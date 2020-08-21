package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dao.AuthProductDao;
import dto.OrderDto;
import dto.ProductDto;

@WebServlet("/authProduct")
public class authProductController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		AuthProductDao dao = AuthProductDao.getInstance();
		String work = req.getParameter("work");
		
		// 페이징 & 검색 + 제품관리 게시판 리스트
		if(work.equals("list")) {
			//검색값
			String choice = req.getParameter("choice");
			String searchWord = req.getParameter("searchWord");
			
			if(choice == null || choice.equals("")){
				choice = "sel";
			}
			// 검색어를 지정하지 않고 Choice가 넘어 왔을 때
			if(choice.equals("sel")){
				searchWord = "";
			}
			if(searchWord == null){
				searchWord = "";
				choice = "sel";
			}
			System.out.println(choice + searchWord);
			
			//페이징
			String spageNumber = req.getParameter("pageNumber");
			int pageNumber = 0; //현재 페이지
			if( spageNumber != null && !spageNumber.equals("")){
				pageNumber = Integer.parseInt(spageNumber);
			}
			
			List<ProductDto> list = dao.getProductPagingList(choice, searchWord, pageNumber);
			int len = dao.getProductListSize(choice, searchWord);
			
			System.out.println("size~" + list.size());
			System.out.println(len);

			int bbsPage = len / 15;	 
			if(len % 15 > 0){
				bbsPage = bbsPage + 1;
			} 
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			map.put("bbsPage", bbsPage);
			map.put("pageNumber", pageNumber);
			map.put("choice", choice);
			map.put("searchWord", searchWord);
			
			req.setAttribute("map", map);
			forward("authProduct/authproductlist.jsp", req, resp);
		}
		
		// 제품관리 게시판 디테일
		else if(work.equals("detail")) {
			int prd_num = Integer.parseInt(req.getParameter("prd_num"));
			ProductDto dto = dao.getProduct(prd_num);
			
			req.setAttribute("dto", dto);
			forward("authProduct/authproductupdate.jsp", req, resp);
		}
		
		// 제품 등록 이동
		else if(work.equals("addview")) {
			forward("authProduct/authproductadd.jsp", req, resp);
		}
		
		// 제품 삭제
		else if(work.equals("delete")) {
			int prd_num = Integer.parseInt(req.getParameter("prd_num"));
			boolean isS = dao.deleteProduct(prd_num);
			System.out.println("dd");
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			
			if(isS) {
			 out.println("<script>alert('삭제되었습니다');"
			 		+ "location.href='authProduct?work=list';</script>"); 
			 }else { 
				 out.println("<script>alert('삭제에 실패했습니다');"
				 		+ "location.href='authProduct/authproductupdate.jsp'" + prd_num + ";</script>"); 
			 }
			out.flush();	
		}
		
		// 제품 차트
		else if(work.equals("chart")) {
			List<ProductDto> list = dao.getAllProduct();
			req.setAttribute("list", list);
			forward("authProduct/authproductchart.jsp", req, resp);
			
		}
		else if(work.equals("order")) {
			//검색값
			String choice = req.getParameter("choice");
			String searchWord = req.getParameter("searchWord");
			
			if(choice == null || choice.equals("")){
				choice = "sel";
			}
			// 검색어를 지정하지 않고 Choice가 넘어 왔을 때
			if(choice.equals("sel")){
				searchWord = "";
			}
			if(searchWord == null){
				searchWord = "";
				choice = "sel";
			}
			System.out.println(choice + searchWord);
			
			//페이징
			String spageNumber = req.getParameter("pageNumber");
			int pageNumber = 0; //현재 페이지
			if( spageNumber != null && !spageNumber.equals("")){
				pageNumber = Integer.parseInt(spageNumber);
			}
			
			List<OrderDto> list = dao.getAllOrder(choice, searchWord, pageNumber);
			int len = dao.getOrderListSize(choice, searchWord);
			
			System.out.println("size~" + list.size());
			System.out.println(len);

			int bbsPage = len / 15;	 
			if(len % 15 > 0){
				bbsPage = bbsPage + 1;
			} 
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			map.put("bbsPage", bbsPage);
			map.put("pageNumber", pageNumber);
			map.put("choice", choice);
			map.put("searchWord", searchWord);
			
			req.setAttribute("map", map);
			forward("authProduct/authorderlist.jsp", req, resp);
		}
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		AuthProductDao dao = AuthProductDao.getInstance();
		String work = req.getParameter("work");
		
		// 제품 등록 
		if(work.equals("add")) {
			
			String fupload = req.getServletContext().getRealPath("/upload");
			System.out.println("업로드 폴더" + fupload);
			
			String yourTempDir = fupload;

			int yourMaxRequestSize = 100 * 1024 * 1024;		// 1 Mbyte
			int yourMaxMemorySize = 100 * 1024;				// 1 Kbyte
			
			// form field의 데이터를 저장할 변수
			int price=0, amount=0, sell=0, category=0;
			String name="", info="", size="", origin="", expdate="";
			String keep="", pack="";
			
			//file
			String filename = "";
			
			boolean isMultipart = ServletFileUpload.isMultipartContent(req);
			if(isMultipart == true){
				
				try {
					// Fileitem 생성
					DiskFileItemFactory factory = new DiskFileItemFactory();
					factory.setSizeThreshold(yourMaxMemorySize);
					factory.setRepository(new File(yourTempDir));
	
					ServletFileUpload upload = new ServletFileUpload(factory);
					upload.setSizeMax(yourMaxRequestSize);
					
					List<FileItem> items = upload.parseRequest(req);
					Iterator<FileItem> it = items.iterator();
					
					//구분
					while(it.hasNext()){
						System.out.println("while it.");
						FileItem item = it.next();
						if(item.isFormField()){
							if(item.getFieldName().equals("name")){
								name = item.getString("utf-8");
							}else if(item.getFieldName().equals("price")){
								price = Integer.parseInt(item.getString("utf-8"));
							}else if(item.getFieldName().equals("info")) {
								info = item.getString("utf-8");
							}else if(item.getFieldName().equals("size")) {
								size = item.getString("utf-8");
							}else if(item.getFieldName().equals("origin")) {
								origin = item.getString("utf-8");
							}else if(item.getFieldName().equals("expdate")) {
								expdate = item.getString("utf-8");
							}else if(item.getFieldName().equals("keep")) {
								keep = item.getString("utf-8");
							}else if(item.getFieldName().equals("pack")) {
								pack = item.getString("utf-8");
							}else if(item.getFieldName().equals("amount")){
								amount = Integer.parseInt(item.getString("utf-8"));
							}else if(item.getFieldName().equals("sell")){
								sell = Integer.parseInt(item.getString("utf-8"));
							}else if(item.getFieldName().equals("category")){
								category = Integer.parseInt(item.getString("utf-8"));
							}
							
						}else{ // 파일 일 떄
							if(item.getFieldName().equals("fileload")){
								filename = processUploadFile(item, fupload);
							}
						}
					}
				} catch (FileUploadException e) {
					e.printStackTrace();
				} 
			}
			
			// DB에 저장
			System.out.println("파일 네임:" + filename);
			
			//prd_num 설정
			int prd_num = category + dao.getPrd_num(category) + 1;
			
			// 제품 등록
			ProductDto dto = new ProductDto(prd_num, name, price, filename, info, 0, size, origin, expdate, keep, pack, amount, sell, 0);
			System.out.println(dto.toString());
			Boolean isS = dao.addProduct(dto);
			
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			
			if(isS) {
			 out.println("<script>alert('등록되었습니다'); "
			 		+ "location.href='authProduct?work=list';</script>"); 
			 }else { 
				 out.println("<script>alert('등록에 실패했습니다'); "
				 		+ "location.href='authProduct/authproductadd.jsp';</script>"); }
			 
			out.flush();
			
		}
		
		// 제품관리 게시판 정보 수정
		else if(work.equals("update")) {
			
			int prd_num = Integer.parseInt(req.getParameter("prd_num"));
			//ProductDto prddto = dao.getProduct(prd_num);
			
			String name = req.getParameter("name");
			int amount = Integer.parseInt(req.getParameter("amount"));
			int sell = Integer.parseInt(req.getParameter("sell"));
			int price = Integer.parseInt(req.getParameter("price"));
			String size = req.getParameter("size");
			String origin = req.getParameter("origin");
			String keep = req.getParameter("keep");
			String pack = req.getParameter("pack");
			String expdate = req.getParameter("expdate");
			String info = req.getParameter("info");
			
			ProductDto dto = new ProductDto(prd_num, name, price, "", info, 2500, size, origin, expdate, keep, pack, amount, sell, 0);
			System.out.println(dto.toString());
			boolean isS = dao.updateProduct(dto);
			
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			
			if(isS) {
			 out.println("<script>alert('수정되었습니다'); "
			 		+ "location.href='authProduct?work=list';</script>"); 
			 }else { 
				 out.println("<script>alert('수정에 실패했습니다'); "
				 		+ "location.href='authProduct?work=detail&prd_num=" + prd_num + "';</script>"); }
			 
			out.flush();
		}
		
		
	}
	
	//forward 함수
	public void forward(String linkname, HttpServletRequest req, HttpServletResponse resp) {
		RequestDispatcher dispatcher = req.getRequestDispatcher(linkname);
		try {
			dispatcher.forward(req, resp);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// upload 함수
	public String processUploadFile(FileItem fileItem, String dir)throws IOException{
											//abc.txt 파일명을 얻기 위함
			String filename = fileItem.getName();	// 경로 + 파일명
			long sizeInBytes = fileItem.getSize();	// 파일 크기
			
			// 파일이 정상
			if(sizeInBytes > 0){	//   d:\\tmp\\abc.txt
				
				int idx = filename.lastIndexOf("\\");
				if(idx == -1){ //   d:/tmp/abc.txt
					idx = filename.lastIndexOf("/");
				}
				
				filename = filename.substring(idx + 1); // //다음부터 끝까지 abc.txt
				File uploadFile = new File(dir, filename);
				
				try{
					fileItem.write(uploadFile);	// 실제 upload 부분
				}catch(Exception e){
				}
			}
			return filename;	// DB에 저장하기 위한 return
		}
			
}

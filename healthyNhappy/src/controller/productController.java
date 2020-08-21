package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.ProductDao;
import dto.CartDto;
import dto.MemberDto;
import dto.OrderDto;
import dto.ProductDto;
import dto.ReviewBbsDto;
import net.sf.json.JSONObject;

@WebServlet("/product")
public class productController extends HttpServlet {

	
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String work = req.getParameter("work");
		ProductDao dao = ProductDao.getInstance();
		
		
		if(work.equals("list")) {
			String category = req.getParameter("category");
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			//전체 카테고리
			if(category.equals("all")) {
				List<ProductDto> list = dao.getAllProduct();	
				map.put("list", list);
				
			}else if(category.equals("fruit")) {
				//과일 카테고리
				List<ProductDto> list = dao.getAllProduct();
				List<ProductDto> listFruit = new ArrayList<ProductDto>();
				for (int i = 0; i < list.size(); i++) {
					if(list.get(i).getPrd_num() < 200) {
						listFruit.add(list.get(i));
					}
				}
				map.put("list", listFruit);
				
			}else if(category.equals("fruit01")) {
				//생과일
				List<ProductDto> list = dao.getAllProduct();
				List<ProductDto> listFruit = new ArrayList<ProductDto>();
				for (int i = 0; i < list.size(); i++) {
					if(list.get(i).getPrd_num() < 120) {
						listFruit.add(list.get(i));
					}
				}
				map.put("list", listFruit);
			}
			else if(category.equals("fruit02")) {
				//냉동과일
				List<ProductDto> list = dao.getAllProduct();
				List<ProductDto> listFruit = new ArrayList<ProductDto>();
				for (int i = 0; i < list.size(); i++) {
					if(list.get(i).getPrd_num() >= 120 && list.get(i).getPrd_num() < 130) {
						listFruit.add(list.get(i));
					}
				}
				map.put("list", listFruit);
			}

			else if(category.equals("vegi")) {
				//채소 카테고리
				List<ProductDto> list = dao.getAllProduct();
				List<ProductDto> listVegi = new ArrayList<ProductDto>();
				for (int i = 0; i < list.size(); i++) {
					if(list.get(i).getPrd_num() > 200) {
						listVegi.add(list.get(i));
					}
				}
				map.put("list", listVegi);
			}
			
			else if(category.equals("vegi01")) {
				//잎채소
				List<ProductDto> list = dao.getAllProduct();
				List<ProductDto> listVegi = new ArrayList<ProductDto>();
				for (int i = 0; i < list.size(); i++) {
					if(list.get(i).getPrd_num() >= 210 && list.get(i).getPrd_num() < 220) {
						listVegi.add(list.get(i));
					}
				}
				map.put("list", listVegi);
			}
			else if(category.equals("vegi02")) {
				//뿌리채소
				List<ProductDto> list = dao.getAllProduct();
				List<ProductDto> listVegi = new ArrayList<ProductDto>();
				for (int i = 0; i < list.size(); i++) {
					if(list.get(i).getPrd_num() >= 220 && list.get(i).getPrd_num() < 230) {
						listVegi.add(list.get(i));
					}
				}
				map.put("list", listVegi);
			}
			
			else if(category.equals("vegi03")) {
				//열매채소
				List<ProductDto> list = dao.getAllProduct();
				List<ProductDto> listVegi = new ArrayList<ProductDto>();
				for (int i = 0; i < list.size(); i++) {
					if(list.get(i).getPrd_num() >= 230 && list.get(i).getPrd_num() < 240) {
						listVegi.add(list.get(i));
					}
				}
				map.put("list", listVegi);
			}
					
			map.put("category", category);
			
			req.setAttribute("map", map);
			forward("productList.jsp", req, resp);
			
		}else if(work.equals("detail")) {
			//상품번호로 상품정보 가져오기
			int prd_num = Integer.parseInt(req.getParameter("prd_num") );
			ProductDto dto = dao.getProduct(prd_num);
			
			req.setAttribute("dto", dto);
			forward("productDetail.jsp", req, resp);
			
		}
		//리뷰 수정
		else if(work.equals("reviewUpdate")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			ReviewBbsDto dto = dao.getReview(seq);
			
			req.setAttribute("dto", dto);
			System.out.println(dto.toString());
			forward("review/reviewUpdate.jsp", req, resp);
		}
		
		//장바구니
		else if (work.equals("mycart")) {
			dao = ProductDao.getInstance();
			
			HttpSession session = req.getSession(false);
			MemberDto mem = (MemberDto)session.getAttribute("login");
			String id = mem.getId();
			
			List<CartDto> cartList = dao.getCartList(id);
			List<ProductDto> goodCartList = dao.getGoodCartList(id);
			System.out.println(id);
			System.out.println("얍1");
			
			req.setAttribute("cart", cartList);
			req.setAttribute("cartProduct",goodCartList);
			
			forward("mycart.jsp", req, resp);
			
		}else if (work.equals("mypage")) {
			
			HttpSession session = req.getSession(false);
			MemberDto mem = (MemberDto)session.getAttribute("login");
			String id = mem.getId();
			
			dao = ProductDao.getInstance();	
			List<OrderDto> orderList = dao.getPageOrderList(id);
			//추가
			//del값 확인
			List<ProductDto> revProductList = dao.myPageReview1(id);
			List<ReviewBbsDto> reviewList = dao.myPageReview2(id);
			
			req.setAttribute("order", orderList);
			req.setAttribute("review", reviewList);
			req.setAttribute("reviewProduct", revProductList);
			forward("mypage.jsp", req, resp);
			
		}else if (work.equals("myPageOrderDetail")) {
			HttpSession session = req.getSession(false);
			MemberDto mem = (MemberDto)session.getAttribute("login");
			String id = mem.getId();
			
			dao = ProductDao.getInstance();
			String seq = req.getParameter("seq");
			
			List<CartDto> cartList = dao.getPageCartList(id, seq);
			List<ProductDto> productList = dao.getPageProductList(id, seq);
			
			req.setAttribute("cart", cartList);			
			req.setAttribute("product", productList);
			
			forward("mypageProduct.jsp", req, resp);
		
		}else if(work.equals("updateOne")) {
			//---------------------------------------
			dao = ProductDao.getInstance();
			
			String id = req.getParameter("ids");
			
			String fixNum = req.getParameter("fixNum");
			String fixAmount = req.getParameter("fixAmount");
			String fixTotal = req.getParameter("fixTotal");
			
			dao.updateCartList(fixAmount, fixTotal, id, fixNum);

			resp.sendRedirect("product?work=mycart&id="+id);
		
		}
		//제품보는 곳에서 바로 사는 부분이고요 그렇고요
	
		
		else if(work.equals("buyNow")) {
			
			HttpSession session = req.getSession(false);
			MemberDto mem = (MemberDto)session.getAttribute("login");
			String id = mem.getId();
			int prdNum = Integer.parseInt(req.getParameter("prdnum"));
			int amount = Integer.parseInt(req.getParameter("amount"));
			int sum = Integer.parseInt(req.getParameter("sum"));
			
			
			CartDto cdto = new CartDto(id, prdNum, amount, sum, 1);
			//프로덕트 하나 가져오는 거 넘어오기
			ProductDto pdto = dao.getProduct(prdNum);
			
			req.setAttribute("cdto", cdto);	
			req.setAttribute("pdtoOne", pdto);	
			
			forward("myreceipt.jsp", req, resp);
			
			
		}
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String work = req.getParameter("work");
		ProductDao dao = ProductDao.getInstance();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		//한글깨짐
		req.setCharacterEncoding("UTF-8");
	    resp.setContentType("text/html; charset=UTF-8");
	    
		// 후기 게시판 ajax
		if(work.equals("review")) {
			
			int prd_num = Integer.parseInt(req.getParameter("prd_num") );
			String spageNumber = req.getParameter("pageNumber");
			int pageNumber = 0; //현재 페이지
			if( spageNumber != null && !spageNumber.equals("")){
				pageNumber = Integer.parseInt(spageNumber);
			}
			
			List<ReviewBbsDto> list = dao.getRevPagingList(pageNumber, prd_num);
			int len = dao.getRevPagingListSize(prd_num);
			System.out.println(len);
			
			int bbsPage = len / 5;	 
			if(len % 5 > 0){
				bbsPage = bbsPage + 1;
			}
			
			//List<ReviewBbsDto> list = dao.getAllReview(prd_num);
			map.put("list", list);
			map.put("bbsPage", bbsPage);
			map.put("pageNumber", pageNumber);
			
			JSONObject jobj = new JSONObject();
			jobj.put("map", map);
			
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(jobj);
		}
	
		//리뷰 등록
		else if(work.equals("reviewWrite")) {
			int prd_num = Integer.parseInt(req.getParameter("prd_num") );
			HttpSession session = req.getSession(false);
			MemberDto mem = (MemberDto)session.getAttribute("login");
			
			/*
			fileSizeThreshold	서버로 파일을 저장할 때 파일의 임시 저장 사이즈
			maxFileSize			1개 파일에 대한 최대 사이즈
			maxRequestSize		서버로 전송되는 request의 최대 사이즈
			*/
			
			// 업로드
			// tomcat 배포(server에)
			String fupload = req.getServletContext().getRealPath("/upload");
			System.out.println("업로드 폴더" + fupload);

			String yourTempDir = fupload;

			int yourMaxRequestSize = 100 * 1024 * 1024;		// 1 Mbyte
			int yourMaxMemorySize = 100 * 1024;				// 1 Kbyte
			
			// form field의 데이터를 저장할 변수
			String title = "";
			String content = "";
			int score = 0;

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
						
						FileItem item = it.next();
						if(item.isFormField()){ // id, title, content
							if(item.getFieldName().equals("title")){
								title = item.getString("utf-8");
							}else if(item.getFieldName().equals("content")){
								content = item.getString("utf-8");
							}else if(item.getFieldName().equals("score")) {
								score = Integer.parseInt(item.getString("utf-8"));
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
			ReviewBbsDto dto = new ReviewBbsDto(mem.getId(), title, content, score, filename, prd_num);
			boolean b = dao.writeReview(dto);
			
			resp.setContentType("text/html; charset=UTF-8");
			 
			PrintWriter out = resp.getWriter();
			if(b) {
				out.println("<script>alert('등록되었습니다'); opener.document.location.reload();" + 
						"self.close();</script>");
			}else {
				out.println("<script>alert('등록에 실패했습니다'); location.href='./review/reviewWrite.jsp?prd_num=" + prd_num +"';</script>");
			}
			out.flush();
		}
		// 리뷰 수정 Af
		else if(work.equals("updateAf")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			ReviewBbsDto revdto = dao.getReview(seq);
			String filename = revdto.getFilename();
				System.out.println("수정 파일넴:" + filename);
			String id = revdto.getId();
			int prd_num = revdto.getPrd_num();
			
			String fupload = req.getServletContext().getRealPath("/upload");
			System.out.println("업로드 폴더" + fupload);

			String yourTempDir = fupload;

			int yourMaxRequestSize = 100 * 1024 * 1024;		// 1 Mbyte
			int yourMaxMemorySize = 100 * 1024;				// 1 Kbyte
			
			// form field의 데이터를 저장할 변수
			
			String title = "";
			String content = "";
			int score = 0;

			//file
			String update_File = "";
			
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
					
					FileItem item = it.next();
					if(item.isFormField()){ // id, title, content
						if(item.getFieldName().equals("title")){
							title = item.getString("utf-8");
						}else if(item.getFieldName().equals("content")){
							content = item.getString("utf-8");
						}else if(item.getFieldName().equals("score")) {
							score = Integer.parseInt(item.getString("utf-8"));
						}
						
					}else{ // 파일 일 떄
						if(item.getFieldName().equals("update_file")){
							
							if( !item.getString("utf-8").equals("") ) {
								System.out.println("걸림");
								filename = processUploadFile(item, fupload);
							}
						}
					}
				}
			} catch (FileUploadException e) {
				e.printStackTrace();
			}
		 } 

		System.out.println("최종파일넴" + filename);	
		//DB 저장
		ReviewBbsDto dto = new ReviewBbsDto(id, title, content, score, filename, prd_num);
		boolean b = dao.updateReview(dto, seq);
		
		resp.setContentType("text/html; charset=UTF-8"); 
		PrintWriter out = resp.getWriter();
		if(b) {
			out.println("<script>alert('수정되었습니다'); opener.document.location.reload(); self.close();</script>");
		}else {
			out.println("<script>alert('수정에 실패했습니다'); location.href='./review/reviewUpdate.jsp?seq=" + seq +"';</script>");
		}
		out.flush();
		}
	
		//후기 삭제
		else if(work.equals("reviewDelete")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			boolean b = dao.deleteReview(seq);
			
			resp.setContentType("text/html; charset=UTF-8"); 
			
			/*
			 * PrintWriter out = resp.getWriter(); if(b) {
			 * out.println("<script>alert('삭제되었습니다');</script>"); }else {
			 * out.println("<script>alert('삭제에 실패했습니다');</script>"); } out.flush();
			 */
			
			//ajax
			ReviewBbsDto dto = dao.getReview(seq);
			int prd_num = dto.getPrd_num();
			String spageNumber = req.getParameter("pageNumber");
			int pageNumber = 0; //현재 페이지
			if( spageNumber != null && !spageNumber.equals("")){
				pageNumber = Integer.parseInt(spageNumber);
			}
			
			List<ReviewBbsDto> list = dao.getRevPagingList(pageNumber, prd_num);
			int len = dao.getRevPagingListSize(prd_num);
			System.out.println(len);
			
			int bbsPage = len / 5;	 
			if(len % 5 > 0){
				bbsPage = bbsPage + 1;
			}
			
			//List<ReviewBbsDto> list = dao.getAllReview(prd_num);
			map.put("list", list);
			map.put("bbsPage", bbsPage);
			map.put("pageNumber", pageNumber);
			map.put("b", b);
			
			JSONObject jobj = new JSONObject();
			jobj.put("map", map);
			
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(jobj);
		}
		
		// 장바구니 
		
	    
		//삭제기능---------------------------------------------------------------------------------------------------------------------
	    else if(work.equals("delAll")) {
			
			dao = ProductDao.getInstance();
			String ids[] = req.getParameterValues("ids");
			String funCk[] = req.getParameterValues("funCk");
			
			for (int i = 0; i < funCk.length; i++) {
				System.out.println("얍" + ids[i]);
				System.out.println("얍" + funCk[i]);
			}
			
			boolean isS = true;
			if(funCk != null) {
				isS = dao.deleteCartGoods(ids, funCk);
				
				resp.sendRedirect("product?work=mycart&id=" + ids[0]);
			}
			
		//---------------------------------------------------------------------------------------------------------------------
		
		}else if(work.equals("ordAll")) {
		
			dao = ProductDao.getInstance();
			String ids[] = req.getParameterValues("ids");
			String funCk[] = req.getParameterValues("funCk");
			
			List<CartDto> receiptList = new ArrayList<CartDto>();
			List<ProductDto> receiptProductList = new ArrayList<ProductDto>();
			
			for (int i = 0; i < funCk.length; i++) {
				receiptList.add(i, dao.getReceipt(ids[i], funCk[i]));
				receiptProductList.add(i, dao.getReceiptProduct(ids[i], funCk[i]));
			}
			
			req.setAttribute("receipt", receiptList);
			req.setAttribute("receiptProduct", receiptProductList);
			
			forward("myreceipt.jsp", req, resp);
			
		//---------------------------------------------------------------------------------------------------------------------
		
		}else if(work.equals("payOrder")) {
			
			dao = ProductDao.getInstance();
			
			String idindi = req.getParameter("idindi");
			/*
			String param = req.getParameter("name"); 
			param = new String(param.getBytes("ISO-8859-1"), "UTF-8"); 
		    */
			String orderRequest = "";
			orderRequest = req.getParameter("orderRequest"); 
			//orderRequest = new String(orderRequest.getBytes("ISO-8859-1"), "UTF-8");
			
			String orderAddress = req.getParameter("orderAddress"); 
			orderAddress = new String(orderAddress.getBytes("ISO-8859-1"), "UTF-8");
			
			String orderMoney = req.getParameter("orderMoney");
			
			String ids[] = req.getParameterValues("ids");
			String productNum[] = req.getParameterValues("productNum");
			
			if(orderRequest.equals("")) {
				orderRequest += "요청없음";
			}else {
				orderRequest = new String(orderRequest.getBytes("ISO-8859-1"), "UTF-8");
			}
			
			dao.payList1(idindi, orderRequest, orderAddress, orderMoney);
			
			for (int i = 0; i < productNum.length; i++) {
				System.out.println(ids[i]);
				System.out.println(productNum[i]);
				dao.payList2(ids[i], productNum[i]);
			}
			
			resp.sendRedirect("product?work=mypage&id=" + idindi);
		}
	
	//장바구니 추가
		else if(work.equals("addCart")) {
			HttpSession session = req.getSession(false);
			MemberDto mem = (MemberDto)session.getAttribute("login");
			
			String id = mem.getId();
			int prd_num = Integer.parseInt(req.getParameter("prd_num"));
			int amount = Integer.parseInt(req.getParameter("amount"));
			int price = Integer.parseInt(req.getParameter("sum"));
			
			CartDto dto = new CartDto(id, prd_num, amount, price, 1);
			boolean isS = dao.addCart(dto);
			
			resp.setContentType("text/html; charset=UTF-8"); 
			PrintWriter out = resp.getWriter();
			if(isS) {
				out.println("<script>alert('장바구니에 추가되었습니다'); location.href='product?work=detail&prd_num=" + prd_num + "';</script>");
															//location.href='./review/reviewWrite.jsp?prd_num=" + prd_num +"';</script>");
			}else {
				out.println("<script>alert('추가에 실패했습니다'); location.href='product?work=detail&prd_num='" + prd_num + ";</script>");
			}
			out.flush();
			}
		else if(work.equals("payImmediately")) {
			HttpSession session = req.getSession(false);
			MemberDto mem = (MemberDto)session.getAttribute("login");
			String id = mem.getId();
			
			String prdNum = req.getParameter("payNowPrdNum");
			String amount = req.getParameter("payNowAmount");
			String price = req.getParameter("payNowPrice");
			
			String address = req.getParameter("payNowAddress");
			address = new String(address.getBytes("ISO-8859-1"), "UTF-8"); 
			
			String request = "";
			request = req.getParameter("payNowRequest");
			
			if(request.equals("")) {
				request += "요청없음";
			}else {
				request = new String(request.getBytes("ISO-8859-1"), "UTF-8");
			}
			
			System.out.println(prdNum);
			System.out.println(amount);
			System.out.println(price);
			System.out.println(address);
			System.out.println(request);
			
			int inprdnum = Integer.parseInt(prdNum);
			int inamount = Integer.parseInt(amount);
			int inprice = Integer.parseInt(price);
			
			CartDto dto = new CartDto(id, inprdnum, inamount, inprice, 1);

			dao.addCart(dto);
			dao.payList1(id, request, address, price);
			dao.payList2(id, prdNum);
			
			resp.sendRedirect("product?work=mypage&id=" + id);				
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

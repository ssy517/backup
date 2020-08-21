package controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
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



import dao.BbsDao;
import dao.WbBbsDao;
import dto.MemberDto;
import dto.QnaAnsDto;
import dto.QnaBbsDto;
import dto.WbBbsDto;
import net.sf.json.JSONObject;

@WebServlet("/bbs")
public class bbsController extends HttpServlet {

	ServletConfig mConfig = null;
	final int BUFFER_SIZE = 8192;
	
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
		mConfig = config;
	}
	
	
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		
		String work = req.getParameter("work");
		
		
		// 질문글 삭제
		if(work.equals("QABbsDelete")) {
			
			int seq = Integer.parseInt(req.getParameter("seq")); 
			boolean isS = false;
			
			BbsDao bdao = BbsDao.getInstance();
			isS = bdao.deleteQABbs(seq);
			
			resp.sendRedirect("main?work=QAlistView");
		}
		else if(work.equals("wellbing")) {
			WbBbsDao dao = WbBbsDao.getInstance();

			List<WbBbsDto> WbDto = dao.getWbBbsList();
			System.out.println("얍");
			req.setAttribute("WbList", WbDto);
			forward("wellbing.jsp", req, resp);
		}
		
		
	
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		
		String work = req.getParameter("work");
		System.out.println(work);
		
		// QnA 질문글 쓰기
		if(work.equals("QAwriteBbs")) {
			// tomcat 배포(server)
			String fupload = req.getServletContext().getRealPath("/QAupload");

			// 지정 폴더(client)
			// String fupload = "d:\\tmp";

			System.out.println("업로드 폴더:" + fupload);

			String yourTempDir = fupload;

			int yourMaxRequestSize = 100 * 1024 * 1024;		// 1 Mbyte
			int yourMaxMemorySize = 100 * 1024;				// 1 Kbyte 

			// form field의 데이터를 저장할 변수
			String id = "";
			String title = "";
			String content = "";
			String sopen = "";
			// file
			String filename = "";

			boolean isMultipart = ServletFileUpload.isMultipartContent(req);
			if(isMultipart == true){
				try {	
					// Fileitem생성
					DiskFileItemFactory factory = new DiskFileItemFactory();
					
					factory.setSizeThreshold(yourMaxMemorySize);
					factory.setRepository(new File(yourTempDir));
					
					ServletFileUpload upload = new ServletFileUpload(factory);
					upload.setSizeMax(yourMaxRequestSize);
					
					
					
					List<FileItem>	items = upload.parseRequest(req);
					Iterator<FileItem> it = items.iterator();
					
					
					
					// 구분
					while(it.hasNext()){
						FileItem item = it.next();
						
						if(item.isFormField()){	// id, title, content
							if(item.getFieldName().equals("id")){
								id = item.getString("utf-8");
							}else if(item.getFieldName().equals("title")){
								title = item.getString("utf-8");
							}else if(item.getFieldName().equals("content")){
								content = item.getString("utf-8");
							}else if(item.getFieldName().equals("open")){
								sopen = item.getString("utf-8");
							}
						}
						else{	// fileload
							if(item.getFieldName().equals("fileload")){
								
								// 파일이름이 있을 때
								if(item.getName() != null && !item.getName().equals("")) {
									
									filename = processUploadFile(item, fupload);
								}
							}
						}
					}	
				} catch (FileUploadException e) {
					
					e.printStackTrace();
				}
				
				// 공개/비공개 숫자형 데이터로 변환
				int open = Integer.parseInt(sopen);
			
				BbsDao dao = BbsDao.getInstance();
				dao.writeQABbs(id, title, content, filename, open);
						
				resp.sendRedirect("main?work=QAlistView");
			
			}
		}
		// QnA 답변 쓰기
		else if(work.equals("QAwriteAns")) {
			
			int seq = Integer.parseInt(req.getParameter("seq"));
			String id = req.getParameter("id");
			String content = req.getParameter("content");
			boolean isS = false;
			
			
			BbsDao dao = BbsDao.getInstance();
			isS = dao.writeQAAns(seq, id, content);
			
			System.out.println(isS);
			
			resp.sendRedirect("main?work=QAlistView");
			
		}
		
		// QnA 질문글 수정
		else if(work.equals("QABbsUpdate")) {
			
			
			// tomcat 배포(server)
			String fupload = req.getServletContext().getRealPath("/QAupload");

			// 지정 폴더(client)
			// String fupload = "d:\\tmp";

			System.out.println("업로드 폴더:" + fupload);

			String yourTempDir = fupload;

			int yourMaxRequestSize = 100 * 1024 * 1024;		// 1 Mbyte
			int yourMaxMemorySize = 100 * 1024;				// 1 Kbyte 

			// form field의 데이터를 저장할 변수
			String sseq = "";
			String sopen = "";
			String title = "";
			String content = "";
			String oldfile = "";
			
			// file
			String filename = "";

			boolean isMultipart = ServletFileUpload.isMultipartContent(req);
			
			if(isMultipart == true){
				try {	
					// Fileitem생성
					DiskFileItemFactory factory = new DiskFileItemFactory();
					
					factory.setSizeThreshold(yourMaxMemorySize);
					factory.setRepository(new File(yourTempDir));
					
					ServletFileUpload upload = new ServletFileUpload(factory);
					upload.setSizeMax(yourMaxRequestSize);
					
					
					
					List<FileItem>	items = upload.parseRequest(req);
					Iterator<FileItem> it = items.iterator();
					
					
					
					// 구분
					while(it.hasNext()){
						FileItem item = it.next();
						
						if(item.isFormField()){	// id, title, content
							if(item.getFieldName().equals("seq")){
								sseq = item.getString("utf-8");
							}else if(item.getFieldName().equals("open")){
								sopen = item.getString("utf-8");
							}else if(item.getFieldName().equals("title")){
								title = item.getString("utf-8");
							}else if(item.getFieldName().equals("content")){
								content = item.getString("utf-8");
							}else if(item.getFieldName().equals("oldfile")){
								oldfile = item.getString("utf-8");
							}
						}
						else{	// fileload
							if(item.getFieldName().equals("fileload")){
								
								// 파일이름이 있을 때
								if(item.getName() != null && !item.getName().equals("")) {
									
									filename = processUploadFile(item, fupload);
								}
							}
						}
						if(filename == null || filename.equals("")) {
							
							filename = oldfile;
						}
					}	
				} catch (FileUploadException e) {
					
					e.printStackTrace();
				}
				
				
				// 시퀀스 번호 데이터 변환
				int seq = Integer.parseInt(sseq);
				
				// 공개/비공개 숫자형 데이터로 변환
				int open = Integer.parseInt(sopen);
				
				//System.out.println(seq + " " + open + " " + filename);
				
				BbsDao bdao = BbsDao.getInstance();
				bdao.updateQABbs(seq, open, title, content, filename);
				
				resp.sendRedirect("main?work=QAlistView");
				
			}
		}
		
		// QnA 답변 수정
		else if(work.equals("QAAnsUpdate")) {
			
	
			int seq = Integer.parseInt(req.getParameter("seq"));
			String content = req.getParameter("content2");
			boolean isS = false;
			
			BbsDao bdao = BbsDao.getInstance();
			isS =bdao.updateQAAns(seq, content);
			
			resp.sendRedirect("main?work=QAlistView");		
		}
		
		
		// QnA 파일 다운로드
		else if(work.equals("QAfileDown")) {
			
			String filename = req.getParameter("filename");
			
			
			// down load 횟수를 증가(DB)
			
			BufferedOutputStream out = new BufferedOutputStream(resp.getOutputStream());
			
			String filepath ="";
			
			//tomcat(server), 부팅을 계속하면 사라질수가 있음
			filepath = mConfig.getServletContext().getRealPath("/QAupload");
			
			//폴더(client)
			//filepath = "d:\\tmp";
			
			
			filepath = filepath + "\\" +filename;
			System.out.println("filepath : " + filepath);
			
			File f = new File(filepath);
			
			// 파일이 존재하거나 읽을 수 있으면
			if(f.exists() && f.canRead()) {
				
				// download window set
				
				
				resp.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");
				// 파일명 확인
				resp.setHeader("Content-Transfer-Encoding", "binary;");
				// 인코딩 방식 바이너리
				resp.setHeader("Content-Length", "" + f.length());
				// 막대 길이
				resp.setHeader("Pragma", "no-cache;"); 
				// 임시 공간 : 저장안함
				resp.setHeader("Expires", "-1;");
				// 기한 : 무제한
				
				// 파일 생성, 데이터 저장
				
				BufferedInputStream fileInput = new BufferedInputStream(new FileInputStream(f));
				
				byte buffer[] = new byte[BUFFER_SIZE];
				
				int read = 0;
				
				while((read = fileInput.read(buffer)) != -1) {
					out.write(buffer, 0, read); // 실제 다운로드
				}
				
				// 반드시 닫아야한다
				fileInput.close();
				out.flush();
			}			
		}
		else if(work.equals("delcheck")) {
			
			String[] delCheck = req.getParameterValues("delcheck");
			int[] seqs = new int[delCheck.length];
			
			for (int i = 0; i < delCheck.length; i++) {
				
				seqs[i] = Integer.parseInt(delCheck[i]);
				
			}
			
			BbsDao bdao = BbsDao.getInstance();
			bdao.deleteMultiQABbs(seqs);
			
			resp.sendRedirect("main?work=QAlistView");
		}
		
		//마이페이지에 qna
		else if(work.equals("myPageReviewQna")) {
			
			HttpSession session = req.getSession(false);
			MemberDto mem = (MemberDto)session.getAttribute("login");
			String id = mem.getId();
			
			BbsDao dao = BbsDao.getInstance();
			/*
			List<ReviewBbsDto> revList = dao.getReviewMypage(id);
			*/
			List<QnaBbsDto> qnaList = dao.getQnaMypage(id);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			/*
			map.put("revList", revList);
			*/
			map.put("qnaList", qnaList);

			JSONObject jobj = new JSONObject();
			jobj.put("map", map);
			
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(jobj);	
			
		}
	}	
	
	
	
	
	
	public void forward(String link, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		RequestDispatcher dis = req.getRequestDispatcher(link);
		dis.forward(req, resp);
	}
	// QNA 파일 경로 찾기
	public String processUploadFile(FileItem fileItem, String dir)throws IOException{
		//     ..abc.txt		d:\tmp\	
		String filename = fileItem.getName();	// 경로 + 파일명
		long sizeInBytes = fileItem.getSize();
		
		// 파일이 정상
		if(sizeInBytes > 0){	// 	d:\\tmp\\abc.txt	d:/tmp/abc.txt	\" \\
		
		int idx = filename.lastIndexOf("\\");
		if(idx == -1){
		idx = filename.lastIndexOf("/");
		}
		
		filename = filename.substring(idx + 1);	// -> abc.txt
		File uploadFile = new File(dir, filename);
		
		try{
		fileItem.write(uploadFile);		// 실제 upload 부분
		}catch(Exception e){}		
		}
		return filename;	// DB에 저장하기 위한 return
	}
	
	
}

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDao;
import dto.MemberDto;

@WebServlet("/Manager")

public class authManagerController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doAction(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doAction(req, resp);
	}

	protected void doAction(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		
		MemberDto dto = new MemberDto();
		MemberDao dao = MemberDao.getInstance();
		
		PrintWriter out = resp.getWriter();
		
		String action = req.getParameter("action");
		
		String id = null;
		String add1;
		String add2;
		String pwd;
		String name; 
		String add;
		String phone;
		String email;
		
		if(action.equals("authdel")) {
	
				dao = MemberDao.getInstance();

				id = req.getParameter("id");
				
				System.out.println("가져온 id값 확인"+id);
				
				int belete = dao.authdel(id);
				
				if(belete == 1 ) {
					System.out.println("삭제 성공");
					
					out.println("<script>alert('삭제 되었습니다!'); location.href='Manager?action=list';</script>");
					
				}else {
					System.out.println("삭제 실패");
					out.println("<script>alert('삭제에 실패했습니다'); location.href='Manager?action=list';</script>");	
				
				}
					out.flush();
			
		}else if(action.equals("inid")) {
			
			System.out.println("까꿍! 도착했음!");
			
			id = req.getParameter("id");
			
			MemberDto dto1 = dao.userinfo(id);
			
			req.setAttribute("dto1", dto1); // 짐싸!
			forward("authUserupdate.jsp", req, resp);
			
		  }else if(action.equals("userupdate")) {
				
				dao = MemberDao.getInstance();

				add1 = req.getParameter("add1");
				add2 = req.getParameter("add2");
				phone = req.getParameter("num");
				email = req.getParameter("email");
				id = req.getParameter("id");
				
				System.out.println("수정된 정보:"+add1+add2+phone+email);
				
				int isS = dao.authupdate(add1+add2, phone, email, id);
				
				if(isS == 1){
				System.out.println("성공");
				out.println("<script>alert('회원정보가 바뀌었습니다!'); location.href='Manager?action=list';</script>");
				}else{	
				System.out.println("실패");
				out.println("<script>alert('회원정보가 안바뀜ㅋㅋ!'); location.href='Manager?action=list';</script>");
				}	
				out.flush();	
				
		  }else if(action.equals("list")){ 
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
				System.out.println("이거 뭐야 ..? "+ choice + searchWord);
				
				//페이징
				String spageNumber = req.getParameter("pageNumber");
				int pageNumber = 0; //현재 페이지
				if( spageNumber != null && !spageNumber.equals("")){
					pageNumber = Integer.parseInt(spageNumber);
				}
				
				List<MemberDto> list = dao.userList(choice, searchWord, pageNumber);
			
				int len = dao.UserlistSize(choice, searchWord);
				
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
				forward("authUserList.jsp", req, resp);
			}		
		}

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

}

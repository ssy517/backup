package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.Session;

import com.sun.corba.se.spi.orbutil.fsm.Action;
import com.sun.media.sound.InvalidDataException;

import dao.MemberDao;
import dto.MemberDto;

@WebServlet("/member")
public class memberController extends HttpServlet {


	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doAction(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doAction(req,resp);	
		System.out.println("서블릿 연결~_~");
	}
	
	public void forward(String link, HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		RequestDispatcher dis = req.getRequestDispatcher(link);
		dis.forward(req, resp);		
	}
		
	protected void doAction(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		
		String action = req.getParameter("action");
		
		MemberDto dto = new MemberDto();
		MemberDao dao = MemberDao.getInstance();
		List<MemberDto> userlist = dao.getUserDtoList();
		
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		
		HttpSession Ss = null;
		
		String id;
		String pwd;
		String name; 
		String add1;
		String add2;
		String phone;
		String email;
		
		switch(action) {
		
			case "regi":	
				
				id = req.getParameter("id");
				pwd = req.getParameter("pwd1");
				name = req.getParameter("name1");
				add1 = req.getParameter("add1");
				add2 = req.getParameter("add2");
				phone = req.getParameter("num");
				email = req.getParameter("email");
				
				 System.out.println("id:"+id); 
				 System.out.println("pwd:"+pwd);
				 System.out.println("name:"+name);
				 System.out.println("add:"+add1+add2);
				 System.out.println("phone:"+phone);
				 System.out.println("email:"+email);
				
				dto = new MemberDto();
				dao = MemberDao.getInstance();
				
				dao.addMember(new MemberDto(id, pwd, name, add1+add2, phone, email, 2));
			
				 out.println("<script>alert('회원가입 성공! 로그인 하세요.'); location.href='Yhlogin.jsp';</script>"); 
				 out.flush();
				 
			break;
			
			case "idtest" :
				id = req.getParameter("id");
				
				System.out.println("id:"+ id);
				
				dao = MemberDao.getInstance();
				
				boolean b = dao.IDtest(id);
				
				if(b == true){	// id가 없음
					out.println("NO");
				}else{			// id가 없음
					out.println("OK");
				}
				break;
				
			case "login" :	
				
				id = req.getParameter("id");
				pwd = req.getParameter("pwd");
				String idck = req.getParameter("idck");
				
				System.out.println("로그인정보:"+id+","+pwd+","+idck); //로그인 하려는 값 확인
				
				dto = dao.login(id, pwd);
				
			if(idck == null){
				
			  	if(dto != null && !dto.getId().equals("") && dto.getAuth() == 2 ) {
		
				  req.getSession().setAttribute("login", dto);  //dto에서 id를 가져와라~
				  req.getSession().setMaxInactiveInterval(30*60*60);
				 
				  out.println("<script>alert('로그인 되었습니다!'); location.href='main.jsp';</script>");
			    	
			  	}else if(dto != null && !dto.getId().equals("") && dto.getAuth() == 1 ) {
					
					  req.getSession().setAttribute("login", dto);  //dto에서 id를 가져와라~
					  req.getSession().setMaxInactiveInterval(30*60*60);
					 
					  out.println("<script>alert('관리자 모드로 로그인 되었습니다!'); location.href='main.jsp';</script>");
				}else if(dto != null && dto.getAuth() == 3){
				 	
				  	dto = null;
					dto = null;	
					
				out.println("<script>alert('탈퇴한 회원입니다!회원가입후 이용해 주세요.'); location.href='Yhlogin.jsp';</script>");
				
			  	}else{  
					 System.out.println("로그인 실패");  
					 out.println("<script>alert('로그인에 실패했습니다. 아이디 비밀번호를 확인하십시오'); location.href='Yhlogin.jsp';</script>");
			  	}
			  	
			}else {
				
				if(dto != null && !dto.getId().equals("") && dto.getAuth() == 2 ) {
					
					Cookie c = new Cookie("id",id);
					c.setMaxAge(60 * 2);
					c.setPath("/");
					resp.addCookie(c);
					
					  req.getSession().setAttribute("login", dto);  //dto에서 id를 가져와라~
					  req.getSession().setMaxInactiveInterval(30*60*60);
					  
					  out.println("<script>alert('로그인 되었습니다!'); location.href='main.jsp';</script>");
				    	
				  	}else if(dto != null && !dto.getId().equals("") && dto.getAuth() == 1 ) {
						
						  req.getSession().setAttribute("login", dto);  //dto에서 id를 가져와라~
						  req.getSession().setMaxInactiveInterval(30*60*60);
						 
						  out.println("<script>alert('관리자 모드로 로그인 되었습니다!'); location.href='main.jsp';</script>");
					}else if(dto != null && dto.getAuth() == 3){
					 	
					  	dto = null;
						dto = null;	
						
					out.println("<script>alert('탈퇴한 회원입니다!회원가입후 이용해 주세요.'); location.href='Yhlogin.jsp';</script>");
					
				  	}else{  
						 System.out.println("로그인 실패");  
						 out.println("<script>alert('로그인에 실패했습니다. 아이디 비밀번호를 확인하십시오'); location.href='Yhlogin.jsp';</script>");
				  	}
			}
				 out.flush();	
				 
				 break; 
				 
			case "logout2" :	
				
				HttpSession loginSs = req.getSession();
				System.out.println(loginSs);
				loginSs.invalidate();
				
				System.out.println("로그아웃 성공");  
				
				out.println("<script>alert('로그아웃 되셨습니다!'); location.href='main.jsp';</script>");
				out.flush();	
				
				break;
				
			case "update" :	
				
				dao = MemberDao.getInstance();

				pwd = req.getParameter("pwd1");
				add1 = req.getParameter("add1");
				add2 =req.getParameter("add2");
				phone = req.getParameter("num");
				email = req.getParameter("email");
				id = req.getParameter("id");
				
				System.out.println("수정된 정보:"+pwd+add1+add2+phone+email);
				
				int isS = dao.update(pwd, add1+add2, phone, email, id);
				
				if(isS == 1){
				System.out.println("성공");
				out.println("<script>alert('회원정보가 바뀌었습니다!'); location.href='main.jsp';</script>");
				}else{	
				System.out.println("실패");
				out.println("<script>alert('회원정보가 안바뀜ㅋㅋ!'); location.href='Yhupdate.jsp';</script>");
				}	
				out.flush();	
			break;
				
			case "pdel" :
				
				dao = MemberDao.getInstance();

				id = req.getParameter("id");
				
				System.out.println("가져온 id값 확인"+id);
				
				int belete = dao.dalete(id);
				
				if(belete == 1 ) {
					System.out.println("탈퇴 성공");

					Ss = req.getSession();
					Ss.invalidate();
					
					out.println("<script>alert('탈퇴되었습니다!'); location.href='main.jsp';</script>");
					
				}else {
					System.out.println("탈퇴 실패");
					out.println("<script>alert('Q&A 게시판에 문의 해 주세요.'); location.href='main.jsp';</script>");	
				}
					out.flush();
				break;
				
		case "idSearch" :
			
			dao = MemberDao.getInstance();
			
			name = req.getParameter("name");
			email=req.getParameter("email");
	
			System.out.println(name+email);
			
			String idsearch = dao.IDfind(name, email);
			
			id = idsearch;
			
			if(id != null){
				
				System.out.println("찾은 아이디:"+id);
				req.setAttribute("id", id);
				forward("Yhidpwdsearch.jsp", req, resp);
				
				}else{	
				System.out.println("id없음");
				out.println("<script>alert('존재하지 않는 아이디 입니다'); location.href='Yhidpwd.jsp';</script>");
				}	
				out.flush();	
				break;
				
		case "pwdSearch" :		
			
			dao = MemberDao.getInstance();
			
			id =req.getParameter("id");
			name = req.getParameter("name");
			
			System.out.println(id+name);
			
			String pwdSearch = dao.PWDfind(id, name);
			
			pwd = pwdSearch;
			
			if(pwd != null){
				
				System.out.println("찾은 비밀번호:"+pwd);
				req.setAttribute("pwd", pwd);
				forward("Yhidpwdsearch.jsp", req, resp);
				
				}else{	
				System.out.println("id없음");
				out.println("<script>alert('존재하지 않는 아이디 입니다'); location.href='Yhidpwd.jsp';</script>");
				}	
				out.flush();	
				break;
			
			
			
		}		
	}
	
 } 

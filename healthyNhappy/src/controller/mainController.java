package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BbsDao;
import dao.ProductDao;
import dto.ProductDto;
import dto.QnaAnsDto;
import dto.QnaBbsDto;

@WebServlet("/main")
public class mainController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String work = req.getParameter("work");
		
		
		if(work.equals("search")) {
			ProductDao dao = ProductDao.getInstance();
			String searchWord = req.getParameter("searchWord").trim();
			List<ProductDto> list = dao.searchProduct(searchWord);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			map.put("searchWord", searchWord);
			System.out.println("리스트사이즈" + list.size());
			req.setAttribute("map", map);
			forward("searchList.jsp", req, resp);
			
		}
		// QnA 게시판 이동
		else if(work.equals("QAlistView")) {
				
				BbsDao dao = BbsDao.getInstance();
				
				
				
				// 1)검색 시 항목과 키워드 검사
				
				String category = req.getParameter("category");
				String keyword = req.getParameter("keyword");

				// 처음 들어왔을 때
				if(category==null || category.equals("")) {
					
					category = "CHOICE";
				}
				// 목록에서 선택을 선택하고 키워드를 입력했을 때
				if(category.equals("CHOICE")) {
					
					keyword = "";
				}
				// 선택을 제외하고 목록을 선택했지만 키워드를 입력 안했을 때
				if(keyword==null) {
					category = "CHOICE";
					keyword = "";
				}
				// 첫 방문시 검색창 셋팅
				req.setAttribute("category", category);
				req.setAttribute("keyword", keyword);
				
				
				
				// 2) 게시물 갯수 카운트
				int QABbs_len = 0;
				
				QABbs_len = dao.getQABbsAmount(category, keyword);
				int len = QABbs_len/10;
				if(QABbs_len%10 != 0){
					len += 1;
				}
				req.setAttribute("QABbs_len", len);
			
				
				
				// 3) 선택한 페이지의 번호 구하기
				
				String rcvPage = req.getParameter("currPage");
				int currPage = 0;
				
				if(rcvPage != null && !rcvPage.equals("")) {
					
					currPage = Integer.parseInt(rcvPage);
				}
				req.setAttribute("currPage", currPage);
				
			
				// 4) 블럭, 첫 페이지, 마지막 페이지 구하기
				
				// 페이지 블럭 번호
				int block = 0;
				// 출력할 페이지 번호 갯수
				int pageAmount = 5;
				// 시작 페이지
				int startPage = 0;
				// 마지막 페이지 
				int lastPage = 0;
				
				
				// 블럭
				block = currPage/pageAmount + 1;			
				// 시작 페이지
				startPage = (block-1)*pageAmount;
				// 마지막 페이지
				lastPage = startPage + pageAmount -1;
				
				
				// 마지막 페이지가 전체 페이지 번호보다 크면 전체 페이지 번호로 바꿈.
				if(lastPage > len - 1) {
					
					lastPage = len - 1;
				}
				
				req.setAttribute("startPage", startPage);
				req.setAttribute("lastPage", lastPage);
				
				
				
				List<QnaBbsDto> list = dao.getQAlist(currPage, category, keyword);
				
				req.setAttribute("QAlist",list);
				
				forward("qnabbslist.jsp", req, resp);

				
			}
			// QnA 상세페이지 이동
			else if(work.equals("QAdetailView")) {
				
				int seq = Integer.parseInt(req.getParameter("seq"));
				
				BbsDao dao = BbsDao.getInstance();
				
				// 질문글
				QnaBbsDto qbdto = dao.getQABbs(seq);
				// 답변글
				QnaAnsDto qadto = dao.getQAAns(seq);
				
				
				// 조회수 카운트, 세션 id 넣어서 비교해야됨
				if(!qbdto.getId().equals("aaa")) {			
					dao.getQABbsReadCount(seq);
				}
				
				
				
				req.setAttribute("qbdto", qbdto);
				req.setAttribute("qadto", qadto);
				
				forward("qnabbsdetail.jsp", req, resp);
				
			}
			
			
			// QnA 글쓰기 페이지 이동
			else if(work.equals("QAWriteView")) {
				
				resp.sendRedirect("qnabbswrite.jsp");
			}
			
			// QnA 질문글 수정페이지 이동
			else if(work.equals("QAUpdateView")) {
				
				int seq = Integer.parseInt(req.getParameter("seq"));
				
				BbsDao dao = BbsDao.getInstance();
				
				// 질문글
				QnaBbsDto qbdto = dao.getQABbs(seq);
				req.setAttribute("qbdto", qbdto);
				
				forward("qnabbsupdate.jsp", req, resp);
			}
			//배송안내 이동
		
			else if(work.equals("delivery")) {				
			
			resp.sendRedirect("delivery.jsp");		
			
			}else if(work.equals("wellbing")) {			
			
			resp.sendRedirect("bbs?w");		
			
			//회사소개 이동
			}else if(work.equals("about")) {
			
			resp.sendRedirect("about.jsp");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
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
}

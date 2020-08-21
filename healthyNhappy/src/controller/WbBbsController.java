package controller;

import dao.ProductDao;
import dao.WbBbsDao;
import dto.ProductDto;
import dto.WbBbsDto;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/wbbbs")
public class WbBbsController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		WbBbsDao dao = WbBbsDao.getInstance();
		String write = req.getParameter("write");
		String choice = req.getParameter("choice");
		String searchWord = req.getParameter("search");
		String spageNumber = req.getParameter("pageNumber");
		


		 if (write.equals("addView")) {

			resp.sendRedirect("wellbingwrite.jsp");

		} else if (write.equals("detailView")) {

			String sseq = req.getParameter("seq");

			int seq = Integer.parseInt(sseq);

			System.out.println(seq);

			WbBbsDto wto = dao.getWbs(seq);

			req.setAttribute("wb", wto);

			forward("wellbingdetail.jsp", req, resp);

		} else if (write.equals("updateView")) {

			int seq = Integer.parseInt(req.getParameter("seq"));

			WbBbsDto wto = dao.getWbs(seq);

			req.setAttribute("update", wto);

			forward("wellbingupdate.jsp", req, resp);

		} else if (write.equals("updateAf")) {

			System.out.println("오나");
			String sseq = req.getParameter("seq");

			int seq = Integer.parseInt(sseq);

			String title = req.getParameter("title");
			String content = req.getParameter("content");

			dao.updateWbUser(seq, title, content);

			resp.sendRedirect("bbs?work=wellbing");

		} else if (write.equals("delete")) {

			System.out.println("오나");
			int seq = Integer.parseInt(req.getParameter("seq"));

			dao.deleteWbBbs(seq);

			resp.sendRedirect("bbs?work=wellbing");
		} else if (write.equals("choice")) {
			searchWord =req.getParameter("search");

			if (choice == null || choice.equals("")) {
				choice = "sel";
			}
			if (choice.equals("sel")) {
				searchWord = "";
			}
			if (searchWord == null) {
				searchWord = "";
				choice = "sel";
			}


			int pageNumber = 0; // 현재 페이지
			if (spageNumber != null && !spageNumber.equals("")) {
				pageNumber = Integer.parseInt(spageNumber);
			}
			//System.out.println("pageNumber:" + pageNumber);

			List<WbBbsDto> list = dao.agetWbBbsList(choice, searchWord, pageNumber);

			int len = dao.getAllWbBbs(choice, searchWord);
			//System.out.println("총 게시판 글의 갯수:" + len);

			int wbBbsPage = len / 10;
			if (len % 10 > 0) {
				wbBbsPage = wbBbsPage + 1;



			}


			System.out.println("aaaaaaaaaaaaaaaaaaa");
			req.setAttribute("searchlist", list);
			req.setAttribute("choice", choice);
			req.setAttribute("searchWord", searchWord);
			req.setAttribute("pageNumber", pageNumber);
			req.setAttribute("wbBbsPage", wbBbsPage);
			forward("wellbing.jsp", req, resp);
		}
	 else if (write.equals("search")) {
			ProductDao pdao = ProductDao.getInstance();

			searchWord = req.getParameter("searchWord").trim();
			List<ProductDto> list = pdao.searchProduct(searchWord);
			HashMap<String, Object> map = new HashMap<String, Object>();


			int pageNumber = 0; // 현재 페이지
			if (spageNumber != null && !spageNumber.equals("")) {
				pageNumber = Integer.parseInt(spageNumber);
			}
			//System.out.println("pageNumber:" + pageNumber);

			List<WbBbsDto> wlist = dao.agetWbBbsList("title", searchWord, pageNumber);

			int len = dao.getAllWbBbs("title", searchWord);
			//System.out.println("총 게시판 글의 갯수:" + len);

			int wbBbsPage = len / 10;
			if (len % 10 > 0) {
				wbBbsPage = wbBbsPage + 1;
			}

			map.put("pageNumber", pageNumber);
			map.put("wbBbsPage", wbBbsPage);

			map.put("wlist", wlist);
			map.put("list", list);
			map.put("searchWord", searchWord);
			System.out.println("리스트사이즈" + list.size());
			req.setAttribute("map", map);
			forward("searchList.jsp", req, resp);

		} else if(write.equals("tableSearch")) {

			searchWord = req.getParameter("searchWord").trim();
			int pageNumber = 0; // 현재 페이지
			if (spageNumber != null && !spageNumber.equals("")) {
				pageNumber = Integer.parseInt(spageNumber);
			}
			//System.out.println("pageNumber:" + pageNumber);

			List<WbBbsDto> wlist = dao.agetWbBbsList("title", searchWord, pageNumber);

			int len = dao.getAllWbBbs("title", searchWord);
			//System.out.println("총 게시판 글의 갯수:" + len);

			int wbBbsPage = len / 10;
			if (len % 10 > 0) {
				wbBbsPage = wbBbsPage + 1;
			}


			req.setAttribute("pageNumber", pageNumber);
			req.setAttribute("wbBbsPage", wbBbsPage);
			req.setAttribute("wlist", wlist);
			req.setAttribute("searchWord", searchWord);
			forward("wellBingTable.jsp", req, resp);
		}


	}
		@Override
		protected void doPost (HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

			req.setCharacterEncoding("UTF-8");

			String write = req.getParameter("write");

			if (write.equals("dataWrite")) {

				String id = req.getParameter("id");
				String title = req.getParameter("title");
				String content = req.getParameter("content");
				String wdate = req.getParameter("wdate");
				System.out.println(id + title + content);

				WbBbsDao wao = WbBbsDao.getInstance();
				wao.addWbBbsWrite(id, title, content, wdate);

				resp.sendRedirect("wbbbs?write=choice");
			}

		}

		public void forward (String link, HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
			RequestDispatcher dis = req.getRequestDispatcher(link);
			dis.forward(req, resp);
		}


}
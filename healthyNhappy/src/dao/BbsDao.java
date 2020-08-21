package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.QnaAnsDto;
import dto.QnaBbsDto;
import dto.ReviewBbsDto;

public class BbsDao {
	
	private static BbsDao dao = new BbsDao();
	
	private BbsDao() {}
	
	public static BbsDao getInstance() {
		return dao;
	}
	
		
		
	// QnA 게시판 게시물 출력
	public List<QnaBbsDto> getQAlist(int currPage, String category, String keyword){
		
		String sql = " SELECT QNA_SEQ, QNA_ID, QNA_TITLE, QNA_CONTENT, TO_CHAR(QNA_WDATE,'YYYY/MM/DD HH24:MI:SS'), QNA_FILE_NAME, QNA_DEL, QNA_READCOUNT, QNA_OPEN, QNA_STATUS "
				+ 	 " FROM "  
				+	 " (SELECT ROW_NUMBER()OVER(ORDER BY QNA_SEQ DESC) AS RNUM, "
				+	 " QNA_SEQ, QNA_ID, QNA_TITLE, QNA_CONTENT, QNA_WDATE, QNA_FILE_NAME, QNA_DEL, QNA_READCOUNT, QNA_OPEN, QNA_STATUS "
				+ 	 " FROM QNA_BOARD ";
		
		String Category = "";
		
		if(category.equals("TITLE")) {
			Category += " WHERE QNA_TITLE LIKE " + "'%" + keyword + "%'" + " AND QNA_DEL=0 ";
		}
		else if(category.equals("CONTENT")) {
			Category += " WHERE QNA_CONTENT LIKE " + "'%" + keyword + "%'" + " AND QNA_DEL=0 ";
		}
		else if(category.equals("ID")) {
			Category += " WHERE QNA_ID LIKE " + "'%" + keyword + "%'" + " AND QNA_DEL=0 ";
		}
		
		sql += Category;
		sql += " ORDER BY QNA_SEQ DESC) ";
		sql += " WHERE RNUM >=? AND RNUM <=? ";
		
		int start = 1 + 10*currPage; // 1, 11, 21
		int end = 10 + 10*currPage; // 10, 20, 30
		
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<QnaBbsDto> list = new ArrayList<QnaBbsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getQAlist success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			rs = psmt.executeQuery();
			System.out.println("2/6 getQAlist success");
			
			while(rs.next()) {
				int i = 1;
				
				
				QnaBbsDto dto = new QnaBbsDto(rs.getInt(i++), 				// seq
											  rs.getString(i++), 			// id
											  rs.getString(i++), 			// title
											  rs.getString(i++),			// content 
											  rs.getString(i++), 			// wadate
											  rs.getString(i++), 			// fileName
											  rs.getInt(i++),				// del
											  rs.getInt(i++),				// readcount
											  rs.getInt(i++),				// open
											  rs.getInt(i++));				// status
				
				// 파일이름 null처리
				if(dto.getFilename() == null || dto.getFilename().equals("") ) {
					
					dto.setFilename("");
				}
				
				
				list.add(dto);
			}
			System.out.println("3/6 getQAlist success");

			
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}

		
	// QNA 질문글 입력
	public boolean writeQABbs(String id, String title, String content, String filename, int open ) {
		String sql = " INSERT INTO QNA_BOARD "
				+	 " (QNA_SEQ, QNA_ID, "
				+	 " QNA_TITLE, QNA_CONTENT, QNA_WDATE, QNA_FILE_NAME, "
				+	 " QNA_DEL, QNA_READCOUNT, QNA_OPEN, QNA_STATUS ) "
				+	 " VALUES( "
				+	 " SEQ_QNA.NEXTVAL, ?, "
				+	 " ?, ?, SYSDATE, ?, "
				+	 " 0, 0, ?, 0) ";
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		System.out.println(sql);
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 writeQABbs success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, title);
			psmt.setString(3, content);
			psmt.setString(4, filename);
			psmt.setInt(5, open);
			System.out.println("2/6 writeQABbs success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 writeQABbs success");
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, null);
		}
		return count>0?true:false;
		
		
	}
	// QNA 게시물 상세페이지 출력
	public QnaBbsDto getQABbs(int seq) {
		String sql = " SELECT QNA_SEQ, QNA_ID, QNA_TITLE, QNA_CONTENT, "
				+	 " QNA_WDATE, QNA_FILE_NAME, QNA_DEL, QNA_READCOUNT, QNA_OPEN, QNA_STATUS "
				+	 " FROM QNA_BOARD "
				+	 " WHERE QNA_SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		QnaBbsDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getQABbs success");
			
			psmt = conn.prepareStatement(sql);				
			psmt.setInt(1, seq);
			System.out.println("2/6 getQABbs success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getQABbs success");
			
			if(rs.next()) {
				int i = 1;
				
				dto = new QnaBbsDto(rs.getInt(i++), 
									rs.getString(i++),
									rs.getString(i++),
									rs.getString(i++),
									rs.getString(i++),
									rs.getString(i++),
									rs.getInt(i++),
									rs.getInt(i++),
									rs.getInt(i++),
									rs.getInt(i++));
				
				// 파일이름 null처리
				if(dto.getFilename() == null || dto.getFilename().equals("") ) {
					
					dto.setFilename("");
				}					
					
			}
			System.out.println("4/6 getQABbs success");
			return dto;
			
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, rs);
		}
		return dto;
		
	}
		
	// QNA 답변글 입력
	public boolean writeQAAns(int seq, String id, String content) {
		
		String sql1 = " UPDATE QNA_BOARD "
				+	  " SET QNA_STATUS=1 "
				+	  " WHERE QNA_SEQ =? ";
		
		
		String sql2 = " INSERT INTO QNA_ANS "
				+	  " (QNA_ANS_SEQ, QNA_ANS_ID, "
				+	  " QNA_ANS_CONTENT, QNA_ANS_WDATE, "
				+	  " QNA_ANS_REF, QNA_ANS_DEL) "
				+	  " VALUES( "
				+	  " QNA_ANS_SEQ.NEXTVAL, ?, "
				+	  " ?, SYSDATE, "
				+	  " ?, 0) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			System.out.println("1/6 writeQAAns success");
			
			psmt = conn.prepareStatement(sql1);
			psmt.setInt(1, seq);
			System.out.println("2/6 writeQAAns success");
			
			count += psmt.executeUpdate();
			System.out.println("3/6 writeQAAns success");
			
			psmt.clearParameters();
			
			psmt = conn.prepareStatement(sql2);
			psmt.setString(1, id);
			psmt.setString(2, content);
			psmt.setInt(3, seq);
			System.out.println("4/6 writeQAAns success");
			
			count += psmt.executeUpdate();
			System.out.println("5/6 writeQAAns success");
			
			conn.commit();
		} catch (Exception e) {
			
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}finally {
				
				try {
					conn.setAutoCommit(true);
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
				DBClose.close(psmt, conn, null);
				System.out.println("6/6 writeQAAns success");
			}
		}
		return count > 0?true:false;		
	}
		
	// QNA 답변글 출력
	public QnaAnsDto getQAAns(int seq) {
		
		String sql = " SELECT QNA_ANS_SEQ, QNA_ANS_ID, QNA_ANS_CONTENT, QNA_ANS_WDATE, "
				+    " QNA_ANS_REF, QNA_ANS_DEL "
				+	 " FROM QNA_ANS "
				+	 " WHERE QNA_ANS_REF =? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		QnaAnsDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getQAAns success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 getQAAns success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getQAAns success");
			if(rs.next()) {
				int i = 1;
				dto = new QnaAnsDto(rs.getInt(i++),
						            rs.getString(i++),
						            rs.getString(i++),
						            rs.getString(i++),
						            rs.getInt(i++),
						            rs.getInt(i++));	
			}
			System.out.println("4/6 getQAAns success");
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, rs);
		}
		return dto;		
	}
	// QNA 질문글 수정
	public boolean updateQABbs(int seq, int open, String title, String content, String filename) {
		
		String sql = " UPDATE QNA_BOARD "
				+	 " SET QNA_OPEN=?, QNA_TITLE=?, QNA_CONTENT=?, QNA_FILE_NAME=? "
				+	 " WHERE QNA_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 updateQABbs success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, open);
			psmt.setString(2, title);
			psmt.setString(3, content);
			psmt.setString(4, filename);
			psmt.setInt(5, seq);
			
			System.out.println("2/6 updateQABbs success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 updateQABbs success");
			
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, null);
		}
		return count > 0?true:false;		
	}
	
	// QNA 질문글 삭제
	public boolean deleteQABbs(int seq) {
		
		String sql = " UPDATE QNA_BOARD "
				+	 " SET QNA_DEL=1 "
				+	 " WHERE QNA_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 deleteQABbs success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq); 

			System.out.println("2/6 deleteQABbs success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 deleteQABbs success");
			
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, null);
		}
		return count > 0?true:false;		
	}
	
	// QNA 질문글 삭제
	public boolean deleteMultiQABbs(int[] seqs) {
		
		String sql = " UPDATE QNA_BOARD "
				+	 " SET QNA_DEL=1 "
				+	 " WHERE QNA_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count[] = new int[seqs.length];
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			System.out.println("1/6 deleteMultiQABbs success");
			
			psmt = conn.prepareStatement(sql);
			
			for (int i = 0; i < seqs.length; i++) {
				psmt.setInt(1, seqs[i]);
				psmt.addBatch();
				
			}
			System.out.println("2/6 deleteMultiQABbs success");
			
			
			count = psmt.executeBatch();
			System.out.println("3/6 deleteMultiQABbs success");
			
			conn.commit();
			System.out.println("4/6 deleteMultiQABbs success");
			
		} catch (Exception e) {
			
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				
				e1.printStackTrace();
			}
		}finally {
			try {
				
				conn.setAutoCommit(true);	
				System.out.println("5/6 deleteMultiQABbs success");
			} catch (SQLException e) {		
				
     			e.printStackTrace();
			}
			
			DBClose.close(psmt, conn, null);
		}
		
		boolean isS = true;
		
		for (int i = 0; i < count.length; i++) {
			
			if(count[i] != -2) {
				
				isS = false;
				break;
			}
		}
		System.out.println("6/6 deleteMultiQABbs success");
		
		return isS;
	}
	
	
	
	
	
	
	// QNA 답변글 수정
	public boolean updateQAAns(int seq, String content) {
		String sql = " UPDATE QNA_ANS "
				+	 " SET QNA_ANS_CONTENT=? "
				+	 " WHERE QNA_ANS_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 updateQAAns success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, content);
			psmt.setInt(2, seq);
			
			System.out.println("2/6 updateQAAns success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 updateQAAns success");
			
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, null);
		}
		return count > 0?true:false;		
		
	}
	// QNA 질문글 갯수 구하기
	public int getQABbsAmount(String category, String keyword) {
		
		String sql= " SELECT COUNT(*) "
				 +	" FROM QNA_BOARD ";
		
		String Category = "";
		
		if(category.equals("TITLE")) {
			Category += " WHERE QNA_TITLE LIKE " + "'%" + keyword + "%'" + " AND QNA_DEL=0 ";
		}
		else if(category.equals("CONTENT")) {
			Category += " WHERE QNA_CONTENT LIKE " + "'%" + keyword + "%'" + " AND QNA_DEL=0 ";
		}
		else if(category.equals("ID")) {
			Category += " WHERE QNA_ID LIKE " + "'%" + keyword + "%'" + " AND QNA_DEL=0 ";
		}
		
		sql += Category;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getQABbsAmount success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getQABbsAmount success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getQABbsAmount success");
			
			
			if(rs.next()){
				
				count =rs.getInt(1) ; 
			}
			System.out.println("4/6 getQABbsAmount success");
				
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		return count;		
	}
	
	// QNA 질문글 조회수 카운트
	public void getQABbsReadCount(int seq) {
		
		String sql = " UPDATE QNA_BOARD "
				+	 " SET QNA_READCOUNT = QNA_READCOUNT+1 "
				+	 " WHERE QNA_SEQ =? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getQABbsReadCount success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 getQABbsReadCount success");
			
			psmt.executeUpdate();
			System.out.println("3/6 getQABbsReadCount success");
						
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally {
			
			DBClose.close(psmt, conn, null);
		}
	}
	
	// Review 게시판 마이페이지로
	public List<ReviewBbsDto> getReviewMypage(String id) {
		
		String sql = " SELECT * " + 
				"	FROM REV_BOARD " + 
				"	WHERE REV_ID=? " + 
				"	ORDER BY REV_WDATE DESC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ReviewBbsDto> list = new ArrayList<ReviewBbsDto>();
			
		try {
			conn = DBConnection.getConnection();
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				int i = 1;
				ReviewBbsDto dto = new ReviewBbsDto(
						rs.getInt(i++), 	// 글번호
						rs.getString(i++),	// id
						rs.getString(i++),	// 제목
						rs.getString(i++), 	// 내용
						rs.getInt(i++),		// 평점
						rs.getString(i++),	// 파일이름
						rs.getString(i++),  // 작성일
						rs.getInt(i++), 	// 삭제
						rs.getInt(i++));	// 상품번호
				list.add(dto);
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;		
	}

	// Qna 게시판 마이페이지로
	public List<QnaBbsDto> getQnaMypage(String id) {
		
		String sql = " SELECT * " + 
				" FROM QNA_BOARD " + 
				" WHERE QNA_ID=? " + 
				" ORDER BY QNA_WDATE DESC ";
				//고친 부분 내일 확인
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<QnaBbsDto> list = new ArrayList<QnaBbsDto>();
			
		try {
			conn = DBConnection.getConnection();
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				int i = 1;
				QnaBbsDto dto = new QnaBbsDto(
						rs.getInt(i++), 				// seq
						  rs.getString(i++), 			// id
						  rs.getString(i++), 			// title
						  rs.getString(i++),			// content 
						  rs.getString(i++), 			// wadate
						  rs.getString(i++), 			// fileName
						  rs.getInt(i++),				// del
						  rs.getInt(i++),				// readcount
						  rs.getInt(i++),				// open
						  rs.getInt(i++));				// status);
				list.add(dto);
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;		
	}
	
}

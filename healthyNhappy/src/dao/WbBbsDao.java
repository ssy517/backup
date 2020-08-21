package dao;

import db.DBClose;
import db.DBConnection;
import dto.MemberDto;
import dto.WbBbsDto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class WbBbsDao {

	private static WbBbsDao dao = new WbBbsDao();  // 전역 객체변수로 사용하기 위해  static 객체변수로 생


	private WbBbsDao() {}  // 생성자를 private 로 만들어 접근 제한을 건

	public static WbBbsDao getInstance() { // getinstance 메소드를 통해 한번만  생성된 객체를 가져온다
		return dao;
	}

	public List<WbBbsDto> getWbBbsList(){

		String sql = " SELECT WB_SEQ, WB_ID , WB_TITLE , WB_CONTENT , WB_WDATE , WB_READCOUNT , WB_DEL "
				+ " FROM WELL_BOARD "
				+ " ORDER BY WB_SEQ DESC ";


		Connection conn= null;
		PreparedStatement psmt = null;
		ResultSet rs =null;

		List<WbBbsDto> list = new ArrayList<>();

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getWbBbsList success");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getWbBbsList success");

			rs = psmt.executeQuery();
			System.out.println("3/6 getWbBbsList success");

			while(rs.next()){
				int i =1;
				WbBbsDto dto = new WbBbsDto(rs.getInt(i++),
						rs.getString(i++),
						rs.getString(i++),
						rs.getString(i++),
						rs.getString(i++),
						rs.getInt(i++),
						rs.getInt(i++)
				);

				list.add(dto);
			}
			System.out.println("4/6 getWbBbsList success");


		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(psmt , conn , rs);
		}
		return list;
	}


	public boolean addWbBbsWrite(String id , String title , String content ,String wdate){

		String sql = " INSERT INTO WELL_BOARD "
				+" (WB_SEQ , WB_ID , WB_TITLE , WB_CONTENT," +
				"  WB_WDATE , WB_READCOUNT , WB_DEL  )"
				+" VALUES (WB_SEQ.NEXTVAL,?,?,?,SYSDATE,0,0) " ;



		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 addMember success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, title);
			psmt.setString(3, content);

			count= psmt.executeUpdate();
			System.out.println("2/6 addMember success");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn ,null);
		}
		return count>0?true:false;
	}


	public WbBbsDto getWbs(int seq){
		String sql =" SELECT WB_SEQ,WB_ID,WB_TITLE,WB_CONTENT,  "
				+" WB_WDATE ,WB_READCOUNT,WB_DEL "
				+" FROM WELL_BOARD "
				+" WHERE WB_SEQ =? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		WbBbsDto dto = null;
		try {
			conn= DBConnection.getConnection();
			System.out.println("1/6 getWbs success");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getWbs success");

			psmt.setInt(1, seq);

			rs = psmt.executeQuery();
			System.out.println("3/6 getWbs success");

			if(rs.next()){
				int i = 1;
				dto = new WbBbsDto(rs.getInt(i++),
						rs.getString(i++),
						rs.getString(i++),
						rs.getString(i++),
						rs.getString(i++),
						rs.getInt(i++),
						rs.getInt(i++));
			}
			System.out.println(dto);
			System.out.println("4/6 getWbs success");
		} catch (Exception e) {
			System.out.println("getWbs fail");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt,conn,rs);
		}
		return dto;
	}

	public int updateWbUser(int seq, String title , String content){

		String sql = " UPDATE WELL_BOARD "
				+" SET WB_TITLE=? , WB_CONTENT=? "
				+" WHERE WB_SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		System.out.println(title);
		System.out.println(content);
		System.out.println(seq);
		int count =0;

		try {
			conn = DBConnection.getConnection();

			psmt= conn.prepareStatement(sql);

			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setInt(3, seq);

			count = psmt.executeUpdate();


		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt , conn , null);
		}
		return count;
	}
	public boolean deleteWbBbs(int seq){

		String sql = " UPDATE WELL_BOARD "
				+ " SET WB_DEL=1 "
				+ " WHERE WB_SEQ=? ";



		Connection conn =null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 deleteWbBbs");

			psmt= conn.prepareStatement(sql);

			psmt.setInt(1, seq);
			System.out.println("2/6 deleteWbBbs");

			count = psmt.executeUpdate();
			System.out.println("3/6 deleteWbBbs");
		} catch (Exception e) {
			System.out.println( "fail deleteWbBbs");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt,conn ,null);
		}
		return count>0?true:false;
	}

	public int getAllWbBbs(String choice , String searchWord){
		String sql = " SELECT COUNT(*) FROM WELL_BOARD ";

		String sqlWord = "";

		if(choice.equals("title")){
			sqlWord = " WHERE WB_TITLE LIKE '%" + searchWord.trim() + "%' ";
		} else if(choice.equals("writer") && !searchWord.equals("")){
			sqlWord = " WHERE WB_ID='" + searchWord.trim() + "'";
		}else if(choice.equals("content")) {
			sqlWord = " WHERE WB_CONTENT LIKE '%" + searchWord.trim() + "%' ";
		}
		sql += sqlWord;


		Connection conn= null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		int len = 0;

		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();

			if(rs.next()){
				len = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("getAllWbBbs fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt , conn ,rs);
		}
		return len;
	}
	public List<WbBbsDto> agetWbBbsList(String choice , String searchWord , int page){

		String sql = " SELECT WB_SEQ, WB_ID, WB_TITLE, WB_CONTENT, "
				+" WB_WDATE, WB_READCOUNT, WB_DEL "
				+" FROM  ";

		sql += "(SELECT ROW_NUMBER()OVER(ORDER BY WB_SEQ DESC) AS RNUM, "
				+" WB_SEQ , WB_ID , WB_TITLE , WB_CONTENT , WB_WDATE , WB_READCOUNT , WB_DEL "
				+" FROM WELL_BOARD ";

		String sqlWord = "";
		if(choice.equals("title")){
			sqlWord = " WHERE WB_TITLE LIKE '%" + searchWord.trim() + "%' AND WB_DEL=0 ";
		} else if(choice.equals("writer")){
			sqlWord = " WHERE WB_ID='" + searchWord.trim() + "'";
		} else if(choice.equals("content")){
			sqlWord =" WHERE WB_CONTENT LIKE '%" + searchWord.trim() + "%' ";
		}
		sql = sql + sqlWord;

		sql += " ORDER BY WB_SEQ DESC) ";
		sql += " WHERE RNUM >= ? AND RNUM <= ? ";

		int start , end;
		start = 1 + 10 * page;
		end = 10 + 10 * page;



		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs =null;

		List<WbBbsDto> list = new ArrayList<>();

		try {
			conn= DBConnection.getConnection();
			System.out.println("1/6 getWbBbsList success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2 , end);
			System.out.println("2/6 getWbBbsList success");

			rs = psmt.executeQuery();
			System.out.println("3/6 getWbBbsList success");

			while(rs.next()){
				int i =1;
				WbBbsDto wto = new WbBbsDto(rs.getInt(i++),
						rs.getString(i++),
						rs.getString(i++),
						rs.getString(i++),
						rs.getString(i++),
						rs.getInt(i++),
						rs.getInt(i++));
				list.add(wto);
			}
			System.out.println("4/6 getWbBbsList success");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt , conn , rs);
		}
		return list;
	}
}

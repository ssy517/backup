package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.jdt.internal.compiler.flow.FinallyFlowContext;

import com.sun.media.jfxmediaimpl.platform.gstreamer.GSTPlatform;
import com.sun.xml.internal.ws.Closeable;

import controller.productController;
import db.DBClose;
import db.DBConnection;
import dto.MemberDto;
import javafx.util.converter.PercentageStringConverter;

public class MemberDao {
	
	private static MemberDao dao = new MemberDao();
	
	private MemberDao() {}
	
	public static MemberDao getInstance() {
		return dao;
	}
	
	public List<MemberDto> getUserDtoList(){
		
		String sql = " SELECT ID, NAME, ADDRESS, PHONE, EMAIL, AUTH"
					+ " FROM MEMBER "
					+ " ORDER BY ID DESC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<MemberDto> list = new ArrayList<MemberDto>();
		
		try {
			conn = DBConnection.getConnection();
			//System.out.println("1/6 getUserDtoList success");
			
			psmt = conn.prepareStatement(sql);
			//System.out.println("2/6 getUserDtoList success");
			
			rs = psmt.executeQuery();
			//System.out.println("3/6 getUserDtoList success");
			
			while(rs.next()) {
				String id = rs.getString("id");
				String name = rs.getString("name");
				String address = rs.getString("address");
				String phone = rs.getString("phone");
				String email = rs.getString("email");
				int auth = rs.getInt("auth");
				list.add( new MemberDto(id,null, name, address, phone, email, auth) );
			}
			System.out.println("getUserDtoList 성공");
		} catch (Exception e) {
			System.out.println("getUserDtoList 실패");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		
	return list;
	}
	
	public boolean addMember(MemberDto dto) { //회원가입
		
		String sql = " INSERT INTO MEMBER "
				+ " (ID, PWD, NAME, ADDRESS, PHONE, EMAIL, AUTH) "
				+ " VALUES(?, ?, ?, ?, ?, ?, 2) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;	
		
		int count = 0;
		
		try {
			
			conn = DBConnection.getConnection();
			System.out.println("1/6 addMember success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 addMember success");
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getAddress());
			psmt.setString(5, dto.getPhone());
			psmt.setString(6, dto.getEmail());
			
			count = psmt.executeUpdate();
			System.out.println("3/6 addMember success");
			System.out.println("추가가 완료 되었습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("addMember 추가실패");
		}finally {
		DBClose.close(psmt, conn, null);	
		}		
		return count>0?true:false;
	}
	
	public boolean IDtest(String id1) { //id체크
		
		String sql = " SELECT ID FROM MEMBER "
					+ " WHERE ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		boolean findid = false;
		
		try {
			
			conn = DBConnection.getConnection();
			System.out.println("1/6 IDtest success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 IDtest success");
			
			psmt.setString(1, id1.trim());
			
			rs = psmt.executeQuery();
			System.out.println("3/6 IDtest success");
			System.out.println("아이디체크 되었습니다.");
			
			if(rs.next()) {
				findid = true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("IDtest 실패");
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return findid;
	}
	
	public int update(String pwd, String add, String phone, String email, String id) { //정보수정
		 
		String sql = " UPDATE MEMBER SET "
				+ " PWD=?, ADDRESS=?, PHONE=?, EMAIL=? "
				+ " WHERE ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		MemberDto dto = new MemberDto();
		
		int count =0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 update success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 update success");
			
			psmt.setString(1, pwd);
			psmt.setString(2, add);
			psmt.setString(3, phone);
			psmt.setString(4, email);
			psmt.setString(5, id);
			
			count = psmt.executeUpdate();
			
			System.out.println("3/6 update success");
			System.out.println("정보가 업데이트 되었습니다.");
			
		} catch (Exception e) {
			System.out.println("update 실패");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		return count;
	}
	
	public MemberDto login(String id, String pwd) { //로그인
		
		String sql = " SELECT ID, NAME, ADDRESS, PHONE, EMAIL, AUTH "
					+ " FROM MEMBER "
					+ " WHERE ID=? AND PWD=? ";
		
		Connection conn = null;			
		PreparedStatement psmt = null; 
		ResultSet rs = null;
		
		MemberDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 login success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 login success");
			
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			
			rs = psmt.executeQuery();
			System.out.println("3/6 login success");
			
			if(rs.next()) {
				String user_id = rs.getString(1);   //아이디
				String name = rs.getString(2);		//이름
				String add = rs.getString(3);		//주소
				String phone = rs.getString(4);     //번호
				String email = rs.getString(5);		//메일
				int auth = rs.getInt(6);			
				
				dto = new MemberDto(user_id,null,name,add,phone,email,auth);
				}
			
				System.out.println("4/6 login success");
				
		} catch (Exception e) {
			System.out.println("로그인 실패");
			e.printStackTrace(); 
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		return dto;
		}
	
	public int dalete(String id) { //탈퇴를 가장한 눈속임
		
		String sql = " UPDATE MEMBER SET "
					+ " AUTH=3"
					+ " WHERE ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		MemberDto dto = new MemberDto();
		
		int count =0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 dalete success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 dalete success");
			
			psmt.setString(1, id);
			
			count = psmt.executeUpdate();
			
			System.out.println("3/6 dalete success");
			System.out.println("정보가 업데이트(3) 되었습니다.");
			
		} catch (Exception e) {
			System.out.println("dalete 실패");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		return count;
	}
	public String IDfind(String name, String email) { 
			
			String sql = " SELECT ID"
						+ " FROM MEMBER "
						+ " WHERE NAME=? AND EMAIL=? ";
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			String findid = null;
			
			try {
				
				conn = DBConnection.getConnection();
				System.out.println("1/6 IDfind success");
				
				psmt = conn.prepareStatement(sql);
				System.out.println("2/6 IDfind success");
				
				psmt.setString(1, name.trim());
				psmt.setString(2, email.trim());
				
				rs = psmt.executeQuery();
				System.out.println("3/6 IDfind success");
				System.out.println("아이디 찾아라");
				
				if(rs.next()) {
				findid = rs.getString("id");
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("IDfind 실패");
			}finally {
				DBClose.close(psmt, conn, rs);
			}
			
			return findid;
		}
	
	public String PWDfind(String id, String name) { 
		
		String sql = " SELECT ID, NAME, PWD"
					+ " FROM MEMBER "
					+ " WHERE ID=? AND NAME=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String PWDfind = null;
		
		try {
			
			conn = DBConnection.getConnection();
			System.out.println("1/6 PWDfind success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 PWDfind success");
			
			psmt.setString(1, id.trim());
			psmt.setString(2, name.trim());
			
			rs = psmt.executeQuery();
			System.out.println("3/6 PWDfind success");
			System.out.println("비밀번호 찾아라");
			
			if(rs.next()) {
			PWDfind = rs.getString("pwd");
			System.out.println("찾음:"+PWDfind);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("PWDfind 실패");
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		return PWDfind;
		}
	
		public MemberDto userinfo(String id) { 
			
			String sql = " SELECT ID, NAME, ADDRESS, PHONE, EMAIL "
						+ " FROM MEMBER "
						+ " WHERE ID=? ";
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			MemberDto dto = new MemberDto();
			
			try {
				
				conn = DBConnection.getConnection();
				System.out.println("1/6 userinfo success");
				
				psmt = conn.prepareStatement(sql);
				System.out.println("2/6 userinfo success");
				
				psmt.setString(1, id);
				System.out.println(id);
				
				rs = psmt.executeQuery();
				System.out.println("3/6 userinfo success");
				System.out.println("신상정보를 찾음");
				
				if(rs.next()) {
				String id1 = rs.getString("id");
				String name = rs.getString("name");
				String address = rs.getString("address");
				String phone = rs.getString("phone");
				String email = rs.getString("email");
				
				dto = new MemberDto(id1, name, address, phone, email);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("userinfo 실패");
			}finally {
				DBClose.close(psmt, conn, rs);
			}
			return dto;
		}
	
	public int authupdate(String add, String phone, String email, String id) { //정보수정
		 
		String sql = " UPDATE MEMBER SET "
				+ " ADDRESS=?, PHONE=?, EMAIL=? "
				+ " WHERE ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		MemberDto dto = new MemberDto();
		
		int count =0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 update success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 update success");
			
			psmt.setString(1, add);
			psmt.setString(2, phone);
			psmt.setString(3, email);
			psmt.setString(4, id);
			
			count = psmt.executeUpdate();
			
			System.out.println("3/6 update success");
			System.out.println("정보가 업데이트 되었습니다.");
			
		} catch (Exception e) {
			System.out.println("update 실패");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		return count;
	}
	
	public int authdel(String id) { //정보수정
		 
		String sql = " UPDATE MEMBER SET "
				+ " AUTH=3"
				+ " WHERE ID=? ";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	MemberDto dto = new MemberDto();
	
	int count =0;
	
	try {
		conn = DBConnection.getConnection();
		System.out.println("1/6 dalete success");
		
		psmt = conn.prepareStatement(sql);
		System.out.println("2/6 dalete success");
		
		psmt.setString(1, id);
		
		count = psmt.executeUpdate();
		
		System.out.println("3/6 dalete success");
		System.out.println("정보가 업데이트(3) 되었습니다.");
		
	} catch (Exception e) {
		System.out.println("dalete 실패");
		e.printStackTrace();
	}finally {
		DBClose.close(psmt, conn, null);
	}
	return count;
	}
	public List<MemberDto> userList(String choice, String searchWord, int pageNumber) {
		
		/*
		 	1. row 번호
		 	2. 검색
		 	3. 정렬
		 	4. 범위설정 1~10까지
		 */
		
		String sql = " SELECT ID, NAME , ADDRESS, PHONE, EMAIL "
				+ " FROM ";
		
		sql += "(SELECT ROW_NUMBER()OVER(ORDER BY NAME DESC) AS RNUM, " + 
					" ID, NAME , ADDRESS, PHONE, EMAIL " + 
					" FROM MEMBER ";
		
		  String sqlWord = "";
		  if (choice.equals("sel")) {
			  sqlWord = " WHERE AUTH <> 3 ";
		  }else if(choice.equals("NAME")) {
			  sqlWord = " WHERE NAME LIKE '%" + searchWord.trim() + "%' AND AUTH <> 3 ";
		  }else if(choice.equals("ADDRESS")) { 
			  sqlWord = " WHERE ADDRESS LIKE '%" +searchWord.trim() + "%' AND AUTH <> 3 "; 
		  } 
		  
		  sql = sql + sqlWord; 
		
		  sql += " ORDER BY NAME ) ";
		  sql += " WHERE RNUM >=? AND RNUM <= ? ";
		  
		 int start, end;
		  start = 1 + 10 * pageNumber;
		  end = 10 + 10 * pageNumber;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		System.out.println("dao sql = "+sql);
		List<MemberDto> list = new ArrayList<MemberDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 userList success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			System.out.println("2/6 userList success");

			rs = psmt.executeQuery();
			System.out.println("3/6 userList success");

			while(rs.next()) {
				int i = 1;
				MemberDto dto = new MemberDto(rs.getString(i++), 
											rs.getString(i++), 
											rs.getString(i++), 
											rs.getString(i++), 
											rs.getString(i++));
											
				list.add(dto);
				
			}
			System.out.println("userList success");

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	public int UserlistSize(String choice, String searchWord) {
		
		String sql = " SELECT COUNT(*) FROM MEMBER"; 	
		
		  if (choice.equals("sel")) {
			  sql += " WHERE AUTH <> 3 ";
		  }else if(choice.equals("NAME")) {
			  sql += " WHERE NAME LIKE '%" + searchWord.trim() + "%' AND AUTH <> 3 ";
		  }else if(choice.equals("ADDRESS")) { 
			  sql += " WHERE ADDRESS LIKE '%" +searchWord.trim() + "%' AND AUTH <> 3 "; 
		  }
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int num = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		return num;
	}	

}


























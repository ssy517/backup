package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.OrderDto;
import dto.ProductDto;

public class AuthProductDao {

	private static AuthProductDao dao = new AuthProductDao();
	
	private AuthProductDao() {
		
	}
	
	public static AuthProductDao getInstance() {
		return dao;
	}
	
	// 상품 관리 게시판 리스트 (차트 반영, 삭제된 제품 제외)
	public List<ProductDto> getAllProduct() {
		String sql = " SELECT * FROM PRODUCT "
				+ " WHERE PRD_DEL != 1 "
				+ " ORDER BY PRD_NUM ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ProductDto> list = new ArrayList<ProductDto>();
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			System.out.println("getAllProduct success");
			
			while(rs.next()) {
				int i = 1;
				ProductDto dto = new ProductDto(
										rs.getInt(i++), 	// 상품번호
										rs.getString(i++),	// 상품이름
										rs.getInt(i++),		// 상품 가격
										rs.getString(i++),	// 상품 이미지 파일 이름
										rs.getString(i++), 	// 상품 설명
										rs.getInt(i++),  	// 배송비
										rs.getString(i++),  // 규격
										rs.getString(i++), 	// 원산지
										rs.getString(i++),	// 유통기한
										rs.getString(i++),	// 보관방법
										rs.getString(i++),	// 포장상태
										rs.getInt(i++),		// 재고
										rs.getInt(i++),		// 판매량
										rs.getInt(i++));	// 삭제
				list.add(dto);
			}
			System.out.println("getAllProductbbs success end");
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}

	// 상품 관리 게시판 페이징 + 검색 리스트
	public List<ProductDto> getProductPagingList(String choice, String searchWord, int pageNumber) {
		String sql = " SELECT PRD_NUM, PRD_NAME, PRD_PRICE, PRD_IMG_NAME, PRD_INFO, PRD_DELIVERY_PRICE, " 
				+ " PRD_SIZE, PRD_ORIGIN, PRD_EXPDATE, PRD_KEEP, PRD_PACK, PRD_AMOUNT, PRD_SELL, PRD_DEL "
				+ " FROM ";
		
		sql += " (SELECT ROW_NUMBER()OVER(ORDER BY PRD_NUM DESC) AS RNUM, "
				+ " PRD_NUM, PRD_NAME, PRD_PRICE, PRD_IMG_NAME, PRD_INFO, PRD_DELIVERY_PRICE, " 
				+ "	PRD_SIZE, PRD_ORIGIN, PRD_EXPDATE, PRD_KEEP, PRD_PACK, PRD_AMOUNT, PRD_SELL, PRD_DEL "
				+ " FROM PRODUCT ";
		
		if(choice.equals("prd_num")) {
			sql = sql + " WHERE PRD_NUM LIKE '%" + searchWord.trim() + "%'";
		}else if(choice.equals("prd_name")) {
			sql = sql + " WHERE PRD_NAME LIKE '%" + searchWord.trim() + "%'";
		}
		
		sql += " ORDER BY PRD_NUM DESC ) ";
		sql += " WHERE RNUM >= ? AND RNUM <= ? ";
		
		int start, end;
		start = 1 + 15 * pageNumber; //시작 글의 번호
		end = 15 + 15 * pageNumber; // 끝 번호
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ProductDto> list = new ArrayList<ProductDto>();
		
		try {
			conn = DBConnection.getConnection();
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			System.out.println( "nummm" + start + end );
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				int i = 1;
				
				ProductDto dto = new ProductDto(
										rs.getInt(i++), 	// 상품번호
										rs.getString(i++),	// 상품이름
										rs.getInt(i++),		// 상품 가격
										rs.getString(i++),	// 상품 이미지 파일 이름
										rs.getString(i++), 	// 상품 설명
										rs.getInt(i++),  	// 배송비
										rs.getString(i++),  // 규격
										rs.getString(i++), 	// 원산지
										rs.getString(i++),	// 유통기한
										rs.getString(i++),	// 보관방법
										rs.getString(i++),	// 포장상태
										rs.getInt(i++),		// 재고
										rs.getInt(i++),		// 판매량
										rs.getInt(i++));	// 삭제
				list.add(dto);
			}
			System.out.println("PAGING success");
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	// 페이징 위한 리스트 사이즈
	public int getProductListSize(String choice, String searchWord) {
		String sql = " SELECT COUNT(*) FROM PRODUCT "; 
		
		if(choice.equals("prd_num")) {
			sql = sql + " WHERE PRD_NUM LIKE '%" + searchWord.trim() + "%'";
		}else if(choice.equals("prd_name")) {
			sql = sql + " WHERE PRD_NAME LIKE '%" + searchWord.trim() + "%'";
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
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		return num;
	}
	
	public ProductDto getProduct( int prd_num ) {
		String sql = " SELECT * FROM PRODUCT "
				+ " WHERE PRD_NUM = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		ProductDto dto = new ProductDto();
	
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, prd_num);
			
			rs = psmt.executeQuery();
			System.out.println("getProduct success");
			
			while(rs.next()) {
				int i = 1;
				dto = new ProductDto(
										rs.getInt(i++), 	// 상품번호
										rs.getString(i++),	// 상품이름
										rs.getInt(i++),		// 상품 가격
										rs.getString(i++),	// 상품 이미지 파일 이름
										rs.getString(i++), 	// 상품 설명
										rs.getInt(i++),  	// 배송비
										rs.getString(i++),  // 규격
										rs.getString(i++), 	// 원산지
										rs.getString(i++),	// 유통기한
										rs.getString(i++),	// 보관방법
										rs.getString(i++),	// 포장상태
										rs.getInt(i++), 	// 재고
										rs.getInt(i++),		// 판매량
										rs.getInt(i++));	// 삭제
			}
			System.out.println("getProduct success end");
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		return dto;
	}
	
	// prd_num 부여하기 위해 기존 리스트 size 가져오기
	public int getPrd_num( int category ) {
		
		String sql = " SELECT COUNT(*) FROM PRODUCT"
				+ " WHERE PRD_NUM > ? AND PRD_NUM < ? "; 
	
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int num = 0;
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, category);
			psmt.setInt(2, category + 11);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt(1);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		return num;
	}

	// 제품 등록
	public boolean addProduct( ProductDto dto ) {
		String sql = " INSERT INTO PRODUCT ( PRD_NUM, PRD_NAME, PRD_PRICE, PRD_IMG_NAME, PRD_INFO, PRD_DELIVERY_PRICE, "
				+ " PRD_SIZE, PRD_ORIGIN, PRD_EXPDATE, PRD_KEEP, PRD_PACK, PRD_AMOUNT, PRD_SELL, PRD_DEL ) "
				+ " VALUES ( ?, ?, ?, ?, ?, 2500, ?, ?, ?, ?, ?, ?, ?, 0 ) ";
	
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		try {
			conn = DBConnection.getConnection();
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, dto.getPrd_num());
			psmt.setString(2, dto.getName());
			psmt.setInt(3, dto.getPrice());
			psmt.setString(4, dto.getImg_name());
			psmt.setString(5, dto.getInfo());
			psmt.setString(6, dto.getSize());
			psmt.setString(7, dto.getOrigin());
			psmt.setString(8, dto.getExpdate());
			psmt.setString(9, dto.getKeep());
			psmt.setString(10, dto.getPack());
			psmt.setInt(11, dto.getAmount());
			psmt.setInt(12, dto.getSell());
			
			count = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		return count>0?true:false;
	}
	
	// 제품 삭제
	public boolean deleteProduct( int prd_num ) {
		String sql=" UPDATE PRODUCT "
				+ " SET PRD_DEL = 1 "
				+ " WHERE PRD_NUM = ?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, prd_num);
			count = psmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		return count>0?true:false;	
	}

	// 제품 수정
	public boolean updateProduct( ProductDto dto ) {
		String sql = " UPDATE PRODUCT "
				+ " SET PRD_NAME = ?, PRD_PRICE = ?, PRD_INFO = ?, PRD_SIZE = ?, "
				+ " PRD_ORIGIN = ?, PRD_EXPDATE = ?, PRD_KEEP = ?, PRD_PACK = ?, PRD_AMOUNT = ?, PRD_SELL = ? "
				+ " WHERE PRD_NUM = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, dto.getName());
			psmt.setInt(2, dto.getPrice());
			psmt.setString(3, dto.getInfo());
			psmt.setString(4, dto.getSize());
			psmt.setString(5, dto.getOrigin());
			psmt.setString(6, dto.getExpdate());
			psmt.setString(7, dto.getKeep());
			psmt.setString(8, dto.getPack());
			psmt.setInt(9, dto.getAmount());
			psmt.setInt(10, dto.getSell());
			psmt.setInt(11, dto.getPrd_num());
	
			count = psmt.executeUpdate();
			
		} catch (Exception e) {			
			e.printStackTrace();
		} finally{
			DBClose.close(psmt, conn, null);			
		}
		return count>0?true:false;
		
	}

	//-----------------------------------------------------------
	
	// 주문 관리 게시판 리스트 
	public List<OrderDto> getAllOrder( String choice, String searchWord, int pageNumber ) {
		String sql = " SELECT ORDER_SEQ, ORDER_ID, ORDER_REQUEST, ORDER_DATE, "
				+ " ORDER_ADDRESS, ORDER_PRICE, ORDER_DEL "
				+ " FROM ";
		sql += " ( SELECT ROW_NUMBER()OVER(ORDER BY ORDER_SEQ DESC) AS RNUM, "
				+ " ORDER_SEQ, ORDER_ID, ORDER_REQUEST, ORDER_DATE, "
				+ " ORDER_ADDRESS, ORDER_PRICE, ORDER_DEL FROM ORDER_PRD ";

		if(choice.equals("order_seq")) {
			sql = sql + " WHERE ORDER_SEQ LIKE '%" + searchWord.trim() + "%'";
		}
		
		sql += " ORDER BY ORDER_SEQ DESC ) ";
		sql += " WHERE RNUM >= ? AND RNUM <= ? ";
	
		int start, end;
		start = 1 + 15 * pageNumber; //시작 글의 번호
		end = 15 + 15 * pageNumber; // 끝 번호
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<OrderDto> list = new ArrayList<OrderDto>();
		
		try {
			conn = DBConnection.getConnection();
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				int i = 1;
				
				OrderDto dto = new OrderDto(
										rs.getInt(i++), 	// 주문번호
										rs.getString(i++),	// id
										rs.getString(i++),	// 요청사항
										rs.getString(i++), 	// 주문일시
										rs.getString(i++),  // 배송지
										rs.getInt(i++),		// 가격
										rs.getInt(i++));	// 삭제
				list.add(dto);
			}
			System.out.println("PAGING success");
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	// 페이징 위한 리스트 사이즈
	public int getOrderListSize(String choice, String searchWord) {
		
		String sql = " SELECT COUNT(*) FROM ORDER_PRD "; 
		
		if(choice.equals("order_seq")) {
			sql = sql + " WHERE PRD_NUM LIKE '%" + searchWord.trim() + "%'";
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
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		return num;
		
	}



}

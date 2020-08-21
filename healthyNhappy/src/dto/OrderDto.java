package dto;

import java.io.Serializable;

public class OrderDto implements Serializable {
	
	/*
	CREATE TABLE ORDER_PRD
	(
    ORDER_SEQ NUMBER(8) PRIMARY KEY,
    ORDER_ID VARCHAR2(50),
    ORDER_REQUEST VARCHAR2(500) NOT NULL,
    ORDER_DATE DATE NOT NULL,
    ORDER_ADDRESS VARCHAR2(50) NOT NULL,
    ORDER_PRICE NUMBER(10) NOT NULL
    ); 
	 */
	
	private int seq;	      // 주문 번호
	private String id;		  // 주문자 id
	private String add_req;   // 기타 요청사항
	private String odate;     // 주문일시
	private String deli_addr; // 배송지
	private int price;		  // 가격
	private int del;		  // 삭제여부
	
	public OrderDto() {}

	public OrderDto(int seq, String id, String add_req, String odate, String deli_addr, int price) {
		super();
		this.seq = seq;
		this.id = id;
		this.add_req = add_req;
		this.odate = odate;
		this.deli_addr = deli_addr;
		this.price = price;
	}
	

	public OrderDto(int seq, String id, String add_req, String odate, String deli_addr, int price, int del) {
		super();
		this.seq = seq;
		this.id = id;
		this.add_req = add_req;
		this.odate = odate;
		this.deli_addr = deli_addr;
		this.price = price;
		this.del = del;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAdd_req() {
		return add_req;
	}

	public void setAdd_req(String add_req) {
		this.add_req = add_req;
	}

	public String getOdate() {
		return odate;
	}

	public void setOdate(String odate) {
		this.odate = odate;
	}

	public String getDeli_addr() {
		return deli_addr;
	}

	public void setDeli_addr(String deli_addr) {
		this.deli_addr = deli_addr;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}
	

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	@Override
	public String toString() {
		return "OrderDto [seq=" + seq + ", id=" + id + ", add_req=" + add_req + ", odate=" + odate + ", deli_addr="
				+ deli_addr + ", price=" + price + ", del=" + del + "]";
	}

	

	
	
}

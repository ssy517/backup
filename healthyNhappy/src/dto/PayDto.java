package dto;

import java.io.Serializable;

public class PayDto implements Serializable {
	/*
	 CREATE TABLE PAY_INFO
	(
    PAY_ORDER_SEQ NUMBER(8),
    PAY_DATE DATE NOT NULL,
    PAY_MONEY NUMBER(10) 
    );
	 */
	
	private int seq;		 // 주문 번호
	private String odate;	 // 주문 일자
	private int cost;	     // 주문 가격
	
	
	public PayDto() {}

	
	
	public PayDto(int seq, String odate, int cost) {
		super();
		this.seq = seq;
		this.odate = odate;
		this.cost = cost;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getOdate() {
		return odate;
	}

	public void setOdate(String odate) {
		this.odate = odate;
	}

	public int getCost() {
		return cost;
	}

	public void setCost(int cost) {
		this.cost = cost;
	}

	@Override
	public String toString() {
		return "PayDto [seq=" + seq + ", odate=" + odate + ", cost=" + cost + "]";
	}
	
}

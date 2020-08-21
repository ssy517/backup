package dto;

import java.io.Serializable;

public class CartDto implements Serializable {

	/*
	CREATE TABLE CART_PRD
	(
	CART_ID VARCHAR2(50),
    CART_PRD_NUM NUMBER(8),
    CART_AMOUNT NUMBER(8) NOT NULL,
    CART_PRICE NUMBER(10) NOT NULL,
    CART_ORDER_SEQ NUMBER(8)
    ); 
	 
	 */
	private String id;		  // 주문자 id
	private int prd_num;	  // 상품 번호
	private int amount;		  // 주문 갯수
	private int price;		  // 가격
	private int order_seq;	      // 주문 번호
	
	public CartDto(String id, int prd_num, int amount, int price, int order_seq) {
		super();
		this.id = id;
		this.prd_num = prd_num;
		this.amount = amount;
		this.price = price;
		this.order_seq = order_seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getPrd_num() {
		return prd_num;
	}

	public void setPrd_num(int prd_num) {
		this.prd_num = prd_num;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getOrder_seq() {
		return order_seq;
	}

	public void setOrder_seq(int order_seq) {
		this.order_seq = order_seq;
	}

	@Override
	public String toString() {
		return "CartDto [id=" + id + ", prd_num=" + prd_num + ", amount=" + amount + ", price=" + price + ", order_seq="
				+ order_seq + "]";
	}
	
	
	
}

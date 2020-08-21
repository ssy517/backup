package dto;

import java.io.Serializable;

public class ProductDto implements Serializable {
	
	/*
    CREATE TABLE PRODUCT
(
    PRD_NUM NUMBER(8) PRIMARY KEY,
    PRD_NAME VARCHAR2(50) NOT NULL,
    PRD_PRICE NUMBER(10) NOT NULL,
    PRD_IMG_NAME VARCHAR2(30) NOT NULL,
    PRD_INFO VARCHAR2(500) NOT NULL,
    PRD_DELIVERY_PRICE NUMBER(6) UNIQUE,
    PRD_SIZE VARCHAR2(50) NOT NULL,
    PRD_ORIGIN VARCHAR2(50) NOT NULL,
    PRD_EXPDATE VARCHAR2(50) NOT NULL,
    PRD_KEEP VARCHAR2(100) NOT NULL,
    PRD_PACK VARCHAR2(100) NOT NULL,
    PRD_AMOUNT NUMBER(8) NOT NULL,
    PRD_SELL NUMBER(8) NOT NULL,
    PRD_DEL NUMBER(8) NOT NULL
    );
	 */
	
	
	private int prd_num; 	    // 상품 번호
	private String name; 		// 상품 이름
	private int price; 			// 상품 가격
	private String img_name; 	// 상품 이미지 파일 이름 
	private String info; 		// 상품 설명
	private int deli_charge; 	// 배송비
	private String size; 		// 규격
	private String origin; 		// 원산지
	private String expdate;		// 유통기한
	private String keep; 		// 보관 방법
	private String pack; 		// 포장 상태
	private int amount;			// 재고
	private int sell;			// 판매량
	private int del;			// 삭제여부
	
	
	
	public ProductDto() {}



	public ProductDto(int prd_num, String name, int price, String img_name, String info, int deli_charge, String size,
			String origin, String expdate, String keep, String pack) {
		super();
		this.prd_num = prd_num;
		this.name = name;
		this.price = price;
		this.img_name = img_name;
		this.info = info;
		this.deli_charge = deli_charge;
		this.size = size;
		this.origin = origin;
		this.expdate = expdate;
		this.keep = keep;
		this.pack = pack;
	}


	public ProductDto(int prd_num, String name, int price, String img_name, String info, int deli_charge, String size,
			String origin, String expdate, String keep, String pack, int amount, int sell, int del) {
		super();
		this.prd_num = prd_num;
		this.name = name;
		this.price = price;
		this.img_name = img_name;
		this.info = info;
		this.deli_charge = deli_charge;
		this.size = size;
		this.origin = origin;
		this.expdate = expdate;
		this.keep = keep;
		this.pack = pack;
		this.amount = amount;
		this.sell = sell;
		this.del = del;
	}



	public int getPrd_num() {
		return prd_num;
	}



	public void setPrd_num(int prd_num) {
		this.prd_num = prd_num;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public int getPrice() {
		return price;
	}



	public void setPrice(int price) {
		this.price = price;
	}



	public String getImg_name() {
		return img_name;
	}



	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}



	public String getInfo() {
		return info;
	}



	public void setInfo(String info) {
		this.info = info;
	}



	public int getDeli_charge() {
		return deli_charge;
	}



	public void setDeli_charge(int deli_charge) {
		this.deli_charge = deli_charge;
	}



	public String getSize() {
		return size;
	}



	public void setSize(String size) {
		this.size = size;
	}



	public String getOrigin() {
		return origin;
	}



	public void setOrigin(String origin) {
		this.origin = origin;
	}



	public String getExpdate() {
		return expdate;
	}



	public void setExpdate(String expdate) {
		this.expdate = expdate;
	}



	public String getKeep() {
		return keep;
	}



	public void setKeep(String keep) {
		this.keep = keep;
	}



	public String getPack() {
		return pack;
	}



	public void setPack(String pack) {
		this.pack = pack;
	}


	

	public int getAmount() {
		return amount;
	}



	public void setAmount(int amount) {
		this.amount = amount;
	}



	public int getSell() {
		return sell;
	}



	public void setSell(int sell) {
		this.sell = sell;
	}



	public int getDel() {
		return del;
	}



	public void setDel(int del) {
		this.del = del;
	}



	@Override
	public String toString() {
		return "ProductDto [prd_num=" + prd_num + ", name=" + name + ", price=" + price + ", img_name=" + img_name
				+ ", info=" + info + ", deli_charge=" + deli_charge + ", size=" + size + ", origin=" + origin
				+ ", expdate=" + expdate + ", keep=" + keep + ", pack=" + pack + ", amount=" + amount + ", sell=" + sell
				+ ", del=" + del + "]";
	}


	
	
}

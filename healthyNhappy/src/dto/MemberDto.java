package dto;

import java.io.Serializable;

public class MemberDto implements Serializable {

	/*
	 CREATE TABLE MEMBER
	(
	ID VARCHAR2(50) PRIMARY KEY,
	PWD VARCHAR2(50) NOT NULL,
	NAME VARCHAR2(50) NOT NULL,
	ADDRESS VARCHAR2(50) NOT NULL,
	PHONE VARCHAR2(50) NOT NULL,
	EMAIL VARCHAR2(50)UNIQUE,
	AUTH NUMBER(1) NOT NULL
	    ); 
	 */
	
	private String id; 		// 회원 id
	private String pwd;	 	// 회원 비밀번호
	private String name; 	// 회원 이름
	private String address; // 회원 주소
	private String phone; 	// 회원 전화번호
	private String email; 	// 회원 이메일
	private int auth; 		// 관리자 권한 0(사용자), 1(관리자), 2(탈퇴한 회원)
	


	public MemberDto(String id, String name, String address, String phone, String email) {
		this.id = id;
		this.name = name;
		this.address = address;
		this.phone = phone;
		this.email = email;
	}

	public MemberDto(String id, String pwd, String name, String address, String phone, String email, int auth) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.address = address;
		this.phone = phone;
		this.email = email;
		this.auth = auth;
	}

	public MemberDto() {
		// TODO Auto-generated constructor stub
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth;
	}

	@Override
	public String toString() {
		return "MemberDto [id=" + id + ", pwd=" + pwd + ", name=" + name + ", address=" + address + ", phone=" + phone
				+ ", email=" + email + ", auth=" + auth + "]";
	}
	
	
	
}

package dto;

import java.io.Serializable;

public class ReviewBbsDto implements Serializable {
	
	/*
	CREATE TABLE REV_BOARD
	(
    REV_SEQ NUMBER(8) NOT NULL,
    REV_ID VARCHAR2(50) NOT NULL,
    REV_TITLE VARCHAR2(50)NOT NULL,
    REV_CONTENT VARCHAR2(2000) NOT NULL,
    REV_SCORE NUMBER(8) NOT NULL,
    REV_FILENAME VARCHAR2(50),
    REV_WDATE DATE NOT NULL,  
    REV_DEL NUMBER(2) NOT NULL,
    REV_PRD_NUM NUMBER(8)
    );  
	 */
	
	private int seq;		// 글번호
	private String id;  	// 작성자 id
	private String title;	// 글제목
	private String content; // 글내용
	private int score;		// 평점
	private String filename;// 파일이름
	private String wdate;	// 작성일
	private int del;		// 삭제 x : 0, 삭제 o : 1
	private int prd_num;	// 상품번호
	
	
	public ReviewBbsDto() {}


	public ReviewBbsDto(int seq, String id, String title, String content, int score, String filename, String wdate,
			int del, int prd_num) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.score = score;
		this.filename = filename;
		this.wdate = wdate;
		this.del = del;
		this.prd_num = prd_num;
	}
	
	public ReviewBbsDto(String id, String title, String content, int score, String filename, int prd_num) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		this.score = score;
		this.filename = filename;
		this.prd_num = prd_num;
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


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public int getScore() {
		return score;
	}


	public void setScore(int score) {
		this.score = score;
	}


	public String getFilename() {
		return filename;
	}


	public void setFilename(String filename) {
		this.filename = filename;
	}


	public String getWdate() {
		return wdate;
	}


	public void setWdate(String wdate) {
		this.wdate = wdate;
	}


	public int getDel() {
		return del;
	}


	public void setDel(int del) {
		this.del = del;
	}


	public int getPrd_num() {
		return prd_num;
	}


	public void setPrd_num(int prd_num) {
		this.prd_num = prd_num;
	}


	@Override
	public String toString() {
		return "ReviewBbsDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", score="
				+ score + ", filename=" + filename + ", wdate=" + wdate + ", del=" + del + ", prd_num=" + prd_num + "]";
	}

	

	}
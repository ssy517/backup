package dto;

import java.io.Serializable;

public class WbBbsDto implements Serializable {
	
	/*
	CREATE TABLE WELL_BOARD
	(
    WB_SEQ NUMBER(8) NOT NULL,
    WB_ID VARCHAR2(50),
    WB_TITLE VARCHAR2(100)NOT NULL,
    WB_CONTENT VARCHAR2(2000) NOT NULL,
    WB_WDATE DATE NOT NULL,
    WB_READCOUNT NUMBER(8) NOT NULL,
    WB_DEL NUMBER(2) NOT NULL
    ); 
	 */
	
	private int seq;		// 글번호
	private String id;  	// 작성자 id
	private String title;	// 글제목
	private String content; // 글내용
	private String wdate;	// 작성일
	private int readCount;	// 조회수
	private int del;		// 삭제 x : 0, 삭제 o : 1
	
	
	public WbBbsDto() {}


	public WbBbsDto(int seq, String id, String title, String content, String wdate, int readCount, int del) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.wdate = wdate;
		this.readCount = readCount;
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


	public String getWdate() {
		return wdate;
	}


	public void setWdate(String wdate) {
		this.wdate = wdate;
	}


	public int getReadCount() {
		return readCount;
	}


	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}


	public int getDel() {
		return del;
	}


	public void setDel(int del) {
		this.del = del;
	}


	@Override
	public String toString() {
		return "WbBbsDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", wdate=" + wdate
				+ ", readCount=" + readCount + ", del=" + del + "]";
	}
	
	
	
	
	
	
	
}
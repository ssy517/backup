package dto;

import java.io.Serializable;

public class QnaBbsDto implements Serializable {

	
	/*
	CREATE TABLE QNA_ANS(

	QNA_ANS_SEQ NUMBER(8) NOT NULL,
	QNA_ANS_ID VARCHAR2(50) NOT NULL,
	QNA_ANS_CONTENT VARCHAR2(1000) NOT NULL,
	QNA_ANS_WDATE DATE NOT NULL,
	QNA_ANS_REF NUMBER(8) NOT NULL,
	QNA_ANS_DEL NUMBER(1) NOT NULL
	);
	 
	 */
	private int seq;			// 글번호
	private String id;			// 작성자 id
	private String title;		// 글제목
	private String content;		// 글내용
	private String wdate;		// 작성일
	private String filename;	// 파일 이름
	private int del;			// 삭제 x : 0, 삭제 o : 1
	private int readcount;		// 조회수
	private int open; 			// 공개 : 0, 비공개 : 1
	private int status;			// 답변대기 : 0, 답변완료 : 1
	
	public QnaBbsDto() {}

	public QnaBbsDto(int seq, String id, String title, String content, String wdate, String filename, int del,
			int readcount, int open, int status) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.wdate = wdate;
		this.filename = filename;
		this.del = del;
		this.readcount = readcount;
		this.open = open;
		this.status = status;
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

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public int getOpen() {
		return open;
	}

	public void setOpen(int open) {
		this.open = open;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "QnaBbsDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", wdate=" + wdate
				+ ", filename=" + filename + ", del=" + del + ", readcount=" + readcount + ", open=" + open
				+ ", status=" + status + "]";
	}

	
	




	
	
	
	
	
}

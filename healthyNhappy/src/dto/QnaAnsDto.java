package dto;

import java.io.Serializable;

public class QnaAnsDto implements Serializable {
	
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
	
	
	
	
	private int seq;				// 답변 번호
	private String id;				// 관리자 id
	private String content;			// 답변 내용
	private String wdate;			// 작성일자
	private int ref;				// 질문게시물 번호
	private int del;				// 삭제z : 0, 삭제o :1
	
	public QnaAnsDto() {}

	public QnaAnsDto(int seq, String id, String content, String wdate, int ref, int del) {
		super();
		this.seq = seq;
		this.id = id;
		this.content = content;
		this.wdate = wdate;
		this.ref = ref;
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

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	@Override
	public String toString() {
		return "QnaAnsDto [seq=" + seq + ", id=" + id + ", content=" + content + ", wdate=" + wdate + ", ref=" + ref
				+ ", del=" + del + "]";
	}
	
	
	
}

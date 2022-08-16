package kr.or.ddit.dto;

import java.util.Date;
import java.util.List;


public class PdsVO {
	private int lCode;
	private String title;
	private String content;
	private int viewCnt;
	private Date regDate;
	private Date updateDate;
	private String writer;

	private List<AttachVO> attachList;

	public List<AttachVO> getAttachList() {
		return attachList;
	}
	public void setAttachList(List<AttachVO> attachList) {
		this.attachList = attachList;
	}
	public int getlCode() {
		return lCode;
	}
	public void setlCode(int lCode) {
		this.lCode = lCode;
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
	public int getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}


	@Override
	public String toString() {
		return "PdsVO [lCode=" + lCode + ", title=" + title + ", content=" + content + ", viewCnt=" + viewCnt
				+ ", regDate=" + regDate + ", updateDate=" + updateDate + ", writer=" + writer + "]";
	}


}

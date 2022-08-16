package kr.or.ddit.dto;

import java.util.Date;

public class TecounseltVO {
	
	private int counCode;
	private Date regdate;
	private Date meetdate;
	private String content;
	private String result;
	private String purpose;
	private String status;
	private String counselor;
	private String client;
	private Date conStart;
	private Date conEnd;
	private String title;
	private String name;
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCounCode() {
		return counCode;
	}
	public void setCounCode(int counCode) {
		this.counCode = counCode;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public Date getMeetdate() {
		return meetdate;
	}
	public void setMeetdate(Date meetdate) {
		this.meetdate = meetdate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCounselor() {
		return counselor;
	}
	public void setCounselor(String counselor) {
		this.counselor = counselor;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public Date getConStart() {
		return conStart;
	}
	public void setConStart(Date conStart) {
		this.conStart = conStart;
	}
	public Date getConEnd() {
		return conEnd;
	}
	public void setConEnd(Date conEnd) {
		this.conEnd = conEnd;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}

}

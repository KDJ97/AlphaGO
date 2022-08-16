package kr.or.ddit.dto;

import java.io.Serializable;
import java.util.Date;

@SuppressWarnings("serial")
public class CalendarVO implements Serializable{

	private String pcCode;
	private String title;
	private Date pcStart;
	private Date pcEnd;
	private String counselor;
	private String name;
	private boolean allDay = false;
	
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCounselor() {
		return counselor;
	}
	public void setCounselor(String counselor) {
		this.counselor = counselor;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public boolean isAllDay() {
		return allDay;
	}
	public void setAllDay(boolean allDay) {
		this.allDay = allDay;
	}
	public String getPcCode() {
		return pcCode;
	}
	public void setPcCode(String pcCode) {
		this.pcCode = pcCode;
	}
	public Date getPcStart() {
		return pcStart;
	}
	public void setPcStart(Date pcStart) {
		this.pcStart = pcStart;
	}
	public Date getPcEnd() {
		return pcEnd;
	}
	public void setPcEnd(Date pcEnd) {
		this.pcEnd = pcEnd;
	}

	
	
}

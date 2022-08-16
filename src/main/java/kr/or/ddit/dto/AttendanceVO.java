package kr.or.ddit.dto;

import java.util.Date;

public class AttendanceVO {
	private int attendanceCode;
	private Date inTime;
	private Date outTime;
	private String id;
	private int attendanceStatus;
	private String reason;
	private Date regDate;

	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public int getAttendanceCode() {
		return attendanceCode;
	}
	public void setAttendanceCode(int attendanceCode) {
		this.attendanceCode = attendanceCode;
	}
	public Date getInTime() {
		return inTime;
	}
	public void setInTime(Date inTime) {
		this.inTime = inTime;
	}
	public Date getOutTime() {
		return outTime;
	}
	public void setOutTime(Date outTime) {
		this.outTime = outTime;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getAttendanceStatus() {
		return attendanceStatus;
	}
	public void setAttendanceStatus(int attendanceStatus) {
		this.attendanceStatus = attendanceStatus;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	@Override
	public String toString() {
		return "AttendanceVO [attendanceCode=" + attendanceCode + ", inTime=" + inTime + ", outTime=" + outTime
				+ ", id=" + id + ", attendanceStatus=" + attendanceStatus + ", reason=" + reason + ", regDate="
				+ regDate + "]";
	}





}

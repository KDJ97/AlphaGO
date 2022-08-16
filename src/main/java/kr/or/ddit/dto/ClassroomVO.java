package kr.or.ddit.dto;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

@SuppressWarnings("serial")
public class ClassroomVO implements Serializable{
	private String roomCode;
	private String capacity;
	private String roomFloor;
	private String roomNo;
	private String usePurpose;
	private String timeCode;
	private String classday;
	private String ctperiod;
	private String classCode;
	private String startDate;
	private String endDate;
	private String startTime;
	private String endTime;
	private String picture;
	private String totalTime;
	private String fxtcode;
	
	public String getFxtcode() {
		return fxtcode;
	}
	public void setFxtcode(String fxtcode) {
		this.fxtcode = fxtcode;
	}
	public String getTotalTime() {
		return totalTime;
	}
	public void setTotalTime(String totalTime) {
		this.totalTime = totalTime;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public String getTimeCode() {
		return timeCode;
	}
	public void setTimeCode(String timeCode) {
		this.timeCode = timeCode;
	}
	public String getClassday() {
		return classday;
	}
	public void setClassday(String classday) {
		this.classday = classday;
	}
	public String getCtperiod() {
		return ctperiod;
	}
	public void setCtperiod(String ctperiod) {
		this.ctperiod = ctperiod;
	}
	public String getClassCode() {
		return classCode;
	}
	public void setClassCode(String classCode) {
		this.classCode = classCode;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getCapacity() {
		return capacity;
	}
	public void setCapacity(String capacity) {
		this.capacity = capacity;
	}
	public String getRoomCode() {
		return roomCode;
	}
	public void setRoomCode(String roomCode) {
		this.roomCode = roomCode;
	}
	public String getRoomFloor() {
		return roomFloor;
	}
	public void setRoomFloor(String roomFloor) {
		this.roomFloor = roomFloor;
	}
	public String getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(String roomNo) {
		this.roomNo = roomNo;
	}
	public String getUsePurpose() {
		return usePurpose;
	}
	public void setUsePurpose(String usePurpose) {
		this.usePurpose = usePurpose;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
	
}

package kr.or.ddit.command;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.dto.ClassroomVO;


@SuppressWarnings("serial")
public class ClassroomModifyCommand implements Serializable{

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
	private String fx1;
	private String fx2;
	private String fx3;
	private String fx4;
	private String fx5;
	private String fx6;
	
	
	private MultipartFile picture;
	private String uploadPicture;
	
	
	
	public String getRoomCode() {
		return roomCode;
	}
	public void setRoomCode(String roomCode) {
		this.roomCode = roomCode;
	}
	public String getCapacity() {
		return capacity;
	}
	public void setCapacity(String capacity) {
		this.capacity = capacity;
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
	public String getFx1() {
		return fx1;
	}
	public void setFx1(String fx1) {
		this.fx1 = fx1;
	}
	public String getFx2() {
		return fx2;
	}
	public void setFx2(String fx2) {
		this.fx2 = fx2;
	}
	public String getFx3() {
		return fx3;
	}
	public void setFx3(String fx3) {
		this.fx3 = fx3;
	}
	public String getFx4() {
		return fx4;
	}
	public void setFx4(String fx4) {
		this.fx4 = fx4;
	}
	public String getFx5() {
		return fx5;
	}
	public void setFx5(String fx5) {
		this.fx5 = fx5;
	}
	public String getFx6() {
		return fx6;
	}
	public void setFx6(String fx6) {
		this.fx6 = fx6;
	}
	public MultipartFile getPicture() {
		return picture;
	}
	public void setPicture(MultipartFile picture) {
		this.picture = picture;
	}
	public String getUploadPicture() {
		return uploadPicture;
	}
	public void setUploadPicture(String uploadPicture) {
		this.uploadPicture = uploadPicture;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
	
	
	public ClassroomVO toRoomVO() {
		ClassroomVO room = new ClassroomVO();
		room.setRoomCode(this.roomCode);
		room.setRoomNo(this.roomNo);
		room.setCapacity(this.capacity);
		room.setUsePurpose(this.usePurpose);
		String roomFloor = this.roomNo.substring(0, 1);
		room.setRoomFloor(roomFloor);
		return room;
	}
	
}

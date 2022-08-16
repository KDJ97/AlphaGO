package kr.or.ddit.command;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import kr.or.ddit.dto.TeachermasVO;

@SuppressWarnings("serial")
public class TeacherRegistCommand implements Serializable{
	
	
	
	
	private String id;
	
	private String picture;
	
	
    private String subject;
    
    private String name;
    
    private String []phone;
    
    private String attendTime;
    private String outTimes;
    
    private String authority;
    
    private String timepay;
    
    
    private String address;
	private String detailAddress;
	
	 private String captureView;
    
    
    
	
	public String getCaptureView() {
		return captureView;
	}
	public void setCaptureView(String captureView) {
		this.captureView = captureView;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	public String getTimepay() {
		return timepay;
	}
	public void setTimepay(String timepay) {
		this.timepay = timepay;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String[] getPhone() {
		return phone;
	}
	public void setPhone(String[] phone) {
		this.phone = phone;
	}
	
    
	
	public String getAttendTime() {
		return attendTime;
	}
	public void setAttendTime(String attendTime) {
		this.attendTime = attendTime;
	}
	
	
	public String getOutTimes() {
		return outTimes;
	}
	public void setOutTimes(String outTimes) {
		this.outTimes = outTimes;
	}
	
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.JSON_STYLE);
	}
	

	public TeachermasVO toTeachermasVO() {
		
		 String phone = "";
			
			for (String data : this.phone) {
				phone += data;
			}
			if (phone.length() == 11) {
				// 010-1234-1234
				phone = phone.substring(0, 3) + "-" +phone.substring(3, 7) + "-" + phone.substring(7);

			} 
			
			TeachermasVO teamas=new TeachermasVO();
			
			teamas.setId(id);
			teamas.setPicture(picture);
			teamas.setSubject(subject);
			teamas.setName(name);
			teamas.setPhone(phone);
			teamas.setAttendTime(attendTime);
			teamas.setOutTimes(outTimes);
			teamas.setRegDate(new Date());
			teamas.setAuthority(authority);
			teamas.setTimepay(timepay);
			teamas.setAddress(address);
			teamas.setDetailAddress(detailAddress);
			teamas.setCaptureView(this.captureView);
			
			return teamas;
	}
    
}

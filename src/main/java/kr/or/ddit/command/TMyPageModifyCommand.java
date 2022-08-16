package kr.or.ddit.command;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import kr.or.ddit.dto.MemberVO;

@SuppressWarnings("serial")
public class TMyPageModifyCommand implements Serializable {

	private String pwd;
	private String[] phone;
	private String[] email;
	private String picture;
	private String address;
	private String detailAddress;
	
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
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
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String[] getPhone() {
		return phone;
	}
	public void setPhone(String[] phone) {
		this.phone = phone;
	}
	public String[] getEmail() {
		return email;
	}
	public void setEmail(String[] email) {
		this.email = email;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.JSON_STYLE);
	}
	
	public MemberVO toMemberVO() {
		
		String phone ="";
		for(String data : this.phone) {
			phone += data;
		}
		if(phone.length() == 11) {
			phone = phone.substring(0, 3) + "-" +phone.substring(3, 7) + "-" + phone.substring(7);
		}
		
		String email = "";
		email = this.email[0]+ "@" + this.email[1];
		
		MemberVO member = new MemberVO();
		
		member.setEmail(email);
		member.setPhone(phone);
		member.setPwd(this.pwd);
		member.setAddress(this.address);
		member.setDetailAddress(this.detailAddress);
		member.setPicture(this.picture);
		
		return member;
	}
	
}

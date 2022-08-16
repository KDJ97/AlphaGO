package kr.or.ddit.dto;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;


@SuppressWarnings("serial")
public class SchoolVO implements Serializable{

	private String schoolCode;		// 학교 코드
	private String schoolName;		// 학교명
	private String schoolRank;		// 학교수준
	private String schoolUrl;		// 학교홈페이지 URL
	private String schoolGender;	// 학교 남녀 구분
	private String schoolAddress;	// 학교 주소

	private String cnt;				// 학원내 원생 학교 수
	private String schoolPercent;	// 학원내 원생 학교 분포율
	
	
	
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getSchoolPercent() {
		return schoolPercent;
	}
	public void setSchoolPercent(String schoolPercent) {
		this.schoolPercent = schoolPercent;
	}
	public String getSchoolCode() {
		return schoolCode;
	}
	public void setSchoolCode(String schoolCode) {
		this.schoolCode = schoolCode;
	}
	public String getSchoolName() {
		return schoolName;
	}
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	public String getSchoolRank() {
		return schoolRank;
	}
	public void setSchoolRank(String schoolRank) {
		this.schoolRank = schoolRank;
	}
	public String getSchoolUrl() {
		return schoolUrl;
	}
	public void setSchoolUrl(String schoolUrl) {
		this.schoolUrl = schoolUrl;
	}
	public String getSchoolGender() {
		return schoolGender;
	}
	public void setSchoolGender(String schoolGender) {
		this.schoolGender = schoolGender;
	}
	public String getSchoolAddress() {
		return schoolAddress;
	}
	public void setSchoolAddress(String schoolAddress) {
		this.schoolAddress = schoolAddress;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
	
}

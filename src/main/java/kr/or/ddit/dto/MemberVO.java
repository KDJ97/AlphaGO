package kr.or.ddit.dto;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

@SuppressWarnings("serial")
public class MemberVO implements Serializable{

	
	private String id;
	private String name;
	private Date regDate;
	private String pwd;
	private String email;
	private String picture;
	private String phone;
	private String address;
	private String authority;
	private int enabled;
	private String parentPhone;
	private int age;
	private String grade;
	private int schoolCode;
	private String register;
	private String subject;
	private String major;
	private String schoolName;
	private String detailAddress;
	private String fuUni;
	private String suUni;
	private String tuUni;
	private String parentName;
	
	
	
	private String status;
	private String timepay;//시급
	private int assignCode;
	private double reviewScore;//담당 수업 전체 평균 후기점수
	private double assignAttachPercent;//수강 수업 과제 제출율
	private double scoreAvg;//점수평균
	private double acheive;//과제, 시험 성취도
	private String totalAcheive;//과제와 시험의 성취도를 연산해 최종 수업 성취도를 나타내는 컬럼(90이상 : A, 80이상:B, 나머지 :C)
	
	
	
	
	
	
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	public String getTimepay() {
		return timepay;
	}
	public void setTimepay(String timepay) {
		this.timepay = timepay;
	}
	public String getTotalAcheive() {
		return totalAcheive;
	}
	public void setTotalAcheive(String totalAcheive) {
		this.totalAcheive = totalAcheive;
	}
	public double getAcheive() {
		return acheive;
	}
	public void setAcheive(double acheive) {
		this.acheive = acheive;
	}
	public double getScoreAvg() {
		return scoreAvg;
	}
	public void setScoreAvg(double scoreAvg) {
		this.scoreAvg = scoreAvg;
	}
	public double getAssignAttachPercent() {
		return assignAttachPercent;
	}
	public void setAssignAttachPercent(double assignAttachPercent) {
		this.assignAttachPercent = assignAttachPercent;
	}
	public double getReviewScore() {
		return reviewScore;
	}
	public void setReviewScore(double reviewScore) {
		this.reviewScore = reviewScore;
	}
	public int getAssignCode() {
		return assignCode;
	}
	public void setAssignCode(int assignCode) {
		this.assignCode = assignCode;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getFuUni() {
		return fuUni;
	}
	public void setFuUni(String fuUni) {
		this.fuUni = fuUni;
	}
	public String getSuUni() {
		return suUni;
	}
	public void setSuUni(String suUni) {
		this.suUni = suUni;
	}
	public String getTuUni() {
		return tuUni;
	}
	public void setTuUni(String tuUni) {
		this.tuUni = tuUni;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	public String getParentPhone() {
		return parentPhone;
	}
	public void setParentPhone(String parentPhone) {
		this.parentPhone = parentPhone;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public int getSchoolCode() {
		return schoolCode;
	}
	public void setSchoolCode(int schoolCode) {
		this.schoolCode = schoolCode;
	}
	public String getRegister() {
		return register;
	}
	public void setRegister(String register) {
		this.register = register;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getSchoolName() {
		return schoolName;
	}
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
}

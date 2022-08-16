package kr.or.ddit.dto;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.fasterxml.jackson.annotation.JsonFormat;

@SuppressWarnings("serial")
public class PacounseltVO implements Serializable {

	private Integer pcCode;
	private String counSelor;
	private String client;
	private Date regDate;
	private Date meetDate;
	private String content;
	private String result;
	private String purpose;
	private String status;
	private String fuCode;
	private String suCode;
	private String tuCode;

	private String title;
	private String name;
	private String phone;
	private String grade;
	private String schoolName;
	private String parentPhone;
	private String universityName;
	private String universityNames;
	private int universityKor;
	private int universityEng;
	private int universityMath;
	private int universitySocial;
	private int universityScience;
	private String myGrade;
	private String id;
	
	//성적 평균
	private double stuavg;
	

	// @JsonFormat(pattern = "HH:mm:ss", timezone = "Asia/Seoul")

	
	private Date pcStart;

	// @JsonFormat(pattern = "HH:mm:ss", timezone = "Asia/Seoul")

	public double getStuavg() {
		return stuavg;
	}

	public void setStuavg(double stuavg) {
		this.stuavg = stuavg;
	}

	private Date pcEnd;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getMyGrade() {
		return myGrade;
	}

	public void setMyGrade(String myGrade) {
		this.myGrade = myGrade;
	}

	public int getUniversityKor() {
		return universityKor;
	}

	public void setUniversityKor(int universityKor) {
		this.universityKor = universityKor;
	}

	public int getUniversityEng() {
		return universityEng;
	}

	public void setUniversityEng(int universityEng) {
		this.universityEng = universityEng;
	}

	public int getUniversityMath() {
		return universityMath;
	}

	public void setUniversityMath(int universityMath) {
		this.universityMath = universityMath;
	}

	public int getUniversitySocial() {
		return universitySocial;
	}

	public void setUniversitySocial(int universitySocial) {
		this.universitySocial = universitySocial;
	}

	public int getUniversityScience() {
		return universityScience;
	}

	public void setUniversityScience(int universityScience) {
		this.universityScience = universityScience;
	}

	public String getUniversityNames() {
		return universityNames;
	}

	public void setUniversityNames(String universityNames) {
		this.universityNames = universityNames;
	}

	public String getUniversityName() {
		return universityName;
	}

	public void setUniversityName(String universityName) {
		this.universityName = universityName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getSchoolName() {
		return schoolName;
	}

	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	public String getParentPhone() {
		return parentPhone;
	}

	public void setParentPhone(String parentPhone) {
		this.parentPhone = parentPhone;
	}

	public Integer getPcCode() {
		return pcCode;
	}

	public void setPcCode(Integer pcCode) {
		this.pcCode = pcCode;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCounSelor() {
		return counSelor;
	}

	public void setCounSelor(String counSelor) {
		this.counSelor = counSelor;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public Date getMeetDate() {
		return meetDate;
	}

	public void setMeetDate(Date meetDate) {
		this.meetDate = meetDate;
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

	public String getFuCode() {
		return fuCode;
	}

	public void setFuCode(String fuCode) {
		this.fuCode = fuCode;
	}

	public String getSuCode() {
		return suCode;
	}

	public void setSuCode(String suCode) {
		this.suCode = suCode;
	}

	public String getTuCode() {
		return tuCode;
	}

	public void setTuCode(String tuCode) {
		this.tuCode = tuCode;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
}
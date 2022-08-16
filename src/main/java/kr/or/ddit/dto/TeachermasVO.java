package kr.or.ddit.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.Map;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.fasterxml.jackson.annotation.JsonFormat;

@SuppressWarnings("serial")
public class TeachermasVO implements Serializable {

	private String id;
	private String name;
	private Date regDate;

	private String picture;
	private String phone;
	private String attendTime;
	private String outTimes;
	private String birthday;
	private String subject;
	private Date inTime;
	private Date outTime;
	private String career;
	private String month;
	private int classCode;
	private String className;
	private String cacontent;
	
	
	// 1학기중간
	private int avg;
	// 1학기기말
	private int avg1;

	// 2학기중간
	private int avg2;

	// 2학기기말
	private int avg3;

	private String authority;

	private int myScore;
	private int subjectCode;
	private String subjectName;

	private int attendanceStatus;

	private String testName;

	// 수강후기 전체 별점
	private int avg4;

	// 수업이름에 따른 전체 별점
	private int avg5;
	
	//강사시급
	private String timepay;
	
	//수업시작시간
	private String startTime;
	
	//수업종료시간
	private String endTime;
	
	//경력시작
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy/MM/dd")
	private Date startDate;
	
	//경력끝날짜
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy/MM/dd")
	private Date endDate;

	
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

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getTimepay() {
		return timepay;
	}

	public void setTimepay(String timepay) {
		this.timepay = timepay;
	}

	public int getAvg5() {
		return avg5;
	}

	public void setAvg5(int avg5) {
		this.avg5 = avg5;
	}

	public int getAvg4() {
		return avg4;
	}

	public void setAvg4(int avg4) {
		this.avg4 = avg4;
	}

	public String getCacontent() {
		return cacontent;
	}

	public void setCacontent(String cacontent) {
		this.cacontent = cacontent;
	}

	private int starScore;
	private String content;

	public int getStarScore() {
		return starScore;
	}

	public void setStarScore(int starScore) {
		this.starScore = starScore;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getClassCode() {
		return classCode;
	}

	public void setClassCode(int classCode) {
		this.classCode = classCode;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getCareer() {
		return career;
	}

	public void setCareer(String career) {
		this.career = career;
	}

	public int getAvg1() {
		return avg1;
	}

	public void setAvg1(int avg1) {
		this.avg1 = avg1;
	}

	public int getAvg2() {
		return avg2;
	}

	public void setAvg2(int avg2) {
		this.avg2 = avg2;
	}

	public int getAvg3() {
		return avg3;
	}

	public void setAvg3(int avg3) {
		this.avg3 = avg3;
	}

	public int getAvg() {
		return avg;
	}

	public void setAvg(int avg) {
		this.avg = avg;
	}

	public String getTestName() {
		return testName;
	}

	public void setTestName(String testName) {
		this.testName = testName;
	}

	public Date getOutTime() {
		return outTime;
	}

	public void setOutTime(Date outTime) {
		this.outTime = outTime;
	}

	public Date getInTime() {
		return inTime;
	}

	public void setInTime(Date inTime) {
		this.inTime = inTime;
	}

	public int getAttendanceStatus() {
		return attendanceStatus;
	}

	public void setAttendanceStatus(int attendanceStatus) {
		this.attendanceStatus = attendanceStatus;
	}

	public int getMyScore() {
		return myScore;
	}

	public void setMyScore(int myScore) {
		this.myScore = myScore;
	}

	public int getSubjectCode() {
		return subjectCode;
	}

	public void setSubjectCode(int subjectCode) {
		this.subjectCode = subjectCode;
	}

	public String getSubjectName() {
		return subjectName;
	}

	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
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

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}

}

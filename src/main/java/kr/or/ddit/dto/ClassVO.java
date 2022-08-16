package kr.or.ddit.dto;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
@SuppressWarnings("serial")
public class ClassVO implements Serializable{

	private String classCode;		  //수업번호
	private String classRank;        //수업수준
	private String className;        //수업명
	private String id; 			      //교사ID
	private String roomCode;         //강의실코드
	private String cpno;              //강의계획서코드
	private String startDate;        //수업시작일
	private String endDate;          //수업종료일
	private String stuCnt;           //수강인원
	private String classPrice;       //수업료
	private String totalTime;        //시수
	private String classGrade;       //학년
	private String cpcheck;          //수업계획서승인상태

	private String subjectCode;	  //과목코드
	private String subjectName;	  //과목이름
	private String subdetailCode;    //세부과목분류코드
	private String subdetailName;    //세부과목 이름
	
	private String roomNo; // 강의실 호수
	private String name;   //강사 이름
	private int classday; // 요일
	
	private String mintime;//쓰레기값임
	private double starScore;
	private double avg5;
	private double avgPoint; //평균 수업후기 평점
	private int totalWeek; //수업의 총 주차수
	
	public int getTotalWeek() {
		return totalWeek;
	}
	public void setTotalWeek(int totalWeek) {
		this.totalWeek = totalWeek;
	}
	public double getAvg5() {
		return avg5;
	}
	public void setAvg5(double avg5) {
		this.avg5 = avg5;
	}
	public double getAvgPoint() {
		return avgPoint;
	}
	public void setAvgPoint(double avgPoint) {
		this.avgPoint = avgPoint;
	}
	public double getStarScore() {
		return starScore;
	}
	public void setStarScore(double starScore) {
		this.starScore = starScore;
	}
	public String getCpcheck() {
		return cpcheck;
	}
	public void setCpcheck(String cpcheck) {
		this.cpcheck = cpcheck;
	}
	public int getClassday() {
		return classday;
	}
	public void setClassday(int classday) {
		this.classday = classday;
	}
	public String getMintime() {
		return mintime;
	}
	public void setMintime(String mintime) {
		this.mintime = mintime;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(String roomNo) {
		this.roomNo = roomNo;
	}
	public String getClassCode() {
		return classCode;
	}
	public void setClassCode(String classCode) {
		this.classCode = classCode;
	}
	public String getClassRank() {
		return classRank;
	}
	public void setClassRank(String classRank) {
		this.classRank = classRank;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRoomCode() {
		return roomCode;
	}
	public void setRoomCode(String roomCode) {
		this.roomCode = roomCode;
	}
	public String getCpno() {
		return cpno;
	}
	public void setCpno(String cpno) {
		this.cpno = cpno;
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
	public String getStuCnt() {
		return stuCnt;
	}
	public void setStuCnt(String stuCnt) {
		this.stuCnt = stuCnt;
	}
	public String getClassPrice() {
		return classPrice;
	}
	public void setClassPrice(String classPrice) {
		this.classPrice = classPrice;
	}
	public String getTotalTime() {
		return totalTime;
	}
	public void setTotalTime(String totalTime) {
		this.totalTime = totalTime;
	}
	public String getClassGrade() {
		return classGrade;
	}
	public void setClassGrade(String classGrade) {
		this.classGrade = classGrade;
	}
	public String getSubjectCode() {
		return subjectCode;
	}
	public void setSubjectCode(String subjectCode) {
		this.subjectCode = subjectCode;
	}
	public String getSubjectName() {
		return subjectName;
	}
	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
	public String getSubdetailCode() {
		return subdetailCode;
	}
	public void setSubdetailCode(String subdetailCode) {
		this.subdetailCode = subdetailCode;
	}
	public String getSubdetailName() {
		return subdetailName;
	}
	public void setSubdetailName(String subdetailName) {
		this.subdetailName = subdetailName;
	}

	@Override
   public String toString() {
      return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
   }
	
}

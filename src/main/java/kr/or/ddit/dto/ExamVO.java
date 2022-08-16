package kr.or.ddit.dto;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

@SuppressWarnings("serial")
public class ExamVO implements Serializable{
	private int examCode;
	private String startDate;
	private String endDate;
	private String examName;
	private int classCode;
	private String className;
	private String id;
	private String achievement;
	
	//문제오답가져오기
	private double problemOdap;
	
	//시험본 학급의 등급
	private String classRank;	
	
	//시험본 세부과목이름
	private String subdetailName;
	
	//시험본 과목은 시작단원
	private String startDan;
	
	//시험본 과목의 끝단원
	private String endDan;
	
	//시험 평균
	private double average;
	
	//이름
	private String name;
	
	//학원성적
	private int acardemyScore;
	
   
	
	
	
	
	

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public int getAcardemyScore() {
		return acardemyScore;
	}
	public void setAcardemyScore(int acardemyScore) {
		this.acardemyScore = acardemyScore;
	}
	public double getAverage() {
		return average;
	}
	public void setAverage(double average) {
		this.average = average;
	}
	public String getSubdetailName() {
		return subdetailName;
	}
	public void setSubdetailName(String subdetailName) {
		this.subdetailName = subdetailName;
	}
	public String getStartDan() {
		return startDan;
	}
	public void setStartDan(String startDan) {
		this.startDan = startDan;
	}
	public String getEndDan() {
		return endDan;
	}
	public void setEndDan(String endDan) {
		this.endDan = endDan;
	}
	public String getAchievement() {
		return achievement;
	}
	public void setAchievement(String achievement) {
		this.achievement = achievement;
	}
	public String getClassRank() {
		return classRank;
	}
	public void setClassRank(String classRank) {
		this.classRank = classRank;
	}
	public double getProblemOdap() {
		return problemOdap;
	}
	public void setProblemOdap(double problemOdap) {
		this.problemOdap = problemOdap;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public int getExamCode() {
		return examCode;
	}
	public void setExamCode(int examCode) {
		this.examCode = examCode;
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
	public String getExamName() {
		return examName;
	}
	public void setExamName(String examName) {
		this.examName = examName;
	}
	public int getClassCode() {
		return classCode;
	}
	public void setClassCode(int classCode) {
		this.classCode = classCode;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
	
}

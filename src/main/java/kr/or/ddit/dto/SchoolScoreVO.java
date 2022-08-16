package kr.or.ddit.dto;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

@SuppressWarnings("serial")
public class SchoolScoreVO implements Serializable {
	private int sscode;
	private String id;
	private float myscore;
	private String mygrade;
	private float standardScore;
	private int schoolYear;
	private int schoolTerm;
	private int subjectCode;
	private Date regdate;
	private String achievement;
	private int rank;
	private int stucnt;
	private float perfectScore;
	private String testName;
	private String subjectName;
	private String schoolName;
	private String schoolCode;
	
	
	

	public String getSubjectName() {
		return subjectName;
	}
	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
	public String getSchoolName() {
		return schoolName;
	}
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	public String getSchoolCode() {
		return schoolCode;
	}
	public void setSchoolCode(String schoolCode) {
		this.schoolCode = schoolCode;
	}
	public int getSscode() {
		return sscode;
	}
	public void setSscode(int sscode) {
		this.sscode = sscode;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public float getMyscore() {
		return myscore;
	}
	public void setMyscore(float myscore) {
		this.myscore = myscore;
	}
	public String getMygrade() {
		return mygrade;
	}
	public void setMygrade(String mygrade) {
		this.mygrade = mygrade;
	}
	public float getStandardScore() {
		return standardScore;
	}
	public void setStandardScore(float standardScore) {
		this.standardScore = standardScore;
	}
	public int getSchoolYear() {
		return schoolYear;
	}
	public void setSchoolYear(int schoolYear) {
		this.schoolYear = schoolYear;
	}
	public int getSchoolTerm() {
		return schoolTerm;
	}
	public void setSchoolTerm(int schoolTerm) {
		this.schoolTerm = schoolTerm;
	}
	public int getSubjectCode() {
		return subjectCode;
	}
	public void setSubjectCode(int subjectCode) {
		this.subjectCode = subjectCode;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getAchievement() {
		return achievement;
	}
	public void setAchievement(String achievement) {
		this.achievement = achievement;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	public int getStucnt() {
		return stucnt;
	}
	public void setStucnt(int stucnt) {
		this.stucnt = stucnt;
	}
	public float getPerfectScore() {
		return perfectScore;
	}
	public void setPerfectScore(float perfectScore) {
		this.perfectScore = perfectScore;
	}
	public String getTestName() {
		return testName;
	}
	public void setTestName(String testName) {
		this.testName = testName;
	}

	@Override
	public String toString(){
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}


}

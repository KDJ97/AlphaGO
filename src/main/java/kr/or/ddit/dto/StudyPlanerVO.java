package kr.or.ddit.dto;

import java.io.Serializable;
import java.util.Date;

@SuppressWarnings("serial")
public class StudyPlanerVO implements Serializable{
	private int spCode;
	private String id;
	private Date regDate;
	private String feedback;
	private int studyTime;
	public int getSpCode() {
		return spCode;
	}
	public void setSpCode(int spCode) {
		this.spCode = spCode;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getFeedback() {
		return feedback;
	}
	public void setFeedback(String feedback) {
		this.feedback = feedback;
	}
	public int getStudyTime() {
		return studyTime;
	}
	public void setStudyTime(int studyTime) {
		this.studyTime = studyTime;
	}

	@Override
	public String toString() {
		return "StudyPlanerVO [spCode=" + spCode + ", id=" + id + ", regDate=" + regDate
				+ ", feedback=" + feedback + ", studyTime=" + studyTime + "]";
	}


}

package kr.or.ddit.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class SubjectVO {

	private String subjectCode;
	private String subdetailCode;
	private String subjectName;
	private String subdetailName;
	public String getSubjectCode() {
		return subjectCode;
	}
	public void setSubjectCode(String subjectCode) {
		this.subjectCode = subjectCode;
	}
	public String getSubdetailCode() {
		return subdetailCode;
	}
	public void setSubdetailCode(String subdetailCode) {
		this.subdetailCode = subdetailCode;
	}
	public String getSubjectName() {
		return subjectName;
	}
	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
	public String getSubdetailName() {
		return subdetailName;
	}
	public void setSubdetailName(String subdetailName) {
		this.subdetailName = subdetailName;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.JSON_STYLE);
	}
}

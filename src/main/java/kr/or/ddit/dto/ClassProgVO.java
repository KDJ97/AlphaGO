package kr.or.ddit.dto;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

@SuppressWarnings("serial")
public class ClassProgVO implements Serializable {
	int subjectProccess;
	int subjectSeq;
	int subdetailCode;
	String subunitName;

	public int getSubjectProccess() {
		return subjectProccess;
	}

	public void setSubjectProccess(int subjectProccess) {
		this.subjectProccess = subjectProccess;
	}

	public int getSubjectSeq() {
		return subjectSeq;
	}

	public void setSubjectSeq(int subjectSeq) {
		this.subjectSeq = subjectSeq;
	}

	public int getSubdetailCode() {
		return subdetailCode;
	}

	public void setSubdetailCode(int subdetailCode) {
		this.subdetailCode = subdetailCode;
	}

	public String getSubunitName() {
		return subunitName;
	}

	public void setSubunitName(String subunitName) {
		this.subunitName = subunitName;
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
}

package kr.or.ddit.command;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

@SuppressWarnings("serial")
public class PacounseltDateCommand implements Serializable{

	private String pcCode;
	private String regDate;
	private String meetDate;
	private String name;
	private String id;
	private String pcStart;
	private String pcEnd;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPcCode() {
		return pcCode;
	}
	public void setPcCode(String pcCode) {
		this.pcCode = pcCode;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getMeetDate() {
		return meetDate;
	}
	public void setMeetDate(String meetDate) {
		this.meetDate = meetDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPcStart() {
		return pcStart;
	}
	public void setPcStart(String pcStart) {
		this.pcStart = pcStart;
	}
	public String getPcEnd() {
		return pcEnd;
	}
	public void setPcEnd(String pcEnd) {
		this.pcEnd = pcEnd;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
}

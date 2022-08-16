package kr.or.ddit.dto;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

@SuppressWarnings("serial")
public class MemberCountVO implements Serializable{

	private String cntno;
	private String regdate;
	private String memcnt;
	
	public String getCntno() {
		return cntno;
	}
	public void setCntno(String cntno) {
		this.cntno = cntno;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getMemcnt() {
		return memcnt;
	}
	public void setMemcnt(String memcnt) {
		this.memcnt = memcnt;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
	
}

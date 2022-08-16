package kr.or.ddit.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class LboardVO {
	private int lcode;
	private String bcode;
	
	public int getLcode() {
		return lcode;
	}
	public void setLcode(int lcode) {
		this.lcode = lcode;
	}
	public String getBcode() {
		return bcode;
	}
	public void setBcode(String bcode) {
		this.bcode = bcode;
	}
	@Override
	public String toString(){
			return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
	
}

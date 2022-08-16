package kr.or.ddit.command;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

@SuppressWarnings("serial")
public class ProblemSearchCommand extends SearchCriteria implements Serializable{
	private String jimoon;
	private String selectgogo;
	
	
	
	public String getSelectgogo() {
		return selectgogo;
	}
	public void setSelectgogo(String selectgo) {
		this.selectgogo = selectgo;
	}
	public String getJimoon() {
		return jimoon;
	}
	public void setJimoon(String jimoon) {
		this.jimoon = jimoon;
	}
	
	
	@Override
	public String toString(){
			return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
}

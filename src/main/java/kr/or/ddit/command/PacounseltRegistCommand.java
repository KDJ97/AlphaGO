package kr.or.ddit.command;

import kr.or.ddit.dto.PacounseltVO;

public class PacounseltRegistCommand {
	
	private String content;
	private String result;
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	
	public PacounseltVO toPacounseltVO() {
		PacounseltVO pacoun=new PacounseltVO();
		
		pacoun.setContent(content);
		pacoun.setResult(result);
		
		return pacoun;
		
	}

}

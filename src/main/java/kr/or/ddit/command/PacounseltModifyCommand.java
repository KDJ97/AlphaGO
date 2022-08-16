package kr.or.ddit.command;

import kr.or.ddit.dto.PacounseltVO;

public class PacounseltModifyCommand extends PacounseltRegistCommand{
	
	private Integer pcCode;

	
	
	


	public Integer getPcCode() {
		return pcCode;
	}






	public void setPcCode(Integer pcCode) {
		this.pcCode = pcCode;
	}






	public PacounseltVO toPacounseltVO() {
		PacounseltVO pacoun=super.toPacounseltVO();
		pacoun.setPcCode(pcCode);
		
		return pacoun;
	}

}

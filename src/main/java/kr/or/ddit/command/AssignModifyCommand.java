package kr.or.ddit.command;

import kr.or.ddit.dto.AssignVO;

public class AssignModifyCommand extends AssignRegistCommand{
	private int assignCode;
	private String[] deleteFile;
	
	public int getAssignCode() {
		return assignCode;
	}
	public void setAssignCode(int assignCode) {
		this.assignCode = assignCode;
	}
	public String[] getDeleteFile() {
		return deleteFile;
	}
	public void setDeleteFile(String[] deleteFile) {
		this.deleteFile = deleteFile;
	}
	
	public AssignVO toAssignVO() {
		AssignVO assign = super.toAssignVO();
		
		return assign;
	}
}

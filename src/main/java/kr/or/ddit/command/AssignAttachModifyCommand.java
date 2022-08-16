package kr.or.ddit.command;

import kr.or.ddit.dto.AssignAttachVO;

public class AssignAttachModifyCommand extends AssignAttachRegistCommand{
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
	
	public AssignAttachVO toAssignAttachVO() {
		AssignAttachVO attach = super.toAssignAttachVO();

		return attach;
	}

}

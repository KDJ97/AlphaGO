package kr.or.ddit.command;

import kr.or.ddit.dto.PdsVO;

public class PdsModifyCommand extends PdsRegistCommand{
	private String lCode;
	private String[] deleteFile;
	public String getlCode() {
		return lCode;
	}
	public void setlCode(String lCode) {
		this.lCode = lCode;
	}
	public String[] getDeleteFile() {
		return deleteFile;
	}
	public void setDeleteFile(String[] deleteFile) {
		this.deleteFile = deleteFile;
	}

	@Override
	public PdsVO toPdsVO() {
		PdsVO pds = super.toPdsVO();
		pds.setlCode(Integer.parseInt(this.lCode));

		return pds;
	}

}

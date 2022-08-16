package kr.or.ddit.command;

import kr.or.ddit.dto.NoticeVO;

public class NoticeModifyCommand extends NoticeRegistCommand{
	private String lcode;
	private String[] deleteFile;
	public String getlCode() {
		return lcode;
	}
	public void setlCode(String lCode) {
		this.lcode = lCode;
	}
	public String[] getDeleteFile() {
		return deleteFile;
	}
	public void setDeleteFile(String[] deleteFile) {
		this.deleteFile = deleteFile;
	}

	@Override
	public NoticeVO toNoticeVO() {
		NoticeVO notice = super.toNoticeVO();
		notice.setLcode(Integer.parseInt(this.lcode));

		return notice;
	}

}

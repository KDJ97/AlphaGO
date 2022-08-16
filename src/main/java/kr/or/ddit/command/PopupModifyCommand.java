package kr.or.ddit.command;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import kr.or.ddit.command.PopupRegistCommand;
import kr.or.ddit.dto.PopupVO;

@SuppressWarnings("serial")
public class PopupModifyCommand extends PopupRegistCommand {

	private String attachno;
	private String[] deleteFile;
	
	
	public String getAttachno() {
		return attachno;
	}
	public void setAttachno(String attachno) {
		this.attachno = attachno;
	}
	public String[] getDeleteFile() {
		return deleteFile;
	}
	public void setDeleteFile(String[] deleteFile) {
		this.deleteFile = deleteFile;
	}
	
	@Override
	public PopupVO toPopupVO() {
		PopupVO popup = super.toPopupVO();

		return popup;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
}

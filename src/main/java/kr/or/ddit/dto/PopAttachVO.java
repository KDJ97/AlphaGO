package kr.or.ddit.dto;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

@SuppressWarnings("serial")
public class PopAttachVO implements Serializable{
	private String attachno;
	private String popcode;
	private String uploadpath;
	private String filename;
	private String filetype;
	private Date regdate;
	
	public String getAttachno() {
		return attachno;
	}
	public void setAttachno(String attachno) {
		this.attachno = attachno;
	}
	public String getPopcode() {
		return popcode;
	}
	public void setPopcode(String popcode) {
		this.popcode = popcode;
	}
	public String getUploadpath() {
		return uploadpath;
	}
	public void setUploadpath(String uploadpath) {
		this.uploadpath = uploadpath;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFiletype() {
		return filetype;
	}
	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
}

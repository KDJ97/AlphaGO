package kr.or.ddit.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

@SuppressWarnings("serial")
public class PopupVO implements Serializable{

	private String popcode;
	private String title;
	private String content;
	private String inuse;
	private String uploadpath;
	private String filename;
	private String filetype;
	private Date regdate;
	private Date startDate;
	private Date endDate;
	private int popcount;
	
	private List<PopAttachVO> popAttachList;
	
	
	public List<PopAttachVO> getPopAttachList() {
		return popAttachList;
	}
	public void setPopAttachList(List<PopAttachVO> popAttachList) {
		this.popAttachList = popAttachList;
	}
	public int getPopcount() {
		return popcount;
	}
	public void setPopcount(int popcount) {
		this.popcount = popcount;
	}
	public String getPopcode() {
		return popcode;
	}
	public void setPopcode(String popcode) {
		this.popcode = popcode;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getInuse() {
		return inuse;
	}
	public void setInuse(String inuse) {
		this.inuse = inuse;
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
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
	
}

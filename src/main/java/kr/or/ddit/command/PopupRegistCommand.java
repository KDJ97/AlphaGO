package kr.or.ddit.command;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.dto.PopAttachVO;
import kr.or.ddit.dto.PopupVO;

@SuppressWarnings("serial")
public class PopupRegistCommand implements Serializable{

	private String popcode;
	private String title;
	private String content;
	private String uploadpath;
	private String startDate;
	private String endDate;
	private String inuse;
	private String filename;
	private String filetype;
	private List<MultipartFile> uploadFile;
	private List<PopAttachVO> attachList;
	
	
	
	public List<PopAttachVO> getAttachList() {
		return attachList;
	}
	public void setAttachList(List<PopAttachVO> attachList) {
		this.attachList = attachList;
	}
	public String getPopcode() {
		return popcode;
	}
	public void setPopcode(String popcode) {
		this.popcode = popcode;
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
	public String getInuse() {
		return inuse;
	}
	public void setInuse(String inuse) {
		this.inuse = inuse;
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
	public String getUploadpath() {
		return uploadpath;
	}
	public void setUploadpath(String uploadpath) {
		this.uploadpath = uploadpath;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public List<MultipartFile> getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(List<MultipartFile> uploadFile) {
		this.uploadFile = uploadFile;
	}
	
	public PopupVO toPopupVO() {
		PopupVO popupVO = new PopupVO();
		 SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		
		popupVO.setPopcode(this.popcode);
		popupVO.setContent(this.content);
		popupVO.setTitle(this.title);
		popupVO.setUploadpath(this.uploadpath);
		popupVO.setInuse(this.inuse);
		try {
			popupVO.setStartDate(format.parse(this.startDate));
			popupVO.setEndDate(format.parse(this.endDate));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return popupVO;
	}

}

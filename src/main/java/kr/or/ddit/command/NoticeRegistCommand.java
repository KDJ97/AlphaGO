package kr.or.ddit.command;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.dto.AssignAttachVO;
import kr.or.ddit.dto.NoticeVO;

public class NoticeRegistCommand {
	private String title;
	private String content;
	private String writer;
	private List<MultipartFile> uploadFile;
	private String category;
	private String fixed;
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getFixed() {
		return fixed;
	}
	public void setFixed(String fixed) {
		this.fixed = fixed;
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
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public List<MultipartFile> getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(List<MultipartFile> uploadFile) {
		this.uploadFile = uploadFile;
	}

	public NoticeVO toNoticeVO() {
		NoticeVO notice = new NoticeVO();
		notice.setContent(this.content);
		notice.setTitle(this.title);
		notice.setWriter(this.writer);
		notice.setCategory(this.category);
		
		if(this.fixed == null) this.fixed = "0"; 
		notice.setFixed(Integer.parseInt(this.fixed));

		return notice;
	}
}

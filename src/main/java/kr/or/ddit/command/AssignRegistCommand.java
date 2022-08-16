package kr.or.ddit.command;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.dto.AssignVO;

public class AssignRegistCommand {
	
	private String content;
	private String title;
	private List<MultipartFile> uploadFile;

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public List<MultipartFile> getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(List<MultipartFile> uploadFile) {
		this.uploadFile = uploadFile;
	}
	
	public AssignVO toAssignVO() {
		AssignVO assign = new AssignVO();
		assign.setContent(this.content);
		assign.setTitle(this.title);
		
		return assign;
	}
}

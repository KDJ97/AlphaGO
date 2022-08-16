package kr.or.ddit.command;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.dto.AssignAttachVO;
import kr.or.ddit.dto.NoticeVO;

public class AssignAttachRegistCommand {
	private String content;
	private String id;
	private List<MultipartFile> uploadFile;
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public List<MultipartFile> getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(List<MultipartFile> uploadFile) {
		this.uploadFile = uploadFile;
	}

	public AssignAttachVO toAssignAttachVO() {
		AssignAttachVO attach = new AssignAttachVO();
		attach.setContent(this.content);
		attach.setId(this.id);
		
		return attach;
	}
}

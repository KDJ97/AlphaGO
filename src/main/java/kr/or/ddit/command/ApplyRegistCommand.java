package kr.or.ddit.command;

import java.io.Serializable;
import java.util.List;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.springframework.web.multipart.MultipartFile;
import kr.or.ddit.dto.ApplyVO;

@SuppressWarnings("serial")
public class ApplyRegistCommand implements Serializable{

	private List<MultipartFile> uploadFile;
	private String applyer;
	private String applyerTel;
	private String applyTitle;
	private String applyContent;
	private String applyUploadPath;
	private String applyFileName;

	public List<MultipartFile> getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(List<MultipartFile> uploadFile) {
		this.uploadFile = uploadFile;
	}

	public String getApplyer() {
		return applyer;
	}

	public void setApplyer(String applyer) {
		this.applyer = applyer;
	}

	public String getApplyerTel() {
		return applyerTel;
	}

	public void setApplyerTel(String applyerTel) {
		this.applyerTel = applyerTel;
	}

	public String getApplyTitle() {
		return applyTitle;
	}

	public void setApplyTitle(String applyTitle) {
		this.applyTitle = applyTitle;
	}

	public String getApplyContent() {
		return applyContent;
	}

	public void setApplyContent(String applyContent) {
		this.applyContent = applyContent;
	}

	public String getApplyUploadPath() {
		return applyUploadPath;
	}

	public void setApplyUploadPath(String applyUploadPath) {
		this.applyUploadPath = applyUploadPath;
	}

	public String getApplyFileName() {
		return applyFileName;
	}

	public void setApplyFileName(String applyFileName) {
		this.applyFileName = applyFileName;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}

	public ApplyVO toapplyVO() {

		ApplyVO apply = new ApplyVO();

		apply.setApplyer(this.applyer);
		apply.setApplyerTel(this.applyerTel);
		apply.setApplyTitle(this.applyTitle);
		apply.setApplyContent(this.applyContent);
		return apply;

	}

}

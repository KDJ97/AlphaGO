package kr.or.ddit.dto;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

@SuppressWarnings("serial")
public class ApplyVO implements Serializable {
	
	 private int applyCode;
	private String applyer;
	private String applyerTel;
	private String applyTitle;
	private String applyContent;
	private String applyUploadPath;
	private Date regDate;
	private String applyFilename;
	private String content;
	
	

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.JSON_STYLE);
	}

	public int getApplyCode() {
		return applyCode;
	}

	public void setApplyCode(int applyCode) {
		this.applyCode = applyCode;
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

	

	public String getApplyFilename() {
		return applyFilename;
	}

	public void setApplyFilename(String applyFilename) {
		this.applyFilename = applyFilename;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	

	
	
}

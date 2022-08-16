package kr.or.ddit.dto;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;


@SuppressWarnings("serial")
public class SuggestVO implements Serializable {

	private int lcode;
	private String title;
	private String content;
	private Date regDate;
	private Date updateDate;
	private int viewcnt;
	private int likecnt;
	private String writer;
	
	private int answercnt; //답글 개수
	
	public int getAnswercnt() {
		return answercnt;
	}
	public void setAnswercnt(int answercnt) {
		this.answercnt = answercnt;
	}
	public int getLcode() {
		return lcode;
	}
	public void setLcode(int lcode) {
		this.lcode = lcode;
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
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regdate) {
		this.regDate = regdate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	public int getLikecnt() {
		return likecnt;
	}
	public void setLikecnt(int likecnt) {
		this.likecnt = likecnt;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	@Override
	public String toString(){
			return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
	
}

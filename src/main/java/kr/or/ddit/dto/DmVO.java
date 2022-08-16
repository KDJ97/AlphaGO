/*
 * 작성자 : 예현의
 * 작성일 : 2022-07-07
 * 쪽지함 구현을 위한 쪽지 VO객체 class
 */

package kr.or.ddit.dto;

import java.util.Date;

public class DmVO {
	
	private int dmCode;
	private String dmDiv;
	private String dmTitle;
	private String dmContent;
	private Date dmDate;
	private String dmSender;
	private String dmReceiver;
	private String dmStatus;
	public int getDmCode() {
		return dmCode;
	}
	public void setDmCode(int dmCode) {
		this.dmCode = dmCode;
	}
	public String getDmDiv() {
		return dmDiv;
	}
	public void setDmDiv(String dmDiv) {
		this.dmDiv = dmDiv;
	}
	public String getDmTitle() {
		return dmTitle;
	}
	public void setDmTitle(String dmTitle) {
		this.dmTitle = dmTitle;
	}
	public String getDmContent() {
		return dmContent;
	}
	public void setDmContent(String dmContent) {
		this.dmContent = dmContent;
	}
	public Date getDmDate() {
		return dmDate;
	}
	public void setDmDate(Date dmDate) {
		this.dmDate = dmDate;
	}
	public String getDmSender() {
		return dmSender;
	}
	public void setDmSender(String dmSender) {
		this.dmSender = dmSender;
	}
	public String getDmReceiver() {
		return dmReceiver;
	}
	public void setDmReceiver(String dmReceiver) {
		this.dmReceiver = dmReceiver;
	}
	public String getDmStatus() {
		return dmStatus;
	}
	public void setDmStatus(String dmStatus) {
		this.dmStatus = dmStatus;
	}
	
}

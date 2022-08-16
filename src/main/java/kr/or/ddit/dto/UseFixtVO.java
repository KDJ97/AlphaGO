package kr.or.ddit.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class UseFixtVO {
	private String fixuseno;
	private String roomCode;
	private String fxtcode;
	private String fxticon;

	public String getFxticon() {
		return fxticon;
	}
	public void setFxticon(String fxticon) {
		this.fxticon = fxticon;
	}
	public String getFixuseno() {
		return fixuseno;
	}
	public void setFixuseno(String fixuseno) {
		this.fixuseno = fixuseno;
	}
	public String getFxtcode() {
		return fxtcode;
	}
	public void setFxtcode(String fxtcode) {
		this.fxtcode = fxtcode;
	}
	public String getRoomCode() {
		return roomCode;
	}
	public void setRoomCode(String roomCode) {
		this.roomCode = roomCode;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.JSON_STYLE);
	}
	
}

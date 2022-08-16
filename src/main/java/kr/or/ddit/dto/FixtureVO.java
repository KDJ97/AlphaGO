package kr.or.ddit.dto;

public class FixtureVO {

	private String fxtcode;
	private String fxtname;
	private String fxticon;
	
	public String getFxtcode() {
		return fxtcode;
	}
	public void setFxtcode(String fxtcode) {
		this.fxtcode = fxtcode;
	}
	public String getFxtname() {
		return fxtname;
	}
	public void setFxtname(String fxtname) {
		this.fxtname = fxtname;
	}
	public String getFxticon() {
		return fxticon;
	}
	public void setFxticon(String fxticon) {
		this.fxticon = fxticon;
	}
	
	@Override
	public String toString() {
		return "FixtureVO [fxtcode=" + fxtcode + ", fxtname=" + fxtname + ", fxticon=" + fxticon + "]";
	}
	
	
}

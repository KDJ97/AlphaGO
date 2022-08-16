package kr.or.ddit.dto;

public class MenuVO {

	private String mcode;
	private String mname;
	private String murl;
	private String micon;
	private String upcode;
	
	public String getMcode() {
		return mcode;
	}
	public void setMcode(String mcode) {
		this.mcode = mcode;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getMurl() {
		return murl;
	}
	public void setMurl(String murl) {
		this.murl = murl;
	}
	public String getMicon() {
		return micon;
	}
	public void setMicon(String micon) {
		this.micon = micon;
	}
	public String getUpcode() {
		return upcode;
	}
	public void setUpcode(String upcode) {
		this.upcode = upcode;
	}
	
	@Override
	public String toString() {
		return "MenuVO [mcode=" + mcode + ", mname=" + mname + ", murl=" + murl + ", micon=" + micon + ", upcode=" + upcode + "]";
	}

}

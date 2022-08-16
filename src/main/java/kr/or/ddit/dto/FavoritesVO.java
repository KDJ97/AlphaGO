package kr.or.ddit.dto;

public class FavoritesVO {

	private int fno;
	private String id;
	private int lCode;

	public int getFno() {
		return fno;
	}
	public void setFno(int fno) {
		this.fno = fno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public int getlCode() {
		return lCode;
	}
	public void setlCode(int lCode) {
		this.lCode = lCode;
	}

	@Override
	public String toString() {
		return "FavoritesVO [fno=" + fno + ", id=" + id + ", lCode=" + lCode + "]";
	}


}

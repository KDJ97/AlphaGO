package kr.or.ddit.command;

public class SearchCriteria extends Criteria {
	
	private String keyword;
	private String searchType;
	private String cateType;
	private String cpcheck;
	
	public String getCpcheck() {
		return cpcheck;
	}
	public void setCpcheck(String cpcheck) {
		this.cpcheck = cpcheck;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	
	public String getCateType() {
		return cateType;
	}
	public void setCateType(String cateType) {
		this.cateType = cateType;
	}

	@Override
	public String toString() {
		return "SearchCriteria [keyword=" + keyword + ", searchType=" + searchType + ", cateType=" + cateType + "]";
	}
	
}

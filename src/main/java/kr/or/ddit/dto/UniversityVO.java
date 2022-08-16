package kr.or.ddit.dto;

public class UniversityVO {
	private String univCode;
	private String universityName;
	private double universityKor;
	private double universityEng;
	private double universityMath;
	private double universitySocial;
	private double universityScience;
	private double universityKorScore;
	private double universityEngScore;
	private double universityMathScore;
	private double universitySocialScore;
	private double universityScienceScore;

	public String getUnivCode() {
		return univCode;
	}
	public void setUnivCode(String univCode) {
		this.univCode = univCode;
	}
	public String getUniversityName() {
		return universityName;
	}
	public void setUniversityName(String universityName) {
		this.universityName = universityName;
	}
	public double getUniversityKor() {
		return universityKor;
	}
	public void setUniversityKor(double universityKor) {
		this.universityKor = universityKor;
	}
	public double getUniversityEng() {
		return universityEng;
	}
	public void setUniversityEng(double universityEng) {
		this.universityEng = universityEng;
	}
	public double getUniversityMath() {
		return universityMath;
	}
	public void setUniversityMath(double universityMath) {
		this.universityMath = universityMath;
	}
	public double getUniversitySocial() {
		return universitySocial;
	}
	public void setUniversitySocial(double universitySocial) {
		this.universitySocial = universitySocial;
	}
	public double getUniversityScience() {
		return universityScience;
	}
	public void setUniversityScience(double universityScience) {
		this.universityScience = universityScience;
	}
	public double getUniversityKorScore() {
		return universityKorScore;
	}
	public void setUniversityKorScore(double universityKorScore) {
		this.universityKorScore = universityKorScore;
	}
	public double getUniversityEngScore() {
		return universityEngScore;
	}
	public void setUniversityEngScore(double universityEngScore) {
		this.universityEngScore = universityEngScore;
	}
	public double getUniversityMathScore() {
		return universityMathScore;
	}
	public void setUniversityMathScore(double universityMathScore) {
		this.universityMathScore = universityMathScore;
	}
	public double getUniversitySocialScore() {
		return universitySocialScore;
	}
	public void setUniversitySocialScore(double universitySocialScore) {
		this.universitySocialScore = universitySocialScore;
	}
	public double getUniversityScienceScore() {
		return universityScienceScore;
	}
	public void setUniversityScienceScore(double universityScienceScore) {
		this.universityScienceScore = universityScienceScore;
	}

	@Override
	public String toString() {
		return "UniversityVO [univCode=" + univCode + ", universityName=" + universityName + ", universityKor="
				+ universityKor + ", universityEng=" + universityEng + ", universityMath=" + universityMath
				+ ", universitySocial=" + universitySocial + ", universityScience=" + universityScience + "]";
	}


}

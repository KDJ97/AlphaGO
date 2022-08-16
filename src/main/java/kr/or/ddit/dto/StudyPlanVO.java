package kr.or.ddit.dto;

public class StudyPlanVO {
	private int planCode;
	private int spCode;
	private String studyPlan;
	private int studyResult;
	private int subjectCode;
	public int getPlanCode() {
		return planCode;
	}
	public void setPlanCode(int planCode) {
		this.planCode = planCode;
	}
	public int getSpCode() {
		return spCode;
	}
	public void setSpCode(int spCode) {
		this.spCode = spCode;
	}
	public String getStudyPlan() {
		return studyPlan;
	}
	public void setStudyPlan(String studyPlan) {
		this.studyPlan = studyPlan;
	}
	public int getStudyResult() {
		return studyResult;
	}
	public void setStudyResult(int studyResult) {
		this.studyResult = studyResult;
	}
	public int getSubjectCode() {
		return subjectCode;
	}
	public void setSubjectCode(int subjectCode) {
		this.subjectCode = subjectCode;
	}
	@Override
	public String toString() {
		return "StudyPlanVO [planCode=" + planCode + ", spCode=" + spCode + ", studyPlan=" + studyPlan
				+ ", studyResult=" + studyResult + ", subjectCode=" + subjectCode + "]";
	}


}

package kr.or.ddit.command;

public class TimeTableCommand {
	private int classCode;
	private String className;
	private int subdetailCode;
	private int classday;
	private String startTime;
	private String endTime;
	public int getClassCode() {
		return classCode;
	}
	public void setClassCode(int classCode) {
		this.classCode = classCode;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public int getSubdetailCode() {
		return subdetailCode;
	}
	public void setSubdetailCode(int subdetailCode) {
		this.subdetailCode = subdetailCode;
	}
	public int getClassday() {
		return classday;
	}
	public void setClassday(int classday) {
		this.classday = classday;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	@Override
	public String toString() {
		return "TimeTableCommand [classCode=" + classCode + ", className=" + className + ", subdetailCode="
				+ subdetailCode + ", classday=" + classday + ", startTime=" + startTime + ", endTime=" + endTime + "]";
	}




}

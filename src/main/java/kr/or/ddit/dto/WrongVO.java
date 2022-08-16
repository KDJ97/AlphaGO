package kr.or.ddit.dto;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

// 오답노트
@SuppressWarnings("serial")
public class WrongVO extends ProblemVO implements Serializable{

	private int wno;
	private String id;
	private String content;
	private String updatedate;
	private int examCode;
	private int problemCode;
	private String wrong;
	private String examName;
	private String className;
	private int pronum;
	private String subdetailName;
	private String name; //문제출제자
	private String question;
	private String answer;
	private int problemPrintcode; // 지문코드
	private String problemPrint; // 지문
	
	public int getProblemPrintcode() {
		return problemPrintcode;
	}
	public void setProblemPrintcode(int problemPrintcode) {
		this.problemPrintcode = problemPrintcode;
	}
	public String getProblemPrint() {
		return problemPrint;
	}
	public void setProblemPrint(String problemPrint) {
		this.problemPrint = problemPrint;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getExamName() {
		return examName;
	}
	public void setExamName(String examName) {
		this.examName = examName;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public int getPronum() {
		return pronum;
	}
	public void setPronum(int pronum) {
		this.pronum = pronum;
	}
	public String getSubdetailName() {
		return subdetailName;
	}
	public void setSubdetailName(String subdetailName) {
		this.subdetailName = subdetailName;
	}
	public String getWrong() {
		return wrong;
	}
	public void setWrong(String wrong) {
		this.wrong = wrong;
	}
	public int getWno() {
		return wno;
	}
	public void setWno(int wno) {
		this.wno = wno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public int getExamCode() {
		return examCode;
	}
	public void setExamCode(int examCode) {
		this.examCode = examCode;
	}
	public int getProblemCode() {
		return problemCode;
	}
	public void setProblemCode(int problemCode) {
		this.problemCode = problemCode;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
	
}

package kr.or.ddit.dto;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

@SuppressWarnings("serial")
public class ProblemVO implements Serializable{
//문제코드	
int problemCode     ;

//영역코드
int sano;

//문제 내용
String problemContent  ;

//주관식or객관식
String lproblem         ;
String problemAnswer   ;
String problemSolution ;
int grade  ;
int subjectProccess;
int schoolCode;


String picture;
String none;
String ntwo;
String ntree;
String nfour;
String nfive;
String plevel;

//단원명
private String subunitName;

//영역명
private String saname;

private double odap;

private String maker;
private String problemPrint; // 지문
private int problemPrintcode; // 지문코드

private String subdetailName;


//신고자
private String repot;

//신고내용
private String repotcomment;

//시험 재배치 할때 쓰는 거
private int examNo;


//오답 여부 체크할때 사용하는 변수
private String wrongCheck;

//오답 번호를 받는 변수
private int odapNo;

//문제 질문이 있는지 확인하기.
private String quCheck;

//문제 답변이 있는지 확인하기.
private String awCheck;



private String subdetailCode;











public String getSubdetailCode() {
	return subdetailCode;
}

public void setSubdetailCode(String subdetailCode) {
	this.subdetailCode = subdetailCode;
}

public String getAwCheck() {
	return awCheck;
}

public void setAwCheck(String awCheck) {
	this.awCheck = awCheck;
}

public String getQuCheck() {
	return quCheck;
}

public void setQuCheck(String quCheck) {
	this.quCheck = quCheck;
}

public int getOdapNo() {
	return odapNo;
}

public void setOdapNo(int odapNo) {
	this.odapNo = odapNo;
}

public String getWrongCheck() {
	return wrongCheck;
}

public void setWrongCheck(String wrongCheck) {
	this.wrongCheck = wrongCheck;
}

public int getExamNo() {
	return examNo;
}

public void setExamNo(int examNo) {
	this.examNo = examNo;
}

public String getRepot() {
	return repot;
}

public void setRepot(String repot) {
	this.repot = repot;
}

public String getRepotcomment() {
	return repotcomment;
}

public void setRepotcomment(String repotcomment) {
	this.repotcomment = repotcomment;
}

public String getSubdetailName() {
	return subdetailName;
}

public void setSubdetailName(String subdetailName) {
	this.subdetailName = subdetailName;
}

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


public String getMaker() {
	return maker;
}





public void setMaker(String maker) {
	this.maker = maker;
}



private String examName; // 시험이름



public String getExamName() {
	return examName;
}

public void setExamName(String examName) {
	this.examName = examName;
}







public double getOdap() {
	return odap;
}

public void setOdap(double odap) {
	this.odap = odap;
}

public String getSaname() {
	return saname;
}





public void setSaname(String saname) {
	this.saname = saname;
}





public String getSubunitName() {
	return subunitName;
}





public void setSubunitName(String subunitName) {
	this.subunitName = subunitName;
}





public String getNfive() {
	return nfive;
}





public void setNfive(String nfive) {
	this.nfive = nfive;
}





public String getPlevel() {
	return plevel;
}





public void setPlevel(String plevel) {
	this.plevel = plevel;
}





public String getPicture() {
	return picture;
}





public void setPicture(String picture) {
	this.picture = picture;
}





public String getNone() {
	return none;
}





public void setNone(String none) {
	this.none = none;
}





public String getNtwo() {
	return ntwo;
}





public void setNtwo(String ntwo) {
	this.ntwo = ntwo;
}





public String getNtree() {
	return ntree;
}





public void setNtree(String ntree) {
	this.ntree = ntree;
}





public String getNfour() {
	return nfour;
}





public void setNfour(String nfour) {
	this.nfour = nfour;
}











public int getProblemCode() {
	return problemCode;
}





public void setProblemCode(int problemCode) {
	this.problemCode = problemCode;
}





public int getSano() {
	return sano;
}





public void setSano(int sano) {
	this.sano = sano;
}





public String getProblemContent() {
	return problemContent;
}





public void setProblemContent(String problemContent) {
	this.problemContent = problemContent;
}





public String getLproblem() {
	return lproblem;
}





public void setLproblem(String lproblem) {
	this.lproblem = lproblem;
}





public String getProblemAnswer() {
	return problemAnswer;
}





public void setProblemAnswer(String problemAnswer) {
	this.problemAnswer = problemAnswer;
}





public String getProblemSolution() {
	return problemSolution;
}





public void setProblemSolution(String problemSolution) {
	this.problemSolution = problemSolution;
}





public int getGrade() {
	return grade;
}





public void setGrade(int grade) {
	this.grade = grade;
}





public int getSubjectProccess() {
	return subjectProccess;
}





public void setSubjectProccess(int subjectProccess) {
	this.subjectProccess = subjectProccess;
}





public int getSchoolCode() {
	return schoolCode;
}





public void setSchoolCode(int schoolCode) {
	this.schoolCode = schoolCode;
}










@Override
public String toString(){
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
}
}                       

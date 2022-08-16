package kr.or.ddit.command;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import kr.or.ddit.dto.ProblemVO;

@SuppressWarnings("serial")
public class JimoonProblemCommand implements Serializable{
	String problemPrint;
	
	
	int problemCode;
	int grade;
	int subjectProccess;
	int schoolCode;
	
	//문제당 문제 유형
	int sano1;
	int sano2;
	
	
	//문제 주관식인지 객관식인지 구분
	String lproblem1;
	String lproblem2;
	
	
	//문제당 난이도
	String plevel1;
	String plevel2;
	
	
	
	String problemContent1g;
	String problemContent2g;
	
	
	String problemContent1j;
	String problemContent2j;
	
	
	
	
	//객관식 답
	String problemAnswer1g;
	String problemAnswer2g;
	
	
	//주관식 답
	String problemAnswer1j;
	String problemAnswer2j;
	
	
	//주관식 해설
	String problemSolution1j;
	String problemSolution2j;
	
	
	//객관식 해설
	String problemSolution1g;
	String problemSolution2g;
	
	


	//사진
	String picture1;
	String picture2;
	
	
	//객관식 보기 1
	String none1g;
	String ntwo1g;
	String ntree1g;
	String nfour1g;
	String nfive1g;
	
	//객관식 보기 2
	String none2g;
	String ntwo2g;
	String ntree2g;
	String nfour2g;
	String nfive2g;
	
	
	
	String maker;
	
	
	
	String[]saname;
	String subdetailCode;
	
	
	
	
	
	
	
	
	public String getSubdetailCode() {
		return subdetailCode;
	}


	public void setSubdetailCode(String subdetailCode) {
		this.subdetailCode = subdetailCode;
	}


	public String[] getSaname() {
		return saname;
	}


	public void setSaname(String[] saname) {
		this.saname = saname;
	}


	public String getMaker() {
		return maker;
	}


	public void setMaker(String maker) {
		this.maker = maker;
	}


	public int getProblemCode() {
		return problemCode;
	}


	public void setProblemCode(int problemCode) {
		this.problemCode = problemCode;
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


	public int getSano1() {
		return sano1;
	}


	public void setSano1(int sano1) {
		this.sano1 = sano1;
	}


	public int getSano2() {
		return sano2;
	}


	public void setSano2(int sano2) {
		this.sano2 = sano2;
	}


	





	public String getLproblem1() {
		return lproblem1;
	}


	public void setLproblem1(String lproblem1) {
		this.lproblem1 = lproblem1;
	}


	public String getLproblem2() {
		return lproblem2;
	}


	public void setLproblem2(String lproblem2) {
		this.lproblem2 = lproblem2;
	}


	





	public String getPlevel1() {
		return plevel1;
	}


	public void setPlevel1(String plevel1) {
		this.plevel1 = plevel1;
	}


	public String getPlevel2() {
		return plevel2;
	}


	public void setPlevel2(String plevel2) {
		this.plevel2 = plevel2;
	}


	

	public String getProblemContent1g() {
		return problemContent1g;
	}


	public void setProblemContent1g(String problemContent1g) {
		this.problemContent1g = problemContent1g;
	}


	public String getProblemContent2g() {
		return problemContent2g;
	}


	public void setProblemContent2g(String problemContent2g) {
		this.problemContent2g = problemContent2g;
	}


	


	

	public String getProblemContent1j() {
		return problemContent1j;
	}


	public void setProblemContent1j(String problemContent1j) {
		this.problemContent1j = problemContent1j;
	}


	public String getProblemContent2j() {
		return problemContent2j;
	}


	public void setProblemContent2j(String problemContent2j) {
		this.problemContent2j = problemContent2j;
	}


	


	public String getProblemAnswer1g() {
		return problemAnswer1g;
	}


	public void setProblemAnswer1g(String problemAnswer1g) {
		this.problemAnswer1g = problemAnswer1g;
	}


	public String getProblemAnswer2g() {
		return problemAnswer2g;
	}


	public void setProblemAnswer2g(String problemAnswer2g) {
		this.problemAnswer2g = problemAnswer2g;
	}





	public String getProblemAnswer1j() {
		return problemAnswer1j;
	}


	public void setProblemAnswer1j(String problemAnswer1j) {
		this.problemAnswer1j = problemAnswer1j;
	}


	public String getProblemAnswer2j() {
		return problemAnswer2j;
	}


	public void setProblemAnswer2j(String problemAnswer2j) {
		this.problemAnswer2j = problemAnswer2j;
	}


	

	public String getProblemSolution1j() {
		return problemSolution1j;
	}


	public void setProblemSolution1j(String problemSolution1j) {
		this.problemSolution1j = problemSolution1j;
	}


	public String getProblemSolution2j() {
		return problemSolution2j;
	}


	public void setProblemSolution2j(String problemSolution2j) {
		this.problemSolution2j = problemSolution2j;
	}






	public String getProblemSolution1g() {
		return problemSolution1g;
	}


	public void setProblemSolution1g(String problemSolution1g) {
		this.problemSolution1g = problemSolution1g;
	}


	public String getProblemSolution2g() {
		return problemSolution2g;
	}


	public void setProblemSolution2g(String problemSolution2g) {
		this.problemSolution2g = problemSolution2g;
	}





	public String getPicture1() {
		return picture1;
	}


	public void setPicture1(String picture1) {
		this.picture1 = picture1;
	}


	public String getPicture2() {
		return picture2;
	}


	public void setPicture2(String picture2) {
		this.picture2 = picture2;
	}


	


	public String getNone1g() {
		return none1g;
	}


	public void setNone1g(String none1g) {
		this.none1g = none1g;
	}


	public String getNtwo1g() {
		return ntwo1g;
	}


	public void setNtwo1g(String ntwo1g) {
		this.ntwo1g = ntwo1g;
	}


	public String getNtree1g() {
		return ntree1g;
	}


	public void setNtree1g(String ntree1g) {
		this.ntree1g = ntree1g;
	}


	public String getNfour1g() {
		return nfour1g;
	}


	public void setNfour1g(String nfour1g) {
		this.nfour1g = nfour1g;
	}


	public String getNfive1g() {
		return nfive1g;
	}


	public void setNfive1g(String nfive1g) {
		this.nfive1g = nfive1g;
	}

	
	
	public String getNone2g() {
		return none2g;
	}


	public void setNone2g(String none2g) {
		this.none2g = none2g;
	}


	public String getNtwo2g() {
		return ntwo2g;
	}


	public void setNtwo2g(String ntwo2g) {
		this.ntwo2g = ntwo2g;
	}


	public String getNtree2g() {
		return ntree2g;
	}


	public void setNtree2g(String ntree2g) {
		this.ntree2g = ntree2g;
	}


	public String getNfour2g() {
		return nfour2g;
	}


	public void setNfour2g(String nfour2g) {
		this.nfour2g = nfour2g;
	}


	public String getNfive2g() {
		return nfive2g;
	}


	public void setNfive2g(String nfive2g) {
		this.nfive2g = nfive2g;
	}


	


	public String getProblemPrint() {
		return problemPrint;
	}


	public void setProblemPrint(String problemPrint) {
		this.problemPrint = problemPrint;
	}


	public ProblemVO toproblem1() {
		ProblemVO pro1=new ProblemVO();
		 pro1.setSano(this.sano1);
		 if(this.getLproblem1().equals("객관식")) {
			 pro1.setProblemContent(this.problemContent1g);
			 pro1.setProblemAnswer(this.problemAnswer1g);
			 pro1.setProblemSolution(this.problemSolution1g);
			 pro1.setNone(this.none1g);
			 pro1.setNtwo(this.ntwo1g);
			 pro1.setNtree(this.ntree1g);
			 pro1.setNfour(this.nfour1g);
			 pro1.setNfive(this.nfive1g);
		 }else {
			 pro1.setProblemContent(this.problemContent1j);
			 pro1.setProblemAnswer(this.problemAnswer1j);
			 pro1.setProblemSolution(this.problemSolution1j);
		 }
		pro1.setLproblem(this.lproblem1); 
	
		pro1.setGrade(this.grade);
		pro1.setSubjectProccess(this.subjectProccess);
		pro1.setSchoolCode(this.schoolCode);
		pro1.setMaker(this.maker);
		pro1.setPicture(this.picture1);
		pro1.setPlevel(this.plevel1);

		return pro1;
	
		
	}
	
	public ProblemVO toproblem2() {
		ProblemVO pro1=new ProblemVO();
		 pro1.setSano(this.sano2);
		 if(this.getLproblem2().equals("객관식")) {
			 pro1.setProblemContent(this.problemContent2g);
			 pro1.setProblemAnswer(this.problemAnswer2g);
			 pro1.setProblemSolution(this.problemSolution2g);
			 pro1.setNone(this.none2g);
			 pro1.setNtwo(this.ntwo2g);
			 pro1.setNtree(this.ntree2g);
			 pro1.setNfour(this.nfour2g);
			 pro1.setNfive(this.nfive2g);
		 }else {
			 pro1.setProblemContent(this.problemContent2j);
			 pro1.setProblemAnswer(this.problemAnswer2j);
			 pro1.setProblemSolution(this.problemSolution2j);
		 }
		pro1.setLproblem(this.lproblem2); 
	
		pro1.setGrade(this.grade);
		pro1.setSubjectProccess(this.subjectProccess);
		pro1.setSchoolCode(this.schoolCode);
		pro1.setMaker(this.maker);

		pro1.setPicture(this.picture2);
		pro1.setPlevel(this.plevel2);

		return pro1;
	
		
	}
	
	
	
	
	
	
	@Override
	public String toString(){
			return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}


	
	
	
}

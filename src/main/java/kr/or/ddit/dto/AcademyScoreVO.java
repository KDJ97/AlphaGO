package kr.or.ddit.dto;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

// 학원성적
@SuppressWarnings("serial")
public class AcademyScoreVO implements Serializable{
	private int ascode;
	private int academyScore;
	private int examCode;
	private String id;
	private String regdate;
	private int perfectScore;
	private String achievement;
	
	
	
	
	
	//시험명
	private String examName;
	
	
	//언어 세부영역 취득점수
	private int ko1;
	private int ko2;
	private int ko3;
	private int ko4;
	private int ko5;
	
	//언어 세부영역 토탈점수
	private int tko1;
	private int tko2;
	private int tko3;
	private int tko4;
	private int tko5;
	
	
	
	//수학 세부영역
	private int ma1;
	private int ma2;
	private int ma3;
	private int ma4;
	
	private int tma1;
	private int tma2;
	private int tma3;
	private int tma4;
	
	//사회 세부영역
	private int so1;
	private int so2;
	private int so3;
	private int so4;
	
	private int tso1;
	private int tso2;
	private int tso3;
	private int tso4;
	
	
	//과학 영역
	private int sc1;
	private int sc2;
	private int sc3;
	private int sc4;
	
	private int tsc1;
	private int tsc2;
	private int tsc3;
	private int tsc4;
	
	private int en1;
	private int en2;
	private int en3;
	private int en4;
	
	private int ten1;
	private int ten2;
	private int ten3;
	private int ten4;
	
	
	
	
	public int getKo5() {
		return ko5;
	}
	public void setKo5(int ko5) {
		this.ko5 = ko5;
	}
	public int getTko5() {
		return tko5;
	}
	public void setTko5(int tko5) {
		this.tko5 = tko5;
	}
	public int getTko1() {
		return tko1;
	}
	public void setTko1(int tko1) {
		this.tko1 = tko1;
	}
	public int getTko2() {
		return tko2;
	}
	public void setTko2(int tko2) {
		this.tko2 = tko2;
	}
	public int getTko3() {
		return tko3;
	}
	public void setTko3(int tko3) {
		this.tko3 = tko3;
	}
	public int getTko4() {
		return tko4;
	}
	public void setTko4(int tko4) {
		this.tko4 = tko4;
	}
	public int getTma1() {
		return tma1;
	}
	public void setTma1(int tma1) {
		this.tma1 = tma1;
	}
	public int getTma2() {
		return tma2;
	}
	public void setTma2(int tma2) {
		this.tma2 = tma2;
	}
	public int getTma3() {
		return tma3;
	}
	public void setTma3(int tma3) {
		this.tma3 = tma3;
	}
	public int getTma4() {
		return tma4;
	}
	public void setTma4(int tma4) {
		this.tma4 = tma4;
	}
	public int getTso1() {
		return tso1;
	}
	public void setTso1(int tso1) {
		this.tso1 = tso1;
	}
	public int getTso2() {
		return tso2;
	}
	public void setTso2(int tso2) {
		this.tso2 = tso2;
	}
	public int getTso3() {
		return tso3;
	}
	public void setTso3(int tso3) {
		this.tso3 = tso3;
	}
	public int getTso4() {
		return tso4;
	}
	public void setTso4(int tso4) {
		this.tso4 = tso4;
	}
	public int getTsc1() {
		return tsc1;
	}
	public void setTsc1(int tsc1) {
		this.tsc1 = tsc1;
	}
	public int getTsc2() {
		return tsc2;
	}
	public void setTsc2(int tsc2) {
		this.tsc2 = tsc2;
	}
	public int getTsc3() {
		return tsc3;
	}
	public void setTsc3(int tsc3) {
		this.tsc3 = tsc3;
	}
	public int getTsc4() {
		return tsc4;
	}
	public void setTsc4(int tsc4) {
		this.tsc4 = tsc4;
	}
	public int getEn1() {
		return en1;
	}
	public void setEn1(int en1) {
		this.en1 = en1;
	}
	public int getEn2() {
		return en2;
	}
	public void setEn2(int en2) {
		this.en2 = en2;
	}
	public int getEn3() {
		return en3;
	}
	public void setEn3(int en3) {
		this.en3 = en3;
	}
	public int getEn4() {
		return en4;
	}
	public void setEn4(int en4) {
		this.en4 = en4;
	}
	public int getTen1() {
		return ten1;
	}
	public void setTen1(int ten1) {
		this.ten1 = ten1;
	}
	public int getTen2() {
		return ten2;
	}
	public void setTen2(int ten2) {
		this.ten2 = ten2;
	}
	public int getTen3() {
		return ten3;
	}
	public void setTen3(int ten3) {
		this.ten3 = ten3;
	}
	public int getTen4() {
		return ten4;
	}
	public void setTen4(int ten4) {
		this.ten4 = ten4;
	}
	public int getSc1() {
		return sc1;
	}
	public void setSc1(int sc1) {
		this.sc1 = sc1;
	}
	public int getSc2() {
		return sc2;
	}
	public void setSc2(int sc2) {
		this.sc2 = sc2;
	}
	public int getSc3() {
		return sc3;
	}
	public void setSc3(int sc3) {
		this.sc3 = sc3;
	}
	public int getSc4() {
		return sc4;
	}
	public void setSc4(int sc4) {
		this.sc4 = sc4;
	}
	public int getKo1() {
		return ko1;
	}
	public void setKo1(int ko1) {
		this.ko1 = ko1;
	}
	public int getKo2() {
		return ko2;
	}
	public void setKo2(int ko2) {
		this.ko2 = ko2;
	}
	public int getKo3() {
		return ko3;
	}
	public void setKo3(int ko3) {
		this.ko3 = ko3;
	}
	public int getKo4() {
		return ko4;
	}
	public void setKo4(int ko4) {
		this.ko4 = ko4;
	}
	public int getMa1() {
		return ma1;
	}
	public void setMa1(int ma1) {
		this.ma1 = ma1;
	}
	public int getMa2() {
		return ma2;
	}
	public void setMa2(int ma2) {
		this.ma2 = ma2;
	}
	public int getMa3() {
		return ma3;
	}
	public void setMa3(int ma3) {
		this.ma3 = ma3;
	}
	public int getMa4() {
		return ma4;
	}
	public void setMa4(int ma4) {
		this.ma4 = ma4;
	}
	public int getSo1() {
		return so1;
	}
	public void setSo1(int so1) {
		this.so1 = so1;
	}
	public int getSo2() {
		return so2;
	}
	public void setSo2(int so2) {
		this.so2 = so2;
	}
	public int getSo3() {
		return so3;
	}
	public void setSo3(int so3) {
		this.so3 = so3;
	}
	public int getSo4() {
		return so4;
	}
	public void setSo4(int so4) {
		this.so4 = so4;
	}
	public String getExamName() {
		return examName;
	}
	public void setExamName(String examName) {
		this.examName = examName;
	}
	public int getAscode() {
		return ascode;
	}
	public void setAscode(int ascode) {
		this.ascode = ascode;
	}
	public int getAcademyScore() {
		return academyScore;
	}
	public void setAcademyScore(int academyScore) {
		this.academyScore = academyScore;
	}
	public int getExamCode() {
		return examCode;
	}
	public void setExamCode(int examCode) {
		this.examCode = examCode;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getPerfectScore() {
		return perfectScore;
	}
	public void setPerfectScore(int perfectScore) {
		this.perfectScore = perfectScore;
	}
	public String getAchievement() {
		return achievement;
	}
	public void setAchievement(String achievement) {
		this.achievement = achievement;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
	
}

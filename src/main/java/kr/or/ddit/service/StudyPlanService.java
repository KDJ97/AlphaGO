package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.dto.StudyPlanVO;
import kr.or.ddit.dto.StudyPlanerVO;

public interface StudyPlanService {

	//시퀀스
	public int getMaxPlanCode() throws SQLException;

	//해당날짜의 플래너 코드 가져오기
	public int getSpCode(String date, String id) throws SQLException;

	public void insertPlan(StudyPlanVO stp) throws SQLException;


	//해당 spCode의 PlanList
	public List<StudyPlanVO> getPlanList(int spCode) throws SQLException;

	public void deletePlan(int planCode) throws SQLException;

	public void updatePlan(StudyPlanVO stp) throws SQLException;

	public void checkPlan(int code) throws SQLException;

	public StudyPlanerVO getStudyPlaner(int spCode)throws SQLException;

	public void updatePlaner(StudyPlanerVO planer) throws SQLException;
}

package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.dto.StudyPlanVO;
import kr.or.ddit.dto.StudyPlanerVO;

public interface StudyPlanDAO {

	public StudyPlanerVO getStudyPlaner(String date) throws SQLException;


	//insert planer
	public void insertPlaner(StudyPlanerVO planerVO) throws SQLException;

	//플래너 시퀀스
	public int slectNextStudyPlanerSeq() throws SQLException;

	//플랜 시퀀스
	public int slectNextStudyPlanSeq() throws SQLException;

	//insert plan
	public void insertPlan(StudyPlanVO stp)throws SQLException;


	public List<StudyPlanVO> selectPlanListBySpCode(int spCode)throws SQLException;


	public void deletePlan(int planCode) throws SQLException;


	public void updatePlan(StudyPlanVO stp) throws SQLException;


	public StudyPlanVO selectStudyPlan(int code) throws SQLException;


	public StudyPlanerVO selectStudyPlanerBySpCode(int spCode) throws SQLException;


	public void updatePlaner(StudyPlanerVO planer) throws SQLException;



}

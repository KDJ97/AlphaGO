package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.dto.StudyPlanVO;
import kr.or.ddit.dto.StudyPlanerVO;

public class StudyPlanDAOImpl implements StudyPlanDAO {
	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public StudyPlanerVO getStudyPlaner(String date) throws SQLException {
		return session.selectOne("StudyPlan-Mapper.selectStudyPlaner", date);
	}

	@Override
	public int slectNextStudyPlanerSeq() throws SQLException {
		return session.selectOne("StudyPlan-Mapper.selectNextStudyPlanerSeq");
	}
	@Override
	public int slectNextStudyPlanSeq() throws SQLException {
		return session.selectOne("StudyPlan-Mapper.selectNextStudyPlanSeq");
	}

	@Override
	public void insertPlaner(StudyPlanerVO planerVO) throws SQLException{
		session.update("StudyPlan-Mapper.insertPlaner", planerVO);
	}

	@Override
	public void insertPlan(StudyPlanVO stp)throws SQLException {
		session.update("StudyPlan-Mapper.insertPlan", stp);
	}

	@Override
	public List<StudyPlanVO> selectPlanListBySpCode(int spCode)throws SQLException {
		return session.selectList("StudyPlan-Mapper.selectPlanListBySpCode", spCode);
	}

	@Override
	public void deletePlan(int planCode) throws SQLException {
		session.update("StudyPlan-Mapper.deletePlan", planCode);
	}

	@Override
	public void updatePlan(StudyPlanVO stp) throws SQLException {
		session.update("StudyPlan-Mapper.updatePlan", stp);
	}

	@Override
	public StudyPlanVO selectStudyPlan(int code) throws SQLException {
		return session.selectOne("StudyPlan-Mapper.selectStudyPlan", code);
	}

	@Override
	public StudyPlanerVO selectStudyPlanerBySpCode(int spCode) throws SQLException {
		return session.selectOne("StudyPlan-Mapper.selectStudyPlanerBySpCode", spCode);
	}

	@Override
	public void updatePlaner(StudyPlanerVO planer) throws SQLException {
		session.update("StudyPlan-Mapper.updatePlaner", planer);
	}
}

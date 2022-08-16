package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.dto.ClassVO;

public class MStudyPlanDAOImpl implements MStudyPlanDAO {

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}
	
	/**
	 * 수업계획서 제출 상태에 따른 수업 정보 리스트를 가져오는 DAO
	 */
	@Override
	public List<ClassVO> selectClassListByCpcheck(String cpcheck) throws SQLException {
		return session.selectList("MStudyPlan-Mapper.selectClassListByCpcheck", cpcheck);
	}

	@Override
	public void updateCpcheck(ClassVO classVO) throws SQLException {
		session.update("MStudyPlan-Mapper.updateCpcheck", classVO);
	}

	/**
	 * 진행중인 수업리스트
	 */
	@Override
	public List<ClassVO> selectClassList() throws SQLException {
		return session.selectList("MStudyPlan-Mapper.selectClassList");
	}

	@Override
	public int selectClassReviewCount(String classCode) throws SQLException {
		return session.selectOne("MStudyPlan-Mapper.selectClassReviewCount", classCode);
	}

	@Override
	public void deleteTimeDetailByClassCode(String classCode) throws SQLException {
		session.update("MStudyPlan-Mapper.deleteTimeDetailByClassCode", classCode);
	}

	@Override
	public void deleteClassByClassCode(String classCode) throws SQLException {
		session.update("MStudyPlan-Mapper.deleteClassByClassCode", classCode);
	}

}

package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.dto.ClassVO;

public interface MStudyPlanService {

	/**
	 * 수업계획서 제출 상태에 따른 수업 정보 리스트를 가져오는 DAO
	 * @param cpcheck
	 * @return
	 * @throws SQLException
	 */
	public List<ClassVO> selectClassListByCpcheck(String cpcheck) throws SQLException;
	
	/**
	 * 수업계획 상태를 변경한다
	 * @param classCode
	 * @throws SQLException
	 */
	public void updateCpcheck(ClassVO classVO) throws SQLException;
	
	public List<ClassVO> selectHotClassList() throws SQLException;

	public List<ClassVO> selectWorstClassList() throws SQLException;
	
	/**
	 * 수업 삭제
	 * @throws SQLException
	 */
	public void removeClassPlan(String classCode) throws SQLException;
}

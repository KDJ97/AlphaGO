package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.dto.ClassVO;

public interface MStudyPlanDAO {

	/**
	 * 수업계획서 제출 상태에 따른 수업 정보 리스트를 가져오는 DAO
	 * @param cpcheck
	 * @return
	 * @throws SQLException
	 */
	public List<ClassVO> selectClassListByCpcheck(String cpcheck) throws SQLException; 
	/**
	 * 수업계획 상태를 변경하는 쿼리
	 * @param classCode
	 * @throws SQLException
	 */
	public void updateCpcheck(ClassVO classVO) throws SQLException;
	
	/**
	 * 진행중인 수업 리스트
	 * @return
	 * @throws SQLException
	 */
	public List<ClassVO> selectClassList() throws SQLException;
	
	/**
	 * 수업 리뷰 개수
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	public int selectClassReviewCount(String classCode) throws SQLException;
	
	/**
	 * 수업 시간 삭제(직접 cascade)
	 * @param classCode
	 * @throws SQLException
	 */
	public void deleteTimeDetailByClassCode(String classCode) throws SQLException;
	/**
	 * 수업 삭제
	 * @param classCode
	 * @throws SQLException
	 */
	public void deleteClassByClassCode(String classCode) throws SQLException;
}














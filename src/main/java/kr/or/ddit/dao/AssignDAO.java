package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.dto.AssignAttachVO;
import kr.or.ddit.dto.AssignNameVO;
import kr.or.ddit.dto.AssignVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.MemberVO;

public interface AssignDAO {
	/**
	 * 강의 선택 후 과제 리스트
	 * @param map
	 * @return
	 * @throws SQLException
	 */
	public List<AssignNameVO> selectAssignName(Map<String, Object> map) throws SQLException;
	
	/**
	 * 강의 선택전 전체 과제 리스트
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public List<AssignNameVO> getAssign(String id) throws SQLException;
	
	/**
	 * 과제 상세
	 * @param title
	 * @return
	 * @throws SQLException
	 */
	public AssignVO selectAssignDetail(int assignCode) throws SQLException;
	
	/**
	 * 과제 제출 상황
	 * @param map
	 * @return
	 * @throws SQLException
	 */
	public AssignAttachVO selectAssignAttach(Map<String, Object> map) throws SQLException;
	
	/**
	 * 과제 제출
	 * @param attachVO
	 * @throws SQLException
	 */
	public void insertAssignAttach(AssignAttachVO attachVO) throws SQLException;
	
	/**
	 * 과제 수정
	 * @param attachVO
	 * @throws SQLException
	 */
	public void updateAssignAttach(AssignAttachVO attachVO) throws SQLException;
	
	/**
	 * 과제 삭제
	 * @param map
	 * @throws SQLException
	 */
	public void deleteAssignAttach(Map<String, Object> map) throws SQLException;
	
	/**
	 * 강사가 과제 관리할 때 해당 강사가 수업중인 과제 목록 출력
	 * @param id
	 * @throws SQLException
	 */
	List<AssignVO> selectAssignForTeacher(String id) throws SQLException;
	
	/**
	 * 강사가 과제 관리할 때 해당 과제를 누르면 그 수업을 듣는 학생과 과제제출현황 리스트를 출력
	 * @param map
	 * @return
	 * @throws SQLException
	 */
	List<AssignAttachVO> selectStudentAndStatusList(Map<String, Object> map) throws SQLException;
	
	//홈화면에서 과제제출한 학생들 출력 하기 위한 메서드
	List<AssignAttachVO> selectSubmitStudentForHome(String id) throws SQLException;
	List<AssignAttachVO> selectStudentAtClassForHome(String id) throws SQLException;
	
	/**
	 * 해당 수업을 듣는 학생들의 리스트 출력
	 * @param map
	 * @return
	 * @throws SQLException
	 */
	List<MemberVO> selectRegisteredStudentAtClass(Map<String, Object> map) throws SQLException;
	
	/**
	 * 해당 과제를 제출한 학생들 리스트 출력
	 * @param map
	 * @return
	 * @throws SQLException
	 */
	List<AssignAttachVO> selectAssignAttachList(Map<String, Object> map) throws SQLException;
	
	/**
	 * 해당 강사가 진행중인, 현재일 기준으로 끝나지 않은 수업목록
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	List<ClassVO> selectClassListNotFinished(String id) throws SQLException;
	
	/**
	 * 과제 seq값 가져오기
	 * @return
	 * @throws SQLException
	 */
	int selectAssignSeqNextValue() throws SQLException;
	
	/**
	 * 과제 등록
	 * @param assign
	 * @throws SQLException
	 */
	void insertAssign(AssignVO assign) throws SQLException;
	
	/**
	 * 과제에 등록한 파일 삭제
	 * @param assignCode
	 * @throws SQLException
	 */
	void deleteFile(int assignCode) throws SQLException;
	//과제삭제
	void deleteAssign(int assignCode) throws SQLException;
	
	/**
	 * 과제 수정
	 * @param assign
	 * @throws SQLException
	 */
	void updateAssign(AssignVO assign) throws SQLException;
	
	/**
	 * 해당 수업을 듣는 총 원생 수
	 * @return
	 * @throws SQLException
	 */
	int selectTotalCountStudent(int classCode) throws SQLException;
	/**
	 * 해당 과제를 제출한 총 원생 수
	 * @return
	 * @throws SQLException
	 */
	int selectSubmitStudentCount(int assignCode) throws SQLException;
	
	/**
	 * 제출한 과제 확인했다고 업데이트하는 메서드
	 * @param map
	 * @throws SQLException
	 */
	void checkHomework(Map<String,Object> map) throws SQLException;
}

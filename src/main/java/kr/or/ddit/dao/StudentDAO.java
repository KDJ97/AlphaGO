package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.NoticeVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.StudentVO;

public interface StudentDAO {

	List<StudentVO> selectStudentList(String id) throws Exception;

	List<StudentVO> selectStudentList(Criteria cri, String id) throws Exception;

	int selectStudentListCount(SearchCriteria cri) throws Exception;

	// 검색 결과의 전체 리스트 개수
	int selectSearchStudentListCount(SearchCriteria cri) throws Exception;

	List<StudentVO> selectSearchStudentList(SearchCriteria cri) throws SQLException;

	public void insertStudent(StudentVO student) throws SQLException;

	StudentVO selectStudentById(String id) throws SQLException;

	StudentVO selectStudentByPicture(String picture) throws SQLException;

	public void deleteStudent(String id) throws SQLException;

	String selectStudentSequenceNextValue() throws SQLException;

	List<StudentVO> selectHopeSchool(String id) throws Exception;

	StudentVO selectFirstHopeSchool(String id) throws SQLException;

//	String selectFuUniversity(String id)throws SQLException;
//	

	/**
	 * 사용자 사진 시퀀스
	 * @return
	 * @throws SQLException
	 */
	public int getMemberPictureSeq() throws SQLException;
	
}

package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.StudentVO;

public interface StudentService {
	/*
	 * public List<StudentVO> getStudentList() throws Exception; public
	 * List<StudentVO> getStudentList(Criteria cri) throws Exception;
	 * 
	 * public Map<String,Object> getStudentListForPage(Criteria cri) throws
	 * Exception;
	 */

	Map<String, Object> getStudentList(Criteria cri, String id) throws SQLException;

	public void regist(StudentVO student, String uploadPath) throws Exception;

	public StudentVO getStudent(String id) throws Exception;

	public void remove(String id) throws Exception;

	Map<String, Object> selectHopeSchool(String id) throws SQLException;

	public StudentVO selectFirstHopeSchool(String id) throws SQLException;

}

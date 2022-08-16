package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.command.YJSearchCriteria;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.WrongVO;

public interface WrongService {
	// 셀렉트박스 시험리스트
	public List<ExamVO> selectExam(Map<String, Object> map) throws SQLException;
	
	// 오답리스트
	public Map<String, Object> selectWrong(String id, YJSearchCriteria cri) throws SQLException;
	
	// 오답 상세
	public WrongVO selectDetailWrong(Map<String, Object> map) throws SQLException;
	
	// 오답 상세 rownum=1
	public WrongVO selectDetailMain(String id) throws SQLException;
	
	// 오답질문 담당쌤 조회
	public List<WrongVO> selectTname(int examCode) throws SQLException;
	
	// 오답질문 등록
	public void updateQuestion(Map<String, Object> map) throws SQLException;
	
	// 오답질문한 학생 조회
	public WrongVO selectSname(Map<String, Object> map) throws SQLException;
	
	// 내해설 등록
	public void insertSolution(Map<String, Object> map) throws SQLException;
	
	// 지문 유무 조회
	public String selectJimoon(int problemCode) throws SQLException;
}

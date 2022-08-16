package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionException;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.ExamInsertCommand;
import kr.or.ddit.command.JimoonProblemCommand;
import kr.or.ddit.command.ProblemSearchCommand;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.AcademyScoreVO;
import kr.or.ddit.dto.ClassProgVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.ProblemVO;
import kr.or.ddit.dto.SchoolScoreVO;
import kr.or.ddit.dto.WrongVO;

public interface TeacherService {
	 //id로 강의명 조회
	 public List<String> processSearch(String id) throws SQLException;

	 //강의명으로 강의 듣는 학생 조회
	 public Map<String,  Object> processStudentList(String processName,Criteria cri)throws SQLException;

	 //선생님의 개설 강의 리스트
	 public List<String> getclassList(String id)throws SQLException;

	//선생님의 학생 조회
	public MemberVO teacherstudentDetail(String id) throws SQLException;
	// public void insertProblemG(ProblemVO problem)throws SQLException;
	public Map<String, Object> teacherstudenttotalList(String id, SearchCriteria cri) throws SQLException;

	//id로 이름 검색&과목검색
	public Map<String,String> idSearchName(String id) throws SQLException;

	//문제리스트
	public  Map<String, Object> problemList(String id, ProblemSearchCommand cri) throws SQLException;

	//학교 성적
	public List<SchoolScoreVO> schoolGrade(String id) throws SQLException;

	public Map<String, Object> createGdata(String id) throws SQLException;

	public List<ClassProgVO> danSearch(String name) throws SQLException;

	public int insertProblem(ProblemVO problem) throws SQLException;

	public int insertJProblem(JimoonProblemCommand problem)throws SQLException;

	public Map<String, Object> getProblem(int prC)throws SQLException;

	//문제 코드로 단원명
	public String danwonSearch(int prC) throws SQLException;

	public String detailSubjecSearch(int prC) throws SQLException;

	public int modifyProblem(ProblemVO problem) throws SQLException;


	//지문 문제 업데이트
	public int updateJProblem(JimoonProblemCommand problem) throws SQLException;


	//시작 단원 선택에 맞게 끝나는 단원 조회
	public List<ClassProgVO> endDanSearch(String startDan, String className)throws SQLException;

	//랜덤하게  문제 뽑아오는 메서드
	public List<List<ProblemVO>> getRandomJimoonProblem(String startDan, String enddan2, String probCnt, String detailCode) throws SQLException;


	//수업이름과 수업코드 가져오기(id로)
	public List<Map<String, Object>> getProcess(String id)throws SQLException;

	//세부과목 코드와 시작단원 끝단원의 문제 가져오기(지문 x인문제)
	public List<ProblemVO> getProblemList(String startDan, String enddan2, int k, String detailCode)throws SQLException;

	//지문없는 문제리스트
	public Map<String, Object>  problemJXsdedList(String startDan, Criteria cri, String enddan, String detailCode) throws SQLException;

	//지문있는 문제리스트
	public Map<String, Object> problemJsdedList(String startDan, Criteria cri, String enddan, String detailCode) throws SQLException;


	//시험을 등록하는 메서드이다.
	public int examInsertGo(ExamInsertCommand exam) throws SQLException;

	public void colExamgo(int cnt, ExamInsertCommand exam) throws SQLException;


	//문제를 신고하는 메서드이다.
	public void repotProblem(String prC, String id, String comment) throws SQLException;
	
	//문제 신고를 취소하는 메서드이다.
	public void repotProblemCanCel(String prC)throws SQLException;

	public List<ProblemVO> repotproblemlist(String id)throws SQLException;
	
	
	//수동 미리보기 문제가져오기~!!
	public List<List<ProblemVO>> previewgetProList(String[] problemCodeList)throws SQLException;
	
	
	//시험지 수업코드로 얻기
	public List<ExamVO> getExamClassCode(String classCode) throws SQLException;
	
	
	//시험 문제 가져오는 메서드
	public List<ProblemVO> getExamProblem(String examCode)throws SQLException;
	
	//ajax화면 찍기 좋게 리스트 변환
	public List<List<ProblemVO>> getExamSendGo(List<ProblemVO> getExamProblemList)throws SQLException;
	
	
	//단원명으로 단원코드 및 단원 조시.
	public ClassProgVO danwonSearch(String name)throws SQLException;
	
	
	//선생님의 모든 학생의 시험이 뜬다.
	public Map<String, Object> getAllExamList(String id, SearchCriteria cri)throws SQLException;
	
	
	//클래스 내용 가져오기.
	public List<ClassVO> getListClass(String id)throws SQLException;
	
	//시험코드로 오답가져오기
	public List<WrongVO> getExamCodeWrong(String examCode)throws SQLException;
	
	
	//디테일코드로 단원정보가져오기.
	public List<ClassProgVO> danSearch2(String detailCode)throws SQLException;

	public WrongVO wrongGet(String examCode)throws SQLException;
	
	
	//답변등록
	public int insertWrongAnswer(String examCode, String answer)throws SQLException;
	
	
	//전체 리스트 가져오기.
	public Map<String, Object> processStudentList2(String ms, SearchCriteria cri)throws SQLException;
	
	
	
	
	

	public List<ClassVO> getclassClist(String id)throws SQLException;
	
	
	//학생 아이디로 수업에서 듣는 시험지 리스트 가지고오기
	public List<AcademyScoreVO> examListGet(String id, String classCode, String subject)throws SQLException;

	public int searchSanoCode(String saname, String subdetailCode)throws SQLException;
	
	







	





}

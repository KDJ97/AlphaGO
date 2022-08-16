package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.Criteria;
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

public interface TeacherDAO {


	List<String> processSearch(String id)throws SQLException;

	List<MemberVO> processStudentList(String processName,Criteria cri)throws SQLException;

	int classCode(String processName)throws SQLException;

	int selectprocessStudentlistCount(int class_code,Criteria cri);

	MemberVO teacherstudentDetail(String id)throws SQLException;

	List<String> searchClass(String id);

	List<MemberVO> teacherstudenttotalList(String id, SearchCriteria cri) throws SQLException;

	int teacherstudenttotalListcount(String id, SearchCriteria cri)throws SQLException;

	String idSearchName(String id) throws SQLException;
	String idSearchSubject(String id)throws SQLException;

	List<SchoolScoreVO> schoolGrade(String id)throws SQLException;


	//아이디로 과목 코드 검색하기
	String idSearchSubjectCode(String id) throws SQLException;

	//과목코드로 세부과목 찾기
	List<Map<String,Object>> subjectCodeSearchDetailName(String subjectCode) throws SQLException;



	List<Map<String,String>> detailCodeSearchSarea(String subcode) throws SQLException;


	//단원 검색
	List<ClassProgVO> danSearch(String name) throws SQLException;

	int insertProblem(ProblemVO problem)throws SQLException;


	//문제 번호 생성
	int problemSequence()throws SQLException;


	//지문 번호 생성
	int jimoonSequece() throws SQLException;

	int insertjimoonProblem(int jimoonNum, int proC1, String problemPrint) throws SQLException;

	//지문없는  문제리스트
	List<ProblemVO> problemPXList(ProblemSearchCommand cri, String subject,String id) throws SQLException;

	//지문없는 문제 숫자
	int PXtotalcnt(ProblemSearchCommand cri, String subject) throws SQLException;

	ProblemVO getProblem(int prC) throws SQLException;

	String getJimoon(int prC) throws SQLException;

	//단원 검색(문제 코드로)
	String danwonSearch(int prC) throws SQLException;

	String detailSubjecSearch(int prC) throws SQLException;

	int modfyProblem(ProblemVO problem) throws SQLException;

	List<Integer> prCSearchprC(int prC) throws SQLException;

	int prCSearchPrintCode(int prC) throws SQLException;

	//객관식 문제 수정(지문)
	void modyfyjProblemG(JimoonProblemCommand problem)throws SQLException;

	//주관식 문제 수정(지문)
	void modyfyjProblemJ(JimoonProblemCommand problem)throws SQLException;

	//지문이 수정되면 같은 지문을 쓰던 것들도 다 지문이 수적되어야한다.
	void problemPrintUpdate(Map<String, String> dataMap)throws SQLException;

	//객관식 문제 수정(지문,사진 추가)
	void modyfyjpProblemG(JimoonProblemCommand problem)throws SQLException;

	//주관식 문제 수정(지문,사진 추가)
	void modyfyjpProblemJ(JimoonProblemCommand problem)throws SQLException;

	//시작단원에 비례해 그 이후의 단원 조회
	List<ClassProgVO> endDanSearch(String startDan, String className)throws SQLException;

	//지문 검색  강의의 단원과 단원사이로 조회된
	List<String> jimoonSearch(String startDan, String enddan2, String probCnt)throws SQLException;


	//지문에 딸린 문제들 가져오기
	List<ProblemVO> getjimoonProblem(String problemPrintCode) throws SQLException;

	//id로 검색
	List<Map<String, Object>> getProcess(String id)throws SQLException;

	List<ProblemVO> getProblemList(Map<String, Object> data)throws SQLException;


	//문제 찾기 단원과 단원사이의 지문없는것
	List<ProblemVO> problemJXsdedList(String startDan, String enddan, String detailCode, Criteria cri)throws SQLException;

	int problemJXsdedListCount(String startDan, String enddan, String detailCode, Criteria cri) throws SQLException;

	//지문 있는 문제리스트
	List<ProblemVO> problemJsdedList(String startDan, String enddan, String detailCode, Criteria cri) throws SQLException;

	//지문없는 문제리스트
	int problemJsdedListCount(String startDan, String enddan, String detailCode, Criteria cri)throws SQLException;

	int examCodeSequenceGet()throws SQLException;

	int examInsert(Map<String, Object> data)throws SQLException;

	void colExamInsert(Map<String, Object> data)throws SQLException;

	void repotProblem(String prC, String id, String comment)throws SQLException;

	List<ExamVO> recentlyExam(int prC)throws SQLException;

	int examTotalCount(int examCode)throws SQLException;

	int wrongTotalCount(int examCode, int prC)throws SQLException;


	List<ExamVO> rankExam(int prC, String string)throws SQLException;

	void repotProblemCanCel(String prC)throws SQLException;

	List<ProblemVO> repotproblemlist(String id)throws SQLException;

	//지문코드로 지문검색하기
	List<ProblemVO> printCodeSearchProblem(String string)throws SQLException;

	boolean jcheck(ProblemVO problemVO)throws SQLException;

	List<ExamVO> getExamClassCode(String classCode)throws SQLException;

	String getExamEndDAN(int examCode)throws SQLException;

	String getExamStartDAN(int examCode)throws SQLException;
	
	
	//시험에 응해서 성적이 입력된 학생의 인원수
	int getAcScoreSc(int examCode)throws SQLException;
	
	//시험에 응한 학생의 총합점수
	int getAcTotalSc(int examCode)throws SQLException;
	
	//시험지 문제 가지고오기.
	List<ProblemVO> getExamProblem(String examCode)throws SQLException;

	int insertjimoonProblem2(int jimoonNum, int proC2)throws SQLException;
	
	
	//단원정보가져오기.
	ClassProgVO danwonSearch2(String name)throws SQLException;
	
	
	//시험 모든것 숫자세기
	int examAllList(String id, SearchCriteria cri)throws SQLException;
	
	//조건에 맞는 시험지 가져오기
	List<ExamVO> examAllListgo(String id, SearchCriteria cri)throws SQLException;

	List<ClassVO> getListClass(String id)throws SQLException;

	List<WrongVO> getExamCodeWrong(String examCode)throws SQLException;

	List<ClassProgVO> danSearch2(String detailCode)throws SQLException;

	WrongVO wrongGet(String examCode)throws SQLException;

	int inserWrongAnswer(Map<String, Object> data)throws SQLException;

	List<ExamVO> AllExam(int problemCode)throws SQLException;

	List<MemberVO> processStudentList2(SearchCriteria cri)throws SQLException;
	
	
	//전체 갯수가져오기
	int selectprocessStudentlistCount2(SearchCriteria cri)throws SQLException;
	
	
	//시험정보 가지고 오기
	List<AcademyScoreVO> examListGet(Map<String, Object> data)throws SQLException;
	
	
	//클래스 정보가져오기.
	List<ClassVO> getclassClist(String id)throws SQLException;

	int getTSSubarea(String id, String string, int examCode)throws SQLException;
	
	
	//시험에서 취득한 영역점수
	int getSSubarea(String id, String string, int examCode)throws SQLException;

	List<ExamVO> examAllListgo2(String id, SearchCriteria cri)throws SQLException;

	int searchSanoCode(Map<String, Object> data)throws SQLException;

	

	
	

	










}

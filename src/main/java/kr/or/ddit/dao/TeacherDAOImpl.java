package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;




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

public class TeacherDAOImpl implements TeacherDAO{
	   private SqlSession session;

	     public void setSession(SqlSession session) {
			this.session = session;
		}

	     //id로 과정검색
		@Override
		public List<String> processSearch(String id)throws SQLException{
			List<String>processList=null;
			processList=session.selectList("Teacher-Mapper.processSearch",id);
			return processList;
		}


		//강의코드로 학생 리스트 가져오기
		@Override
		public List<MemberVO> processStudentList(String processName,Criteria cri) throws SQLException {
			List<MemberVO>processStudentlist=null;
			int classCode=-1;

				//강의명으로 강의 코드 가져오기
		     classCode=classCode(processName);

		     int startRow = cri.getStartRowNum();
				int endRow = startRow+cri.getPerPageNum()-1;

				SearchCriteria searchCri = (SearchCriteria)cri;

				Map<String, Object> dataParam = new HashMap<String, Object>();
				dataParam.put("startRow", startRow);
				dataParam.put("endRow", endRow);
				dataParam.put("searchType", searchCri.getSearchType());
				dataParam.put("keyword", searchCri.getKeyword());
				dataParam.put("classCode",classCode);



				processStudentlist=session.selectList("Teacher-Mapper.processStudentlist",dataParam);

			return processStudentlist;
		}
		
		
		
		@Override
		public List<MemberVO> processStudentList2(SearchCriteria cri) throws SQLException {
			List<MemberVO>processStudentlist=null;
		    

		     int startRow = cri.getStartRowNum();
				int endRow = startRow+cri.getPerPageNum()-1;

				SearchCriteria searchCri = (SearchCriteria)cri;

				Map<String, Object> dataParam = new HashMap<String, Object>();
				dataParam.put("startRow", startRow);
				dataParam.put("endRow", endRow);
				dataParam.put("searchType", searchCri.getSearchType());
				dataParam.put("keyword", searchCri.getKeyword());
				



				processStudentlist=session.selectList("Teacher-Mapper.processStudentlist2",dataParam);

			return processStudentlist;
		}
		
		
		
		
		
		

		//강의코드로 학생수 조회하기
		@Override
		public int selectprocessStudentlistCount(int class_code,Criteria cri) {

		     int startRow = cri.getStartRowNum();
				int endRow = startRow+cri.getPerPageNum()-1;

				SearchCriteria searchCri = (SearchCriteria)cri;

				Map<String, Object> dataParam = new HashMap<String, Object>();
				dataParam.put("startRow", startRow);
				dataParam.put("endRow", endRow);

				dataParam.put("searchType", searchCri.getSearchType());
				dataParam.put("keyword", searchCri.getKeyword());
				dataParam.put("classCode",class_code);
		System.out.println(dataParam);
			return session.selectOne("Teacher-Mapper.processStudentlistCount",dataParam);
		}
		
		@Override
		public int selectprocessStudentlistCount2(SearchCriteria cri) throws SQLException {
			  int startRow = cri.getStartRowNum();
				int endRow = startRow+cri.getPerPageNum()-1;

				SearchCriteria searchCri = (SearchCriteria)cri;

				Map<String, Object> dataParam = new HashMap<String, Object>();
				dataParam.put("startRow", startRow);
				dataParam.put("endRow", endRow);

				dataParam.put("searchType", searchCri.getSearchType());
				dataParam.put("keyword", searchCri.getKeyword());
				
		System.out.println(dataParam);
			return session.selectOne("Teacher-Mapper.processStudentlistCount2",dataParam);
		}

		
		
		
		
		
		

		//학생 아이디를 통한 학생 상세 조회
		@Override
		public MemberVO teacherstudentDetail(String id) throws SQLException {

			return session.selectOne("Teacher-Mapper.teacherstudentDetail",id);
		}

		//강의 이름으로 강의 코드찾기
		@Override
		public int classCode(String processName) throws SQLException {

			System.out.println("-----------------------------------");
			System.out.println(processName);
			System.out.println("-----------------------------------");
			return  session.selectOne("Teacher-Mapper.classCode",processName);
		}

		//로그인한 선생님의 강의 리스트
		@Override
		public List<String> searchClass(String id) {

			return session.selectList("Teacher-Mapper.searchClass",id);
		}

		//선생님 강의듣는 학생 리스트
		@Override
		public List<MemberVO> teacherstudenttotalList(String id,SearchCriteria cri) throws SQLException {
			 int startRow = cri.getStartRowNum();
				int endRow = startRow+cri.getPerPageNum()-1;

				SearchCriteria searchCri = (SearchCriteria)cri;

				Map<String, Object> dataParam = new HashMap<String, Object>();
				dataParam.put("startRow", startRow);
				dataParam.put("endRow", endRow);
				dataParam.put("searchType", searchCri.getSearchType());
				dataParam.put("keyword", searchCri.getKeyword());
				dataParam.put("id",id);

			return session.selectList("Teacher-Mapper.teacherstudenttotalList",dataParam);
		}

		//선생님 강의듣는 학생 리스트 수세기
		@Override
		public int teacherstudenttotalListcount(String id, SearchCriteria cri) throws SQLException {
			   int startRow = cri.getStartRowNum();
				int endRow = startRow+cri.getPerPageNum()-1;


				Map<String, Object> dataParam = new HashMap<String, Object>();
				dataParam.put("startRow", startRow);
				dataParam.put("endRow", endRow);

				dataParam.put("searchType", cri.getSearchType());
				dataParam.put("keyword", cri.getKeyword());

				dataParam.put("id",id);
				System.out.println(dataParam);
				if(session.selectOne("Teacher-Mapper.teacherstudenttotalListcount",dataParam)==null) {
					return 0;
				}
				return session.selectOne("Teacher-Mapper.teacherstudenttotalListcount",dataParam);
		}

		//id로 이름검색
		@Override
		public String idSearchName(String id) throws SQLException {
			// TODO Auto-generated method stub
			return session.selectOne("Teacher-Mapper.idSearchName", id);
		}

		//id로 과목검색
		@Override
		public String idSearchSubject(String id) throws SQLException {

			return session.selectOne("Teacher-Mapper.idSearchSubject",id);
		}

		//학교 성적 불러오기
		@Override
		public List<SchoolScoreVO> schoolGrade(String id) throws SQLException {
			List<SchoolScoreVO>scoreList=session.selectList("Teacher-Mapper.schoolGrage", id);
			return scoreList;
		}

		//아이디로 과목코드 불러오기
		@Override
		public String idSearchSubjectCode(String id) throws SQLException {
			String subject=idSearchSubject(id);
			String subjectCode=session.selectOne("Teacher-Mapper.idSearchSubjectCode",subject);
			return subjectCode;
		}


		//과목코드로 세부과목 이름,코드 가지고 오기
		@Override
		public List<Map<String,Object>> subjectCodeSearchDetailName(String subjectCode) throws SQLException {
			List<Map<String,Object>>subjectDetailList=session.selectList("Teacher-Mapper.subjectCodeSearchDetailName",subjectCode);
			return subjectDetailList;
		}

		//세부과목코드로 유형및 유형코드 검색
		@Override
		public List<Map<String,String>> detailCodeSearchSarea(String subcode) throws SQLException {
		        List<Map<String,String>>subAreaList=session.selectList("Teacher-Mapper.detailCodeSearchSarea",subcode);
		        System.out.println("이것이 서브 리스트:"+subAreaList);
			return subAreaList;
		}


		//단원을 세부과목 코드로 검색
		@Override
		public List<ClassProgVO> danSearch(String name) throws SQLException {
			// TODO Auto-generated method stub
			return session.selectList("Teacher-Mapper.danSearch", name);
		}

		@Override
		public List<ClassProgVO> danSearch2(String detailCode) throws SQLException {
			// TODO Auto-generated method stub
			return session.selectList("Teacher-Mapper.danSearch2", detailCode);
		}
		
		
		
		
		//문제를 등록할 때 쓰는 메서드
		@Override
		public int insertProblem(ProblemVO problem) throws SQLException {

			return session.insert("Teacher-Mapper.insertProblem",problem);
		}
	

		@Override
		public int problemSequence() throws SQLException {

			return session.selectOne("Teacher-Mapper.selectProblemSeqNext");
		}

		@Override
		public int jimoonSequece() throws SQLException {
			// TODO Auto-generated method stub
			return session.selectOne("Teacher-Mapper.jimoonSequeceNext");
		}

		@Override
		public int insertjimoonProblem(int jimoonNum, int proC1, String problemPrint) throws SQLException {
			Map<String,Object>dataMap=new HashMap<String,Object>();
			dataMap.put("proC1",proC1);
			dataMap.put("problemPrint",problemPrint);
			dataMap.put("jimoonNum",jimoonNum);

			return session.insert("Teacher-Mapper.insertjimoonProblem",dataMap);
		}
		@Override
		public int insertjimoonProblem2(int jimoonNum, int proC1) throws SQLException {
			Map<String,Object>dataMap=new HashMap<String,Object>();
			dataMap.put("proC1",proC1);
			dataMap.put("jimoonNum",jimoonNum);

			return session.insert("Teacher-Mapper.insertjimoonProblem2",dataMap);
		}

		@Override
		public List<ProblemVO> problemPXList(ProblemSearchCommand cri, String subject,String id) throws SQLException {
			Map<String,Object>dataParam=new HashMap<String,Object>();
			 int startRow = cri.getStartRowNum();
			int endRow = startRow+cri.getPerPageNum()-1;

			dataParam.put("startRow", startRow);
			dataParam.put("endRow", endRow);
			dataParam.put("selectgo",cri.getSelectgogo());
			dataParam.put("searchType", cri.getSearchType());
			dataParam.put("keyword", cri.getKeyword());
			dataParam.put("subject",subject);
			dataParam.put("id",id);
			
			System.out.println("dataParam"+dataParam);
			return session.selectList("Teacher-Mapper.problemPXList",dataParam);
		}

		@Override
		public int PXtotalcnt(ProblemSearchCommand cri, String subject) throws SQLException {
			Map<String,Object>dataParam=new HashMap<String,Object>();
			 int startRow = cri.getStartRowNum();
			int endRow = startRow+cri.getPerPageNum()-1;

			dataParam.put("startRow", startRow);
			dataParam.put("endRow", endRow);

			dataParam.put("searchType", cri.getSearchType());
			dataParam.put("keyword", cri.getKeyword());
			dataParam.put("subject",subject);
			return session.selectOne("Teacher-Mapper.PXtotalcnt",dataParam);
		}

		//문제가져오기
		@Override
		public ProblemVO getProblem(int prC) throws SQLException {

			return session.selectOne("Teacher-Mapper.getProblem", prC);
		}

		//문제에 지문있음 가져오기
		@Override
		public String getJimoon(int prC) throws SQLException {
			// TODO Auto-generated method stub
			return session.selectOne("Teacher-Mapper.getJimoon",prC);
		}


		//문제코드로 단원 검색이요
		@Override
		public String danwonSearch(int prC) throws SQLException {
			// TODO Auto-generated method stub
			System.out.println(prC);

			return session.selectOne("Teacher-Mapper.danwonSearch",prC);
		}

		@Override
		public String detailSubjecSearch(int prC) throws SQLException {
			System.out.println("다오안에서의 prC:"+prC);
			return session.selectOne("Teacher-Mapper.detailSubjecSearch",prC);
		}

		//문제 수정
		@Override
		public int modfyProblem(ProblemVO problem) throws SQLException {
			int cnt=0;
			if(problem.getLproblem().equals("객관식")) {
				if(problem.getPicture()==null||problem.getPicture().trim().equals("")) {
					//객관식 문제 수정
					cnt=session.update("Teacher-Mapper.modfyGProblem",problem);
				}else {
					cnt=session.update("Teacher-Mapper.modfyGProblem2",problem);
				}

			}else {
				System.out.println("주관식안에서의 문제:"+problem);
				if(problem.getPicture()==null||problem.getPicture().trim().equals("")) {
					//주관식 문제 수정
					System.out.println("주관식 수정해라");
					cnt=session.update("Teacher-Mapper.modfyJProblem",problem);
				}else {
					System.out.println("주관식 수정해라했다.");
					cnt=session.update("Teacher-Mapper.modfyJProblem2",problem);
				}
				//주관식 문제 수정

			}
			return cnt;
		}


		//문제 코드로 지문에 달려있는 문제코드 뽑기
		@Override
		public List<Integer> prCSearchprC(int prC) throws SQLException {

			return session.selectList("Teacher-Mapper.prCSearchprC",prC);
		}

		//문제코드로 지문 코드 찾기
		@Override
		public int prCSearchPrintCode(int prC) throws SQLException {
			// TODO Auto-generated method stub
			return session.selectOne("Teacher-Mapper.prCSearchPrintCode",prC);
		}

		//객관식 지문있는 문제 수정
		@Override
		public void modyfyjProblemG(JimoonProblemCommand problem) throws SQLException {
			session.update("Teacher-Mapper.modyfyjProblemG",problem);

		}

		//주관식 문제 수정
		@Override
		public void modyfyjProblemJ(JimoonProblemCommand problem) throws SQLException {
			session.update("Teacher-Mapper.modyfyjProblemJ",problem);

		}

		//같은 문제코드로 사용하는 모든 지문 수정해주기
		@Override
		public void problemPrintUpdate(Map<String, String> dataMap) throws SQLException {
			session.update("Teacher-Mapper.problemPrintUpdate",dataMap);

		}

		@Override
		public void modyfyjpProblemG(JimoonProblemCommand problem) throws SQLException {
			session.update("Teacher-Mapper.modyfyjpProblemG",problem);

		}

		@Override
		public void modyfyjpProblemJ(JimoonProblemCommand problem) throws SQLException {
			session.update("Teacher-Mapper.modyfyjpProblemJ",problem);

		}

		//끝단원 검색
		@Override
		public List<ClassProgVO> endDanSearch(String startDan, String detailCode) throws SQLException {
			Map<String,String>data=new HashMap<String,String>();
			data.put("startDan",startDan);
			data.put("detailCode",detailCode);
			return session.selectList("Teacher-Mapper.endDanSearch",data);
		}

		//지문 검색이요~
		@Override
		public List<String>jimoonSearch(String startDan, String enddan2, String probCnt) throws SQLException {
			Map<String,String>data=new HashMap<String,String>();
			data.put("startDan",startDan);
			data.put("endDan",enddan2);
			data.put("probCnt",probCnt);
			return session.selectList("Teacher-Mapper.jimoonSearch",data);
		}



		@Override
		public List<Map<String, Object>> getProcess(String id) throws SQLException {
			// TODO Auto-generated method stub
			return session.selectList("Teacher-Mapper.getProcess",id);
		}

		@Override
		public List<ProblemVO> getProblemList(Map<String, Object> data) throws SQLException {
			// TODO Auto-generated method stub
			return session.selectList("Teacher-Mapper.getProblemList",data);
		}

		@Override
		public List<ProblemVO> getjimoonProblem(String problemPrintCode) throws SQLException {

			return session.selectList("Teacher-Mapper.getjimoonProblem",problemPrintCode);
		}

		@Override
		public List<ProblemVO> problemJXsdedList(String startDan, String enddan, String detailCode, Criteria cri){

		//강의명으로 강의 코드 가져오기


     int startRow = cri.getStartRowNum();
		int endRow = startRow+cri.getPerPageNum();



		Map<String, Object> dataParam = new HashMap<String, Object>();
		dataParam.put("startRow", startRow);
		dataParam.put("endRow", endRow);

		dataParam.put("startDan",startDan);
		dataParam.put("enddan",enddan);
		dataParam.put("detailCode",detailCode);

		System.out.println(dataParam);

	   return session.selectList("Teacher-Mapper.problemJXsdedList",dataParam);
		}

		@Override
		public int problemJXsdedListCount(String startDan, String enddan, String detailCode, Criteria cri)
				throws SQLException {
			int startRow = cri.getStartRowNum();
			int endRow = startRow+cri.getPerPageNum()-1;



			Map<String, Object> dataParam = new HashMap<String, Object>();
			dataParam.put("startRow", startRow);
			dataParam.put("endRow", endRow);

			dataParam.put("startDan",startDan);
			dataParam.put("enddan",enddan);
			dataParam.put("detailCode",detailCode);
			return session.selectOne("Teacher-Mapper.problemJXsdedListCount",dataParam);
		}

		@Override
		public List<ProblemVO> problemJsdedList(String startDan, String enddan, String detailCode, Criteria cri){
		  int startRow = cri.getStartRowNum();
				int endRow = startRow+cri.getPerPageNum();



				Map<String, Object> dataParam = new HashMap<String, Object>();
				dataParam.put("startRow", startRow);
				dataParam.put("endRow", endRow);

				dataParam.put("startDan",startDan);
				dataParam.put("enddan",enddan);
				dataParam.put("detailCode",detailCode);

				System.out.println(dataParam);

			   return session.selectList("Teacher-Mapper.problemJsdedList",dataParam);
		}

		@Override
		public int problemJsdedListCount(String startDan, String enddan, String detailCode, Criteria cri)
				throws SQLException {
			int startRow = cri.getStartRowNum();
			int endRow = startRow+cri.getPerPageNum()-1;



			Map<String, Object> dataParam = new HashMap<String, Object>();
			dataParam.put("startRow", startRow);
			dataParam.put("endRow", endRow);

			dataParam.put("startDan",startDan);
			dataParam.put("enddan",enddan);
			dataParam.put("detailCode",detailCode);
			return session.selectOne("Teacher-Mapper.problemJsdedListCount",dataParam);
		}

		@Override
		public int examCodeSequenceGet() throws SQLException {
			// TODO Auto-generated method stub
			return session.selectOne("Teacher-Mapper.examCodeSequenceGet");
		}

		@Override
		public int examInsert(Map<String, Object> data) throws SQLException {
			// TODO Auto-generated method stub
			return session.insert("Teacher-Mapper.examInsert",data);
		}

		@Override
		public void colExamInsert(Map<String, Object> data) throws SQLException {
			session.insert("Teacher-Mapper.colExamInsert",data);

		}


		//문제를 신고하는 메서드
		@Override
		public void repotProblem(String prC, String id, String comment) throws SQLException {
			Map<String,Object>data=new HashMap<String,Object>();
			data.put("prC",prC);
			data.put("id",id);
			data.put("comment",comment);
			session.update("Teacher-Mapper.repotProblem",data);

		}


		//문제코드로 시험 정보가져오기.
		@Override
		public List<ExamVO> recentlyExam(int prC) throws SQLException {

			return session.selectList("Teacher-Mapper.recentlyExam",prC);
		}

		@Override
		public int examTotalCount(int examCode) throws SQLException {

			return session.selectOne("Teacher-Mapper.examTotalCount", examCode);
		}

		@Override
		public int wrongTotalCount(int examCode, int prC) throws SQLException {
			Map<String,Object>data=new HashMap<String,Object>();
			data.put("examCode",examCode);
			data.put("problemCode",prC);
			return session.selectOne("Teacher-Mapper.wrongTotalCount",data);
		}


		@Override
		public List<ExamVO> rankExam(int prC, String rankk) throws SQLException {
			Map<String,Object>data=new HashMap<String,Object>();
			data.put("rankk",rankk);
			data.put("prC",prC);
			return session.selectList("Teacher-Mapper.rankExam",data);
		}

		@Override
		public void repotProblemCanCel(String prC) throws SQLException {
			session.update("Teacher-Mapper.repotProblemCanCel",prC);
			
		}

		@Override
		public List<ProblemVO> repotproblemlist(String id) throws SQLException {
			// TODO Auto-generated method stub
			return session.selectList("Teacher-Mapper.repotproblemlist",id);
		}

		@Override
		public List<ProblemVO> printCodeSearchProblem(String pc) throws SQLException {
		
			return session.selectList("Teacher-Mapper.printCodeSearchProblem",pc);
		}

		@Override
		public boolean jcheck(ProblemVO problemVO) throws SQLException {
			boolean flag=true;
			
			int cnt=session.selectOne("Teacher-Mapper.jcheck",problemVO.getProblemCode());
			if(cnt==0) {
				flag=false;
			}else {
				flag=true;
			}
			return flag;
		}

		@Override
		public List<ExamVO> getExamClassCode(String classCode) throws SQLException {
			   
			return session.selectList("Teacher-Mapper.getExamClassCode", classCode);
		}

		@Override
		public String getExamEndDAN(int examCode) throws SQLException {
			// TODO Auto-generated method stub
			return session.selectOne("Teacher-Mapper.getExamEndDAN",examCode);
		}

		@Override
		public String getExamStartDAN(int examCode) throws SQLException {
			// TODO Auto-generated method stub
			return session.selectOne("Teacher-Mapper.getExamStartDAN",examCode);
		}

		@Override
		public int getAcScoreSc(int examCode) throws SQLException {
			int cnt=0;
			if(session.selectOne("Teacher-Mapper.getAcScoreSc",examCode)!=null) {
				cnt=session.selectOne("Teacher-Mapper.getAcScoreSc",examCode);
			}
			return cnt;
		}
		
		
		//시험에서의 학생의 총합 점수
		@Override
		public int getAcTotalSc(int examCode) throws SQLException {
			// TODO Auto-generated method stub
			int cnt=0;
			if(session.selectOne("Teacher-Mapper.getAcTotalSc",examCode)==null) {
				
			}else {
				cnt=session.selectOne("Teacher-Mapper.getAcTotalSc",examCode);
			}
			return cnt;
		}
		
		//시험지로 문제 가지고오기.
		@Override
		public List<ProblemVO> getExamProblem(String examCode) throws SQLException {
			
			return session.selectList("Teacher-Mapper.getExamProblem",examCode);
		}

		
		
		
		@Override
		public ClassProgVO danwonSearch2(String name) throws SQLException {
			// TODO Auto-generated method stub
			return session.selectOne("Teacher-Mapper.danwonSearch2",name);
		}

		@Override
		public int examAllList(String id, SearchCriteria cri) throws SQLException {
		    int startRow = cri.getStartRowNum();
						int endRow = startRow+cri.getPerPageNum()-1;

						SearchCriteria searchCri = (SearchCriteria)cri;

						Map<String, Object> dataParam = new HashMap<String, Object>();
						dataParam.put("startRow", startRow);
						dataParam.put("endRow", endRow);
						
						dataParam.put("searchType", searchCri.getSearchType());
						dataParam.put("keyword", searchCri.getKeyword());
						dataParam.put("id",id);
						
						if(searchCri.getSearchType()!=null&&searchCri.getSearchType()!=null) {
							return session.selectOne("Teacher-Mapper.examAllList2", dataParam);
						}
			return session.selectOne("Teacher-Mapper.examAllList",dataParam);
		}

		@Override
		public List<ExamVO> examAllListgo(String id, SearchCriteria cri) throws SQLException {
			 int startRow = cri.getStartRowNum();
				int endRow = startRow+cri.getPerPageNum()-1;

				SearchCriteria searchCri = (SearchCriteria)cri;

				Map<String, Object> dataParam = new HashMap<String, Object>();
				dataParam.put("startRow", startRow);
				dataParam.put("endRow", endRow);
				dataParam.put("searchType", searchCri.getSearchType());
				dataParam.put("keyword", searchCri.getKeyword());
				dataParam.put("id",id);
				System.out.println("검색 데이터:"+dataParam);
				if(searchCri.getSearchType()!=null&&searchCri.getSearchType()!=null) {
					return session.selectList("Teacher-Mapper.examAllListgo2", dataParam);
				}
				
				
			return session.selectList("Teacher-Mapper.examAllListgo", dataParam);
		}

		@Override
		public List<ClassVO> getListClass(String id) throws SQLException {
			// TODO Auto-generated method stub
			return session.selectList("Teacher-Mapper.getListClass",id);
		}
		
		
		//시험코드로 오답 가져오기.
		@Override
		public List<WrongVO> getExamCodeWrong(String examCode) throws SQLException {
			// TODO Auto-generated method stub
			return session.selectList("Teacher-Mapper.getExamCodeWrong", examCode);
		}

		@Override
		public WrongVO wrongGet(String examCode) throws SQLException {
			// TODO Auto-generated method stub
			return session.selectOne("Teacher-Mapper.wrongGet", examCode);
		}

		@Override
		public int inserWrongAnswer(Map<String, Object> data) throws SQLException {
			// TODO Auto-generated method stub
			return session.update("Teacher-Mapper.inserWrongAnswer", data);
		}

		@Override
		public List<ExamVO> AllExam(int problemCode) throws SQLException {
			// TODO Auto-generated method stub
			return session.selectList("Teacher-Mapper.AllExam", problemCode);
		}

		@Override
		public List<AcademyScoreVO> examListGet(Map<String, Object> data) throws SQLException {
			
			return session.selectList("Teacher-Mapper.examListGet",data);
		}

		@Override
		public List<ClassVO> getclassClist(String id) throws SQLException {
			// TODO Auto-generated method stub
			return session.selectList("Teacher-Mapper.getclassClist",id);
		}
		
		//
		@Override
		public int getTSSubarea(String id, String string, int examCode) throws SQLException {
			Map<String,Object>data=new HashMap<>();
			data.put("examCode",examCode);
			data.put("subareaName",string);
			return session.selectOne("Teacher-Mapper.getTSSubarea",data);
		}

		@Override
		public int getSSubarea(String id, String string, int examCode) throws SQLException {
			Map<String,Object>data=new HashMap<>();
			data.put("examCode",examCode);
			data.put("subareaName",string);
			data.put("id",id);
			return session.selectOne("Teacher-Mapper.getSSubarea",data);
		}

		@Override
		public List<ExamVO> examAllListgo2(String id, SearchCriteria cri) throws SQLException {
			 int startRow = cri.getStartRowNum();
				int endRow = startRow+cri.getPerPageNum()-1;

				SearchCriteria searchCri = (SearchCriteria)cri;

				Map<String, Object> dataParam = new HashMap<String, Object>();
				dataParam.put("startRow", startRow);
				dataParam.put("endRow", endRow);
				dataParam.put("searchType", searchCri.getSearchType());
				dataParam.put("keyword", searchCri.getKeyword());
				dataParam.put("id",id);
				
				if(searchCri.getSearchType()!=null&&searchCri.getSearchType()!=null) {
					return session.selectList("Teacher-Mapper.examAllListgo4", dataParam);
				}
				
				
			return session.selectList("Teacher-Mapper.examAllListgo3", dataParam);
		}

		@Override
		public int searchSanoCode(Map<String, Object> data) throws SQLException {
			// TODO Auto-generated method stub
			return session.selectOne("Teacher-Mapper.searchSanoCode", data);
		}

		
	

		
	
		

		
		




}

package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSessionException;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.ExamInsertCommand;
import kr.or.ddit.command.JimoonProblemCommand;
import kr.or.ddit.command.PageMaker;
import kr.or.ddit.command.ProblemSearchCommand;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dao.TeacherDAO;
import kr.or.ddit.dto.AcademyScoreVO;
import kr.or.ddit.dto.ClassProgVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.ProblemVO;
import kr.or.ddit.dto.SchoolScoreVO;
import kr.or.ddit.dto.WrongVO;



public class TeacherServiceImpl implements TeacherService{
	 private TeacherDAO teacherDAO;
	    public void setTeacherDAO(TeacherDAO teacherDAO) {
			this.teacherDAO = teacherDAO;
		}

	@Override
	public List<String> processSearch(String id)throws SQLException {
		List<String>processList=null;
		processList=teacherDAO.processSearch(id);
		return processList;
	}
	@Override
	public Map<String, Object> processStudentList(String processName,Criteria cri)throws SQLException{
		 int class_code= teacherDAO.classCode(processName);
        // System.out.println(class_code);

		 Map<String, Object> dataMap=null;

		try {
			 dataMap = new HashMap<String, Object>();

			// 현재 page 번호에 맞는 리스트를 perPageNum 개수 만큼 가져오기.
			List<MemberVO> processStudentList = teacherDAO.processStudentList(processName,cri);

			// 전체 board 개수
			int totalCount = teacherDAO.selectprocessStudentlistCount(class_code, cri);

			// PageMaker 생성.
	    	PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(totalCount);

			dataMap.put("processStudentList", processStudentList);
			dataMap.put("pageMaker", pageMaker);


		}catch(SQLException e) {}


		return dataMap;
		//return null;
	}
	//전체 학생리스트
	@Override
	public Map<String, Object> processStudentList2(String ms, SearchCriteria cri) throws SQLException {
		 //int class_code= teacherDAO.classCode(processName);
	        // System.out.println(class_code);

			 Map<String, Object> dataMap=null;

			try {
				 dataMap = new HashMap<String, Object>();

				// 현재 page 번호에 맞는 리스트를 perPageNum 개수 만큼 가져오기.
				List<MemberVO> processStudentList = teacherDAO.processStudentList2(cri);

				// 전체 board 개수
				int totalCount = teacherDAO.selectprocessStudentlistCount2(cri);

				// PageMaker 생성.
		    	PageMaker pageMaker = new PageMaker();
				pageMaker.setCri(cri);
				pageMaker.setTotalCount(totalCount);

				dataMap.put("processStudentList", processStudentList);
				dataMap.put("pageMaker", pageMaker);


			}catch(SQLException e) {}


			return dataMap;
	}
	
	
	
	@Override
	public List<String> getclassList(String id) {
		// TODO Auto-generated method stub
		return teacherDAO.searchClass(id);
	}

	@Override
	public MemberVO teacherstudentDetail(String id) throws SQLException {
		// TODO Auto-generated method stub
		return teacherDAO.teacherstudentDetail(id);
	}

	@Override
	public Map<String, Object> teacherstudenttotalList(String id,SearchCriteria cri) throws SQLException {
//		if(cri.getSearchType()==null) {
//			cri.setSearchType("");
//		}
//		if(cri.getKeyword()==null) {
//			cri.setKeyword("");
//		}
		int totalCount = teacherDAO.teacherstudenttotalListcount(id,cri);

		List<MemberVO>studentTotalList=teacherDAO.teacherstudenttotalList(id,cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		 Map<String, Object> dataMap=new HashMap<String, Object>();
;
		dataMap.put("studentTotalList", studentTotalList);
		dataMap.put("pageMaker", pageMaker);



		return dataMap;
	}

	@Override
	public Map<String,String> idSearchName(String id) throws SQLException {
		Map<String,String>dt=new HashMap<String,String>();
		dt.put("name",teacherDAO.idSearchName(id));
		dt.put("subject",teacherDAO.idSearchSubject(id));
		return dt;
	}


	//문제 검색~~!!
	@Override
	public  Map<String, Object> problemList(String id,ProblemSearchCommand cri) throws SQLException {
		 Map<String, Object> dataMap=null;
			String subject=teacherDAO.idSearchSubject(id);
			
	
			
			
			
			PageMaker pageMaker = new PageMaker();
			try {
				 dataMap = new HashMap<String, Object>();

				// 현재 page 번호에 맞는 리스트를 perPageNum 개수 만큼 가져오기.

				 	


					    List<ProblemVO> ProblemPXList = teacherDAO.problemPXList(cri,subject,id);
					    
					    if(ProblemPXList!=null&&ProblemPXList.size()>0) {
					    	for(ProblemVO pr:ProblemPXList) {
					    		List<ExamVO> allExam=teacherDAO.AllExam(pr.getProblemCode());
					    		if(allExam!=null&&allExam.size()>0) {
					    			
					    				int total=0;
					    				int wroncnt=0;
					    				double odap=0;
					    			  for(ExamVO ex:allExam) {
					    		    		//시험 코드
					    		    		int examCode=ex.getExamCode();
					    		    		//시험에 응시한 인원
					    		    		 total+=teacherDAO.examTotalCount(examCode);

					    		    		//시험을틀린 인원
					    		    		 wroncnt+=teacherDAO.wrongTotalCount(examCode,pr.getProblemCode());
					    		    		
					    		    	
					    		    		
					    		}
					    			  if(total!=0) {
				    		    			odap=Math.round((((double)wroncnt/total)*100.0)/100.0)*100;
				    		    			pr.setOdap(odap);
				    		    		}
					    	}
					    }
					    
					    
					    }   
					    
					    
					    
						// 전체 board 개수
						int PXtotalCount = teacherDAO.PXtotalcnt(cri,subject);
						System.out.println(ProblemPXList);
						pageMaker.setCri(cri);
						pageMaker.setTotalCount(PXtotalCount);
						dataMap.put("ProblemPXList",ProblemPXList);
						dataMap.put("pageMaker", pageMaker);




				// PageMaker 생성.

			//	pageMaker.setCri(cri);
			//	pageMaker.setTotalCount(PXtotalCount);
					    


			}catch(SQLException e) {}

		return dataMap;
	}

	@Override
	public List<SchoolScoreVO> schoolGrade(String id) throws SQLException {
		List<SchoolScoreVO> schoolScoreList=teacherDAO.schoolGrade(id);

		return schoolScoreList;
	}

	@Override
	public Map<String, Object> createGdata(String id) throws SQLException {

		//로그인한 선생님의 과목 코드 불러오기
		String subjectCode=teacherDAO.idSearchSubjectCode(id);
		System.out.println("subjectCode:"+subjectCode);

		//과목코드로 세부과목 검색하기
		List<Map<String,Object>>subjectDetail=teacherDAO.subjectCodeSearchDetailName(subjectCode);
		System.out.println("subjectDetail:"+subjectDetail);

		//유형 검색하기
		List<Map<String,String>>subareaList=null;
		if(subjectDetail.size()!=0) {
			Map<String,Object>dd=subjectDetail.get(0);
			System.out.println("dd:"+dd);

			if(dd==null) {

			}else {
				String subcode=String.valueOf(dd.get("SUBDETAIL_CODE"));
				System.out.println(subcode);
				subareaList=teacherDAO.detailCodeSearchSarea(subcode);
				System.out.println("subareaList:"+subareaList);
			}

		}




		Map<String,Object>data=new HashMap<String,Object>();

		List<String>subDetailNameList=new ArrayList<String>();

		List<String>subAreaList=new ArrayList<String>();

		if(subjectDetail!=null&&subjectDetail.size()>0) {
			for(Map<String,Object>ss:subjectDetail) {
				System.out.println(ss);
				subDetailNameList.add(String.valueOf(ss.get("SUBDETAIL_NAME")));
			}
		}

		if(subareaList!=null&&subareaList.size()>0) {
			for(Map<String,String>ss:subareaList) {
				subAreaList.add(ss.get("saname"));
			}
		}
		System.out.println(subjectDetail);
		System.out.println("subAreaList"+subAreaList);
		System.out.println("subDetailNameList:"+subDetailNameList);
		data.put("subAreaList",subareaList);
		data.put("subnamecode",subjectDetail);
		return data;
	}

	@Override
	public List<ClassProgVO> danSearch(String name) throws SQLException {

		List<ClassProgVO> danList=teacherDAO.danSearch(name);
		System.out.println("서비스에서 단원 조사 danList:"+danList);
		return danList;
	}
	
	@Override
	public List<ClassProgVO> danSearch2(String detailCode) throws SQLException {
		List<ClassProgVO> danList=teacherDAO.danSearch2(detailCode);
		
		return danList;
	}
	//문제 등록 메서드
	@Override
	public int insertProblem(ProblemVO problem) throws SQLException {
		  int cnt=0;
		  int proC=teacherDAO.problemSequence();
		  problem.setProblemCode(proC);
		  System.out.println("확인해봅시다 무엇을 이것을~!!"+problem);
		 
		  
		
		  cnt=teacherDAO.insertProblem(problem);
		return cnt;
	}

	@Override
	public int insertJProblem(JimoonProblemCommand problem) throws SQLException {
		  int cnt=0;
		  int proC1=teacherDAO.problemSequence();
		  ProblemVO pro1=problem.toproblem1();
		
		  pro1.setProblemCode(proC1);
		  pro1.setSano(searchSanoCode(problem.getSaname()[0],problem.getSubdetailCode()));
		 
		
		  if(teacherDAO.insertProblem(pro1)<=0) {
			  return 0;
		  }
		  int proC2=teacherDAO.problemSequence();
		  ProblemVO pro2=problem.toproblem2();
		  pro2.setProblemCode(proC2);
		  pro2.setSano(searchSanoCode(problem.getSaname()[1],problem.getSubdetailCode()));
		 
		 
		  if(teacherDAO.insertProblem(pro2)<=0) {
			  return 0;
		  }

		  int jimoonNum=teacherDAO.jimoonSequece();
		  if(teacherDAO.insertjimoonProblem(jimoonNum,proC1,problem.getProblemPrint())<=0) {
			  return 0;
		  }
		  if(teacherDAO.insertjimoonProblem2(jimoonNum,proC2)<=0) {
			  return 0;
		  }


		return cnt;
	}

	//문제 가졍오기
	@Override
	public Map<String, Object> getProblem(int prC) throws SQLException {
	      ProblemVO problem=teacherDAO.getProblem(prC);
	      //가지고온 시험들(문제를 사용한)
	      List<ExamVO> exam=teacherDAO.recentlyExam(prC);

	      List<ExamVO>aRexam=teacherDAO.rankExam(prC,"A");
	      List<ExamVO>bRexam=teacherDAO.rankExam(prC,"B");
	      List<ExamVO>cRexam=teacherDAO.rankExam(prC,"C");
	      

	      



	      //최근시험 
	      if(exam!=null||exam.size()>0) {
	    	  for(ExamVO ex:exam) {
	    		//시험 코드
	    		int examCode=ex.getExamCode();
	    		//시험에 응시한 인원
	    		int total=teacherDAO.examTotalCount(examCode);

	    		//시험을틀린 인원
	    		int worong=teacherDAO.wrongTotalCount(examCode,prC);
	    		System.out.println("총 인원:"+total);
	    		System.out.println("틀린 갯수:"+worong);
	    		double odap=0;
	    		if(total!=0) {
	    			odap=Math.round((((double)worong/total)*100.0)/100.0)*100;

	    		}

	    		ex.setProblemOdap(odap);
	    	  }
	      }
	      int totalA=0;
	      int worongA=0;
	      double odapA=0;
	      if(aRexam!=null||aRexam.size()>0) {
	    	  for(ExamVO ex:aRexam) {
	    		  //시험 코드
	    		  int examCode=ex.getExamCode();
	    		  
	    		  //시험에 응시한 인원
	    		   totalA+=teacherDAO.examTotalCount(examCode);
	    		  
	    		   //시험에 틀린인원
	    		  worongA+=teacherDAO.wrongTotalCount(examCode,prC);
	    		    
	    	  }
	    	  
	      }
	      if(totalA!=0) {
	    	  odapA=Math.round((((double)worongA/totalA)*100.0)/100.0)*100;
	      }
	      int totalB=0;
	      int worongB=0;
	      double odapB=0;
	      if(bRexam!=null||bRexam.size()>0) {
	    	  for(ExamVO ex:bRexam) {
	    		  //시험 코드
	    		  int examCode=ex.getExamCode();
	    		  
	    		  //시험에 응시한 인원
	    		   totalB+=teacherDAO.examTotalCount(examCode);
	    		  
	    		   //시험에 틀린인원
	    		  worongB+=teacherDAO.wrongTotalCount(examCode,prC);
	    		    
	    	  }
	    	  
	      }
	      if(totalB!=0) {
	    	  odapB=Math.round((((double)worongB/totalB)*100.0)/100.0)*100;
	      }
	      int totalC=0;
	      int worongC=0;
	      double odapC=0;
	      if(cRexam!=null||cRexam.size()>0) {
	    	  for(ExamVO ex:cRexam) {
	    		  //시험 코드
	    		  int examCode=ex.getExamCode();
	    		  
	    		  //시험에 응시한 인원
	    		   totalC+=teacherDAO.examTotalCount(examCode);
	    		  
	    		   //시험에 틀린인원
	    		  worongC+=teacherDAO.wrongTotalCount(examCode,prC);
	    		    
	    	  }
	    	  
	      }
	      if(totalC!=0) {
	    	  System.out.println("TOTALC:"+totalC);
	    	  System.out.println("오답토탈:"+worongC);
	    	  odapC=Math.round((((double)worongC/totalC)*100.0)/100.0)*100;
	    	 
	      }
	      
	      
	      String fidback="데이터가 부족합니다.";
	     
	      if(aRexam.size()!=0&&bRexam.size()!=0&&cRexam.size()!=0) {
	    	  int cnt=0;
	    	  if(problem.getPlevel().equals("하")) {
	    		  if(odapA>=10) {
	    			  cnt+=1;
	    		  }
	    		  if(odapB>=15) {
	    			  cnt+=1;
	    		  }
	    		  if(odapC>=30) {
	    			  cnt+=1;
	    		  }
	    		  if(cnt==3) {
	    			  fidback="난이도가 적절치 않음";
	    		  }
	    		  if(cnt==2) {
	    			  fidback="난이도가 의심됩니다.";
	    		  }
	    		  if(cnt==1) {
	    			  fidback="난이도가 적절합니다.";
	    		  }
	    		  if(cnt==0) {
	    			  fidback="난이도가 매우 정확합니다.";
	    		  }
	    	  }
	    	  if(problem.getPlevel().equals("중")) {
	    		  if(odapA>=40) {
	    			  cnt+=1;
	    		  }
	    		  if(odapB>=50) {
	    			  cnt+=1;
	    		  }
	    		  if(odapC>=70) {
	    			  cnt+=1;
	    		  }
	    		  if(cnt==3) {
	    			  fidback="난이도가 적절치 않음";
	    		  }
	    		  if(cnt==2) {
	    			  fidback="난이도가 의심됩니다.";
	    		  }
	    		  if(cnt==1) {
	    			  fidback="난이도가 적절합니다.";
	    		  }
	    		  if(cnt==0) {
	    			  fidback="난이도가 매우 정확합니다.";
	    		  }
	    	  }
	    	  if(problem.getPlevel().equals("상")) {
	    		  if(odapA<40) {
	    			  cnt+=1;
	    		  }
	    		  if(odapB<50) {
	    			  cnt+=1;
	    		  }
	    		  if(odapC<70) {
	    			  cnt+=1;
	    		  }
	    		  if(cnt==3) {
	    			  fidback="난이도가 적절치 않음";
	    		  }
	    		  if(cnt==2) {
	    			  fidback="난이도가 의심됩니다.";
	    		  }
	    		  if(cnt==1) {
	    			  fidback="난이도가 적절합니다.";
	    		  }
	    		  if(cnt==0) {
	    			  fidback="난이도가 매우 정확합니다.";
	    		  }
	    	  }
	      }
	      
	      
	    
	      
	      String jimoon=teacherDAO.getJimoon(prC);
	      Map<String,Object>data=new HashMap<String,Object>();
	      data.put("problem",problem);
	      data.put("jimoon",jimoon);
	      data.put("exam",exam);

	      data.put("odapA",odapA);
	      data.put("odapB",odapB);
	      data.put("odapC",odapC);
	      data.put("fidback",fidback);
	      return data; 



	 

	}

	//문제코드로 단원 검색
	@Override
	public String danwonSearch(int prC) throws SQLException {
		// TODO Auto-generated method stub
		return teacherDAO.danwonSearch(prC);
	}

	//문제코드로 세부과목 검색
	@Override
	public String detailSubjecSearch(int prC) throws SQLException {
		// TODO Auto-generated method stub
		return teacherDAO.detailSubjecSearch(prC);
	}


	//지문 없는 문제 수정
	@Override
	public int modifyProblem(ProblemVO problem) throws SQLException {
		  int cnt=0;

		  cnt=teacherDAO.modfyProblem(problem);
		return cnt;
	}


	//지문문제 업데이트
	@Override
	public int updateJProblem(JimoonProblemCommand problem) throws SQLException {
		int prC=problem.getProblemCode();
		String lproblem=problem.getLproblem1();
		System.out.println("문제유형:"+lproblem);
		//문제코드로 같은 지문을 쓰는 문제 코드 가져오기
		List<Integer>prClist=teacherDAO.prCSearchprC(prC);
           Collections.sort(prClist);
		//문제코드로 지문 코드 가져오기
		System.out.println("문제코드:"+prC);

		int problemPrintCode=teacherDAO.prCSearchPrintCode(prC);

		int cnt=1;
		if(lproblem.equals("객관식")) {
			if(problem.getPicture1()==null||problem.getPicture1().trim()=="") {
				teacherDAO.modyfyjProblemG(problem);
			}else {
				teacherDAO.modyfyjpProblemG(problem);
			}

		}else {
			if(problem.getPicture1()==null||problem.getPicture1().trim()=="") {
				teacherDAO.modyfyjProblemJ(problem);
			}else {
				teacherDAO.modyfyjpProblemJ(problem);
			}

		}

		Map<String,String> dataMap=new HashMap<String,String>();
		if(prClist!=null&&prClist.size()!=0) {
		
				
				dataMap.put("prC",prClist.get(0)+"");
				dataMap.put("jimoon",problem.getProblemPrint());
				dataMap.put("jiC",problemPrintCode+"");
				teacherDAO.problemPrintUpdate(dataMap);
			
		}





		return 0;
	}

	@Override
	public List<ClassProgVO> endDanSearch(String startDan, String className) throws SQLException {

		return teacherDAO.endDanSearch(startDan,className);
	}

	@Override
	public List<List<ProblemVO>> getRandomJimoonProblem(String startDan, String enddan2,  String probCnt,String detailCode)
			throws SQLException {
		List<String>jimoonListCode=teacherDAO.jimoonSearch(startDan,enddan2,detailCode);
		List<List<ProblemVO>>problemListList=new ArrayList<>();
		//잘 들어왓다.~~!
		if(jimoonListCode.size()>0) {
			for(int i=0;i<jimoonListCode.size();i++) {
				//지문코드와 그에 연결되있는 문제를 가져오기.
				List<ProblemVO>jimoomProblemSet=teacherDAO.printCodeSearchProblem(jimoonListCode.get(i));
				problemListList.add(jimoomProblemSet);
				//		System.out.println(i+"번째 문제세트:"+jimoomProblemSet);
			}
		}
		//지문 문제 뽑아놓은 세트 랜덤으로 섞기
		List<List<ProblemVO>>randomProblemListList=new ArrayList<>();
		
		//컨트롤러로 보낼 랜덤문제들
		List<List<ProblemVO>>sendrandomProblemListList=new ArrayList<>();
		
		List<Integer>numList=new ArrayList<>();
		if(problemListList.size()>0) {
			for(int i=0;i<problemListList.size();i++) {
				numList.add(i);
			}
		     Collections.shuffle(numList);
		     
		    
		     
		     
		 	if(Integer.parseInt(probCnt)==20) {
		 		List<ProblemVO>problemListgj=getProblemList(startDan,enddan2,10,detailCode);
		 		 randomProblemListList.add(problemListList.get(numList.get(0)));
		 		 randomProblemListList.add(problemListList.get(numList.get(1)));
		 		 randomProblemListList.add(problemListList.get(numList.get(2)));
		 		 randomProblemListList.add(problemListList.get(numList.get(3)));
		 		 randomProblemListList.add(problemListList.get(numList.get(4)));
		 		sendrandomProblemListList.add(randomProblemListList.get(0));
		 		sendrandomProblemListList.add(randomProblemListList.get(1));
		 		List<ProblemVO>p1=new ArrayList<>();
		 		p1.add(problemListgj.get(0));
		 		p1.add(problemListgj.get(1));
		 		p1.add(problemListgj.get(2));
		 		p1.add(problemListgj.get(3));
		 		sendrandomProblemListList.add(p1);
		 		sendrandomProblemListList.add(randomProblemListList.get(2));
		 		sendrandomProblemListList.add(randomProblemListList.get(3));
		 		List<ProblemVO>p2=new ArrayList<>();
		 		p2.add(problemListgj.get(4));
		 		p2.add(problemListgj.get(5));
		 		p2.add(problemListgj.get(6));
		 		p2.add(problemListgj.get(7));
		 		sendrandomProblemListList.add(p2);
		 		sendrandomProblemListList.add(randomProblemListList.get(4));
		 		List<ProblemVO>p3=new ArrayList<>();
		 		p3.add(problemListgj.get(8));
		 		p3.add(problemListgj.get(9));
		 		
		 		sendrandomProblemListList.add(p3);
			}
		 	if(Integer.parseInt(probCnt)==25) {
List<ProblemVO>problemListgj=getProblemList(startDan,enddan2,13,detailCode);
randomProblemListList.add(problemListList.get(numList.get(0)));
 randomProblemListList.add(problemListList.get(numList.get(1)));
 randomProblemListList.add(problemListList.get(numList.get(2)));
 randomProblemListList.add(problemListList.get(numList.get(3)));
 randomProblemListList.add(problemListList.get(numList.get(4)));
 randomProblemListList.add(problemListList.get(numList.get(5)));
		 		sendrandomProblemListList.add(randomProblemListList.get(0));
		 		sendrandomProblemListList.add(randomProblemListList.get(1));
		 		List<ProblemVO>p1=new ArrayList<>();
		 		p1.add(problemListgj.get(0));
		 		p1.add(problemListgj.get(1));
		 		p1.add(problemListgj.get(2));
		 		p1.add(problemListgj.get(3));
		 		sendrandomProblemListList.add(p1);
		 		sendrandomProblemListList.add(randomProblemListList.get(2));
		 		sendrandomProblemListList.add(randomProblemListList.get(3));
		 		List<ProblemVO>p2=new ArrayList<>();
		 		p2.add(problemListgj.get(4));
		 		p2.add(problemListgj.get(5));
		 		p2.add(problemListgj.get(6));
		 		p2.add(problemListgj.get(7));
		 		sendrandomProblemListList.add(p2);
		 		sendrandomProblemListList.add(randomProblemListList.get(4));
		 		List<ProblemVO>p3=new ArrayList<>();
		 		p3.add(problemListgj.get(8));
		 		p3.add(problemListgj.get(9));
		 		p3.add(problemListgj.get(10));
		 		p3.add(problemListgj.get(11));
		 		sendrandomProblemListList.add(p3);
		 		sendrandomProblemListList.add(randomProblemListList.get(5));
		 		List<ProblemVO>p4=new ArrayList<>();
		 		p4.add(problemListgj.get(12));
		 	
		 		sendrandomProblemListList.add(p4);
			}
		}
		int cnt=0;
		for(int i=0;i<sendrandomProblemListList.size();i++) {
			cnt+=sendrandomProblemListList.get(i).size();
		}
		//System.out.println("토탈 문제수입니다.:"+cnt);
		//  System.out.println("여기는 지문다오에서 실험하고있다.~~1"+jimoonListCode);
			
		
		




		return sendrandomProblemListList;
	}

	@Override
	public List<Map<String, Object>> getProcess(String id) throws SQLException {


		return teacherDAO.getProcess(id);
	}


	//주어진 갯수의 문제가져오기(지문x)
	@Override
	public List<ProblemVO> getProblemList(String startDan, String enddan2, int k, String detailCode)
			throws SQLException {
		  Map<String,Object>data=new HashMap<String,Object>();
	      data.put("starDan",startDan);
	      data.put("endDan",enddan2);
	      data.put("detailCode",detailCode);
	      //지문없는 문제가져오기
	      List<ProblemVO>problemList=teacherDAO.getProblemList(data);
	      List<ProblemVO>randomProblemList=new ArrayList<>();
	      HashSet<Integer>numset=new HashSet<>();
	      if(k>problemList.size()) {
	    	   problemList=null;
			}else {
				while(numset.size()<k) {
					int ran=(int)(Math.random()*problemList.size());
					numset.add(ran);
				}
				ArrayList<Integer>numList=new ArrayList<>(numset);
				Collections.shuffle(numList);
				for(int i=0;i<numList.size();i++) {
					randomProblemList.add(problemList.get(numList.get(i)));
				}
			}


//		return teacherDAO.getProblemList;
		  return randomProblemList;



	}

	//지문없는 문제 리스트
	@Override
	public Map<String, Object>  problemJXsdedList(String startDan, Criteria cri, String enddan, String detailCode){

    // System.out.println(class_code);

	 Map<String, Object> dataMap=null;

	try {
		 dataMap = new HashMap<String, Object>();

		// 현재 page 번호에 맞는 리스트를 perPageNum 개수 만큼 가져오기.

		List<ProblemVO> problemList = teacherDAO.problemJXsdedList(startDan,enddan,detailCode,cri);
		System.out.println("=================================================================");
		System.out.println(problemList);
		System.out.println("=================================================================");		// 전체 board 개수
		int totalCount = teacherDAO.problemJXsdedListCount(startDan,enddan,detailCode,cri);
         System.out.println("총 숫자:"+totalCount);
		// PageMaker 생성.
    	PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
    		pageMaker.setTotalCount(totalCount);

		dataMap.put("problemList", problemList);
		dataMap.put("pageMaker", pageMaker);


	}catch(SQLException e) {}


	return dataMap;

	}


	//지문있는 문제리스트
	@Override
	public Map<String, Object> problemJsdedList(String startDan, Criteria cri, String enddan, String detailCode){
	 Map<String, Object> dataMap=null;

		try {
			 dataMap = new HashMap<String, Object>();

			// 현재 page 번호에 맞는 리스트를 perPageNum 개수 만큼 가져오기.

			List<ProblemVO> problemList = teacherDAO.problemJsdedList(startDan,enddan,detailCode,cri);
			System.out.println("=================================================================");
			System.out.println(problemList);
			System.out.println("=================================================================");		// 전체 board 개수
			int totalCount = teacherDAO.problemJsdedListCount(startDan,enddan,detailCode,cri);
	         System.out.println("총 숫자:"+totalCount);
			// PageMaker 생성.
	    	PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
	    		pageMaker.setTotalCount(totalCount);

			dataMap.put("problemList", problemList);
			dataMap.put("pageMaker", pageMaker);


		}catch(SQLException e) {}


		return dataMap;
	}

	@Override
	public int examInsertGo(ExamInsertCommand exam) throws SQLException {
		int examCode=teacherDAO.examCodeSequenceGet();
		Map<String,Object>data=new HashMap<String,Object>();
		System.out.println(exam);
		data.put("examStart",exam.getExamStart());
		data.put("examEnd",exam.getExamEnd());
		data.put("examCode",examCode);
		data.put("examName",exam.getExamName());
		data.put("classCode",exam.getClassCode());
		int cnt=teacherDAO.examInsert(data);
		System.out.println("시험 인설트 갯수:"+cnt);
//		for(int i=0;i<Integer.parseInt(exam.getProblemCount());i++){
//			Map<String,Object>dat=new HashMap<String,Object>();
//			dat.put("pronum",(i+1));
//			dat.put("problemCode",exam.getP1());
//			dat.put("examCode",examCode);
//			teacherDAO.colExamInsert(dat);
//		}

		return examCode;
	}

	@Override
	public void colExamgo(int cnt,ExamInsertCommand exam) throws SQLException {
		for(int i=0;i<Integer.parseInt(exam.getProblemCount());i++){
			Map<String,Object>dat=new HashMap<String,Object>();
			dat.put("pronum",(i+1));
			if(i==0) {
				dat.put("problemCode",exam.getP1());
			}
			if(i==1) {
				dat.put("problemCode",exam.getP2());
			}
			if(i==2) {
				dat.put("problemCode",exam.getP3());
			}
			if(i==3) {
				dat.put("problemCode",exam.getP4());
			}
			if(i==4) {
				dat.put("problemCode",exam.getP5());
			}
			if(i==5) {
				dat.put("problemCode",exam.getP6());
			}
			if(i==6) {
				dat.put("problemCode",exam.getP7());
			}
			if(i==7) {
				dat.put("problemCode",exam.getP8());
			}
			if(i==8) {
				dat.put("problemCode",exam.getP9());
			}
			if(i==9) {
				dat.put("problemCode",exam.getP10());
			}
			if(i==10) {
				dat.put("problemCode",exam.getP11());
			}
			if(i==11) {
				dat.put("problemCode",exam.getP12());
			}
			if(i==12) {
				dat.put("problemCode",exam.getP13());
			}
			if(i==13) {
				dat.put("problemCode",exam.getP14());
			}
			if(i==14) {
				dat.put("problemCode",exam.getP15());
			}
			if(i==15) {
				dat.put("problemCode",exam.getP16());
			}
			if(i==16) {
				dat.put("problemCode",exam.getP17());
			}
			if(i==17) {
				dat.put("problemCode",exam.getP18());
			}
			if(i==18) {
				dat.put("problemCode",exam.getP19());
			}
			if(i==19) {
				dat.put("problemCode",exam.getP20());
			}
			if(i==20) {
				dat.put("problemCode",exam.getP21());
			}
			if(i==21) {
				dat.put("problemCode",exam.getP22());
			}
			if(i==22) {
				dat.put("problemCode",exam.getP23());
			}
			if(i==23) {
				dat.put("problemCode",exam.getP24());
			}
			if(i==24) {
				dat.put("problemCode",exam.getP25());
			}


			dat.put("examCode",cnt);
			teacherDAO.colExamInsert(dat);
		}

	}

	@Override
	public void repotProblem(String prC, String id, String comment) throws SQLException {
		 teacherDAO.repotProblem(prC,id,comment);

	}


	@Override
	public void repotProblemCanCel(String prC) throws SQLException {
		teacherDAO.repotProblemCanCel(prC);
		
	}

	@Override
	public List<ProblemVO> repotproblemlist(String id) throws SQLException {
		// TODO Auto-generated method stub
		return teacherDAO.repotproblemlist(id);
	}
	
	
	
	//수동 미리보기 문제 가져오기~!
	@Override
	public List<List<ProblemVO>> previewgetProList(String[] problemCodeList) throws SQLException {
		
		List<List<ProblemVO>>sendproList=new ArrayList<>();
		List<ProblemVO>problemList=new ArrayList<>();
	    for(int i=0;i<problemCodeList.length;i++) {
	    	problemList.add(teacherDAO.getProblem(Integer.parseInt(problemCodeList[i])));
	    }
	   
	    int i=0;
	    while(true) {
	    	 if(teacherDAO.jcheck(problemList.get(i))) {
	 	    	List<ProblemVO>problemli=new ArrayList<>();
	 	    	if(i+2<problemCodeList.length) {
	 	    		problemli.add(problemList.get(i));
	 	    		problemli.add(problemList.get(i+1));
	 	    		sendproList.add(problemli);
	 	    		i+=2;
	 	    	}else {
	 	    		
	 	    		for(int k=i;k<problemCodeList.length;k++) {
	 	    			problemli.add(problemList.get(k));
	 	    			
	 	    			i=problemCodeList.length;
	 	    			
	 	    		}
	 	    		sendproList.add(problemli);
	 	    	}
	 	    	if(i==problemCodeList.length) {
	 	    		break;
	 	    	}
	    }else {
	    	
	    	List<ProblemVO>problemli=new ArrayList<>();
 	    	if(i+4<problemCodeList.length) {
 	    		problemli.add(problemList.get(i));
 	    		problemli.add(problemList.get(i+1));
 	    		problemli.add(problemList.get(i+2));
 	    		problemli.add(problemList.get(i+3));
 	    		sendproList.add(problemli);
 	    		i+=4;
 	    	}else {
 	    		
 	    		for(int k=i;k<problemCodeList.length;k++) {
 	    			problemli.add(problemList.get(k));
 	    		
 	    			i=problemCodeList.length;
 	    			
 	    		}
 	    		sendproList.add(problemli);
 	    	}
	    	
	    	
	    	
	    	
 	   	if(i==problemCodeList.length) {
	    		break;
	    	}
	    	
	    }
	   
	    	
	    	
	    }
	    System.out.println("===================");
	    System.out.println("내가 원하는 대로 들어왔나 확인하기");
	    System.out.println("sendproList사이즈:"+sendproList.size());
	    int cnt=0;
	    for(int t=0;t<sendproList.size();t++) {
	    	for(int j=0;j<sendproList.get(t).size();j++) {
	    		System.out.println(sendproList.get(t).get(j));
	    		
	    	}
	    	cnt+=sendproList.get(t).size();
	    }
	    System.out.println("total:"+cnt);
	    System.out.println("===================");
		return sendproList;
	}

	@Override
	public List<ExamVO> getExamClassCode(String classCode) throws SQLException {
		List<ExamVO> examList=teacherDAO.getExamClassCode(classCode);
		if(examList!=null&&examList.size()>0) {
			for(int i=0;i<examList.size();i++) {
				int examCode=examList.get(i).getExamCode();
				//시작단원 세팅
				examList.get(i).setStartDan(teacherDAO.getExamStartDAN(examCode));
			
				//성적이 입력된 학생수 구하기(시험코드로)
				int cnt=teacherDAO.getAcScoreSc(examCode);
				
				//성적이 입력된 학생의 스코어 총합 가져오기
				int totalScore=teacherDAO.getAcTotalSc(examCode);
				
				if(cnt!=0) {
					System.out.println("==================");
					System.out.println("여기는 평균구하는곳");
					System.out.println("성적이 입력된 학생 수:"+cnt);
					System.out.println("성적이 입력된 학생의 총 스코어 총합:"+totalScore);
					
					examList.get(i).setAverage(Math.round((((double)totalScore/(100*cnt))*100.0))/100.0*100.0);
				}
				
				//마지막 단원 세팅
				examList.get(i).setEndDan(teacherDAO.getExamEndDAN(examCode));
				
				
			}
		}
	 
		
		return examList;
	}

	@Override
	public List<ProblemVO> getExamProblem(String examCode) throws SQLException {
	               
		return teacherDAO.getExamProblem(examCode);
	}

	@Override
	public List<List<ProblemVO>> getExamSendGo(List<ProblemVO> getExamProblemList) throws SQLException {
		List<List<ProblemVO>>sendproList=new ArrayList<>();
		System.out.println("시험지로 시험리스트 받기:"+getExamProblemList);
	   
	    int i=0;
	    while(true) {
	    	 if(teacherDAO.jcheck(getExamProblemList.get(i))) {
	 	    	List<ProblemVO>problemli=new ArrayList<>();
	 	    	if(i+2<getExamProblemList.size()) {
	 	    		problemli.add(getExamProblemList.get(i));
	 	    		problemli.add(getExamProblemList.get(i+1));
	 	    		sendproList.add(problemli);
	 	    		i+=2;
	 	    	}else {
	 	    		
	 	    		for(int k=i;k<getExamProblemList.size();k++) {
	 	    			problemli.add(getExamProblemList.get(k));
	 	    			
	 	    			i=getExamProblemList.size();
	 	    			
	 	    		}
	 	    		sendproList.add(problemli);
	 	    	}
	 	    	if(i==getExamProblemList.size()) {
	 	    		break;
	 	    	}
	    }else {
	    	
	    	List<ProblemVO>problemli=new ArrayList<>();
 	    	if(i+4<getExamProblemList.size()) {
 	    		problemli.add(getExamProblemList.get(i));
 	    		problemli.add(getExamProblemList.get(i+1));
 	    		problemli.add(getExamProblemList.get(i+2));
 	    		problemli.add(getExamProblemList.get(i+3));
 	    		sendproList.add(problemli);
 	    		i+=4;
 	    	}else {
 	    		
 	    		for(int k=i;k<getExamProblemList.size();k++) {
 	    			problemli.add(getExamProblemList.get(k));
 	    		
 	    			i=getExamProblemList.size();
 	    			
 	    		}
 	    		sendproList.add(problemli);
 	    	}
	    	
	    	
	    	
	    	
 	   	if(i==getExamProblemList.size()) {
	    		break;
	    	}
	    	
	    }
	   
	    	
	    	
	    }
	    System.out.println("===================");
	    System.out.println("내가 원하는 대로 들어왔나 확인하기");
	    System.out.println("sendproList사이즈:"+sendproList.size());
	    int cnt=0;
	    for(int t=0;t<sendproList.size();t++) {
	    	for(int j=0;j<sendproList.get(t).size();j++) {
	    		System.out.println(sendproList.get(t).get(j));
	    		
	    	}
	    	cnt+=sendproList.get(t).size();
	    }
	    System.out.println("total:"+cnt);
	    System.out.println("===================");
		return sendproList;
	}
	
	
	//단원이름으로 검색
	@Override
	public ClassProgVO danwonSearch(String name) throws SQLException {
		// TODO Auto-generated method stub
		return teacherDAO.danwonSearch2(name);
	}
	
	
	//시험 리스트 모든것 가지고오기
	@Override
	public Map<String, Object> getAllExamList(String id, SearchCriteria cri) throws SQLException {
		
		
		//토탈 시험수
		int totalCount = teacherDAO.examAllList(id,cri);
		
		List<ExamVO>examTotalList=teacherDAO.examAllListgo(id,cri);
		List<ExamVO>examTotalList2=teacherDAO.examAllListgo2(id,cri);
		double av=0;
		System.out.println("이것이 총 시험수:"+totalCount);
		System.out.println("이것은 시험수의수:"+examTotalList2.size());
		
		
		
		
		if(totalCount>0) {
			if(examTotalList2!=null&&examTotalList2.size()>0) {
				int total=0;
				for(ExamVO ex:examTotalList2) {
					total+=ex.getAcardemyScore();
				}
				
				av=Math.round((double)total/examTotalList2.size()*100.0)/100.0;
				
				
				
				
			}
		}
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		 Map<String, Object> dataMap=new HashMap<String, Object>();
		 System.out.println(examTotalList);
		dataMap.put("examList",examTotalList);
		dataMap.put("pageMaker", pageMaker);
		dataMap.put("average",av);
		
		
		return dataMap;
	}
	
	//클래스가져오기
	@Override
	public List<ClassVO> getListClass(String id) throws SQLException {
		// TODO Auto-generated method stub
		return teacherDAO.getListClass(id);
	}
	
	
	//시험코드로 오답가져오기/
	@Override
	public List<WrongVO> getExamCodeWrong(String examCode) throws SQLException {
		// TODO Auto-generated method stub
		return teacherDAO.getExamCodeWrong(examCode);
	}

	@Override
	public WrongVO wrongGet(String examCode) throws SQLException {
		// TODO Auto-generated method stub
		return teacherDAO.wrongGet(examCode);
	}

	@Override
	public int insertWrongAnswer(String examCode, String answer) throws SQLException {
		Map<String,Object>data=new HashMap<String,Object>();
		data.put("wno",examCode);
		data.put("answer",answer);
		return teacherDAO.inserWrongAnswer(data);
	}



	@Override
	public List<ClassVO> getclassClist(String id) throws SQLException {
		
		return teacherDAO.getclassClist(id);
	}

	@Override
	public List<AcademyScoreVO> examListGet(String id, String classCode, String subject) throws SQLException {
		Map<String,Object>data=new HashMap<>();
		data.put("classCode",classCode);
		data.put("id",id);
		List<AcademyScoreVO>examList=teacherDAO.examListGet(data);
		if(subject.equals("국어")) {
			if(examList!=null&&examList.size()>0) {
				for(AcademyScoreVO ac:examList) {
				      ac.setTko1(teacherDAO.getTSSubarea(id,"화작",ac.getExamCode()));
				      ac.setTko2(teacherDAO.getTSSubarea(id,"문법",ac.getExamCode()));
				      ac.setTko3(teacherDAO.getTSSubarea(id,"독서",ac.getExamCode()));
				      ac.setTko4(teacherDAO.getTSSubarea(id,"문학",ac.getExamCode()));
				      
				      int total=ac.getTko1()+ac.getTko2()+ac.getTko3()+ac.getTko4();
				      int score=100/total;
				      ac.setTko1(score*teacherDAO.getTSSubarea(id,"화작",ac.getExamCode()));
				      ac.setTko2(score*teacherDAO.getTSSubarea(id,"문법",ac.getExamCode()));
				      ac.setTko3(score*teacherDAO.getTSSubarea(id,"독서",ac.getExamCode()));
				      ac.setTko4(score*teacherDAO.getTSSubarea(id,"문학",ac.getExamCode()));
				      
				      System.out.println("정령 문학은 점수가없는것인가?:"+teacherDAO.getTSSubarea(id,"문학",ac.getExamCode()));
				      
				      ac.setKo1(teacherDAO.getSSubarea(id,"화작",ac.getExamCode()));
				      ac.setKo2(teacherDAO.getSSubarea(id,"문법",ac.getExamCode()));
				      ac.setKo3(teacherDAO.getSSubarea(id,"독서",ac.getExamCode()));
				      ac.setKo4(teacherDAO.getSSubarea(id,"문학",ac.getExamCode()));
				      ac.setKo1(ac.getTko1()-teacherDAO.getSSubarea(id,"화작",ac.getExamCode())*score);
				      ac.setKo2(ac.getTko2()-teacherDAO.getSSubarea(id,"문법",ac.getExamCode())*score);
				      ac.setKo3(ac.getTko3()-teacherDAO.getSSubarea(id,"독서",ac.getExamCode())*score);
				      ac.setKo4(ac.getTko4()-teacherDAO.getSSubarea(id,"문학",ac.getExamCode())*score);
				      System.out.println(ac);
				}
			}
			
			
			
		}
		if(subject.equals("수학")) {
if(examList!=null&&examList.size()>0) {
				
			}
		}
		if(subject.equals("사회")) {
if(examList!=null&&examList.size()>0) {
				
			}
	    }
		if(subject.equals("과학")) {
if(examList!=null&&examList.size()>0) {
				
			}
	    }
		if(subject.equals("영어")) {
if(examList!=null&&examList.size()>0) {
				
			}
	    }
		
		
		return examList;
	}

	@Override
	public int searchSanoCode(String saname, String subdetailCode) throws SQLException {
		 Map<String,Object>data=new HashMap<>();
		 data.put("saname",saname);
		 data.put("subdetailCode",subdetailCode);
		// System.out.println("이것이 검색하는데이터:"+data);
		return teacherDAO.searchSanoCode(data);
	}

	

	
	
	
	








}



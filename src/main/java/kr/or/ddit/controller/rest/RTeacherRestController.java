package kr.or.ddit.controller.rest;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.MakeFileName;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.AcademyScoreVO;
import kr.or.ddit.dto.ClassProgVO;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.ProblemVO;
import kr.or.ddit.dto.UniversityVO;
import kr.or.ddit.dto.WrongVO;
import kr.or.ddit.service.MemberService;
import kr.or.ddit.service.ScoreService;
import kr.or.ddit.service.TeacherService;






@RestController
@RequestMapping("/rteacher")
public class RTeacherRestController {
	
	@Autowired
	private TeacherService service;
	
	@Autowired
	private MemberService memberService;

	@Autowired
	private ScoreService scoreService;
	
	
	
	@Resource(name = "picturePath")
	
	   private String picturePath;
	   
	   public String savePicture(String oldPicture, MultipartFile multi)throws Exception{
	      String fileName = null;
	      
	      /* 파일저장폴더설정 */
	      String uploadPath = picturePath;
	      
	      /* 파일유무확인 */
	      if(!(multi == null || multi.isEmpty() || multi.getSize() > 1024 * 1024 * 1)) {
	         fileName = MakeFileName.toUUIDFileName(multi.getOriginalFilename(), "$$");
	         File storeFile = new File(uploadPath, fileName);
	         
	         // 파일경로 생성
	         storeFile.mkdirs();
	         
	         //local HDD에 저장
	         multi.transferTo(storeFile);
	      }
	      
	      // 기존파일 삭제
	      if(oldPicture != null && !oldPicture.isEmpty()) {
	         File oldFile = new File(uploadPath, oldPicture);
	         if(oldFile.exists()) {
	            oldFile.delete();
	         }
	      }
	      return fileName;
	   }
	
	   @RequestMapping(value = "/picture", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	   public ResponseEntity<String> picture(@RequestParam("pictureFile")MultipartFile multi, String oldPicture)throws Exception{
	      
	      ResponseEntity<String> entity = null;
	      String result = "";
	      HttpStatus status = null;
	      
	      /* 파일저장확인 */
	      if((result = savePicture(oldPicture, multi)) == null) {
	         result = "업로드 실패했습니다.!";
	         status = HttpStatus.BAD_REQUEST;
	      }else {
	         status = HttpStatus.OK;
	      }
	      
	      entity = new ResponseEntity<String>(result, status);
	      return entity;
	      
	   }
	
	   
	   @RequestMapping(value = "/picture1", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	   public ResponseEntity<String> picture1(@RequestParam("pictureFile1")MultipartFile multi, String oldPicture)throws Exception{
	      
	      ResponseEntity<String> entity = null;
	      String result = "";
	      HttpStatus status = null;
	      
	      /* 파일저장확인 */
	      if((result = savePicture(oldPicture, multi)) == null) {
	         result = "업로드 실패했습니다.!";
	         status = HttpStatus.BAD_REQUEST;
	      }else {
	         status = HttpStatus.OK;
	      }
	      
	      entity = new ResponseEntity<String>(result, status);
	      return entity;
	      
	   }
	
	   @RequestMapping(value = "/picture2", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	   public ResponseEntity<String> picture2(@RequestParam("pictureFile2")MultipartFile multi, String oldPicture)throws Exception{
	      
	      ResponseEntity<String> entity = null;
	      String result = "";
	      HttpStatus status = null;
	      
	      /* 파일저장확인 */
	      if((result = savePicture(oldPicture, multi)) == null) {
	         result = "업로드 실패했습니다.!";
	         status = HttpStatus.BAD_REQUEST;
	      }else {
	         status = HttpStatus.OK;
	      }
	      
	      entity = new ResponseEntity<String>(result, status);
	      return entity;
	      
	   }
	
	   @RequestMapping(value = "/picture3", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	   public ResponseEntity<String> picture3(@RequestParam("pictureFile3")MultipartFile multi, String oldPicture)throws Exception{
	      
	      ResponseEntity<String> entity = null;
	      String result = "";
	      HttpStatus status = null;
	      
	      /* 파일저장확인 */
	      if((result = savePicture(oldPicture, multi)) == null) {
	         result = "업로드 실패했습니다.!";
	         status = HttpStatus.BAD_REQUEST;
	      }else {
	         status = HttpStatus.OK;
	      }
	      
	      entity = new ResponseEntity<String>(result, status);
	      return entity;
	      
	   }
	
	   @RequestMapping(value = "/picture4", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	   public ResponseEntity<String> picture4(@RequestParam("pictureFile4")MultipartFile multi, String oldPicture)throws Exception{
	      
	      ResponseEntity<String> entity = null;
	      String result = "";
	      HttpStatus status = null;
	      
	      /* 파일저장확인 */
	      if((result = savePicture(oldPicture, multi)) == null) {
	         result = "업로드 실패했습니다.!";
	         status = HttpStatus.BAD_REQUEST;
	      }else {
	         status = HttpStatus.OK;
	      }
	      
	      entity = new ResponseEntity<String>(result, status);
	      return entity;
	      
	   }
	
	   
	   
	   @RequestMapping(value = "/getProPicture", produces = "text/plain;charset=utf-8")
		public ResponseEntity<byte[]> getProPicture(int problemCode) throws Exception {

			int  prCode= problemCode;
			ProblemVO problem=(ProblemVO)service.getProblem(problemCode).get("problem");
			
			String picture=problem.getPicture();
			System.out.println(picture);
			InputStream in = null;
			ResponseEntity<byte[]> entity = null;
			String imgPath = this.picturePath;
			System.out.println("여기는rteacher컨트롤");
			try {
				in = new FileInputStream(new File(imgPath, picture));

				entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), 
							HttpStatus.CREATED);

			} finally {
				if(in!=null)in.close();
			}
			return entity;
		}
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	
	
	@RequestMapping(value ="pslist", method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> res(HttpServletRequest request) throws Exception{
		System.out.println("여긴왔다");
	   String mm=request.getParameter("searchtype");
	   String ms=request.getParameter("processname");
	
	   SearchCriteria cri=new  SearchCriteria();
	   cri.setKeyword(request.getParameter("keyword"));
	   try {
		   int page= Integer.parseInt(request.getParameter("page"));
	   }catch(Exception e) {
		   return null;
	   }
	    
	   cri.setPage(Integer.parseInt(request.getParameter("page")));
	   cri.setSearchType(mm);
		System.out.println(mm);
		System.out.println(ms);
		System.out.println(cri.getPage());
		System.out.println(cri.getKeyword());
		//System.out.println(page);
		ResponseEntity<Map<String, Object>> entity = null;

		Map<String,  Object> dataMap=new HashMap<>();
		   if(ms.equals("전체")) {
			  
				dataMap = service.processStudentList2(ms,cri);

		   }else {
				 dataMap = service.processStudentList(ms,cri);

		   }
		
		
		
		
		
		
		
	       System.out.println(dataMap.get("processStudentList"));
	       
		entity = new ResponseEntity<Map<String,Object>>(dataMap, HttpStatus.OK);
		
	//	return entity;
		return entity;
	}
	
	
	
	
	
	@RequestMapping(value ="piddetail", method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> piddetail(HttpServletRequest request) throws Exception{
		System.out.println("여긴왔다");
	    String id=request.getParameter("id");
	    MemberVO member=service.teacherstudentDetail(id);
		//System.out.println(page);
		ResponseEntity<Map<String, Object>> entity = null;
       Map<String,Object>dataMap=new HashMap<String,Object>();
       dataMap.put("student",member);
       System.out.println("===========================");
        System.out.println(member.getRegDate()); 
        System.out.println("===========================");
		entity = new ResponseEntity<Map<String,Object>>(dataMap, HttpStatus.OK);
		
		return entity;
	//	return null;
	}
	
	
	@RequestMapping(value ="schoolgrade", method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> schoolgrade(HttpServletRequest request,String id) throws Exception{
	
	    String id2=request.getParameter(id);
	    System.out.println("id 체크;"+id);
	   // MemberVO member=service.teacherstudentDetail(id);
		//System.out.println(page);
		ResponseEntity<Map<String, Object>> entity = null;
       Map<String,Object>dataMap=new HashMap<String,Object>();
     //  dataMap.put("student",member);
        //  dataMap.put("schoolScoreList",service.schoolGrade(id));
          
          
  		Map<String, Object> subjectMap = scoreService.getScoreListBySubjectMap(id);
  		Map<String, UniversityVO> uniMap = memberService.getSHUniList(id);
  		dataMap.put("subjectMap",subjectMap);
  		dataMap.put("uniMap",uniMap);
      //  System.out.println(member.getRegDate()); 
   
		entity = new ResponseEntity<Map<String,Object>>(dataMap, HttpStatus.OK);
		
		return entity;
	//	return null;
	}
	
	@RequestMapping(value ="dsubjectSearch", method=RequestMethod.GET)
	public ResponseEntity<List<ClassProgVO>> dsubjectSearch(HttpServletRequest request,String name,String detailCode) throws Exception{
	

		ResponseEntity<List<ClassProgVO>> entity = null;
		System.out.println("이것이 세부과목 코드:"+detailCode);
 //      List<ClassProgVO>danList=service.danSearch(name);
       List<ClassProgVO>danList2=service.danSearch2(detailCode);
       System.out.println(danList2);
        ClassProgVO pr=new ClassProgVO();
//        pr.setSubdetailCode(1);
//        pr.setSubjectProccess(2);
//        pr.setSubunitName("수학 노잼");
//        danList.add(pr);
        System.out.println("이것은:"+pr);
		entity = new ResponseEntity<List<ClassProgVO>>(danList2, HttpStatus.OK);
		
		return entity;
	//	return null;
	}
	
	
	
	@RequestMapping(value ="endDanSearch", method=RequestMethod.GET)
	public ResponseEntity<List<ClassProgVO>> endDanSearch(HttpServletRequest request,String startDan,String className,String detailCode) throws Exception{
	

		ResponseEntity<List<ClassProgVO>> entity = null;
		System.out.println("시작단원:"+startDan);
	
       List<ClassProgVO>danList=service.endDanSearch(startDan,detailCode);
       
        System.out.println("끝 단원 리스트"+danList);
       
       
       
		entity = new ResponseEntity<List<ClassProgVO>>(danList, HttpStatus.OK);
		
		return entity;
	//	return null;
	}
	
	
	@RequestMapping(value ="autoProblemCreate", method=RequestMethod.GET)
	public ResponseEntity<List<List<ProblemVO>>> autoProblemCreate(HttpServletRequest request,String startDan,String probCnt,String enddan2,String detailCode) throws Exception{
	

		ResponseEntity<List<List<ProblemVO>>> entity = null;
		
		//랜덤한 문제 list로담아서 보내기.
		List<List<ProblemVO>>problemSet=service.getRandomJimoonProblem(startDan,enddan2,probCnt,detailCode);
		System.out.println("problemSet실험입니다."+problemSet);
		System.out.println("========================================");
		int cnt=0; 
	   for(int i=0;i<problemSet.size();i++) {
		   for(int j=0;j<problemSet.get(i).size();j++) {
			   if(i>=1) {
				   if(j==0) {
					   cnt+=problemSet.get(i-1).size();
				   }
				   problemSet.get(i).get(j).setExamNo(cnt+(j+1));
			   }else {
				   problemSet.get(i).get(j).setExamNo((j+1));
			   }
			   
		   }
	   }
		
		
       
		entity = new ResponseEntity<List<List<ProblemVO>>>(problemSet, HttpStatus.OK);
		
		return entity;
	//	return null;
	}
	
	
	@RequestMapping(value ="problemjxlistgo", method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> problemjxlistgo(HttpServletRequest request,String startDan,String enddan,String detailCode,String page) throws Exception{
	
		
		ResponseEntity<Map<String,Object>> entity = null;
		
		
		
		
		          Criteria cri=new  Criteria();
		   
		   try {
			   int page2= Integer.parseInt(page);
			   cri.setPage(page2);
				
		   }catch(Exception e) {
			   cri.setPage(1);
			   return null;
		   }
		    
		   Map<String,  Object> dataMap = service.problemJXsdedList(startDan,cri,enddan,detailCode);
			System.out.println("문제 리스트 길이:"+((List<ProblemVO>)dataMap.get("problemList")).size());
		
		
		
	
		
      
       
		entity = new ResponseEntity<Map<String,Object>>(dataMap, HttpStatus.OK);
		
		return entity;
	//	return null;
	}
	
	
	
	
	
	
	
	@RequestMapping(value ="problemjlistgo", method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> problemjlistgo(HttpServletRequest request,String startDan,String enddan,String detailCode,String page) throws Exception{
	
		
		ResponseEntity<Map<String,Object>> entity = null;
		
		
		
		
		          Criteria cri=new  Criteria();
		   
		   try {
			   int page2= Integer.parseInt(page);
			   cri.setPage(page2);
				
		   }catch(Exception e) {
			   cri.setPage(1);
			   return null;
		   }
		    
		   Map<String,  Object> dataMap = service.problemJsdedList(startDan,cri,enddan,detailCode);
			System.out.println(dataMap);
		
		
		
	
		
      
       
		entity = new ResponseEntity<Map<String,Object>>(dataMap, HttpStatus.OK);
		
		return entity;

	}
	
	@RequestMapping(value ="problemRepot", method=RequestMethod.GET)
	public ResponseEntity<String>problemRepot(HttpServletRequest request,String prC,String comment) throws Exception{
	
		
		ResponseEntity<String> entity = null;
		 HttpSession session=request.getSession();
		   MemberVO loginUser=(MemberVO)session.getAttribute("loginUser");
		   String id=loginUser.getId();
		   System.out.println("id확인:"+id);
	
	//	    System.out.println(prC);
		
		service.repotProblem(prC,id,comment);
		
	
		
      
       
		entity = new ResponseEntity<String>("ok", HttpStatus.OK);
		
		return entity;

	}
	@RequestMapping(value ="problemRepotcancel", method=RequestMethod.GET)
	public ResponseEntity<String>problemRepotcancel(HttpServletRequest request,String prC) throws Exception{
	
		
		ResponseEntity<String> entity = null;
		
	  
	
	
		
		service.repotProblemCanCel(prC);
		
	
		
      
       
		entity = new ResponseEntity<String>("ok", HttpStatus.OK);
		
		return entity;

	}
	@RequestMapping(value ="manualPrecview", method=RequestMethod.GET)
	public ResponseEntity<List<List<ProblemVO>>>manualPrecview(HttpServletRequest request,String data) throws Exception{
	
		
		ResponseEntity<List<List<ProblemVO>>> entity = null;
		
		String[] problemCodeList=data.split(",");
		
		List<List<ProblemVO>>previewPrList=service.previewgetProList(problemCodeList);
		int cnt=0; 
		   for(int i=0;i<previewPrList.size();i++) {
			   for(int j=0;j<previewPrList.get(i).size();j++) {
				   if(i>=1) {
					   if(j==0) {
						   cnt+=previewPrList.get(i-1).size();
					   }
					   previewPrList.get(i).get(j).setExamNo(cnt+(j+1));
				   }else {
					   previewPrList.get(i).get(j).setExamNo((j+1));
				   }
				   
			   }
		   }
		
		
      
       
		entity = new ResponseEntity<List<List<ProblemVO>>>(previewPrList, HttpStatus.OK);
		
		return entity;

	}
	
	
	
	
	@RequestMapping(value ="classExamList", method=RequestMethod.GET)
	public ResponseEntity<List<ExamVO>>classExamList(HttpServletRequest request,String classCode) throws Exception{
	
		
		ResponseEntity<List<ExamVO>> entity = null;
		
		
		
		//클래스 코드로 시험지 리스트 검색하기.
		List<ExamVO>examList=service.getExamClassCode(classCode);
		
		
      
       
		entity = new ResponseEntity<List<ExamVO>>(examList, HttpStatus.OK);
		
		return entity;

	}
	
	@RequestMapping(value ="examFolerPrecview", method=RequestMethod.GET)
	public ResponseEntity<List<List<ProblemVO>>>examFolerPrecview(HttpServletRequest request,String examCode) throws Exception{
	
		
		ResponseEntity<List<List<ProblemVO>>> entity = null;
		
		System.out.println(examCode);
		List<ProblemVO>getExamProblemList=service.getExamProblem(examCode);
		List<List<ProblemVO>>previewPrList=service.getExamSendGo(getExamProblemList);
		int cnt=0; 
		   for(int i=0;i<previewPrList.size();i++) {
			   for(int j=0;j<previewPrList.get(i).size();j++) {
				   if(i>=1) {
					   if(j==0) {
						   cnt+=previewPrList.get(i-1).size();
					   }
					   previewPrList.get(i).get(j).setExamNo(cnt+(j+1));
				   }else {
					   previewPrList.get(i).get(j).setExamNo((j+1));
				   }
				   
			   }
		   }
		
		
      
       
		entity = new ResponseEntity<List<List<ProblemVO>>>(previewPrList, HttpStatus.OK);
		
		return entity;

	}
	
	@RequestMapping(value ="examSearchClassCode", method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>>examSearchClassCode(HttpServletRequest request,String classCode,String examCode) throws Exception{
	
		
		ResponseEntity<Map<String,Object>> entity = null;
		
		//System.out.println(classCode);
	    Map<String,Object>dataMap=new HashMap<String,Object>();
	    
        List<ExamVO>examList=service.getExamClassCode(classCode);
        dataMap.put("examList",examList);
        //if(examCode)
		dataMap.put("examCode",examCode);
		
       
		entity = new ResponseEntity<Map<String,Object>>(dataMap, HttpStatus.OK);
		
		return entity;

	}
	@RequestMapping(value ="wrongExamProblem", method=RequestMethod.GET)
	public ResponseEntity<List<ProblemVO>>wrongExamProblem(HttpServletRequest request,String examCode) throws Exception{
	
		
		ResponseEntity<List<ProblemVO>> entity = null;
		System.out.println(examCode);
		
		//시험코드로 문제들 가져오기.
		List<ProblemVO>problemList=service.getExamProblem(examCode);
		
		//시험코드로 오답 가져오기.
		List<WrongVO>wrongList=service.getExamCodeWrong(examCode);
		
		
		if(problemList!=null&&problemList.size()>0) {
			if(wrongList!=null&&wrongList.size()>0) {
				for(WrongVO wr:wrongList) {
					for(ProblemVO pr:problemList) {
						if(wr.getProblemCode()==pr.getProblemCode()) {
							pr.setWrongCheck("o");
							pr.setProblemAnswer(wr.getWrong());
							pr.setOdapNo(wr.getWno());
							pr.setMaker(wr.getId());
							if(wr.getQuestion()!=null) {
								pr.setQuCheck("o");
							}
							if(wr.getAnswer()!=null) {
								pr.setAwCheck("o");
							}
						}
					}
				}
			}
			
		}
	   
		entity = new ResponseEntity<List<ProblemVO>>(problemList, HttpStatus.OK);
		
		return entity;

	}
	
	
	
	
	
	
	@RequestMapping(value ="acdemyScoreGet", method=RequestMethod.GET)
	public ResponseEntity< Map<String,Object>>acdemyScoreGet(HttpServletRequest request,String id,String classCode) throws Exception{
	
		
		
		ResponseEntity< Map<String,Object>> entity = null;
		  HttpSession session=request.getSession();
		   MemberVO loginUser=(MemberVO)session.getAttribute("loginUser");
		   String subject=loginUser.getSubject();
		   Map<String,Object>dataMap=new HashMap<>();
		 
		//클래스 코드로 시험지 리스트 검색하기.
		
		
		List<AcademyScoreVO>examList=service.examListGet(id,classCode,subject);
		
		   dataMap.put("subject",subject);
		   dataMap.put("eamList",examList);
		
      
       
		entity = new ResponseEntity<Map<String,Object>>(dataMap, HttpStatus.OK);
		
		return entity;

	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

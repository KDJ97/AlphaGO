package kr.or.ddit.controller.view;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.sql.SQLException;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.command.StudentRegistCommand;
import kr.or.ddit.command.TeacherRegistCommand;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.StudentVO;
import kr.or.ddit.dto.TeachermasVO;
import kr.or.ddit.service.ApplyService;
import kr.or.ddit.service.PacounseltService;
import kr.or.ddit.service.StudentService;
import kr.or.ddit.service.TeacherMasService;

@Controller
@RequestMapping("/master")
public class HdMasterController {

	@Autowired

	private StudentService studentService;
	
	@Autowired
	private TeacherMasService teacherMasService;
	
	@Autowired
	private ApplyService applyService;
	
	@Autowired
	private PacounseltService counseltService;

//	@RequestMapping("/studentlist")
//	public String studentlist(String id,SearchCriteria cri,HttpSession session,Model model)
//			throws SQLException {
//		String url = "master/studentlist";
//
//		Map<String, Object> dataMap = null;
//		Map<String, Object> dat=null;
//		
//
//		try {
//		
//			dataMap = studentService.getStudentList(cri,id);
//			dat=studentService.selectHopeSchool(id);
////         if(true) throw new SQLException();
//
//		}
//      catch (SQLException e) {
//    	
//    	  e.printStackTrace();
//         throw e;
//      }
//		catch (Exception e) {
//			e.printStackTrace();
//		}
//		//StudentVO stst=studentService.selectFirstHopeSchool(id);
//		//model.addAttribute("stst",stst);
//		model.addAttribute("dataMap",dataMap);
//		model.addAttribute("dat",dat);
//		
//		return url;
//	}
//
//	
//
//	@RequestMapping("/popup")
//	public String popup() throws Exception {
//		String url = "master/popup";
//		return url;
//	}

//	@RequestMapping("/pdfview")
//	public String pdfview() throws Exception {
//		String url = "master/pdfview";
//		return url;
//	}

	/*
	 * @RequestMapping("/registstudent") public String registstudent() throws
	 * Exception { String url = "master/registstudent"; return url; }
	 */
//
//	@RequestMapping(value = "/registstudent", method = RequestMethod.GET)
//	public String registForm() {
//		String url = "master/registstudent";
//		return url;
//	}
//	
//	@RequestMapping(value="/registstudent",method=RequestMethod.POST)
//	public String regist(StudentRegistCommand studentReq)throws Exception{
//		String url="master/registstudent_success";
//		StudentVO student=studentReq.toStudentVO();
//		studentService.regist(student);
//		
//		return url;
//	}

	
//	@RequestMapping(value="/registteacher",method=RequestMethod.GET)
//	public String registteacher() throws Exception {
//		String url = "master/registteacher";
//		return url;
//	}
//	@RequestMapping(value="/registteacher",method=RequestMethod.POST)
//	public String registteacher(TeacherRegistCommand teacherReq)throws Exception{
//		String url="master/registteacher_success";
//		TeachermasVO teamas=teacherReq.toTeachermasVO();
//		teacherMasService.regist(teamas);
//		
//		return url;
//	}
	
	@Resource(name="picturePath")
	private String picturePath;
	
//	@RequestMapping(value="/remove",method=RequestMethod.POST)
//	public String remove(@RequestParam(value="id")String id)throws Exception{
//		String url="master/removestudent_success";
//		
//		   System.out.println(id);
//		
//			studentService.remove(id);
//			
//			//DB삭제
//			
//			
//			
//			
//			return url;
//		}
	
//	@ResponseBody
//	@RequestMapping(value="/registconend",method=RequestMethod.POST,produces = "application/json;charset=utf-8")
//	public ResponseEntity<Integer> registconend(@RequestBody PacounseltVO paco)throws Exception{
//			
//		  ResponseEntity<Integer> entity = null;
//				System.out.println(paco);
//				
//			try {
//				
//				int result = counseltService.updateCounseltDetailList(paco);
//				entity = new ResponseEntity<Integer>(result,HttpStatus.OK);
//			} catch (Exception e) {
//				entity=new ResponseEntity<Integer>(HttpStatus.INTERNAL_SERVER_ERROR);
//			}
//		    
//		
//			
//			
//			
//			return entity;
//		}
	
	@ResponseBody
	@RequestMapping(value="/registcalender",method=RequestMethod.POST,produces = "application/json;charset=utf-8")
	public ResponseEntity<Integer> registcalender(@RequestBody PacounseltVO paco)throws Exception{
			
		  ResponseEntity<Integer> entity = null;
				System.out.println(paco);
				
			try {
				
				int result = counseltService.insertCalender(paco);
				entity = new ResponseEntity<Integer>(result,HttpStatus.OK);
			} catch (Exception e) {
				entity=new ResponseEntity<Integer>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
		    
		
			
			
			
			return entity;
		}
//  
//	@RequestMapping(value="/removeteacher",method=RequestMethod.POST)
//	public String removeteacher(@RequestParam(value="id")String id)throws Exception{
//		String url="master/removeteacher_success";
//		
//		   System.out.println(id);
//		
//			teacherMasService.remove(id);
//			
//			//DB삭제
//			
//			
//			
//			
//			return url;
//		}
//
//	@RequestMapping("/schoolgrade")
//	public String schoolgrade() throws Exception {
//		String url = "master/schoolgrade";
//		return url;
//	}
//
//	@RequestMapping("/academygrade")
//	public String academygrade() throws Exception {
//		String url = "master/academygrade";
//		return url;
//	}

	/*
	 * @RequestMapping("/studentlist") public String studentlist() throws Exception
	 * { String url = "master/studentlist"; return url; }
	 */
//
//	@RequestMapping("/studentdetail")
//	public String studentdetail() throws Exception {
//		String url = "master/studentdetail";
//		return url;
//	}

//	@RequestMapping("/consultlist")
//	public String consultlist(SearchCriteria cri,HttpSession session,Model model,Integer pcCode) throws Exception {
//		String url = "master/consultlist";
//		Map<String, Object> dataMap = null;
//
//		try {
//			//dataMap =counseltService.getCounseltList(cri,counCode);
//			dataMap =counseltService.getCounseltList(cri, pcCode);
//			
////         if(true) throw new SQLException();
//
//		}
//      catch (SQLException e) {
//    	
//    	  e.printStackTrace();
//         throw e;
//      }
//		catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		model.addAttribute("dataMap",dataMap);
//		
//		return url;
//	}

//	@RequestMapping("/consultdetail")
//	public String consultdetail() throws Exception {
//		String url = "master/consultdetail";
//		return url;
//	}
//
//	@RequestMapping("/analysis")
//	public String analysis(SearchCriteria cri,Integer pcCode,String from,Model model) throws Exception {
//		String url = "master/analysis";
//		Map<String, Object> dataMap = null;
//		Map<String, Object> dat = null;
//		Map<String, Object> data = null;
//		Map<String, Object> dataMa = null;
//		dataMap=counseltService.getCounseltList(cri, pcCode);
//		dataMa=counseltService.getOverUniversityList(pcCode);
//		data=counseltService.getPosibleUniversityList(pcCode);
//		dat=counseltService.getlowUniversityList(pcCode);
//		model.addAttribute("dataMap",dataMap);
//		model.addAttribute("dat",dat);
//		model.addAttribute("data",data);
//		model.addAttribute("dataMa",dataMa);
//		PacounseltVO cou=counseltService.getPacounselt(pcCode);
//		PacounseltVO abc=counseltService.selectPacounseltByPcCode2(pcCode);
//		PacounseltVO cde=counseltService.selectPacounseltByPcCode3(pcCode);
//		PacounseltVO efg=counseltService.selectPacounseltByPcCode4(pcCode);
//		PacounseltVO ab=counseltService.selectPacounseltByPcCode5(pcCode);
//		PacounseltVO cd=counseltService.selectPacounseltByPcCode6(pcCode);
//		PacounseltVO a=counseltService.selectSchoolnaesin(pcCode);
//		PacounseltVO b=counseltService.selectSchoolnaesin2(pcCode);
//		PacounseltVO c=counseltService.selectSchoolnaesin3(pcCode);
//		PacounseltVO e=counseltService.selectSchoolnaesin4(pcCode);
//		PacounseltVO f=counseltService.selectSchoolnaesin5(pcCode);
//		PacounseltVO g=counseltService.selectSchoolnaesin6(pcCode);
//		PacounseltVO h=counseltService.selectStudentGrade(pcCode);
//		PacounseltVO i=counseltService.selectFisrtHighSchool(pcCode);
//		PacounseltVO j=counseltService.selectScoreHighSchool(pcCode);
//
//		model.addAttribute("cou",cou);
//		model.addAttribute("abc",abc);
//		model.addAttribute("cde",cde);
//		model.addAttribute("efg",efg);
//		model.addAttribute("ab",ab);
//		model.addAttribute("cd",cd);
//		model.addAttribute("a",a);
//		model.addAttribute("b",b);
//		model.addAttribute("c",c);
//		model.addAttribute("e",e);
//		model.addAttribute("f",f);
//		model.addAttribute("g",g);
//		model.addAttribute("h",h);
//		model.addAttribute("i",i);
//		model.addAttribute("j",j);
//		PacounseltVO k=counseltService.selectFisrtPosibleSchool(pcCode);
//		model.addAttribute("k",k);
//		PacounseltVO o=counseltService.selectFisrtPosibleScoreSchool(pcCode);
//		model.addAttribute("o",o);
//		PacounseltVO m=counseltService.selectFisrtDownSchool(pcCode);
//		model.addAttribute("m",m);
//		PacounseltVO n=counseltService.selectFisrtDownScoreSchool(pcCode);
//		model.addAttribute("n",n);
//		PacounseltVO sf=counseltService.selectSecondHighSchool(pcCode);
//		model.addAttribute("sf",sf);
//		
//		PacounseltVO ss=counseltService.selectSecondScorePossibleSchool(pcCode);
//		model.addAttribute("ss",ss);
//		
//		PacounseltVO si=counseltService.selectThirdPossibleSchool(pcCode);
//		model.addAttribute("si",si);
//		PacounseltVO tt=counseltService.selectSecondOverSchool(pcCode);
//		model.addAttribute("tt",tt);
//		
//		PacounseltVO ta=counseltService.selectThirdOverSchool(pcCode);
//		model.addAttribute("ta",ta);
//		
//		PacounseltVO ds=counseltService.selectSecondDownSchool(pcCode);
//		model.addAttribute("ds",ds);
//		PacounseltVO dt=counseltService.selectThirdDownSchool(pcCode);
//		model.addAttribute("dt",dt);
//		return url;
//	}
//
//	@RequestMapping("/pdfprpr")
//	public String pdfprpr(SearchCriteria cri,Integer pcCode,String from,Model model) throws Exception {
//		String url = "master/pdfprpr";
//		
//		Map<String, Object> dataMap = null;
//		Map<String, Object> dat = null;
//		Map<String, Object> data = null;
//		Map<String, Object> dataMa = null;
//		dataMap=counseltService.getCounseltList(cri, pcCode);
//		dataMa=counseltService.getOverUniversityList(pcCode);
//		data=counseltService.getPosibleUniversityList(pcCode);
//		dat=counseltService.getlowUniversityList(pcCode);
//		model.addAttribute("dataMap",dataMap);
//		model.addAttribute("dat",dat);
//		model.addAttribute("data",data);
//		model.addAttribute("dataMa",dataMa);
//		PacounseltVO cou=counseltService.getPacounselt(pcCode);
//		PacounseltVO abc=counseltService.selectPacounseltByPcCode2(pcCode);
//		PacounseltVO cde=counseltService.selectPacounseltByPcCode3(pcCode);
//		PacounseltVO efg=counseltService.selectPacounseltByPcCode4(pcCode);
//		PacounseltVO ab=counseltService.selectPacounseltByPcCode5(pcCode);
//		PacounseltVO cd=counseltService.selectPacounseltByPcCode6(pcCode);
//		PacounseltVO a=counseltService.selectSchoolnaesin(pcCode);
//		PacounseltVO b=counseltService.selectSchoolnaesin2(pcCode);
//		PacounseltVO c=counseltService.selectSchoolnaesin3(pcCode);
//		PacounseltVO e=counseltService.selectSchoolnaesin4(pcCode);
//		PacounseltVO f=counseltService.selectSchoolnaesin5(pcCode);
//		PacounseltVO g=counseltService.selectSchoolnaesin6(pcCode);
//		PacounseltVO h=counseltService.selectStudentGrade(pcCode);
//		PacounseltVO i=counseltService.selectFisrtHighSchool(pcCode);
//		PacounseltVO j=counseltService.selectScoreHighSchool(pcCode);
//
//		model.addAttribute("cou",cou);
//		model.addAttribute("abc",abc);
//		model.addAttribute("cde",cde);
//		model.addAttribute("efg",efg);
//		model.addAttribute("ab",ab);
//		model.addAttribute("cd",cd);
//		model.addAttribute("a",a);
//		model.addAttribute("b",b);
//		model.addAttribute("c",c);
//		model.addAttribute("e",e);
//		model.addAttribute("f",f);
//		model.addAttribute("g",g);
//		model.addAttribute("h",h);
//		model.addAttribute("i",i);
//		model.addAttribute("j",j);
//		PacounseltVO k=counseltService.selectFisrtPosibleSchool(pcCode);
//		model.addAttribute("k",k);
//		PacounseltVO o=counseltService.selectFisrtPosibleScoreSchool(pcCode);
//		model.addAttribute("o",o);
//		PacounseltVO m=counseltService.selectFisrtDownSchool(pcCode);
//		model.addAttribute("m",m);
//		PacounseltVO n=counseltService.selectFisrtDownScoreSchool(pcCode);
//		model.addAttribute("n",n);
//		PacounseltVO sf=counseltService.selectSecondHighSchool(pcCode);
//		model.addAttribute("sf",sf);
//		
//		PacounseltVO ss=counseltService.selectSecondScorePossibleSchool(pcCode);
//		model.addAttribute("ss",ss);
//		
//		PacounseltVO si=counseltService.selectThirdPossibleSchool(pcCode);
//		model.addAttribute("si",si);
//		PacounseltVO tt=counseltService.selectSecondOverSchool(pcCode);
//		model.addAttribute("tt",tt);
//		
//		PacounseltVO ta=counseltService.selectThirdOverSchool(pcCode);
//		model.addAttribute("ta",ta);
//		
//		PacounseltVO ds=counseltService.selectSecondDownSchool(pcCode);
//		model.addAttribute("ds",ds);
//		PacounseltVO dt=counseltService.selectThirdDownSchool(pcCode);
//		model.addAttribute("dt",dt);
//		return url;
//	}
	@RequestMapping("/consultcancel")
	public String consultcancel() throws Exception {
		String url = "master/consultcancel";
		return url;
	}

//	@RequestMapping("/consultend")
//	public String consultend(SearchCriteria cri,HttpSession session,Model model,Integer pcCode) throws Exception {
//		String url = "master/consultend";
//		Map<String, Object> dataMap = null;
//   
//		try {
//			//dataMap =counseltService.getCounseltList(cri,counCode);
//			dataMap =counseltService.getCounseltEndList(cri, pcCode);
////         if(true) throw new SQLException();
//
//		}
//      catch (SQLException e) {
//    	
//    	  e.printStackTrace();
//         throw e;
//      }
//		catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		model.addAttribute("dataMap",dataMap);
//		
//		return url;
//	}

	

//	
//	@RequestMapping("/teacherlist")
//	public String teacherlist(SearchCriteria cri, HttpSession session, Model model) throws Exception {
//		String url = "master/teacherlist";
//
//	
//
//		Map<String, Object> dataMap = null;
//		try {
//			dataMap =teacherMasService.getTeacherList(cri); 
//		} catch (SQLException e) {
//			e.printStackTrace();
//			throw e;
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		
//
//		model.addAttribute("dataMap", dataMap);
//
//		
//
//		return url;
//	}
	@RequestMapping("/teacherdetail")
	public String teacherdetail() throws Exception {
		String url = "master/teacherdetail";
		return url;
	}

	@RequestMapping("/upgrade")
	public String upgrade() throws Exception {
		String url = "master/upgrade";
		return url;
	}

//	@RequestMapping("/resumelist")
//	public String resumelist(SearchCriteria cri, HttpSession session, Model model) throws Exception {
//		String url = "master/resumelist";
//
//		Map<String, Object> dataMap = null;
//
//		try {
//			dataMap =applyService.getApplyList(cri); 
//
////         if(true) throw new SQLException();
//
//		}
//      catch (SQLException e) {
//    	
//    	  e.printStackTrace();
//         throw e;
//      }
//		catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		model.addAttribute("dataMap",dataMap);
//		
//		return url;
//	}

	@RequestMapping("/message")
	public String message() throws Exception {
		String url = "master/message";
		return url;
	}

//	@RequestMapping("/attend")
//	public String attend() throws Exception {
//		String url = "master/attend";
//		return url;
//	}

	@RequestMapping("/resumesample")
	public String resumesample() throws Exception {
		String url = "master/resumesample";
		return url;
	}

	// 집가고 싶다
	// 1차 테스트

	// ㄷㅈㄹㄴㄹ
	// ㅛㅑㅛㅑㅛㅑㅛ

	// 2차 테스트
}

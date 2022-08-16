package kr.or.ddit.controller.view;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.service.DmService;
import kr.or.ddit.service.MStudyPlanService;
import kr.or.ddit.service.TclassService;

@Controller
@RequestMapping("/mStudyPlan")
public class MStudyPlanController {

	@Autowired
	MStudyPlanService mStudyPlanService;
	
	@Autowired
	TclassService tclassService;
	
	@Autowired
	DmService dmService;
	
	@RequestMapping("/list")
	public String list(Model model) throws Exception{
		String url="mstudyplan/list";
		
		return url;
	}
	
	/**
	 * 카테고리에 따른 수업정보 리스트
	 * @param cpcheck
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/selectClassListByCpcheck")
	public ResponseEntity<List<ClassVO>> selectClassListByCpcheck(String cpcheck) {
		ResponseEntity<List<ClassVO>> entity = null;
		List<ClassVO> list = null;
		try {
			list = mStudyPlanService.selectClassListByCpcheck(cpcheck);
			entity = new ResponseEntity<List<ClassVO>>(list, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<ClassVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	/**
	 * 인기/비인기 수업정보 리스트
	 * @param cpcheck
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/selectHotClassList")
	public ResponseEntity<List<ClassVO>> selectHotClassList(String cate) {
		ResponseEntity<List<ClassVO>> entity = null;
		List<ClassVO> list = null;
		
		try {
			if(cate.equals("H")) {
				list = mStudyPlanService.selectHotClassList();
			}else if(cate.equals("W")) {
				list = mStudyPlanService.selectWorstClassList();
			}
			
			entity = new ResponseEntity<List<ClassVO>>(list, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<ClassVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	
	/**
	 * 수업 계획서 상세 확인
	 * @param classCode
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/detail")
	public String detail(String classCode, Model model) throws Exception{
		String url="mstudyplan/detail";
		int classcode = Integer.parseInt(classCode);
		//등록된 수업 계획서 정보
		Map<String, Object> dataMap = tclassService.selectRegisteredClassForModal(classcode);
		
		model.addAttribute("dataMap", dataMap);
		
		return url;
	}
	
	/**
	 * 수업계획서 승인
	 * @param classCode
	 * @return
	 */
	@RequestMapping(value="/classPlanConfirm",method=RequestMethod.POST, produces="application/json;charset=utf-8")
	public String classPlanConfirm(ClassVO classVO, RedirectAttributes rttr) throws Exception {
		String url="redirect:/mStudyPlan/list.go";
		
		//해당 수업 상태변경 - 승인으로
		mStudyPlanService.updateCpcheck(classVO);
		rttr.addFlashAttribute("from", "3");
		
		return url;
	}
	/**
	 * 수업계획서 승인 및 반려
	 * @param classCode
	 * @return
	 */
	@RequestMapping(value="/classPlanConfuse",method=RequestMethod.POST, produces="application/json;charset=utf-8")
	public String classPlanConfuse(ClassVO classVO, RedirectAttributes rttr,HttpSession session) throws Exception {
		String url="redirect:/mStudyPlan/list.go";
		
		//해당 수업 상태변경 - 반려로
		mStudyPlanService.updateCpcheck(classVO);
		
		//쪽지를 보낼 강사 id
		List<String> to = new ArrayList<String>();
		to.add(classVO.getId());
		
		//현재 로그인된 아이디 꺼내기(원장)
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		String from = loginUser.getId();
		
		String title="수업계획서 반려";
		String content="수업명 : " + classVO.getClassName();
		dmService.sendDm(to, from, title, content);
		
		rttr.addFlashAttribute("from", "2");
		
		return url;
	}

	@ResponseBody
	@RequestMapping("/removeClass")
	public ResponseEntity<List<ClassVO>> removeClass(String classCode) {
		ResponseEntity<List<ClassVO>> entity = null;
		
		try {
			mStudyPlanService.removeClassPlan(classCode);
			entity = new ResponseEntity<List<ClassVO>>(HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<ClassVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	
	
	
}



































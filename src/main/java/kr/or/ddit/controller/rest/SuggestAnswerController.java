package kr.or.ddit.controller.rest;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.josephoconnell.html.HTMLInputFilter;

import kr.or.ddit.command.PageMaker;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.SuggestAnswerVO;
import kr.or.ddit.service.SuggestAnswerService;

@RestController
@RequestMapping("/suggestAnswer")
public class SuggestAnswerController {
	
	@Autowired
	private SuggestAnswerService service;
	
	@RequestMapping(value = "/{lcode}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> suggestAnswerList(@PathVariable("lcode") int lcode, @PathVariable("page") int page,
																	HttpServletRequest request) throws Exception{
		ResponseEntity<Map<String, Object>> entity = null;
		
		SearchCriteria cri = new SearchCriteria();
		cri.setPage(page);
		cri.setPerPageNum(1);

		HttpSession session=request.getSession();
		MemberVO member=(MemberVO)session.getAttribute("loginUser");
		String id=member.getId();
		
		Map<String, Object> dataMap = service.getSuggestAnswerList(lcode, cri);
		
		List<SuggestAnswerVO> suggestAnswerList = (List<SuggestAnswerVO>) dataMap.get("suggestAnswerList");
		for(int i=0; i<suggestAnswerList.size(); i++) {
			suggestAnswerList.get(i).setId(id);
		}
		
		entity = new ResponseEntity<Map<String,Object>>(dataMap, HttpStatus.OK);
		
		return entity;
	}
	
	@RequestMapping(value="",method=RequestMethod.POST)
	public ResponseEntity<String> register (@RequestBody SuggestAnswerVO suggestAnswer) throws Exception{
		
		ResponseEntity<String> entity = null;
		
		System.out.println(suggestAnswer.getAnswer());
		suggestAnswer.setAnswer(HTMLInputFilter.htmlSpecialChars(suggestAnswer.getAnswer()));
		
		service.registSuggestAnswer(suggestAnswer);
		
		SearchCriteria cri = new SearchCriteria();
		Map<String,  Object> dataMap = service.getSuggestAnswerList(suggestAnswer.getLcode(), cri);
		PageMaker pageMaker = (PageMaker)dataMap.get("pageMaker");
		int realEndPage = pageMaker.getRealEndPage();
		
		entity = new ResponseEntity<String>(realEndPage + "",HttpStatus.OK);
		
		return entity;
		
	}
	
	@RequestMapping(value="/{lcode}/{col}/{page}", method=RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("lcode") int lcode,
										 @PathVariable("col") int col,
										 @PathVariable("page") int page) throws Exception{
		
		ResponseEntity<String> entity = null;
		System.out.println("*-col번호 : " + col);
		try {
			service.removeSuggestAnswer(col);
		} catch (Exception e) {
			System.out.println("remove실패");
		}
		
		SearchCriteria cri = new SearchCriteria();
		
		Map<String, Object>dataMap =service.getSuggestAnswerList(lcode, cri);
		PageMaker pageMaker = (PageMaker)dataMap.get("pageMaker");
		
		int realEndPage = pageMaker.getRealEndPage();
		if(page > realEndPage) {
			page = realEndPage;
		}
		
		entity = new ResponseEntity<String>(""+page, HttpStatus.OK);
		
		return entity;
	}
}

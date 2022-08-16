package kr.or.ddit.controller.view;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonObjectFormatVisitor;

import kr.or.ddit.dto.SuggestVO;
import kr.or.ddit.service.SuggestService;


@Controller
@RequestMapping("/suggest")
public class SuggestController {
	
	@Autowired
	private SuggestService suggestService;
	
	@RequestMapping("/list")
	public String list(kr.or.ddit.command.SearchCriteria cri, Model model, String selectedOrder) throws Exception{
		String url = "suggest/list";
		System.out.println("7Suggest Controller에서 : "+selectedOrder);
		if(selectedOrder==null) selectedOrder = "reg";
		System.out.println("변환 -> " + selectedOrder);
		//System.out.println(lr);
		Map<String,Object> dataMap = suggestService.getSuggestList(cri, selectedOrder);
		model.addAttribute("dataMap",dataMap);
		
		return url;
	}
	
	@RequestMapping("/detail")
	public ModelAndView detail(int lcode, String from, ModelAndView mnv) throws Exception{
		String url = "suggest/detail";
		
		SuggestVO suggest = null;
		if(from!=null && from.equals("list")) {
			suggest=suggestService.getSuggest(lcode);
			url="redirect:/suggest/detail.go?lcode="+lcode;
		}else {
			suggest=suggestService.getSuggestForModify(lcode);
		}
		mnv.addObject("suggest",suggest);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/registForm")
	public String registForm(kr.or.ddit.command.SearchCriteria cri, Model model) throws Exception{
		String url = "suggest/regist";
		return url;
	}
	
	@RequestMapping("/regist")
	public String regist(@RequestParam Map<String,Object> map, RedirectAttributes rttr) throws Exception{
	
		String url="redirect:/suggest/list.go";	
		
		SuggestVO suggest = new SuggestVO();
		String title = (String)map.get("title");
		String content = (String)map.get("content");
		String writer = (String)map.get("writer");
		suggest.setTitle(title);
		suggest.setContent(content);
		suggest.setWriter(writer);
		suggestService.regist(suggest);
		
		rttr.addFlashAttribute("from","regist");
		
		return url;
	}
	
	@RequestMapping("/modifyForm")
	public String modifyForm(int lcode, Model model) throws Exception{
		String url = "suggest/modify";
		
		SuggestVO suggest = suggestService.getSuggestForModify(lcode);
		
		model.addAttribute("suggest",suggest);		
		
		return url;
	}
	
	@RequestMapping(value="/modify",method=RequestMethod.POST)
	public String modify(SuggestVO suggest, RedirectAttributes rttr) throws Exception{
		String url="redirect:/suggest/detail.go";
		
		suggestService.modify(suggest);
		
		rttr.addFlashAttribute("from","modify");
		rttr.addAttribute("lcode",suggest.getLcode());
		
		return url;
	}
	
	
	@RequestMapping(value="/remove",method=RequestMethod.GET)
	public String remove(int lcode,RedirectAttributes rttr) throws Exception{
		String url = "redirect:/suggest/list.go";
		suggestService.remove(lcode);
		
		rttr.addAttribute("lcode",lcode);
		rttr.addFlashAttribute("from","remove");
		
		return url;
	}
	
	@ResponseBody
	@RequestMapping(value="/like",method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> like(@RequestParam Map<String,Object> likeMap){
		
		ResponseEntity<Map<String,Object>> entity = null;
		
		String str_lcode = (String)likeMap.get("lcode");
		int lcode = Integer.parseInt(str_lcode);
		String writer = (String)likeMap.get("id");
		
//		System.out.println("like.go : "+lcode);
//		System.out.println("like.go : "+writer);
		
		Map<String,Object> cntMap = null;
		try {
			System.out.println("try idn7887876");
			suggestService.registSUGLIKE(likeMap);
			suggestService.like(lcode);
			cntMap = new HashMap<String, Object>();
			int cnt=suggestService.likeCount(lcode);
			cntMap.put("cnt", cnt);
			System.out.println(cntMap);
			entity = new ResponseEntity<Map<String,Object>>(cntMap,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("catch in");
			entity = new ResponseEntity<Map<String,Object>>(cntMap,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	
}




















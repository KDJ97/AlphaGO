package kr.or.ddit.controller.view;

import java.io.File;
import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.command.PopupModifyCommand;
import kr.or.ddit.command.PopupRegistCommand;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.controller.rest.GetPopAttachesByMultiFileAdapter;
import kr.or.ddit.dto.PopAttachVO;
import kr.or.ddit.dto.PopupVO;
import kr.or.ddit.service.PopupService;

@Controller
@RequestMapping("/popup")
public class PopupController {

	@Autowired
	PopupService popupService;
	
	@RequestMapping("/list")
	public String list(Model model, SearchCriteria cri) throws Exception{
		String url = "popup/list";
		
		Map<String, Object> dataMap = popupService.selectSearchPopupList(cri);
		model.addAttribute("dataMap", dataMap);
		
		return url;
	}
	
	//팝업 경로 불러오기
	@Autowired
	private String popupUploadPath;
	
	@RequestMapping(value = "/regist", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	public String registPopup(PopupRegistCommand popupCommand, MultipartHttpServletRequest request, RedirectAttributes rttr) throws Exception{
		String url="redirect:/popup/list.go";
//		System.out.println("popupCommand getUploadFile: " + popupCommand.getUploadFile());
		
		//file저장 -> List<AttachVO>
		String savePath = this.popupUploadPath;
		List<PopAttachVO> attachList = GetPopAttachesByMultiFileAdapter.save(popupCommand.getUploadFile(), savePath);
		
		//DB
		PopupVO popupVO = popupCommand.toPopupVO();
		popupVO.setPopAttachList(attachList);
//		System.out.println("inuse from controller : " + popupVO.getInuse());
		popupService.registPopup(popupVO);
		
		//output
		rttr.addFlashAttribute("from", "regist");
		
		return url;
	}
	/**
	 * 팝업 상세 정보를 비동기로 불러온다.
	 * @param popcode
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/detail", method = RequestMethod.GET)
	public ResponseEntity<PopupRegistCommand> detailPopup(@RequestParam String popcode) {
		ResponseEntity<PopupRegistCommand> entity = null;
		PopupRegistCommand command = null; 
		try {
			command = popupService.getPopup(popcode);
			//파일명 재정의
			if(command != null) {
				List<PopAttachVO> attachList = command.getAttachList();
				if(attachList != null) {
					for(PopAttachVO attach : attachList) {
						String fileName = attach.getFilename().split("\\$\\$")[1];
						attach.setFilename(fileName);
					}
				}
			}
			entity = new ResponseEntity<PopupRegistCommand>(command, HttpStatus.OK); 
		} catch (Exception e) {
			entity = new ResponseEntity<PopupRegistCommand>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	
	//팝업 수정 (파일 삭제 + 파일 등록 + 수정)
	@RequestMapping(value = "/modify", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	public String modifyPopup(PopupModifyCommand modifyReq, RedirectAttributes rttr) throws Exception{
		String url = "redirect:/popup/list.go";
		String savePath = popupUploadPath;
//		System.out.println("modifyReq : " + modifyReq);
		//파일 삭제
		if(modifyReq.getDeleteFile() != null && modifyReq.getDeleteFile().length>0) {
			 for(String anoStr:modifyReq.getDeleteFile()) {
				 String attachno = anoStr;
//				 System.out.println("deleteFile attachno: " + attachno);
				 PopAttachVO attach = popupService.getAttachByAttachno(attachno);

				 File deleteFile = new File(attach.getUploadpath(),attach.getFilename());
				 if(deleteFile.exists()) {
					 deleteFile.delete();	//File 삭제
				 }
				 popupService.removeAttachByAttachno(attachno);//db 삭제
			}
		}
		//파일 저장
		List<PopAttachVO> popattachList = GetPopAttachesByMultiFileAdapter.save(modifyReq.getUploadFile(),savePath);

		//pdsVO setting
		PopupVO popup = modifyReq.toPopupVO();
//		System.out.println("popup for modify : " + popup.toString());
//		System.out.println("save attachList : " + popattachList.toString());
		popup.setPopAttachList(popattachList);

		//DB 수정
		popupService.modifyPopup(popup);

		rttr.addFlashAttribute("from","modify");

		return url;
	}
	
	@RequestMapping("/remove")
	public String removePopup(PopupModifyCommand command, RedirectAttributes rttr) throws Exception{
		String url="redirect:/popup/list.go";
		
		PopupVO popupVO = command.toPopupVO();
		System.out.println("popupVO : " + popupVO);
		String popcode = popupVO.getPopcode();
		List<PopAttachVO> attachList = popupService.getAttachByPopcode(popcode);
		System.out.println("attachList :" + attachList);
		
		if(attachList != null && attachList.size()>0)
		for(PopAttachVO attach : attachList) {
			 File deleteFile = new File(attach.getUploadpath(),attach.getFilename());
			 if(deleteFile.exists()) {
				 deleteFile.delete();	//File 삭제
			 }
		}
		popupService.removeAttachByPopcode(popcode);//첨부파일 db삭제
		
		popupService.removePopup(popupVO);//팝업 db 삭제
		
		rttr.addFlashAttribute("from", "remove");
		return url;
	}
	
	
	@RequestMapping("/openPopup")
	public String openPopup(@RequestParam String popcode, Model model) throws Exception{
		String url="popup/detail";
//		System.out.println(popcode);
		//사용유무가 Y이며 팝업 기간에 오늘 날짜가 포함된 팝업 리스트-> 쿼리로 해결함
		PopupRegistCommand popup = popupService.getPopup(popcode);
		List<PopAttachVO> attachList = popup.getAttachList();
		if(attachList != null) {
			for(PopAttachVO attach : attachList) {
				String fileName = attach.getFilename().split("\\$\\$")[1];
				attach.setFilename(fileName);
			}
		}

		model.addAttribute("popup", popup);
		return url;
	}
	@RequestMapping("/getFile")
	public String getFile(String attachno, Model model) throws Exception{
		String url = "downloadFile";
		PopAttachVO attach = popupService.getAttachByAttachno(attachno);
		
		model.addAttribute("savedPath",attach.getUploadpath());
		model.addAttribute("fileName",attach.getFilename());
		return url;
	}
	
	@ResponseBody
	@RequestMapping("/getCount")
	public ResponseEntity<Integer> getCount() {
		ResponseEntity<Integer> entity = null;
		try {
			int cnt = popupService.selectUsePopupCount();
			entity = new ResponseEntity<Integer>(cnt, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<Integer>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	
	
	
	
	
	
	
}











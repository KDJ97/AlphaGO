package kr.or.ddit.controller.view;

import java.io.File;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

import kr.or.ddit.command.NoticeModifyCommand;
import kr.or.ddit.command.NoticeRegistCommand;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.controller.rest.GetAttachesByMultipartFileAdapter;
import kr.or.ddit.dto.AttachVO;
import kr.or.ddit.dto.NoticeVO;
import kr.or.ddit.service.NoticeService;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	@Autowired
	private NoticeService noticeService;

	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);

//	@ResponseBody
//	@RequestMapping("/cateList")
//	public ResponseEntity<List<NoticeVO>> cateList(String name, SearchCriteria cri) {
//		ResponseEntity<List<NoticeVO>> entity = null;
//		List<NoticeVO> noticeList = null;
//
//		try {
//			noticeList = noticeService.selectCateNoticeList(name, cri);
//
//			entity = new ResponseEntity<List<NoticeVO>>(noticeList, HttpStatus.OK);
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			entity = new ResponseEntity<List<NoticeVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
//		}
//
//
//		return entity;
//	}


	/**
	 * 공지사항 리스트 목록 출력
	 * @param cri
	 * @param session
	 * @param model
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping("/list")
	public String list(SearchCriteria cri, HttpSession session, Model model) throws SQLException {
		String url = "notice/list";

		Map<String, Object> dataMap = null;
		List<NoticeVO> fixList = null;

		try {
			dataMap = noticeService.getNoticeList(cri);
			fixList = noticeService.selectFixedList();

			dataMap.put("fixList", fixList);

		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("dataMap", dataMap);

		return url;
	}

	@RequestMapping("/registForm")
	public String registForm() throws Exception {
		String url = "notice/regist";
		return url;
	}

	@Resource(name = "fileUploadPath")
	private String fileUploadPath;

	@RequestMapping(value = "/regist", method = RequestMethod.POST, produces = "text/plain; charset=utf-8")
	public String regist(NoticeRegistCommand registReq, HttpServletRequest request, RedirectAttributes rttr)
			throws Exception {
		String url = "redirect:/notice/list.go";

		// file 저장
		String savePath = this.fileUploadPath;

		List<AttachVO> attachList = GetAttachesByMultipartFileAdapter.save(registReq.getUploadFile(), savePath);
		List<NoticeVO> fixList = noticeService.selectFixedList();

		// DB
		NoticeVO notice = registReq.toNoticeVO();
		notice.setAttachList(attachList);

		noticeService.insertNotice(notice);

		// output
		rttr.addFlashAttribute("from", "regist");
		return url;
	}

	@RequestMapping("/detail")
	public String detail(int cnt, int lcode, String from, Model model) throws Exception {
		String url = "notice/detail";

		NoticeVO notice = null;
		if (from != null && from.equals("list")) {
			notice = noticeService.selectNoticeByLcode(lcode);
			url = "redirect:/notice/detail.go?lcode=" + lcode + "&cnt=" + cnt;
		} else {
			notice = noticeService.getNotice(lcode);
		}

		// 파일명 재정의
		if (notice != null) {
			List<AttachVO> attachList = notice.getAttachList();
			if (attachList != null) {
				for (AttachVO attach : attachList) {
					String fileName = attach.getFileName().split("\\$\\$")[1];
					attach.setFileName(fileName);
				}
			}
		}

		//model.addAttribute("cnt", cnt);
		model.addAttribute("notice", notice);

		return url;
	}

	@RequestMapping("/remove")
	public String remove(int lcode, RedirectAttributes rttr) throws Exception {
		String url = "redirect:/notice/detail.go";

		// 첨부파일 삭제
		List<AttachVO> attachList = noticeService.getNotice(lcode).getAttachList();
		if (attachList != null) {
			for (AttachVO attach : attachList) {
				File target = new File(attach.getUploadPath(), attach.getFileName());
				if (target.exists()) {
					target.delete();
				}
			}
		}

		noticeService.deleteNotice(lcode);

		rttr.addAttribute("lcode", lcode);
		rttr.addFlashAttribute("from", "remove");

		return url;
	}

	@RequestMapping("/modifyForm")
	public ModelAndView modifyForm(int lcode, int cnt, ModelAndView mnv) throws SQLException {
		String url = "notice/modify";
		
		System.out.println("cnt" + cnt);
		
		NoticeVO notice = noticeService.getNotice(lcode);

		if (notice != null) {
			List<AttachVO> attachList = notice.getAttachList();
			if (attachList != null) {
				for (AttachVO attach : attachList) {
					String fileName = attach.getFileName().split("\\$\\$")[1];
					attach.setFileName(fileName);
				}
			}
		}

		mnv.addObject("cnt", cnt);
		mnv.addObject("notice", notice);
		mnv.setViewName(url);

		return mnv;
	}

	@RequestMapping("/modify")
	public String modifyPost(NoticeModifyCommand modifyReq, HttpServletRequest request, RedirectAttributes rttr)
			throws Exception {
		String url = "redirect:/notice/detail.go";
		// 파일 삭제
		if (modifyReq.getDeleteFile() != null && modifyReq.getDeleteFile().length > 0) {
			for (String anoStr : modifyReq.getDeleteFile()) {
				int ano = Integer.parseInt(anoStr);
				AttachVO attach = noticeService.getAttachByAno(ano);

				File deleteFile = new File(attach.getUploadPath(), attach.getFileName());
				if (deleteFile.exists()) {
					deleteFile.delete(); // File 삭제
				}
				noticeService.removeAttachByAno(ano);// db 삭제
			}
		}
		// 파일 저장
		List<AttachVO> attachList = GetAttachesByMultipartFileAdapter.save(modifyReq.getUploadFile(), fileUploadPath);

		// pdsVO setting
		NoticeVO notice = modifyReq.toNoticeVO();
		notice.setAttachList(attachList);
		// pds.setTitle((String)request.getAttribute("XSStitle"));

		// DB 저장
		noticeService.updateNotice(notice);
		List<NoticeVO> fixList = noticeService.selectFixedList();

		rttr.addFlashAttribute("from", "modify");
		rttr.addAttribute("lcode", notice.getLcode());
		rttr.addAttribute("cnt", fixList.size());

		return url;
	}

	@RequestMapping("/getFile")
	public String getFile(int ano, Model model) throws Exception {
		String url = "downloadFile";
		AttachVO attach = noticeService.getAttachByAno(ano);

		model.addAttribute("savedPath", attach.getUploadPath());
		model.addAttribute("fileName", attach.getFileName());
		return url;
	}

}

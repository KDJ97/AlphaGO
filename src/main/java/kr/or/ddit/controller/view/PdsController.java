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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.command.PdsModifyCommand;
import kr.or.ddit.command.PdsRegistCommand;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.controller.rest.GetAttachesByMultipartFileAdapter;
import kr.or.ddit.dto.AttachVO;
import kr.or.ddit.dto.FavoritesVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.PdsVO;
import kr.or.ddit.service.FavoritesService;
import kr.or.ddit.service.PdsService;

@Controller
@RequestMapping("/pds")
public class PdsController {

	private static final Logger logger = LoggerFactory.getLogger(PdsController.class);

	@Autowired
	private PdsService pdsService;

	@Autowired
	private FavoritesService favoritesService;

	@RequestMapping("/list")
	public String list(SearchCriteria cri, HttpSession session, Model model) throws Exception {
		String url = "pds/list";

		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		if(member == null) {
			//로그인 session 정보가 없을 때
			url = "redirect:/common/loginTimeOut";
			logger.info("loginMember 정보가 없음");
			return url;
		}

		String id = member.getId();

		Map<String, Object> dataMap = null;
		try {
			dataMap = pdsService.getPdsList(cri);

		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<FavoritesVO> likeList = favoritesService.getFavoritesListById(id);

		model.addAttribute("dataMap", dataMap);
		model.addAttribute("likeList", likeList);

		return url;
	}



	@RequestMapping("/registForm")
	public String registForm() throws Exception {
		String url = "pds/regist";
		return url;
	}

	@RequestMapping("/detail")
	public String detail(int lCode, String from, Model model) throws Exception {
		String url = "pds/detail";
		logger.info("lCode : " + lCode);
		PdsVO pds = null;
		if(from != null && from.equals("list")){
			pds = pdsService.read(lCode);
			url = "redirect:/pds/detail.go?lCode=" + lCode;
		}else {
			pds = pdsService.getPds(lCode);
		}

		//파일명 재정의
		if(pds != null) {
			List<AttachVO> attachList = pds.getAttachList();
			if(attachList != null) {
				for(AttachVO attach : attachList) {
					String fileName = attach.getFileName().split("\\$\\$")[1];
					attach.setFileName(fileName);
				}
			}
		}


		model.addAttribute("pds", pds);

		return url;
	}

	@RequestMapping("/remove")
	public String remove(int lCode, HttpSession session, RedirectAttributes rttr) throws Exception{
		String url =  "redirect:/pds/detail.go";

		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		if(member == null) {
			//로그인 session 정보가 없을 때
			url = "redirect:/common/loginTimeOut";
			logger.info("loginMember 정보가 없음");
			return url;
		}
		String id = member.getId();

		// 첨부파일 삭제
		List<AttachVO> attachList = pdsService.getPds(lCode).getAttachList();
		if(attachList != null) {
			for(AttachVO attach : attachList) {
				File target = new File(attach.getUploadPath(), attach.getFileName());
				if(target.exists()) {
					target.delete();
				}
			}
		}

		favoritesService.removeFav(id, lCode);
		pdsService.remove(lCode);

		rttr.addAttribute("lCode", lCode);
		rttr.addFlashAttribute("from", "remove");

		return url;
	}

	 @Resource(name = "fileUploadPath")
	 private String fileUploadPath;

	 @RequestMapping(value="/regist",method=RequestMethod.POST, produces="text/plain; charset=utf-8")
	 public String regist(PdsRegistCommand registReq, HttpServletRequest request, RedirectAttributes rttr)throws Exception{
		 String url="redirect:/pds/list.go";

		 //file 저장
	     String savePath = this.fileUploadPath;

		 List<AttachVO> attachList = GetAttachesByMultipartFileAdapter.save(registReq. getUploadFile(),savePath);

	     //DB
	     PdsVO pds = registReq.toPdsVO();
	     pds.setAttachList(attachList);
         //pds.setTitle((String)request.getAttribute("XSStitle"));
         pdsService.regist(pds);

         //output
         rttr.addFlashAttribute("from","regist");
         return url;
      }


	 @RequestMapping("/modifyForm")
	 public ModelAndView modifyForm(int lCode, ModelAndView mnv) throws SQLException{
		 String url="pds/modify";

		 PdsVO pds = pdsService.getPds(lCode);

		 if(pds!=null) {
			 List<AttachVO>attachList=pds.getAttachList();
			 if(attachList!=null) {
				 for(AttachVO attach:attachList) {
					 String fileName=attach.getFileName().split("\\$\\$")[1];
					 attach.setFileName(fileName);
				}
			 }
		 }

		 mnv.addObject("pds",pds);
		 mnv.setViewName(url);

		 return mnv;
	}


	 @RequestMapping("/modify")
	 public String modifyPost(PdsModifyCommand modifyReq, HttpServletRequest request, RedirectAttributes rttr) throws Exception{
		String url = "redirect:/pds/detail.go";
		//파일 삭제
		if(modifyReq.getDeleteFile() != null && modifyReq.getDeleteFile().length>0) {
			 for(String anoStr:modifyReq.getDeleteFile()) {
				 int ano = Integer.parseInt(anoStr);
				 AttachVO attach = pdsService.getAttachByAno(ano);

				 File deleteFile = new File(attach.getUploadPath(),attach.getFileName());
				 if(deleteFile.exists()) {
					 deleteFile.delete();	//File 삭제
				 }
				 pdsService.removeAttachByAno(ano);//db 삭제
			}
		}
		//파일 저장
		List<AttachVO> attachList = GetAttachesByMultipartFileAdapter.save(modifyReq.getUploadFile(),fileUploadPath);

		//pdsVO setting
		PdsVO pds = modifyReq.toPdsVO();
		pds.setAttachList(attachList);
		//pds.setTitle((String)request.getAttribute("XSStitle"));

		//DB 저장
		pdsService.modify(pds);

		rttr.addFlashAttribute("from","modify");
		rttr.addAttribute("lCode",pds.getlCode());

		return url;
	}



	@RequestMapping("/getFile")
	public String getFile(int ano, Model model) throws Exception{
		String url = "downloadFile";
		AttachVO attach = pdsService.getAttachByAno(ano);

		model.addAttribute("savedPath",attach.getUploadPath());
		model.addAttribute("fileName",attach.getFileName());
		return url;
	}



}

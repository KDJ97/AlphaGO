package kr.or.ddit.controller.rest;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.List;

import javax.annotation.Resource;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.command.MakeFileName;
import kr.or.ddit.dto.StudentVO;
import kr.or.ddit.dto.TeachermasVO;
import kr.or.ddit.service.StudentService;
import kr.or.ddit.service.TeacherMasService;

@RestController
@RequestMapping("/mteacher")
public class TeacherRestController {

	@Autowired
	private StudentService studentService;
	@Autowired
	private TeacherMasService teacherMasService;

	@Resource(name = "picturePath")

	private String picturePath;

	public String savePicture(String oldPicture, MultipartFile multi) throws Exception {
		String fileName = null;

		/* 파일저장폴더설정 */
		String uploadPath = picturePath;

		/* 파일유무확인 */
		if (!(multi == null || multi.isEmpty() || multi.getSize() > 1024 * 1024 * 1)) {
			fileName = MakeFileName.toUUIDFileName(multi.getOriginalFilename(), "$$");
			File storeFile = new File(uploadPath, fileName);

			// 파일경로 생성
			storeFile.mkdirs();

			// local HDD에 저장
			multi.transferTo(storeFile);
		}

		// 기존파일 삭제
		if (oldPicture != null && !oldPicture.isEmpty()) {
			File oldFile = new File(uploadPath, oldPicture);
			if (oldFile.exists()) {
				oldFile.delete();
			}
		}
		return fileName;
	}

	@RequestMapping(value = "/picture", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	public ResponseEntity<String> picture(@RequestParam("pictureFile") MultipartFile multi, String oldPicture)
			throws Exception {

		ResponseEntity<String> entity = null;
		String result = "";
		HttpStatus status = null;

		/* 파일저장확인 */
		if ((result = savePicture(oldPicture, multi)) == null) {
			result = "업로드 실패했습니다.!";
			status = HttpStatus.BAD_REQUEST;
		} else {
			status = HttpStatus.OK;
		}

		entity = new ResponseEntity<String>(result, status);
		return entity;

	}

	@RequestMapping(value = "/getPicture", produces = "text/plain;charset=utf-8")
	public ResponseEntity<byte[]> getPicture(String id) throws Exception {

		System.out.println(id);

		String picture = teacherMasService.getTeacher(id).getPicture();
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		String imgPath = this.picturePath;

		try {
			in = new FileInputStream(new File(imgPath, picture));

			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), HttpStatus.CREATED);
		} finally {
			if (in != null)
				in.close();
		}
		return entity;
	}

	@RequestMapping("/idCheck")
	public ResponseEntity<String> idCheck(String id) throws Exception {
		ResponseEntity<String> entity = null;

		TeachermasVO teamas = teacherMasService.getTeacher(id);

		if (teamas != null) {
			entity = new ResponseEntity<String>("duplicated", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>("", HttpStatus.OK);
		}

		return entity;
	}

//	   @RequestMapping(value ="/teadetail",method = RequestMethod.POST, produces = "application/json;charset=utf-8")
//	   public ResponseEntity<TeachermasVO> teadetail(@RequestParam(value="id") String id)throws Exception{
//		   
//		     ResponseEntity<TeachermasVO>entity=null;
//		     
//		    System.out.println(id);
//		     
//		     TeachermasVO teamasVO=null;
//		   
//		     try {
//		    	 teamasVO= teacherMasService.getTeacher(id);
//		    	
//				entity = new ResponseEntity<TeachermasVO>(teamasVO, HttpStatus.OK);
//			} catch (Exception e) {
//				entity = new ResponseEntity<TeachermasVO>(HttpStatus.INTERNAL_SERVER_ERROR);
//				e.printStackTrace();
//			}
//			return entity;
//			
//			
//	   }

	@RequestMapping(value = "/teadetail", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public ResponseEntity<TeachermasVO> teadetail(@RequestParam(value = "id") String id) throws Exception {

		System.out.println(id);
		ResponseEntity<TeachermasVO> entity = null;

		System.out.println(id);

		TeachermasVO teamasVO = null;

		try {
			teamasVO = teacherMasService.getTeacher(id);

			entity = new ResponseEntity<TeachermasVO>(teamasVO, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<TeachermasVO>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
		return entity;

	}

	// 강사경력
	@RequestMapping(value = "/teacareer", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public ResponseEntity<List<TeachermasVO>> teacareer(@RequestParam(value = "id") String id, Model model)
			throws Exception {

		ResponseEntity<List<TeachermasVO>> entity = null;

		System.out.println(id);

		List<TeachermasVO> teamasVO = null;

		try {
			teamasVO = teacherMasService.selectTeacherCareer(id);

			entity = new ResponseEntity<List<TeachermasVO>>(teamasVO, HttpStatus.OK);

		} catch (Exception e) {
			entity = new ResponseEntity<List<TeachermasVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
		return entity;

	}

	@RequestMapping(value = "/gradetail", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public ResponseEntity<TeachermasVO> graphdetail(@RequestParam(value = "subject") String subject, Model model)
			throws Exception {

		ResponseEntity<TeachermasVO> entity = null;

		System.out.println(subject);

		TeachermasVO teamasVO = null;

		try {
			teamasVO = teacherMasService.selectFinalTestBykor(subject);

			entity = new ResponseEntity<TeachermasVO>(teamasVO, HttpStatus.OK);

		} catch (Exception e) {
			entity = new ResponseEntity<TeachermasVO>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
		return entity;

	}

	@RequestMapping(value = "/gradetail1", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public ResponseEntity<TeachermasVO> graphdetail1(@RequestParam(value = "subject") String subject, Model model)
			throws Exception {

		ResponseEntity<TeachermasVO> entity = null;

		System.out.println(subject);

		TeachermasVO teamasVO = null;

		try {
			teamasVO = teacherMasService.selectFinalTestByFisrtFinal(subject);

			entity = new ResponseEntity<TeachermasVO>(teamasVO, HttpStatus.OK);

		} catch (Exception e) {
			entity = new ResponseEntity<TeachermasVO>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
		return entity;

	}

	@RequestMapping(value = "/gradetail2", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public ResponseEntity<TeachermasVO> graphdetail2(@RequestParam(value = "subject") String subject, Model model)
			throws Exception {

		ResponseEntity<TeachermasVO> entity = null;

		System.out.println(subject);

		TeachermasVO teamasVO = null;

		try {
			teamasVO = teacherMasService.selectFinalTestBySecondMiddle(subject);

			entity = new ResponseEntity<TeachermasVO>(teamasVO, HttpStatus.OK);

		} catch (Exception e) {
			entity = new ResponseEntity<TeachermasVO>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
		return entity;

	}

	@RequestMapping(value = "/gradetail3", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public ResponseEntity<TeachermasVO> graphdetail3(@RequestParam(value = "subject") String subject, Model model)
			throws Exception {

		ResponseEntity<TeachermasVO> entity = null;

		System.out.println(subject);

		TeachermasVO teamasVO = null;

		try {
			teamasVO = teacherMasService.selectFinalTestBySecondFinal(subject);

			entity = new ResponseEntity<TeachermasVO>(teamasVO, HttpStatus.OK);

		} catch (Exception e) {
			entity = new ResponseEntity<TeachermasVO>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
		return entity;

	}
	
	//처음에 전체 별점 평균 
	@RequestMapping(value = "/allavgstar", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public ResponseEntity<TeachermasVO> allavgstar(@RequestParam(value = "id") String id, Model model)
			throws Exception {

		ResponseEntity<TeachermasVO> entity = null;

		System.out.println(id);

		TeachermasVO teamasVO = null;

		try {
			teamasVO = teacherMasService.selectAllStarById(id);

			entity = new ResponseEntity<TeachermasVO>(teamasVO, HttpStatus.OK);

		} catch (Exception e) {
			entity = new ResponseEntity<TeachermasVO>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
		return entity;

	}
	
	//selectbox로 수업이름 마다  별점 평균 
		@RequestMapping(value = "/classnameavgstar", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
		public ResponseEntity<TeachermasVO> classnameallavgstar(@RequestParam(value = "classCode") int classCode, Model model)
				throws Exception {

			ResponseEntity<TeachermasVO> entity = null;

			System.out.println(classCode);

			TeachermasVO teamasVO = null;

			try {
				teamasVO = teacherMasService.selectAvgByclassCode(classCode);

				entity = new ResponseEntity<TeachermasVO>(teamasVO, HttpStatus.OK);

			} catch (Exception e) {
				entity = new ResponseEntity<TeachermasVO>(HttpStatus.INTERNAL_SERVER_ERROR);
				e.printStackTrace();
			}
			return entity;

		}

	// 수업후기 수업명
	@RequestMapping(value = "/classend", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public ResponseEntity<List<TeachermasVO>> classend(@RequestParam(value = "id") String id, Model model)
			throws Exception {

		ResponseEntity<List<TeachermasVO>> entity = null;

		System.out.println(id);

		List<TeachermasVO> teamasVO = null;

		try {
			teamasVO = teacherMasService.selectclassName(id);

			entity = new ResponseEntity<List<TeachermasVO>>(teamasVO, HttpStatus.OK);

		} catch (Exception e) {
			entity = new ResponseEntity<List<TeachermasVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
		return entity;

	}

	// 전체수업후기
	@RequestMapping(value = "/classreview", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public ResponseEntity<List<TeachermasVO>> classend2(@RequestParam(value = "id") String id, Model model)
			throws Exception {

		ResponseEntity<List<TeachermasVO>> entity = null;

		System.out.println(id);

		List<TeachermasVO> teamasVO = null;

		try {
			teamasVO = teacherMasService.selectAllReviewListById(id);

			entity = new ResponseEntity<List<TeachermasVO>>(teamasVO, HttpStatus.OK);

		} catch (Exception e) {
			entity = new ResponseEntity<List<TeachermasVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
		return entity;

	}

	// 셀렉트박스누르면 바꿔짐
	@RequestMapping(value = "/reviewchange", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public ResponseEntity<List<TeachermasVO>> classend3(@RequestParam(value = "classCode") int classCode, Model model)
			throws Exception {

		ResponseEntity<List<TeachermasVO>> entity = null;

		System.out.println(classCode);

		List<TeachermasVO> teamasVO = null;

		try {
			teamasVO = teacherMasService.selectReviewListByClassCode(classCode);

			entity = new ResponseEntity<List<TeachermasVO>>(teamasVO, HttpStatus.OK);

		} catch (Exception e) {
			entity = new ResponseEntity<List<TeachermasVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
		return entity;

	}
	
	
	
	


}

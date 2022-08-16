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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.command.CalenderListCommand;
import kr.or.ddit.command.MakeFileName;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.MenuVO;
import kr.or.ddit.dto.StudentVO;
import kr.or.ddit.dto.TeachermasVO;
import kr.or.ddit.service.StudentService;
import kr.or.ddit.service.TeacherMasService;

@RestController
@RequestMapping("/mstudent")
public class StudentRestController {

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

		String picture = studentService.getStudent(id).getPicture();
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

		StudentVO student = studentService.getStudent(id);

		if (student != null) {
			entity = new ResponseEntity<String>("duplicated", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>("", HttpStatus.OK);
		}

		return entity;
	}

	@RequestMapping(value = "/studetail", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public ResponseEntity<StudentVO> studetail(@RequestParam(value = "id") String id) throws Exception {

		ResponseEntity<StudentVO> entity = null;

		StudentVO studentVO = null;

		try {
			studentVO = studentService.getStudent(id);

			entity = new ResponseEntity<StudentVO>(studentVO, HttpStatus.OK);

		} catch (Exception e) {
			entity = new ResponseEntity<StudentVO>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
		return entity;

	}

	@RequestMapping(value = "/teadetail", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public ResponseEntity<TeachermasVO> teadetail(@RequestParam(value = "id") String id) throws Exception {

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
	
	
//	   @ResponseBody
//	   @RequestMapping(value = "/sendsmss", method = RequestMethod.POST,produces = "application/json;charset=utf-8")
//	    public ResponseEntity<String> sendSms(HttpServletRequest request,@RequestParam(value ="id")String id) throws Exception {
//		ResponseEntity<String > entity = null;
//		String hostNameUrl = "https://sens.apigw.ntruss.com"; // 호스트 URL
//		String requestUrl = "/sms/v2/services/"; // 요청 URL
//		String requestUrlType = "/messages"; // 요청 URL
//		String accessKey = "NoBq1UwqZvVwUKmhBTHt"; // 네이버 클라우드 플랫폼 회원에게 발급되는 개인 인증키
//		String secretKey = "KfAuUX6Leinn8GMNVfSQH1Y1WXML53pVbPRzn8Oz"; // 2차 인증을 위해 서비스마다 할당되는 service secret
//		String serviceId = "ncp:sms:kr:288275248801:sms"; // 프로젝트에 할당된 SMS 서비스 ID
//		String method = "POST"; // 요청 method
//		String timestamp = Long.toString(System.currentTimeMillis()); // current timestamp (epoch)
//		requestUrl += serviceId + requestUrlType;
//		String apiUrl = hostNameUrl + requestUrl;
//
//		// JSON 을 활용한 body data 생성
//
//		JSONObject bodyJson = new JSONObject();
//		JSONObject toJson = new JSONObject();
//		JSONArray toArr = new JSONArray();
//
//		String refuse ="id는"+id+"입니다.비밀번호는 1234입니다.비밀번호는 변경해주세요"; // <-----------여기에 받아라
//
//		toJson.put("subject", "왜LMS?"); // 메시지 제목 * LMS Type에서만 사용할 수 있습니다.
//		toJson.put("content",refuse); // 메시지 내용 * Type별로 최대 byte 제한이 다릅니다.* SMS: 80byte / LMS: 2000byte <!-- 이게
//										// 진짜임!!!! -->
//		toJson.put("to", "01096470026"); // 수신번호 목록 * 최대 50개까지 한번에 전송할 수 있습니다.
//		// toJson.put("to","01032290177"); // 수신번호 목록 * 최대 50개까지 한번에 전송할 수 있습니다.
//		toArr.add(toJson);
//
//		bodyJson.put("type", "SMS"); // 메시지 Type (sms | lms)
//		bodyJson.put("contentType", "COMM"); // 메시지 내용 Type (AD | COMM) * AD: 광고용, COMM: 일반용 (default: COMM) * 광고용 메시지
//												// 발송 시 불법 스팸 방지를 위한 정보통신망법 (제 50조)가 적용됩니다.
//		bodyJson.put("countryCode", "82"); // 국가 전화번호
//		bodyJson.put("from", "01051448830"); // 발신번호 * 사전에 인증/등록된 번호만 사용할 수 있습니다.
//		bodyJson.put("subject", "AlphaGo"); // 메시지 제목 * LMS Type에서만 사용할 수 있습니다.
//		bodyJson.put("content",refuse); // 메시지 내용 * Type별로 최대 byte 제한이 다릅니다.* SMS: 80byte / LMS: 2000byte <!-- 왜
//												// 그런지모르겟는데 지우면 안됨 -->
//		bodyJson.put("messages", toArr);
//
//		String body = bodyJson.toJSONString();
//
//		System.out.println(body);
//
//		try {
//
//			URL url = new URL(apiUrl);
//
//			HttpURLConnection con = (HttpURLConnection) url.openConnection();
//			con.setUseCaches(false);
//			con.setDoOutput(true);
//			con.setDoInput(true);
//			con.setRequestProperty("content-type", "application/json");
//			con.setRequestProperty("x-ncp-apigw-timestamp", timestamp);
//			con.setRequestProperty("x-ncp-iam-access-key", accessKey);
//			con.setRequestProperty("x-ncp-apigw-signature-v2",
//					makeSignature(requestUrl, timestamp, method, accessKey, secretKey));
//			con.setRequestMethod(method);
//			con.setDoOutput(true);
//			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
//
//			wr.write(body.getBytes());
//			wr.flush();
//			wr.close();
//
//			int responseCode = con.getResponseCode();
//			BufferedReader br;
//			System.out.println("responseCode" + " " + responseCode);
//			if (responseCode == 202) { // 정상 호출
//				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
//			} else { // 에러 발생
//				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
//			}
//
//			String inputLine;
//			StringBuffer response = new StringBuffer();
//			while ((inputLine = br.readLine()) != null) {
//				response.append(inputLine);
//			}
//			br.close();
//
//			System.out.println(response.toString());
//			entity = new ResponseEntity<String>("연기 문자가 발송 되었습니다.", HttpStatus.OK);
//
//		} catch (Exception e) {
//			System.out.println(e);
//			entity = new ResponseEntity<String>("연기 문자가 발송 되었습니다.", HttpStatus.OK);
//		}
//		return entity;
//		
//		
//
//	}
//	public static String makeSignature(String url, String timestamp, String method, String accessKey, String secretKey)
//			throws NoSuchAlgorithmException, InvalidKeyException {
//		String space = " "; // one space
//		String newLine = "\n"; // new line
//
//		String message = new StringBuilder().append(method).append(space).append(url).append(newLine).append(timestamp)
//				.append(newLine).append(accessKey).toString();
//
//		SecretKeySpec signingKey;
//		String encodeBase64String;
//		try {
//
//			signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
//			Mac mac = Mac.getInstance("HmacSHA256");
//			mac.init(signingKey);
//			byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
//			encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);
//		} catch (UnsupportedEncodingException e) {
//			// TODO Auto-generated catch block
//			encodeBase64String = e.toString();
//		}
//
//		return encodeBase64String;
//	}

}

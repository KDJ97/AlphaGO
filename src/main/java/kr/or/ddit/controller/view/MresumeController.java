package kr.or.ddit.controller.view;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Base64;
import java.util.Map;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.ApplyVO;
import kr.or.ddit.dto.ResumeVO;
import kr.or.ddit.service.ApplyService;
import kr.or.ddit.service.PacounseltService;
import kr.or.ddit.service.ResumeService;
import kr.or.ddit.service.StudentService;
import kr.or.ddit.service.TeacherMasService;

@Controller
@RequestMapping("/mresume")
public class MresumeController {
	@Autowired

	private StudentService studentService;

	@Autowired
	private TeacherMasService teacherMasService;

	@Autowired
	private ApplyService applyService;

	@Autowired
	private PacounseltService counseltService;
	
	@Autowired
	private ResumeService resumeService;

	@RequestMapping("/list")
	public String resumelist(SearchCriteria cri, HttpSession session, Model model) throws Exception {
		String url = "mresume/list";

		Map<String, Object> dataMap = null;

		try {
			dataMap = applyService.getApplyList(cri);

//         if(true) throw new SQLException();

		} catch (SQLException e) {

			e.printStackTrace();
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("dataMap", dataMap);

		return url;
	}

	@RequestMapping("/pdfview")
	public String pdfview(Model model) throws Exception {
		String url = "mresume/pdfview";
		ResumeVO resume=resumeService.selectResumeBystatusY();
		String fileName =null;
		if(resume.getStatus().equals("Y")){
			fileName=resume.getFileName();
		}
		String pdf =fileName;
		model.addAttribute("pdfName", pdf);
		return url;
	}
	
	@RequestMapping("/modify")
	public String modify(Model model) throws Exception {
		String url = "mresume/modify";
		
		return url;
	}

	@RequestMapping("/getFile")
	public String getFile(int applyCode, Model model) throws Exception {
		String url = "downloadFile";

		   ApplyVO apply=applyService.selectApplyByApplyCode(applyCode);
		   
		   model.addAttribute("savedPath",apply.getApplyUploadPath());
		   model.addAttribute("fileName",apply.getApplyFilename());

		return url;
	}
	
	
	
	

		@ResponseBody
	   @RequestMapping(value = "/sendsmssss", method = RequestMethod.POST,produces = "application/json;charset=utf-8")
	     public ResponseEntity<String>send(HttpServletRequest request) throws Exception {
		ResponseEntity<String > entity = null;
		
		String hostNameUrl = "https://sens.apigw.ntruss.com"; // 호스트 URL
		String requestUrl = "/sms/v2/services/"; // 요청 URL
		String requestUrlType = "/messages"; // 요청 URL
		String accessKey = "NoBq1UwqZvVwUKmhBTHt"; // 네이버 클라우드 플랫폼 회원에게 발급되는 개인 인증키
		String secretKey = "KfAuUX6Leinn8GMNVfSQH1Y1WXML53pVbPRzn8Oz"; // 2차 인증을 위해 서비스마다 할당되는 service secret
		String serviceId = "ncp:sms:kr:288275248801:sms"; // 프로젝트에 할당된 SMS 서비스 ID
		String method = "POST"; // 요청 method
		String timestamp = Long.toString(System.currentTimeMillis()); // current timestamp (epoch)
		requestUrl += serviceId + requestUrlType;
		String apiUrl = hostNameUrl + requestUrl;

		// JSON 을 활용한 body data 생성

		JSONObject bodyJson = new JSONObject();
		JSONObject toJson = new JSONObject();
		JSONArray toArr = new JSONArray();

		String refuse ="면접 오세요"; // <-----------여기에 받아라

		toJson.put("subject", "왜LMS?"); // 메시지 제목 * LMS Type에서만 사용할 수 있습니다.
		toJson.put("content",refuse); // 메시지 내용 * Type별로 최대 byte 제한이 다릅니다.* SMS: 80byte / LMS: 2000byte <!-- 이게
										// 진짜임!!!! -->
		toJson.put("to", "01096470026"); // 수신번호 목록 * 최대 50개까지 한번에 전송할 수 있습니다.
		// toJson.put("to","01032290177"); // 수신번호 목록 * 최대 50개까지 한번에 전송할 수 있습니다.
		toArr.add(toJson);

		bodyJson.put("type", "SMS"); // 메시지 Type (sms | lms)
		bodyJson.put("contentType", "COMM"); // 메시지 내용 Type (AD | COMM) * AD: 광고용, COMM: 일반용 (default: COMM) * 광고용 메시지
												// 발송 시 불법 스팸 방지를 위한 정보통신망법 (제 50조)가 적용됩니다.
		bodyJson.put("countryCode", "82"); // 국가 전화번호
		bodyJson.put("from", "01051448830"); // 발신번호 * 사전에 인증/등록된 번호만 사용할 수 있습니다.
		bodyJson.put("subject", "AlphaGo"); // 메시지 제목 * LMS Type에서만 사용할 수 있습니다.
		bodyJson.put("content",refuse); // 메시지 내용 * Type별로 최대 byte 제한이 다릅니다.* SMS: 80byte / LMS: 2000byte <!-- 왜
												// 그런지모르겟는데 지우면 안됨 -->
		bodyJson.put("messages", toArr);

		String body = bodyJson.toJSONString();

		System.out.println(body);

		try {

			URL url = new URL(apiUrl);

			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setUseCaches(false);
			con.setDoOutput(true);
			con.setDoInput(true);
			con.setRequestProperty("content-type", "application/json");
			con.setRequestProperty("x-ncp-apigw-timestamp", timestamp);
			con.setRequestProperty("x-ncp-iam-access-key", accessKey);
			con.setRequestProperty("x-ncp-apigw-signature-v2",
					makeSignature(requestUrl, timestamp, method, accessKey, secretKey));
			con.setRequestMethod(method);
			con.setDoOutput(true);
			DataOutputStream wr = new DataOutputStream(con.getOutputStream());

			wr.write(body.getBytes());
			wr.flush();
			wr.close();

			int responseCode = con.getResponseCode();
			BufferedReader br;
			System.out.println("responseCode" + " " + responseCode);
			if (responseCode == 202) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}

			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();

			System.out.println(response.toString());
			entity = new ResponseEntity<String>("연기 문자가 발송 되었습니다.", HttpStatus.OK);

		} catch (Exception e) {
			System.out.println(e);
			entity = new ResponseEntity<String>("연기 문자가 발송 되었습니다.", HttpStatus.OK);
		}
		return entity;
		
		

	}
	public static String makeSignature(String url, String timestamp, String method, String accessKey, String secretKey)
			throws NoSuchAlgorithmException, InvalidKeyException {
		String space = " "; // one space
		String newLine = "\n"; // new line

		String message = new StringBuilder().append(method).append(space).append(url).append(newLine).append(timestamp)
				.append(newLine).append(accessKey).toString();

		SecretKeySpec signingKey;
		String encodeBase64String;
		try {

			signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
			Mac mac = Mac.getInstance("HmacSHA256");
			mac.init(signingKey);
			byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
			encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			encodeBase64String = e.toString();
		}

		return encodeBase64String;
	}

}

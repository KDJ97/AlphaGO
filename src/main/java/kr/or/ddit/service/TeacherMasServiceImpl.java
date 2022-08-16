package kr.or.ddit.service;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.imageio.ImageIO;
import javax.xml.bind.DatatypeConverter;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.MakeFileName;
import kr.or.ddit.command.PageMaker;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dao.StudentDAO;
import kr.or.ddit.dao.TeacherMasDAO;
import kr.or.ddit.dto.AttendanceVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.StudentVO;
import kr.or.ddit.dto.TeachermasVO;

public class TeacherMasServiceImpl implements TeacherMasService {

	private TeacherMasDAO teachermasDAO;

	public void setTeachermasDAO(TeacherMasDAO teachermasDAO) {
		this.teachermasDAO = teachermasDAO;
	}

	@Override
	public Map<String, Object> getTeacherList(Criteria cri) throws SQLException {
		SearchCriteria searchCri = (SearchCriteria) cri;
		Map<String, Object> dataMap = new HashMap<String, Object>();

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		try {
			pageMaker.setTotalCount(teachermasDAO.selectTeacherListCount(searchCri));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		List<TeachermasVO> teacherList = teachermasDAO.selectSearchTeacherList(searchCri);

		dataMap.put("teacherList", teacherList);
		dataMap.put("pageMaker", pageMaker);

		return dataMap;
	}

	@Override
	public void regist(TeachermasVO teamas, String uploadPath) throws Exception {

		String teaid = teachermasDAO.selectTeacherSequenceNextValue();

		if (teamas.getAuthority().equals("ROLE_STUDENT")) {
			teamas.setId("S" + teaid);
		} else if (teamas.getAuthority().equals("ROLE_TEACHER")) {
			teamas.setId("T" + teaid);
		}
		boolean check = true;
		if(teamas.getCaptureView()!=null&&teamas.getPicture()==null) {
			check = false;
			System.out.println("12113");
		}else if(teamas.getCaptureView()==null&&teamas.getPicture()!=null) {
			check = true;
			System.out.println("1231244");
		}
		
		String temppic = teamas.getCaptureView();
		System.out.println("temppic : " + temppic);
	      if (temppic != null) {
    		  byte[] imageBytes = DatatypeConverter.parseBase64Binary(temppic);
    		  System.out.println("imageBytes : " + imageBytes.hashCode());
    		  System.out.println("imageBytes size : " + imageBytes.length);
    		
//	            int num = mediRecodao.gettemppdsSeq();//파일 이름 시퀀스로 저장하기 위해 시퀀스 뽑아옴
    		  String seq = String.valueOf(teachermasDAO.getMemberPictureSeq());
    		  String result = seq+".jpg";
    		 
    		  BufferedImage image = null;

  			String[] base64Arr = temppic.split(","); // image/png;base64, 이 부분 버리기 위한 작업
  			byte[] imageByte = DatatypeConverter.parseBase64Binary(base64Arr[1]); // base64 to byte array로 변경
  			
  			
  			
  			ByteArrayInputStream bis = new ByteArrayInputStream(imageByte);
  			image = ImageIO.read(bis);
    		  
    		  
    		  String fileName = MakeFileName.toUUIDFileName(result, "$$");
    		  BufferedImage bufImg = ImageIO.read(new ByteArrayInputStream(imageBytes));
//    		  int width = 300;
//    		  int height = 150;
//    		  BufferedImage convertedGrayscale = new BufferedImage(width, height, BufferedImage.TYPE_BYTE_GRAY);
//    		  convertedGrayscale.getRaster().setDataElements(0, 0, width, height, imageBytes);

    		  System.out.println("image:"+image); 
 //  		  System.out.println("bufImg : " + bufImg);
   		

    		  ImageIO.write(image, "jpg", new File(uploadPath,fileName));
//    		  ImageIO.write(image, "png", new File("d:"+File.separator + fileName));
    		  teamas.setPicture(fileName);
    		  System.out.println(fileName);
	      }
		

		teachermasDAO.insertTeacher(teamas);
		
		String hostNameUrl = "https://sens.apigw.ntruss.com";     		// 호스트 URL
		String requestUrl= "/sms/v2/services/";                   		// 요청 URL
		String requestUrlType = "/messages";                      		// 요청 URL
		String accessKey = "NoBq1UwqZvVwUKmhBTHt";                     						// 네이버 클라우드 플랫폼 회원에게 발급되는 개인 인증키
		String secretKey = "KfAuUX6Leinn8GMNVfSQH1Y1WXML53pVbPRzn8Oz";  										// 2차 인증을 위해 서비스마다 할당되는 service secret
		String serviceId = "ncp:sms:kr:288275248801:sms";        									// 프로젝트에 할당된 SMS 서비스 ID
		String method = "POST";											// 요청 method
		String timestamp = Long.toString(System.currentTimeMillis()); 	// current timestamp (epoch)
		requestUrl += serviceId + requestUrlType;
		String apiUrl = hostNameUrl + requestUrl;
		
		// JSON 을 활용한 body data 생성
		
		JSONObject bodyJson = new JSONObject();
		JSONObject toJson = new JSONObject();
	    JSONArray  toArr = new JSONArray();
	    
	    String refuse ="아이디는"+teamas.getId()+"이고 비빌번호는 1234입니다.비밀번호를 변경해주세요";  //       <-----------여기에 받아라 
	    
	    toJson.put("subject","왜LMS?");				// 메시지 제목 * LMS Type에서만 사용할 수 있습니다.
	    toJson.put("content",refuse);				// 메시지 내용 * Type별로 최대 byte 제한이 다릅니다.* SMS: 80byte / LMS: 2000byte  <!-- 이게 진짜임!!!! -->
	    toJson.put("to","01096470026");					// 수신번호 목록  * 최대 50개까지 한번에 전송할 수 있습니다.
	    //toJson.put("to","01032290177");					// 수신번호 목록  * 최대 50개까지 한번에 전송할 수 있습니다.
	    toArr.add(toJson);
	    
	    bodyJson.put("type","SMS");				// 메시지 Type (sms | lms)
	    bodyJson.put("contentType","COMM");			// 메시지 내용 Type (AD | COMM) * AD: 광고용, COMM: 일반용 (default: COMM) * 광고용 메시지 발송 시 불법 스팸 방지를 위한 정보통신망법 (제 50조)가 적용됩니다.
	    bodyJson.put("countryCode","82");		// 국가 전화번호
	    bodyJson.put("from","01051448830");				// 발신번호 * 사전에 인증/등록된 번호만 사용할 수 있습니다.		
	    bodyJson.put("subject","AlphaGo");				// 메시지 제목 * LMS Type에서만 사용할 수 있습니다.
	    bodyJson.put("content","학원 내일 안엽니다");				// 메시지 내용 * Type별로 최대 byte 제한이 다릅니다.* SMS: 80byte / LMS: 2000byte  <!-- 왜 그런지모르겟는데 지우면 안됨 -->
	    bodyJson.put("messages", toArr);		
	    

	    String body = bodyJson.toJSONString();
	    
	    System.out.println(body);
	    
        try {

            URL url = new URL(apiUrl);

            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setUseCaches(false);
            con.setDoOutput(true);
            con.setDoInput(true);
            con.setRequestProperty("content-type", "application/json");
            con.setRequestProperty("x-ncp-apigw-timestamp", timestamp);
            con.setRequestProperty("x-ncp-iam-access-key", accessKey);
            con.setRequestProperty("x-ncp-apigw-signature-v2", makeSignature(requestUrl, timestamp, method, accessKey, secretKey));
            con.setRequestMethod(method);
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            
            wr.write(body.getBytes());
            wr.flush();
            wr.close();

            int responseCode = con.getResponseCode();
            BufferedReader br;
            System.out.println("responseCode" +" " + responseCode);
            if(responseCode==202) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }

            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            
            System.out.println(response.toString());

        } catch (Exception e) {
            System.out.println(e);
        }
    }
	
	public static String makeSignature(String url, String timestamp, String method, String accessKey, String secretKey) throws NoSuchAlgorithmException, InvalidKeyException {
	    String space = " ";                    // one space
	    String newLine = "\n";                 // new line
	    

	    String message = new StringBuilder()
	        .append(method)
	        .append(space)
	        .append(url)
	        .append(newLine)
	        .append(timestamp)
	        .append(newLine)
	        .append(accessKey)
	        .toString();

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

	

	@Override
	public TeachermasVO getTeacher(String id) throws Exception {

		TeachermasVO teamas = teachermasDAO.selectTeacherById(id);

		return teamas;
	}

	@Override
	public void remove(String id) throws Exception {
		teachermasDAO.deleteTeacher(id);

	}

	@Override
	public TeachermasVO selectScoreBySubjectName(String subjectName) throws SQLException {
		TeachermasVO teamas = teachermasDAO.selectScoreBySubjectName(subjectName);

		return teamas;
	}

	@Override
	public Map<String, Object> getTeacherAttendList(Criteria cri) throws SQLException {
		SearchCriteria searchCri = (SearchCriteria) cri;
		Map<String, Object> dataMap = new HashMap<String, Object>();
		cri.setPerPageNum(10);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		try {
			pageMaker.setTotalCount(teachermasDAO.selectTeacherAttendListCount(searchCri));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		List<TeachermasVO> teacherattendList = teachermasDAO.selectSearchTeacherAttendList(searchCri);

		dataMap.put("teacherattendList", teacherattendList);
		dataMap.put("pageMaker", pageMaker);

		return dataMap;
	}

	@Override
	public Map<String, Object> getTeacherAllAttendList(String id) throws Exception {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
//		PageMaker pageMaker = new PageMaker();
//		pageMaker.setCri(cri);
//
//		pageMaker.setTotalCount(teachermasDAO.selectSearchAllAttendTeacherByIdListCount(id));

		List<TeachermasVO> teattendList = null;
		try {
			teattendList = teachermasDAO.selectAllAttendTeacherById(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		dataMap.put("teattendList", teattendList);
		//dataMap.put("pageMaker", pageMaker);
		return dataMap;
	}

	@Override
	public List<TeachermasVO> selectAllAttendTeacherByChartId(String id) throws SQLException {
		return teachermasDAO.selectAllAttendTeacherByChartId(id);
	}

	@Override
	public TeachermasVO selectFinalTestBykor(String subject) throws SQLException {
		TeachermasVO teamas = teachermasDAO.selectFinalTestBykor(subject);

		return teamas;
	}

	@Override
	public TeachermasVO selectFinalTestByFisrtFinal(String subject) throws SQLException {
		TeachermasVO teamas = teachermasDAO.selectFinalTestByFisrtFinal(subject);

		return teamas;
	}

	@Override
	public TeachermasVO selectFinalTestBySecondMiddle(String subject) throws SQLException {
		TeachermasVO teamas = teachermasDAO.selectFinalTestBySecondMiddle(subject);

		return teamas;
	}

	@Override
	public TeachermasVO selectFinalTestBySecondFinal(String subject) throws SQLException {
		TeachermasVO teamas = teachermasDAO.selectFinalTestBySecondFinal(subject);

		return teamas;
	}

	@Override
	public List<TeachermasVO> selectclassName(String id) throws Exception {
		return teachermasDAO.selectclassName(id);
	}

	@Override
	public List<TeachermasVO> selectReviewListByClassCode(int classCode) throws Exception {
		return teachermasDAO.selectReviewListByClassCode(classCode);
	}

	@Override
	public List<TeachermasVO> selectAllReviewListById(String id) throws Exception {
		return teachermasDAO.selectAllReviewListById(id);
	}

	@Override
	public List<TeachermasVO> selectTeacherCareer(String id) throws Exception {
		return teachermasDAO.selectTeacherCareer(id);
	}

	@Override
	public TeachermasVO selectAllStarById(String id) throws SQLException {
		TeachermasVO teamas = teachermasDAO.selectAllStarById(id);

		return teamas;
	}

	@Override
	public TeachermasVO selectAvgByclassCode(int classCode) throws SQLException {
		TeachermasVO teamas = teachermasDAO.selectAvgByclassCode(classCode);

		return teamas;
	}

	@Override
	public Map<String, Object> selectClassTeacheringById(String id) throws Exception {
		Map<String, Object> data = new HashMap<String, Object>();

		List<TeachermasVO> classteacherList = teachermasDAO.selectClassTeacheringById(id);
		System.out.println(classteacherList.size());
		System.out.println(classteacherList);
		
		List<TeachermasVO> realList = new ArrayList<TeachermasVO>();//담아줄 리스트
		
		for(TeachermasVO teacherMasVO : classteacherList) {
//			System.out.println("sdf"+teacherMasVO);
			String classCode = String.valueOf(teacherMasVO.getClassCode());
//			System.out.println("classCode : " + classCode);
			
			LocalDate localDate = LocalDate.now();
			System.out.println(localDate.toString());
			
//			System.out.println("요일 : " + localDate.getDayOfMonth());
			//월요일 1 화요일 2 수요일 3 목요일 4 금요일 5 토요일 6 일요일 7
			
			int classday=localDate.getDayOfMonth();
			if(classday==7) {
				classday=0;
			}
			ClassVO classvo=new ClassVO();
			classvo.setClassCode(classCode);
			classvo.setClassday(classday);
//			System.out.println("이거다:"+classvo.getClassCode());
//			System.out.println("classday:"+classvo.getClassday());
			
			TeachermasVO teamas=teachermasDAO.selectClassTimeByClassDay(classvo);
			if(teamas!=null) {
				teacherMasVO.setStartTime(teamas.getStartTime());
				teacherMasVO.setEndTime(teamas.getEndTime());
//				System.out.println("starttime:"+teamas.getStartTime());
//				System.out.println("endtime:"+teamas.getEndTime());
				
				realList.add(teacherMasVO);
				System.out.println("걸러진 오늘 수업 있는 애들 : " + realList);
				System.out.println("걸러진 개수 : " + realList.size());
			}
			
		}
		data.put("classteacherList", realList);

		return data;
	}

	@Override
	public TeachermasVO selectTeacherAttendDetail(String id) throws SQLException {
		TeachermasVO teamas = teachermasDAO.selectTeacherAttendDetail(id);

		return teamas;
	}

	

}

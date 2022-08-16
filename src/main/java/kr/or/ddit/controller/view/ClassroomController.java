package kr.or.ddit.controller.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.command.ClassroomCommand;
import kr.or.ddit.command.ClassroomModifyCommand;
import kr.or.ddit.command.MakeFileName;
import kr.or.ddit.command.RoomCommand;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.ClassroomVO;
import kr.or.ddit.dto.UseFixtVO;
import kr.or.ddit.dto.UseRoomVO;
import kr.or.ddit.service.ClassService;
import kr.or.ddit.service.ClassroomService;

@Controller
@RequestMapping("/classroom")
public class ClassroomController {

	@Autowired
	ClassroomService classroomService;
	
	@Autowired
	ClassService classService;
	
	/**
	 * 강의실 목록 컨트롤러
	 * @param cri
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String classroom(SearchCriteria cri, Model model) throws Exception{
		String url = "classroom/list";

		Map<String, Object> dataMap = classroomService.getAllClassroom(cri);
		
		model.addAttribute("dataMap", dataMap);
		
		return url;
	}
	
	/**
	 * 사용중인 수업실 정보
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/useRoomList")
	public ResponseEntity<List<ClassroomVO>> useRoomList() {
		ResponseEntity<List<ClassroomVO>> entity = null;
		List<ClassroomVO> useRoomList = null;
		try {
			useRoomList = classroomService.selectUnUsedRoomList();
			entity = new ResponseEntity<List<ClassroomVO>>(useRoomList, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<ClassroomVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	@ResponseBody
	@RequestMapping("/wholeRoomData")
	public ResponseEntity<Map<String, Object>> wholeRoomData() {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> roomData = null;
		try {
			roomData = classroomService.wholeRoomData();
			entity = new ResponseEntity<Map<String, Object>>(roomData, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	
	
	
	@RequestMapping("/registForm")
	public String roomRegistForm() throws Exception{
		String url = "classroom/regist";
		return url;
	}
	
	
	/**
	 * 강의실 등록 컨트롤러
	 * @param map
	 * @param rttr
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/regist",method = RequestMethod.POST,produces = "text/plain;charset=utf-8")
	public String classRegist(ClassroomCommand roomCommand,RedirectAttributes rttr) throws Exception{
		String url = "redirect:/classroom/list.go";
		
		classroomService.registClassroom(roomCommand);
		rttr.addFlashAttribute("from", "regist");
		
		return url;
	}
	
	/**
	 * 강의실 삭제 컨트롤러
	 * @param map
	 * @param rttr
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/classRemove")
	public String removeClassroom(@RequestParam Map<String, Object> map, RedirectAttributes rttr) throws Exception{
		String url = "redirect:/classroom/list.go";
		
		String roomCode = (String)map.get("roomCode");
		System.out.println(roomCode);
		
		int rcode=Integer.parseInt(roomCode);
		try {
			classroomService.removeClassroom(rcode);
			rttr.addFlashAttribute("from", "1");
		} catch (Exception e) {
			rttr.addFlashAttribute("from", "0");
		}
		
		return url;
	}
	
	@Autowired
	private String classroomUploadPath; //강의실 사진업로드 경로
	
	@ResponseBody
	@RequestMapping(value="/picture",method = RequestMethod.POST,produces = "text/plain;charset=utf-8")
	public ResponseEntity<String> uploadPicture(String oldPicture, @RequestParam("pictureFile")MultipartFile multi) throws Exception{
	      ResponseEntity<String> entity = null;
	      String result = "";
	      HttpStatus status = null;
	      
	      /* 파일저장확인 */
	      if((result = savePicture(oldPicture, multi)) == null) {
	         result = "업로드 실패했습니다.!";
	         status = HttpStatus.BAD_REQUEST;
	      }else {
	         status = HttpStatus.OK;
	      }
	      
	      entity = new ResponseEntity<String>(result, status);
	      return entity;
	}
	
	  public String savePicture(String oldPicture, MultipartFile multi)throws Exception{
	      String fileName = null;
	      
	      /* 파일저장폴더설정 */
	      String uploadPath = classroomUploadPath;
	      
	      /* 파일유무확인 */
	      if(!(multi == null || multi.isEmpty() || multi.getSize() > 1024 * 1024 * 1)) {
	         fileName = MakeFileName.toUUIDFileName(multi.getOriginalFilename(), "$$");
	         File storeFile = new File(uploadPath, fileName);
	         
	         // 파일경로 생성
	         storeFile.mkdirs();
	         
	         //local HDD에 저장
	         multi.transferTo(storeFile);
	      }
	      
	      // 기존파일 삭제
	      if(oldPicture != null && !oldPicture.isEmpty()) {
	         File oldFile = new File(uploadPath, oldPicture);
	         if(oldFile.exists()) {
	            oldFile.delete();
	         }
	      }
	      return fileName;
	   }
	  
	  
	   @RequestMapping("/roomCheck")
	   public ResponseEntity<String> idCheck(String roomNo)throws Exception{
	      ResponseEntity<String> entity = null;
	      
	      ClassroomVO room = classroomService.selectRoomByRno(roomNo);
	      
	      if(room != null) {
	         entity = new ResponseEntity<String>("duplicated", HttpStatus.OK);
	      }else {
	         entity = new ResponseEntity<String>("", HttpStatus.OK);
	      }
	      
	      return entity;
	   }
	   
	   //강의실 사진 가져오기
	   @ResponseBody
	   @RequestMapping(value = "/getPicture", produces = "text/plain;charset=utf-8")
	   public ResponseEntity<byte[]> getPicture(String roomCode)throws Exception{
	      
	      String picture = classroomService.getOneClassroom(roomCode).getPicture();
	      System.out.println(picture);
	      InputStream in = null;
	      ResponseEntity<byte[]> entity = null;
	      String imgPath = classroomUploadPath;
	      
	      try {
	         in = new FileInputStream(new File(imgPath, picture));
	         System.out.println(in);
	         entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), HttpStatus.CREATED);
	      }finally {
	         if(in!=null) in.close();
	      }
	      return entity;
	   }
	   
	   @RequestMapping("/detail")
	   public String detail(String roomCode, SearchCriteria cri, Model model) throws Exception{
		   String url="classroom/detail";
		   System.out.println("roomCode : " + roomCode);
		   
		   Map<String, Object> dataMap = classroomService.selectClassListByRoomCode(roomCode, cri);
		   dataMap.put("roomCode", roomCode);
		   model.addAttribute("dataMap", dataMap);
		   
		   return url;
	   }
	   
		@ResponseBody
		@RequestMapping("/getUseRoomTime")	
		public ResponseEntity<List<UseRoomVO>> getUseRoomList(String roomCode){
			ResponseEntity<List<UseRoomVO>> entity = null;
			List<UseRoomVO> list = null;
			try {
				list = classroomService.getUseRoomTimeByCpcheck(roomCode);
				entity = new ResponseEntity<List<UseRoomVO>>(list, HttpStatus.OK);
			} catch (Exception e) {
				entity = new ResponseEntity<List<UseRoomVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
			return entity;
		}
		
		//해당강의실의 오늘 수업이 있는 수업정보 리스트를 가져온다
		@ResponseBody
		@RequestMapping("/selectClassListByRoomCodeClassDay")	
		public ResponseEntity<List<ClassVO>> selectClassListByRoomCodeClassDay(String roomCode){
			ResponseEntity<List<ClassVO>> entity = null;
			List<ClassVO> list = null;
			try {
				list = classroomService.selectClassListByRoomCodeClassDay(roomCode);
				entity = new ResponseEntity<List<ClassVO>>(list, HttpStatus.OK);
			} catch (Exception e) {
				entity = new ResponseEntity<List<ClassVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
			return entity;
		}
		
		
		@ResponseBody
		@RequestMapping(value="/selectClassTimeByRoom",method=RequestMethod.POST,produces = "application/json;charset=utf-8")	
		public ResponseEntity<List<ClassroomVO>> selectClassTimeByRoom(@RequestBody ClassVO classVO){
			ResponseEntity<List<ClassroomVO>> entity = null;
			List<ClassroomVO> list = null;
			System.out.println("classVO" + classVO);
			try {
				list = classroomService.selectClassTimeByRoom(classVO);
				entity = new ResponseEntity<List<ClassroomVO>>(list, HttpStatus.OK);
			} catch (Exception e) {
				entity = new ResponseEntity<List<ClassroomVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
			return entity;
		}
		
		@RequestMapping("/modifyForm")
		public String modifyForm(String roomCode, Model model) throws Exception{
			String url="classroom/modify";
			Map<String, Object> dataMap = new HashMap<String, Object>();
			
			ClassroomVO room = classroomService.getOneClassroom(roomCode);
			List<UseFixtVO> fixtList = classroomService.getUsedFixtByRoomCode(roomCode);
			
			RoomCommand command = new RoomCommand();
			command.setRoomCode(room.getRoomCode());
			command.setCapacity(room.getCapacity());
			command.setUsePurpose(room.getUsePurpose());
			command.setRoomNo(room.getRoomNo());
			command.setPicture(room.getPicture());
			
			for(UseFixtVO fix : fixtList) {
				String fxtCode = fix.getFxtcode();
				
				switch (fxtCode) {
				case "FXT_01":
					command.setFx1("Y");
					break;
				case "FXT_02":
					command.setFx2("Y");
					break;
				case "FXT_03":
					command.setFx3("Y");
					break;
				case "FXT_04":
					command.setFx4("Y");
					break;
				case "FXT_05":
					command.setFx5("Y");
					break;
				case "FXT_06":
					command.setFx6("Y");
					break;
				}
			}
			
			dataMap.put("room", command);
			model.addAttribute("dataMap", dataMap);
			return url;
		}
		
		@RequestMapping(value="/modify",method = RequestMethod.POST, produces="text/plain;charset=utf-8")
		public String modify(ClassroomModifyCommand roomCommand, RedirectAttributes rttr) throws Exception{
			String url="redirect:/classroom/detail.go";
			
			ClassroomVO room = roomCommand.toRoomVO();
			
			//강의실 사진 수정
			String oldPicture = classroomService.getOneClassroom(room.getRoomCode()).getPicture();
			if(roomCommand.getUploadPicture()!=null && !roomCommand.getUploadPicture().isEmpty()) {
				String fileName = savePicture(oldPicture, roomCommand.getPicture());
				room.setPicture(fileName);
			}else {
				room.setPicture(oldPicture);
			}
			
			//강의실 업데이트
			classroomService.updateClassroom(room);
			
			//비품 업데이트
			String status1 = roomCommand.getFx1();
			String status2 = roomCommand.getFx2();
			String status3 = roomCommand.getFx3();
			String status4 = roomCommand.getFx4();
			String status5 = roomCommand.getFx5();
			String status6 = roomCommand.getFx6();
			
			if(status1.equals("Y")) {
				room.setFxtcode("FXT_01");
				int cnt = classroomService.selectUseFixtCountByRoomCode(room);
				UseFixtVO fixt = new UseFixtVO();
				if(cnt==0) {
					String fxtno = String.valueOf(classroomService.getUseFixtSeq());
					fixt.setFixuseno(fxtno);
					fixt.setFxtcode("FXT_01");
					fixt.setRoomCode(room.getRoomCode());
					classroomService.insertUseFixt(fixt);
				}
			}
			if(status2.equals("Y")) {
				room.setFxtcode("FXT_02");
				int cnt = classroomService.selectUseFixtCountByRoomCode(room);
				UseFixtVO fixt = new UseFixtVO();
				if(cnt==0) {
					String fxtno = String.valueOf(classroomService.getUseFixtSeq());
					fixt.setFixuseno(fxtno);
					fixt.setFxtcode("FXT_02");
					fixt.setRoomCode(room.getRoomCode());
					classroomService.insertUseFixt(fixt);
				}
			}
			if(status3.equals("Y")) {
				room.setFxtcode("FXT_03");
				int cnt = classroomService.selectUseFixtCountByRoomCode(room);
				UseFixtVO fixt = new UseFixtVO();
				if(cnt==0) {
					String fxtno = String.valueOf(classroomService.getUseFixtSeq());
					fixt.setFixuseno(fxtno);
					fixt.setFxtcode("FXT_03");
					fixt.setRoomCode(room.getRoomCode());
					classroomService.insertUseFixt(fixt);
				}
			}
			if(status4.equals("Y")) {
				room.setFxtcode("FXT_04");
				int cnt = classroomService.selectUseFixtCountByRoomCode(room);
				UseFixtVO fixt = new UseFixtVO();
				if(cnt==0) {
					String fxtno = String.valueOf(classroomService.getUseFixtSeq());
					fixt.setFixuseno(fxtno);
					fixt.setFxtcode("FXT_04");
					fixt.setRoomCode(room.getRoomCode());
					classroomService.insertUseFixt(fixt);
				}
			}
			if(status5.equals("Y")) {
				room.setFxtcode("FXT_05");
				int cnt = classroomService.selectUseFixtCountByRoomCode(room);
				UseFixtVO fixt = new UseFixtVO();
				if(cnt==0) {
					String fxtno = String.valueOf(classroomService.getUseFixtSeq());
					fixt.setFixuseno(fxtno);
					fixt.setFxtcode("FXT_05");
					fixt.setRoomCode(room.getRoomCode());
					classroomService.insertUseFixt(fixt);
				}
			}
			if(status6.equals("Y")) {
				room.setFxtcode("FXT_06");
				int cnt = classroomService.selectUseFixtCountByRoomCode(room);
				UseFixtVO fixt = new UseFixtVO();
				if(cnt==0) {
					String fxtno = String.valueOf(classroomService.getUseFixtSeq());
					fixt.setFixuseno(fxtno);
					fixt.setFxtcode("FXT_06");
					fixt.setRoomCode(room.getRoomCode());
					classroomService.insertUseFixt(fixt);
				}
			}
			
			rttr.addFlashAttribute("from", "modify");
			
			return url;
		}
		
		
}






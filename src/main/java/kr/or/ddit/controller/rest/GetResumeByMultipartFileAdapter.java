package kr.or.ddit.controller.rest;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.command.MakeFileName;
import kr.or.ddit.dto.ResumeVO;

public class GetResumeByMultipartFileAdapter {
	
public static List<ResumeVO> save(List<MultipartFile> multiFiles, String savePath) throws Exception{
		
		List<ResumeVO> assignList  = new ArrayList<ResumeVO>();
		if(multiFiles !=null && multiFiles.size()>0) {
			for(MultipartFile multi : multiFiles) {
				if(multi.getSize()==0) {
					break;
				}
//				String fileName = MakeFileName.toUUIDFileName(multi.getOriginalFilename(), "$$");
				String fileName = multi.getOriginalFilename();
				File target = new File(savePath, fileName);
				System.out.println("fileName from Adapter : " + fileName);
				System.out.println("savePath from Adapter : " + savePath);
				target.mkdirs();

				multi.transferTo(target);
				
				ResumeVO assign = new ResumeVO();
				
				assign.setUploadPath(savePath);
				assign.setFileName(fileName);
				//assign.setFiletype(fileName.substring(fileName.lastIndexOf('.')+1).toUpperCase());;
				assignList.add(assign);
			}
		}
		
		return assignList;
	}

}

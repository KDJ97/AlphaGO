package kr.or.ddit.controller.rest;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.command.MakeFileName;
import kr.or.ddit.dto.AssignVO;

public class GetAssignByMultipartFileAdapter {

	public static List<AssignVO> save(List<MultipartFile> multiFiles, String savePath) throws Exception{
		
		List<AssignVO> assignList  = new ArrayList<AssignVO>();
		if(multiFiles !=null && multiFiles.size()>0) {
			for(MultipartFile multi : multiFiles) {
				if(multi.getSize()==0) {
					break;
				}
				String fileName = MakeFileName.toUUIDFileName(multi.getOriginalFilename(), "$$");
				File target = new File(savePath, fileName);
				
				target.mkdirs();

				multi.transferTo(target);
				
				AssignVO assign = new AssignVO();
				
				assign.setUploadpath(savePath);
				assign.setFilename(fileName);
				assign.setFiletype(fileName.substring(fileName.lastIndexOf('.')+1).toUpperCase());;
				assignList.add(assign);
			}
		}
		
		
		return assignList;
	}
}

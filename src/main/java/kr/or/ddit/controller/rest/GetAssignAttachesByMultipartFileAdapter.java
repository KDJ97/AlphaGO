package kr.or.ddit.controller.rest;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.command.MakeFileName;
import kr.or.ddit.dto.AssignAttachVO;
import kr.or.ddit.dto.AttachVO;

public class GetAssignAttachesByMultipartFileAdapter {

	public static List<AssignAttachVO> save(List<MultipartFile> multiFiles, String savePath) throws Exception{

		List<AssignAttachVO> attachList = new ArrayList<AssignAttachVO>();

		//저장 -> attachVO -> list.add
		if(multiFiles != null && multiFiles.size()>0) {
			for(MultipartFile multi : multiFiles) {
				if(multi.getSize()==0) {
					break;
				}
				String fileName = MakeFileName.toUUIDFileName(multi.getOriginalFilename(), "$$");
				File target = new File(savePath, fileName);

				target.mkdirs();

				multi.transferTo(target);

				AssignAttachVO attach = new AssignAttachVO();

				attach.setUploadpath(savePath);
				attach.setFilename(fileName);
				attach.setFiletype(fileName.substring(fileName.lastIndexOf('.')+1).toUpperCase());
				attachList.add(attach);
			}
		}
		return attachList;
	}

}

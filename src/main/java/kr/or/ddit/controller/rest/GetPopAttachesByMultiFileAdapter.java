package kr.or.ddit.controller.rest;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.command.MakeFileName;
import kr.or.ddit.dto.PopAttachVO;

public class GetPopAttachesByMultiFileAdapter {

	public static List<PopAttachVO> save(List<MultipartFile> multiFiles, String savePath) throws Exception{

		List<PopAttachVO> attachList = new ArrayList<PopAttachVO>();

		//저장 -> PopAttachVO -> list.add
		if(multiFiles != null) {
			for(MultipartFile multi : multiFiles) {
				String fileName = MakeFileName.toUUIDFileName(multi.getOriginalFilename(), "$$");
				File target = new File(savePath, fileName);

				target.mkdirs();

				multi.transferTo(target);

				PopAttachVO attach = new PopAttachVO();

				attach.setUploadpath(savePath);
				attach.setFilename(fileName);
				attach.setFiletype((fileName.substring(fileName.lastIndexOf('.')+1).toUpperCase()));
				attachList.add(attach);
			}
		}
		return attachList;
	}
	
}

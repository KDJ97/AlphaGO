package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.PageMaker;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dao.TecounseltDAO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.TecounseltVO;

public class TecounseltServiceImpl implements TecounseltService{
	
	private TecounseltDAO tecounseltDAO;
	
	public void setTecounseltDAO(TecounseltDAO tecounseltDAO) {
		this.tecounseltDAO = tecounseltDAO;
	}

	@Override
	public Map<String, Object> getCounseltList(Criteria cri, Integer counCode) throws SQLException {
		SearchCriteria searchCri = (SearchCriteria) cri;
		Map<String, Object> dataMap = new HashMap<String, Object>();

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		try {
			pageMaker.setTotalCount(tecounseltDAO.selectCounseltListCount(searchCri));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		List<TecounseltVO> counseltList =tecounseltDAO.selectSearchCounseltList(searchCri);

		for (TecounseltVO counselt : counseltList) {
			try {
				String name =tecounseltDAO.selectName(counselt.getCounCode());
				//String universityname = counseltDAO.selectFuUniv(counselt.getPcCode());
				//String universitynames = counseltDAO.selectSuUniv(counselt.getPcCode());
				//String phone = counseltDAO.selectStudentPhone(counselt.getPcCode());
				//String id = counseltDAO.selectId(counselt.getPcCode());
				// String universitynames=counseltDAO.selectSuUniv(counselt.getPcCode());
				// String name=counseltDAO.selectName(counselt.getCounCode());
				// counselt.setPcCode(pcCode);
				// counselt.setCounCode(counCode);
				//counselt.setUniversityNames(universitynames);
				//counselt.setUniversityName(universityname);
				// counselt.setUniversityName(universitynames);
				counselt.setName(name);
				//counselt.setPhone(phone);
				//counselt.setId(id);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		dataMap.put("counseltList", counseltList);
		dataMap.put("pageMaker", pageMaker);

		return dataMap;
	}
	}
	
	


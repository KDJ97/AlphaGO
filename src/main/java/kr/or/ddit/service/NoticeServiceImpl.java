package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.Category;
import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.PageMaker;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dao.AttachDAO;
import kr.or.ddit.dao.LboardDAO;
import kr.or.ddit.dao.NoticeDAO;
import kr.or.ddit.dto.AttachVO;
import kr.or.ddit.dto.LboardVO;
import kr.or.ddit.dto.NoticeVO;
import kr.or.ddit.dto.PdsVO;

public class NoticeServiceImpl implements NoticeService{
    private NoticeDAO noticeDAO;
    public void setNoticeDAO(NoticeDAO noticeDAO) {
		this.noticeDAO = noticeDAO;
	}

    private AttachDAO attachDAO;
	public void setAttachDAO(AttachDAO attachDAO) {
		this.attachDAO = attachDAO;
	}

	private LboardDAO lBoardDAO;
	public void setLBoardDAO(LboardDAO lBoardDAO) {
		this.lBoardDAO = lBoardDAO;
	}

	@Override
	public Map<String, Object> getNoticeList(Criteria cri) throws SQLException {
		SearchCriteria searchCri = (SearchCriteria) cri;
		Map<String, Object> dataMap = new HashMap<String, Object>();

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(noticeDAO.selectSearchNoticeListCount(searchCri));

		List<NoticeVO> noticeList = noticeDAO.selectSearchNoticeList(searchCri);

		if(noticeList!=null) {
			for(NoticeVO nv : noticeList) {
				addAttachList(nv);
			}
		}

		dataMap.put("noticeList", noticeList);
		dataMap.put("pageMaker", pageMaker);

		return dataMap;
	}

	@Override
	public List<NoticeVO> getNoticeList() throws Exception {
		List<NoticeVO> noticeList = noticeDAO.selectAllNoticeList();

		if(noticeList != null)
			for(NoticeVO notice : noticeList)
				addAttachList(notice);

		return noticeList;
	}

	private void addAttachList(NoticeVO notice) throws SQLException{
		if(notice == null) return;

		int lcode = notice.getLcode();

		List<AttachVO> attachList = attachDAO.selectAttachesByLCode(lcode);

		notice.setAttachList(attachList);
	}

	@Override
	public NoticeVO selectNoticeByLcode(int lcode) throws SQLException {
		NoticeVO notice = noticeDAO.selectNoticeByLcode(lcode);
		noticeDAO.increaseViewCnt(lcode);

		addAttachList(notice);

		return notice;
	}
	@Override
	public void deleteNotice(int lcode) throws SQLException {
		noticeDAO.deleteNotice(lcode);

	}
	@Override
	public void insertNotice(NoticeVO notice) throws SQLException {
		int lcode = lBoardDAO.selectLboardSeqNext();

		LboardVO lBoard = new LboardVO();
		lBoard.setLcode(lcode);
		lBoard.setBcode("notice");

		lBoardDAO.insertLboard(lBoard);

		notice.setLcode(lcode);
		noticeDAO.insertNotice(notice);

		if (notice.getAttachList() != null) for (AttachVO attach : notice.getAttachList()) {
			attach.setlCode(lcode);
			attach.setAttacher(notice.getWriter());
			attachDAO.insertAttach(attach);
		}

	}
	@Override
	public void updateNotice(NoticeVO notice) throws SQLException {
		noticeDAO.updateNotice(notice);

		// attachDAOBean.deleteAllAttach(pds.getPno()); 삭제예정

		if (notice.getAttachList() != null)
			for (AttachVO attach : notice.getAttachList()) {
				attach.setlCode(notice.getLcode());
				attach.setAttacher(notice.getWriter());
				attachDAO.insertAttach(attach);

			}

	}

	@Override
	public AttachVO getAttachByAno(int ano) throws SQLException {
		AttachVO attach = attachDAO.selectAttachByAno(ano);

		attach.getAno();


		return attach;
	}

	@Override
	public void removeAttachByAno(int ano) throws SQLException {
		attachDAO.deleteAttach(ano);

	}

	@Override
	public NoticeVO getNotice(int lcode) throws SQLException {
		NoticeVO notice = noticeDAO.selectNoticeByLcode(lcode);

		addAttachList(notice);

		return notice;
	}

	@Override
	public List<NoticeVO> selectFixedList() throws SQLException {
		List<NoticeVO> fixList = noticeDAO.selectFixedList();

		if(fixList!=null) {
			for(NoticeVO nv : fixList) {
				addAttachList(nv);
			}
		}

		return fixList;
	}

//	@Override
//	public List<NoticeVO> selectCateNoticeList(String name, SearchCriteria cri) throws SQLException {
//		Map<String, Object> map = new HashMap<String, Object>();
//		Category category = new Category();
//		category.setName(name);
//
//		System.out.println(category.getName());
//
//		PageMaker pageMaker = new PageMaker();
//		pageMaker.setCri(cri);
//		pageMaker.setTotalCount(noticeDAO.selectSearchNoticeListCount(cri));
//
//		map.put("pageMaker", pageMaker);
//		map.put("category", category);
//
//		List<NoticeVO> noticeList = noticeDAO.selectCateNoticeList(map);
//
//		for(NoticeVO notice : noticeList) {
//			System.out.println(notice.getTitle());
//		}
//
//		return noticeList;
//	}


}

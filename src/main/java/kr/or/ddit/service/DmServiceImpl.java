package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.dao.DmDAO;
import kr.or.ddit.dto.DmVO;

public class DmServiceImpl implements DmService {

	private DmDAO dmDAO;
	public void setDmDAO(DmDAO dmDAO) {
		this.dmDAO = dmDAO;
	}

	@Override
	public List<DmVO> getSendList(String id) throws Exception {
		List<DmVO> dmList = dmDAO.selectSendList(id);
		return dmList;
	}

	@Override
	public List<DmVO> getReciveList(String id) throws Exception {
		List<DmVO> dmList = dmDAO.selectReciveList(id);
		return dmList;
	}

	@Override
	public DmVO getDm(String code, String from) throws Exception {

		String div = null;

		if("reciveList".equals(from)) {
			div = "R";
			//받은 사람이 상세조회 했을 경우 같은 코드의 쪽지를 읽음으로 변경
			dmDAO.updateDmByRead(code);
		}
		if("sendList".equals(from)) {
			div = "S";
		}

		DmVO dm = dmDAO.selectDm(code, div);

		return dm;
	}

	@Override
	public int selectNewDm(String id) throws Exception {
		int cnt = dmDAO.selectNewDm(id);
		return cnt;
	}

	@Override
	public void deleteDm(String code, String div) throws Exception {
		dmDAO.deleteDm(code, div);
	}

	@Override
	public void sendDm(List<String> to, String from, String title, String content) {

		for(int i=0; i<to.size(); i++) {

			int code = dmDAO.selectMaxDm();

			//R쪽지 insert
			DmVO r_dm = new DmVO();
			r_dm.setDmCode(code);
			r_dm.setDmDiv("R");
			r_dm.setDmTitle(title);
			r_dm.setDmContent(content);
			r_dm.setDmSender(from);
			r_dm.setDmReceiver(to.get(i));

			//S쪽지 insert
			DmVO s_dm = new DmVO();
			s_dm.setDmCode(code);
			s_dm.setDmDiv("S");
			s_dm.setDmTitle(title);
			s_dm.setDmContent(content);
			s_dm.setDmSender(from);
			s_dm.setDmReceiver(to.get(i));

			dmDAO.insertDm(r_dm);
			dmDAO.insertDm(s_dm);
		}
	}

	@Override
	public List<DmVO> getNotReadDm(String id) throws Exception {
		return dmDAO.selectNotReadDmById(id);
	}

}

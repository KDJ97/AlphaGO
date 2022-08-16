package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.Map;

import kr.or.ddit.command.Criteria;

public interface TecounseltService {
	
	//상담 리스트
	Map<String, Object> getCounseltList(Criteria cri, Integer counCode) throws SQLException;

}

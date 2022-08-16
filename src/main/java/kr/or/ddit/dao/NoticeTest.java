package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.NoticeVO;

public class NoticeTest {
	public static void main(String[] args) throws SQLException{
		ApplicationContext context 
		= new ClassPathXmlApplicationContext(new String[] {"/kr/or/ddit/context/root-context.xml"}
				);
		
		NoticeDAO noticeDAO = (NoticeDAO)context.getBean("noticeDAO");
		
		System.out.println(context);
		
		System.out.println("noticeDAO : " + noticeDAO);
		
		SearchCriteria cri = new SearchCriteria();
		
		List<NoticeVO> list = noticeDAO.selectSearchNoticeList(cri);
		System.out.println(list.size());
		
		for(NoticeVO noticeVO:list) {
			System.out.println(noticeVO);
		}
	}

}

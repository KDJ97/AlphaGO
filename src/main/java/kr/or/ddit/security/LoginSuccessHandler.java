package kr.or.ddit.security;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import kr.or.ddit.dto.MemberVO;

public class LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

	private String savePath = "c:\\log";
	private String saveFileName = "login_user_log.csv";

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {

		User user = (User) authentication.getDetails();
		System.out.println("user autorities from LoginSuccessHandler: " + user.getAuthorities());
		Collection<? extends GrantedAuthority> roles = user.getAuthorities();

		// 로그인 유저의 권한을 뽑는 과정
		GrantedAuthority first = roles.iterator().next();
		String fauth = first.getAuthority();
		String auth = fauth.substring(5, 6);
		System.out.println("auth from loginSuccessHandler >>" + auth);

		// session에 저장.
		MemberVO loginUser = user.getMemberVO();

		HttpSession session = request.getSession();
		session.setAttribute("loginUser", loginUser);
		session.setAttribute("auth", auth);
		session.setMaxInactiveInterval(60 * 60);

		// log 작성
		loginUserlogFile(loginUser, request);

		// 화면전환
		super.onAuthenticationSuccess(request, response, authentication);
	}

	private void loginUserlogFile(MemberVO loginUser, HttpServletRequest request) throws IOException {
		// 로그인 정보를 스트링으로 저장
		String tag = "[login:user]";
		String log = tag + loginUser.getId() + "," + loginUser.getPhone() + "," + loginUser.getEmail() + ","
				+ request.getRemoteAddr() + "," + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

		File file = new File(savePath);
		file.mkdirs();

		String logFilePath = savePath + File.separator + saveFileName;
		BufferedWriter out = new BufferedWriter(new FileWriter(logFilePath, true));

		// 로그를 기록
		out.write(log);
		out.newLine();

		out.close();
	}

}

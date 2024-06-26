package com.example.demo.vo;

import java.io.IOException;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import com.example.demo.service.GameService;
import com.example.demo.service.MemberService;
import com.example.demo.util.Ut;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.Getter;

@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class Rq {
	@Getter
	private boolean isLogined;
	@Getter
	private int loginedMemberId;
	@Getter
	private Member loginedMember;
	@Getter
	private Player player;
	@Getter
	private int selectedplayer;
	
	
	private HttpSession session;

	private HttpServletRequest req;
	private HttpServletResponse resp;

	public Rq(HttpServletRequest req, HttpServletResponse resp, MemberService memberService, GameService gameService) {
		this.req = req;
		this.resp = resp;
		this.session = req.getSession();

		HttpSession httpSession = req.getSession();

		if (httpSession.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) httpSession.getAttribute("loginedMemberId");
			loginedMember = memberService.getMember(loginedMemberId);;
			Integer fplayerValue = loginedMember.getFplayer(); 
		    // System.out.println(fplayerValue + "^^^^^^^^^^^^^^^^^^^^^^^^");
		    if (fplayerValue != null) {
		        if (fplayerValue != 0) {
		            player = gameService.getPlayer(fplayerValue);
		            selectedplayer = memberService.getselectedplayer(loginedMemberId);
		        }
		    }
				
		}

		this.req.setAttribute("rq", this);
	}

	public void printHistoryBack(String msg) throws IOException {
		resp.setContentType("text/html; charset=UTF-8");
		println("<script>");
		if (!Ut.isEmpty(msg)) {
			System.err.println("alert('" + msg + "');");
			println("alert('" + msg + "');");
		}
		println("history.back();");
		println("</script>");
	}

	private void println(String str) {
		print(str + "\n");
	}

	private void print(String str) {
		try {
			resp.getWriter().append(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void logout() {
		session.removeAttribute("loginedMemberId");
	}

	public void login(Member member) {
		session.setAttribute("loginedMemberId", member.getId());
	}

	public void initBeforeActionInterceptor() {

	}

	public String historyBackOnView(String msg) {
		req.setAttribute("msg", msg);
		req.setAttribute("historyBack", true);
		return "usr/common/js";
	}

	public String getCurrentUri() {
		String currentUri = req.getRequestURI();
		String queryString = req.getQueryString();

		System.err.println(currentUri);
		System.err.println(queryString);

		if (currentUri != null && queryString != null) {
			currentUri += "?" + queryString;
		}

		System.out.println(currentUri);

		return currentUri;
	}

	public void jsprintReplace(String resultCode, String msg, String replaceUri) {
		resp.setContentType("text/html; charset=UTF-8");
		print(Ut.jsReplace(resultCode, msg, replaceUri));

	}

	public String getLoginUri() {
		return "../member/login?afterLoginUri=" + getAfterLoginUri();
	}

	private String getAfterLoginUri() {
		return getEncodedCurrentUri();
	}
	
	public String getImgUri(int id) {
		return "/common/genFile/file/article/" + id + "/extra/Img/1";
	}

	public String getProfileFallbackImgUri() {
		return "https://via.placeholder.com/150/?text=*";
	}

	public String getProfileFallbackImgOnErrorHtml() {
		return "this.src = '" + getProfileFallbackImgUri() + "'";
	}
	
	public String getEncodedCurrentUri() {
		return Ut.getEncodedCurrentUri(getCurrentUri());
	}

	public String getLogoutUri() {
		return "../member/doLogout?afterLogoutUri=" + getAfterLogoutUri();
	}

	private String getAfterLogoutUri() {

		String requestUri = req.getRequestURI();

		return getEncodedCurrentUri();
	}
	
	public String getFindLoginIdUri() {
		return "../member/findId?afterFindLoginIdUri=" + getAfterFindLoginIdUri();
	}

	private String getAfterFindLoginIdUri() {
		return getEncodedCurrentUri();
	}

	public String getFindLoginPwUri() {
		return "../member/findPw?afterFindLoginPwUri=" + getAfterFindLoginPwUri();
	}

	private String getAfterFindLoginPwUri() {
		return getEncodedCurrentUri();
	}

	
}
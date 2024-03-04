package com.example.demo.controller;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.MemberService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Member;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UsrMemberController {

	@Autowired
	private Rq rq;
	
	@Autowired
	private MemberService memberService;

	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout(HttpServletRequest req) {
		Rq rq = (Rq) req.getAttribute("rq");

		if (!rq.isLogined()) {
			return Ut.jsHistoryBack("F-A", "이미 로그아웃 상태입니다");
		}

		rq.logout();

		return Ut.jsReplace("S-1", "로그아웃 되었습니다", "/");
	}

	@RequestMapping("/usr/member/login")
	public String showLogin(HttpServletRequest req) {

		Rq rq = (Rq) req.getAttribute("rq");

		if (rq.isLogined()) {
			return Ut.jsHistoryBack("F-A", "이미 로그인 함");
		}
		
		return "usr/member/login";
	}

	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(HttpServletRequest req, HttpSession httpSession, String loginId, String loginPw) {

		Rq rq = (Rq) req.getAttribute("rq");

		if (rq.isLogined()) {
			return Ut.jsHistoryBack("F-A", "이미 로그인 함");
		}

		if (Ut.isNullOrEmpty(loginId)) {
			return Ut.jsHistoryBack("F-1", "아이디를 입력해주세요");
		}
		if (Ut.isNullOrEmpty(loginPw)) {
			return Ut.jsHistoryBack("F-2", "비밀번호를 입력해주세요");
		}

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return Ut.jsHistoryBack("F-3", Ut.f("%s(은)는 존재하지 않는 아이디입니다", loginId));
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			return Ut.jsHistoryBack("F-4", Ut.f("비밀번호가 일치하지 않습니다"));
		}

		rq.login(member);

		return Ut.jsReplace("S-1", Ut.f("%s님 환영합니다", member.getLoginId()), "/");
	}

	@RequestMapping("/usr/member/join")
	public String showJoin(HttpServletRequest req) {

		Rq rq = (Rq) req.getAttribute("rq");

		if (rq.isLogined()) {
			return Ut.jsHistoryBack("F-A", "이미 로그인 함");
		}

		return "usr/member/join";
	}
	
	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public String doJoin(HttpServletRequest req, String loginId, String loginPw, String birth, String mname, 
			String cellphoneNum, String email, String address) {
		
		Rq rq = (Rq) req.getAttribute("rq");
		if (rq.isLogined()) {
			return Ut.jsHistoryBack("F-A", "이미 로그인 상태입니다");
		}
		if (Ut.isNullOrEmpty(loginId)) {
			return Ut.jsHistoryBack("F-1", "아이디를 입력해주세요");
		}
		if (Ut.isNullOrEmpty(loginPw)) {
			return Ut.jsHistoryBack("F-2", "비밀번호를 입력해주세요");
		}
		if (Ut.isNullOrEmpty(mname)) {
			return Ut.jsHistoryBack("F-3", "이름을 입력해주세요");
		}
		if (Ut.isNullOrEmpty(birth)) {
			return Ut.jsHistoryBack("F-4", "생년월일을 입력해주세요");
		}
		if (Ut.isNullOrEmpty(email)) {
			return Ut.jsHistoryBack("F-5", "이메일을 입력해주세요");
		}
 
		ResultData<Integer> joinRd = memberService.join(loginId, loginPw, birth, mname, cellphoneNum, email, address);

		if (joinRd.isFail()) {
			return Ut.jsHistoryBack(joinRd.getResultCode(), joinRd.getMsg());
		}

		Member member = memberService.getMember(joinRd.getData1());

		return Ut.jsReplace(joinRd.getResultCode(), joinRd.getMsg(), "../member/login");
	}
	
	@SuppressWarnings("unused")
	@RequestMapping("/usr/member/doAction")
	@ResponseBody
	public String doAction(String loginId) {
		
		Member existsMember = memberService.getMemberByLoginId(loginId);
		
		String msg = "중복된 아이디가 존재합니다.";
		
		if (existsMember == null) {
			if (loginId == "") {
				msg = "아이디는 필수 정보입니다.";
				return msg;
			}
			msg = "사용가능한 아이디입니다.";
			return msg;
		}

		return msg;
	}
	
	@RequestMapping("/usr/member/mypage")
	public String showMypage(HttpServletRequest req, Model model) {
		
		Rq rq = (Rq) req.getAttribute("rq");
		int id = rq.getLoginedMemberId();
		
		Member member = memberService.getMember(id);
		
		model.addAttribute("member", member);
		
		return "usr/member/mypage";
	}
	
	@RequestMapping("/usr/member/modify")
	public String showModify(HttpServletRequest req, Model model) {
		
		Rq rq = (Rq) req.getAttribute("rq");
		int id = rq.getLoginedMemberId();
		
		Member member = memberService.getMember(id);
		
		model.addAttribute("member", member);
		
		return "usr/member/modify";
	}
	
	@RequestMapping("/usr/member/doModify")
	@ResponseBody
	public String doModify(HttpServletRequest req, String loginPw, String mname,
			String cellphoneNum, String email, String address) {
		
		Rq rq = (Rq) req.getAttribute("rq");
		int id = rq.getLoginedMemberId();
		
		memberService.setMember(id, loginPw, mname, cellphoneNum, email, address);
//		req.setAttribute(nickname, nickname);
		
		return Ut.jsReplace("S-1", "회원정보가 수정되었습니다", "/");
	}
	@RequestMapping("/usr/member/findId")
	public String showFindId(HttpServletRequest req) {

		Rq rq = (Rq) req.getAttribute("rq");

		if (rq.isLogined()) {
			return Ut.jsHistoryBack("F-A", "이미 로그인 함");
		}

		return "usr/member/findId";
	}
	
	@RequestMapping("/usr/member/dofindId")
	@ResponseBody
	public String doFindId(HttpServletRequest req, String mname, String cellphoneNum, String email) {
		
		Rq rq = (Rq) req.getAttribute("rq");
		int id = rq.getLoginedMemberId();
		
		if (Ut.isNullOrEmpty(mname)) {
			return Ut.jsHistoryBack("F-1", "이름을 입력해주세요");
		}
		if (Ut.isNullOrEmpty(cellphoneNum)) {
			return Ut.jsHistoryBack("F-2", "전화번호를 입력해주세요");
		}
		
		return Ut.jsReplace("S-1", "회원정보가 수정되었습니다", "/");
	}
	
	@RequestMapping("/usr/member/findPw")
	public String showFindPw(HttpServletRequest req) {

		Rq rq = (Rq) req.getAttribute("rq");

		if (rq.isLogined()) {
			return Ut.jsHistoryBack("F-A", "이미 로그인 함");
		}

		return "usr/member/findPw";
	}
	
	@RequestMapping("/usr/member/dofindPw")
	@ResponseBody
	public String doFindPw(HttpServletRequest req, String loginId) {
		
//		Rq rq = (Rq) req.getAttribute("rq");
//		
//		int id = rq.getLoginedMemberId();
		
		if (Ut.isNullOrEmpty(loginId)) {
			return Ut.jsHistoryBack("F-1", "아이디를 입력해주세요");
		}
		
		return Ut.jsReplace("S-1", "회원정보가 수정되었습니다", "/");
	}
	
	@RequestMapping("/usr/member/membership")
	public String membership(HttpServletRequest req, Model model) {

		Rq rq = (Rq) req.getAttribute("rq");

		int id = rq.getLoginedMemberId();
		
		Member member = memberService.getMember(id);
		
		model.addAttribute("member", member);
		
		return "usr/member/membership";
	}
	
	@RequestMapping("/usr/member/doMembership")
	@ResponseBody
	public String doMembership(HttpServletRequest req, Model model, String loginId, String mname, 
			String cellphoneNum, String email, String address, String level) {
		
		int memberlevel = memberService.getMemberBylevel(loginId);
		
		if (memberlevel == 1 || memberlevel == 2) {
			return Ut.jsHistoryBack("F-1", "이미 멤버쉽이 등록되었습니다.");
		}
		
		int lv = Integer.parseInt(level);
		
		// @SuppressWarnings("unused") 경고 메시지를 무시하도록 지정
		String membercode;
		String type;
	
        if (lv == 1) {
        	membercode = "G" + (int) (Math.random() * (99999 - 10000 + 1) + 10000);
        	type = "골드";
        } else {
        	membercode = "S" + (int) (Math.random() * (99999 - 10000 + 1) + 10000);
        	type = "실버";
        }

		ResultData<Integer> membershipRd = memberService.membership(loginId, lv, membercode, type);
		
		memberService.setMember2(loginId, mname, cellphoneNum, email, address, lv, membercode, type);
		
		if (membershipRd.isFail()) {
			return Ut.jsHistoryBack(membershipRd.getResultCode(), membershipRd.getMsg());
		}

		return Ut.jsReplace(membershipRd.getResultCode(), membershipRd.getMsg(), "../member/mypage");
		
	}
	
}
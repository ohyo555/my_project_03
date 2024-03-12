package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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
	public String doLogout(HttpServletRequest req, @RequestParam(defaultValue = "/") String afterLogoutUri) {
		Rq rq = (Rq) req.getAttribute("rq");

		if (!rq.isLogined()) {
			return Ut.jsHistoryBack("F-A", "이미 로그아웃 상태입니다");
		}

		rq.logout();

		return Ut.jsReplace("S-1", "로그아웃 되었습니다", afterLogoutUri);
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
	public String doLogin(HttpServletRequest req, String loginId, String loginPw,
			@RequestParam(defaultValue = "/") String afterLoginUri) {

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
		
		if (member.isDelStatus()) {
			return Ut.jsHistoryBack("F-5", Ut.f("%s(은)는 탈퇴 계정입니다.", loginId));
		} // boolean값이 0이면 false, 1이면 true
		
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
			String cellphoneNum, String email, String postcode, String address, String detailAddress, String extraAddress) {

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

		String fulladdress = address + detailAddress + extraAddress;
		
		ResultData<Integer> joinRd = memberService.join(loginId, loginPw, birth, mname, cellphoneNum, email, postcode, fulladdress);

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

	@PostMapping("/usr/member/doModify")
	@ResponseBody
	public String doModify(@RequestBody Member member, HttpServletRequest req) {
		Rq rq = (Rq) req.getAttribute("rq");
		int id = rq.getLoginedMemberId();
		String loginId = rq.getLoginedMember().getLoginId();

		Member findmember = memberService.getMemberByLoginId(loginId);

		if (member.getLoginPw() == null || member.getLoginPw() == "") {
			return "비밀번호를 입력해주세요.";
		} else if (!findmember.getLoginPw().equals(member.getLoginPw())) {
			return "비밀번호가 일치하지 않습니다";
		} else {
			memberService.setMember(id, member.getLoginPw(), member.getMname(), member.getCellphoneNum(),
					member.getEmail(), member.getAddress());
			return "회원정보가 수정되었습니다";
		}
	}

	@PostMapping("/usr/member/dopwModify")
	@ResponseBody
	public String dopwModify(@RequestBody Member member, HttpServletRequest req) {
		Rq rq = (Rq) req.getAttribute("rq");
		int id = rq.getLoginedMemberId();
		String loginId = rq.getLoginedMember().getLoginId();

		Member findmember = memberService.getMemberByLoginId(loginId);

		if (!findmember.getLoginPw().equals(member.getLoginPw())) {
			return "비밀번호가 일치하지 않습니다";
		} else if(findmember.getLoginPw().equals(member.getNew_loginPw())){
			return "기존 비밀번호와 동일합니다, 변경할 비밀번호를 입력하세요.";
		} else{
			memberService.setMember(id, member.getNew_loginPw());
			return "회원정보가 수정되었습니다";
		}
	}
	
	@PostMapping("/usr/member/dodel")
	@ResponseBody
	public String dodel(@RequestBody Member member, HttpServletRequest req) {
		Rq rq = (Rq) req.getAttribute("rq");
		int id = rq.getLoginedMemberId();
		String loginId = rq.getLoginedMember().getLoginId();

		Member findmember = memberService.getMemberByLoginId(loginId);

		if (!findmember.getLoginPw().equals(member.getLoginPw())) {
			return "비밀번호가 일치하지 않습니다";
		} else{
			memberService.delMember(id);
			return "탈퇴되었습니다.";
		}
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
		String loginId = rq.getLoginedMember().getLoginId();
		
		int memberlevel = memberService.getMemberBylevel(loginId);

//		if (memberlevel == 1 || memberlevel == 2) {
//			
////			return Ut.jsHistoryBack("F-1", "이미 멤버쉽이 등록되었습니다.");
//			return "alredy registered";
//		}
//		
		Member member = memberService.getMember(id);
		
		model.addAttribute("member", member);
		
		return "usr/member/membership";
		
	}

	@RequestMapping("/usr/member/doMembership")
	@ResponseBody
	public String doMembership(HttpServletRequest req, Model model, String loginId, String mname, String cellphoneNum,
			String email, String address, String level) {

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

		return Ut.jsHistoryBack(membershipRd.getResultCode(), membershipRd.getMsg());

	}

	@RequestMapping("/usr/member/selectplayer")
	@ResponseBody
	public String doselectplayer(String player, HttpServletRequest req) {
		Rq rq = (Rq) req.getAttribute("rq");

		String loginId = rq.getLoginedMember().getLoginId();

		Member findmember = memberService.getMemberByLoginId(loginId);

		memberService.setfplayer(loginId, player);
		return "응원선수 선택이 완료되었습니다.";

	}

	@RequestMapping("/usr/member/upload")
	@ResponseBody
	public String handleFileUpload(HttpServletRequest req, @RequestParam("photo") MultipartFile file) {
        // 여기에 파일 저장 또는 처리 로직을 추가합니다.
        // 예: 파일을 서버의 특정 경로에 저장하거나, 데이터베이스에 저장합니다.
		Rq rq = (Rq) req.getAttribute("rq");
		
		int id = rq.getLoginedMemberId();
		memberService.upload(file, id);
		
        // 이후 페이지로 리다이렉트 또는 다른 처리를 수행할 수 있습니다.
        return "이미지가 업로드되었습니다.";
    }

}
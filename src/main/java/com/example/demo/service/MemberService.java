package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.MemberRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.Member;
import com.example.demo.vo.ResultData;

@Service
public class MemberService {
	@Autowired
	private MemberRepository memberRepository;

	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}

	public ResultData<Integer> join(String loginId, String loginPw, String birth, String mname, String cellphoneNum, 
			String email, String address) {
		Member existsMember = getMemberByLoginId(loginId);

		if (existsMember != null) {
			return ResultData.from("F-7", Ut.f("이미 사용중인 아이디(%s)입니다", loginId));
		}

		existsMember = getMemberByNameAndEmail(mname, email);

		if (existsMember != null) {
			return ResultData.from("F-8", Ut.f("이미 사용중인 이름(%s)과 이메일(%s)입니다", mname, email));
		}

		memberRepository.join(loginId, loginPw, birth, mname, cellphoneNum, email, address);

		int id = memberRepository.getLastInsertId();

		return ResultData.from("S-1", "회원가입이 완료되었습니다.", "id", id);

	}

	private Member getMemberByNameAndEmail(String mname, String email) {
		return memberRepository.getMemberByNameAndEmail(mname, email);
	}

	public Member getMemberByLoginId(String loginId) {
		return memberRepository.getMemberByLoginId(loginId);
	}

	public Member getMember(int id) {
		return memberRepository.getMember(id);
	}
	
	public void setMember(int id, String loginPw, String mname, String cellphoneNum, String email, String address) {
		memberRepository.setMember(id, loginPw, mname, cellphoneNum, email, address);
	}

	public ResultData<Integer> membership(String loginId, int lv, String membercode, String type) {
		
		memberRepository.membership(loginId, lv, membercode, type);

		int id = memberRepository.getLastInsertId();
		
		return ResultData.from("S-1", "멤버쉽가입이 완료되었습니다.", "id", id);
	}

	public void setMember2(String loginId, String mname, String cellphoneNum, String email, String address, int lv, String membercode, String type) {
		memberRepository.setMember2(loginId, mname, cellphoneNum, email, address, lv, membercode, type);
	}

	public int getMemberBylevel(String loginId) {
		return memberRepository.getMemberBylevel(loginId);
	}

}
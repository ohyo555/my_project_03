package com.example.demo.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;

import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
			String email, String postcode, String fulladdress) {
		Member existsMember = getMemberByLoginId_1(loginId);

		if (existsMember != null) {
			return ResultData.from("F-7", Ut.f("이미 사용중인 아이디(%s)입니다", loginId));
		}

		existsMember = getMemberByNameAndEmail(mname, email);

		if (existsMember != null) {
			return ResultData.from("F-8", Ut.f("이미 사용중인 이름(%s)과 이메일(%s)입니다", mname, email));
		}

		memberRepository.join(loginId, loginPw, birth, mname, cellphoneNum, email, postcode, fulladdress);

		int id = memberRepository.getLastInsertId();

		return ResultData.from("S-1", "회원가입이 완료되었습니다.", "id", id);

	}

	public Member getMemberByNameAndEmail(String mname, String email) {
		return memberRepository.getMemberByNameAndEmail(mname, email);
	}

	public Member getMemberByLoginId(String loginId) {
		return memberRepository.getMemberByLoginId(loginId);
	}

	public Member getMember(int id) {
		return memberRepository.getMember(id);
	}
	
	// 회원정보 수정
	public void setMember(int id, String mname, String birth, String cellphoneNum, String email, String address) {
		memberRepository.setMember(id, mname, birth, cellphoneNum, email, address);
	}
	
	// 비밀번호 변경
	public void setMember(int id, String new_loginPw) {
		memberRepository.setMember_pw(id, new_loginPw);
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

	public void upload(MultipartFile file, int id) {
        try {
            // 파일의 실제 이름을 얻어옴
            String originalFileName = file.getOriginalFilename();

            // 파일의 확장자를 얻어옴
            String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));

            // 유니크한 파일명 생성
            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

            byte[] fileBytes = file.getBytes();

            // 파일 저장
            // (여기에서는 데이터베이스에 직접 저장하지 않고, 파일 경로만 저장하도록 수정)
            String filePath = saveFile(uniqueFileName, fileBytes);
            String resourcesPath = "src\\main\\resources\\static";
            String unixStylePath = null;
            
	         // "src/main/resources/" 다음의 부분을 추출
	         int index = filePath.indexOf(resourcesPath);
	         if (index != -1) {
	        	 String relativePath = filePath.substring(index + resourcesPath.length());
	        	 unixStylePath = relativePath.replaceAll("\\\\", "/");
	         } 
//	         else {
//	             System.out.println("문자열에서 /images/를 찾을 수 없습니다.");
//	         }
         System.out.println(unixStylePath + "@@@@@@@@@@@@@@@" + "id");
            memberRepository.upload(unixStylePath, id);
            
            // 여기에 데이터베이스에 파일 정보를 저장하는 로직을 추가할 수 있습니다.
        } catch (IOException e) {
            e.printStackTrace();
            // 파일 처리 중 예외가 발생한 경우 처리
        }
    }

	private String saveFile(String fileName, byte[] fileBytes) throws IOException {
        // 파일을 실제 경로에 저장하는 로직 추가
        // (여기에서는 간단하게 파일명으로 저장하는 것으로 예제 작성)
        String filePath = "C:\\work\\sts-4.21.0.RELEASE-workspace\\myproject\\src\\main\\resources\\static\\resource\\" + fileName;
        Files.write(Paths.get(filePath), fileBytes);
        return filePath;
    }
//	public ResultData modifyWithoutPw(int loginedMemberId, String name, String nickname, String cellphoneNum,
//			String email, String address) {
//		memberRepository.modifyWithoutPw(loginedMemberId, name, nickname, cellphoneNum, email, address);
//		return ResultData.from("S-1", "회원정보 수정 완료");
//	}

	public void delMember(int id) {
		memberRepository.delMember(id);
	}

	public void setfplayer(String loginId, String player) {
		memberRepository.setfplayer(loginId, player);
	}

	public String memberinfo(int id) {
		return memberRepository.memberinfo(id);
	}

	public int getselectedplayer(int loginedMemberId) {
		return memberRepository.getselectedplayer(loginedMemberId);
	}

	public Member getMemberByLoginId_1(String loginId) {
		return memberRepository.getMemberByLoginId_1(loginId);
	}

	public int isselectplayer(String loginId) {
		return memberRepository.isselectplayer(loginId);
	}

}
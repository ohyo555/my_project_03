package com.example.demo.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.repository.MemberRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.Member;
import com.example.demo.vo.ResultData;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Service
public class MemberService {
	
	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	@Value("${custom.siteName}")
	private String siteName;

	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private MailService mailService;

	public MemberService(MailService mailService, MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
		this.mailService = mailService;
	}

	public ResultData<Integer> join(String loginId, String loginPw, String birth, String mname, String cellphoneNum, 
			String email, String postcode, String fulladdress) {
		Member existsMember = getMemberByLoginId_1(loginId);

		if (existsMember != null) {
			return ResultData.from("F-7", Ut.f("이미 사용중인 아이디(%s)입니다", loginId));
		}

		loginPw = Ut.sha256(loginPw);
		
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
		
		new_loginPw = Ut.sha256(new_loginPw);
		
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
        String filePath = "C:\\work\\sts-4.21.0.RELEASE-workspace\\myproject\\src\\main\\resources\\static\\resource\\" + fileName;
        //String filePath = "C:\\OHJ\\sts-4.22.0.RELEASE-workspace\\my_project_03\\src\\main\\resources\\static\\resource\\" + fileName;
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

	public Member isselectplayer(String loginId) {
		return memberRepository.isselectplayer(loginId);
	}

	public ResultData notifyTempLoginPwByEmail(Member actor) {
		String title = "[" + siteName + "] 임시 패스워드 발송";
		String tempPassword = Ut.getTempPassword(6);
		String body = "<h1>임시 패스워드 : " + tempPassword + "</h1>";
		body += "<a href=\"" + siteMainUri + "/usr/member/login\" target=\"_blank\">로그인 하러가기</a>";

		ResultData sendResultData = mailService.send(actor.getEmail(), title, body);

		if (sendResultData.isFail()) {
			return sendResultData;
		}

		setTempPassword(actor, tempPassword);

		return ResultData.from("S-1", "계정의 이메일주소로 임시 패스워드가 발송되었습니다.");
	}

	private void setTempPassword(Member actor, String tempPassword) {
		memberRepository.setMember_pw(actor.getId(), Ut.sha256(tempPassword));
	}

	public void sendMessage(String mname, String cellphoneNum, String membercode, String type) {
		
		DefaultMessageService messageService =  NurigoApp.INSTANCE.initialize("NCSPXAU1FTBQFE6H", "MB2MMY4IRIOTXHMUWHEF8AEWD4HLWKSR", "https://api.coolsms.co.kr");
		// Message 패키지가 중복될 경우 net.nurigo.sdk.message.model.Message로 치환하여 주세요
		Message message = new Message();
		message.setFrom("01076070903");
		message.setTo(cellphoneNum);
		message.setText(mname + "님, " + type + "멤버쉽 가입이 완료되었습니다.\n" + "멤버쉽 코드: [" + type + "]" + membercode);
		
		try {
		  // send 메소드로 ArrayList<Message> 객체를 넣어도 동작합니다!
		  messageService.send(message);
		} catch (NurigoMessageNotReceivedException exception) {
		  // 발송에 실패한 메시지 목록을 확인할 수 있습니다!
		  System.out.println(exception.getFailedMessageList());
		  System.out.println(exception.getMessage());
		} catch (Exception exception) {
		  System.out.println(exception.getMessage());
		}
	}
		

}
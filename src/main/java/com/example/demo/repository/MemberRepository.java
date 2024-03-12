package com.example.demo.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.vo.Member;
import com.example.demo.vo.ResultData;

@Mapper
public interface MemberRepository {
	@Select("""
			SELECT *
			FROM `member`
			WHERE loginId = #{loginId}
			""")
	public Member getMemberByLoginId(String loginId);

	@Select("""
			SELECT *
			FROM `member`
			WHERE mname = #{mname}
			AND email = #{email}
			""")
	public Member getMemberByNameAndEmail(String mname, String email);

	@Insert("""
			INSERT INTO
			`member` SET
			regDate = NOW(),
			updateDate = NOW(),
			loginId = #{loginId},
			loginPw = #{loginPw},
			birth = #{birth},
			mname = #{mname},
			cellphoneNum = #{cellphoneNum},
			email = #{email},
			postcode = #{postcode},
			address = #{fulladdress},
			image = "/resource/profile.png"
			""")
	public void join(String loginId, String loginPw, String birth, String mname, String cellphoneNum, String email,
			String postcode, String fulladdress);

	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();

	@Select("SELECT * FROM `member` WHERE id = #{id}")
	public Member getMember(int id);

	@Select("""
			SELECT loginPw
			FROM `member`
			WHERE loginId = #{loginId}
			""")
	public String login(String loginId, String loginPw);

	// 회원정보 수정
	@Update("""
			<script>
			UPDATE member
			<set>
			<if test="loginPw != null and loginPw != ''">loginPw = #{loginPw},</if>
			<if test="mname != null and mname != ''">mname = #{mname},</if>
			<if test="cellphoneNum != null and cellphoneNum != ''">cellphoneNum = #{cellphoneNum},</if>
			<if test="email != null and email != ''">email = #{email},</if>
			<if test="address != null and address != ''">address = #{address},</if>
			updateDate = NOW()
			</set>
			WHERE id = #{id}
			</script>
			""")
	public void setMember(int id, String loginPw, String mname, String cellphoneNum, String email, String address);
	
	// 비밀번호 변경
	@Update("""
			<script>
			UPDATE member
			<set>
			<if test="new_loginPw != null and new_loginPw != ''">loginPw = #{new_loginPw},</if>
			updateDate = NOW()
			</set>
			WHERE id = #{id}
			</script>
			""")
	public void setMember_pw(int id, String new_loginPw);
	
	// 멤버쉽 등록하고 나서 멤버테이블 변경
	@Update("""
			<script>
			UPDATE member
			<set>
			<if test="mname != null and mname != ''">mname = #{mname},</if>
			<if test="cellphoneNum != null and cellphoneNum != ''">cellphoneNum = #{cellphoneNum},</if>
			<if test="email != null and email != ''">email = #{email},</if>
			<if test="address != null and address != ''">address = #{address},</if>
			<if test="lv != null and lv != ''">`authLevel` = #{lv},</if>
			type = #{type},
			membercode = #{membercode},
			updateDate = NOW()
			</set>
			WHERE loginId = #{loginId}
			</script>
			""")
	public void setMember2(String loginId, String mname, String cellphoneNum, String email, String address, int lv,
			String membercode, String type);

	@Insert("""
			INSERT INTO
			membership SET
			loginId = #{loginId},
			`authLevel` = #{lv},
			`type` = #{type},
			membercode = #{membercode},
			regDate = NOW(),
			updateDate = NOW(),
			endDate = NOW()
			""")
	public void membership(String loginId, int lv, String membercode, String type);

	@Select("SELECT `authLevel` FROM `member` WHERE loginId = #{loginId}")
	public int getMemberBylevel(String loginId);

	@Update("UPDATE `member` SET image = #{unixStylePath} WHERE id = #{id}")
	public void upload(String unixStylePath, int id);

	@Update("UPDATE `member` SET delStatus = 1, delDate = NOW() WHERE id = #{id}")
	public void delMember(int id);

	@Update("UPDATE `member` SET fplayer = #{player} WHERE loginId = #{loginId}")
	public void setfplayer(String loginId, String player);


}
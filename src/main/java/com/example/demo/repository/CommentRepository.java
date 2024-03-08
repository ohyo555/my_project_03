package com.example.demo.repository;

import java.util.List;
import java.util.Optional;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.vo.Article;
import com.example.demo.vo.Comment;
import com.example.demo.vo.ReactionPoint;

@Mapper
public interface CommentRepository {

	@Select("""
			SELECT C.*, M.loginId AS loginId, M.image AS image, SUM(C.goodreactionPoint) AS `sum`
			FROM `comment` AS C
			INNER JOIN `member` AS M
			ON C.memberId = M.id
			WHERE C.relId = #{id}
			GROUP BY C.id
			""")
	List<Comment> getForPrintComments(int loginedMemberId, String relTypeCode, int id);

	@Insert("""
			INSERT INTO `comment`
			SET regDate = NOW(),
			updateDate = NOW(),
			`comment` = #{comment},
			memberId = #{loginedMemberId},
			relTypeCode = #{relTypeCode},
			relId = #{relId}
			""")
	void writeComment(int loginedMemberId, String relTypeCode, int relId, String comment);

	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();

	@Select("""
			SELECT *
			FROM `comment`
			WHERE id = #{id}
			""")
	public Comment getComment(int id);

	@Update("""
			UPDATE `comment`
			SET `comment` = #{comment},
			updateDate = NOW()
			WHERE id = #{id}
				""")
	void modifyComment(int id, String comment);

	@Delete("DELETE FROM `comment` WHERE id = #{id}")
	void deleteComment(int id);
}
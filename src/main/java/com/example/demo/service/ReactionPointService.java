package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.ReactionPointRepository;
import com.example.demo.vo.ReactionPoint;
import com.example.demo.vo.ResultData;

@Service
public class ReactionPointService {

	@Autowired
	private ArticleService articleService;

	@Autowired
	private CommentService commentService;
	
	@Autowired
	private ReactionPointRepository reactionPointRepository;

	public ReactionPointService(ReactionPointRepository reactionPointRepository) {
		this.reactionPointRepository = reactionPointRepository;
	}

	

	public ResultData usersReaction(int loginedMemberId, String relTypeCode, int id) {

		if (loginedMemberId == 0) {
			return ResultData.from("F-L", "로그인 하고 써야해");
		}

		int sumReactionPointByMemberId = reactionPointRepository.getSumReactionPoint(loginedMemberId, relTypeCode,
				id);

		if (sumReactionPointByMemberId != 0) {
			return ResultData.from("F-1", "추천 불가능", "sumReactionPointByMemberId", sumReactionPointByMemberId);
		}

		return ResultData.from("S-1", "추천 가능", "sumReactionPointByMemberId", sumReactionPointByMemberId);
	}

	public ResultData addGoodReactionPoint(int loginedMemberId, String relTypeCode, int relId) {

		int affectedRow = reactionPointRepository.addGoodReactionPoint(loginedMemberId, relTypeCode, relId);
		
		System.err.println(affectedRow);
		
		if (affectedRow != 1) {
			return ResultData.from("F-1", "좋아요 실패");
		}

		switch (relTypeCode) {
		case "article":
			articleService.increaseGoodReactionPoint(relId);
			break;
		case "comment":
			commentService.increaseGoodReactionPoint(relId);
			break;
		}

		return ResultData.from("S-1", "좋아요!");
	}

	public ResultData addBadReactionPoint(int loginedMemberId, String relTypeCode, int relId) {
		int affectedRow = reactionPointRepository.addBadReactionPoint(loginedMemberId, relTypeCode, relId);

		if (affectedRow != 1) {
			return ResultData.from("F-1", "싫어요 실패");
		}

		switch (relTypeCode) {
		case "article":
			articleService.increaseBadReactionPoint(relId);
			break;
		case "comment":
			articleService.decreaseGoodReactionPoint(relId);
			break;
		} 
		return ResultData.from("S-1", "싫어요!");
	}

	public ResultData deleteGoodReactionPoint(int loginedMemberId, String relTypeCode, int relId) {
		reactionPointRepository.deleteReactionPoint(loginedMemberId, relTypeCode, relId);

		switch (relTypeCode) {
		case "article":
			articleService.decreaseGoodReactionPoint(relId);
			break;
			
		case "comment":
			commentService.decreaseGoodReactionPoint(relId);
			break;
		}
		return ResultData.from("S-1", "좋아요 취소 됨");

	}

	public ResultData deleteBadReactionPoint(int loginedMemberId, String relTypeCode, int relId) {
		reactionPointRepository.deleteReactionPoint(loginedMemberId, relTypeCode, relId);

		switch (relTypeCode) {
		case "article":
			articleService.decreaseBadReactionPoint(relId);
			break;
		}
		return ResultData.from("S-1", "싫어요 취소 됨");
	}

	public boolean isAlreadyAddGoodRp(int memberId, int id, String relTypeCode) {

		int getPointTypeCodeByMemberId = reactionPointRepository.getSumReactionPoint(memberId, relTypeCode, id);

		if (getPointTypeCodeByMemberId > 0) {
			return true;
		}

		return false;
	}

	public boolean isAlreadyAddBadRp(int memberId, int id, String relTypeCode) {
		int getPointTypeCodeByMemberId = reactionPointRepository.getSumReactionPoint(memberId, relTypeCode, id);

		if (getPointTypeCodeByMemberId < 0) {
			return true;
		}

		return false;
	}



	public List<ReactionPoint> isAlreadyAddGoodComRp(int memberId, int id, String relTypeCode) {
		
		List<ReactionPoint> isAlreadyAddGoodComRp = reactionPointRepository.getSumComReactionPoint(memberId, relTypeCode, id);

		return isAlreadyAddGoodComRp;
	}

}
package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ReactionPointService;
import com.example.demo.service.CommentService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.Comment;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrCommentController {

	@Autowired
	private Rq rq;

	@Autowired
	private CommentService commentService;

	@Autowired
	private ReactionPointService reactionPointService;

	@RequestMapping("/usr/comment/doWrite")
	@ResponseBody
	public String doWrite(HttpServletRequest req, String relTypeCode, int relId, String comment) {

		Rq rq = (Rq) req.getAttribute("rq");

		if (Ut.isNullOrEmpty(relTypeCode)) {
			return Ut.jsHistoryBack("F-1", "relTypeCode을 입력해주세요");
		}
		if (Ut.isEmpty(relId)) {
			return Ut.jsHistoryBack("F-2", "relId을 입력해주세요");
		}
		if (Ut.isNullOrEmpty(comment)) {
			return Ut.jsHistoryBack("F-3", "내용을 입력해주세요");
		}

		ResultData<Integer> writeCommentRd = commentService.writeComment(rq.getLoginedMemberId(), relTypeCode, relId,
				comment);

		int id = (int) writeCommentRd.getData1();

		return Ut.jsReplace(writeCommentRd.getResultCode(), writeCommentRd.getMsg(), "../article/detail?id=" + relId);

	}

	@RequestMapping("/usr/comment/doModify")
	@ResponseBody
	public String doModify(HttpServletRequest req, int id, String comment) {
		Rq rq = (Rq) req.getAttribute("rq");

		Comment com = commentService.getComment(id); // 댓글에 해당하는 정보를 가져와

		if (com == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 댓글은 존재하지 않습니다", id));
		}
		
		ResultData loginedMemberCanModifyRd = commentService.userCanModify(rq.getLoginedMemberId(), com);
		
		if (loginedMemberCanModifyRd.isSuccess()) {
			commentService.modifyComment(id, comment);
		}
		
		com = commentService.getComment(id);

		return com.getComment();
	}
	
	@RequestMapping("/usr/comment/doDelete")
	@ResponseBody
	public String doDelete(HttpServletRequest req, int id, String replaceUri) {
		Rq rq = (Rq) req.getAttribute("rq");

		Comment com = commentService.getComment(id);
		if (com == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 댓글은 존재하지 않습니다", id));
		}

		ResultData loginedMemberCanDeleteRd = commentService.userCanDelete(rq.getLoginedMemberId(), com);

		if (loginedMemberCanDeleteRd.isSuccess()) {
			commentService.deleteComment(id);
		}

		if (Ut.isNullOrEmpty(replaceUri)) {
			switch (com.getRelTypeCode()) {
			case "article":
				replaceUri = Ut.f("../article/detail?id=%d", com.getRelId());
				break;
			}
		}
		
		return Ut.jsReplace(loginedMemberCanDeleteRd.getResultCode(), loginedMemberCanDeleteRd.getMsg(), replaceUri);
	}
}
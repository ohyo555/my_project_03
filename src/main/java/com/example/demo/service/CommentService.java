package com.example.demo.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.CommentRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.Comment;
import com.example.demo.vo.ResultData;

@Service
public class CommentService {

	@Autowired
	private CommentRepository commentRepository;

	public CommentService(CommentRepository commentRepository) {
		this.commentRepository = commentRepository;
	}

	public List<Comment> getForPrintComments(int loginedMemberId, String relTypeCode, int relId) {
//		return commentRepository.getForPrintComments(loginedMemberId, relTypeCode, relId);
	
		List<Comment> comments = commentRepository.getForPrintComments(loginedMemberId, relTypeCode, relId);

		for (Comment comment : comments) {
			controlForPrintData(loginedMemberId, comment);
		}

		return comments;
	}

	private void controlForPrintData(int loginedMemberId, Comment comment) {
		if (comment == null) {
			return;
		}
		ResultData userCanModifyRd = userCanModify(loginedMemberId, comment);
		comment.setUserCanModify(userCanModifyRd.isSuccess());

		ResultData userCanDeleteRd = userCanDelete(loginedMemberId, comment);
		comment.setUserCanDelete(userCanDeleteRd.isSuccess());
	}

	public ResultData userCanDelete(int loginedMemberId, Comment comment) {

		if (comment.getMemberId() != loginedMemberId) {
			return ResultData.from("F-2", Ut.f("%d번 댓글에 대한 삭제 권한이 없습니다", comment.getId()));
		}

		return ResultData.from("S-1", Ut.f("%d번 댓글이 삭제 되었습니다", comment.getId()));
	}

	public ResultData userCanModify(int loginedMemberId, Comment comment) {

		if (comment.getMemberId() != loginedMemberId) {
			return ResultData.from("F-2", Ut.f("%d번 댓글에 대한 수정 권한이 없습니다", comment.getId()));
		}

		return ResultData.from("S-1", Ut.f("%d번 댓글을 수정했습니다", comment.getId()));
	}

	public ResultData<Integer> writeComment(int loginedMemberId, String relTypeCode, int relId, String comment) {
		commentRepository.writeComment(loginedMemberId, relTypeCode, relId, comment);

		int id = commentRepository.getLastInsertId();

		return ResultData.from("S-1", Ut.f("%d번 댓글이 생성되었습니다", id), "id", id);
	}

	public Comment getComment(int id) {
		return commentRepository.getComment(id);
	}

	public ResultData userCommentCanModify(int loginedMemberId, String comment) {
		// TODO Auto-generated method stub
		return null;
	}

	public void modifyComment(int id, String comment) {
		commentRepository.modifyComment(id, comment);
	}

	public ResultData deleteComment(int id) {
		
		commentRepository.deleteComment(id);
		return ResultData.from("S-1", Ut.f("%d번 댓글을 삭제했습니다", id));
	}

}
package com.example.demo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.example.demo.service.ArticleService;
import com.example.demo.service.BoardService;
import com.example.demo.service.CommentService;
import com.example.demo.service.GenFileService;
import com.example.demo.service.ReactionPointService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.Board;
import com.example.demo.vo.Comment;
import com.example.demo.vo.Member;
import com.example.demo.vo.ReactionPoint;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrArticleController {
	
	@Autowired
	private Rq rq;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private ArticleService articleService;
	
	@Autowired
	private GenFileService genFileService;
	
	@Autowired
	private CommentService commentService;

	@Autowired
	private ReactionPointService reactionPointService;
	
	public UsrArticleController() {

	}

	// 액션 메서드
	@RequestMapping("/usr/article/list")
	public String showList(HttpServletRequest req, Model model, @RequestParam(defaultValue = "1") int boardId,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "title,body") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) {

		Rq rq = (Rq) req.getAttribute("rq");
		Board board = boardService.getBoardById(boardId);
		int id = rq.getLoginedMemberId();
		List<Article> articles = null;
		int articlesCount = 0;
		
		if (board == null) {
			return rq.historyBackOnView("없는 게시판이야");
		}

		int itemsInAPage = 15;
		
		if(boardId == 4) {
			articles = articleService.getForPrintMyArticles(id, itemsInAPage, page, searchKeywordTypeCode, searchKeyword);
			articlesCount = articleService.getMyArticlesCount(id, searchKeywordTypeCode, searchKeyword);
		} else {
			articles = articleService.getForPrintArticles(boardId, itemsInAPage, page, searchKeywordTypeCode, searchKeyword);
			articlesCount = articleService.getArticlesCount(boardId, searchKeywordTypeCode, searchKeyword);
		}
		
		int pagesCount = (int) Math.ceil(articlesCount / (double) itemsInAPage);
		System.err.println("^^^^^^^^^^^^^^^^^" + pagesCount);
		
		model.addAttribute("board", board);
		model.addAttribute("boardId", boardId);
		model.addAttribute("page", page);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("articlesCount", articlesCount);
		model.addAttribute("articles", articles);

		return "usr/article/list";
	}

	@RequestMapping("/usr/article/doAction")
	@ResponseBody
	public String doAction(int id, String loginPw) {

		String password = articleService.getMemberByLoginPw(id);

		loginPw = Ut.sha256(loginPw);
		
		if (password.equals(loginPw)) {
			System.err.println("성공!!!");
			return Ut.jsReplace("S-1", "비밀번호 일치", "../article/detail?id=" + id);
		}
		
		return Ut.jsHistoryBack("F-1", "비밀번호가 일치하지 않습니다.");
	}

	
	@RequestMapping("/usr/article/detail")
	public String showDetail(HttpServletRequest req, Model model, int id) {
		Rq rq = (Rq) req.getAttribute("rq");
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		ResultData usersReactionRd = reactionPointService.usersReaction(rq.getLoginedMemberId(), "article", id);
		
		if (usersReactionRd.isSuccess()) {
			model.addAttribute("userCanMakeReaction", usersReactionRd.isSuccess());
		}

	    // order 값을 받아옵니다.
	    // String order = req.getParameter("order");

	    List<Comment> comments = commentService.getForPrintComments(rq.getLoginedMemberId(), "article", id);
	    List<ReactionPoint> reactionPoints = reactionPointService.isAlreadyAddGoodComRp(rq.getLoginedMemberId(), id, "comment");
		/*
		 * for (Comment comment : comments) {
		 * reactionPointService.isAlreadyAddGoodRp(rq.getLoginedMemberId(), id,
		 * "comment"); System.out.println("Comment ID: " + comment.getId());
		 * System.out.println("Comment Text: " + comment.getText()); // Add more actions
		 * as needed }
		 */
	    
	    // ResultData usersComme  ntReactionRd = reactionPointService.usersReaction(rq.getLoginedMemberId(), "comment", id);
		// List<ReactionPoint> reactionPoints = reactionPointService.isAlreadyAddGoodComRp(rq.getLoginedMemberId(), id, "comment");
		if (usersReactionRd.isSuccess()) {
			model.addAttribute("userCanMakeReaction", usersReactionRd.isSuccess());
		}
		
		int commentsCount = comments.size();
		int genfilecnt = genFileService.getGenFilecnt(id);
		
		model.addAttribute("loginedMember", rq.getLoginedMemberId());
		model.addAttribute("article", article);
		model.addAttribute("comments", comments);
		model.addAttribute("commentsCount", commentsCount);
		model.addAttribute("genfilecnt", genfilecnt);
		model.addAttribute("isAlreadyAddGoodRp",reactionPointService.isAlreadyAddGoodRp(rq.getLoginedMemberId(), id, "article"));
		model.addAttribute("isAlreadyAddBadRp",reactionPointService.isAlreadyAddBadRp(rq.getLoginedMemberId(), id, "article"));
		model.addAttribute("reactionPoints",reactionPoints);
		
		return "usr/article/detail";
	}
	
	@RequestMapping("/usr/article/detail2")
	@ResponseBody
	public List<Comment> showDetail2(HttpServletRequest req, Model model, int id) {
		Rq rq = (Rq) req.getAttribute("rq");
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		ResultData usersReactionRd = reactionPointService.usersReaction(rq.getLoginedMemberId(), "article", id);
		
		if (usersReactionRd.isSuccess()) {
			model.addAttribute("userCanMakeReaction", usersReactionRd.isSuccess());
		}
		
	    // order 값을 받아옵니다.
	    String order = req.getParameter("order");

	    List<Comment> comments = commentService.getForPrintComments(rq.getLoginedMemberId(), "article", id);
	    
	    // order 값이 null이 아니라면 적절한 처리를 수행합니다.
	    if (order != null) {
	        // order 값이 "asc"이면 등록순으로 댓글을 정렬합니다.
	        if (order.equals("asc")) {
	        	comments = commentService.getForPrintComments(rq.getLoginedMemberId(), "article", id, order);
	        }
	        // order 값이 "desc"이면 최신순으로 댓글을 정렬합니다.
	        else if (order.equals("desc")) {
	        	comments = commentService.getForPrintComments(rq.getLoginedMemberId(), "article", id, order);
	        }
	    }
		if (usersReactionRd.isSuccess()) {
			model.addAttribute("userCanMakeReaction", usersReactionRd.isSuccess());
		}
		
		int commentsCount = comments.size();
		int genfilecnt = genFileService.getGenFilecnt(id);
		
		model.addAttribute("loginedMember", rq.getLoginedMemberId());
		model.addAttribute("article", article);
		model.addAttribute("comments", comments);
		model.addAttribute("commentsCount", commentsCount);
		model.addAttribute("genfilecnt", genfilecnt);
		model.addAttribute("isAlreadyAddGoodRp",reactionPointService.isAlreadyAddGoodRp(rq.getLoginedMemberId(), id, "article"));
		model.addAttribute("isAlreadyAddBadRp",reactionPointService.isAlreadyAddBadRp(rq.getLoginedMemberId(), id, "article"));
		
		return comments;
	}
	
	
	@RequestMapping("/usr/article/doIncreaseHitCountRd")
	@ResponseBody
	public ResultData doIncreaseHitCountRd(int id) {

		ResultData increaseHitCountRd = articleService.increaseHitCount(id);

		if (increaseHitCountRd.isFail()) {
			return increaseHitCountRd;
		}

		ResultData rd = ResultData.newData(increaseHitCountRd, "hitCount", articleService.getArticleHitCount(id));

		rd.setData2("id", id);

		return rd;

	}

	@RequestMapping("/usr/article/doIncreaseGoodCountRd")
	@ResponseBody
	public ResultData doIncreaseGoodCountRd(HttpServletRequest req, int id) {
		
		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		ResultData increaseGoodCountRd = articleService.goodArticle(id, rq.getLoginedMemberId(), article.getId());

		if (increaseGoodCountRd.isFail()) {
			return increaseGoodCountRd;
		}
		
		ResultData rd = ResultData.newData(increaseGoodCountRd, "good", articleService.goodArticle(id, rq.getLoginedMemberId(), article.getId()));

		rd.setData2("id", id);

		return rd;
	}
	
	@RequestMapping("/usr/article/modify")
	public String showModify(HttpServletRequest req, Model model, int id) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);
		
		if (article == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 글은 존재하지 않습니다", id));
		}
		model.addAttribute("article", article);

		return "usr/article/modify";
	}

	@RequestMapping("/usr/article/write")
	public String showJoin(Model model) {

		int currentId = articleService.getCurrentArticleId();

		model.addAttribute("currentId", currentId);

		return "usr/article/write";
	}

	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(HttpServletRequest req, int boardId, String title, String body, String replaceUri,
			MultipartRequest multipartRequest) {

		Rq rq = (Rq) req.getAttribute("rq");

		if (Ut.isNullOrEmpty(title)) {
			return Ut.jsHistoryBack("F-1", "제목을 입력해주세요");
		}
		if (Ut.isNullOrEmpty(body)) {
			return Ut.jsHistoryBack("F-2", "내용을 입력해주세요");
		}

		ResultData<Integer> writeArticleRd = articleService.writeArticle(rq.getLoginedMemberId(), title, body, boardId);

		int id = (int) writeArticleRd.getData1();

		Article article = articleService.getArticle(id);

		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);

			if (multipartFile.isEmpty() == false) {
				genFileService.save(multipartFile, id);
			}
		}

		return Ut.jsReplace(writeArticleRd.getResultCode(), writeArticleRd.getMsg(), "../article/detail?id=" + id);

	}
	
	// 로그인 체크 -> 유무 체크 -> 권한 체크 -> 수정
	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(HttpServletRequest req, Model model, int id, String title, String body) {
		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getArticle(id);

		if (article == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 글은 존재하지 않습니다", id));
		}

		ResultData loginedMemberCanModifyRd = articleService.userCanModify(rq.getLoginedMemberId(), article);

		if (loginedMemberCanModifyRd.isSuccess()) {
			articleService.modifyArticle(id, title, body);
		}

		return Ut.jsReplace(loginedMemberCanModifyRd.getResultCode(), loginedMemberCanModifyRd.getMsg(), "../article/detail?id="+article.getId());
	}

	// 로그인 체크 -> 유무 체크 -> 권한 체크 -> 삭제
	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(HttpServletRequest req, int id) {
		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getArticle(id);

		if (article == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 글은 존재하지 않습니다", id));
		}

		ResultData loginedMemberCanDeleteRd = articleService.userCanDelete(rq.getLoginedMemberId(), article);
		
		if (loginedMemberCanDeleteRd.isSuccess()) {
			articleService.deleteArticle(id);
		}
		
		return Ut.jsReplace(loginedMemberCanDeleteRd.getResultCode(), loginedMemberCanDeleteRd.getMsg(),
				"../article/list");
	}

}
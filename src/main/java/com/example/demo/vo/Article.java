package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Article {
	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private String loginId;
	private String title;
	private String body;
	private int hitCount;
	private int cnt;
	private String type;
	private int goodReactionPoint;
	private int badReactionPoint;
	private String userLevel;
	private int boardId;
	private String orderType;
	private int password;
	
	
	private boolean userCanModify;
	private boolean userCanDelete;

}
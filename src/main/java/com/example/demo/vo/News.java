package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class News {
	private String company_img;
	private String company_name;
	private String date;
	private String title;
	private String content;
	private String title_img;
	private String news_url;
}
package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.vo.News;

@Controller
public class UsrNewsController {
	
	@Autowired
	private UsrCrawlingController3 news;

	@Autowired
	private UsrCrawlingController2 news2;
	
	@RequestMapping("/usr/game/news")
	public String showNews(Model model) {

		List<News> News = news.crawl();
		model.addAttribute("News", News);

		return "usr/game/news";

	}

	@RequestMapping("/usr/game/news2")
	public String showNews2(Model model) {

		news2.crawl();
		
		return "usr/game/news2";

	}

}
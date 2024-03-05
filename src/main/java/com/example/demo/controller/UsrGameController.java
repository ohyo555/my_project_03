package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.service.ArticleService;
import com.example.demo.service.GameService;
import com.example.demo.vo.Article;
import com.example.demo.vo.Game;

@Controller
public class UsrGameController {
	
	@Autowired
	private GameService teamService;

	@RequestMapping("/usr/game/calendar")
	public String showCalendar() {

		return "/usr/game/calendar";
	}
	
	@RequestMapping("/usr/game/map")
	public String showMap(Model model) {
		
		int id = 1; // 정관장이 중심이라 정관장 아이디 고정
		
		Game team = teamService.getTeam(id);
		
		model.addAttribute("team", team);
		return "/usr/game/map";
	}
	
	@RequestMapping("/usr/game/aaaa")
	public String showa() {
		
		return "/usr/game/aaaa";
	}

}
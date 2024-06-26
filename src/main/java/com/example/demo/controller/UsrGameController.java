package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.service.GameService;
import com.example.demo.vo.Article;
import com.example.demo.vo.Game;
import com.example.demo.vo.Schedule;

@Controller
public class UsrGameController {

	@Autowired
	private GameService gameService;

	@RequestMapping("/usr/game/calendar")
	public String showCalendar(Model model) {

		List<String> gamedate = gameService.getGamedate();
		List<Schedule> schedule = gameService.getGamelist();
		List<Game> teamlist = gameService.getTeamlist();
		// System.out.println(teamlist.get(0) +
		// "*******************************************");
		model.addAttribute("gamedate", gamedate);
		model.addAttribute("schedule", schedule);
		model.addAttribute("teamlist", teamlist);

		return "/usr/game/calendar";
	}

	@RequestMapping("/usr/game/gamelist")
	public String showgamelist(Model model) {

		List<Schedule> schedules = gameService.getGamelist();
		model.addAttribute("schedules", schedules);

		return "/usr/game/gamelist";
	}

	@RequestMapping("/usr/game/map")
	public String showMap(Model model) {

		int id = 1; // 정관장이 중심이라 정관장 아이디 고정

		Game team = gameService.getTeam(id);

		model.addAttribute("team", team);
		return "/usr/game/map";
	}

	@RequestMapping("/usr/game/findmap")
	public String showfindmap(Model model) {

		int id = 1; // 정관장이 중심이라 정관장 아이디 고정

		Game team = gameService.getTeam(id);
		model.addAttribute("team", team);

		return "/usr/game/findmap";
	}

	@RequestMapping("/usr/game/reservation")
	public String showreservation(Model model) {

		List<String> gamedate = gameService.getGamedate();
		List<Schedule> schedule = gameService.getGamelist();

		model.addAttribute("gamedate", gamedate);
		model.addAttribute("schedule", schedule);
		
		return "/usr/game/reservation";
	}

	@RequestMapping("/usr/game/reservation2")
	public String showreservation2(Model model) {
		
		List<String> gamedate = gameService.getGamedate();
		List<Schedule> schedule = gameService.getGamelist();

		model.addAttribute("gamedate", gamedate);
		model.addAttribute("schedule", schedule);
	
		return "/usr/game/reservation2";
	}
	
	@RequestMapping("/usr/game/reservation3")
	public String showreservation3(Model model) {
		
		List<String> gamedate = gameService.getGamedate();
		
		model.addAttribute("gamedate", gamedate);
		
		return "/usr/game/reservation3";
	}
	
	@RequestMapping("/usr/game/reservation4")
	public String showreservation4(Model model) {
		
		List<String> gamedate = gameService.getGamedate();
		
		model.addAttribute("gamedate", gamedate);
		
		return "/usr/game/reservation4";
	}
	
	/*
	 * @RequestMapping("/usr/game/news") public String shownews() {
	 * 
	 * return "/usr/game/news"; }
	 */

	/*
	 * @RequestMapping("/usr/game/news2") public String shownews() { return
	 * "/usr/game/news2"; }
	 */

}
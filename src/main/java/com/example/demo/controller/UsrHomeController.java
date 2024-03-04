package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UsrHomeController {

	@RequestMapping("/usr/home/main")
	public String showMain() {

		return "/usr/home/main";
	}

	@RequestMapping("/")
	public String showRoot() {

		return "redirect:/usr/home/main";
	}
	
	@RequestMapping("/usr/home/main2")
	public String showMain2() {

		return "/usr/home/main2";
	}
	
	@RequestMapping("/usr/home/main3")
	public String showMain3() {

		return "/usr/home/main3";
	}
	
	@RequestMapping("/usr/home/main4")
	public String showMain4() {

		return "/usr/home/main4";
	}
}
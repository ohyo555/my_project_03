package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.GameRepository;
import com.example.demo.vo.Game;

@Service
public class GameService {

	@Autowired
	private GameRepository teamRepository;

	
	public Game getTeam(int id) {
		
		Game team = teamRepository.getTeam(id); // 정관장 팀 정보를 가져와

		return team;
	}

}

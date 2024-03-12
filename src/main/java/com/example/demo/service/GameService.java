package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.GameRepository;
import com.example.demo.vo.Game;
import com.example.demo.vo.Player;

@Service
public class GameService {

	@Autowired
	private GameRepository teamRepository;
	@Autowired
	private GameRepository playerRepository;
	
	public Game getTeam(int id) {
		
		Game team = teamRepository.getTeam(id); // 정관장 팀 정보를 가져와

		return team;
	}
	

	public Player getPlayer(int id) {
		
		Player player = playerRepository.getPlayer(id);
		return player;
	}

}

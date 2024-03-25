package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.GameRepository;
import com.example.demo.vo.Game;
import com.example.demo.vo.Player;
import com.example.demo.vo.Schedule;

@Service
public class GameService {

	@Autowired
	private GameRepository gameRepository;
	
	public Game getTeam(int id) {
		
		Game team = gameRepository.getTeam(id); // 정관장 팀 정보를 가져와

		return team;
	}
	
	public Player getPlayer(int id) {
		
		Player player = gameRepository.getPlayer(id);
		return player;
	}

	public List<Schedule> getGamelist() {
		
		List<Schedule> schedule = gameRepository.getGamelist();
		return schedule;
	}

	public List<String> getGamedate() {
		List<String> gamedate = gameRepository.getGamedate();
		return gamedate;
	}

	public List<Game> getTeamlist() {
		List<Game> Teamlist = gameRepository.getTeamlist();
		return Teamlist;
	}

}

package com.example.demo.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.vo.Game;

@Mapper
public interface GameRepository {

	@Select("""
			SELECT *
			FROM team
			WHERE id = #{id}
			""")
	public Game getTeam(int id);
}

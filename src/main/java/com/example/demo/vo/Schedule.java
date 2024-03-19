package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Schedule {
	private String date;
	private int num;
	private String stype;
	private String time;
	private String stadium;
	private String broadcasting;
	private String round;
	private String info;
	private String game;
	
}
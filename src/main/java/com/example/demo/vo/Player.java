package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Player {
	private int id;
	private String pname;
	private String position;
	private String number;
	private String startDate;
	private String endDate;
	private String image;
	private String regDate;
	private String updateDate;
}
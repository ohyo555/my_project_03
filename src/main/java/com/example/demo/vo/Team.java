package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Team {
	private int id;
	private String tname;
	private String stadium;
	private String address;
	private String latitude;
	private String longitude;
	private String regDate;
	private String updateDate;
}
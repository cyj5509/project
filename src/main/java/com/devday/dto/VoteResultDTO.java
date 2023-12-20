package com.devday.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class VoteResultDTO {

	private boolean status; // 투표의 결과
	private String message; 
    private String action; // 투표의 종류

}

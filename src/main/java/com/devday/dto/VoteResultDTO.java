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

	private boolean voteResult; // 투표의 결과
	private int likesCount; // 현재의 추천 수
	private int dislikesCount; // 현재의 비추천 수
}

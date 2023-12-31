package com.devday.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardVoteVO {
	
	// 클래스 필드 방식으로 처리(단일 필드 방식 아님)
	private BoardVO boardVO; // 게시물 정보
	private VoteVO voteVO; // 투표 정보(다수 투표 포함)
}

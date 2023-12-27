package com.devday.service;

import java.util.Map;

import com.devday.domain.BoardVoteVO;
import com.devday.domain.VoteVO;
import com.devday.dto.VoteResultDTO;

public interface VoteService {

	
	BoardVoteVO getVoteAction(Long bd_number); // 추천/비추천 수 조회(SELECT 문)

	boolean checkVote(Long bd_number, String us_id);

	String getCurrentVoteStatus(Long bd_number, String us_id);

	VoteResultDTO insertVote(VoteVO vt_vo); // 게시물 추천 및 비추천 관련 로직은 구현 클래스에서 사용

	Map<String, Integer> countVoteStatus(Long bd_number);
}

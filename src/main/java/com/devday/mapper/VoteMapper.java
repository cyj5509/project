package com.devday.mapper;

import java.util.List;
import java.util.Map;

import com.devday.domain.VoteVO;

public interface VoteMapper {

	// 게시물 추천 및 비추천 관련 메서드
	VoteVO getLatestVote(Map<String, Object> map);
	// BoardVoteVO getVoteAction(Long bd_number); // 추천/비추천 수 조회(SELECT 문)
	
	int checkDailyVote(Map<String, Object> map); // 1일 1회 처리
	int checkAccountVote(Map<String, Object> map); // 계정당 1회 처리
	
	String getCurrentVoteStatus(Map<String, Object> map);
	void insertVote(VoteVO vt_vo);
	
	void cancelVote(Map<String, Object> map); // 투표 취소: 같은 상태로 다시 투표하는 경우(UPDATE 문)
	void changeVote(Map<String, Object> map); // 투표 변경: 다른 상태로 다시 투표하는 경우(DELETE 문)
	
	List<Map<String, Object>> countVoteStatus(Long bd_number); // 특정 게시물에 대한 각 투표 상태의 개수 집계(SELECT 문)
}

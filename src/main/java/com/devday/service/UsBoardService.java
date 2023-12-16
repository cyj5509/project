package com.devday.service;

import java.util.List;

import com.devday.domain.BoardVO;
import com.devday.domain.VoteVO;
import com.devday.dto.Criteria;

public interface UsBoardService {

	void register(BoardVO board);
	
	BoardVO get(Long bd_number); // 조회 증가 로직은 구현 클래스에서만 사용
	
	boolean voteCheck(Long bd_number, String us_id, String session_id, String actionType);
	void insertVote(VoteVO vt_vo);

	List<BoardVO> getList();

	void modify(BoardVO board);

	void delete(Long bd_number);

	List<BoardVO> getListWithPaging(Criteria cri, String bd_type);

	int getTotalCount(Criteria cri, String bd_type);

}

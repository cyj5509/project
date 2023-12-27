package com.devday.service;

import java.util.List;
import java.util.Map;

import com.devday.domain.BoardVO;
import com.devday.domain.BoardVoteVO;
import com.devday.domain.VoteVO;
import com.devday.dto.Criteria;
import com.devday.dto.VoteResultDTO;

public interface UsBoardService {

	void register(BoardVO board);
	
	BoardVO get(Long bd_number, boolean readCount); // 게시물 조회 수와 관련된 로직은 구현 클래스에서 작성
	
	List<BoardVO> getList();

	void modify(BoardVO board);

	void delete(Long bd_number);

	List<BoardVO> getListWithPaging(Criteria cri, String bd_type);

	int getTotalCount(Criteria cri, String bd_type);


}

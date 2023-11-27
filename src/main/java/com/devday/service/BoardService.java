package com.devday.service;

import java.util.List;

import com.devday.domain.BoardVO;
import com.devday.dto.Criteria;

public interface BoardService {

	void register(BoardVO board);
	
	BoardVO get(Long bd_number);

	List<BoardVO> getList();

	void modify(BoardVO board);

	void delete(Long bd_number);

	List<BoardVO> getListWithPaging(Criteria cri, String bd_type);

	int getTotalCount(Criteria cri, String bd_type);

}

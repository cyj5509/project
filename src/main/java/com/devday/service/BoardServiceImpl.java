package com.devday.service;


import java.util.List;

import org.springframework.stereotype.Service;

import com.devday.domain.BoardVO;
import com.devday.dto.Criteria;
import com.devday.mapper.BoardMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	private final BoardMapper boardMapper;

	@Override
	public void register(BoardVO board) {
		
		boardMapper.register(board);
	}
	
	@Override
	public BoardVO get(Long bd_number) {
		
		boardMapper.readCount(bd_number);
		
		return boardMapper.get(bd_number);
	}
	
	@Override
	public List<BoardVO> getList() {
		
		return boardMapper.getList();
	}


	@Override
	public void modify(BoardVO board) {
	
		boardMapper.modify(board);
	}

	@Override
	public void delete(Long bd_number) {

		boardMapper.delete(bd_number);
	}

	@Override
	public List<BoardVO> getListWithPaging(Criteria cri) {

		return boardMapper.getListWithPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {

		return boardMapper.getTotalCount(cri);
	}

	@Override
	public BoardVO getListType(String bd_type) {
		
		return boardMapper.getListType(bd_type);
	}	
}

package com.devday.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.devday.domain.BoardVO;
import com.devday.dto.Criteria;
import com.devday.mapper.UsBoardMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class UsBoardServiceImpl implements UsBoardService {

	private final UsBoardMapper usBoardMapper;

	@Override
	public void register(BoardVO board) {

		usBoardMapper.register(board);
	}

	@Override
	@Transactional
	public BoardVO get(Long bd_number, boolean increaseReadCount) {
		
		// 게시물 조회 페이지에서만 true, 나머지는 false로 처리 
		if (increaseReadCount) {
			usBoardMapper.readCount(bd_number); // usBoardService 인터페이스에 부존재
		}

		return usBoardMapper.get(bd_number);
	}
	
		
	@Override
	public List<BoardVO> getList() {

		return usBoardMapper.getList();
	}

	@Override
	public void modify(BoardVO board) {

		usBoardMapper.modify(board);
	}

	@Override
	public void delete(Long bd_number) {

		usBoardMapper.delete(bd_number);
	}

	@Override
	public List<BoardVO> getListWithPaging(Criteria cri, String bd_type) {

		return usBoardMapper.getListWithPaging(cri, bd_type);
	}

	@Override
	public int getTotalCount(Criteria cri, String bd_type) {

		return usBoardMapper.getTotalCount(cri, bd_type);
	}
}

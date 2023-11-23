package com.devday.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.devday.domain.ReviewVO;
import com.devday.dto.Criteria;
import com.devday.mapper.ReviewMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewServiceImpl implements ReviewService {

	private final ReviewMapper reviewMapper;

	@Override
	public void review_insert(ReviewVO vo) {

		reviewMapper.review_insert(vo);
	}

	@Override
	public List<ReviewVO> list(Integer pd_number, Criteria cri) {

		return reviewMapper.list(pd_number, cri);
	}

	@Override
	public int listCount(Integer pd_number) {
		
		return reviewMapper.listCount(pd_number);
	}
}

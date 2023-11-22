package com.devday.service;

import org.springframework.stereotype.Service;

import com.devday.domain.ReviewVO;
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
}

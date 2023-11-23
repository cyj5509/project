package com.devday.service;

import java.util.List;

import com.devday.domain.ReviewVO;
import com.devday.dto.Criteria;

public interface ReviewService {

	void review_insert(ReviewVO vo);

	List<ReviewVO> list(Integer pd_number, Criteria cri);
	
	int listCount(Integer pd_number);
}

package com.devday.service;

import java.util.List;

import com.devday.domain.ReviewVO;
import com.devday.dto.Criteria;

public interface ReviewService {

	void review_insert(ReviewVO vo);
	
	void review_modify(ReviewVO vo);

	List<ReviewVO> list(Integer pd_number, Criteria cri); // Criteria에서 검색 관련 필드 사용 안함
	
	int listCount(Integer pd_number);
	
	void delete(Long rv_number); // INSERT, DELETE, UPDATE 문은 void

}

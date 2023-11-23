package com.devday.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.devday.domain.ReviewVO;
import com.devday.dto.Criteria;

public interface ReviewMapper {

	void review_insert(ReviewVO vo);
	
	List<ReviewVO> list(@Param("pd_number") Integer pd_number, 
			   @Param("cri") Criteria cri); // Criteria에서 검색 관련 필드 사용 안함

	int listCount(Integer pd_number);
}

package com.devday.mapper;

import java.util.List;

import com.devday.domain.CategoryVO;

public interface UsCategoryMapper {

	// AdCategoryMapper -> CommCategoryMapper 형태로 작업해도 됨
	List<CategoryVO> getSecondCategoryList(Integer cg_parent_code);// 2차 카테고리 출력
}

package com.devday.service;

import java.util.List;

import com.devday.domain.CategoryVO;

public interface UsCategoryService {

	List<CategoryVO> getSecondCategoryList(Integer cg_prt_code);// 2차 카테고리 출력
}

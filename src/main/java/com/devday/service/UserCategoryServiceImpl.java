package com.devday.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.devday.domain.CategoryVO;
import com.devday.mapper.UserCategoryMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

// Bean의 생성 및 등록을 위한 설정 작업
// 1. @Service: UserCategoryServiceImpl Bean 생성
// 2. root-context.xml의 <context:component-scan base-package="com.docmall.service" />
@Service 
@RequiredArgsConstructor
@Log4j
public class UserCategoryServiceImpl implements UserCategoryService {

	private final UserCategoryMapper userCategoryMapper;

	@Override
	public List<CategoryVO> getSecondCategoryList(Integer cg_prt_code) {
		
		return userCategoryMapper.getSecondCategoryList(cg_prt_code);
	}

}

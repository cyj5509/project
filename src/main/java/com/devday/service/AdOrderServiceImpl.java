package com.devday.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.devday.domain.OrderBasicVO;
import com.devday.dto.Criteria;
import com.devday.mapper.AdOrderMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdOrderServiceImpl implements AdOrderService {

	private final AdOrderMapper adOrderMapper;
	
	@Override
	public List<OrderBasicVO> order_list(Criteria cri) {

		return adOrderMapper.order_list(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {

		return adOrderMapper.getTotalCount(cri);
	}
}

package com.devday.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.devday.domain.CartVO;
import com.devday.dto.CartDTOList;
import com.devday.mapper.CartMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CartServiceImpl implements CartService {

	private final CartMapper cartMapper; 

	// 장바구니 추가 관련 메서드
	@Override
	public void cart_add(CartVO ct_vo) {
		
		cartMapper.cart_add(ct_vo);
	}

	@Override
	public List<CartDTOList> cart_list(String us_id) {
	
		return cartMapper.cart_list(us_id);
	}

	// 장바구니 수량 변경 관련 메서드
	@Override
	public void cart_amount_change(Long ct_code, int ct_amount) {
		
		cartMapper.cart_amount_change(ct_code, ct_amount);
	}

	// 장바구니 목록에서 개별 삭제 관련 메서드
	@Override
	public void cart_list_del(Long ct_code) {
		
		cartMapper.cart_list_del(ct_code);
		
	}
	
	@Override
	public void cart_sel_delete(List<Long> ct_code_arr) {

		cartMapper.cart_sel_delete(ct_code_arr);
	}



}

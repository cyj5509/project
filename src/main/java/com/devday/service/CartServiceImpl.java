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
	public void cart_add(CartVO vo) {
		
		cartMapper.cart_add(vo);
	}

	@Override
	public List<CartDTOList> cart_list(String mem_id) {
	
		return cartMapper.cart_list(mem_id);
	}

	// 장바구니 수량 변경 관련 메서드
	@Override
	public void cart_amount_change(Long cart_code, int cart_amount) {
		
		cartMapper.cart_amount_change(cart_code, cart_amount);
	}

	// 장바구니 목록에서 개별 삭제 관련 메서드
	@Override
	public void cart_list_del(Long cart_code) {
		
		cartMapper.cart_list_del(cart_code);
		
	}
	
	@Override
	public void cart_sel_delete(List<Long> cart_code_arr) {

		cartMapper.cart_sel_delete(cart_code_arr);
	}



}

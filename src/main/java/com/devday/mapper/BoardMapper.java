package com.devday.mapper;

import java.util.List;

import com.devday.domain.BoardVO;
import com.devday.dto.Criteria;

public interface BoardMapper {

	// 추상 메서드
	// 특별하지 않으면 INSERT, UPDATE, DELETE의 리턴값은 void

	// 글 쓰기 저장
	// 메서드명과 xml 파일의 id="register" 일치 -> <insert id="register"></insert>
	void register(BoardVO board);

	// 하나의 게시물 읽기 또는 글 수정 폼: BoardVO
	BoardVO get(Long bd_number);

	// 전체 목록(여러 개): List<BoardVO> 리턴값
	List<BoardVO> getList();

	// 페이징 목록(여러 개): List<BoardVO> 리턴값 -> pageNum, amount, type, keyword 사용
	List<BoardVO> getListWithPaging(Criteria cri);

	// 전체 데이터 개수(검색 포함)
	int getTotalCount(Criteria cri);

	// 조회수 증가
	void readCount(Long bd_number);

	// 글 수정하기
	void modify(BoardVO board);

	// 글 삭제하기
	void delete(Long bd_number);

	// 개인적으로 만든 메서드
	BoardVO listType(String bd_type);
}

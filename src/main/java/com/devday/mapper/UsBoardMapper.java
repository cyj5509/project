package com.devday.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.devday.domain.BoardVO;
import com.devday.domain.VoteVO;
import com.devday.dto.Criteria;

public interface UsBoardMapper {

	// 특별하지 않으면 INSERT, UPDATE, DELETE의 리턴값은 void

	// 게시글 등록, 조회 및 수정 관련 메서드
	void register(BoardVO board); // 게시글 등록(INSERT 문)
	BoardVO get(Long bd_number); // 게시물 조회 및 수정(SELECT 문)
	void readCount(Long bd_number); // 조회 증가(UPDATE 문)
	
	void insertVote(VoteVO vt_vo);
	int voteCheck(Map<String, Object> map);
	void increaseLike(Long bd_number); // 추천 증가(UPDATE 문)
	void increaseDislike(Long bd_number); // 비추천 증가(UPDATE 문)
	
	// 전체 목록(여러 개): List<BoardVO> 리턴값
	List<BoardVO> getList();

	// 페이징 목록(여러 개): List<BoardVO> 리턴값 -> pageNum, amount, type, keyword 사용
	List<BoardVO> getListWithPaging(@Param("cri") Criteria cri, 
								   @Param("bd_type") String bd_type);

	// 전체 데이터 개수(검색 포함)
	int getTotalCount(@Param("cri") Criteria cri, 
					  @Param("bd_type") String bd_type);


	// 글 수정하기
	void modify(BoardVO board);

	// 글 삭제하기
	void delete(Long bd_number);
}

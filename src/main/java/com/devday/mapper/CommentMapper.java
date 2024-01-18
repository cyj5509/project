package com.devday.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.devday.domain.CommentVO;
import com.devday.dto.Criteria;

public interface CommentMapper {

	// 댓글 추가, 수정, 삭제 관련 메서드
	void insert(CommentVO cm_vo);
	void modify(CommentVO cm_vo);
	void delete(Long cm_code);
	CommentVO findComment(Long cm_code);
	
	// 댓글 및 대댓글 조회 관련 메서드
	List<CommentVO> getComment(@Param("bd_number") Long bd_number, 
							   @Param("cri") Criteria cri);
	List<CommentVO> getReply(Long cm_code);
	int getTotalCount(Long bd_number);
	List<CommentVO> getAllComments(Long bd_number);
}

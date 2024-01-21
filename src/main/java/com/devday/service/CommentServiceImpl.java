package com.devday.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.devday.domain.CommentVO;
import com.devday.dto.Criteria;
import com.devday.mapper.CommentMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class CommentServiceImpl implements CommentService {

	private final CommentMapper commentMapper;

	@Transactional
    @Override
    public void manageComments(CommentVO cm_vo, String action) {
		
        switch (action) {
            case "insert":
                commentMapper.insert(cm_vo);
                // log.info("댓글 코드: " + cm_vo.getCm_code());
                break;
            case "modify":
                commentMapper.modify(cm_vo);
                break;
            case "delete":            	
                commentMapper.delete(cm_vo.getCm_code());
                break;
        }
    }
	
	@Override
	public CommentVO findComment(Long cm_code) {
		
		return commentMapper.findComment(cm_code);
	}
	
	@Override
    public List<CommentVO> retrieveComments(Long bd_number, Criteria cri) {

	    return commentMapper.getComment(bd_number, cri); // 댓글 목록 반환
	}

	@Override
	public List<CommentVO> retrieveReplies(Long cm_code) {
		
	    return commentMapper.getReply(cm_code); // 답글 목록 반환
	}
	
	@Override
	public int countComments(Long bd_number) {
		
		return commentMapper.countComments(bd_number); // 원본 댓글 수 반환
	}
	
	@Override
	public int countReplies(Long cm_code) {
		
		return commentMapper.countReplies(cm_code); // 답글 수 반환
	}
}

package com.devday.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.devday.domain.BoardVO;
import com.devday.domain.VoteVO;
import com.devday.dto.Criteria;
import com.devday.dto.VoteResultDTO;
import com.devday.mapper.UsBoardMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UsBoardServiceImpl implements UsBoardService {

	private final UsBoardMapper usBoardMapper;

	@Override
	public void register(BoardVO board) {

		usBoardMapper.register(board);
	}

	@Override
	@Transactional
	public BoardVO get(Long bd_number, boolean increaseReadCount) {

		if (increaseReadCount) {
			usBoardMapper.readCount(bd_number); // usBoardService 인터페이스에 부존재
		}

		return usBoardMapper.get(bd_number);
	}

	@Override
	public boolean checkVote(Long bd_number, String us_id, String non_us_id) {
		
	    Map<String, Object> map = new HashMap<>();
	    map.put("bd_number", bd_number);
	    map.put("us_id", us_id);
	    map.put("non_us_id", non_us_id);

	    int count = usBoardMapper.checkVote(map);
	    return count > 0;
	}
	
	@Override
	public String getCurrentVoteStatus(Long bd_number, String us_id, String non_us_id) {
		
		Map<String, Object> map = new HashMap<>();
	    map.put("bd_number", bd_number);
	    map.put("us_id", us_id);
	    map.put("non_us_id", non_us_id);
		
		return usBoardMapper.getCurrentVoteStatus(map);
	}
	
	@Override
	@Transactional
	public VoteResultDTO insertVote(VoteVO vt_vo) {
		// 투표 여부 확인
		boolean alreadyVote = checkVote(vt_vo.getBd_number(), vt_vo.getUs_id(), vt_vo.getNon_us_id());
		String currentStatus = alreadyVote ? getCurrentVoteStatus(vt_vo.getBd_number(), vt_vo.getUs_id(), vt_vo.getNon_us_id()) : null;

		if (!alreadyVote) {
			// 기존에 투표하지 않은 경우 새로운 투표 추가
			usBoardMapper.insertVote(vt_vo);
			updateCount(vt_vo.getBd_number(), vt_vo.getVt_status(), true); // 추천 또는 비추천 수 증가
			return new VoteResultDTO(true);
		} else if (alreadyVote && vt_vo.getVt_status().equals(currentStatus)) {
			// 같은 상태로 다시 투표하는 경우(투표 취소)
			usBoardMapper.cancelVote(vt_vo);
			updateCount(vt_vo.getBd_number(), currentStatus, false); // 추천 또는 비추천 수 감소
	        return new VoteResultDTO(true);
		} else if (alreadyVote && !vt_vo.getVt_status().equals(currentStatus)) {
			// 다른 상태로 다시 투표하는 경우(투표 변경)
			usBoardMapper.changeVote(vt_vo);
			updateCount(vt_vo.getBd_number(), currentStatus, false); // 이전 카운트 감소
			updateCount(vt_vo.getBd_number(), vt_vo.getVt_status(), true); // 새 카운트 증가
	        return new VoteResultDTO(true);
		}
		 return new VoteResultDTO(false);
	}
	
	// insertVote 메서드 내에서 사용(일관성 등을 위해 재정의), boolean increase는 true/false 직접 제어
	@Override 
	public void updateCount(Long bd_number, String vt_status, boolean increase) {
	    if ("like".equals(vt_status)) {
	        if (increase) usBoardMapper.increaseLike(bd_number); // 추천 수 증가
	        else usBoardMapper.decreaseLike(bd_number); // 추천 수 감소
	    } else if ("dislike".equals(vt_status)) {
	        if (increase) usBoardMapper.increaseDislike(bd_number); // 비추천 수 증가
	        else usBoardMapper.decreaseDislike(bd_number); // 비추천 수 감소
	    }
	}
	
	@Override
	public List<BoardVO> getList() {

		return usBoardMapper.getList();
	}

	@Override
	public void modify(BoardVO board) {

		usBoardMapper.modify(board);
	}

	@Override
	public void delete(Long bd_number) {

		usBoardMapper.delete(bd_number);
	}

	@Override
	public List<BoardVO> getListWithPaging(Criteria cri, String bd_type) {

		return usBoardMapper.getListWithPaging(cri, bd_type);
	}

	@Override
	public int getTotalCount(Criteria cri, String bd_type) {

		return usBoardMapper.getTotalCount(cri, bd_type);
	}
}

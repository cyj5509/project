package com.devday.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.devday.domain.VoteVO;
import com.devday.dto.VoteResultDTO;
import com.devday.mapper.VoteMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class VoteServiceImpl implements VoteService {
	
	private final VoteMapper voteMapper;
	
	@Override
	public VoteVO getLatestVote(Long bd_number, String us_id) {

		// 쿼리 파라미터를 담을 Map 생성
		Map<String, Object> params = new HashMap<>();
		params.put("bd_number", bd_number); // 게시물 번호
		params.put("us_id", us_id); // 사용자 아이디

		return voteMapper.getLatestVote(params);
	}
	
//	@Override
//	public BoardVoteVO getVoteAction(Long bd_number) {
//
//		return voteMapper.getVoteAction(bd_number);
//	}

	@Override
	public String getCurrentVoteStatus(Long bd_number, String us_id) {
		
		// 쿼리 파라미터를 담을 Map 생성
		Map<String, Object> params = new HashMap<>();
		params.put("bd_number", bd_number); // 게시물 번호
		params.put("us_id", us_id); // 사용자 아이디
		
		// 단일 결과를 String으로 반환
		return voteMapper.getCurrentVoteStatus(params); // "like", "dislike" 또는 "none"
	}
	
	// 1일 1회 투표 처리 로직
	@Override
	public boolean checkDailyVote(Long bd_number, String us_id, String bd_type) {
		
	    Map<String, Object> map = new HashMap<>();
	    map.put("bd_number", bd_number);
	    map.put("us_id", us_id);
	    map.put("bd_type", bd_type);

	    int count = voteMapper.checkDailyVote(map);
	    return count > 0;
	}
	
	// 계정당 1회 투표 처리 로직
	@Override
	public boolean checkAccountVote(Long bd_number, String us_id, String bd_type) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("bd_number", bd_number);
		map.put("us_id", us_id);
		map.put("bd_type", bd_type);
		
		int count = voteMapper.checkAccountVote(map);
		return count > 0;
	}
	
	@Override
	@Transactional
	public VoteResultDTO insertVote(VoteVO vt_vo, String bd_type) {
		
		// 현재 사용자의 투표 상태를 가져옴(해당하는 데이터가 없는 경우 null 반환)
	    String currentStatus  = getCurrentVoteStatus(vt_vo.getBd_number(), vt_vo.getUs_id());	   	    
	    log.info("저장된 상태: " + currentStatus);

	    // 1일 1회 및 계정당 1회 투표 여부 확인
	    boolean checkDailyVote = checkDailyVote(vt_vo.getBd_number(), vt_vo.getUs_id(), bd_type); // 1일 1회 확인
	    log.info("1일 1회 확인: " + checkDailyVote);
	    boolean checkAccountVote = checkAccountVote(vt_vo.getBd_number(), vt_vo.getUs_id(), bd_type); // 계정당 1회 확인
	    log.info("계정당 1회 확인: " + checkAccountVote);
	    
	    boolean alreadyVoted = (bd_type.equals("free")) ? checkDailyVote : checkAccountVote;
		
		String actionType = vt_vo.getVt_status(); // actionType을 투표 상태로 설정
		log.info("선택한 상태: " + actionType);

		boolean isVoteChange = false; // 추가, 취소, 변경 처리가 아닌 경우

		if (!alreadyVoted && currentStatus == null) {
			// 투표 추가: 이전에 투표한 기록이 없고 취소 등으로 현재 상태도 없는 경우
			voteMapper.insertVote(vt_vo);
			isVoteChange = true;
		} else if (alreadyVoted && currentStatus != null) {
			// 투표 취소 및 변경: 이전에 투표한 기록이 있고 현재 상태도 존재하는 경우
			if ("none".equals(actionType)) {
				// 같은 상태로 다시 투표하는 경우(투표 취소)
				Map<String, Object> params = new HashMap<>();
			    params.put("vt_vo", vt_vo);
			    params.put("bd_type", bd_type);
			    voteMapper.cancelVote(params);
				isVoteChange = false;
			} else if (!actionType.equals(currentStatus)) {
				// 다른 상태로 다시 투표하는 경우(투표 변경)
				Map<String, Object> params = new HashMap<>();
			    params.put("vt_vo", vt_vo);
			    params.put("bd_type", bd_type);
			    voteMapper.changeVote(params);
				isVoteChange = true;
			}
		}

		// 취소/변경/추가 여부에 관계없이 집계 데이터 업데이트
		Map<String, Integer> counts = countVoteStatus(vt_vo.getBd_number()); // 집계 관련 메서드 호출
		log.info("반환 컬럼: " + counts.keySet());

		// 최신 투표 데이터 조회
	    VoteVO db_vo = getLatestVote(vt_vo.getBd_number(), vt_vo.getUs_id());
		Date latestVoteDate = (db_vo != null) ? db_vo.getVt_register_date() : null;
		log.info("투표 정보: " + db_vo);
	    
		// getOrDefault는 키에 해당하는 값, 값이 없는 경우 기본값 설정(get은 키에 해당하는 값만 해당)
		int likesCount = counts.getOrDefault("like", 0);
		int dislikesCount = counts.getOrDefault("dislike", 0);
		
		// VoteResultDTO 생성시 최신 투표 데이터의 등록일도 포함
		return new VoteResultDTO(isVoteChange, likesCount, dislikesCount, latestVoteDate);
	}
	
	@Override
	public Map<String, Integer> countVoteStatus(Long bd_number) {
		
		// 매퍼로부터 결과 리스트를 받음
		List<Map<String, Object>> results = voteMapper.countVoteStatus(bd_number);
		Map<String, Integer> countMap = new HashMap<>();
		for (Map<String, Object> result : results) {
			// 각 결과로부터 vt_status와 count 추출(쿼리에서 설정한 별칭 사용)
			String status = (String) result.get("vt_status");
			Integer count = ((Number) result.get("count")).intValue(); // COUNT(*) 결과를 안전하게 정수로 변환
			countMap.put(status, count);
		}
		return countMap; // 집계된 결과 반환
	}
}

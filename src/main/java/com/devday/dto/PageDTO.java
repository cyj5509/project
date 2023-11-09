package com.devday.dto;

import lombok.Getter;
import lombok.ToString;

// 페이징 기능 목적 클래스 [prev] 1 2 3 4 5 6 7 8 9 10 [next]

@Getter
@ToString
public class PageDTO {


	private int startPage; // 각 블록에서 출력할 시작 페이지 번호
	private int endPage; // 각 블록에서 출력할 종료 페이지 번호

	private boolean prev, next; // 이전, 다음 표시 여부

	private int total; // 테이블의 데이터 총 개수

	private Criteria cri; // 1) 페이징: pageNum, amount / 2) 검색: type, keyword

	public PageDTO(Criteria cri, int total) {

		/*
		   1) 나머지가 존재하는 경우, 페이지 하나가 더 필요함
		   total: 13개
		   amount: 5개
		   페이지 수: 3
		   
		   2) 나머지가 존재하지 않는 경우, 추가 페이지가 불필요 
		   total: 10개
		   amount: 5개
		   페이지 수: 2
		*/
		
		this.cri = cri; // 1) 검색 조건이 없을 경우 pageNum=1, amount=10, type=null, keyword=null
		this.total = total;

		int pageSize = 10; // 블록에 보여줄 페이지 번호의 개수 -> 1 2 3 4 5 6 7 8 9 10
		int endPageInfo = pageSize - 1; // 9
		
		// this.endPage = (int) (Math.ceil(1 / 10.0)) * 10;
		this.endPage = (int) (Math.ceil(cri.getPageNum() / (double) pageSize)) * pageSize;
				
		// this.startPage = 10 - 9;
		this.startPage = this.endPage - endPageInfo;
		
		// 나머지가 있는 경우 한 페이지가 더 필요해서 Math.ceil()을 사용함
		// [예시] int readEnd = (int) (Math.ceil((13 * 1.0) / 5));
		int readEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
		
		if(readEnd <= this.endPage) {
			this.endPage = readEnd; // 위의 가정을 전제로 endPage가 3임;
		}
		
		this.prev = this.startPage > 1; // false 값 대입  
		this.next = this.endPage < readEnd; // false 값 대입
		
		// cri: pageNum=1, amount=10, type=null, keyword=null
		// pageSize, startPage, endPage, prev, next가 값을 갖게 됨
	}
}

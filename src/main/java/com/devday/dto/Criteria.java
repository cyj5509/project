package com.devday.dto;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// 페이징 및 검색 필드를 가지고 있는 클래스
@Getter
@Setter
@ToString
// '기준'을 의미하는 Criteria 클래스 생성
public class Criteria {

	private int pageNum; // 선택된 페이지 번호를 저장할 필드
	private int amount; // 페이지마다 출력할 게시물 개수. pro_list 메서드의 cri.setAmount(2);에 의해 10 -> 2 

	private String type; // 검색 종류 -> T, C, W, TC, TW, TWC
	private String keyword; // 검색어

	// 아래 기본 생성자를 생략해선 안 된다.
	public Criteria() {
		this(1, 10); // this(1, 10); -> this(1, 2); 또는 	AdProductController에서 10 -> 2. cri.setAmount(2);
		System.out.println("Criteria 기본 생성자 호출");
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum; // 1
		this.amount = amount; // 10
		// type, keyword는 null로 처리
	}

	// getType() 메서드 대신 boardMapper.xml에서 사용할 메서드
	// type;(검색 종류)은 6개 중 선택
	public String[] getTypeArr() {

		// type이 "TWC"면, {"T", "W", "C"}
		return type == null ? new String[] {} : type.split("");
	}
	
	//UriComponentsBuilder(스프링에서 제공): 여러 개의 파라미터들을 연결하여 URL 형태로 만들어주는 기능
	// /board/list?pageNum=값&amount=값&type=값&keyword=값
	// BoardController의 rttr로 시작하는 반복 구문 대체
	public String getListLink() {
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
			.queryParam("pageNum", this.pageNum)
			.queryParam("amount", this.amount)
			.queryParam("type", this.type)
			.queryParam("keyword", this.keyword);
		
		return builder.toUriString();
	}
}
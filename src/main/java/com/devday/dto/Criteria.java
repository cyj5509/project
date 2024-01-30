package com.devday.dto;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// '기준'을 의미하는 페이징 및 조건 검색을 처리하는 클래스

@Getter
@Setter
@ToString
public class Criteria {

	private int pageNum; // 페이지 번호
	private int amount; // 페이지당 항목 수. pro_list 메서드의 cri.setAmount(2);에 의해 10 -> 2 

	private String type; // 검색 유형 -> T, C, W, TC, TW, TWC
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

	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
	
	// UriComponentsBuilder 클래스: 여러 개의 파라미터를 연결하여 URL 형태로 생성
	// pageNum=값&amount=값&type=값&keyword=값
	public String getListLink() {
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
			.queryParam("pageNum", this.pageNum)
			.queryParam("amount", this.amount)
			.queryParam("type", this.type)
			.queryParam("keyword", this.keyword);
		
		return builder.toUriString();
	}
}
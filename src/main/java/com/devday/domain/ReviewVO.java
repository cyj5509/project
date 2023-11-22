package com.devday.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {

	// rew_num, mbsp_id, pro_num, rew_content, rew_score, rew_regdate
	
	private Long rv_number;
	private String us_id;
	private Integer pd_number;
	private String rv_content;
	private int rv_score;
	private Date rv_register_date;
}

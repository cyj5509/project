package com.devday.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
CREATE TABLE vote_table (
    vt_number         NUMBER          NOT NULL,        -- 투표 번호(시퀀스 사용)
    us_id             VARCHAR2(40),                    -- 사용자 아이디
    non_us_id         VARCHAR2(100),                   -- 비회원 식별자
    bd_number         NUMBER          NOT NULL,        -- 게시물 번호
    vt_status         VARCHAR2(20),                    -- 'Like' vs. 'Dislike'(NULL 허용)
    vt_register_date  DATE DEFAULT sysdate,       	   -- 등록 일자
    CONSTRAINT pk_vt_number PRIMARY KEY (vt_number),
    CONSTRAINT fk_vote_bd_number FOREIGN KEY(bd_number)
        REFERENCES board_table(bd_number) ON DELETE CASCADE -- 연쇄 삭제 옵션 적용
);
*/

@Getter
@Setter
@ToString
public class VoteVO {
	
    private Long vt_number;
    private String us_id;
    private String non_us_id;
    private Long bd_number;
    private String vt_status;
    private Date vt_register_date;
}

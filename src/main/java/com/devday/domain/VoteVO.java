package com.devday.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
CREATE TABLE vote_table (
    vt_number   NUMBER          NOT NULL,        -- 투표 번호(시퀀스 사용)
    us_id       VARCHAR2(40),                    -- 사용자 ID(회원의 경우)
    session_id  VARCHAR2(100),                   -- 세션 ID(비회원의 경우)
    bd_number   NUMBER          NOT NULL,        -- 게시물 번호
    vt_type     VARCHAR2(20)    NOT NULL,        -- 투표 구분('like' vs. 'dislike')
    vt_date     DATE DEFAULT current_date,       -- 투표 일자
    CONSTRAINT pk_vt_number PRIMARY KEY (vt_number),
    CONSTRAINT fk_vote_bd_number FOREIGN KEY(bd_number) REFERENCES board_table(bd_number)
);
*/

@Getter
@Setter
@ToString
public class VoteVO {
	
    private Long vt_number;
    private String us_id;
    private String session_id;
    private Long bd_number;
    private String vt_type;
    private Date vt_date;
}

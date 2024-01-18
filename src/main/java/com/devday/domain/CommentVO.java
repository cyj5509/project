package com.devday.domain;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
CREATE TABLE comment_table (
	    cm_code             NUMBER,                          -- 댓글 코드(2차 이후)
	    cm_parent_code      NUMBER                NULL,      -- 상위 댓글 코드(1차: 대댓글 기능용)
	    bd_number           NUMBER                NOT NULL,  -- 게시물 번호
	    us_id               VARCHAR2(40),                    -- 사용자 아이디(NULL 허용)
	    cm_content          VARCHAR2(1000)        NOT NULL,  -- 댓글 내용
	    cm_register_date    DATE DEFAULT sysdate  NOT NULL,  -- 등록 일자
	    cm_update_date      DATE DEFAULT sysdate  NOT NULL,  -- 수정 일자
	    cm_guest_nickname   VARCHAR2(40),                    -- 비회원 닉네임(NULL 허용)
	    cm_guest_pw         VARCHAR2(60),                    -- 비회원 비밀번호(NULL 허용)
	    CONSTRAINT pk_cm_code PRIMARY KEY(cm_code),
	    CONSTRAINT fk_cm_parent_code FOREIGN KEY(cm_parent_code) REFERENCES comment_table(cm_code),
	    CONSTRAINT fk_cm_bd_number FOREIGN KEY(bd_number)
	        REFERENCES board_table(bd_number) ON DELETE CASCADE -- 연쇄 삭제 옵션 적용
);
*/

@Getter
@Setter
@ToString
public class CommentVO {

	private Long cm_code;             
    private Long cm_parent_code;       
    private Long bd_number;         
    private String us_id; 
    private String cm_content;
    private Date cm_register_date;
    private Date cm_update_date;
    private String cm_guest_nickname;
    private String cm_guest_pw;
     
    // 테이블에 직접 매핑되지 않고, 서버/클라이언트 간 데이터 전달을 위해 사용
	private List<CommentVO> replies; // 답글 목록을 저장하기 위한 필드
}

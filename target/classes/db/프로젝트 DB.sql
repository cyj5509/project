-- 실습예제 기반 테이블 재구성

/*
SELECT DBMS_XDB.GETHTTPPORT() FROM DUAL;
EXEC DBMS_XDB.SETHTTPPORT(9090);

-- 계정 생성 및 권한 부여
CREATE USER devday IDENTIFIED BY dd;
GRANT RESOURCE, CONNECT TO devday;

COMMIT;
*/

-- 1. 사용자 테이블 ─ 회원가입을 포함한 회원관리(비회원 포함)
-- 기본키: 회원 아이디 / 외래키: 없음
-- DROP TABLE member_tbl;
DROP TABLE user_table;
CREATE TABLE user_table (
    us_id            VARCHAR2(15),                      -- 사용자 아이디
    us_pw            VARCHAR2(60)             NOT NULL, -- 사용자 비밀번호
    us_name          VARCHAR2(30)             NOT NULL, -- 사용자 이름
    us_phone         VARCHAR2(15)             NOT NULL, -- 사용자 전화번호
    us_email         VARCHAR2(50)             NOT NULL, -- 사용자 이메일 
    us_postcode      CHAR(5)                  NOT NULL, -- 사용자 우편번호
    us_addr_basic    VARCHAR2(100)            NOT NULL, -- 사용자 기본주소
    us_addr_detail   VARCHAR2(100)            NOT NULL, -- 사용자 상세주소
    us_point         NUMBER DEFAULT 0         NOT NULL, -- 사용자 포인트
    us_join_date     DATE   DEFAULT sysdate   NOT NULL, -- 가입 일자
    us_update_date   DATE   DEFAULT sysdate   NOT NULL, -- 수정 일자
    us_last_login    DATE   DEFAULT sysdate   NOT NULL, -- 접속 일자
    us_status        NUMBER DEFAULT 0         NOT NULL, -- 회원 vs. 비회원(회원: 0, 비회원: 1)
    ad_check         NUMBER DEFAULT 0         NOT NULL, -- 사용자 vs. 관리자(사용자: 0, 관리자: 1)
    us_login_token   VARCHAR2(250),                     -- 로그인 토큰(NULL 허용)
    tk_expiry_date   DATE,                              -- 토큰 유효 기간(NULL 허용)
    CONSTRAINT pk_us_id PRIMARY KEY(us_id)
);

-- 다른 PK 설정 방법
-- ALTER TABLE user_table ADD CONSTRAINT user_pk PRIMARY KEY (user_id);

ALTER TABLE user_table
ADD (
    us_login_token VARCHAR2(250),  -- 로그인 토큰(NULL 허용)
    tk_expiry_date DATE            -- 토큰 만료일(NULL 허용)
);

-- 관리자 계정 활성화
INSERT INTO
    user_table (us_id, us_pw, us_name, us_phone, us_email, us_postcode, us_addr_basic, us_addr_detail, us_point, us_join_date, us_update_date, us_last_login, us_status, ad_check) VALUES 
    ('admin', '$2a$10$dQFCMr0udCI865eG6SoIcOaNr3Y/dgBX.R4qf6rX5KA3jciSnnNjG', 'admin', 'admin', 'admin', 'admin', 'admin', 'admin', 9999999, sysdate, sysdate, sysdate, 0, 1);

UPDATE user_table SET ad_check = 1 WHERE us_id = 'admin';

-- 사용자 계정 활성화
INSERT INTO
    user_table (us_id, us_pw, us_name, us_phone, us_email, us_postcode, us_addr_basic, us_addr_detail, us_point, us_join_date, us_update_date, us_last_login, us_status, ad_check) 
VALUES 
    ('user01', '$2a$10$dQFCMr0udCI865eG6SoIcOaNr3Y/dgBX.R4qf6rX5KA3jciSnnNjG', '홍길동', '010-1234-5678', 'cyj5509@naver.com', '12345', '서울특별시 노원구 상계로 64', '화랑빌딩 7F 이젠 아카데미', 0, sysdate, sysdate, sysdate, 0, 0);
INSERT INTO
    user_table (us_id, us_pw, us_name, us_phone, us_email, us_postcode, us_addr_basic, us_addr_detail, us_point, us_join_date, us_update_date, us_last_login, us_status, ad_check) 
VALUES 
    ('user02', '$2a$10$dQFCMr0udCI865eG6SoIcOaNr3Y/dgBX.R4qf6rX5KA3jciSnnNjG', '강감찬', '010-1234-5678', 'cyj5509@naver.com', '12345', '서울특별시 노원구 상계로 64', '화랑빌딩 7F 이젠 아카데미', 0, sysdate, sysdate, sysdate, 0, 0);
INSERT INTO
    user_table (us_id, us_pw, us_name, us_phone, us_email, us_postcode, us_addr_basic, us_addr_detail, us_point, us_join_date, us_update_date, us_last_login, us_status, ad_check) 
VALUES 
    ('user03', '$2a$10$dQFCMr0udCI865eG6SoIcOaNr3Y/dgBX.R4qf6rX5KA3jciSnnNjG', '이순신', '010-1234-5678', 'cyj5509@naver.com', '12345', '서울특별시 노원구 상계로 64', '화랑빌딩 7F 이젠 아카데미', 0, sysdate, sysdate, sysdate, 0, 0);
INSERT INTO
    user_table (us_id, us_pw, us_name, us_phone, us_email, us_postcode, us_addr_basic, us_addr_detail, us_point, us_join_date, us_update_date, us_last_login, us_status, ad_check) 
VALUES 
    ('user04', '$2a$10$dQFCMr0udCI865eG6SoIcOaNr3Y/dgBX.R4qf6rX5KA3jciSnnNjG', '김좌진', '010-1234-5678', 'cyj5509@naver.com', '12345', '서울특별시 노원구 상계로 64', '화랑빌딩 7F 이젠 아카데미', 0, sysdate, sysdate, sysdate, 0, 0);
INSERT INTO
    user_table (us_id, us_pw, us_name, us_phone, us_email, us_postcode, us_addr_basic, us_addr_detail, us_point, us_join_date, us_update_date, us_last_login, us_status, ad_check) 
VALUES 
    ('user05', '$2a$10$dQFCMr0udCI865eG6SoIcOaNr3Y/dgBX.R4qf6rX5KA3jciSnnNjG', '안중근', '010-1234-5678', 'cyj5509@naver.com', '12345', '서울특별시 노원구 상계로 64', '화랑빌딩 7F 이젠 아카데미', 0, sysdate, sysdate, sysdate, 0, 0);

COMMIT;

-- 전체 데이터 조회 및 삭제
SELECT * FROM user_table;
DELETE FROM user_table;



-- 2. 관리자 테이블: 회원관리, 상품관리, 주문관리 등
-- 기본키: 관리자 아이디 / 외래키: 없음
DROP TABLE admin_table;
CREATE TABLE admin_table (
    ad_id          VARCHAR2(15),                          -- 관리자 아이디
    ad_pw          VARCHAR2(60)                NOT NULL,  -- 관리자 비밀번호
    ad_last_login   DATE    DEFAULT   sysdate  NOT NULL,  -- 접속 일자
    CONSTRAINT pk_ad_id PRIMARY KEY(ad_id)
);

-- 관리자 계정 활성화
INSERT INTO admin_table VALUES('admin', '$2a$10$dQFCMr0udCI865eG6SoIcOaNr3Y/dgBX.R4qf6rX5KA3jciSnnNjG', sysdate);

COMMIT;

-- 전체 데이터 조회 및 삭제
SELECT * FROM admin_table;
DELETE FROM admin_table;



-- 3. 카테고리 테이블
-- 기본키: 하위 카테고리 코드(2차 이후) / 외래키: 상위 카테고리 코드(1차)
DROP TABLE category_table;
CREATE TABLE category_table (
    cg_code         NUMBER        CONSTRAINT pk_cg_code PRIMARY KEY,  -- 하위 카테고리 코드(2차 이후)
    cg_parent_code  NUMBER        NULL,                               -- 상위 카테고리 코드(1차)
    cg_name         VARCHAR2(50)  NOT NULL,                           -- 카테고리 이름(범주)
    CONSTRAINT fk_cg_parent_code FOREIGN KEY(cg_parent_code) REFERENCES category_table(cg_code)
);

-- 1차 카테고리 : IT 일반(1), 컴퓨터 공학(2), 웹 프로그래밍(3), 프로그래밍 언어(4), 모바일 프로그래밍(5) 데이터베이스(6), 자격증/수험서(7)
INSERT INTO category_table (cg_code, cg_parent_code, cg_name) 
    VALUES (1, NULL, 'IT 일반');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name) 
    VALUES (2, NULL, '컴퓨터 공학');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name) 
    VALUES (3, NULL, '웹 프로그래밍');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name) 
    VALUES (4, NULL, '프로그래밍 언어');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name) 
    VALUES (5, NULL, '모바일 프로그래밍');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name) 
    VALUES (6, NULL, '데이터베이스');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name) 
    VALUES (7, NULL, '자격증&#47;수험서');

-- 1차 카테고리(1): IT 일반
-- 2차 카테고리: IT 일반서, IT 교양서/에세이, 개발 방법론
INSERT INTO category_table (cg_code, cg_parent_code, cg_name) 
    VALUES (8, 1, 'IT 일반서');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name) 
VALUES (9, 1, 'IT 교양서&#47;에세이');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name) 
VALUES (10, 1, '개발 방법론');

-- 1차 카테고리(2): 컴퓨터 공학
-- 2차 카테고리: 컴퓨터 공학 일반, 컴퓨터 구조, 소프트웨어 공학, 운영체제론, 데이터 통신, 자료구조/알고리즘
INSERT INTO category_table (cg_code, cg_parent_code, cg_name) 
    VALUES (11, 2, '컴퓨터 공학 일반');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name) 
    VALUES (12, 2, '컴퓨터 구조');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name) 
    VALUES (13, 2, '소프트웨어 공학');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name) 
    VALUES (14, 2, '운영체제');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name) 
    VALUES (15, 2, '데이터 통신');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name) 
    VALUES (16, 2, '자료구조&#47;알고리즘');

-- 1차 카테고리(3): 웹 프로그래밍
-- 2차 카테고리: 웹 프로그래밍 일반, HTML/CSS, JavaScript
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (17, 3, '웹 프로그래밍 일반');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (18, 3, 'HTML&#47;CSS');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (19, 3, 'JavaScript');    
    
-- 1차 카테고리(4): 프로그래밍 언어
-- 2차 카테고리: 프로그래밍 언어 일반, Java, Python, C, C++, C#
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (20, 4, '프로그래밍 언어 일반');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (21, 4, 'Java');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (22, 4, 'Python');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (23, 4, 'C'); 
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (24, 4, 'C&#43;&#43;');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (25, 4, 'C&#35;');
    
-- 1차 카테고리(5): 모바일 프로그래밍
-- 2차카테고리: 모바일 프로그래밍 일반, 안드로이드, 아이폰/아이패드
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (26, 5, '모바일 프로그래밍 일반');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (27, 5, '안드로이드');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (28, 5, '아이폰&#47;아이패드');     
   
-- 1차 카테고리(6): 데이터베이스
-- 2차 카테고리: 데이터베이스 일반, Oracle, MySQL
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (29, 6, '데이터베이스 일반'); 
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (30, 6, 'Oracle');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (31, 6, 'MySQL');

    
-- 1차 카테고리(7):  자격증/수험서
-- 2차 카테고리: 사무 자동화, 정보 처리, 정보 보안, 네트워크, 그래픽/디자인, 기타 자격증
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (32, 7, '사무 자동화 ');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (33, 7, '정보 처리');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (34, 7, '정보 보안');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (35, 7, '네트워크');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (36, 7, '그래픽&#47;디자인');
INSERT INTO category_table (cg_code, cg_parent_code, cg_name)
    VALUES (37, 7, '기타 자격증');

COMMIT;

-- 전체 데이터 조회 및 삭제
SELECT * FROM category_table;
DELETE FROM category_table;

-- 1차 카테고리 출력
SELECT cg_code, cg_parent_code, cg_name FROM category_table WHERE cg_parent_code IS NULL;

-- 2차 카테고리 출력
SELECT * FROM category_table WHERE cg_parent_code IS NOT NULL;

-- 1차 카테고리의 2차 카테고리 출력.
-- SELECT cg_parent_code, cg_code, cg_name FROM category_table WHERE cg_parent_code = ?;

-- 2차 카테고리의 1차 카테고리 출력
-- SELECT cg_code, cg_parent_code, cg_name FROM category_table where cg_code = ?;



-- 4. 상품 테이블
-- 기본키: 상품 번호 / 외래키: 카테고리 테이블의 하위 카테고리 코드(2차 이후)
DROP TABLE product_table;
CREATE TABLE product_table (
    pd_number            NUMBER CONSTRAINT pk_pd_number PRIMARY KEY,  -- 상품 번호
    cg_code              NUMBER                NULL,                  -- 카테고리 코드(2차 이후)
    pd_name              VARCHAR2(100)         NOT NULL,              -- 상품 이름
    pd_price             NUMBER                NOT NULL,              -- 상품 개별 가격
    pd_discount          NUMBER                NOT NULL,              -- 상품 할인율
    pd_company           VARCHAR2(100)         NOT NULL,              -- 상품 제조사(또는 출판사)
    pd_content           VARCHAR2(4000)        NOT NULL,              -- 상품 상세 내용
    pd_image_folder      VARCHAR2(400)         NOT NULL,              -- 상품 이미지 폴더명
    pd_image             VARCHAR2(1000)        NOT NULL,              -- 상품 이미지
    pd_amount            NUMBER                NOT NULL,              -- 상품 수량(재고)
    pd_buy_status        CHAR(1)               NOT NULL,              -- 판매 여부
    pd_register_date     DATE DEFAULT sysdate  NOT NULL,              -- 등록 일자
    pd_update_date       DATE DEFAULT sysdate  NOT NULL,              -- 수정 일자
    CONSTRAINT fk_pd_cg_code FOREIGN KEY(cg_code) REFERENCES category_table(cg_code)
);

-- 더미 데이터 -- 
INSERT INTO product_table (pd_number, CG_CODE, PD_NAME, PD_PRICE, PD_DISCOUNT, PD_COMPANY, PD_CONTENT, PD_IMAGE_FOLDER, PD_IMAGE, PD_AMOUNT, PD_BUY_STATUS, PD_REGISTER_DATE, PD_UPDATE_DATE)
SELECT sequence_pd_number.NEXTVAL, CG_CODE, PD_NAME, PD_PRICE, PD_DISCOUNT, PD_COMPANY, PD_CONTENT, PD_IMAGE_FOLDER, PD_IMAGE, PD_AMOUNT, PD_BUY_STATUS, PD_REGISTER_DATE, PD_UPDATE_DATE FROM product_table;

-- 시퀀스: 상품 테이블의 상품 번호 컬럼(pd_number)
DROP SEQUENCE sequence_pd_number;
CREATE SEQUENCE sequence_pd_number;

COMMIT;

-- 전체 데이터 조회 및 삭제
SELECT * FROM product_table;
DELETE FROM product_table;



-- 5. 장바구니 테이블
-- 기본키: 장바구니 코드 / 외래키: 상품 테이블의 상품 번호, 사용자의 테이블의 사용자 아이디
DROP TABLE cart_table;
CREATE TABLE cart_table(
    ct_code     NUMBER,                  -- 장바구니 코드
    pd_number   NUMBER        NOT NULL,  -- 상품 번호
    us_id       VARCHAR2(15)  NOT NULL,  -- 회원 아이디
    ct_amount   NUMBER        NOT NULL,  -- 장바구니 수량
    CONSTRAINT pk_ct_code PRIMARY KEY(ct_code),
    CONSTRAINT fk_ct_pd_number FOREIGN KEY(pd_number) REFERENCES product_table(pd_number)
    -- CONSTRAINT fk_ct_us_id FOREIGN KEY(us_id) REFERENCES user_table(us_id)
);

-- 시퀀스: 장바구니 테이블의 카테고리 코드 컬럼(ct_code)
DROP SEQUENCE sequence_ct_code;
CREATE SEQUENCE sequence_ct_code;

COMMIT;

-- 전체 데이터 조회 및 삭제
SELECT * FROM cart_table;
DELETE FROM cart_table;



-- 6. 주문 테이블(기본)
-- 기본키: 주문 번호 / 외래키: 사용자 테이블의 사용자 아이디
-- DROP TABLE order_table;
DROP TABLE order_basic_table;
CREATE TABLE order_basic_table (
    od_number         NUMBER CONSTRAINT pk_bs_od_number PRIMARY KEY,  -- 주문 번호
    us_id             VARCHAR2(15)          NOT NULL,                 -- 회원 아이디
    od_name           VARCHAR2(30)          NOT NULL,                 -- 주문자의 이름
    od_phone          VARCHAR2(20)          NOT NULL,                 -- 주문자의 전화번호
    od_postcode       CHAR(5)               NOT NULL,                 -- 주문자의 우편번호
    od_addr_basic     VARCHAR2(50)          NOT NULL,                 -- 주문자의 기본 주소
    od_addr_detail    VARCHAR2(50)          NOT NULL,                 -- 주문자의 상세 주소
    od_total_price    NUMBER                NOT NULL,                 -- 전체 주문 금액
    od_pay_date       DATE DEFAULT sysdate  NOT NULL,                 -- 결제 일자
    od_status         VARCHAR2(20)          NOT NULL,                 -- 주문 상태
    pm_status         VARCHAR2(20)          NOT NULL                  -- 결제 상태
    -- CONSTRAINT fk_bs_us_id FOREIGN KEY(us_id) REFERENCES user_table(us_id)
);

COMMIT;

-- 전체 데이터 조회 및 삭제
SELECT * FROM order_basic_table;
DELETE FROM order_basic_table;



-- 7. 주문 테이블(상세)
-- 기본키(복합키): 주문 번호 및 상품 번호 / 외래키: 주문 테이블(기본)의 주문 번호, 상품 테이블의 상품 번호
DROP TABLE order_detail_table;
CREATE TABLE order_detail_table (
    od_number     NUMBER    NOT NULL CONSTRAINT fk_dt_od_number REFERENCES order_basic_table(od_number),  -- 주문 번호
    pd_number     NUMBER    NOT NULL CONSTRAINT fk_dt_pd_number REFERENCES product_table(pd_number),      -- 상품 번호
    od_amount     NUMBER    NOT NULL,                                                                     -- 상품 개별 수량
    od_price      NUMBER    NOT NULL,                                                                     -- 상품 개별 가격
    CONSTRAINT ck_dt_number PRIMARY KEY (od_number, pd_number)
);

-- 시퀀스: 주문 테이블(상세)의 주문 번호 컬럼(od_number)
DROP SEQUENCE sequence_od_number;
CREATE SEQUENCE sequence_od_number;

COMMIT;

-- 전체 데이터 조회 및 삭제
SELECT * FROM order_detail_table;
DELETE FROM order_detail_table;

-- 주문상세 정보: 주문상세 테이블, 상품 테이블
-- JOIN: 1) 오라클 조인 2) ANSI-SQL 표준 조인
-- OD.DT_PRICE는 P.PRO_PRICE와 동일
-- 1) 오라클 조인
SELECT OD.od_number, OD.pd_number, OD.od_amount, OD.od_price,
P.pd_number, P.cg_code, P.pd_name, P.pd_price, P.pd_discount, P.pd_company,
P.pd_content, P.pd_image_folder, P.pd_image, P.pd_amount, P.pd_buy_status, P.pd_register_date, P.pd_update_date
FROM order_detail_table OD, product_table P
WHERE OD.pd_number = P.pd_number
AND OD.od_number = 선택 주문번호;

-- 2) ANSI 조인
SELECT OD.od_number, OD.pd_number, OD.od_amount, OD.od_price,
P.pd_number, P.cg_code, P.pd_name, P.pd_price, P.pd_discount, P.pd_company,
P.pd_content, P.pd_image_folder, P.pd_image, P.pd_amount, P.pd_buy_status, P.pd_register_date, P.pd_update_date
FROM order_detail_table OD INNER JOIN product_table P
ON OD.pd_number = P.pd_number
WHERE OD.od_number = 선택 주문번호;

SELECT OD.od_number, OD.pd_number, OD.od_amount, P.pd_number, P.pd_name, P.pd_price, P.pd_image_folder, P.pd_image
FROM order_detail_table OD, product_table P
WHERE OD.pd_number = P.pd_number
AND OD.od_number = 선택 주문번호;

-- 8. 결제 테이블: 카카오페이 및 무통장입금
-- 기본키: 결제 코드 / 외래키: 없음
DROP TABLE payment_table;
CREATE TABLE payment_table (
    pm_number               NUMBER CONSTRAINT pk_pm_code PRIMARY KEY, -- 결제 번호
    od_number               NUMBER NOT NULL,                          -- 주문 번호
    us_id                   VARCHAR2(50) NOT NULL,                    -- 사용자 아이디
    pm_method               VARCHAR2(50) NOT NULL,                    -- 결제 방식
    pm_complete_date        DATE DEFAULT sysdate NULL,                -- 결제 완료 일자
    pm_total_price          NUMBER NOT NULL,                          -- 결제 금액
    pm_no_bankbook_bank     VARCHAR2(50) NULL,                        -- 무통장 입금은행
    pm_no_bankbook_account  VARCHAR2(50) NULL,                        -- 무통장 입금계좌
    pm_no_bankbook_price    NUMBER NULL,                              -- 무통장 입금금액
    pm_no_bankbook_user     VARCHAR2(50) NULL,                        -- 무통장 입금자명
    pm_memo                 VARCHAR2(50) NULL                         -- 메모
);

-- 시퀀스: 결제 테이블의 결제 코드 컬럼(pm_number)
DROP SEQUENCE sequence_pm_number;
CREATE SEQUENCE sequence_pm_number;

COMMIT;

-- 전체 데이터 조회 및 삭제
SELECT * FROM payment_table;
DELETE FROM payment_table;



-- 9. 리뷰 테이블
-- 기본키: 리뷰 번호 / 외래키: 사용자 테이블의 사용자 아이디, 상품 테이블의 상품 번호
DROP TABLE review_table;
CREATE TABLE review_table (
    rv_number         NUMBER,                         -- 리뷰 번호
    us_id             VARCHAR2(15)          NOT NULL, -- 사용자 아이디
    pd_number         NUMBER                NOT NULL, -- 상품 번호
    rv_content        VARCHAR2(1000)         NOT NULL, -- 리뷰 내용
    rv_score          NUMBER                NOT NULL, -- 리뷰 평점
    rv_register_date  DATE DEFAULT sysdate  NOT NULL, -- 등록 일자
    -- CONSTRAINT fk_rv_us_id FOREIGN KEY(us_id) REFERENCES user_table(us_id),
    CONSTRAINT fk_rv_pd_number FOREIGN KEY(pd_number) REFERENCES product_table(pd_number)
);

-- 리뷰 번호에 대한 기본키 설정
ALTER TABLE review_table ADD CONSTRAINT pk_rv_number PRIMARY KEY(rv_number);

-- 시퀀스: 리뷰 테이블의 리뷰 번호 컬럼(rv_number)
DROP SEQUENCE sequence_rv_number;
CREATE SEQUENCE sequence_rv_number;

COMMIT;

-- 전체 데이터 조회 및 삭제
SELECT * FROM review_table;
DELETE FROM review_table;



-- 10. 게시판 테이블
-- 기본키: 게시물 번호 / 외래키: 사용자 테이블의 사용자 아이디
DROP TABLE board_table;
CREATE TABLE board_table (
    bd_number         NUMBER,                           -- 게시물 번호
    bd_type           VARCHAR2(40)            NOT NULL, -- 게시물 구분(타입)
    us_id             VARCHAR2(15),                     -- 사용자 아이디
    bd_title          VARCHAR2(100)           NOT NULL, -- 게시물 제목
    bd_content        VARCHAR2(4000)          NOT NULL, -- 게시물 내용
    bd_register_date  DATE    DEFAULT sysdate,          -- 등록 일자
    bd_update_date    DATE    DEFAULT sysdate,          -- 수정 일자
    bd_view_count     NUMBER  DEFAULT 0,                -- 조회수
    bd_guest_nickname VARCHAR2(40),                     -- 비회원 닉네임(NULL 허용)
    bd_guest_pw       VARCHAR2(60),                     -- 비회원 비밀번호(NULL 허용)
    CONSTRAINT pk_bd_number PRIMARY KEY(bd_number)
);

INSERT INTO board_table(bd_number, bd_type, us_id, bd_title, bd_content, bd_guest_nickname, bd_guest_pw)
  VALUES(sequence_bd_number.NEXTVAL, 'notice', 'admin', '공지(관리자)', '게시판 테스트', null, null);

INSERT INTO board_table(bd_number, bd_type, us_id, bd_title, bd_content, bd_guest_nickname, bd_guest_pw)
  VALUES(sequence_bd_number.NEXTVAL, 'free', 'user01', '자유(회원)', '게시판 테스트', null, null);

INSERT INTO board_table(bd_number, bd_type, us_id, bd_title, bd_content, bd_guest_nickname, bd_guest_pw)
  VALUES(sequence_bd_number.NEXTVAL, 'free', null, '자유(비회원)', '게시판 테스트', 'guest01', '$2a$10$gMV7csO4ARfRzZ572BDkNeSTCvZIJqkrg4FRgwFi9yWHsPcPPvKXO');  
  
INSERT INTO board_table(bd_number, bd_type, us_id, bd_title, bd_content, bd_guest_nickname, bd_guest_pw)
  VALUES(sequence_bd_number.NEXTVAL, 'info', 'user02', '정보(회원)', '게시판 테스트', null, null);

INSERT INTO board_table(bd_number, bd_type, us_id, bd_title, bd_content, bd_guest_nickname, bd_guest_pw)
  VALUES(sequence_bd_number.NEXTVAL, 'study', 'user03', '공부(회원)', '게시판 테스트', null, null);

INSERT INTO board_table(bd_number, bd_type, us_id, bd_title, bd_content, bd_guest_nickname, bd_guest_pw)
  VALUES(sequence_bd_number.NEXTVAL, 'project', 'user04', '플젝(회원)', '게시판 테스트', null, null);
  
INSERT INTO board_table(bd_number, bd_type, us_id, bd_title, bd_content, bd_guest_nickname, bd_guest_pw)
  VALUES(sequence_bd_number.NEXTVAL, 'inquery', 'user05', '문의(회원)', '게시판 테스트', null, null);

INSERT INTO board_table(bd_number, bd_type, us_id, bd_title, bd_content, bd_guest_nickname, bd_guest_pw)
  VALUES(sequence_bd_number.NEXTVAL, 'inquery', null, '자유(비회원)', '게시판 테스트', 'guest02', '$2a$10$gMV7csO4ARfRzZ572BDkNeSTCvZIJqkrg4FRgwFi9yWHsPcPPvKXO');  

INSERT INTO board_table(bd_number, bd_type, us_id, bd_title, bd_content, bd_guest_nickname, bd_guest_pw)
SELECT sequence_bd_number.NEXTVAL, bd_type, us_id, bd_title, bd_content, bd_guest_nickname, bd_guest_pw FROM board_table;

COMMIT;

-- 참조키(외래키) 추가
ALTER TABLE board_table ADD CONSTRAINT fk_bd_us_id
FOREIGN KEY (us_id) REFERENCES user_table(us_id);

-- 시퀀스: 게시판 테이블의 게시판 번호 컬럼(bd_number)
DROP SEQUENCE sequence_bd_number;
CREATE SEQUENCE sequence_bd_number;

-- 전체 데이터 조회 및 삭제(384개 행 삽입)
SELECT * FROM board_table;
DELETE FROM board_table;


-- 11. 투표 테이블
DROP TABLE vote_table;
CREATE TABLE vote_table (
    vt_number         NUMBER          NOT NULL,        -- 투표 번호(시퀀스 사용)
    us_id             VARCHAR2(40)    NOT NULL,        -- 사용자 아이디
    bd_number         NUMBER          NOT NULL,        -- 게시물 번호
    vt_status         VARCHAR2(40)    NOT NULL,        -- 'Like' vs. 'Dislike'(NULL 허용)
    vt_register_date  DATE DEFAULT SYSDATE,            -- 등록 일자
    CONSTRAINT pk_vt_number PRIMARY KEY (vt_number),
    CONSTRAINT fk_vote_bd_number FOREIGN KEY(bd_number)
        REFERENCES board_table(bd_number) ON DELETE CASCADE -- 연쇄 삭제 옵션 적용
);

-- 시퀀스: 투표 테이블의 투표 번호 컬럼(vt_number)
DROP SEQUENCE sequence_vt_number;
CREATE SEQUENCE sequence_vt_number;

-- 전체 데이터 조회 및 삭제(384개 행 삽입)
SELECT * FROM vote_table;
DELETE FROM vote_table;



-- 12. 댓글 테이블
DROP TABLE comment_table;
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

-- 시퀀스: 댓글 테이블의 댓글 코드 컬럼(cm_code)
DROP SEQUENCE sequence_cm_code;
CREATE SEQUENCE sequence_cm_code;

INSERT INTO comment_table (cm_code, cm_parent_code, bd_number, us_id, cm_content, cm_guest_nickname, cm_guest_pw)
  VALUES(sequence_cm_code.NEXTVAL, null, 2043, 'user01', '회원 댓글 테스트 01', null, null);

INSERT INTO comment_table (cm_code, cm_parent_code, bd_number, us_id, cm_content, cm_guest_nickname, cm_guest_pw)
  VALUES(sequence_cm_code.NEXTVAL, null, 2043, 'user02', '회원 댓글 테스트 02', null, null);
  
INSERT INTO comment_table (cm_code, cm_parent_code, bd_number, us_id, cm_content, cm_guest_nickname, cm_guest_pw)
  VALUES(sequence_cm_code.NEXTVAL, null, 2043, 'user03', '회원 댓글 테스트 03', null, null);

INSERT INTO comment_table (cm_code, cm_parent_code, bd_number, us_id, cm_content, cm_guest_nickname, cm_guest_pw)
  VALUES(sequence_cm_code.NEXTVAL, null, 2043, null, '비회원 댓글 테스트 01', 'guest01', '$2a$10$gMV7csO4ARfRzZ572BDkNeSTCvZIJqkrg4FRgwFi9yWHsPcPPvKXO');

INSERT INTO comment_table (cm_code, cm_parent_code, bd_number, us_id, cm_content, cm_guest_nickname, cm_guest_pw)
  VALUES(sequence_cm_code.NEXTVAL, null, 2043, null, '비회원 댓글 테스트 02', 'guest02', '$2a$10$gMV7csO4ARfRzZ572BDkNeSTCvZIJqkrg4FRgwFi9yWHsPcPPvKXO');

INSERT INTO comment_table (cm_code, cm_parent_code, bd_number, us_id, cm_content, cm_guest_nickname, cm_guest_pw)
  VALUES(sequence_cm_code.NEXTVAL, null, 2043, null, '비회원 댓글 테스트 03', 'guest03', '$2a$10$gMV7csO4ARfRzZ572BDkNeSTCvZIJqkrg4FRgwFi9yWHsPcPPvKXO');

INSERT INTO comment_table(cm_code, cm_parent_code, bd_number, us_id, cm_content, cm_guest_nickname, cm_guest_pw)
SELECT sequence_cm_code.NEXTVAL, cm_parent_code, bd_number, us_id, cm_content, cm_guest_nickname, cm_guest_pw FROM comment_table;

COMMIT;

-- 전체 데이터 조회 및 삭제
SELECT COUNT(*) FROM comment_table;
DELETE FROM comment_table;


	SELECT
		pd_number, cg_code, pd_name, pd_price, pd_discount, pd_company, pd_content, pd_image_folder, pd_image, pd_amount, pd_buy_status, pd_register_date, pd_update_date
	FROM 
		product_table 
	WHERE 
		pd_number = 1;
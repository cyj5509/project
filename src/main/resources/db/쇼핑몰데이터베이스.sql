-- 갠플 테이블 다시 구성(실습예제 기반)

/*
-- 계정 생성 및 권한 부여
CREATE USER devday IDENTIFIED BY dd;
GRANT RESOURCE, CONNECT TO devday;

COMMIT;
*/

-- 1. 사용자 테이블 ─ 회원가입을 포함한 회원관리(비회원 포함)
-- DROP TABLE member_tbl;
DROP TABLE user_tbl;
CREATE TABLE user_tbl (
    us_id            VARCHAR2(15),                        -- 회원 아이디
    us_pw            VARCHAR2(60)               NOT NULL, -- 회원 비밀번호
    us_name          VARCHAR2(30)               NOT NULL, -- 회원 이름
    us_email         VARCHAR2(50)               NOT NULL, -- 회원 이메일 
    us_phone         VARCHAR2(15)               NOT NULL, -- 회원 전화번호
    us_postcode      CHAR(5)                    NOT NULL, -- 회원 우편번호
    us_addr_basic    VARCHAR2(100)              NOT NULL, -- 회원 기본주소
    us_addr_detail   VARCHAR2(100)              NOT NULL, -- 회원 상세주소
    us_point         NUMBER  DEFAULT   0        NOT NULL, -- 회원 포인트
    us_join_date     DATE    DEFAULT   sysdate  NOT NULL, -- 회원 가입일자
    us_update_date   DATE    DEFAULT   sysdate  NOT NULL, -- 회원 수정일자
    us_last_login    DATE    DEFAULT   sysdate  NOT NULL, -- 회원 접속일자
    us_status        NUMBER  DEFAULT   0        NOT NULL, -- 회원 상태(관리자: 1, 사용자: 0)
    CONSTRAINT user_pk PRIMARY KEY(us_id)
);

-- 다른 PK 설정 방법
-- ALTER TABLE user_tbl ADD CONSTRAINT user_pk PRIMARY KEY (user_id);

-- 관리자 계정 활성화
INSERT INTO
    user_tbl (us_id, us_pw, us_name, us_email, us_phone, us_postcode, us_addr_basic, us_addr_detail, us_point, us_joindate, us_updatedate, us_lastlogin, us_status) 
VALUES 
    ('admin', '1234', 'admin', 'admin', 'admin', 'admin', 'admin', 'admin', 9999999, sysdate, sysdate, sysdate, 1);

UPDATE user_tbl SET us_status = 1 WHERE us_id = 'admin';

COMMIT;

-- 전체 데이터 조회 및 삭제
SELECT * FROM user_tbl;
DELETE FROM user_tbl;



-- 2. 관리자 테이블: 회원관리, 상품관리, 주문관리 등
DROP TABLE admin_tbl;
CREATE TABLE admin_tbl (
    ad_id          VARCHAR2(15),                          -- 관리자 아이디
    ad_pw          VARCHAR2(60)                NOT NULL,  -- 관리자 비밀번호
    ad_last_login   DATE    DEFAULT   sysdate   NOT NULL, -- 관리자 접속일자
    CONSTRAINT admin_pk PRIMARY KEY(ad_id)
);

-- 관리자 계정 활성화
INSERT INTO admin_tbl VALUES('admin', '$2a$10$dQFCMr0udCI865eG6SoIcOaNr3Y/dgBX.R4qf6rX5KA3jciSnnNjG', sysdate);

COMMIT;

-- 전체 데이터 조회 및 삭제
SELECT * FROM admin_tbl;
DELETE FROM admin_tbl;



-- 3. 카테고리 테이블
DROP TABLE category_tbl;
CREATE TABLE category_tbl(
    cg_code         NUMBER         CONSTRAINT category_pk PRIMARY KEY, -- 하위 카테고리 코드(2차 이후)
    cg_parent_code  NUMBER         NULL,        -- 상위 카테고리 코드(1차)
    cg_name         VARCHAR2(50)   NOT NULL,    -- 카테고리 이름(범주)
    FOREIGN KEY(cg_parent_code) REFERENCES category_tbl(cg_code)
);

-- 1차 카테고리 : IT 일반(1), 컴퓨터 공학(2), 웹 프로그래밍(3), 프로그래밍 언어(4), 모바일 프로그래밍(5) 데이터베이스(6), 자격증/수험서(7)
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name) 
    VALUES (1, NULL, 'IT 일반');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name) 
    VALUES (2, NULL, '컴퓨터 공학');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name) 
    VALUES (3, NULL, '웹 프로그래밍');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name) 
    VALUES (4, NULL, '프로그래밍 언어');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name) 
    VALUES (5, NULL, '모바일 프로그래밍');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name) 
    VALUES (6, NULL, '데이터베이스');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name) 
    VALUES (7, NULL, '자격증&#47;수험서');

-- 1차 카테고리(1): IT 일반
-- 2차 카테고리: IT 일반서, IT 교양서/에세이, 개발 방법론
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name) 
    VALUES (8, 1, 'IT 일반서');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name) 
VALUES (9, 1, 'IT 교양서&#47;에세이');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name) 
VALUES (10, 1, '개발 방법론');

-- 1차 카테고리(2): 컴퓨터 공학
-- 2차 카테고리: 컴퓨터 공학 일반, 컴퓨터 구조, 소프트웨어 공학, 운영체제론, 데이터 통신, 자료구조/알고리즘
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name) 
    VALUES (11, 2, '컴퓨터 공학 일반');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name) 
    VALUES (12, 2, '컴퓨터 구조');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name) 
    VALUES (13, 2, '소프트웨어 공학');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name) 
    VALUES (14, 2, '운영체제');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name) 
    VALUES (15, 2, '데이터 통신');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name) 
    VALUES (16, 2, '자료구조&#47;알고리즘');

-- 1차 카테고리(3): 웹 프로그래밍
-- 2차 카테고리: 웹 프로그래밍 일반, HTML/CSS, JavaScript
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (17, 3, '웹 프로그래밍 일반');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (18, 3, 'HTML&#47;CSS');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (19, 3, 'JavaScript');    
    
-- 1차 카테고리(4): 프로그래밍 언어
-- 2차 카테고리: 프로그래밍 언어 일반, Java, Python, C, C++, C#
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (20, 4, '프로그래밍 언어 일반');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (21, 4, 'Java');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (22, 4, 'Python');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (23, 4, 'C'); 
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (24, 4, 'C&#43;&#43;');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (25, 4, 'C&#35;');
    
-- 1차 카테고리(5): 모바일 프로그래밍
-- 2차카테고리: 모바일 프로그래밍 일반, 안드로이드, 아이폰/아이패드
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (26, 5, '모바일 프로그래밍 일반');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (27, 5, '안드로이드');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (28, 5, '아이폰&#47;아이패드');     
   
-- 1차 카테고리(6): 데이터베이스
-- 2차 카테고리: 데이터베이스 일반, Oracle, MySQL
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (29, 6, '데이터베이스 일반'); 
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (30, 6, 'Oracle');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (31, 6, 'MySQL');

    
-- 1차 카테고리(7):  자격증/수험서
-- 2차 카테고리: 사무 자동화, 정보 처리, 정보 보안, 네트워크, 그래픽/디자인, 기타 자격증
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (32, 7, '사무 자동화 ');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (33, 7, '정보 처리');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (34, 7, '정보 보안');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (35, 7, '네트워크');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (36, 7, '그래픽&#47;디자인');
INSERT INTO category_tbl (cg_code, cg_parent_code, cg_name)
    VALUES (37, 7, '기타 자격증');

COMMIT;

-- 전체 데이터 조회 및 삭제
SELECT * FROM category_tbl;
DELETE FROM category_tbl;

-- 1차 카테고리 출력
SELECT cg_code, cg_parent_code, cg_name FROM category_tbl WHERE cg_parent_code IS NULL;

-- 2차 카테고리 출력
SELECT * FROM category_tbl WHERE cg_parent_code IS NOT NULL;

-- 1차 카테고리의 2차 카테고리 출력.
-- SELECT cg_parent_code, cg_code, cg_name FROM category_tbl WHERE cg_parent_code = ?;

-- 2차 카테고리의 1차 카테고리 출력
-- SELECT cg_code, cg_parent_code, cg_name FROM category_tbl where cg_code = ?;



-- 4. 상품 테이블
DROP TABLE product_tbl;
CREATE TABLE product_tbl(
    pd_number            NUMBER CONSTRAINT product_pk PRIMARY KEY, -- 상품 번호
    cg_code              NUMBER                NULL,               -- 카테고리 코드(2차 이후)
    pd_name              VARCHAR2(50)          NOT NULL,           -- 상품 이름
    pd_price             NUMBER                NOT NULL,           -- 상품 가격
    pd_discount          NUMBER                NOT NULL,           -- 상품 할인율
    pd_company           VARCHAR2(50)          NOT NULL,           -- 상품 제조사(또는 출판사)
    pd_content           VARCHAR2(4000)        NOT NULL,           -- 상품 상세 내용
    pd_img_folder        VARCHAR2(50)          NOT NULL,           -- 상품 이미지 폴더명
    pd_img               VARCHAR2(100)         NOT NULL,           -- 상품 이미지
    pd_amount            NUMBER                NOT NULL,           -- 상품 수량
    pd_buy_status        CHAR(1)               NOT NULL,           -- 판매 여부
    pd_register_date     DATE DEFAULT sysdate  NOT NULL,           -- 등록일자
    pd_update_date       DATE DEFAULT sysdate  NOT NULL,           -- 수정일자
    FOREIGN KEY(cg_code) REFERENCES category_tbl(cg_code)
);

-- 상품 테이블의 상품번호 컬럼(prd_number)에 사용
CREATE SEQUENCE product_seq;

COMMIT;

-- 전체 데이터 조회 및 삭제
SELECT * FROM product_tbl;
DELETE FROM product_tbl;



-- 5. 장바구니 테이블
DROP TABLE cart_tbl;
CREATE TABLE cart_tbl(
    ct_code     NUMBER,                 -- 장바구니 코드
    pd_number     NUMBER      NOT NULL, -- 상품 번호
    us_id        VARCHAR2(15) NOT NULL, -- 회원 아이디
    ct_amount   NUMBER        NOT NULL, -- 장바구니 수량
    FOREIGN KEY(pd_number) REFERENCES product_tbl(pd_number),
    FOREIGN KEY(us_id) REFERENCES mbsp_tbl(us_id),
    CONSTRAINT cart_pk PRIMARY KEY(ct_code) 
);

-- 장바구니 테이블의 카테고리 코드 컬럼(ct_code)에 사용
CREATE SEQUENCE cart_seq;

COMMIT;

-- 전체 데이터 조회 및 삭제
SELECT * FROM cart_tbl;
DELETE FROM cart_tbl;


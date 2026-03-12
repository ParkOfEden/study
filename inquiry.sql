-- 테이블 존재유무 확인
SELECT * FROM inquiry;
SELECT * FROM inquiry_sql;

-- 기존 테이블 삭제 (필요 시)
-- DROP TABLE inquiry;
-- DROP SEQUENCE inquiry_seq;

CREATE TABLE inquiry (
    id NUMBER PRIMARY KEY,              -- 게시글 번호
    category VARCHAR2(50),              -- 카테고리
    email VARCHAR2(100),                -- 사용자 이메일
    title VARCHAR2(200),                -- 문의 제목
    content VARCHAR2(1000),             -- 문의 내용
    status NUMBER DEFAULT 0,            -- 0: 답변대기, 1: 답변완료
    regdate DATE DEFAULT SYSDATE        -- 등록일
);

CREATE SEQUENCE inquiry_seq;






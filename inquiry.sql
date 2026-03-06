CREATE TABLE inquiry (
    id NUMBER PRIMARY KEY,
    category VARCHAR2(50),
    email VARCHAR2(100),
    title VARCHAR2(200),
    content VARCHAR2(1000),
    regdate DATE DEFAULT SYSDATE
);

CREATE SEQUENCE inquiry_seq;
ALTER TABLE inquiry ADD answer VARCHAR2(1000);
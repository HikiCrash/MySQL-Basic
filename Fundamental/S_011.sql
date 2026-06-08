CREATE DATABASE Scriptdba;
use scriptdba;

-- s_student 테이블이 존재하면 삭제
DROP TABLE IF EXISTS s_student;

CREATE TABLE s_student (
	sNo CHAR(5) PRIMARY KEY,
    sName VARCHAR(20) NOT NULL,
    sAddr VARCHAR(50),
    sCellPhone VARCHAR(17) 
);

-- 변수에 학생 정보 저장 (학생 1)
SET @sNo = 'S0001';
SET @sName = '김창수';
SET @sAddr = '인천시';
SET @sCellPhone = '01023419000';

-- 변수 값을 이용해 학생 1명 삽입
INSERT INTO s_student (sNo, sName, sAddr, sCellPhone)
VALUES (@sNo, @sName, @sAddr, @sCellPhone);

SELECT * FROM s_student;

SET @sNo = 'S0002';
SET @sName = '이민정';
SET @sAddr = '인천시';
SET @sCellPhone = '01034521211';

INSERT INTO s_student (sNo, sName, sAddr, sCellPhone)
VALUES (@sNo, @sName, @sAddr, @sCellPhone);

SELECT * FROM s_student;

SET @sNo = 'S0003';
SET @sName = '김은희';
SET @sAddr = '서울시';
SET @sCellPhone = '01090001000';

INSERT INTO s_student (sNo, sName, sAddr, sCellPhone)
VALUES (@sNo, @sName, @sAddr, @sCellPhone);

SELECT * FROM s_student;

-- 특정 전화번호를 변수에 저장
SET @sCellPhone = '01090001000';

-- 해당 전화번호를 가진 학생 조회
SELECT sName, sCellPhone FROM s_student
WHERE sCellPhone = @sCellPhone;

SET @sNo = 'S0002';
SET @sAddr = '부천시';


UPDATE s_student
SET sAddr = @sAddr 
WHERE sNo = @sNo;
-- 해당 학생 번호의 주소 변경

SELECT * FROM s_student
WHERE sNo = @sNo;

SET @sNo = 'S0001';

DELETE FROM s_student
WHERE sNO = @sNO;
-- 해당 학생 번호의 학생을 삭제

SELECT * FROM s_student
WHERE sNo = @sNo;

CREATE TABLE product (
	id CHAR(8) NOT NULL,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2),
    quantity INT DEFAULT 0,
    PRIMARY KEY (id)
);

CREATE TABLE product (
	id CHAR(8) NOT NULL,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2),
    quantity INT DEFAULT 0
);

INSERT INTO product VALUES
('ep000001', '갤럭시 S25울트라', 1182690, 20),
('ep000002', '아이폰 17 프로', 17900000, 10);

SELECT * FROM product;

DELIMITER //
-- 상품을 추가하는 저장 프로시저 생성
CREATE PROCEDURE usp_insert_product(
	IN p_id CHAR(8),
    IN p_name VARCHAR(100),
    IN p_price DECIMAL(10, 2),
    IN p_quantity INT
)
BEGIN
-- product 테이블에 데이터 삽입
	INSERT INTO product (id, name, price, quantity)
    VALUES (p_id, p_name, p_price, p_quantity);
END //
DELIMITER ;

-- 프로시저 호출
CALL usp_insert_product('ep000003', '구글 픽셀 10a', 660000, 1);

SELECT * FROM product;

CALL usp_insert_product('ac000001', '구찌 [리본즈] 브랙 알리 스몰 크로스백', 441542, 3);
CALL usp_insert_product('ac000002', '여성 나이키 P-6000 FV6603-101', 90759, 5);
CALL usp_insert_product('ac000003', '듀오 캔버스 토트백 II 3913', 34319, 2);
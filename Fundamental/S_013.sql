use scriptdba;

CREATE TABLE users (
	user_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL
);

CREATE TABLE orders (
	order_id INT PRIMARY KEY,
    user_id INT,
    product_name VARCHAR(100),
    price DECIMAL(15, 2), -- 최대 15자리, 소수점 2자리까지 저장
    order_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    -- users 테이블과 외래키 연결
);

INSERT INTO users VALUES (1, '박인서', 'ispark@gmail.com', '서울시 강남구');
INSERT INTO users VALUES (2, '방민경', 'mkb@naver.com', '인천시 연수구');

SELECT * FROM users;

INSERT INTO orders VALUES(101, 1, '최신형 노트북', 1500000, '2026-03-10');
INSERT INTO orders VALUES(102, 1, '무선 마우스', 35000, '2026-04-12');
INSERT INTO orders VALUES(103, 2, '기계식 키보드', 120000, '2026-01-02');

SELECT * FROM orders;

-- 사용자와 주문 정보를 합친 뷰(View) 생성
CREATE VIEW v_order_details AS
SELECT
	u.name AS customer_name,
    o.product_name,
    o.price,
    o.order_date
FROM users u
JOIN orders o ON u.user_id = o.user_id;

SELECT * FROM v_order_details;

SELECT * FROM v_order_details
WHERE customer_name = '방민경';

-- 기존 뷰를 수정하여 이메일 컬럼 추가
CREATE OR REPLACE VIEW v_order_details AS
SELECT
	u.name AS customer_name,
    u.email, -- 추가된 컬럼
    o.product_name,
    o.price,
    o.order_date
FROM users u
JOIN orders o ON u.user_id = o.user_id;

SELECT * FROM v_order_details;

SET SQL_SAFE_UPDATES = 0;

-- 뷰를 통해 원본 테이블의 데이터 수정
UPDATE v_order_details
SET price = 36500
WHERE product_name = '무선 마우스';

DROP VIEW v_order_details;

CREATE TABLE books (
	book_id INT PRIMARY KEY, -- 이 부분이 클러스터형 인덱스가 됩니다!
    title VARCHAR(100),
    author VARCHAR(50),
    published_date DATE
);

INSERT INTO books VALUES (3, '인생을 위한 최소한의 생각', '신영준', '2026-02-25');
INSERT INTO books VALUES (1, '앨빈 토플러 청소년 부의 미래', '앨빈토플러', '2023-05-31');
INSERT INTO books VALUES (2, '된다! 하루 만에 끝내는 제미나이 활용법', '권서림', '2025-11-17');

SELECT * FROM books;

-- title 컬럼에 보조 인덱스 생성
CREATE INDEX idx_book_title ON books(title);

SHOW INDEX FROM books;

DROP INDEX idx_book_title ON books;

use class_a;

SELECT * FROM division;
SELECT * FROM employee;

-- 트랜잭션 시작
START TRANSACTION;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM division;
DELETE FROM employee;

-- 트랜잭션 취소
ROLLBACK;

SELECT * FROM division;
SELECT * FROM employee;

-- 테이블이 이미 있으면 삭제
DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
	id INT PRIMARY KEY,
    item_name VARCHAR(50),
    price DECIMAL(10, 2)
);

SELECT * FROM orders;

START TRANSACTION;

INSERT INTO orders (id, item_name, price) VALUES (1, '노트북', 1560000);

-- 저장 지점 생성
SAVEPOINT point1;

SELECT * FROM orders;

INSERT INTO orders (id, item_name, price) VALUES (2, '마우스', 24000);

-- 두 번째 저장 지점 생성
SAVEPOINT point2;

SELECT * FROM orders;

-- 잘못된 상품 입력
INSERT INTO orders (id, item_name, price) VALUES (3, '키보드', 500);

SELECT * FROM orders;

ROLLBACK TO point2;

SELECT * FROM orders;

-- 최종 확정
COMMIT;

SELECT * FROM orders;
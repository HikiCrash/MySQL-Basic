use class_a;

CREATE TABLE course (
	course_code VARCHAR(10) PRIMARY KEY,
    room_location VARCHAR(50)
);

CREATE TABLE enrollment (
	student_id INT,
    course_code VARCHAR(10),
    grade VARCHAR(2),
    PRIMARY KEY (student_id, course_code), -- 복합 기본키
    FOREIGN KEY (course_code) REFERENCES course(course_code)
    -- 강의 코드를 course 테이블의 course_code와 연결
);

INSERT INTO course VALUES ('CS101', '공학관 101호'), ('MATH201', '이학관 305호');

SELECT * FROM course;

INSERT INTO enrollment VALUES
(202401, 'CS101', 'A'),
(202401, 'MATH201', 'B'),
(202402, 'CS101', 'A+');

SELECT * FROM enrollment;


CREATE TABLE Rating (
	grade VARCHAR(10) PRIMARY KEY,
    discount_rate INT NOT NULL
);

CREATE TABLE Customer (
	customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    grade VARCHAR(10),
    FOREIGN KEY (grade) REFERENCES Rating(grade)
    -- 회원 등급을 Rating 테이블과 연결
);

CREATE TABLE Orders2 (
	order_id INT PRIMARY KEY,
    customer_id VARCHAR(20),
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP, -- 기본값 현재 시간
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
    -- 고객 정보를 Customer 테이블과 연결
);

INSERT INTO Rating VALUES ('VIP', 10), ('일반', 0);

SELECT * FROM Rating;

INSERT INTO Customer VALUES
('user1', '아사노프아타이', 'VIP'),
('user2', '배예은', 'VIP'),
('user3', '문정수', '일반');

SELECT * FROM Customer;

INSERT INTO Orders2 (order_id, customer_id) VALUES
('101', 'user1'),
('102', 'user2'),
('103', 'user1');

SELECT * FROM Orders2;

-- 고객 이름, 주문 번호, 주문 일시를 조회
-- Customer와 Orders2 테이블을 INNER JOIN으로 연결
SELECT a.customer_name, b.order_id, b.order_date 
FROM Customer a
INNER JOIN Orders2 b
ON a.customer_id = b.customer_id; -- customer_id가 같은 데이터끼리 매칭해서 결합
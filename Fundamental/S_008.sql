use class_a;

CREATE TABLE Members (
	id INT AUTO_INCREMENT PRIMARY KEY,
    age INT CHECK (age >= 19), -- 나이는 19세 이상이어야 함.
	email VARCHAR(255)
);

INSERT INTO Members(age, email) VALUES(20, "cskim@naver.com");
-- INSERT INTO Members(age, email) VALUES(17, "hslee@gmail.com"); 
-- 나이 제한으로 인한 에러.

CREATE TABLE Orders (
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE NOT NULL,
    delivery_date DATE NOT NULL,
    quantity INT NOT NULL,
    status VARCHAR(20),
    
    CONSTRAINT chk_quantity CHECK (quantity >= 1), -- 수량은 1개 이상.
    CONSTRAINT chk_delivery_date CHECK (delivery_date >= order_date), -- 배송일은 주문일과 같거나 커야함.
    CONSTRAINT chk_status CHECK (status IN ('READY', 'SHIPPING', 'DELIVERED',
		'CANCELLED')) -- 주문 상태는 지정된 값만 허용
);

-- 수량이 0이므로 에러 발생.
-- INSERT INTO Orders (order_date, delivery_date, quantity, status)
-- VALUES ('2026-02-21', '2026-02-22', 0, 'READY');

-- 배송일이 주문일보다 빨라서 에러 발생! (chk_delivery_date 위반)
-- INSERT INTO Orders (order_date, delivery_date, quantity, status)
-- VALUES ('2026-02-21', '2026-02-20', 1, 'READY');

-- 기본 값(default 지정)
CREATE TABLE default_orders (
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    order_status VARCHAR(20) DEFAULT 'PENDING',
    priority TINYINT DEFAULT 0,
    ordered_at DATETIME DEFAULT NOW() -- 현재 시각
);

INSERT INTO default_orders (product_name)
VALUES ('iphone 15');

SELECT * FROM default_orders;

CREATE TABLE noOptBUSEO (
	buseocode CHAR(4),
    buseoname VARCHAR(16),
    CONSTRAINT pk_no0ptBuseo_buseocode PRIMARY KEY(buseocode) -- 부서 코드 기본키
);

CREATE TABLE noOptSAWON (
	sawon_num INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(14),
    buseocode CHAR(4),
    CONSTRAINT pk_noOptSAWON_buseocode FOREIGN KEY(buseocode) REFERENCES
    noOptBUSEO(buseocode) -- 부서 코드 외래키 설정
);

-- INSERT INTO noOptSAWON(name, buseocode) VALUES('홍길동', '1111');
-- 존재하지 않느 부서 코드 오류

INSERT INTO noOptBUSEO VALUES ('1111', '개발부'); -- 부서 코드 추가
INSERT INTO noOptSAWON(name, buseocode) VALUES('홍길동', '1111');

CREATE TABLE cascadeDepartments (
	dept_code CHAR(4),
    dept_name VARCHAR(16),
    CONSTRAINT pk_cascadeDepartments_dept_code PRIMARY KEY(dept_code) -- 부서 코드 기본키.
);

CREATE TABLE cascadeEmployees (
	emp_num INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(14),
    dept_code CHAR(4),
    CONSTRAINT fk_cascadeEmployees_dept_code FOREIGN KEY(dept_code) REFERENCES
    cascadeDepartments(dept_code)
    ON DELETE CASCADE
    ON UPDATE CASCADE -- 외래키 설정 및 CASCADE 옵션 적용
);

INSERT INTO cascadeDepartments VALUES('1111', 'Sales');
INSERT INTO cascadeDepartments VALUES('1112', 'Production');
INSERT INTO cascadeDepartments VALUES('1113', 'Marketing');
INSERT INTO cascadeDepartments VALUES('1114', 'Human Resources');

INSERT INTO cascadeEmployees(emp_name, dept_code) VALUES('김창수', '1112');
INSERT INTO cascadeEmployees(emp_name, dept_code) VALUES('이선우', '1112');
INSERT INTO cascadeEmployees(emp_name, dept_code) VALUES('김은희', '1113');

SELECT * FROM cascadeDepartments;
SELECT * FROM cascadeEmployees;

-- 1113 부서 삭제, 해당 부서 사원도 삭제됨
DELETE FROM cascadeDepartments WHERE dept_code = '1113';
SELECT * FROM cascadeEmployees;

INSERT INTO cascadeEmployees(emp_name, dept_code) VALUES('이가은', '1111');
SELECT * FROM cascadeEmployees;

-- 1111 부서 코드를 2222로 교체
UPDATE cascadeDepartments SET dept_code = '2222'
WHERE dept_code = '1111';

SELECT * FROM cascadeEmployees;
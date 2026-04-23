use class_a;

CREATE TABLE division (
	division_code char(4) PRIMARY KEY,
    division_name varchar(30)
);

CREATE TABLE employee (
	emp_no int AUTO_INCREMENT PRIMARY KEY, -- 자동 증가.
    emp_name varchar(30),
    division_code char(4), 
    emp_position varchar(30)
);

INSERT INTO division (division_code, division_name) VALUES
	('1111', '개발부'),
    ('1112', '영업부'),
    ('1113', '홍보부'),
    ('1114', '경영지원부');
    
SELECT * FROM division;

INSERT INTO employee (emp_name, division_code, emp_position) VALUES
('홍길동', '1111', '사원'), ('이기자', '1111', '과장'), ('최천식', '1112', '부장'),
('강감찬', '1112', '대리'), ('이아름', '1113', '부장'), ('김소연', '1113', '차장');

SELECT * FROM employee;

SELECT a.division_name, b.emp_name, b.emp_position
FROM division a
INNER JOIN employee b
 ON a.division_code = b.division_code
WHERE a.division_code = '1112';
-- INNER JOIN은 교집합, 부서 코드가 일치하는 데이터만 조회, 1112에 해당하는 직원 조회

SELECT *
FROM division a
LEFT OUTER JOIN employee b
	ON a.division_code = b.division_code;
-- 왼쪽은 전부 포함, 오른쪽은 일치하는 것만. 없으면 NULL.
    
SELECT *
FROM employee a
RIGHT OUTER JOIN division b
	ON a.division_code = b.division_code;
-- 오른쪽은 전부 포함, 왼쪽은 일치하는 것만. 없으면 NULL
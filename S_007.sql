use class_a;

SELECT JSON_ARRAYAGG(
	JSON_OBJECT(
    'department', department,
    'student_number', student_number,
    'name', name,
    'grade', grade,
    'cell_phone', cell_phone,
    'email', email
    )
)
INTO OUTFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dbstudent.json'
FROM dbstudent
-- dbstudent 데이터를 JSON 배열 형태로 만들어 파일로 저장

CREATE TABLE info_employees (
	emp_num char(9) PRIMARY KEY,
    emp_name varchar(14)
    );
    
CREATE TABLE info_employees2 (
	emp_num char(9),
    emp_name varchar(14),
    CONSTRAINT pk_into_employees PRIMARY KEY(emp_num) -- 제약조건 이름 지정
    );
    
CREATE TABLE const_students (
	s_jumin_number char(14),
    s_name varchar(14),
    CONSTRAINT uni_s_jumin_number UNIQUE(s_jumin_number) -- 중복 금지
    );
    
INSERT INTO const_students VALUE('11111111111111', '김창수');
SELECT * FROM const_students;

INSERT INTO const_students VALUE('11111111111111', '이한우');
-- 중복 데이터로 에러

INSERT INTO const_students VALUE(NULL, '김종혁');
-- UNIQUE는 NULL 가능
 
SELECT * FROM const_students
WHERE s_jumin_number IS NULL
-- NULL 데이터 조회

INSERT INTO const_students VALUE(NULL, '최여진');
-- 가능, NULL은 서로 다른 값 취급

CREATE TABLE primary_students(
	s_jumin_number char(14),
    s_name varchar(14),
    CONSTRAINT pk_s_jumin_number PRIMARY KEY(s_jumin_number)
    );
    
INSERT INTO primary_students VALUES('890413-1712343', '김재현');
SELECT * FROM primary_students;

INSERT INTO primary_students VALUES('890413-1712343', '김다영');
-- 중복 값 에러

INSERT INTO primary_students VALUES(NULL, '김성일');
-- NULL 허용 금지 에러

CREATE TABLE auto_employees (
-- 	id 칼럼이 자동으로 1, 2, 3... 늘어나며 기본 키 역할을 함
	emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    hire_date DATE
    );
    
INSERT INTO auto_employees (emp_name, hire_date) VALUES ('박진희', '2024-01-01');
INSERT INTO auto_employees (emp_name, hire_date) VALUES ('김경아', '2025-02-03');
-- 기본 값과 자동 증가 조합

SELECT * FROM auto_employees;
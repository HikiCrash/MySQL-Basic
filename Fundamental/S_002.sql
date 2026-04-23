use class_a;

SELECT * FROM dbstudent
WHERE cell_phone IS NULL; -- 전화번호가 NULL인 학생 조회

SELECT * FROM dbstudent ORDER BY grade desc;
-- 학년을 기준으로 내림차순, 기본값은 오름차순(asc)

SELECT grade AS 학년, count(*) as 학생수
FROM dbstudent
GROUP BY grade;
-- 학년별로 그룹을 나누고, 각 학생수 계산

CREATE TABLE dbstudent2 (
	department VARCHAR(50) NOT NULL,
	student_number CHAR(9) PRIMARY KEY, -- 길이 9 고정, 기본 값(중복 불가)
	name VARCHAR(20) NOT NULL,
	grade INT,
	cell_phone VARCHAR(20),
	email VARCHAR(50)
);

INSERT INTO dbstudent2 VALUES -- 한 행씩 데이터 삽입 (모든 컬럼 순서대로)
('정보통신공학과', '202633024', '김태우', 1, '010-2487-4727','qustkd@naver.com');
INSERT INTO dbstudent2 VALUES
('정보통신공학과', '202533027', '조은호', 2, '010-9048-0317','ehcho@hanmail.net');
INSERT INTO dbstudent2 VALUES
('정보통신공학과', '202433006', '황정하', 3, '010-3606-4256','jhh@naver.com');

SELECT * FROM dbstudent2;

INSERT INTO dbstudent2 (department, student_number, name, grade, email)
 VALUES ('컴퓨터정보공학과', '202533039', '최진영', 1, 'jychoi@naver.com');
INSERT INTO dbstudent2 (department, student_number, name, grade, email)
 VALUES ('정보통신공학과', '202533022', '김동주', 2, 'djkim@naver.com');
INSERT INTO dbstudent2 (department, student_number, name, grade, email)
 VALUES ('항공운항과', '202633038', '허준', 2, 'jh01@naver.com'); 
-- 특정 컬럼에 한 행씩 데이터 삽입 (생략 컬럼 -> 자동 NULL)
-- NOT NULL 컬럼 생략시 에러

INSERT INTO dbstudent2 (department, student_number, name, grade, cell_phone, email)
VALUES
('컴퓨터정보공학과', '202533033', '이상선', 2, '010-1487-4770', 'sslee@naver.com'),
('컴퓨터정보공학과', '202433026', '박주봉', 3, '010-0048-0312', 'kbpark@hanmail.net'),
('정보통신공학과', '202633007', '이지은', 1, '010-5606-4251', 'jelee@naver.com'),
('컴퓨터시스템공학과', '202433019', '박성수', 3, '110-x487-4722', 'sspark@naver.com'),
('디지털마케팅공학과', '202533012', '김아름', 2, '010-2048-0307', 'alkim@hanmail.net'),
('전기공학과', '202533002', '최진기', 2, '010-8606-4151', 'jkchoi@naver.com');
-- 여러 행 한 번에 삽입

CREATE TABLE dbstudent2_backup (
	department VARCHAR(50) NOT NULL,
	student_number CHAR(9) PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	grade INT,
	cell_phone VARCHAR(20),
	email VARCHAR(50)
 );

INSERT INTO dbstudent2_backup(department, student_number, name, grade, cell_phone)
SELECT department, student_number, name, grade, cell_phone
FROM dbstudent2
WHERE cell_phone IS NULL;
-- dbstudent2에서 전화번호가 NULL인 데이터만 골라서 백업 테이블에 삽입
-- 무조건 IS NULL 써야 함 (= NULL 금지)


SELECT * FROM dbstudent2_backup;
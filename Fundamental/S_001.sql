create database class_a; -- 데이터베이스 생성

use class_a; -- 사용 할 데이터베이스

CREATE TABLE dbstudent ( -- 테이블 생성
	department VARCHAR(50) NOT NULL, -- 문자열 최대50, NULL 불가
    student_number INT PRIMARY KEY, -- 정수형 중복 불가
    name VARCHAR(20) NOT NULL, -- 문자열 최대20, NULL 불가
    grade INT, -- 정수형
    cell_phone VARCHAR(20), -- 문자열 최대20
    email VARCHAR(50) -- 문자열 최대50
);
-- char는 고정길이 -> 남은 공간 공백으로 채움, varchar는 가변길이다

INSERT INTO dbstudent(department, student_number, name, grade, cell_phone, email)
VALUES -- dbstudent 테이블에 여러 명의 데이터를 삽입
('정보통신공학과', 202633024, '김태우', 1, '010-2487-4727', 'qustkd@naver.com'),
('컴퓨터정보공학과', 202533027, '조은호', 2, '010-9048-0317', 'ehcho@hanmail.net'),
('컴퓨터정보공학과', 202433006, '황정하', 3, '010-3606-4256', 'jhh@naver.com'),
('컴퓨터정보공학과', 202533039, '최진영', 1, NULL, 'jychoi@naver.com'),
('컴퓨터정보공학과', 202533033, '이상선', 2, '010-1487-4770', 'sslee@naver.com'),
('컴퓨터정보공학과', 202433026, '박주봉', 3, '010-0048-0312', 'kbpark@hanmail.net'),
('정보통신공학과', 202633007, '이지은', 1, '010-5606-4251', 'jelee@naver.com'),
('정보통신공학과', 202533022, '김동주', 2, NULL, 'djkim@naver.com'),
('컴퓨터시스템공학과', 202433019, '박성수', 3, '110-x487-4722', 'sspark@naver.com'),
('디지털마케팅공학과', 202533012, '김아름', 2, '010-2048-0307', 'alkim@hanmail.net'),
('전기공학과', 202533002, '최진기', 2, '010-8606-4151', 'jkchoi@naver.com'),
('항공운항과', 202633038, '허준', 2, NULL, 'jh01@naver.com');

SELECT * FROM dbstudent; -- dbstudent 테이블의 모든 데이터 조회

SELECT department, student_number, name FROM dbstudent;
-- 특정 컬럼만 조회

SELECT * FROM dbstudent
WHERE name LIKE '김%'; -- 김으로 시작하는 학생 조회

SELECT * FROM dbstudent
WHERE grade IN(1,3); -- 1 또는 3학년 학생 조회

SELECT * FROM dbstudent
WHERE grade !=2; -- 2학년이 아닌 학생 조회

SELECT * FROM dbstudent
WHERE grade IN(2); -- 2학년인 학생 조회

SELECT department AS 학과, student_number AS 학번, name AS 이름,
	grade AS 학년, cell_phone AS 전화번호, email AS 이메일
FROM dbstudent; -- 컬럼 이름을 별칭으로 바꿔서 출력, 원본 손상 x
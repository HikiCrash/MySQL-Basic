use class_a

CREATE TABLE user(
	user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE -- 중복 불가
    );
    
INSERT INTO user (name, email) VALUES ('김철수', 'chulsoo@gmail.com');
INSERT INTO user (name, email) VALUES ('이영희', 'younghee@outlook.com');
INSERT INTO user (name, email) VALUES ('박민수', 'minsoo@naver.com');

SELECT * FROM user;

ALTER TABLE user ADD phone VARCHAR(20); -- phone 컬럼 추가
ALTER TABLE user ADD gender CHAR(1) AFTER name; -- gendef 컬럼 추가

SELECT * FROM user;

ALTER TABLE user CHANGE phone phone_number VARCHAR(20); -- phone 컬럼을 phone_number로 변경
ALTER TABLE user CHANGE gender gender ENUM('M','F'); -- gender 컬럼을 ENUM 타입으로 변경

SELECT * FROM user;

INSERT INTO user (name, gender, email, phone_number) VALUES 
('김소연', 'F', 'sykim@naver.com', '010-7654-9000');

INSERT INTO user (name, email, phone_number) VALUES
('한석규', 'skhan@naver.com', '010-8765-1000');

TRUNCATE TABLE user;
-- 테이블 안에 데이터 전부 삭제.
-- DROP TABLE 테이블명 -> 테이블 자체 삭제 없을 시 에러
-- DROP TABLE IF EXISTS 테이블명 -> 테이블 있을 시 삭제

INSERT INTO user (name, email, phone_number) VALUES
('한석규', 'skhan@naver.com', '010-8765-1000');

SELECT * FROM user;

SELECT * FROM dbstudent
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dbstudent.csv'
FIELDS TERMINATED BY ',' -- 필드 구분자 : 쉼표
ENCLOSED BY '"' -- 값들을 따옴표로 감쌈
LINES TERMINATED BY '\n'; -- 줄 구분 : 줄 바꿈
-- dbsudent 데이터를 CSV 파일로 내보내기

SHOW VARIABLES LIKE 'secure_file_priv';
-- 파일 저장 경로 확인

SELECT JSON_OBJECT(
	'department', department,
    'student_number', student_number,
    'name', name,
    'grade', grade,
    'cell_phone', cell_phone,
    'email', email
)FROM dbstudent;
-- dbsudent 데이터를 JSON 형태로 변환해서 출력
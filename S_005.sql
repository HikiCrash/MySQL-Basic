use class_a;

SELECT * FROM division a
LEFT JOIN employee b
	ON a.division_code = b.division_code
UNION
SELECT * FROM division a
RIGHT JOIN employee b
	ON a.division_code = b.division_code;
-- LEFT, RIGHT룰 UNION으로 FULL OUTER JOIN 흉내.

CREATE TABLE division_self (
	emp_no char(5) PRIMARY KEY,
    emp_name varchar(30),
    division_code char(4),
    emp_position varchar(20),
    mgr_no char(5)
    );

INSERT INTO division_self(emp_no, emp_name, division_code, emp_position, mgr_no)
VALUES ('S0014', '홍길동', '1111', '사원', 'S0011'),
('S0012', '이기자', '1111', '과장', 'S0010'),
('Y0010', '최천식', '1112', '부장', 'Y0011'),
('Y0013', '강감찬', '1112', '대리', 'Y0011'),
('Z0010', '이아름', '1113', '부장', 'Z0010'),
('S0010', '김소연', '1111', '부장', 'S0010');
-- 상사 - 부하 관계 테이블

SELECT * FROM division_self;

SELECT b.emp_no as 사원번호, b.emp_name as 사원이름, a.emp_name as 매니저
FROM division_self a
JOIN division_self b
ON a.emp_no = b.mgr_no;
-- SELF JOIN으로 자기 자신이 상사가 되는 사원을 조회

SELECT * FROM division
CROSS JOIN employee;
-- CROSS JOIN으로 행끼리의 모든 경우의 수를 생성함.

SELECT count(*) FROM division
CROSS JOIN employee;
-- CROSS JOIN의 결과 행 수를 출력

SELECT a.emp_no, a.emp_name, b.division_name
FROM employee a
INNER JOIN division b 
ON a.division_code = b.division_code
WHERE b.division_name = '개발부';
-- 개발부에 속한 직원 조회

-- (1단계 개발부를 찾는다.)
SELECT division_code, division_name
FROM division
WHERE division_name = '개발부';

-- (2단계 개발부에 해당하는 직원을 찾는다.)
SELECT emp_no, emp_name
FROM employee
WHERE division_code = '1111';

SELECT emp_no, emp_name, division_code
FROM employee
WHERE division_code = (SELECT division_code FROM division WHERE
						division_code = '1111');
-- 실행 순서 : 서브 쿼리 -> 바깥 쿼리
                        
SELECT emp_no, emp_name, division_code
FROM employee
WHERE division_code = (SELECT division_code FROM division WHERE
						division_name = '개발부');
-- 개발부의 코드 번호를 찾음 -> 1111이 들어간 사원을 조회.
                        
SELECT a.division_code, a.division_name
FROM division a
LEFT JOIN employee b
ON a.division_code = b.division_code
WHERE b.division_code IS NULL;
-- LEFT JOIN + NULL 체크 : 직원이 없는 부서 찾기

SELECT DISTINCT division_code FROM employee;
-- 중복된 코드 제거 후 조회

SELECT division_code, division_name
FROM division
WHERE division_code
NOT IN('1111', '1112', '1113');
-- 1111, 1112, 1113이 포함되지 않은 부서 조회

SELECT division_code, division_name
FROM division
WHERE division_code
NOT IN(SELECT DISTINCT division_code FROM employee);
-- 직원이 존재하지 않는 부서 조회
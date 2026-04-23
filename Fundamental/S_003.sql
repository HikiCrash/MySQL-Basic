use class_a;

SELECT * FROM dbstudent;

UPDATE dbstudent
SET cell_phone = '010-3487-4722'
WHERE student_number = '202433019';
-- 특정 학번에 전화번호 새로운 값 수정

SELECT * FROM dbstudent2_backup;

UPDATE dbstudent2_backup
SET cell_phone = '전화번호입력필요'
WHERE cell_phone IS NULL;
-- NULL 값을 전화번호입력필요로 일괄 수정

SELECT * FROM dbstudent2;

DELETE FROM dbstudent2
WHERE grade = 3;
-- 3학년 학생 삭제

SET SQL_SAFE_UPDATES = 0; -- 안전모드 해제(삭제가능)

SET SQL_SAFE_UPDATES = 1; -- 안전모드 켜기
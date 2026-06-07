use class_a;

CREATE TABLE membership (
	member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    identification_number CHAR(14) UNIQUE,
    address VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL
    );
    
CREATE TABLE license (
	license_id CHAR(5) PRIMARY KEY,
    license VARCHAR(10) NOT NULL,
    member_id INT NOT NULL,
    acquisition_date DATE,
    CONSTRAINT fk_license_member_id FOREIGN KEY(member_id) references membership(member_id)
    -- 멤버 아이디를 외래키로 사용
);

INSERT INTO membership (name, identification_number, address, phone) VALUES
('김창수', '880111-1234567', '인천시', '01077771212'),
('이아름', '870912-1431222', '인천시', '01018972325'),
('김은하', '900321-2543111', '서울시', '01090873276');

SELECT * FROM membership;

-- 5번 회원은 존재하지 않아서 에러.
-- INSERT INTO license (license_id, license, member_id, acquisition_date) VALUES
-- ('ms001', 'mvp', 5, '2024-10-01');

INSERT INTO license (license_id, license, member_id, acquisition_date) VALUES
('ms001', 'mvp', 1, '2024-10-01');

SELECT * FROM license;

INSERT INTO license (license_id, license, member_id, acquisition_date) VALUES
('or001', 'oca', 1, '2023-03-09');
INSERT INTO license (license_id, license, member_id, acquisition_date) VALUES
('ms002', 'mct', 1, '2024-09-07');

INSERT INTO license (license_id, license, member_id, acquisition_date) VALUES
('ms003', 'mcp', 2, '2021-04-3');

SELECT * FROM license;

-- 멤버 정보와 자격증 정보를 조회
SELECT a.member_id, a.name, b.license_id, b.license FROM membership a
INNER JOIN license b
ON a.member_id = b.member_id;
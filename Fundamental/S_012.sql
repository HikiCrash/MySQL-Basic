use scriptdba;

-- 상품 ID로 상품을 조회하는 프로시저 생성
DELIMITER //

CREATE PROCEDURE usp_select_product (
	IN p_id CHAR(8)
)
BEGIN
	-- 입력받은 ID와 일치하는 상품 조회
	SELECT * FROM product
    WHERE id = p_id;
END //

-- 상품 조회
CALL usp_select_product('ep000003');
CALL usp_select_product('ac000003');


-- 상품명 일부를 검색하여 상품을 조회하는 프로시저 생성
DELIMITER //

CREATE PROCEDURE usp_select_product_byname(
	IN p_name VARCHAR(100)
)
BEGIN
	-- 상품명에 입력한 문자열이 포함된 상품 조회
	SELECT * FROM product
    WHERE name Like CONCAT('%', p_name, '%');
END //

CALL usp_select_product_byname('갤럭시');


-- 상품 수량을 수정하는 프로시저 생성
DELIMITER //

CREATE PROCEDURE usp_update_product_quantity (
	IN P_id CHAR(8),
	IN p_quantity INT
)
BEGIN
	-- 해당 상품의 수량 수정
	UPDATE product
    SET quantity = p_quantity
    WHERE id = p_id;
END //

SELECT * FROM product;

CALL usp_update_product_quantity('ac000003', 104);


-- 상품 ID로 상품을 삭제하는 프로시저 생성
DELIMITER //

CREATE PROCEDURE usp_delete_product_id (
	IN P_id CHAR(8)
)
BEGIN
	-- 해당 상품 삭제
	DELETE FROM product
    WHERE id = p_id;
END //

SELECT * FROM product;

CALL usp_delete_product_id('ep000001');


CREATE TABLE product_details (
	id CHAR(8) PRIMARY KEY,
    description TEXT, -- 상품 상세 설명
    -- product 테이블의 id를 참조하는 외래키
    CONSTRAINT fk_product_details_id
    FOREIGN KEY (id) REFERENCES product(id)
    -- 부모 데이터 삭제 시 자식 데이터도 함께 삭제
    ON DELETE CASCADE
);

INSERT INTO product_details VALUES ('ep000002', '아이폰 17 프로 A19 Pro 칩, 12GB 램, 전면 48MP 트리플 카메라');
INSERT INTO product_details VALUES ('ep000003', '텐서 G4칩셋, 플랫디자인, 위성 SOS 기능');
INSERT INTO product_details VALUES ('ac000001', '블랙 레더와 빈티지골드GG 로고');
INSERT INTO product_details VALUES ('ac000002', '통기성 좋은 메시와 가죽 레이어의 레트로 디자인');
INSERT INTO product_details VALUES ('ac000003', '크기 적당, 재질 좋음');

SELECT a.id, a.name, a.price, a.quantity, b.description FROM product a
INNER JOIN product_details b
ON a.id = b.id
WHERE a.id = 'ac000001';


-- 상품 정보와 상세 설명을 조인하여 조회하는 프로시저 생성
DELIMITER //

CREATE PROCEDURE usp_select_join_id (
	IN p_id CHAR(8)
)
BEGIN
	-- 상품 정보와 상세 설명을 조인하여 조회하는 프로시저 생성
	SELECT a.id, a.name, a.price, a.quantity, b.description FROM product a
	INNER JOIN product_details b
	ON a.id = b.id
	WHERE a.id = p_id;
END //

CALL usp_select_join_id('ac000001');
CALL usp_select_join_id('ac000002');
CALL usp_select_join_id('ac000003');


-- 상품명으로 상품 설명을 조회하는 서브쿼리 프로시저 생성
DELIMITER //

CREATE PROCEDURE usp_select_subquery_name (
    IN p_name VARCHAR(100)
)
BEGIN
	-- 상품명을 통해 ID를 찾고 해당 설명 조회
	SELECT id, description FROM product_details
    WHERE id = (SELECT id FROM product WHERE name like CONCAT('%', p_name, '%'));
END //

CALL usp_select_subquery_name('구찌');
CALL usp_select_subquery_name('나이키');
CALL usp_select_subquery_name('구글');


-- 중복 ID 예외처리가 포함된 상품 추가 프로시저 생성
DELIMITER //

CREATE PROCEDURE usp_add_product (
    IN p_id CHAR(8),
    IN p_name VARCHAR(100),
    IN p_price DECIMAL(10, 2),
    IN p_quantity INT
)
BEGIN
	-- 1. 중복 에러(SQLSTATE '23000' 또는 에러코드 1062) 발생 시 처리할 핸들러
    DECLARE EXIT HANDLER FOR 1062
    BEGIN
		SELECT '이미 존재하는 id입니다. 삽입을 취소합니다.' AS Message;
	END;
    -- 2. 데이터 삽입 시도
    INSERT INTO product (id, name, price, quantity)
    VALUES (p_id, p_name, p_price, p_quantity);
    
    SELECT '제품이 성공적으로 추가되었습니다.' AS Result;
END //

SELECT * FROM product;

-- 이미 존재하는 ID 사용 (중복 오류 발생)
CALL usp_add_product('ac000001', '벨트', 20000, 2);

-- 새로운 ID 사용 (정상 추가)
CALL usp_add_product('ac000004', '벨트', 20000, 2);
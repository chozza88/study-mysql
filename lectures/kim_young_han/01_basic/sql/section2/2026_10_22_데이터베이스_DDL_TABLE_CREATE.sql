-- DDL - 테이블 생성1

-- 쇼핑몰 요구사항
-- 고객
-- 고객 id, 이름, 이메일, 비밀번호, 주소, 가입 시각이 관리되어야 함.

-- 상품
-- 상품 id, 이름, 설명, 가격, 재고 수량이 관리되어야 한다. 

-- 주문
-- 주문 id, 주문 고객, 주문 상품, 주문 수량, 주문 시각, 주문 상태가 관리되어야 한다.
-- 주문이 등록되면 최초의 주문 상태는 주문접수 상태가 된다. 
-- 예제를 단순화 하기 위해 한 번의 주문 시에 한 종류의 상품만 주문할 수 있다. 한 종류의 상품을 여러 개 주문하는 것은 가능하다. 

CREATE TABLE customers(
	customer_id INT AUTO_INCREMENT PRIMARY KEY
    , name VARCHAR(50) NOT NULL
    , email VARCHAR(100) NOT NULL UNIQUE
    , password VARCHAR(255) NOT NULL
    , address VARCHAR(255) NOT NULL
    , join_date DATETIME DEFAULT CURRENT_TIMESTAMP
    
    -- 추가 학습: 소프트 삭제 후 동일 이메일 재가입 허용 
    -- 적용 시 email의 UNIQUE 제거, deleted_at과 active_email 활성화
    -- , update_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    -- , deleted_at DATETIME DEFAULT NULL
    -- , active_email VARCHAR(100)
	--		GENERATED ALWAYS AS (
    --			CASE
    --				WHEN deleted_at IS NULL THEN email
    --				ELSE NULL
    --			END
    --		)STORED
    -- , UNIQUE KEY uq_customers_active_email (active_email) 
);

CREATE TABLE products(
	product_id INT AUTO_INCREMENT PRIMARY KEY
    , name VARCHAR(100) NOT NULL
    , description TEXT
    , price INT NOT NULL
    , stock_quantity INT NOT NULL DEFAULT 0
);

CREATE TABLE orders (
	order_id INT AUTO_INCREMENT PRIMARY KEY
    , customer_id INT NOT NULL
    , product_id INT NOT NULL
    , quantity INT NOT NULL
    , order_date DATETIME DEFAULT CURRENT_TIMESTAMP
    , status VARCHAR(20) NOT NULL DEFAULT '주문접수'
	
	, CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    , CONSTRAINT fk_orders_products FOREIGN KEY (product_id) REFERENCES products(product_id)
);

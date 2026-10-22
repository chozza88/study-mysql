SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;

-- 고객명단의 이름과, 이메일 값들만 가르쳐달라는 요청
SELECT 
	name AS 고객명
    , email AS `진짜 이메일` 
    FROM customers;

-- 고객 중 이메일이 'yisunsin@example.com'인 회원의 비밀번호를 찾고 싶을 때의 정보
SELECT
	name AS 성명
	, password AS 비밀번호
FROM customers
WHERE email = 'yisunsin@example.com'; 

-- products 테이블에서 가격(price)이 10000원 이상인 상품만 조회해보자 
SELECT 
	*
FROM products 
WHERE price >= 10000;

-- 가격이 5000원 이상이면서, 재고가 50개 이상인 상품을 찾아주세요. 
SELECT 
	*
FROM products 
WHERE price >= 5000 
AND stock_quantity >= 50;

-- 가격이 20000원 이거나, 재고가 100개 이상인 상품을 찾아주세요. 
SELECT 
	* 
FROM products 
WHERE price >= 20000
OR stock_quantity >= 100;

-- 부정연산자(!, <>)
SELECT 
	*
FROM products
WHERE !(price >= 20000);

-- BETWEEN: 특정 범위에 있는 값 찾기
-- MD(상품기획자)가 우리에게 묻는다. "가격이 5,000원에서 15,000원 사이인 상품들만 모아서 보여주세요." 
SELECT 
	*
FROM products 
WHERE price BETWEEN 5000 AND 15000; -- BETWEEN a AND b 구문은 'a와 b 사이의 값(a,b 포함)'을 찾아준다. a에는 최솟값, b에는 최댓값을 넣는다. 

-- products 테이블에서 가격이 5000원 이상 15000원 이하인 상품 조회하기
SELECT 
	*
FROM products 
WHERE price BETWEEN 5000 AND 15000;

-- 다시 MD가 찾아왔다. "가격이 5,000원에서 15,000원 사이인 상품들은 특별 할인 행사 대상입니다. 이 상품드르을 제외한 나머지 모든 상품 목록을 보여주세요. 
SELECT 
	*
FROM products 
WHERE NOT price BETWEEN 5000 AND 15000;

-- products 테이블에서 이름이 '갤럭시', '아이폰', '에어팟' 중 하나인 상품 조회하기
SELECT 
	* 
FROM products
WHERE name IN('갤럭시', '아이폰', '에어팟');

-- 마케팅팀에서 다시 요청했다. "갤럭시, 아이폰, 에어팟은 행사 상품으로 지정했으니, 이 상품들을 제외한 나머지 상품들의 재고를 점검하고 싶습니다. 목록을 뽑아주세요."
SELECT 
	name AS `상품명`
    , stock_quantity AS 재고량
FROM products 
WHERE name NOT IN('갤럭시', '아이폰', '에어팟');

select 
	*
from customers
where email like 'sejong%';

-- 마케팅 팀에서 요청이 왔다. "서울특별시에 살지 않는 고객을 대상으로 마케팅을 하고 싶어요. 대상 고객 목록을 출력해 주세요" 
select 
	*
from customers 
where address not like '서울특별시%';


-- 최근에 가입한 고객 순서대로 명단을 뽑아주세요! 방금 가입한 사람이 맨 위에 보이게요 
desc customers;
select
	* 
from customers 
order by join_date desc;

-- products 테이블을 가격(price) 낮은순으로 정렬하기 
select 
	* 
from products 
order by price; 

-- 상품목록을 인단 재고 수량(stock_quantity)이 많은 순서대로 정렬해 주세요. 그런데 만약 재고 수량이 같다면, 그 상품들끼리는 가격(price)이 낮은 순서대로 정렬해주세요 
select 
	* 
from products 
order by stock_quantity desc, price asc;

-- products 테이블에서 가장 비싼 상품 2개만 조회하기 
select 
	*
from products 
order by price desc
limit 2;

-- OFFSET = (현재 페이지 - 1) * 페이지당 개수
-- 1페이지 가져오기
select
	*
from products 
limit 0, 2;

-- 2페이지 가져오기
select
	*
from products 
limit 2, 2;

-- 3페이지 가져오기
select
	*
from products 
limit 4, 2;

-- 주문한 고객만 확인하고 싶음. 
select
	distinct customer_id 
from orders;

-- 어떤 고객이 어떤 상품을 구매했는지 그 조합을 중복 없이 보고 싶음. 
select 
	distinct customer_id
    , product_id
from orders
order by customer_id, product_id;    

select 
	*
from products 
order by description desc;

select
	* 
from products
where description is not null;

-- description열을 오름차순으로 정렬하기 
select 
	product_id, name, description 
from products
order by description is null desc, description desc;
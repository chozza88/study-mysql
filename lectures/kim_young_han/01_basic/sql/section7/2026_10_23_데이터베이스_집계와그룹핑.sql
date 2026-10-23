CREATE TABLE order_stat(
	order_id INT PRIMARY KEY AUTO_INCREMENT
    , customer_name VARCHAR(50)
    , category VARCHAR(50)
    , product_name VARCHAR(100)
    , price INT 
    , quantity INT 
    , order_date DATE
);

INSERT INTO order_stat (customer_name, category, product_name, price, 
quantity, order_date) VALUES
('이순신', '전자기기', '프리미엄 기계식 키보드', 150000, 1, '2025-05-10'),
('세종대왕', '도서', 'SQL 마스터링', 35000, 2, '2025-05-10'),
('신사임당', '가구', '인체공학 사무용 의자', 250000, 1, '2025-05-11'),
('이순신', '전자기기', '고성능 게이밍 마우스', 80000, 1, '2025-05-12'),
('세종대왕', '전자기기', '4K 모니터', 450000, 1, '2025-05-12'),
('장영실', '도서', '파이썬 데이터 분석', 40000, 3, '2025-05-13'),
('이순신', '문구', '고급 만년필 세트', 200000, 1, '2025-05-14'),
('세종대왕', '가구', '높이조절 스탠딩 데스크', 320000, 1, '2025-05-15'),
('신사임당', '전자기기', '노이즈캔슬링 블루투스 이어폰', 180000, 1, '2025-05-15'),
('장영실', '전자기기', '보조배터리 20000mAh', 50000, 2, '2025-05-16'),
('홍길동', NULL, 'USB-C 허브', 65000, 1, '2025-05-17');

-- 집계 함수 
select 
	*
from order_stat;

-- 우리 쇼핑몰의 총 주문 건수는 몇 건인가? 
select 
	count(*) as `전체 주문 건수`
from order_stat;

-- 카테고리가 있는 주문 건수는 몇 건인가? 
select 
	count(category) as `카테고리 등록 건수`
from order_stat;

-- "지금까지의 총매출액은 얼마인가?" 
select 
	sum(price * quantity) as `총 매출액`
from order_stat;

-- "고객들은 한 번 주문할 때 평균적으로 얼마를 쓰는가? 
select 
	avg(price * quantity) as `평균 주문 금액`
from order_stat;

-- "총 판매 상품 수량과 주문당 편균 수량 분석하기"
select 
	sum(quantity) as `판매 총 갯수` 
    , avg(quantity) as `주문당 평균 수량`
from order_stat;

-- "우리 쇼핑몰에서 가장 비싸게 팔린 단일 상품의 가격은 얼마인가?, 또는 가장 오래된 주문은 언제였는가?"
desc order_stat;
select
	max(price) 
    , min(order_date)
from order_stat;

select 
	count(customer_name) as `총 주문 건수`
	, count(distinct customer_name) as `순수 고객 수`
from order_stat;


-- GROUP BY 
-- "카테고리별 주문 건수를 알려줘!", "카테고리별로 매출액이 얼마나 되는지 알려줘"
select
	category
    , count(*) as '카테고리별 주문 건수'
from order_stat
group by category;

-- "고객별로 총 몇 번이나 주문했을까?"
select 
	customer_name
    , count(*) as `주문 횟수` 
from order_stat
group by customer_name;

select 
	category
    , sum(price * quantity) 
from order_stat
group by category;

-- 이번에는 한 걸음 더 나아가, 고객별로 총 주문 횟수, 총 구매 수량, 그리고 총 구매 금액을 함께 계산해 보자. 이를 통해 어떤 고객이 우리 쇼핑몰의 진정한 VIP인지 찾아낼 수 있다.
select 
	customer_name
    , count(*) as `총 주문 횟수`
    , sum(quantity) as `총 구매 수량`
    , sum(price * quantity) as `총 구매 금액`
from order_stat
group by customer_name
order by `총 구매 금액` desc; 

-- 어떤 고객이(customer_name), 어떤 상품 카테고리에서(category) 얼마나 썼는지 그룹으로 묶어보자. 
select
	customer_name
    , category
    , sum(price * quantity) as `카테고리별 구매 금액` 
from order_stat 
group by customer_name, category
order by customer_name, `카테고리별 구매 금액` desc;


-- HAVING 
-- 우리 쇼핑몰의 카테고리별 실적은 알겠는데, 이 중에서 매출액이 50만 원을 넘는 핵심 카테고리만 따로 보고 싶음 
select 
	category
    , sum(price * quantity) as `카테고리별 총 매출`
from order_stat
group by category
having `카테고리별 총 매출` >= 500000;

-- 이번에는 다른 기준으로 그룹을 필터링해보자. '3회 이상 주문한' 충성 고객을 찾아보자. 이 또한 2단계로 나누어 생각하면 아주 간단하다.
select
	customer_name
    , count(*) 
from order_stat
group by customer_name
having count(*) >= 3;

-- 가격이 10만 원 이상인 고가 상품들 중에서만, 카테고리별로 묶었을 때, 그 고가 상품이 2건 이상 팔린 카테고리는 어디인가요? 
select 
	category
    , count(*)
from order_stat
where price >= 100000
group by category
having count(*) >= 2;

-- 2025년 5월 14일 이전에 들어온 주문들 중에서, 고객별로 그룹화하여, 주문 건수가 2회 이상인 고객을 찾아서, 해당 고객의 이름과 총 구매 금앨을 조회하고, 
-- 총 구매 금액을 기준으로 내림차순 정렬해라. 그리고 하나의 데이터만 출력해라. 
select 
	customer_name
    , sum(price * quantity) as total_purchase
from order_stat
where order_date < '2025-05-14'
group by customer_name
having count(*) >= 2
order by sum(price * quantity) desc
limit 1; 
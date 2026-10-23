-- 문제1 
-- order_stat 테이블을 사용하여 쇼핑몰의 전체 주문 건수와, 카테고리 정보가 누락되지 않은(NULL이 아닌) 주문 건수를 각각 조회해라. 
-- 컬럼의 별칭은 각각 '총 주문 건수', '카테고리 보유 건수'로 지정해라. 실행 결과를 참고해라. 
select 
	count(*) as `총 주문 건수`
    , count(category) as `카테고리 보유 건수` 
from order_stat;

-- 문제2 
-- order_stat 테이블을 사용하여 우리 쇼핑몰의 총 매출액, 평균 주문 금액(주문 1건당 매출액), 판매된 상품들의 최고 단가와 최저 단가를 한 번에 조회해라. 실행 결과를 참고해라. 
select 
	sum(price * quantity) as `총 매출액`
    , avg(price * quantity) as `평균 주문 금액`
    , max(price) as `최고 단가`
    , min(price) as `최저 단가`
from order_stat;
    
-- 문제3 
-- order_stat 테이블을 category별로 그룹화하여 각 카테고리별로 총 판매된 상품 수량(quantity의 합계)과 총 매출액(price * quantity의 합계)을 계산해라. 
-- 결과는 총 매출액이 높은 순서대로 정렬해야 한다. 실행 결과를 참고해라. 
select 
	category
	, sum(quantity) as `카테고리별 총 판매 수량`
    , sum(price * quantity) as `카테고리별 총 매출액`
from order_stat
group by category
order by `카테고리별 총 매출액` desc;

-- 문제4 
-- order_stat 테이블을 사용하여 고객별로 총 주문 횟수와 총 구매한 상품의 수량(quantity)을 계산해라. 
-- 결과는 주문 횟수가 많은 순으로, 주문 횟수가 같다면 총 구매 수량이 많은 순으로 정령해라. 실행 결과를 참고해라. 
select 
	customer_name
    , count(*) as `총 주문 횟수`
    , sum(quantity) as `총 구매 수량`
from order_stat
group by customer_name 
order by `총 주문 횟수` desc, `총 구매 수량` desc; 

-- 문제5
-- order_stat 테이블에서 고객별 총 구매 금액을 계산하고, 총 구매 금액이 40만 원 이상인 'VIP 고객' 목록만 조회해라. 
-- 결과에는 고객 이름과 총 구매 금액이 포함되어야 하며, 총 구매 금액이 높은 순으로 정렬되어야 한다. 실행 결과를 참고해라. 

select 
	customer_name
    , sum(price * quantity) as `총 구매 금액`
from order_stat 
group by customer_name
having `총 구매 금액` >= 400000
order by `총 구매 금액` desc;

-- 문제6 
-- order_stat 테이블에서 '도서'카테고리를 제외한 주문들 중에서, 2회 이상 주문한 고객들을 찾아,
-- 그 고객들의 이름, 주문 횟수, 총 사용 금액을 조회해라. 결과는 총 사용 금액이 높은 순으로 정렬되어야 한다. 
select 
	customer_name
    , count(*) as `주문 횟수`
    , sum(price * quantity) as `총 사용 금액`
from order_stat
where category <> '도서' or category is null
group by customer_name
having count(*) >= 2
order by `총 사용 금액` desc;
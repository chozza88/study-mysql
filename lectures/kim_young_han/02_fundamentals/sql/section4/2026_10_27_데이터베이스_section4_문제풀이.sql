-- 문제1 
-- 가장 비싼 상품 조회하기 
select 
	product_id as 상품ID
    , name as 상품명 
    , price as 가격 
from products 
where price = (
	select 
		max(price)
	from products
);

-- 문제2 
-- order_id가 1인 주문과 동일한 상품을 주문한 다른 모든 주문의 order_id, user_id, order_date를 조회해라. 
-- 스칼라 서브쿼리를 활용해야 한다. 

select 
	order_id as 주문ID
    , user_id as 고객ID
    , order_date as 주문일시 
from orders 
where product_id = (
	select 
	product_id
	from orders 
	where order_id = 1
) and order_id != 1;

-- 문제3 
-- 각 고객(users)별로 총 몇 번의 주문을 했는지 '총주문횟수'를 이름과 함께 조회해라. 정렬은 user_id 오름차순이다. 
-- 한 번도 주문하지 않은 고객도 결과에 포함되어야 한다. SELECT 절에 상관 서브쿼리를 사용하여 해결해야 한다. 

select 
	name as 고객명
    , (
		select count(*)
		from orders o
        where o.user_id = u.user_id
        ) as 총주문횟수
from users u 
order by u.user_id;
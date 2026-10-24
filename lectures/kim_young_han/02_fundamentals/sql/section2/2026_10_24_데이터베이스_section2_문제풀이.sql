-- 문제1
-- INNER JOIN을 사용하여 orders 테이블과 products 테이블을 연결해라. 모든 주문에 대해 주문 ID, 상품명, 주문 수량이 
-- 포함된 목록을 조회하는 SQL을 작성하고 order_id 오름차순 정렬해라. 가독성을 위해 테이블 별칭을 사용해야 한다. 

select 
	od.order_id
    , pd.name as name
    , od.quantity as quantity
from orders od
join products pd
on od.product_id = pd.product_id
order by od.order_id asc;


-- 문제2
-- orders, users, products 세 개의 테이블을 모두 조인해라. SHIPPED (배송) 상태인 주문에 대해 주문 ID, 고객이름, 상품명, 주문날짜 
-- 를 조회하는 SQL을 작성해라. 

select 
	o.order_id
    , u.name as user_name
    , p.name as product_name
    , o.order_date
from orders o
join users u
on o.user_id = u.user_id
join products p
on o.product_id = p.product_id
where o.status = 'SHIPPED';


-- 문제3 
-- INNER JOIN과 집계 함수를 함께 사용해서 각 고객이 지금까지 주문한 총 구매액을 계산해라.
-- 결과는 고객이름과 총 구매액으로 구성되어야 하며, 총 구매액이 높은 순서대로 정렬해야 한다. 

select 
	u.name as user_name
    , sum(o.quantity * p.price) as total_purchase_amount 
from users u 
join orders o 
on u.user_id = o.user_id
join products p
on o.product_id = p.product_id
group by u.user_id 
order by total_purchase_amount desc; 
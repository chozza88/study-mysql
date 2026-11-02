-- 문제1 
-- users 테이블에는 고객의 주소, 생년월일과 같은 민감한 정보가 포함되어 있다. 마케팅팀에서는 고객에게 이메일을 보내기 위해 이름과 이메일 조수만 필요하다. 
-- 보안을 위해 고객의 user_id, name, email 컬럼만을 포함하는 v_customer_email_list라는 이름의 뷰(View)를 생성해라. 
drop view if exists v_customer_email_list;

create view v_customer_email_list as
select 
	user_id
    , name as 고객명
    , email as 이메일
from users;

select * from v_customer_email_list
where user_id = 1;


-- 문제2 
-- 운영팀에서는 현재 주문 내역을 확인할 때마다 order, users, products 테이블을 매번 JOIN해야 해서 불편함을 겪고 있다. 
-- 주문 ID(order_id), 고객이름(name), 상품명(name), 주문수량(quantity), 주문상태(status)를 한 번에 볼 수 있는 
-- v_order_summary라는 이름의 뷰를 생성하여 업무 효율을 높여라. 

drop view if exists v_order_summary;

create view v_order_summary as
select 
	o.order_id 
    , u.name as 고객이름 
    , p.name as 상품명
    , o.quantity as 주문수량 
    , o.status as 주문상태
from orders o
join users u
on o.user_id = u.user_id
join products p
on o.product_id = p.product_id; 

select * from v_order_summary;

-- 문제3 
-- 전략기획팀은 '전자기기' 카테고리의 상품들에 대한 주문 건수와 총매출액을 집중적으로 분석하고자 한다. 
-- products 테이블과 orders 테이블을 JOIN하여, '전자기기' 카테고리에 속한 상품들의 총주문 건수(total_orders)와
-- 총매출액(total_sales)을 계산하는 v_electronics_sales_status 뷰를 생성하라.  
drop view if exists v_electronics_sales_status;
create view v_electronics_sales_status as
select 
	p.category
    , count(o.order_id) as total_orders 
    , sum(p.price * o.quantity) as total_sales
from orders o
join products p
on o.product_id = p.product_id 
where p.category = '전자기기'
group by p.category;

select * from v_electronics_sales_status;

-- 문제4 
-- 문제3에서 만들었던 v_electronics_sales_status뷰가 매우 유용하다는 피드백을 받았다. 전략기획팀에서 총매출액뿐만 아니라, 
-- 평귱 주문액(average_order_value)도 함께 보고 싶다는 추가 요청이 왔다. 
-- 기존 뷰를 삭제하지 말고, ALTER VIEW를 사용하여 v_electronics_sales_status 뷰의 정의를 수정해라. 총주문 건수 
-- 총매출액, 그리고 평균 주문액을 보여주도록 변경해야 한다. 
alter view v_electronics_sales_status as
select 
	p.category
    , count(o.order_id) as total_orders
    , sum(p.price * o.quantity) as total_sales 
    , avg(p.price * o.quantity) as average_order_value
from orders o
join products p
on o.product_id = p.product_id
where p.category = '전자기기' 
group by p.category;

select * from v_electronics_sales_status;

select 
	name as 이름 
    , email as 이메일
from users
UNION 
select 
	name, email 
from retired_users;


-- 문제2 
-- 마케팅팀에서 두 그룹의 고객에게 이벤트를 진행하려고 한다. 
-- 1. '전자기기'카테고리 상품을 한 번이라도 구매한 고객 
-- 2. 한 번의 주문으로 상품을 2개 이상 구매한 고객 
-- 두 그룹에 모두 해당하는 고객도 있을 수 있다. 성능을 고려하여, 두 그룹의 목록을 중복 제거 없이 모두 합쳐서 조회해라. 컬럼 별칭은 고객명, 이메일로 지정한다. 
select 
	u.name as 고객명
    ,u.email as 이메일
from orders o
join users u
on o.user_id = u.user_id 
join products p 
on o.product_id = p.product_id 
where category = '전자기기'
union all
select distinct
	u.name
    , u.email
from orders o
join users u
on o.user_id = u.user_id 
where o.quantity >= 2;


select
	create_at as 이벤트_날짜 
    , '고객 가입' as 이벤트_종류
    , name as 상세_내용 
from users
union all 
select
	o.order_date as 이벤트_날짜
    , '상품 주문' as 이벤트_종류 
    , p.name as 상세_내용
from orders o
join products p
on o.product_id = p.product_id
order by 이벤트_날짜 desc;

select 
	name as 이름
    , '고객' as 역할
    , email as 이메일
from users

union all 

select 
	name as 이름
    , '직원' as 역할
    , concat(name, '@my-shop.com') as 이메일
from employees 
order by 이름;
-- 문제1 
-- products 테이블에 있는 모든 상품의 이름(name)과 가격(price) 정보를 조회해라. 단, 조회 결과의 열 이름은 각각 '상품명'과 '판매가'로 표시되어야 한다.

select 
	name as `상품명`
    , price as `판매가`
from products;

-- 문제2
-- customers 테이븛에서 '장영실' 고객의 모든 정보를 조회해라. 
select 
	*
from customers
where name = '장영실';

-- 문제3 
-- products 테이블에서 가격(price)이 10000원 이상이면서, 동시에 재고(stock_quantity)가 50개 미만인 상품을 조회해라.
select 
	*
from products
where price >= 10000 
and stock_quantity < 50;


-- 문제4
-- products 테이블에서 product_id가 2번, 3번, 4번 중 하나에 해당하는 상품들의 이름(name)과 가격(price)을 조회해라.
select 
	name
    , price
from products
where product_id in(2, 3, 4);

-- 문제5
-- customers 테이블에서 주소(address)가 '서울특별시'로 시작하는 고객의 이름(name)과 전체 주소(address)를 조회해라. 
select 
	name 
    , address 
from customers 
where address like '서울특별시%';

-- 문제6 
-- products 테이블에서 상품 설명(description)이 아직 입력되지 않은(NULL) 상품의 모든 정보를 조회해라. 
select
	* 
from products 
where description is null;

-- 문제7 
-- products 테이블의 모든 상품 정보를 가격(price)이 비싼 순서(내림차순)대로 정렬하여 조회해라. 
select 
	* 
from products 
order by price desc;

-- 문제8 
-- products 테이블의 상품 정보를 먼저 가격(price)의 오름차순으로 정렬하고, 만약 가격이 같다면 재고 수량(stock_quantity)이 많은 순(내림차순)으로 정렬하여 조회해라. 
select 
	* 
from products 
order by price, stock_quantity desc;

-- 문제9 
-- customers 테이블에서 가장 최근에 가입한 고객 2명의 모든 정보를 조회해라.
select 
	* 
from customers 
order by join_date desc
limit 2;

-- 문제10 
-- orders 테이블을 참조하여, 한 번이라도 주문을 한 적이 있는 고객의 ID(customer_id)와 주문한 상품의 ID(product_id) 조합을 중복 없이 조회해라. 
select 
	distinct customer_id
    , product_id
from orders;

-- 문제11 
-- products 테이블에서 가격이 3000원을 초과하고 재고가 100개 이하인 상품들을 대상으로, 재고가 많은 순서대로 정렬하여 상위 3개의 상품명과 재고 수량을 조회해라. 
-- 이때 상품명은 '상품 이름'으로, 재고 수량은 '남은 수량'으로 출력해라. 
desc products;
select 
	name as `상품 이름`
    , stock_quantity as `남은 수량`
from 
	products 
where 
	price > 3000 and stock_quantity <= 100
order by 
	stock_quantity desc 
limit 3;
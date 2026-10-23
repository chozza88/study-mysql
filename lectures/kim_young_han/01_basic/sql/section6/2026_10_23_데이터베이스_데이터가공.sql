use my_shop;

-- 산술 연산
-- 상품의 각 재고 자산을 구해주세요.
select 
	name
    , price
    , stock_quantity
    , price * stock_quantity as total_stock_value
from products;

-- 상품에 각각 3000원이 인상된 가격의 값을 구해주세요. 
select 
	name
    , price
    , price + 3000 as expected_price
from products;

-- 상품에서 각각 1000원 할인된 가격의 값을 구해주세요. 
select 
	name
    , price
    , price - 1000 as discounted_price
from products;

-- 상품들을 10개월 무이자로 했을 때, 한달 무이자 가격이 어떻게 되는지 구해주세요. 
select 
	name 
    , price 
	, price / 10 as monthly_payment 
from products;

-- 문자열 연산
select 
	name
    , email
from customers;

-- 이름과 이메일을 합쳐서 보이도록 해야함. 
select 
	concat(name, ' - ', email)
from customers;

select 
	concat(name, ' (', email, ')') as name_and_email
from customers;

select 
	concat_ws(', ', name, email, address) as customer_details 
from customers;

select 
	upper(email) as upper_email 
from customers;

select
	name
    , char_length(name) as char_length
    , length(name) as byte_length
from customers;

-- NULL 함수 
select 
	name 
    , ifnull(description, '상품 설명 없음') as description
from products;

select 
	name 
    , coalesce(description, '상품 설명 없음') as description 
from products;

-- 다양한 함수들을 사용할 때는 공식문서를 이용하자

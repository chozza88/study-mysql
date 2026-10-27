use my_shop2;

DROP TABLE IF EXISTS retired_users;
CREATE TABLE retired_users(
	id BIGINT
    , name VARCHAR(255) NOT NULL
    , email VARCHAR(255) NOT NULL 
    , retired_date DATE NOT NULL
);

INSERT INTO retired_users (id, name, email, retired_date) VALUES 
(1, '션', 'sean@example.com', '2024-12-31'),
(7, '아이작 뉴턴', 'newton@example.com', '2025-01-10');

-- UNION
-- UNION은 중복을 제거하고 고유한 목록만 보여준다. 
select name, email from users
union
select name, email from retired_users;

-- UNION ALL
-- UNION ALL은 중복을 허용
select u.name, u.email 
from users u
join orders o on u.user_id = o.user_id 
join products p on o.product_id = p.product_id 
where p.category = '전자기기' 

UNION ALL

select name, email 
from users 
where address like '서울%';


select name, email from users 
union 
select name, email from retired_users
order by name;
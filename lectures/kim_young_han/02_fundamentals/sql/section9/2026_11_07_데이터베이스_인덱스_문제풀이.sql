show index from items;

drop index idx_items_category_price on items;

-- 문제 
-- 최근 쇼핑몰의 items 테이블에 데이터가 많아지면서, 사용자들이 특정 조건으로 상품을 조회할 때 시스템이 점점 느려진다는 불만이 접수되었다. 
-- 원인 파악 결과, 자주 사용되는 조회 쿼리에 인덱스가 걸려있지 않아 전체 데이터를 스캔(Full Table Scan)하고 있었다. 

-- 다음은 느리다고 보고된 주요 쿼리이다. 
explain select * from items where category = '전자기기' and is_active = true;

explain select * from items where category = '전자기기' and is_active = true order by stock_quantity desc;

explain select * from items where stock_quantity < 90 and category = '전자기기' and is_active = true; 

explain select * from items where stock_quantity < 90 and category = '전자기기' and is_active = true order by stock_quantity desc;

-- [인덱스 설계 및 성능 최적화]
--
-- 문제 상황:
-- 상품 데이터가 증가하면서 특정 카테고리의 활성 상품 조회와
-- 재고 수량 조건 및 정렬을 포함한 조회 성능이 저하되었다.
--
-- 해결 방법:
-- category와 is_active는 동등 조건(=)이므로 앞에 배치하고,
-- stock_quantity는 범위 조건(<) 및 내림차순 정렬에
-- 활용할 수 있도록 마지막에 배치한다.
--
-- 설계 이유:
-- 복합 인덱스의 정렬 구조를 이용하여 조회 범위를 좁히고,
-- 조건에 따라 별도의 정렬 작업을 줄일 수 있다.
--
-- 주의 사항:
-- 인덱스는 조회 성능을 개선할 수 있지만,
-- INSERT, UPDATE, DELETE 시 유지 비용이 발생한다.
--
-- 특히 쇼핑몰에서는 재고 수량이 빈번하게 변경될 수 있으므로,
-- stock_quantity를 인덱스에 포함하는 것이
-- 전체 시스템 성능에 유리한지 검토해야 한다.
--
-- 검증 방법:
-- 실제 데이터 분포와 조회/변경 빈도를 확인하고,
-- EXPLAIN ANALYZE 및 쓰기 부하 테스트로 성능을 비교한다.
create index idx_items_category_active_stock_quantity on items (category, is_active, stock_quantity desc);

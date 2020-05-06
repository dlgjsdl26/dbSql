
SELECT ROWNUM , a.*
FROM
(SELECT kf.sido, kf.sigungu, ROUND(((cnt1 + cnt2 + cnt3) / cnt4),2) burger_index
FROM
(SELECT sido, sigungu, COUNT(gb) cnt1
FROM fastfood
WHERE gb = '버거킹'
GROUP BY sido, sigungu) bk,

(SELECT sido, sigungu, COUNT(gb) cnt2
FROM fastfood
WHERE gb = 'KFC'
GROUP BY sido, sigungu) kf,

(SELECT sido, sigungu, COUNT(gb) cnt3
FROM fastfood
WHERE gb = '맥도날드'
GROUP BY sido, sigungu) mac,

(SELECT sido, sigungu, COUNT(gb) cnt4
FROM fastfood
WHERE gb = '롯데리아'
GROUP BY sido, sigungu) lot

WHERE bk.sido = kf.sido 
  AND bk.sigungu = kf.sigungu
  AND bk.sido = mac.sido 
  AND bk.sigungu = mac.sigungu
  AND bk.sido = lot.sido 
  AND bk.sigungu = lot.sigungu

ORDER BY burger_index DESC) a;


SELECT *
FROM tax;


사용된 SQL 문법 : WHERE, 그룹연산을 의한 GROUP BY, 복수행 함수(COUNT), 인라인 뷰, ROWNUM, ORDER BY, 별칭(컬럼, 테이블), ROUND, JOIN

과제1] fastfood 테이블과 tax 테이블을 이용하여 다음과 같이 조회되도록 SQL 작성
 1. 도시발전지수를 구하고
 2. 인당 연말 신고액이 높은 시도 시군구별로 순위를 구하여
 3. 도시발전지수와 인당 신고액 순위가 같은 데이터 끼리 조인하여 아래와 같이 컬럼이 조회되도록 SQL 작성
 
  순위, 햄버거 시도, 햄버거 시군구, 햄버거 도시발전지수, 국세청 시도, 국세청 시군구, 국세청 연말정산 금액 1인당 신고액
  
  SELECT ta.rank1, bug.sido, bug.sigungu, burger_index, ta.sido, ta.sigungu, ta.tax_1
  FROM
  
  (SELECT ROWNUM rank1, a.*
  FROM
  (SELECT sido, sigungu, ROUND(sal/people,2) tax_1
  FROM tax
  ORDER BY tax_1 DESC) a) ta,
   
(SELECT ROWNUM rank2, a.*
FROM
(SELECT kf.sido, kf.sigungu, ROUND(((cnt1 + cnt2 + cnt3) / cnt4),2) burger_index
FROM
(SELECT sido, sigungu, COUNT(gb) cnt1
FROM fastfood
WHERE gb = '버거킹'
GROUP BY sido, sigungu) bk,

(SELECT sido, sigungu, COUNT(gb) cnt2
FROM fastfood
WHERE gb = 'KFC'
GROUP BY sido, sigungu) kf,

(SELECT sido, sigungu, COUNT(gb) cnt3
FROM fastfood
WHERE gb = '맥도날드'
GROUP BY sido, sigungu) mac,

(SELECT sido, sigungu, COUNT(gb) cnt4
FROM fastfood
WHERE gb = '롯데리아'
GROUP BY sido, sigungu) lot

WHERE bk.sido = kf.sido 
  AND bk.sigungu = kf.sigungu
  AND bk.sido = mac.sido 
  AND bk.sigungu = mac.sigungu
  AND bk.sido = lot.sido 
  AND bk.sigungu = lot.sigungu

ORDER BY burger_index DESC) a) bug

WHERE ta.rank1 = bug.rank2;

  
과제2]
햄버거 도시발전 지수를 구하기 위해 4개의 인라인 뷰를 사용 하였는데 (fastfood 테이블을 4번 사용)
이를 개선하여 테이블을 한번만 읽는 형태로 쿼리를 개선 (fastfood 테이블을 1번만 사용)
CASE, DECODE

개별 햄버거점의 주소(파파이스, 맘스터치 제외하고 계산)
SELECT ROWNUM rank, sido, sigungu, city_idx
FROM
    (SELECT sido, sigungu, Round((kfc + mac + bk) / lot, 2) city_idx
    FROM
    
    (SELECT sido, sigungu, NVL(SUM(CASE WHEN gb = '롯데리아' THEN 1 END),1) lot,
                           NVL(SUM(CASE WHEN gb = 'kfc' THEN 1 END),0) kfc,
                           NVL(SUM(CASE WHEN gb = '맥도날드' THEN 1 END),0) mac,
                           NVL(SUM(CASE WHEN gb = '버거킹' THEN 1 END),0) bk
    FROM fastfood
    WHERE gb IN ('버거킹', 'KFC', '맥도날드', '롯데리아')
    GROUP BY sido, sigungu)
    ORDER BY city_idx DESC);
/*SELECT ROWNUM, a.*
FROM

(SELECT sido, sigungu, ROUND((bug+kf+mac)/lot,2) index2
FROM

(SELECT sido, sigungu, COUNT(DECODE(gb, '롯데리아', gb)) lot, COUNT(DECODE(gb, '맥도날드', gb)) mac, COUNT(DECODE(gb, '버거킹', gb)) bug, COUNT(DECODE(gb, 'KFC', gb)) kf
FROM fastfood
GROUP BY sido, sigungu)

WHERE lot != 0
ORDER BY index2 DESC) a;*/




과제3]
햄버거 지수 sql을 다른 형태로 도전하기

SELECT 시도, 시군구, (KFC 스칼라 서브쿼리),
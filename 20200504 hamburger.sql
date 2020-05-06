
SELECT ROWNUM , a.*
FROM
(SELECT kf.sido, kf.sigungu, ROUND(((cnt1 + cnt2 + cnt3) / cnt4),2) burger_index
FROM
(SELECT sido, sigungu, COUNT(gb) cnt1
FROM fastfood
WHERE gb = '����ŷ'
GROUP BY sido, sigungu) bk,

(SELECT sido, sigungu, COUNT(gb) cnt2
FROM fastfood
WHERE gb = 'KFC'
GROUP BY sido, sigungu) kf,

(SELECT sido, sigungu, COUNT(gb) cnt3
FROM fastfood
WHERE gb = '�Ƶ�����'
GROUP BY sido, sigungu) mac,

(SELECT sido, sigungu, COUNT(gb) cnt4
FROM fastfood
WHERE gb = '�Ե�����'
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


���� SQL ���� : WHERE, �׷쿬���� ���� GROUP BY, ������ �Լ�(COUNT), �ζ��� ��, ROWNUM, ORDER BY, ��Ī(�÷�, ���̺�), ROUND, JOIN

����1] fastfood ���̺�� tax ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� SQL �ۼ�
 1. ���ù��������� ���ϰ�
 2. �δ� ���� �Ű���� ���� �õ� �ñ������� ������ ���Ͽ�
 3. ���ù��������� �δ� �Ű�� ������ ���� ������ ���� �����Ͽ� �Ʒ��� ���� �÷��� ��ȸ�ǵ��� SQL �ۼ�
 
  ����, �ܹ��� �õ�, �ܹ��� �ñ���, �ܹ��� ���ù�������, ����û �õ�, ����û �ñ���, ����û �������� �ݾ� 1�δ� �Ű��
  
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
WHERE gb = '����ŷ'
GROUP BY sido, sigungu) bk,

(SELECT sido, sigungu, COUNT(gb) cnt2
FROM fastfood
WHERE gb = 'KFC'
GROUP BY sido, sigungu) kf,

(SELECT sido, sigungu, COUNT(gb) cnt3
FROM fastfood
WHERE gb = '�Ƶ�����'
GROUP BY sido, sigungu) mac,

(SELECT sido, sigungu, COUNT(gb) cnt4
FROM fastfood
WHERE gb = '�Ե�����'
GROUP BY sido, sigungu) lot

WHERE bk.sido = kf.sido 
  AND bk.sigungu = kf.sigungu
  AND bk.sido = mac.sido 
  AND bk.sigungu = mac.sigungu
  AND bk.sido = lot.sido 
  AND bk.sigungu = lot.sigungu

ORDER BY burger_index DESC) a) bug

WHERE ta.rank1 = bug.rank2;

  
����2]
�ܹ��� ���ù��� ������ ���ϱ� ���� 4���� �ζ��� �並 ��� �Ͽ��µ� (fastfood ���̺��� 4�� ���)
�̸� �����Ͽ� ���̺��� �ѹ��� �д� ���·� ������ ���� (fastfood ���̺��� 1���� ���)
CASE, DECODE

���� �ܹ������� �ּ�(�����̽�, ������ġ �����ϰ� ���)
SELECT ROWNUM rank, sido, sigungu, city_idx
FROM
    (SELECT sido, sigungu, Round((kfc + mac + bk) / lot, 2) city_idx
    FROM
    
    (SELECT sido, sigungu, NVL(SUM(CASE WHEN gb = '�Ե�����' THEN 1 END),1) lot,
                           NVL(SUM(CASE WHEN gb = 'kfc' THEN 1 END),0) kfc,
                           NVL(SUM(CASE WHEN gb = '�Ƶ�����' THEN 1 END),0) mac,
                           NVL(SUM(CASE WHEN gb = '����ŷ' THEN 1 END),0) bk
    FROM fastfood
    WHERE gb IN ('����ŷ', 'KFC', '�Ƶ�����', '�Ե�����')
    GROUP BY sido, sigungu)
    ORDER BY city_idx DESC);
/*SELECT ROWNUM, a.*
FROM

(SELECT sido, sigungu, ROUND((bug+kf+mac)/lot,2) index2
FROM

(SELECT sido, sigungu, COUNT(DECODE(gb, '�Ե�����', gb)) lot, COUNT(DECODE(gb, '�Ƶ�����', gb)) mac, COUNT(DECODE(gb, '����ŷ', gb)) bug, COUNT(DECODE(gb, 'KFC', gb)) kf
FROM fastfood
GROUP BY sido, sigungu)

WHERE lot != 0
ORDER BY index2 DESC) a;*/




����3]
�ܹ��� ���� sql�� �ٸ� ���·� �����ϱ�

SELECT �õ�, �ñ���, (KFC ��Į�� ��������),
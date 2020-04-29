OUTER JOIN
���̺� ���� ������ �����ص�, �������� ���� ���̺��� �÷��� ��ȸ�� �ǵ��� �ϴ� ���� ���
<===>
INNER JOIN(�츮�� ���ݱ��� ��� ���)

LEFT OUTER JOIN     : ������ �Ǵ� ���̺��� JOIN Ű���� ���ʿ� ��ġ
RIGHT OUTER JOIN    : ������ �Ǵ� ���̺��� JOIN Ű���� ���ʿ� ��ġ
FULL OUTER JOIN     : LEFT OUTER JOIN + RIGHT OUTER JOIN - (�ߺ��Ǵ� �����Ͱ� �ѰǸ� ������ ó��)

emp���̺��� �÷��� mgr�÷��� ���� �ش� ������ ������ ������ ã�ư� �� �ִ�.
������ KING������ ��� ����ڰ� ���� ������ �Ϲ����� inner ���� ó����
���ο� �����ϱ� ������ KING�� ������ 13���� �����͸� ��ȸ�� ��

INNER ���� ����
����� ���, ����� �̸�, ���� ���, ���� �̸�

������ �����ؾ����� �����Ͱ� ��ȸ�ȴ�
==> KING�� ����� ����(mgr)�� NULL�̱� ������ ���ο� �����ϰ�
    KING�� ������ ������ �ʴ´� (emp ���̺� �Ǽ� 14�� ==> ���� ��� 13��)
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

ANSI-SQL
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e JOIN emp m ON e.mgr = m.empno;


���� ������ OUTER �������� ����
(KING ������ ���ο� �����ص� ���� ������ ���ؼ��� ��������,
������ ����� ������ ���� ������ ������ �ʴ´�);

ANSI-SQL : OUTER
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp m RIGHT OUTER JOIN emp e ON ( e.mgr = m.empno );

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp m LEFT OUTER JOIN emp e ON ( e.mgr = m.empno );

ORACLE-SQL : OUTER
oracle join
1. FROM���� ������ ���̺� ���(�޸��� ����)
2. WHERE���� ���� ������ ���
3. ���� �÷�(�����)�� ������ �����Ͽ� �����Ͱ� ���� ���� �÷��� (+)�� �ٿ� �ش�.
    ==> ������ ���̺� �ݴ����� ���̺��� �÷�
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);


OUTER ������ ���� ��� ��ġ�� ���� ��� ��ȭ

������ ����� �̸�, ���̵� �����ؼ� ��ȸ
��, ������ �ҼӺμ��� 10���� ���ϴ� �����鸸 �����ؼ�;

������ ON���� ������� ��
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp m RIGHT OUTER JOIN emp e ON ( e.mgr = m.empno AND e.deptno = 10);

ORACLE-SQL
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp m, emp e
WHERE e.mgr = m.empno 
    AND e.deptno = 10;

������ WHERE���� ������� ��
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp m RIGHT OUTER JOIN emp e ON ( e.mgr = m.empno)
WHERE e.deptno = 10;

OUTER ������ �ϰ� ���� ���̶�� ������ ON���� ����ϴ°� �´�.

outerjoin1]
SELECT *
FROM buyprod
WHERE buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');

SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM prod, buyprod
WHERE buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD')
    AND prod_id = buy_prod(+);


SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM prod LEFT OUTER JOIN buyprod ON prod_id = buy_prod
    AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');

SELECT*
FROM prod;

outer join2]
SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD'), buy_prod, prod_id, prod_name, buy_qty
FROM prod, buyprod
WHERE buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD')
    AND prod_id = buy_prod(+);


outer join3]

SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD'), buy_prod, prod_id, prod_name, NVL(buy_qty, 0) buy_qty
FROM prod, buyprod
WHERE buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD')
    AND prod_id = buy_prod(+);


outer join4]
SELECT product.pid, pnm, 1 cid, NVL(day,0) day, NVL(cnt,0)
FROM cycle, product
WHERE cycle.pid(+) = product.pid
   AND cid(+) = 1;


outer join5] --�Ϸ� X

SELECT a.pid, a.pnm, 1 cid, NVL(day,0) day, NVL(cnt,0)
FROM
    (SELECT product.pid pid, pnm, 1 cid, NVL(day,0) day, NVL(cnt,0) cnt
    FROM cycle, product
    WHERE cycle.pid(+) = product.pid
        AND cid(+) = 1) a, customer;
   
15 ==> 45

SELECT *
FROM product, cycle, customer
WHERE product.pid = cycle.pid;

CROSS JOIN
���� ������ ������� ���� ���
��� ������ ���� �������� ����� ��ȸ�ȴ�.

ANSI-SQL
SELECT *
FROM emp CROSS JOIN dept;

ORACLE (���� ���̺� ����ϰ�  WHERE ���� ������ ������� �ʴ´�)
SELECT *
FROM emp, dept;

crossjoin1]
SELECT *
FROM customer CROSS JOIN product;


��������
WHERE : ������ �����ϴ� �ุ ��ȸ�ǵ��� ����
SELECT *
FROM emp
WHERE 1=1
    OR 1 != 1;
    
���� <==> ����
���������� �ٸ� ���� �ȿ��� �ۼ��� ����
�������� ������ ��ġ
1. SELECT
    SCALAR SUB QUERY
    *��Į�� ���������� ��ȸ�Ǵ� ���� 1���̰�, �÷��� �Ѱ��� �÷��̾�� �Ѵ�.
    EX) DUAL���̺�
    
2. FROM
    INLINE-VIEW
    SELECT ������ ��ȣ�� ���� ��

3. WHERE
    SUB QUERY
    WHERE ���� ���� ����
    

SMITH�� ���� �μ��� ���� �������� ���� ������?

1. SMITH�� ���� �μ��� �������??
2. 1������ �˾Ƴ� �μ���ȣ�� ���ϴ� ������ ��ȸ

==> �������� 2���� ������ ���� ����
    �ι�° ������ ù��°�� ������ ����� ���� ���� �ٸ��� �����;� �Ѵ�.
    (SMITH(20) => WARD(30) ==> �ι�° ���� �ۼ��� 10������ 30������ ������ ����
    ==> �������� ���鿡�� ��������.
    
ù��° ����;
SELECT deptno --20
FROM emp
WHERE ename = 'SMITH';

�ι�° ����;
SELECT *
FROM emp
WHERE deptno = 20;

���������� ���� ���� ����

SELECT *
FROM emp
WHERE deptno = (SELECT deptno --20
                FROM emp
                WHERE ename = :ename);--'SMITH');

SELECT COUNT(*)
FROM emp
WHERE sal > (SELECT AVG(sal)
            FROM emp);

SELECT AVG(sal)
FROM emp;
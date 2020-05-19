SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno, job)

����׷� ���� ���
ROLLUP : �����ʿ��� �ϴϾ� �������鼭 ����׷��� ����
        ==>(deptno, job), (deptno), all
CUBE



SUB_A2];
DROP TABLE dept_test;

SELECT *
FROM dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

COMMIT;


INSERT INTO dept_test VALUES (99, 'it1', 'daejeon');
INSERT INTO dept_test VALUES (98, 'it2', 'daejeon');

ROLLBACK;

DELETE dept_test
WHERE NOT EXISTS (  SELECT 'X'
                    FROM emp
                    WHERE emp.deptno = dept_test.deptno);

SELECT *
FROM dept_test
WHERE NOT EXISTS(SELECT 'X'
                 FROM emp
                 WHERE emp.deptno = dept_test.deptno);


SELECT *
FROM emp_test;

UPDATE emp_test al SET sal = sal + 200
WHERE sal < (SELECT AVG(sal)
             FROM emp_test b
             WHERE al.deptno = b.deptno
             GROUP BY deptno);
             
ROLLBACK;

���Ŀ��� �ƴ�����, �˻�-������ ���� ������ ǥ��
���������� ���� ���
1. Ȯ���� : ��ȣ���� �������� (EXISTS)
            ==> ���� ���� ���� ���� ==> ���� ���� ����
2. ������ : ���������� ���� ����Ǽ� ���������� ���� ���� ���ִ� ����

13�� : �Ŵ����� �����ϴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr IN (SELECT empno
                FROM emp);
                

�μ��� ��� �޿�
SELECT deptno, ROUND(AVG(sal),2)
FROM emp
GROUP BY deptno;

��ü �޿� ���
SELECT ROUND(AVG(sal),2)
FROM emp;

�Ϲ����� ���� ����
SELECT deptno, ROUND(AVG(sal),2)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal),2) > (SELECT ROUND(AVG(sal),2)
                            FROM emp);

WITH �� : SQL���� �ݺ������� ������ QUERY BLOCK(SUBQUERY)�� ������ �����Ͽ�
          SQL ����� �ѹ��� �޸𸮿� �ε��� �ϰ� �ݺ������� ����� �� �޸� ������ �����͸� Ȱ���Ͽ� �ӵ� ������ �� �� �ִ� KEYWORD
          ��, �ϳ��� SQL���� �ݺ����� SQL���� ������ ���� �߸� �ۼ��� SQL�� ���ɼ��� ���� ������
          �ٸ� ���·� ������ �� �ִ����� ���� �غ��� ���� ��õ.
WITH emp_avg_sal AS(
    SELECT ROUND(AVG(sal),2)
    FROM emp
)
SELECT deptno, ROUND(AVG(sal),2), (SELECT * FROM emp_avg_sal)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal),2) > (SELECT *
                            FROM emp_avg_sal);



��������
CONNECT BY LEVEL : ���� �ݺ��ϰ� ���� ����ŭ ������ ���ִ� ���
��ġ : FROM(WHERE)�� ������ ���
DUAL ���̺�� ���� ���

���̺� ���� �Ѱ�, �޸𸮿��� ����
SELECT LEVEL
FROM dual
CONNECT BY LEVEL <= 5;

���� ���� ���� �̹� ��� KEYWORD�� �̿��Ͽ� �ۼ� ����
5�� �̻��� �����ϴ� ���̺��� ���� ���� ����
���࿡ �츮�� ������ �����Ͱ� 10000���̸��� 10000�ǿ� ���� DISK I/O�� �߻�
SELECT ROWNUM
FROM emp
WHERE ROWNUM <= 5;


1. �츮���� �־��� ���ڿ� ��� : 202005
    �־��� ����� �ϼ��� ���Ͽ� �ϼ��� ���� ����
    
�޷��� �÷��� 7�� - �÷��� ������ ���� : Ư�����ڴ� �ϳ��� ���Ͽ� ����
SELECT TO_DATE('202005','YYYYMM') + (LEVEL - 1) dt, 7���� �÷��� �߰��� ����
        �Ͽ����̸� dt�÷�, �������̸� dt�÷�, ȭ�����̸� dt�÷�....������̸� dt�÷�
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005','YYYYMM')),'DD');



SELECT TO_CHAR(LAST_DAY(TO_DATE('202005','YYYYMM')),'DD')
FROM dual;

�Ʒ� ������� SQL�� �ۼ��ص� ������ �ϼ��ϴ°� �����ϳ� ������ ���鿡�� �ʹ� �����Ͽ� �ζ��κ並 �̿��Ͽ� ������ ���� �ܼ��ϰ� �����.
SELECT TO_DATE('202005','YYYYMM') + (LEVEL - 1) dt,
        DECODE(TO_CHAR(TO_DATE('202005', 'YYYYMM') + (LEVEL - 1), 'D'), '1', TO_DATE('202005', 'YYYYMM') + (LEVEL-1) sun
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005','YYYYMM')),'DD');

�÷��� ����ȭ �Ͽ� ǥ��
TO_DATE('202005','YYYYMM') + (LEVEL - 1) dt

SELECT 
            MIN(DECODE(d, 1, dt)) sun, MIN(DECODE(d, 2, dt)) mon, MIN(DECODE(d, 3, dt)) tue,
            MIN(DECODE(d, 4, dt)) wed, MIN(DECODE(d, 5, dt)) thu, MIN(DECODE(d, 6, dt)) fri, MIN(DECODE(d, 7, dt)) sat
FROM
    (SELECT TO_DATE(:yyyymm,'YYYYMM') + (LEVEL - 1) dt,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM') + (LEVEL - 1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM') + (LEVEL - 1), 'iw') iw
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'YYYYMM')),'DD'))
GROUP BY DECODE(d, 1, iw+1, iw)
ORDER BY DECODE(d, 1, iw+1, iw);




SELECT 
            MIN(DECODE(d, 1, dt)) sun, MIN(DECODE(d, 2, dt)) mon, MIN(DECODE(d, 3, dt)) tue,
            MIN(DECODE(d, 4, dt)) wed, MIN(DECODE(d, 5, dt)) thu, MIN(DECODE(d, 6, dt)) fri, MIN(DECODE(d, 7, dt)) sat
FROM
    (SELECT TO_DATE(:yyyymm,'YYYYMM') + (LEVEL - 1) dt,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM') + (LEVEL - 1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM') + (LEVEL - 1), 'iw') iw,
            DECODE(TO_CHAR(TO_DATE(:yyyymm,'YYYYMM'),'MM',
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'YYYYMM')),'DD'))
GROUP BY DECODE(d, 1, iw+1, iw)
ORDER BY DECODE(d, 1, iw+1, iw);


create table sales as 
select to_date('2019-01-03', 'yyyy-MM-dd') dt, 500 sales from dual union all
select to_date('2019-01-15', 'yyyy-MM-dd') dt, 700 sales from dual union all
select to_date('2019-02-17', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-02-28', 'yyyy-MM-dd') dt, 1000 sales from dual union all
select to_date('2019-04-05', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-04-20', 'yyyy-MM-dd') dt, 900 sales from dual union all
select to_date('2019-05-11', 'yyyy-MM-dd') dt, 150 sales from dual union all
select to_date('2019-05-30', 'yyyy-MM-dd') dt, 100 sales from dual union all
select to_date('2019-06-22', 'yyyy-MM-dd') dt, 1400 sales from dual union all
select to_date('2019-06-27', 'yyyy-MM-dd') dt, 1300 sales from dual;

CALENDER 1]
SELECT *
FROM sales;

SELECT      NVL(SUM(DECODE(m, 01, s)),0) jan, NVL(SUM(DECODE(m, 02, s)),0) feb, NVL(SUM(DECODE(m, 03, s)),0) mar, 
            NVL(SUM(DECODE(m, 04, s)),0) apr, NVL(SUM(DECODE(m, 05, s)),0) may, NVL(SUM(DECODE(m, 06, s)),0) jun
FROM
(SELECT TO_CHAR(dt,'mm') m ,sum(sales) s
FROM sales
GROUP BY TO_CHAR(dt,'mm')) a;


CALENDER 2]

SELECT 
            MIN(DECODE(d, 1, dt)) sun, MIN(DECODE(d, 2, dt)) mon, MIN(DECODE(d, 3, dt)) tue,
            MIN(DECODE(d, 4, dt)) wed, MIN(DECODE(d, 5, dt)) thu, MIN(DECODE(d, 6, dt)) fri, MIN(DECODE(d, 7, dt)) sat
FROM
    (SELECT TO_DATE(:yyyymm,'YYYYMM') + (LEVEL - 1) dt,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM') + (LEVEL - 1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM') + (LEVEL - 1), 'iw') iw
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'YYYYMM')),'DD'))
GROUP BY DECODE(d, 1, iw+1, iw)
ORDER BY DECODE(d, 1, iw+1, iw);
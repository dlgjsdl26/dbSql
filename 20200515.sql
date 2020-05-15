ROLLUP : ����׷� ���� - ����� �÷��� �����ʿ������� ���������� GROUP BY�� ����

�Ʒ� ������ ����׷�
1. GROUP BY job, deptno
2. GROUP BY job
3. GROUP BY ==>��ü

ROLLUP ���� �����Ǵ� ����׷��� ���� : ROLLUP�� ����� �÷��� + 1;
SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

GROUP_AD2];
SELECT NVL(job, '�Ѱ�'), deptno,
       GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);


SELECT DECODE(GROUPING(job), 0, job, 1, '�Ѱ�') job, deptno,
       GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);


GROUP_AD2-1];
SELECT DECODE(GROUPING(job), 0, job, 1, '�Ѱ�') job, DECODE(GROUPING(job) + GROUPING(deptno), 2, '��', 1, '�Ұ�', deptno) deptno,
       GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT *
FROM emp;


GROUP_AD3]
SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno, job);

ROLLUP ���� ��� �Ǵ� �÷��� ������ ��ȸ ����� ������ ��ģ��.
(********* ���� �׷��� ����� �÷��� ������ ���� ������ �����鼭 ����)
GROUP BY ROLLUP (deptno, job);
GROUP BY ROLLUP (job, deptno);


REPORT GROUP FUNCTION ==> Ȯ��� GROUP BY
REPORT GROUPING FUNCTION�� ����� ���ϸ�
�������� SQL�ۼ�, UNION ALL�� ���ؼ� �ϳ��� ����� ��ġ�� ����
==> �� �� ���ϰ� �ϴ°� REPORT GROUP FUNCTION


GROUP_AD4]
SELECT dept.dname, emp.job, SUM(sal)
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job);


GROUP_AD5]
SELECT NVL(dept.dname, '�Ѱ�') dname, emp.job, SUM(sal)
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job);


2. GROUPING SETS
ROLLUP�� ���� : ���ɾ��� ����׷쵵 ���� �ؾ��Ѵ�.
                ROLLUP���� ����� �÷��� �����ʿ��� ���������� ������
                ���� �߰������� �ִ� ����׷��� ���ʿ� �� ��� ����.
GROUPING SETS : �����ڰ� ���� ������ ����׷��� ���
                ROLLUP���� �ٸ��� ���⼺�� ����.
                
���� : GROUP BY GROUPING SETS (col1, col2)
GROUP BY col1
UNION ALL
GROUP BY col2

GROUP BY GROUPING SETS (col2, col1)
GROUP BY col2
UNION ALL
GROUP BY col1



SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno);

SELECT job, null, SUM(sal)
FROM emp
GROUP BY job

UNION ALL

SELECT null, deptno, SUM(sal)
FROM emp
GROUP BY deptno;


�׷������
1. job, deptno
2. mgr

GROUP BY GROUPING SETS((job, deptno), mgr)

SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY GROUPING SETS ((job, deptno), mgr);


3. CUBE
���� : GROUP BY CUBE (col1, col2...)
����� �÷��� ������ ��� ���� (������ ��Ų��)

GROUP BY CUBE (job, deptno);
  1        2
  job,      deptno
  job,      x
  x,        deptno
  x,        x
  
  
SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY CUBE(job, deptno);


�������� REPORT GROUP ����ϱ�
SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

**�߻� ������ ������ ���
1       2       3
job     deptno  mgr
job     x       mgr
job     deptno  x
job     x       x

SELECT job, deptno, mgr, SUM(sal+NVL(comm,0)) sal
FROM emp
GROUP BY job, rollup(job,deptno), cube(mgr);

**�߻� ������ ������ ���
1       2           3
job     job,deptno   mgr
job     job          mgr
job     x            mgr
job     job,deptno   x
job     job          x
job     x            x




��ȣ���� �������� ������Ʈ
1. emp���̺��� �̿��Ͽ� emp_tet ���̺� ����
    ==> ������ ������ emp_test ���̺� ���� ���� ����
DROP TABLE emp_test;
CREATE TABLE emp_test AS
SELECT *
FROM emp;

2. emp_test ���̺� dname�÷� �߰�(dept ���̺� ����)
ALTER TABLE emp_test ADD (dname VARCHAR2(14));
DESC emp_test;

DESC dept;

3. subquery�� �̿��Ͽ� emp_test ���̺� �߰��� dname �÷��� ������Ʈ ���ִ� ���� �ۼ�
emp_test�� dname �÷��� ���� dept ���̺��� dname �÷����� update
emp_test���̺��� deptno���� Ȯ���ؼ� dept���̺��� deptno���̶� ��ġ�ϴ� dname �÷����� ������ update

emp_test���̺��� dname �÷��� dept ���̺� �̿��ؼ� dname�� ��ȸ�Ͽ� ������Ʈ
update ����� �Ǵ� �� - 14 ==> WHERE ���� ������� ����

��� ������ ������� dname �÷��� dept ���̺��� ��ȸ�Ͽ� ������Ʈ;
UPDATE emp_test SET dname = (SELECT dname
                             FROM dept
                             WHERE emp_test.deptno = dept.deptno);

SELECT *
FROM emp_test;



1. dept ���̺��� �̿��Ͽ� dept_test ���̺� ����

DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

2. dept_test ���̺� empcnt(NUMBER)�÷� �߰�

ALTER TABLE dept_test ADD (empcnt NUMBER);

SELECT COUNT(*)
FROM emp;

DESC emP;

SELECT * 
FROM dept_test;

3. subquery�� �̿��Ͽ� dept_test ���̺��� empcnt �÷��� �ش� �μ��� ���� update�ϴ� ������ �ۼ��ϼ���

UPDATE dept_test SET empcnt = (SELECT COUNT(*)
                               FROM emp
                               WHERE emp.deptno = dept_test.deptno);
                               


SELELCT ��� ��ü�� ������� �׷� �Լ��� ������ ��� ���Ǵ� ���� ������ 0���� ����

SELECT COUNT(*)
FROM emp
WHERE 1=2;

GROUP BY ���� ����� ��� ����� �Ǵ� ���� ���� ��� ��ȸ�Ǵ� ���� ����.
SELECT COUNT(*)
FROM emp
WHERE 1=2
GROUP BY deptno;
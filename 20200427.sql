grp7]
dept ���̺��� Ȯ���ϸ� �� 4���� �μ� ������ ���� ==> ȸ�系�� �����ϴ� ��� �μ�����
emp ���̺��� �����Ǵ� �������� ���� ���� �μ������� ���� ==> 10, 20, 30 ==> 3��

SELECT COUNT(*) cnt
FROM 
    (SELECT deptno
    FROM emp
    GROUP BY deptno);
    
    
DBMS : DataBase Management System
==> db
RDBMS : Relational DataBase Management System
==> ������ �����ͺ��̽� ���� �ý���

JOIN ������ ����
ANSI - ǥ��
�������� ����(ORACLE)

JOIN�� ��� �ٸ� ���̺��� �÷��� ����� �� �ֱ� ������
SELECT �Ҽ� �ִ� �÷��� ������ ��������(����Ȯ��)

���տ��� ==> ���� Ȯ�� (���� ��������.)

NATURAL JOIN 
    . �����Ϸ��� �� ���̺��� ����� �÷��� �̸� ���� ���
    . emp, dept ���̺��� deptno��� �����(������ �̸���, Ÿ�Ե� ����) ����� �÷��� ����
    . �ٸ� ANSI-SQL ������ ���ؼ� ��ü�� �����ϰ�, ���� ���̺���� �÷����� �������� ������ ����� �Ұ����ϱ� ������ ���󵵴� �ټ� ����.
    
.emp ���̺� : 14��
.dept ���̺� : 4��

���� �Ϸ����ϴ� �÷��� ���� ������� ����
SELECT *
FROM emp NATURAL JOIN dept;

ORACLE ���� ������ ANSI ����ó�� ����ȭ ���� ����
����Ŭ ���� ����
 1. ������ ���̺� ����� FROM ���� ����ϸ� �����ڴ� �ݷ�(,)
 2. ����� ������ WHERE ���� ����ϸ� �ȴ� (ex : WHERE emp.deptno = dept.deptno)
 
 SELECT *
 FROM emp, dept
 WHERE emp.deptno = dept.deptno;
 
 deptno�� 10���� �����鸸 ��ȸ
 SELECT *
 FROM emp, dept
 WHERE emp.deptno = dept.deptno 
   AND emp.deptno = 10;
 
ANSI-SQL : JOIN with USING
 . join �Ϸ��� ���̺� �̸��� ���� �÷��� 2�� �̻��� ��
 . �����ڰ� �ϳ��� �÷����θ� �����ϰ� ���� �� ���� �÷����� ���
 
 SELECT *
 FROM emp JOIN dept USING (deptno);
 
ANSI - SQL : JOIN with ON
 . ���� �Ϸ��� �� ���̺� �÷����� �ٸ� ��
 . ON���� ����� ������ ���;
 
 SELECT *
 FROM emp JOIN dept ON (emp.deptno = dept.deptno);
 
 ORACLE �������� �� SQL�� �ۼ�
 SELECT *
 FROM emp, dept
 WHERE emp.deptno = dept.deptno;
 
 JOIN�� ������ ����
 SELF JOIN : �����Ϸ��� ���̺��� ���� ���� ��
 EMP ���̺��� ������ ������ ������ ��Ÿ���� ������ ������ mgr �÷��� �ش� ������ ������ ����� ����.
 �ش� ������ �������� �̸��� �˰���� ��.
 
 ANSI-SQL�� SQL ���� : �����Ϸ��� �ϴ� ���̺� EMP(����), EMP(������ ������)
                                ����� �÷� : ����.MGR = ������.EMPNO
                                 ==> ���� �÷� �̸��� �ٸ���(MGR, EMPNO)
                                    ==> NATURAL JOIN, JOIN WITH USING�� ����� �Ұ����� ����
                                        ==> JOIN with ON
                                        
SELECT *
FROM emp JOIN emp a ON (emp.mgr = a.empno);

NONEQUI JOIN : ����� ������ =�� �ƴҶ�

�׵��� WHERE���� ����� ������ : =, !-, <>, <-, <, >, >=, AND, OR, NOT, LIKE %, _, OR - IN, BETWEEN AND ==> >=, <=

SELECT *
FROM emp;

SELECT *
FROM salgrade;

SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp JOIN salgrade ON (emp.sal BETWEEN salgrade.losal AND salgrade.hisal);

==> ORACLE ���� �������� ����

SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal >= salgrade.losal AND emp.sal <= salgrade.hisal; 


join 0_0
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno
ORDER BY deptno;

SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept. deptno 
ORDER BY deptno;

join 0_1
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno AND emp.deptno IN(10, 30) AND dept.deptno IN(10, 30);

SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno IN(10, 30) AND dept.deptno IN(10, 30) AND emp.deptno = dept. deptno;

join 0_2
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno AND emp.sal > 2500
ORDER BY deptno;

SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept. deptno AND emp.sal > 2500
ORDER BY deptno;

join 0_3
emp,dept ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���
(�޿� 2500�ʰ�, ����� 7600���� ū ����);

SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno AND emp.sal > 2500 AND emp.empno > 7600
ORDER BY deptno;

SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept. deptno AND emp.sal > 2500 AND emp.empno > 7600
ORDER BY deptno;

join 0_4
emp, dept ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���
(�޿� 2500 �ʰ�, ����� 7600���� ũ��, RESEARCH �μ��� ���ϴ� ����);

SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept. deptno AND emp.sal > 2500 AND emp.empno > 7600 AND dept.dname = 'RESEARCH';

SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno AND emp.sal > 2500 AND emp.empno > 7600 AND dept.dname = 'RESEARCH';


join 1
SELECT *
FROM lprod;

SELECT lprod.lprod_gu, lprod.lprod_nm, prod.prod_id, prod.prod_name
FROM lprod JOIN prod ON prod.prod_lgu = lprod.lprod_gu;

SELECT lprod.lprod_gu, lprod.lprod_nm, prod.prod_id, prod.prod_name
FROM lprod, prod
WHERE prod.prod_lgu = lprod.lprod_gu;
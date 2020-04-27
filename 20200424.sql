NULLó�� �ϴ� ��� (4���� �߿� ���� ���Ѱɷ� �ϳ� �̻��� ���)
NVL, NVL2...

condition : CASE, DECODE

�����ȹ : �����ȹ�� ����, ���¼���

emp ���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� SALESMAN�� ��� SAL���� 5% �λ�� �ݾ��� ���ʽ��� ���� (ex : sal 100 -> 105)
�ش� ������ job�� MANAGER�̸鼭 deptno�� 10�̸� SAL���� 30% �λ�� �ݾ��� ���ʽ��� ����
                              �� ���� �μ��� ���ϴ� ����� 10% �λ�� �ݾ��� ���ʽ��� ���� (ex : sal 100 -> 110)
�ش� ������ job�� PRESIDENT�� ��� SAL���� 20% �λ�� �ݾ��� ���ʽ��� ���� (ex : sal 100 -> 120)
�׿� �������� sal��ŭ�� ����

DECODE�� ���

SELECT empno, ename, job, sal, deptno, DECODE(job, 'SALESMAN', SAL * 1.05, 'MANAGER', DECODE(deptno, 10, SAL * 1.3, SAL * 1.1), 'PRESIDENT', SAL * 1.2, SAL) bonus
FROM emp;


���� A = {10, 15, 18, 23, 24, 25, 29, 30, 35, 37}
�Ҽ� : {23, 29, 37}
��Ҽ� : [10, 15, 18, 24, 25, 30, 35}


GROUP FUNCTION
�������� �����͸� �̿��Ͽ� ���� �׷쳢�� ���� �����ϴ� �Լ�
�������� �Է¹޾� �ϳ��� ���� ����� ���δ�.
EX : �μ��� �޿� ���
    emp ���̺��� 14���� ������ �ְ�, 14���� ������ 3���� �μ�(10, 20, 30)�� ���� �ִ�.
    �μ��� �޿� ����� 3���� ������ ����� ��ȯ�ȴ�.
    
GROUP BY ����� ���� ���� : SELECT ����� �� �ִ� �÷��� ���ѵ�

SELECT �׷��� ���� �÷�, �׷��Լ�
FROM ���̺�
GROUP BY �׷��� ���� �÷�
[ORDER BY];

SELECT deptno,
        MAX(sal), --�μ����� ���� ���� �޿� ��
        MIN(sal), --�μ����� ���� ���� �޿� ��
        ROUND(AVG(sal),2), --�μ��� �޿� ���
        SUM(sal), --�μ��� �޿� ��
        COUNT(sal), --�μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT(*),--�μ��� ���� ��
        COUNT(mgr)
FROM emp
GROUP BY deptno;


�μ����� ���� ���� �޿� ��
SELECT deptno, MIN(ename), MAX(sal)
FROM emp
GROUP BY deptno;

* �׷� �Լ��� ���� �μ���ȣ �� ���� ���� �޿��� ���� ���� ������ ���� ���� �޿��� �޴� ����� �̸��� �� �� �� ����.
    ==> ���� WINDOW/�м� FUNCTION�� ���� �ذ� ����
    
emp ���̺��� �׷� ������ �μ���ȣ�� �ƴ� ��ü �������� �����ϴ� ���
SELECT 
        MAX(sal), --��ü ������ ���� ���� �޿� ��
        MIN(sal), --��ü ������ ���� ���� �޿� ��
        ROUND(AVG(sal),2), --��ü ������ �޿� ���
        SUM(sal), --��ü ������ �޿� ��
        COUNT(sal), --��ü ������ �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT(*),--��ü ���� ��
        COUNT(mgr)  --mgr �÷��� null�� �ƴ� �Ǽ�
FROM emp;

GROUP BY ���� ����� �÷���
    SELECT ���� ������ ������ ????
    
GROUP BY ���� ������� ���� �÷���
    SELECT ���� ������ ????
    
    �׷�ȭ�� ���þ��� ���ڿ�, ��� ���� SELECT ���� ǥ�� �� �� �ִ� (���� �ƴ�);
SELECT deptno, 'TEST', 1,
        MAX(sal), --��ü ������ ���� ���� �޿� ��
        MIN(sal), --��ü ������ ���� ���� �޿� ��
        ROUND(AVG(sal),2), --��ü ������ �޿� ���
        SUM(sal), --��ü ������ �޿� ��
        COUNT(sal), --��ü ������ �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT(*),--��ü ���� ��
        COUNT(mgr)  --mgr �÷��� null�� �ƴ� �Ǽ�
FROM emp
GROUP BY deptno;

GROUP �Լ� ����� NULL ���� ���ܰ� �ȴ�.
30�� �μ����� NULL���� ���� ���� ������ SUM(COMM)�� ���� ���������� ���� �� Ȯ�� �� �� �ִ�.
SELECT deptno, SUM(comm)
FROM emp
GROUP BY deptno;

10, 20�� �μ��� SUM(COMM) �÷��� NULL�� �ƴ϶� 0�� �������� NULLó��
* Ư���� ������ �ƴϸ� �׷��Լ� ������� NULL ó���� �ϴ� ���� ���ɻ� ����

NVL(SUM(comm), 0) : COMM�÷��� SUM �׷��Լ��� �����ϰ� ���� ����� NVL�� ����(1ȸ ȣ��)
SUM(NVL(comm), 0) : ��� COMM�÷��� NVL �Լ��� ������(�ش� �׷��� ROW�� ��ŭ ȣ��) SUM �׷��Լ� ����

SELECT deptno, SUM(NVL(comm, 0)), NVL(SUM(comm),0)
FROM emp
GROUP BY deptno;

single row �Լ��� where���� ����� �� ������
multi row �Լ�(group �Լ�)�� where���� ����� �� ����
GROUP BY �� ���� HAVING ���� ������ ���

single row �Լ��� WHERE ������ ��밡��
SELECT *
FROM emp
WHERE LOWER(ename) = 'smith'

�μ��� �޿� ���� 5000 �Ѵ� �μ��� ��ȸ;
SELECT deptno, SUM(sal)
FROM emp
WHERE SUM(sal) > 9000
GROUP BY deptno;

SELECT deptno, SUM(sal)
FROM emp
HAVING SUM(sal) > 9000
GROUP BY deptno;


SELECT
        MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal),2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mgr,
        COUNT(*) count_all
FROM emp;

SELECT  deptno,
        MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal),2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mgr,
        COUNT(*) count_all
FROM emp
GROUP BY deptno ;

SELECT TO_CHAR(hiredate, 'YYYYMM') hire_yyyy, COUNT(hiredate) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM')
ORDER BY TO_CHAR(hiredate, 'YYYYMM');

SELECT TO_CHAR(hiredate, 'YYYY') hire_yyyy, COUNT(hiredate) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY');


SELECT COUNT(dname) cmt
FROM dept;

SELECT COUNT(deptno) cnt
FROM (SELECT deptno
        FROM emp
        GROUP BY deptno);

SELECT *
FROM emp;


SELECT COUNT(*)
        FROM emp
        GROUP BY deptno;

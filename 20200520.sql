SELECT ename, sal, deptno, RANK() OVER(PARTITION BY deptno ORDER BY sal DESC) sal_rank
FROM emp;

RANK�����Լ� : RANK, DENSE_RANK, ROW_NUMBER
RANK : ���� ���ϱ�, ���� ���� ���ؼ��� ������ ������ �ο��ϰ� �ļ����� +1
        1���� 3���̸� 2��,3���� ���� �� �ļ����� 1��
DENSE_RANK : ���� ���ϱ�, ������ ���� ���ؼ��� ������ ������ �ο��ϰ� �ļ����� �״�� ����
        1���� 3���̸� �״��� �ļ����� 2��
ROW_NUMBER : ���ļ������ 1���� �������� ���� �ο�, ������ �ߺ��� ����.

ana1]
�μ� �� ��ũ ==> ��ü ���� ��� �޿� ��ũ
�μ� �� �޿��� ==> GROUP BY deptno
��ü ������ �޿��� ==> GROUP BY �Ⱦ�

SELECT ename, sal, deptno, 
       RANK() OVER(PARTITION BY deptno ORDER BY sal) sal_rank,
       DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal) sal_dense_rank,
       ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal) sal_row_rank
FROM emp;

SELECT ename, sal, deptno, 
       RANK() OVER(ORDER BY sal DESC, empno ASC) sal_rank,
       DENSE_RANK() OVER(ORDER BY sal DESC, empno ASC) sal_dense_rank,
       ROW_NUMBER() OVER(ORDER BY sal DESC, empno ASC) sal_row_number
FROM emp;


no_ana2]
�м��Լ��� ������� �ʰ� ���� �������θ� ������ ����
SELECT a.*, b.cnt
FROM
(SELECT empno, ename, deptno
 FROM emp) a,
 (SELECT deptno, COUNT(*) cnt
  FROM emp
  GROUP BY deptno) b
WHERE a.deptno = b.deptno
ORDER BY a.deptno, a.empno;

�м��Լ� - ������ ��� �����Լ�(�׷��Լ�) 5������ �м��Լ������� ����
�׷��Լ� - SUM, MAX, MIN, AVG, COUNT

SELECT empno, ename, deptno, COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;

ana2]

SELECT empno, ename, sal, deptno, ROUND(AVG(sal) OVER (PARTITION BY deptno), 2) avg_sal
FROM emp;

ana3~4]

SELECT empno, ename, sal, deptno,
        MAX(sal) OVER (PARTITION BY deptno) max_sal,
        MIN(sal) OVER (PARTITION BY deptno) min_sal
FROM emp;

�׷� �� ����� : 
LAG : Ư������ ����
LEAD : Ư������ ����

��ü���� �޿� �������� �ڽź��� �޿� ��ũ�� �Ѵܰ� ���� ����� �޿� ��������
��, �޿��� ���� ���� �Ի����ڰ� ��������� ���ǰ� ���� ������ ���
SELECT empno, ename, hiredate, sal,
        LEAD(sal) OVER(ORDER BY sal DESC, hiredate ASC) lead_sal
FROM emp
ORDER BY sal DESC;


ana5]

SELECT empno, ename, hiredate, sal,
        LAG(sal) OVER(ORDER BY sal DESC, hiredate ASC) lead_sal
FROM emp
ORDER BY sal DESC;

ana6]

SELECT empno, ename, hiredate, job, sal,
        LAG(sal) OVER(PARTITION BY job  ORDER BY sal DESC, hiredate ASC) lead_sal
FROM emp;

no_ana3]
SELECT a.empno, a.ename, a.sal, SUM(b.sal) c_sum
FROM
(SELECT a.*, ROWNUM rn
 FROM
    (SELECT empno, ename, sal
     FROM emp
     ORDER BY sal) a) a,
     
(SELECT a.*, ROWNUM rn
 FROM
    (SELECT empno, ename, sal
     FROM emp
     ORDER BY sal) a) b
WHERE a.rn >= b.rn
GROUP BY a.empno, a.ename, a.sal
ORDER BY a.sal ASC;


�׷� �� ����� - WINDOWING
SELECT empno, ename, deptno, sal, --****�Ʒ��������� ��õ****
        SUM(sal) OVER(ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum
FROM emp;

SELECT empno, ename, deptno, sal,
        SUM(sal) OVER(ORDER BY sal ROWS UNBOUNDED PRECEDING) c_sum
FROM emp;

������ �� ����
EX: ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING

SELECT empno, ename, deptno, sal,
        SUM(sal) OVER(ORDER BY sal ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) c_sum
FROM emp;


ana7]
SELECT empno, ename, deptno, sal,
        SUM(sal) OVER(PARTITION BY deptno ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum
FROM emp;

WINDOWING
ROWS : ������ ROW�� ��Ī
RANGE : ������ ROW�� ��Ī
DEFAULT : 
SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING) rows_sum,
        SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING) range_sum
        --SUM(sal) OVER (ORDER BY sal DEFAULT UNBOUNDED PRECEDING) default_sum
FROM emp;


���� ������
SELECT LPAD(' ', (LEVEL-1)*4) || org_cd org_cd, total
FROM
    (SELECT org_cd, parent_org_cd, lv, SUM(total) total
    FROM
        (SELECT a.*, SUM(no_emp_c) OVER (PARTITION BY gp ORDER BY rn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) total
        FROM
            (SELECT a.*, ROWNUM rn, lv + ROWNUM gp,
                    COUNT(*) OVER (PARTITION BY org_cd) cnt,
                    no_emp / COUNT(*) OVER (PARTITION BY org_cd) no_emp_c
            FROM
                (SELECT org_cd, parent_org_cd, no_emp,
                        CONNECT_BY_ISLEAF leaf, LEVEL lv
                 FROM no_emp
                 START WITH org_cd = 'XXȸ��'
                 CONNECT BY PRIOR org_cd = parent_org_cd) a
            START WITH leaf = 1
            CONNECT BY PRIOR parent_org_cd = org_cd) a)
    GROUP BY org_cd, parent_org_cd, lv)
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;


SELECT *
FROM TABLE(dbms_xplan.display);

ROWID - ���̺� ���� ����� �����ּ�(java - �ν��Ͻ� ����, c - ������);
SELECT ROWID, emp.*
FROM emp;

����ڿ� ���� ROWID ���
SELECT *
FROM emp
WHERE ROWID = 'AAAE5xAAFAAAAEUAAF';

2-1-0

Plan hash value: 2949544139
 
--------------------------------------------------------------------------------------
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    87 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    87 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("EMPNO"=7369)
   
   
   

INDEX �ǽ�
emp���̺� ���� ������ pk_emp PRIMARY KEY ���������� ����
ALTER TABLE emp DROP CONSTRAINT pk_emp;

�ε��� ���� empno ���� �̿��Ͽ� ������ ��ȸ

EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE empno = 7782;



2. emp ���̺� empno �÷����� PRIMARY KEY  �������� ���� �� ���
    (empno�÷����� ������ unique �ε����� ����);
    
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno); 

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);


3. 2�� SQL�� ����

2��
SELECT *
FROM emp
WHERE empno = 7782;


3��
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;


SELECT *
FROM TABLE(dbms_xplan.display);

4. empno�÷��� non_unique �ε����� �����Ǿ� �ִ� ���
ALTER TABLE emp DROP CONSTRAINT pk_emp;

CREATE INDEX idx_emp_01 ON emp (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);


5. emp ���̺��� job ���� ��ġ�ϴ� �����͸� ã�� ���� ��
���� �ε���
idx_emp_01 : empno

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     3 |   261 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     3 |   261 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("JOB"='MANAGER')
 
idx_emp_01�� ��� ������ empno�÷� �������� �Ǿ� �ֱ� ������ job �÷��� �����ϴ� SQL������ ȿ�������� ����� ���� ���� ������
TABLE ��ü �����ϴ� ������ �����ȹ�� ������

==> idx_emp_02(job) ������ �� �� �����ȹ ��
CREATE INDEX idx_emp_02 ON emp(job);

SELECT *
FROM TABLE (dbms_xplan.display);

Plan hash value: 4079571388
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     3 |   261 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     3 |   261 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_02 |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER')
 
 


6. emp���̺��� job='MANAGER' �̸鼭 ename �� C�� �����ϴ� ����� ��ȸ
�ε��� ��Ȳ
idx_emp_01 : empno
idn_emp_02 : job

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER' AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 4079571388
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    87 |     2   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    87 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_02 |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("ENAME" LIKE 'C%')
   2 - access("JOB"='MANAGER')
 



7. emp���̺��� job='MANAGER' �̸鼭 ename �� C�� �����ϴ� ����� ��ȸ(��ü�÷� ��ȸ)
��, ���ο� �ε��� �߰� : idx_emp_03 : job, ename;
CREATE INDEX idx_emp_03 ON emp (job, ename);


�ε��� ��Ȳ
idx_emp_01 : empno
idx_emp_02 : job
idx_emp_03 : job, ename

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER' 
  AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);



8. emp���̺��� job='MANAGER' �̸鼭 ename �� C�� ������ ����� ��ȸ(��ü�÷� ��ȸ)

�ε��� ��Ȳ
idx_emp_01 : empno
idx_emp_02 : job
idx_emp_03 : job, ename;

EXPLAIN PLAN FOR
SELECT /*+ INDEX(emp IDX_EMP_03) */*
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE '%C';

SELECT *
FROM TABLE(dbms_xplan.display);


9.���� �÷� �ε����� �÷� ������ �߿伺
�ε��� ���� �÷� : (job, ename) VS (ename, job)
*** �����ؾ� �ϴ� sql�� ���� �ε��� �÷� ������ �����ؾ� �Ѵ�.

���� sql : job = manager, enam�� C�� �����ϴ� ��� ������ ��ȸ(��ü �÷�)
���� �ε��� ���� : idx_emp_03;
DROP INDEX idx_emp_03;
�ε��� �ű� ����
idx_emp_04 : ename, job

CREATE INDEX idx_emp_04 ON emp(ename, job);

�ε��� ��Ȳ
idx_emp_01 : empno
idx_emp_02 : job
idx_emp_04 : ename, job;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE 'c%';
  
SELECT *
FROM TABLE(dbms_xplan.display);


���ο����� �ε���
idx_emp_01 ����(pk_emp �ε����� �ߺ�)
DROP INDEX idx_emp_01;

emp ���̺� empno �÷��� PIMARY KEY�� �������� ����
pk_emp : empno
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);



�ε��� ��Ȳ
pk_emp : empno
idx_emp_02 : job
idx_emp_04 : ename, job;

(��� ���� ��ȸ��)
EXPLAIN PLAN FOR
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

EXPLAIN PLAN FOR
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.empno = 7788;

NESTED LOOP JOIN
HASH JOIN
SORT MERGE JOIN

SELECT *
FROM TABLE(dbms_xplan.display);

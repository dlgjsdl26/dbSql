CREATE TABLE DEPT_TEST2 AS
SELECT *
FROM dept
WHERE 1=1;

SELECT *
FROM dept_test2;

idx1]
CREATE UNIQUE INDEX idx_u_dept_test2_01 ON dept_test2 (deptno);
CREATE INDEX idx_dept_test2_02 ON dept_test2 (dname);
CREATE INDEX idx_dept_test2_03 ON dept_test2 (deptno, dname);

idx2]
DROP INDEX idx_u_dept_test2_01;
DROP INDEX idx_dept_test2_02;
DROP INDEX idx_dept_test2_03;

idx3]
CREATE UNIQUE INDEX idx_emp_01 ON emp (empno);
CREATE INDEX idx_emp_02 ON emp (ename);
CREATE INDEX idx_emp_03 ON emp (deptno, sal, empno);
CREATE INDEX idx_emp_04 ON emp (deptno, hiredate);


empno(=)

ename(=)

deptno(=), empno(like ' %')

deptno(=), sal(between)

deptno(=), empno(=)

deptno, hiredate


idx4]

CREATE UNIQUE INDEX idx_u_emp_01 ON emp (empno);
CREATE INDEX idx_emp_02 ON emp (deptno, empno, sal);
CREATE UNIQUE INDEX idx_u_dept_01 ON dept (deptno);
CREATE INDEX idx_dept_02 ON dept (loc);

emp
empno(=)

deptno(=), empno(like)

deptno(=), sal(between)

deptno(=)

dept
deptno(=)

loc(=)






�����ȹ

�����ð��� ��� ����
==> ������ ���� ���¸� �̾߱� ��, ������� �̾߱Ⱑ �ƴ�
inner join : ���ο� �����ϴ� �����͸� ��ȸ�ϴ� ���� ���
outer join : ���ο� �����ص� ������ �Ǵ� ���̺��� �÷������� ��ȸ�ϴ� ���� ���
cross join : ������ ����(īƼ�� ������Ʈ), ���� ������ ������� �ʾƼ�
             ���� ������ ��� ����� ���� ���εǴ� ���
self join : ���� ���̺��� �����ϴ� ����

�����ڰ� DBMS�� SQL�� ���� ��û �ϸ� DBMS�� SQL�� �м��ؼ� ��� �� ���̺��� �������� ����,
3���� ����� ���� ���(������ ���� ���, ������� �̾߱�)
1. Nested Loop Join
2. Sort Merge Join
3. Hash Join

(OLTP) OnLine Transaction Processing : �ǽð� ó�� ==> ������ ����� �ϴ� �ý���(�Ϲ����� �� ����)
(OLAP) OnLine Analysis Processing : �ϰ�ó�� ==> ��ü ó���ӵ��� �߿��� ���(���� ���� ���, ���� �ѹ��� ���)
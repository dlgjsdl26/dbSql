SELECT ���� ���� :
    ��¥ ����(+, -) : ��¥ + ����, -���� : ��¥���� +-������ �� ���� Ȥ�� �̷������� ����Ʈ Ÿ�� ��ȯ
    ���� ����(....) : �����ð��� �ٷ��� ����...
    ���ڿ� ����
        ���ͷ� : ǥ����
                    ���� ���ͷ� : ���ڷ� ǥ��
                    ���� ���ͷ� : java : "���ڿ�" / sql : 'sql'
                    
            ���ڿ� ���տ��� : +�� �ƴ϶� ||   (java ������ +)
        ��¥?? : TO_DATE('��¥���ڿ�', '��¥ ���ڿ��� ���� ����')
                TO_DATE('20200417', 'YYYYMMDD')
                
WHERE : ����� ���ǿ� �����ϴ� �ุ ��ȸ �ǵ��� ����;

SELECT *
FROM users
WHERE userid = 'brown';

sal���� 1000���� ũ�ų� ����, 2000���� �۰ų� ���� ������ ��ȸ ==> BETWEEN AND;
�񱳴�� �÷�/ �� BETWEEN ���۰� AND ���ᰪ
���۰��� ���ᰪ�� ��ġ�� �ٲٸ� ���� �������� ����

sal >= 1000
sal <=2000
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

SELECT *
FROM sal >=1000
AND sla <= 2000;

SELECT ename, hiredate
FROM emp
WHERE hiredate >='19820101'
AND hiredate <='19830101';

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN '19820101' AND '19830101';

IN ������
�÷�|Ư���� IN(��1, ��2,....)
�÷��̳� Ư������ ��ȣ�ȿ� ���߿� �ϳ��� ��ġ�� �ϸ� TRUE

SELECT *
FROM emp
WHERE deptno IN (10, 30);
==> deptno�� 10�̰ų� 30���� ����
deptno = 10 OR deptno = 30

SELECT *
FROM emp
WHERE deptno = 10
    OR deptno = 30;
    
SELECT userid "���̵�", usernm "�̸�", alias "����"
FROM users
WHERE userid IN ('brown', 'cony', 'sally');

���ڿ� ��Ī ���� : LIKE���� : JAVA : .startsWith(prefix), .endsWith(suffix)
����ŷ ���ڿ� : % -��� ���ڿ�(���� ����)
              _ - � ���ڿ��̵��� �� �ϳ��� ����
���ڿ��� �Ϻΰ� ������ TRUE

�÷�|Ư���� LIKE ���� ���ڿ�;

'cony' : cony�� ���ڿ�
'co%' : ���ڿ��� co�� �����ϰ� �ڿ��� � ���ڿ��̵� �� ���ִ� ���ڿ�
        'cony', 'con', 'co'
'%co%' : co�� �����ϴ� ���ڿ�
        'cony', 'sally cony'
'co__' : co�� �����ϰ� �ڿ� �ΰ��� ���ڰ� ���� ���ڿ�
'_on_' : ��� �α��ڰ� on�̰� �յڷ� � ���ڿ��̵��� �ϳ��� ���ڰ� �ü� �ִ� ���ڿ�

���� �̸�(ename)�� �빮�� S�� �����ϴ� ������ ��ȸ
SELECT *
FROM emp
WHERE ename LIKE 'S%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%��%';

NULL ��
SQL �񱳿����� : =
    WHERE usernm = 'brown'
    
MGR�÷� ���� ���� ��� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr = null;

SQL���� NULL ���� ���� ��� �Ϲ�����
�񱳿�����(=)�� ��� ���ϰ� IS �����ڸ� ���

SELECT *
FROM emp
WHERE mgr IS NULL;

���� �ִ� ��Ȳ���� � �� : =, !=, <>
NULL : IS NOT NULL

emp���̺��� mgr �÷� ���� NULL�� �ƴ� ������ ��ȸ

SELECT *
FROM emp
WHERE mgr IS NOT NULL;

SELECT*
FROM emp
WHERE comm IS NOT NULL;

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839,NULL);

IN�����ڸ� �� �����ڷ� ����

SELECT *
FROM emp
WHERE mgr IN (7698, 7839,NULL);
==> WHERE mgr = 7698 OR mgr = 7839

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839);
==> WHERE (mgr != 7698 AND mgr != 7839)

SELECT *
FROM emp
WHERE (job = 'SALESMAN' AND hiredate >= '19810601');

SELECT *
FROM emp
WHERE (deptno != 10 AND hiredate >= '19810601');

SELECT *
FROM emp
WHERE (deptno IN (20, 30) AND hiredate >= '19810601');

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR hiredate >= '19810601';

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE ('78%');

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno >=7800 AND empno < 7900;

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno >=7800 AND empno < 7900 AND hiredate >= '19810601';

table���� ��ȸ, ����� ������ ����(�������� ����)
==> ���нð��� ���հ� ������ ����

SQL������ �����͸� �����Ϸ��� ������ ������ �ʿ�
ORDER BY �÷��� [��������], �÷���2[��������]....

������ ���� : ��������(DEFAULT) - ASC, �������� - DESC

���� �̸����� ���� ��������
SELECT *
FROM emp
ORDER BY ename ASC;

���� �̸����� ���� ��������
SELECT *
FROM emp
ORDER BY ename DESC;

job�� �������� ���� ���������ϰ� job�� ������� �Ի��Ϸ� �������� ����
��� ������ ��ȸ

SELECT *
FROM emp
ORDER BY job ASC , hiredate DESC;
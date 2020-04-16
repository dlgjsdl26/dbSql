SELECT*   --��� �÷������� ��ȸ
FROM prod;  --�����͸� ��ȸ�� ���̺� ���

Ư�� �÷��� ���ؼ��� ��ȸ : SELECT �÷�1, �÷�2....
prod_id, prod_name�÷��� prod ���̺��� ��ȸ;

SELECT prod_id, prod_name
FROM prod;

--select 1
SELECT *
FROM prod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;

SQL ���� : JAVA�� �ٸ��� ���� X, �Ϲ��� ��Ģ����

SQL ������ Ÿ�� : ����, ����, ��¥(date)

USERS ���̺��� (4/14 ����� ����) ����
USERS ���̺��� ��� �����͸� ��ȸ;

��¥ Ÿ�Կ� ���� ���� : ��¥�� +, - ���갡��
date type + ���� : date���� ������¥��ŭ �̷� ��¥�� �̵�
date type - ���� : date���� ������¥��ŭ ���� ��¥�� �̵�;

SELECT userid, reg_dt + 5
FROM users;

�÷� ��Ī : ���� �÷����� ���� �ϰ� ���� ��
syntax : ���� �÷��� [as] ��Ī��Ī
��Ī ��Ī�� ������ ǥ���Ǿ�� �� ��� ���������̼����� ���´�
���� ����Ŭ������ ��ü���� �빮�� ó�� �ϱ� ������ �ҹ��ڷ� ��Ī�� �����ϱ� ���ؼ��� ���� �����̼��� ����Ѵ�.;


SELECT userid as id, userid id2, userid ���̵�
FROM users;

SELECT lprod_id as "id", lprod_name "name"
FROM lprod;

SELECT prod_gu as "gu", 1prod_nm "nm"
FROM prod;

SELECT buyer_id "���̾���̵�", buyer_name "�̸�"
FROM buyer;

���ڿ� ����(���տ���) :|| (���ڿ� ������ + �����ڰ� �ƴϴ�);
SELECT /*userid + 'test'*/userid || 'test', reg_dt + 5, 'test', 15
FROM users;

�� �̸� ��
SELECT '�� ' || userid || ' ��'
FROM users;

SELECT userid || usernm id_name, CONCAT(userid, usernm) concat_id_name
FROM users;

sel_con1]
user_tables : oracle�� �����ϴ� ���̺� ������ ��� �ִ� ���̺�(view) ==> data dictionary;

SELECT table_name
FROM user_tables;

SELECT 'SELECT * FROM ' || table_name || ';' query
FROM user_tables;

���̺��� ���� �÷��� Ȯ��
1. tool(sql developer)�� ���� Ȯ��
    ���̺� - Ȯ���ϰ��� �ϴ� ���̺�
2. SELECT *
    FROM ���̺�
    �ϴ� ��ü ��ȸ --> ��� �÷��� ǥ��
3. DESC ���̺��
4. data dictionary : user_tab_columns;

DESC emp;

SELECT *
FROM user_tab_columns;

���ݱ��� ��� SELECT ����
��ȸ�ϰ��� �ϴ� �÷� ��� : SELECT
��ȸ�� ���̺� ��� : FROM
��ȸ�� ���� �����ϴ� ������ ��� : WHERE
WHERE ���� ����� ������ ��(TRUE)�� �� ����� ��ȸ

java�� �񱳿��� : a������ b������ ���� ������ �� ==
sql�� �� ���� : =

SELECT *
FROM users
WHERE userid = 'cony';

emp���̺��� �÷��� ������ Ÿ���� Ȯ��;
DESC emp;

SELECT *
FROM emp;
emp : employee
empno : �����ȣ
ename : ����̸�
job : ������(��å)
mgr : �����(������)
hiredate : �Ի糯¥
sal : �޿�
comm : ������
deptno : �μ���ȣ

SELECT *
FROM dept;

DESC emp;

emp ���̺��� ������ ���� �μ���ȣ�� 30������ ū(<) �μ��� ���� ������ ��ȸ;

SELECT *
FROM emp
WHERE deptno >= 30;

!= �ٸ���
users ���̺��� ����� ���̵�(usersid)�� brown�� �ƴ� ����ڸ� ��ȸ
SELECT*
FROM users
WHERE userid != 'brown';


SQL ���ͷ�
���� : ....20, 30, 40.5
���� : �̱� �����̼� : 'hello world'
��¥ : TO_DATE('��¥���ڿ�', '��¥ ���ڿ��� ����');


1982�� 1�� 1�� ���Ŀ� �Ի��� ������ ��ȸ
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'YYYYMMDD');
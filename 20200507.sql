DDL : Data Definition Language
�����͸� �����ϴ� ���
CREATE, DROP, ALTER

**********************************
DDL�� ���� �ڵ� Ŀ��(ROLLBACK �Ұ�)
**********************************


���̺� ����
���� : DROP TABLE ������ ���̺��;

ranger ���̺� ����

DROP TABLE ranger;

���̺� ��� Ȯ��(refresh)

DDL�� ROLLBACK �Ұ�

SELECT *
FROM ranger;

TABLE ����
����
CREATE TABLE [������.]���̺��(
    �÷���1 �÷�Ÿ�� DEFAULT ������ �⺻��,
    �÷���2 �÷�Ÿ��,
    ....
    �÷���3 �÷�Ÿ��);
    
ranger���̺��� ������ ���� �÷����� ����
ranger_no �÷��� NUMBER Ÿ������
ranger_nm �÷��� VARCHAR2(50) Ÿ������
reg_dt �÷��� DATE Ÿ������ (�� �⺻���� �Է´���� ������ ���� �ð�)


CREATE TABLE ranger(
    ranger_no NUMBER,
    ranger_nm VARCHAR2(50),
    reg_dt DATE DEFAULT SYSDATE
);

SELECT *
FROM ranger;

ranger_ no 1
ranger_nm 'brown'

INSERT INTO ranger (ranger_no, ranger_nm) VALUES(1, 'brown');
reg_dt

member ���̺� �����̶�� �÷��� ���� ��
���� �÷��� �� �� �ִ� �� : ����, ����, ����


�������� : �������� ���Ἲ�� ��Ű�� ���� ����
��4���� ���������� ����
    UNIQUE : ������ �÷��� ���� �ٸ� ���� ���� �ߺ����� �ʵ��� ����
            ex : ���, �й�;
    PRIMARY KEY : UNEQUE���� + NOT NULL CHECK ����
            ���� �����ؾ� �ϸ�, ���� �ݵ�� ���;� �ϴ� �÷�
            ex : ���, �й�;
    FOREIGN KEY : �ش� �÷��� �����ϴ� ���̺��� ���� �����ϴ��� Ȯ���ϴ� ����
            ex : emp���̺� �űԻ���� ��Ͻ� deptno ���� dept ���̺� �ݵ�� �����ϴ� ���� ����� �����ϴ�.
    CHECK : �÷��� �ԷµǴ� ���� �����ڰ� ���� ������ ���� üũ, ���� �ϴ� ����
            ex : ���� �÷��� ���� F, M �ΰ��� ���� �� �� �ֵ��� ����;
            
���������� �����ϴ� ���
1. ���̺� ������ �÷� �����ٰ� �ش� �÷��� ����� ���������� ���
    ==> �����÷� ������ �Ұ�
2. ���̺� ������ �÷� ����� ������ �ش� ���̺� ����� ���������� ���
    ==> �����÷� ���� ����
3. ���̺� ���� ����, ������ �������Ǹ� �ش� ���̺� ����
    ==> ���̺� ����, �����÷� ���� ����
    

1. ���̺� ������ �÷� ���� ���������� ���

�μ���ȣ�� �ߺ��� �Ǹ� �ȵǰ�, ���� ��� �־�� �ȵȴ�(�Ϲ�������)
==> dbms���� ���� ������ PRIMARY KEY ���������� �÷� ������ ����

DROP TABLE dept_test;

�������� �̸��� ������� ���� ��� ����Ŭ DBMS�� �ڵ����� �������� �̸��� �ٿ��ش�.
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR(13)
);

SELECT *
FROM dept_test;

INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
�� ������ ���������� ����
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
�� ������ ù��° �������� �Է��� �μ���ȣ�� �ߺ� �Ǳ� ������
PRIMARY KEY(UNIQUE) �������ǿ� ����Ǿ� ���������� �����Ͱ� �Էµ��� �ʴ´�
    ==>�츮�� ������ ������ ���Ἲ�� ��������.

DROP TABLE dept_test;

�������� �̸��� ����� ���� �ִ�.
�ش� ������ �������� ��� ��Ģ�� ����� �Ѵ�.
PRIMARY KEY : pk_���̺��
UNIQUE : u_���̺��
FOREIGN KEY : fk_���̺��_�������̺��
NOT NULL, CHECK : ������ �̸��� ������� �ʴ´�.

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR(13)
);

2. ���̺� ������ �÷� ����� ������ �ش� ���̺� ����� ���������� ���
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR(13),

    CONSTRAINT pk_dept_test PRIMARY KEY (deptno, dname)
);
dept_test ���̺� deptno, dname���� PRIMARY KEY ���������� ����
�ΰ� �÷��� ��� ���ƾ����� �ߺ��Ǵ� ������ �ν�

INSERT INT dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INT dept_test VALUES (99, 'ddit2', 'daejeon');

deptno, dname �÷��� ��� ���� ���� ����
INSERT INT dept_test VALUES (99, 'ddit2', 'daejeon');

SELECT*
FROM deptno_test;
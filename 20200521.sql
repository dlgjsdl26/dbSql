ȣ��ȣ
10��, 1~2ȸ�簡 PL/SQLȸ�縦 ��ȣ

PL/SQL ==> PL/SQL�� �����ϴ� ���� ����Ŭ ��ü
            �ڵ� ��ü�� ����Ŭ�� ����(����Ŭ ��ü�ϱ�)
            ������ �ٲ� �Ϲ� ���α׷��� ���(java)�� ���� �� �ʿ䰡 ����
SQL ==> SQL������ �Ϲ� ���� ����(java)
        .���� sql�� ���õ� ������ �ٲ�� java������ ������ ���ɼ��� ŭ
        

PL/SQL : Procedual Language / Structured Query Language
SQL : ������, ������ ����(�̺��ϰ� ����,CASE, DECODE..FOR)

������ �ϴٺ��� � ���ǿ� ���� ��ȸ�ؾ��� ���̺� ���װ� �ٲ�ų�, ������ ��ŵ�ϴ� ���� �������� �κ��� �ʿ� �� ���� ����

�������� : �ҵ��� 25%�� �ſ�ī�� + ���ݿ����� + üũī���� �Һ� �Һ�ݾ��� �ҵ��� 25%�� �ʰ��ϴ� �ݾ׿� ���ؼ�
          �ſ�ī��� ���� : 20%, ���ݿ������� 30%, üũī�� 25%�� �����ϴ� 
          ��, �����ݾ��� 300������ ���� �� ����
          ��, ���߱��뿡 ���� �߰������� 100������ ���� ���� �� �ְ�
          ��, ������忡 ���ݿ� ���ؼ��� �߰������� 100������ ���� ���� �� �ִ�;
          
DBMS�󿡼� ���Ͱ��� ������ ������ SQL�� �ۼ��ϴµ��� ������ ����(��������)
�Ϲ����� ���α׷��� ���� ����ϴ� ��������(if, case), �ݺ���(for, while), �������� Ȱ�� �� �� �ִ� PL/SQL �� ����

*���� : �򰥸� ����

java =
pl/sql :=


java���� sysout ==> console�� ���
PL/SQL���� ����
SET SERVEROUTPUT ON; �α׸� �ܼ�â�� ��°����ϰԲ� �ϴ� ����

SET SERVEROUTPUT ON;

PL/SQL block�� �⺻����
DECLARE - ����� (���� ���� ����, ��������)
BEGIN - ����� (������ �����Ǵ� �κ�)
EXCEPTION - ���ܺ�(���ܰ� �߻� ���� �� CATCH�Ͽ� �ٸ� ������ �����ϴ� �κ�(java try-catch)


pl/sql �͸�(�̸��� ����, ��ȸ��) ���


������ Ÿ�� ����
v_deptno, v_dname �ΰ��� ���� ���� ==> dept ���̺��� �÷� ���� �������� ����
                                 ==> dept ���̺��� �÷� ������ Ÿ�԰� �����ϰ� ���� �ϰ� ���� ��Ȳ;
������ Ÿ���� ���� �������� �ʰ� ���̺��� �÷� Ÿ���� ���� �ϵ��� ���� �� �� �ִ�.
==> ���̺� ������ �ٲ� pl/sql ��Ͽ� ����� ������ Ÿ���� �������� �ʾƵ� �ڵ����� ����ȴ�.

���̺��. �÷���%TYPE;
DECLARE
    /*JAVA : ����TYPE ������
    PL/SQL : ������ ����TYPE;*/
    
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
BEGIN
    /*dept ���̺��� 10�� �μ��� �ش��ϴ� �μ���ȣ, �μ����� DECLARE���� ������ �ΰ��� ������ ���*/
    
    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno = 10;
    
    /*JAVA�� SYSOUT*/
    /*System.out.println(v_deptno + "   " + v_dname);*/
    DBMS_OUTPUT.PUT_LINE(v_deptno || '   '  || v_dname);
END;
/

��¥�� �Է¹޾� ==> ��ȸ���� �������������� 5�ϵ��� ��¥�� �����ϴ� �Լ�
    ȸ�縸�� Ư���� ������ �ʿ��� ��� �Լ��� ���� �� �ִ�.


PROCEDURE : �̸��� �ִ� PL/SQL ���, ���ϰ��� ����
            ������ ���� ó���� �����͸� �ٸ� ���̺� �Է��ϴ� ���� ����Ͻ� ������ ó�� �� �� ���
            ����Ŭ ��ü ==> ����Ŭ ������ ������ �ȴ�.
            ������ �ִ� ������� ���ν��� �̸��� ���� ������ ����


CREATE OR REPLACE PROCEDURE printdept (p_deptno IN dept.deptno%TYPE) IS
--�����
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
BEGIN
        SELECT deptno, dname INTO v_deptno, v_dname
        FROM dept
        WHERE deptno = p_deptno;
        
        DBMS_OUTPUT.PUT_LINE(v_deptno || '  ' || v_dname);
END;
/

���ν��� ���� ��� : EXEC ���ν����̸�;
EXEC printdept;

���ڰ� �ִ� printdept ����
EXEC printdept(20);

PL/SQL ������ SELECT ������ ���� ���� �� �����Ͱ� �Ѱǵ� �ȳ��� ��� NO_DATA_FOUND ���ܸ� ������.


CREATE OR REPLACE PROCEDURE printemp (e.empno IN emp.empno%TYPE) IS

SELECT *
FROM dept;

CREATE OR REPLACE PROCEDURE printemp (p_empno IN emp.empno%TYPE) IS
    v_ename emp.ename%TYPE;
    v_dname dept.dname%TYPE;
BEGIN
        SELECT ename, dname INTO v_ename, v_dname
        FROM emp, dept
        WHERE emp.deptno = dept.deptno
          AND empno = p_empno;
        DBMS_OUTPUT.PUT_LINE(v_ename || '  ' || v_dname);
END;
/
EXEC printemp(7499);


SELECT *
FROM dept_test;

CREATE OR REPLACE PROCEDURE registdept_test (p_deptno IN dept.deptno%TYPE, p_dname IN dept.dname%TYPE, p_loc IN dept.loc%TYPE) IS
BEGIN
    INSERT INTO dept_test VALUES(p_deptno, p_dname, p_loc);
    COMMIT;
END;
/
EXEC registdept_test(99, 'ddit', 'daejeon');
SELECT *
FROM dept_test;

CREATE OR REPLACE PROCEDURE UPDATEdept_test (p_deptno IN dept.deptno%TYPE, p_dname IN dept.dname%TYPE, p_loc IN dept.loc%TYPE) IS
BEGIN
    UPDATE INTO dept_test VALUES(p_deptno, p_dname, p_loc);
    COMMIT;
END;
/



���պ���
��ȸ����� �÷��� �ϳ��� ������ ��� �۾� ���ŷӴ� ==> ���� ������ ����Ͽ� �������� �ؼ�

0. %TYPE : �÷�
1. %ROWTYPE : Ư�� ���̺��� ���� ��� �÷��� ������ �� �ִ� ���� ���� Ÿ��
   (���� %TYPE - Ư�� ���̺��� �÷� Ÿ���� ����)
2. PL/SQL RECORD : ����ڰ� ���� �����Ҽ� �ִ� Ÿ��, �÷��� �����ڰ� ���� ���
                    ���̺��� ��� �÷��� ����ϴ°� �ƴ϶� �÷��� �Ϻθ� ����ϰ� ���� ��
3. PL/SQL TABLE TYPE : �������� ��, �÷��� ������ �� �ִ� Ÿ��

%ROWTYPE
�͸������ dept ���̺��� 10�� �μ������� ��ȸ�Ͽ� %ROWTYPE���� ������ ������ ������� �����ϰ�
DBMS_OUTPUT.PUT_LINE�� �̿��Ͽ� ���

SELECT *
FROM dept
WHERE deptno=10;

DECLARE
        v_dept_row dept%ROWTYPE;
BEGIN
        SELECT * INTO v_dept_row
        FROM dept
        WHERE deptno=10;
        
        DBMS_OUTPUT.PUT_LINE(v_dept_row.deptno || ' / ' || v_dept_row.dname || ' / ' || v_dept_row.loc);
END;
/


2. record : ���� �����Ҽ� �ִ� ����Ÿ��, �÷� ������ �����ڰ� ���� ������ �� �ִ�.
dept���̺��� deptno, dname �ΰ� �÷��� ������� �����ϰ� ���� ��


DECLARE
    --deptno, dname �÷� �ΰ��� ���� ������ �� �ִ� TYPE�� ����
    TYPE dept_rec IS RECORD(
        deptno dept.deptno%TYPE,
        dname dept.dname%TYPE);
        
    --���Ӱ� Ÿ������ ������ ���� (class ����� �ν��Ͻ� ����)
   v_dept_rec dept_rec;
BEGIN
    SELECT deptno, dname INTO v_dept_rec
    FROM dept
    WHERE deptno = 10;

    DBMS_OUTPUT.PUT_LINE(v_dept_rec.deptno || ' / ' || v_dept_rec.dname);
END;
/


�������� ������ �� ��
SELECT ����� �������̱� ������ �ϳ��� �� ������ ���� �� �ִ� ROWTYPE �������� ���� ���� ���� ���� ���� �߻�
==> ���� ���� ������ �� �ִ� TABLE TYPE ���

DECLARE
        v_dept_row dept%ROWTYPE;
BEGIN
        SELECT * INTO v_dept_row
        FROM dept
        WHERE deptno=10;
        
        DBMS_OUTPUT.PUT_LINE(v_dept_row.deptno || ' / ' || v_dept_row.dname || ' / ' || v_dept_row.loc);
END;
/

TABLE TYPE : �������� ������ �� �ִ� Ÿ��
���� : TYPE Ÿ�Ը� IS TABLE OF �� Ÿ�� INDEX BY �ε����� Ÿ��;
dept���̺��� �� ������ ������ �� �ִ� ���̺� TYPE

    java���� �迭 �ε���
    int[] intArray = new int[50];
    intArray[0]
    java������ �ε����� �翬�� ����
    
    intArray["ù��°"] = 50;
    System.out.println(intArray["ù��°"];
    
    MAP<String, Dept> deptMap = new HashMap<String, Dept>();
    deptMap.put("ù��°", new Dept());
    
    PL/SQL������ �ΰ��� Ÿ���� ���� : ����(BINARY_INTEGER), ���ڿ�(VARCHAR(2))

    TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER
    
DECLARE
    TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dept dept_tab;
BEGIN
    SELECT * BULK COLLECT INTO v_dept
    FROM dept;
END;
/
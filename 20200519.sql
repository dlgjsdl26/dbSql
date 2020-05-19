'202005' ==> �Ϲ����� �޷��� row, col;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno);

JOIN ������ ��
CROSS JOIN : ������ ���� �Ҷ�...

�μ���ȣ��, ��ü �� �� SAL ���� ���ϴ� 3��° ���
SELECT DECODE(lv, 1, deptno, 2, null) deptno, SUM(sal) sal
FROM emp, (SELECT LEVEL lv
           FROM dual
           CONNECT BY LEVEL <= 2)
GROUP BY DECODE(lv, 1, deptno, 2, null)
ORDER BY 1;


--===============================================================
������ ����
START WITH : ���� ������ ������ ���
CONNECT BY : ����(��)�� ������� ǥ��

 XXȸ�����(�ֻ��� ���)���� ���� ��������� ���������� Ž���ϴ� ����Ŭ ������ ���� �ۼ�
 1. �������� ���� : XXȸ��
 2. ������(��� ��) ����� ǥ��
    PRIOR : ���� ���� �а� �ִ� ���� ǥ��
    �ƹ��͵� ������ ���� : ���� ������ ���� ���� ǥ��

SELECT*
FROM dept_h;
    
SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL-1)*3) || deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT LEVEL, deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

�����
������ : �������� - dept0_00_0

SELECT *
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd;

SELECT deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd;


SELECT LPAD(' ', (LEVEL-1)*4) || s_id s_id, value
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;


SELECT *
FROM no_emp;

CONNECT BY ���Ŀ� �̾ PRIOR�� ���� �ʾƵ� ��� ����
PRIOR�� ���� �а� �ִ� ���� ��Ī�ϴ� Ű����

SELECT LPAD(' ', (LEVEL-1)*4) || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;



create table h_sum as
select '0' s_id, null ps_id, null value from dual union all
select '01' s_id, '0' ps_id, null value from dual union all
select '012' s_id, '01' ps_id, null value from dual union all
select '0123' s_id, '012' ps_id, 10 value from dual union all
select '0124' s_id, '012' ps_id, 10 value from dual union all
select '015' s_id, '01' ps_id, null value from dual union all
select '0156' s_id, '015' ps_id, 20 value from dual union all

select '017' s_id, '01' ps_id, 50 value from dual union all
select '018' s_id, '01' ps_id, null value from dual union all
select '0189' s_id, '018' ps_id, 10 value from dual union all
select '11' s_id, '0' ps_id, 27 value from dual;
commit;

SELECT *
FROM h_sum;



create table no_emp(
    org_cd varchar2(100),
    parent_org_cd varchar2(100),
    no_emp number
);
insert into no_emp values('XXȸ��', null, 1);
insert into no_emp values('�����ý��ۺ�', 'XXȸ��', 2);
insert into no_emp values('����1��', '�����ý��ۺ�', 5);
insert into no_emp values('����2��', '�����ý��ۺ�', 10);
insert into no_emp values('������ȹ��', 'XXȸ��', 3);
insert into no_emp values('��ȹ��', '������ȹ��', 7);
insert into no_emp values('��ȹ��Ʈ', '��ȹ��', 4);
insert into no_emp values('�����κ�', 'XXȸ��', 1);
insert into no_emp values('��������', '�����κ�', 7);

commit;







-------------------------------------
pruning branch : ����ġ��
WHERE���� ������ ��� ���� �� : ������ ������ ���� �� ���� �������� ����
CONNECT BY���� ��� ���� �� : �����߿� ������ ����
�� ���̸� ��
*�� ������ �������� FROM -> START WITH CONNECT BY -> WHERE �� ������ ó���ȴ�.

1. WHERE���� ������ ����� ���

SELECT LEVEL lv, deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd
FROM dept_h
WHERE deptcd != '������ȹ��'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

2.CONNECT BY ���� ������ ����� ���

SELECT LEVEL lv, deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd AND deptnm != '������ȹ��';


������ �������� ����� �� �ִ� Ư�� �Լ�

CONNECT_BY_ROOT(column) : �ش� �÷��� �ֻ��� �����͸� ��ȸ
SYS_CONNECT_BY_PATH(column, ������) : �ش� ���� ������� ���Ŀ� ���� column���� ǥ���ϰ� �����ڸ� ���� ����
CONNECT_BY_ISLEAF ���ڰ� ���� : �ش� ���� ������ ���̻� ���� ������ ������� (LEAF ���)
                               LEAF ��� : 1, NO LEAF ��� : 0

������
    ==���
        ==���
������
     ==���
     ==���
SELECT LEVEL lv, deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd,
        CONNECT_BY_ROOT(deptnm),
        LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'), '-'),
        CONNECT_BY_ISLEAF
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;




create table board_test (
 seq number,
 parent_seq number,
 title varchar2(100) );
 
insert into board_test values (1, null, 'ù��° ���Դϴ�');
insert into board_test values (2, null, '�ι�° ���Դϴ�');
insert into board_test values (3, 2, '����° ���� �ι�° ���� ����Դϴ�');
insert into board_test values (4, null, '�׹�° ���Դϴ�');
insert into board_test values (5, 4, '�ټ���° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (6, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (7, 6, '�ϰ���° ���� ������° ���� ����Դϴ�');
insert into board_test values (8, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (9, 1, '��ȩ��° ���� ù��° ���� ����Դϴ�');
insert into board_test values (10, 4, '����° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (11, 10, '���ѹ�° ���� ����° ���� ����Դϴ�');
commit;

SELECT *
FROM board_test;

DESC board_test;


SELECT seq, LPAD(' ', (LEVEL-1)*3) || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq;

h7]
������ ������ ���Ľ� ���� ������ �����ϸ鼭 ���� �ϴ� ����� ����
ORDER SIBLING BY

SELECT seq, LPAD(' ', (LEVEL-1)*3) || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;


h9]
ALTER TABLE board_test ADD (gp_no NUMBER);

UPDATE board_test SET gp_no = 4
WHERE seq IN (4, 10, 11, 5, 8, 6, 7);

UPDATE board_test SET gp_no = 2
WHERE seq IN (2, 3);

UPDATE board_test SET gp_no = 1
WHERE seq IN (1, 9);

SELECT gp_no, CONNECT_BY_ROOT(seq), seq, LPAD(' ', (LEVEL-1)*3) || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY gp_no DESC, seq;



------------------------------------------

��ü �����߿� ���� ���� �޿��� �޴� ����� �޿�����
�ٵ� �װ� ������???

���� ���� �޿��� �޴� ����� �̸�
SELECT MAX(sal)
FROM emp;

emp���̺��� 2�� �о ������ �޼� ==> ���� �� ȿ������ ����� ������?? ==> WINDOW / ANALYSIS function
SELECT ename
FROM emp
WHERE sal = (SELECT MAX(sal)
             FROM emp);


SELECT n.ename, n.sal, n.deptno, d.lv
FROM
(SELECT c.*, ROWNUM rn
 FROM
    (SELECT a.*, b.lv
    FROM
        (SELECT deptno, COUNT(*) cnt
         FROM emp
         GROUP BY deptno)a, (SELECT LEVEL lv
                             FROM dual
                             CONNECT BY LEVEL <=6) b
        WHERE a.cnt >= lv
        ORDER BY a.deptno, b.lv) c) d,
    (SELECT m.*, ROWNUM ro
     FROM
        (SELECT *
         FROM emp
         ORDER BY deptno, sal DESC) m) n
WHERE d.rn = n.ro;
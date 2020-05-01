 한개의 행, 하나의 컬럼을 리턴하는 서브쿼리
ex : 전체 직원의 급여 평균, SMITH 직원이 속한 부서의 부서번호

WHERE에서 사용가능한 연산자
WHERE deptno = 10
==>

부서번호가 10 혹은 30번인 경우
WHERE deptno IN (10,30)
WHERE deptno = 10 OR deptno = 30

WHERE deptno = (10, 30)


다중행 연산자
다중행을 조회하는 서브쿼리의 경우 = 연산자를 사용불가
WHERE deptno IN (여러개의 행을 리턴하고, 하나의 컬럼으로 이루어진 쿼리)

SMITH - 20, ALLEN은 30번 부서에 속함

SMITH 또는 ALLEN이 속하는 부서의 조직원 정보를 조회

행이 여러개고, 컬럼은 하나다 
==> 서브쿼리에서 사용가능한 연산자 IN(많이씀, 중요), (ANY, ALL, 빈도가 낮음)
IN : 서브쿼리의 결과값중 동일한 값이 있을 때 TRUE
    WHERE 컬럼|표현식 IN (서브쿼리)

ANY : 연산자를 만족하는 값이 하나라도 있을 때 TRUE
    WHERE 컬럼|표현식 연산자 ANY (서브쿼리)

ALL : 서브쿼리의 모든 값이 연산자를 만족할 때 TRUE
    WHERE 컬럼|표현식 연산자 ALL (서브쿼리)

SMITH와 ALLEN이 속한 부서에서 근무하는 모든 직원을 조회

1. 서브쿼리를 사용하지 않을 경우 : 두개의 쿼리를 실행
1-1] SMITH, ALLEN이 속한 부서의 부서번호를 확인하는 쿼리
SELECT *
FROM emp
WHERE ename IN ('SMITH', 'ALLEN');

1-2] 1-1]에서 얻은 부서번호로 IN연산자를 통해 해당 부서에 속하는 직원 정보 조회
SELECT employee_id, first_name || last_name name
FROM employees, jobs
WHERE employees.job_id = jobs.job_id;

==> 서브쿼리를 이용하면 하나의 SQL에서 실행가능
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('SMITH', 'ALLEN'));
                 
sub3]
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('SMITH', 'WARD'));


ANY, ALL
SMITH나 WARD 두사원의 급여중 아무 값보다 작은 급여를 받는 직원 조회
SELECT *
FROM emp
WHERE sal < ANY(SELECT sal
             FROM emp
             WHERE ename IN('SMITH', 'WARD'));

SMITH(800)나 WARD(1250) 두사원의 급여 보다 많은 급여를 받는 직원 조회
==> sal > 800
SELECT *
FROM emp
WHERE sal > ALL(SELECT sal
             FROM emp
             WHERE ename IN('SMITH', 'WARD'));


IN 연산자의 부정
소속부서가 20, 혹은 30인 경우
WHERE deptno IN (20, 30)

소속부서가 20, 혹은 30에 속하지 않는 경우
WHERE deptno NOT IN (20, 30)
NOT IN 연산자를 사용할 경우 서브쿼리의 값에 NULL이 있는지 여부가 중요
==> 정상적으로 동작하지 않음

아래 쿼리는 무슨 의미인가??
SELECT *
FROM emp
WHERE empno NOT IN (SELECT mgr
                    FROM emp


NULL값을 갖는 행을 제거
SELECT *
FROM emp
WHERE empno NOT IN (SELECT mgr
                    FROM emp
                    WHERE mgr IS NOT NULL);


NULL처리 함수를 통해 쿼리에 영향이 가지 않는 값으로 치환
SELECT *
FROM emp
WHERE empno NOT IN (SELECT NVL(mgr,-1)
                    FROM emp);


단일 컬럼을 리턴하는 서브쿼리에 대한 연산 ==> 복수 컬럼을 리턴하는 서브쿼리
PAIRWISE 연산 (순서쌍) ==> 동시에 만족

SELECT mgr, deptno
FROM emp
WHERE empno IN (7499, 7782);

7499, 7782사번의 직원과 같은 부서, 같은 매니저인 모든 직원 정보 조회
매니저가 7698이면서 소속부서가 30인 경우
매니저가 7839이면서 소속부서가 10인 경우

mgr 컬럼과 deptno 컬럼의 연관성이 없다
(mgr, deptno);
SELECT *
FROM emp
WHERE mgr IN (7698, 7839)
    AND deptno IN (10, 30);

PAIRWISE 적용 (위의 쿼리보다 결과가 한건 적다)
SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN(7499, 7782));

서브쿼리 구분 - 사용 위치
SELECT - 스칼라 서브 쿼리
FROM - 인라인 뷰
WHERE - 서브쿼리


서브쿼리 구분 - 반환하는 행, 컬럼의 수
단일 행
    단일 컬럼(스칼라 서브 쿼리)
    복수 컬럼
복수 행
    단일 컬럼(많이 쓰는 형태)
    복수 컬럼
    
    
스칼라 서브쿼리
SELECT 절에 표현되는 서브쿼리
단일행 단일 컬럼을 리턴하는 서브쿼리만 사용 가능
메인 쿼리의 하나의 컬럼 처럼 인식;

SELECT 'X', (SELECT SYSDATE FROM dual)
FROM dual;

스칼라 서브 쿼리는 하나의 행, 하나의 컬럼을 반환 해야 한다.

행은 하나지만 컬럼이 2개여서 에러
SELECT 'X', (SELECT empno, enam FROM emp WHERE ename='SMITH')
FROM dual;

다중행 하나의 컬럼을 리턴하는 스칼라 서브쿼리 ==> 에러
SELECT 'X', (SELECT empno FROM emp)
FROM dual;

emp 테이블만 사용할 경우 해당 직원의 소속 부서 이름을 알수가 없다. ==> 조인
특정 부서의 부서 이름을 조회하는 쿼리
SELECT dname
FROM dept
WHERE deptno = 10;


join으로 구현
SELECT empno, ename, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

위 쿼리를 스칼라 서브쿼리로 변경
SELECT empno, ename, emp.deptno, (SELECT dname FROM dept WHERE deptno = emp.deptno)--, 부서이름
FROM emp;

서브쿼리 구분 - 메인쿼리의 컬럼을 서브쿼리에서 사용하는지 여부에 따른 구분
상호연관 서브쿼리(corelated sub query)
    .메인 쿼리가 실행 되어야 서브 쿼리가 실행이 가능하다.
    
비상호 연관 서브쿼리(non corelated sub query)
    .main 쿼리의 테이블을 먼저 조회 할 수도 있고
    sub 쿼리의 테이블을 먼저 조회 할 수도 있다.
    ==> 오라클이 판단 했을 때 성능상 유리한 방향으로 실행 방향을 결정

모든 직원의 급여평균 보다 많은 급여를 받는 직원을 조회하는 쿼리를 작성 하세요(서브 쿼리 이용);
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
             
생각해볼 문제, 위의 쿼리는 상호 연관 서브 쿼리인가? 비상호 연관 서브 쿼리인가?

직원이 속한 부서의 급여 평균보다 많은 급여를 받는 직원
전체 직원의 급여 평균 ==> 직원이 속한 부서의 급여 평균

특정 부서의 급여 평균을 구하는 SQL
SELECT AVG(sal)
FROM emp
WHERE deptno = 10;

SELECT *
FROM emp e
WHERE sal > (SELECT AVG(sal)
             FROM emp
             WHERE deptno = e.deptno);

SELECT *
FROM dept;

INSERT INTO dept VALUES (99, 'ddit', 'daejeon');

emp테이블에 등록된 직원들은 10, 20, 30번 부서에만 소속이 되어있음
직원 소속되지 않은 부서 : 40, 99

sub4];
SELECT *
FROM dept
WHERE deptno NOT IN(SELECT deptno
                    FROM emp);

서브쿼리를 이용하여 IN연산자를 통해 일치하는 값이 있는지 조사할 때 값이 여러개 있어도 상관 없다(집합)

sub5]
SELECT *
FROM product 
WHERE pid NOT IN (SELECT pid
                  FROM cycle
                  WHERE cid = 1);
                  
sub6]
SELECT *
FROM cycle
WHERE cid = 1 AND pid IN(SELECT pid
                   FROM cycle
                   WHERE cid = 2);
                   
sub7]
join;

SELECT cycle.cid cid, cnm, cycle.pid pid, pnm, day, cnt 
FROM cycle, product, customer
WHERE cycle.cid = customer.cid 
  AND product.pid = cycle.pid 
  AND cycle.cid = 1 
  AND cycle.pid IN
                (SELECT pid
                 FROM cycle
                 WHERE cid = 2);
  
 스칼라 서브쿼리를 이용한 방법   
 SELECT cnm FROM customer WHERE cid = 3;
 SELECT pnm FROM product WHERE pid = 100;
                 
SELECT cid, (SELECT cnm FROM customer WHERE cid = 3) cnm, pid,  (SELECT pnm FROM product WHERE pid = 100) pnm, day, cnt
FROM cycle
WHERE cid = 1 AND pid IN(SELECT pid
                   FROM cycle
                   WHERE cid = 2);
                   


                   
SELECT *
FROM product;
use ubion;

select * from emp where SAL = 2000;

select * from 
emp 
left join
dept 
on emp.DEPTNO = dept.DEPTNO; 


-- 월급이 1500 이상 3000 이하인 사원의 정보를 출력
select 
* 
from 
emp 
where 
SAL >= 1500
and 
SAL <= 3000;

select * from emp 
where SAL between 1500 and 3000;


-- job이 salesman, manager 인 경우의 사원의 정보를 출력
select * from emp 
where 
job = 'salesman'
or
job = 'manager';

select * from emp 
where job in ('salesman', 'manager');

-- job이 salesman, manager를 제외한 사원 정보를 출력
select * from emp 
where 
job != 'salesman'
and
job != 'manager';

select * from emp 
where job not in ('salesman', 'manager');

-- 사원 이름이 S로 시작하는 사원 정보
select * from emp 
where ENAME like 'S%';

-- 그룹화 
select job, AVG(SAL) as mean 
from emp group by job
order by mean;

select 
a.ename, a.job, a.sal, b.loc
from 
emp as a
left join 
dept as b 
on a.deptno = b.deptno;

-- tran_1 table과 tran_2 table을 단순하게 행 결합
select * from tran_1
union
select * from tran_2;

-- 부서 지역이 NEW YORK이 사원의 정보를 출력하시오
-- 사원의 정보는 emp 
-- 부서의 정보는 dept
select 
* from 
emp left join dept 
on emp.deptno = dept.deptno 
where loc = 'NEW YORK';

-- dept table에서 loc가 NEW YORK인 부서번호 확인
select deptno from dept 
where loc = 'NEW YORK';

-- 부서 지역이 NEW WORK이거나 DALLAS인 사원의 정보를 출력
select * from emp 
where deptno = (
select deptno from dept 
where loc = 'DALLAS'
);

select deptno from dept
where loc = 'NEW YORK' or loc='DALLAS';

select * from 
emp where deptno = 10 or deptno = 20;

select * from emp 
where deptno in (10, 20);

select * from emp 
where deptno in (
	select deptno 
    from dept 
    where loc in ('NEW YORK', 'DALLAS')
);





with 
bases as (
  select * from (
    select k.k, n.n, cos(2*3.141592653589793238462643383279502884197169399375/24*k.k*n.n) a, -sin(2*3.141592653589793238462643383279502884197169399375/24*k.k*n.n) b
    from (select rownum-1 k from all_tables where rownum<13) k,
         (select rownum-1 n from all_tables where rownum<25) n
  )),
signal as ( 
  select row_number() over (order by mes) n, mes, valor-avg(valor) over () valor 
  from (
    select to_char(data, 'YYYYMM') mes, sum(valor) valor from pagamentos
    where ano in (2016, 2017)
    group by  to_char(data, 'YYYYMM'))
  )
select bases.k, sqrt(power(sum(signal.valor*bases.a)/24,2)+power(sum(signal.valor*bases.b)/24,2))
from bases inner join signal on bases.n=signal.n-1
group by bases.k
order by bases.k;
with k as (
  select rownum-1 k
  from all_tables
  where rownum<65
), m as (
  select rownum-1 m
  from all_tables
  where rownum<129
), data as (
  select rownum-1 n, sin(rownum-1) x
  from all_tables
  where rownum<129
)
select k, sqrt(re*re+im*im) from (
  select k, sum(re) re, sum(im) im from (
    select k.k, data.x*cos(6.28318530718/128*k.k*m.m) re, data.x*sin(6.28318530718/128*k.k*m.m) im
    from k, m, data
    where data.n=m.m
  )
  group by k
)
order by k;

create or replace view zc_wards as
(
select
dept_dict.dept_code id /*病区代码*/,
dept_dict.dept_name name /*病区名称*/,
'300' mark /*病区标志 300:普通*/,
'1' valid /*是否有效*/
from dept_dict
where clinic_attr=2
and outp_or_inp=1
);

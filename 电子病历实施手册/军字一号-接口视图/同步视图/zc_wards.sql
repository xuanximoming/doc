create or replace view zc_wards as
(
select
dept_dict.dept_code id /*��������*/,
dept_dict.dept_name name /*��������*/,
'300' mark /*������־ 300:��ͨ*/,
'1' valid /*�Ƿ���Ч*/
from dept_dict
where clinic_attr=2
and outp_or_inp=1
);

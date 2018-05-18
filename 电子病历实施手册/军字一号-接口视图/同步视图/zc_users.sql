create or replace view zc_users as
(
select
trim(to_char(NVL(staff_dict.id,ROWNUM),'000000')) id /*职工代码*/,
staff_dict.name name /*职工姓名*/,
'' sexy /*职工性别*/,
'' birth /*出生日期, 可以根据身份证号处理*/,
'' idno /*身份证号*/,
staff_dict.dept_code deptid /*科室代码*/,
(select dept_vs_ward.ward_code from dept_vs_ward where staff_dict.dept_code=dept_vs_ward.dept_code) wardid /*病区代码*/,
case staff_dict.job       when '医生' then '401' --普通医师
                          when '护士' then '402' --护士
                          else '404' --其他
end category /*职工类别*/,
case staff_dict.title     when '主任医师' then '1' --主任医师
                          when '副主任医师' then '2' --副主任医师
                          when '主治医师' then '3' --主治医师
                          when '医师' then '4' --医师
                          when '' then '5' --医士
                          when '' then '11'--主任护师
                          when '' then '12'--副主任护师
                          when '主管护师' then '13'--主管护师
                          when '护师' then '14'--护师
                          when '' then '15'--护士
                          else '' --其他的职称暂时不管
end jobtitle /*职称代码*/,
case staff_dict.job       when '医生' then '1' --有处方权
                          else '0'          --无处方权
end recipemark /*处方权*/,
'' narcosismark /*麻醉处方权*/,
case staff_dict.title     when '主任医师' then '2000' --主任医师
                          when '副主任医师' then '2001' --副主任医师
                          when '主治医师' then '2002' --主治医师
                          when '医师' then '2003' --住院医师
                          when '医师' then '2003' --住院医师
                          when '主管护师' then '2004'--护士
                          when '护师' then '2004'--护士
                          when '' then '2004'--护士
                          when '' then '2004'--护士
                          when '' then '2004'--护士
                          else '' --其他的职称暂时不管
end grade /*医生级别*/,
'1' valid /*是否有效*/
from staff_dict where staff_dict.emrid is not null
)
;

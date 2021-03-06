create or replace view zc_departments as
(
select
dept_dict.dept_code id /*科室代码*/,
dept_dict.dept_name name /*科室名称*/,
case dept_dict.clinic_attr when 0 /*住院*/ then '101' /*临床*/
                            when 1 /*医技*/ then '102' /*医技*/
                            when 2 /*药库*/ then '102' /*药剂*/
                            when 0009 /*药房*/ then '103' /*药剂*/ -- 待确定
                            when 3 /*机关*/ then '104' /*机关*/
                            else '105'  /*其他*/
end sort /*科室类别*/,
201 mark /*科室标志 普通*/,
null totalchief    /*主任医师数*/,
null totalattend   /*住院医师数*/,
null totalresident /*主治医师数*/,
null totalnurse    /*护士数*/,
null totalbed      /*床位数*/,
null totalextra    /*核定加床数*/,
'1' valid  /*有效记录*/
from dept_dict
where CLINIC_ATTR=0
and outp_or_inp = 1
and length(dept_code) = 4
and to_number(dept_code) < 300
);

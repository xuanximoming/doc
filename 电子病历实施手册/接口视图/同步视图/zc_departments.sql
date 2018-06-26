create or replace view zc_departments as
(
select
dept_dict.dept_code id /*���Ҵ���*/,
dept_dict.dept_name name /*��������*/,
case dept_dict.clinic_attr when 0 /*סԺ*/ then '101' /*�ٴ�*/
                            when 1 /*ҽ��*/ then '102' /*ҽ��*/
                            when 2 /*ҩ��*/ then '102' /*ҩ��*/
                            when 0009 /*ҩ��*/ then '103' /*ҩ��*/ -- ��ȷ��
                            when 3 /*����*/ then '104' /*����*/
                            else '105'  /*����*/
end sort /*�������*/,
201 mark /*���ұ�־ ��ͨ*/,
null totalchief    /*����ҽʦ��*/,
null totalattend   /*סԺҽʦ��*/,
null totalresident /*����ҽʦ��*/,
null totalnurse    /*��ʿ��*/,
null totalbed      /*��λ��*/,
null totalextra    /*�˶��Ӵ���*/,
'1' valid  /*��Ч��¼*/
from dept_dict
where CLINIC_ATTR=0
and outp_or_inp = 1
and length(dept_code) = 4
and to_number(dept_code) < 300
);

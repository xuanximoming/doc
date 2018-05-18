create or replace view zc_users as
(
select
trim(to_char(NVL(staff_dict.id,ROWNUM),'000000')) id /*ְ������*/,
staff_dict.name name /*ְ������*/,
'' sexy /*ְ���Ա�*/,
'' birth /*��������, ���Ը������֤�Ŵ���*/,
'' idno /*���֤��*/,
staff_dict.dept_code deptid /*���Ҵ���*/,
(select dept_vs_ward.ward_code from dept_vs_ward where staff_dict.dept_code=dept_vs_ward.dept_code) wardid /*��������*/,
case staff_dict.job       when 'ҽ��' then '401' --��ͨҽʦ
                          when '��ʿ' then '402' --��ʿ
                          else '404' --����
end category /*ְ�����*/,
case staff_dict.title     when '����ҽʦ' then '1' --����ҽʦ
                          when '������ҽʦ' then '2' --������ҽʦ
                          when '����ҽʦ' then '3' --����ҽʦ
                          when 'ҽʦ' then '4' --ҽʦ
                          when '' then '5' --ҽʿ
                          when '' then '11'--���λ�ʦ
                          when '' then '12'--�����λ�ʦ
                          when '���ܻ�ʦ' then '13'--���ܻ�ʦ
                          when '��ʦ' then '14'--��ʦ
                          when '' then '15'--��ʿ
                          else '' --������ְ����ʱ����
end jobtitle /*ְ�ƴ���*/,
case staff_dict.job       when 'ҽ��' then '1' --�д���Ȩ
                          else '0'          --�޴���Ȩ
end recipemark /*����Ȩ*/,
'' narcosismark /*������Ȩ*/,
case staff_dict.title     when '����ҽʦ' then '2000' --����ҽʦ
                          when '������ҽʦ' then '2001' --������ҽʦ
                          when '����ҽʦ' then '2002' --����ҽʦ
                          when 'ҽʦ' then '2003' --סԺҽʦ
                          when 'ҽʦ' then '2003' --סԺҽʦ
                          when '���ܻ�ʦ' then '2004'--��ʿ
                          when '��ʦ' then '2004'--��ʿ
                          when '' then '2004'--��ʿ
                          when '' then '2004'--��ʿ
                          when '' then '2004'--��ʿ
                          else '' --������ְ����ʱ����
end grade /*ҽ������*/,
'1' valid /*�Ƿ���Ч*/
from staff_dict where staff_dict.emrid is not null
)
;

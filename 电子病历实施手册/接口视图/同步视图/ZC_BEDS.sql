CREATE OR REPLACE VIEW ZC_BEDS
(id, deptid, wardid, roomid, resident, attend, chief, sexinfo, style, inbed, patnoofhis, valid)
AS
(
SELECT
b.bed_label       /*��λ����*/,
b.dept_code /*���Ҵ���*/,
b.ward_code /*��������*/,
nvl( b.room_no,1) room_no /*�����*/,
'' resident /*סԺҽʦ����*/,
'' attend   /*����ҽʦ����*/,
'' chief    /*����ҽʦ����*/,
case b.bed_sex_type         when '1' then '1100' /*��*/
                            when '2' then '1101' /*Ů*/
                            when '9' then '1102' /*��*/
end sexinfo,
case b.bed_approved_type      when '0' /*������*/   then '1200' /*�ڱ�*/
                              when '1' /*������*/   then '1201' /*�Ǳ�*/
                              when '2' /*�Ӵ�*/     then '1202' /*�Ӵ�*/
                              when '3' /*ͯ��*/     then '1203' /*ͯ��*/
end style,
case b.bed_status             when '0' then '1300' --�մ�
                              when '1' then '1301' --ռ��
                              --when '9' then '1302' δչ��
                              else '1302'
end inbed,
c.patient_id||'_'||a.visit_id patnoofhis /*HIS ��ҳ���*/,
1  valid     /*��Ч��¼*/
FROM  pats_in_hospital a,bed_rec b,pat_master_index c
where a.patient_id = c.patient_id and a.ward_code = b.ward_code and a.bed_no=b.bed_no

);

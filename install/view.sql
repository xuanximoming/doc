-------------------------------------------
-- Export file for user EMR@YC           --
-- Created by key on 2018/5/27, 13:42:12 --
-------------------------------------------

set define off
spool view.log

prompt
prompt Creating view BABYVIEW
prompt ======================
prompt
create or replace force view emr.babyview as
select
baby.iem_mainpage_no,  --������ҳ��
baby.iem_mainpage_obsbabyid,  --Ӥ����ҳ��
baby.tc,  --̥��
baby.cc,  --����
baby.tb,  --̥��
baby.cfhypld,  --�����������Ѷ�
baby.midwifery,  --�Ӳ���
baby.sex as babySex,  --�Ա�
baby.apj,  --����������
baby.heigh,  --��
baby.weight as BABY_weight,  --����
baby.ccqk as ccqkID,  --�������
baby.bithday,  --����ʱ��
baby.fmfs as fmfsID,  --���䷽ʽ
baby.cyqk as cyqkID,  --��Ժ���
baby.create_user as BABY_create_user,  --Ӥ����Ϣ������
baby.create_time as BABY_create_time,  --Ӥ����Ϣ����ʱ��
baby.valide as BABY_valide,  --Ӥ����Ϣ�Ƿ���Ч
midwifery.name as midwiferyName,  --�Ӳ���
sex.name as sex,  --�Ա�
ccqk.name as ccqk,  --�������
fmfs.name as fmfs,  --���䷽ʽ
cyqk.name as cyqk,  --��Ժ���
create_user.name as create_user  --������
from
iem_mainpage_obstetricsbaby baby
left join users midwifery
on midwifery.id = baby.midwifery
left join dictionary_detail sex
on sex.detailid = baby.sex and
sex.categoryid = '3'
left join dictionary_detail ccqk
on ccqk.detailid = baby.ccqk and
ccqk.categoryid = '32'
left join dictionary_detail fmfs
on fmfs.detailid = baby.fmfs and
fmfs.categoryid = '33'
left join dictionary_detail cyqk
on cyqk.detailid = baby.cyqk and
cyqk.categoryid = '34'
left join users create_user
on create_user.id = baby.create_user
and baby.valide='1'
;

prompt
prompt Creating view BASICINFOVIEW
prompt ===========================
prompt
create or replace force view emr.basicinfoview as
select
basic.IEM_MAINPAGE_NO,  --������ҳ��ʶ
basic.PATNOOFHIS,  --������
basic.NOOFINPAT,  --������ҳ���
basic.PAYID,  --ҽ�Ƹ��ʽID
basic.SOCIALCARE,  --�籣����
basic.INCOUNT,  --��Ժ����
basic.NAME,  --��������
basic.sexid,  --�Ա�
basic.BIRTH,  --����
basic.MARITAL,  --����״�� 1.δ�� 2.�ѻ� 3.ɥż4.��� 9.����
basic.JOBID,  --ְҵ
basic.NATIONID,  --����
basic.NATIONALITYID,  --����ID
basic.IDNO,  --���֤����
basic.ORGANIZATION,  --������λ
basic.OFFICEPLACE,  --������λ��ַ
basic.OFFICETEL,  --������λ�绰
basic.OFFICEPOST,  --������λ�ʱ�
basic.CONTACTPERSON,  --��ϵ������
basic.RELATIONSHIP,  --����ϵ�˹�ϵ
basic.CONTACTADDRESS,  --��ϵ�˵�ַ
basic.CONTACTTEL,  --��ϵ�˵绰
basic.ADMITDATE,  --��Ժʱ��
basic.ADMITDEPT,  --��Ժ����
basic.ADMITWARD,  --��Ժ����
basic.TRANS_DATE,  --תԺʱ��
basic.TRANS_ADMITDEPT,  --תԺ�Ʊ�
basic.TRANS_ADMITWARD,  --תԺ����
basic.OUTWARDDATE,  --��Ժʱ��
basic.OUTHOSDEPT,  --��Ժ����
basic.OUTHOSWARD,  --��Ժ����
basic.ACTUALDAYS,  --ʵ��סԺ����
basic.PATHOLOGY_DIAGNOSIS_NAME,  --�����������
basic.PATHOLOGY_OBSERVATION_SN,  --�������
basic.ALLERGIC_DRUG,  --����ҩ��
basic.SECTION_DIRECTOR,  --������
basic.DIRECTOR,  --������������ҽʦ
basic.VS_EMPLOYEE_CODE,  --����ҽʦ
basic.RESIDENT_EMPLOYEE_CODE,  --סԺҽʦ
basic.REFRESH_EMPLOYEE_CODE,  --����ҽʦ
basic.DUTY_NURSE,  --���λ�ʿ
basic.INTERNE,  --ʵϰҽʦ
basic.CODING_USER,  --����Ա
basic.MEDICAL_QUALITY_ID,  --��������
basic.QUALITY_CONTROL_DOCTOR,  --�ʿ�ҽʦ
basic.QUALITY_CONTROL_NURSE,  --�ʿػ�ʿ
basic.QUALITY_CONTROL_DATE,  --�ʿ�ʱ��
basic.XAY_SN,  --x�߼���
basic.CT_SN,  --CT����
basic.MRI_SN,  --mri����
basic.DSA_SN,  --Dsa����
basic.BLOODTYPE as bloodTypeID,  --Ѫ��
basic.RH as RHID,  --Rh
basic.IS_COMPLETED,  --��ɷ� y/n
basic.COMPLETED_TIME,  --���ʱ��
basic.VALIDE,  --���Ϸ� 1/0
basic.CREATE_USER,  --�����˼�¼��
basic.CREATE_TIME,  --����ʱ��
basic.MODIFIED_USER,  --�޸Ĵ˼�¼��
basic.MODIFIED_TIME,  --�޸�ʱ��
basic.ZYMOSIS,  --ҽԺ��Ⱦ��
basic.HURT_TOXICOSIS_ELE_ID,  --���ˡ��ж����ⲿ����
basic.HURT_TOXICOSIS_ELE_NAME,  --���ˡ��ж����ⲿ����
basic.ZYMOSISSTATE,  --ҽԺ��Ⱦ��״̬
basic.PATHOLOGY_DIAGNOSIS_ID,  --������ϱ��
basic.MONTHAGE,  --�����䲻��1����ģ� ����(��)
basic.WEIGHT,  --��������������(��)
basic.INWEIGHT,  --��������Ժ����(��)
basic.INHOSTYPE,  --��Ժ;��:1.����  2.����  3.����ҽ�ƻ���ת��  9.����
basic.OUTHOSTYPE,  --��Ժ��ʽ �� 1.ҽ����Ժ  2.ҽ��תԺ 3.ҽ��ת���������������/��������Ժ 4.��ҽ����Ժ5.����9.����
basic.RECEIVEHOSPITAL,  --2.ҽ��תԺ�������ҽ�ƻ������ƣ�
basic.RECEIVEHOSPITAL2,  --3.ҽ��ת���������������/��������Ժ�������ҽ�ƻ������ƣ�
basic.AGAININHOSPITAL,  --�Ƿ��г�Ժ31������סԺ�ƻ� �� 1.��  2.��
basic.AGAININHOSPITALREASON,  --��Ժ31������סԺ�ƻ� Ŀ��:
basic.BEFOREHOSCOMADAY,  --­�����˻��߻���ʱ�䣺 ��Ժǰ    ��
basic.BEFOREHOSCOMAHOUR,  --­�����˻��߻���ʱ�䣺 ��Ժǰ     Сʱ
basic.BEFOREHOSCOMAMINUTE,  --­�����˻��߻���ʱ�䣺 ��Ժǰ    ����
basic.LATERHOSCOMADAY,  --­�����˻��߻���ʱ�䣺 ��Ժ��    ��
basic.LATERHOSCOMAHOUR,  --­�����˻��߻���ʱ�䣺 ��Ժ��    Сʱ
basic.LATERHOSCOMAMINUTE,  --­�����˻��߻���ʱ�䣺 ��Ժ��    ����
basic.CARDNUMBER,  --��������
basic.ALLERGIC_FLAG,  --ҩ�����1.�� 2.��
basic.AUTOPSY_FLAG,  --��������ʬ�� �� 1.��  2.��
basic.CSD_PROVINCEID,  --������ ʡ
basic.CSD_CITYID,  --������ ��
basic.CSD_DISTRICTID,  --������ ��
basic.CSD_PROVINCENAME,  --������ ʡ����
basic.CSD_CITYNAME,  --������ ������
basic.CSD_DISTRICTNAME,  --������ ������
basic.XZZ_PROVINCEID,  --��סַ ʡ
basic.XZZ_CITYID,  --��סַ ��
basic.XZZ_DISTRICTID,  --��סַ ��
basic.XZZ_PROVINCENAME,  --��סַ ʡ����
basic.XZZ_CITYNAME,  --��סַ ������
basic.XZZ_DISTRICTNAME,  --��סַ ������
basic.XZZ_TEL,  --��סַ �绰
basic.XZZ_POST,  --��סַ �ʱ�
basic.HKDZ_PROVINCEID,  --���ڵ�ַ ʡ
basic.HKDZ_CITYID,  --���ڵ�ַ ��
basic.HKDZ_DISTRICTID,  --���ڵ�ַ ��
basic.HKDZ_PROVINCENAME,  --���ڵ�ַ ʡ����
basic.HKDZ_CITYNAME,  --���ڵ�ַ ������
basic.HKDZ_DISTRICTNAME,  --���ڵ�ַ ������
basic.HKDZ_POST,  --�������ڵ��ʱ�
basic.JG_PROVINCEID,  --���� ʡ����
basic.JG_CITYID,  --���� ������
basic.JG_PROVINCENAME,  --���� ʡ����
basic.JG_CITYNAME,  --���� ������
basic.AGE,  --��������
basic.ZG_FLAG,  --ת�飺�� 1.���� 2.��ת 3.δ�� 4.���� 5.����
basic.ADMITINFO,  --
basic.CSDADDRESS,  --�����ص�ַ
basic.JGADDRESS,  --�����ַ
basic.XZZADDRESS,  --��סַ
basic.HKADDRESS,  --����סַ
basic.MENANDINHOP as MENANDINHOPID,  --������סԺ
basic.INHOPANDOUTHOP as INHOPANDOUTHOPID,  --��Ժ���Ժ
basic.BEFOREOPEANDAFTEROPER as BEFOREOPEANDAFTEROPERID,  --��ǰ������
basic.LINANDBINGLI as LINANDBINGLIID,  --�ٴ��벡��
basic.INHOPTHREE as INHOPTHREEID,  --��Ժ������
basic.fangandbingli as fangandbingliID,  --�����벡��
paymethod.name as paymethod,  --���ʽ
sex.name as sex,  --�Ա�
marry.name as marry,  --����״��
job.name as job,  --ְҵ
nation.name as nation,  --����
country.name as country,  --����
ralation.name as ralation,  --����ϵ�˹�ϵ
departIn.Name as departIn,  --��Ժ����
wardIn.Name as wardIn,  --��Ժ����
departTran.Name as departTran,  --תԺ�Ʊ�
wardTran.Name  as wardTran,  --תԺ����
departOut.Name as departOut,  --��Ժ����
wardOut.Name as wardOut,  --��Ժ����
secDirect.Name as secDirect,  --������
direct.name as direct,  --������������ҽʦ
vsEmployee.Name as vsEmployee,  --����ҽʦ
residentEmployee.Name as residentEmployee,  --סԺҽʦ
refreshEmployee.Name as refreshEmployee,  --����ҽʦ
dutyNurse.Name as dutyNurse,  --���λ�ʿ
internEmployee.Name as internEmployee,  --ʵϰҽʦ
codingUser.Name as codingUser,  --����Ա
quaCtrlDoctor.Name as quaCtrlDoctor,  --�ʿ�ҽʦ
quaCtrlNurse.Name as quaCtrlNurse,  --�ʿػ�ʿ
bloodType.Name as bloodType,  --Ѫ��
rh.name as rh,  --Rh
createUser.Name as createUser,  --�����˼�¼��
modifyUser.Name as modifyUser,  --�޸Ĵ˼�¼��
diagno.name as diagnosis,  --�������
inStype.Name as inStype,  --��Ժ;��
outStype.Name as outStype,  --��Ժ��ʽ
autoPsy.Name as autoPsy,  --��������ʬ��
zg.name as zg,  --ת��
menandinhop.name as menandinhop,  --������סԺ
inhopandouthop.name as inhopandouthop,  --��Ժ���Ժ
beforeopeandafteroper.name as beforeopeandafteroper,  --��ǰ������
linandbingli.name as linandbingli,  --�ٴ��벡��
inhopthree.name as inhopthree,  --��Ժ������
fangandbingli.name as fangandbingli,  --�����벡��
basic.patflag--�жϵ��Ƿ���ϳ�Ժ��Ƭ����֤����HIS����
from
IEM_MAINPAGE_BASICINFO_2012 basic
left join dictionary_detail paymethod
on paymethod.detailid = basic.payid and
paymethod.categoryid = '1'
left join dictionary_detail sex
on sex.detailid = basic.sexid and
sex.categoryid = '3'
left join dictionary_detail marry
on marry.detailid = basic.marital and
marry.categoryid = '4'
left join dictionary_detail job
on job.detailid = basic.jobid and
job.categoryid = '41'
left join dictionary_detail nation
on nation.detailid = basic.nationid and
nation.categoryid = '42'
left join dictionary_detail country
on country.detailid = basic.nationalityid and
country.categoryid = '43'
left join dictionary_detail ralation
on ralation.detailid = basic.relationship and
ralation.categoryid = '44'
left join department departIn
on departIn.Id = basic.admitdept
left join ward wardIn
on wardIn.Id = basic.admitward
left join department departTran
on departTran.Id = basic.trans_admitdept
left join ward wardTran
on wardTran.Id = basic.trans_admitward
left join department departOut
on departOut.Id = basic.outhosdept
left join ward wardOut
on wardOut.Id = basic.outhosward
left join users secDirect
on secDirect.Id = basic.section_director
left join users direct
on direct.Id = basic.director
left join users vsEmployee
on vsEmployee.Id = basic.vs_employee_code
left join users residentEmployee
on residentEmployee.Id = basic.resident_employee_code
left join users refreshEmployee
on refreshEmployee.Id = basic.refresh_employee_code
left join users dutyNurse
on dutyNurse.Id = basic.duty_nurse
left join users internEmployee
on internEmployee.Id = basic.interne
left join users codingUser
on codingUser.Id = basic.coding_user
left join users quaCtrlDoctor
on quaCtrlDoctor.Id = basic.quality_control_doctor
left join users quaCtrlNurse
on quaCtrlNurse.Id = basic.quality_control_nurse
left join dictionary_detail bloodType
on bloodType.Categoryid = '52' and
bloodType.Detailid = basic.bloodtype
left join dictionary_detail rh
on rh.Categoryid = '17' and
rh.Detailid = basic.rh
left join users createUser
on createUser.Id = basic.create_user
left join users modifyUser
on modifyUser.Id = basic.modified_user
left join diagnosis diagno
on diagno.icd = basic.pathology_diagnosis_id
left join dictionary_detail inStype
on inStype.Categoryid = '6' and
inStype.Detailid = basic.inhostype
left join dictionary_detail outStype
on outStype.Categoryid = '60' and
outStype.Detailid = basic.outhostype
left join dictionary_detail autoPsy
on autoPsy.Categoryid = '69' and
autoPsy.Detailid = basic.autopsy_flag
left join dictionary_detail zg
on zg.Categoryid = '15' and
zg.Detailid = basic.zg_flag
left join dictionary_detail menandinhop
on menandinhop.Categoryid = 'dg' and
menandinhop.Detailid = basic.menandinhop
left join dictionary_detail inhopandouthop
on inhopandouthop.Categoryid = 'dg' and
inhopandouthop.Detailid = basic.inhopandouthop
left join dictionary_detail beforeopeandafteroper
on beforeopeandafteroper.Categoryid = 'dg' and
beforeopeandafteroper.Detailid = basic.beforeopeandafteroper
left join dictionary_detail linandbingli
on linandbingli.Categoryid = 'dg' and
linandbingli.Detailid = basic.linandbingli
left join dictionary_detail inhopthree
on inhopthree.Categoryid = 'dg' and
inhopthree.Detailid = basic.inhopthree
left join dictionary_detail fangandbingli
on fangandbingli.Categoryid = 'dg' and
fangandbingli.Detailid = basic.fangandbingli
and basic.valide='1'
;

prompt
prompt Creating view DC_ORDERS
prompt =======================
prompt
create or replace force view emr.dc_orders as
select "PATIENT_ID",
       "VISIT_ID",
       to_char(a.start_date_time, 'yyyy-mm-dd hh24:mi:ss'),
       case a.order_sub_no
         when 1 then
          (case ORDER_CLASS
            when 'A' then
             'ҩƷ'
            when 'B' then
             'ҩƷ'
            else
             '��ҩƷ'
          end)
         else
          ''
       end,
       case a.order_sub_no
         when 1 then
          (case ORDER_CLASS
            when 'A' then
             'ҩƷ'
            when 'B' then
             'ҩƷ'
            else
             '��ҩƷ'
          end)
         else
          ''
       end,
       case a.order_sub_no
         when 1 then
          (case a.repeat_indicator
            when 1 then
             '����'
            else
             '��ʱ'
          end)
         else
          ''
       end,
       to_char(a.stop_date_time, 'yyyy-mm-dd hh24:mi:ss'),
       a.order_no || '  ' || a.order_text || '  ' ||
       (decode(a.dosage, null, '', to_char(a.dosage, 'FM999990.0099'))) ||
       a.dosage_units|| '  '||
       decode(a.freq_detail,'','','˵����'||a.freq_detail),
       a.order_no
  from orders a;

prompt
prompt Creating view DIAGNOSISVIEW
prompt ===========================
prompt
create or replace force view emr.diagnosisview as
select
dia.iem_mainpage_no,  --������ҳ��ʶ
dia.iem_mainpage_diagnosis_no,  --�����ҳ��ʶ
dia.DIAGNOSIS_TYPE_ID,  --�������
dia.DIAGNOSIS_CODE,  --��ϱ���
dia.DIAGNOSIS_NAME as DIAGNOSIS_NAMEID,  --������Ʊ��
dia.STATUS_ID,  --���״̬����
dia.ORDER_VALUE,  --
dia.VALIDE as DIA_VALIDE,  --����Ƿ���Ч
dia.CREATE_USER as DIA_CREATE_USER,  --�����Ϣ������
dia.CREATE_TIME as DIA_CREATE_TIME,  --�����Ϣ����ʱ��
dia.CANCEL_USER,  --�����Ϣȡ����
dia.CANCEL_TIME,  --�����Ϣȡ��ʱ��
dia.MENANDINHOP as DIA_MENANDINHOP,  --������סԺ��Ϸ������
dia.INHOPANDOUTHOP as DIA_INHOPANDOUTHOP,  --��Ժ���Ժ��Ϸ������
dia.BEFOREOPEANDAFTEROPER as DIA_BEFOREOPEANDAFTEROPER,  --��ǰ��������Ϸ������
dia.LINANDBINGLI as IDA_LINANDBINGLI,  --�ٴ��벡����Ϸ������
dia.INHOPTHREE as DIA_INHOPTHREE,  --��Ժ��������Ϸ������
dia.FANGANDBINGLI as DIA_FANGANDBINGLI,  --�����벡����Ϸ������
dia.ADMITINFO as DIA_ADMITINFO,  --��Ժ����
diagnosisName.Name as diagnosisName,  --�������
createUser.Name as createUser,  --������
cancelUser.Name as cancelUser,  --ȡ����
menandinhop.name as menandinhop,  --������סԺ
inhopandouthop.name as inhopandouthop,  --��Ժ���Ժ
beforeopeandafteroper.name as beforeopeandafteroper,  --��ǰ������
linandbingli.name as linandbingli,  --�ٴ��벡��
inhopthree.name as inhopthree,  --��Ժ������
fangandbingli.name as fangandbingli  --�����벡��
from
iem_mainpage_diagnosis_2012 dia
left join diagnosis diagnosisName
on diagnosisName.Icd = dia.diagnosis_code
left join users createUser
on createUser.Id = dia.create_user
left join users cancelUser
on cancelUser.Id = dia.cancel_user
left join dictionary_detail menandinhop
on menandinhop.Categoryid = 'dg' and
menandinhop.Detailid = dia.menandinhop
left join dictionary_detail inhopandouthop
on inhopandouthop.Categoryid = 'dg' and
inhopandouthop.Detailid = dia.inhopandouthop
left join dictionary_detail beforeopeandafteroper
on beforeopeandafteroper.Categoryid = 'dg' and
beforeopeandafteroper.Detailid = dia.beforeopeandafteroper
left join dictionary_detail linandbingli
on linandbingli.Categoryid = 'dg' and
linandbingli.Detailid = dia.linandbingli
left join dictionary_detail inhopthree
on inhopthree.Categoryid = 'dg' and
inhopthree.Detailid = dia.inhopthree
left join dictionary_detail fangandbingli
on fangandbingli.Categoryid = 'dg' and
fangandbingli.Detailid = dia.fangandbingli
and dia.valide='1'
;

prompt
prompt Creating view INCOMMONNOTE_ITEMHIS_VIEW
prompt =======================================
prompt
create or replace force view emr.incommonnote_itemhis_view as
select c.incommonnote_tab_flow,
c.incommonnoteflow,
ci.commonnote_tab_flow,
ci.commonnoteflow,
r.createdoctorid,
r.createdoctorname,
r.createdatetime,
r.valide valide,
r.recorddate,
r.recordtime,
r.recorddoctorid,
r.recorddoctorname,
 c.incommonnote_item_flow,
 c.hisrowflow as groupflow,
 t.commonnote_item_flow,
 t.dataelementflow,
 d.elementid  as dataelementid,
 d.elementname as dataelementname,
   t.othername,
   ci.ordercode,
ci.isvalidate,
c.valuexml,
r.rowflow
  from incommonnote_columnhis c
  left join incommonnote_rowhis r
    on c.hisrowflow = r.historyflow
  left join incommonnote_column_type t
    on t.commonnote_item_flow = c.commonnote_item_flow and t.incommonnote_tab_flow=c.incommonnote_tab_flow
   left join dateelement d
   on d.elementflow=t.dataelementflow
    left join commonnote_item ci
    on ci.commonnote_item_flow=t.commonnote_item_flow;

prompt
prompt Creating view INCOMMONNOTE_ITEM_VIEW
prompt ====================================
prompt
create or replace force view emr.incommonnote_item_view as
select r.incommonnote_tab_flow,
c.incommonnoteflow,
r.commonnote_tab_flow,
r.commonnoteflow,
r.createdoctorid,
r.createdoctorname,
r.createdatetime,
r.valide,
r.recorddate,
r.recordtime,
r.recorddoctorid,
r.recorddoctorname,
 c.incommonnote_item_flow,
 c.rowflow as groupflow,
 t.commonnote_item_flow,
 t.dataelementflow,
 d.elementid  as dataelementid,
 d.elementname as dataelementname,
   t.othername,
   ci.ordercode,
ci.isvalidate,
c.valuexml,
(select count(*) from incommonnote_rowhis where incommonnote_rowhis.rowflow=r.rowflow) XGNum
  from incommonnote_column c
  left join incommonnote_row r
    on c.rowflow = r.rowflow
  left join incommonnote_column_type t
    on t.commonnote_item_flow = c.commonnote_item_flow and t.incommonnote_tab_flow=c.incommonnote_tab_flow
   left join dateelement d
   on d.elementflow=t.dataelementflow
    left join commonnote_item ci
    on ci.commonnote_item_flow=t.commonnote_item_flow;

prompt
prompt Creating view INPATIENT_OPERATION_SUNY
prompt ======================================
prompt
create or replace force view emr.inpatient_operation_suny as
select t.patnoofhis סԺ��,t.name ����,(select dt.name from department dt where dt.id=t.admitdept) ����
from inpatient t where t.noofinpat in(select rd.noofinpat from recorddetail rd where rd.name like '%����%' and rd.createtime between '2011-08-01 00:00:00' and '2011-08-31 00:00:00');

prompt
prompt Creating view MED_REC_BORROW_VIEW
prompt =================================
prompt
create or replace force view emr.med_rec_borrow_view as
Select  e.id,i.noofinpat, i.name,i.patid,---------Add by xlb 2013-05-30 ������Ӧ��ͬ������ҳ��ȡnoofrecord
             u.name as applyname,e.applydate,to_char(e.applydate,'yyyy-MM-dd hh24:mi:ss') as sqsj,
             i.isbaby,i.mother,--add by 2013-7-4 zjy
             e.applycontent,e.applytimes,e.approvedocid,e.approvecontent,
             e.approvedate,to_char(e.approvedate,'yyyy-MM-dd hh24:mi:ss') as shsj,
             nvl2(trim(e.yanqiflag),'��','��') as yq, e.status,'' as statusdes,
             i.AGESTR as age,i.outhosdate,i.outbed, i.outhosdept,--ieb.outhosdept, add by zjy 2013-6-20
             d.name as cyks, ied.diagnosis_name as cyzd,e.applydocid
             from EMR_RecordBorrow e  inner join inpatient i
             on e.noofinpat = i.noofinpat
             left join users u on e.applydocid = u.id
             left join department d on i.outhosdept = d.id
              left join iem_mainpage_basicinfo_2012 ieb  on e.noofinpat = ieb.noofinpat
               left join iem_mainpage_diagnosis_2012 ied on ieb.iem_mainpage_no = ied.iem_mainpage_no
              and ieb.valide=1
              and ied.diagnosis_type_id<>13
             order by e.status,u.name,e.applydate,i.noofinpat,i.name,
             ied.create_time,ied.diagnosis_name
;

prompt
prompt Creating view MED_REC_BORROW_VIEW_ZY
prompt ====================================
prompt
create or replace force view emr.med_rec_borrow_view_zy as
Select  e.id,i.noofinpat, i.name,i.patid,---------Add by xlb 2013-05-30 ������Ӧ��ͬ������ҳ��ȡnoofrecord
             u.name as applyname,e.applydate,to_char(e.applydate,'yyyy-MM-dd hh24:mi:ss') as sqsj,
             i.isbaby,i.mother,--add by 2013-7-4 zjy
             e.applycontent,e.applytimes,e.approvedocid,e.approvecontent,
             e.approvedate,to_char(e.approvedate,'yyyy-MM-dd hh24:mi:ss') as shsj,
             nvl2(trim(e.yanqiflag),'��','��') as yq, e.status,'' as statusdes,
             i.AGESTR as age,i.outhosdate,i.outbed, i.outhosdept,--ieb.outhosdept, add by zjy 2013-6-20
             d.name as cyks, ied.diagnosis_name as cyzd,e.applydocid
             from EMR_RecordBorrow e  inner join inpatient i
             on e.noofinpat = i.noofinpat
             left join users u on e.applydocid = u.id
             left join department d on i.outhosdept = d.id
              left join iem_mainpage_basicinfo_sx ieb  on e.noofinpat = ieb.noofinpat
               left join iem_mainpage_diagnosis_sx ied on ieb.iem_mainpage_no = ied.iem_mainpage_no
              and ieb.valide=1
              and ied.diagnosis_type_id<>13
             order by e.status,u.name,e.applydate,i.noofinpat,i.name,
             ied.create_time,ied.diagnosis_name
;

prompt
prompt Creating view MED_REC_INHOSINP_OP_VIEW
prompt ======================================
prompt
create or replace force view emr.med_rec_inhosinp_op_view as
select  distinct i.noofinpat,i.name,i.AGESTR as age,i.sexid,i.outhosdate,i.PATID,i.ISLOCK,
             i.ADMITDATE, i.isbaby,i.mother,--add by 2013-7-4 zjy
             isday(datediff('dd',i.ADMITDATE,OUTHOSDATE))  as zyts,--zjy add 2013-6-27
             isday(datediff('dd',i.outhosdate,TO_CHAR(SYSDATE, 'yyyy-mm-dd')))  as ycyts,--zjy add 2013-6-27
             i.outhosdept,
             d.name as cyks, ied.diagnosis_name as cyzd,ied.create_time,ieo.operation_name,ieo.operation_date,
              --add by zjy ����µ���islock
              (case
           when ((i.islock is null) or islock='4700')  then 'δ�鵵'
           when i.islock='4701'then '�ѹ鵵'
           when i.islock='4702' then '�����鵵'
           else
            'δ֪'
         end) as gdzt,
         --add by ck 2013-8-26 �������ҽ���ֶ�
         (select users.name from users where users.id=i.resident) as ZZYS,
         i.resident
             from inpatient i
            left join  iem_mainpage_basicinfo_2012 ie on ie.noofinpat=i.noofinpat and ie.valide='1'
           left join iem_mainpage_diagnosis_2012 ied on ied.iem_mainpage_no=ie.iem_mainpage_no and ied.valide='1' and ied.diagnosis_type_id in(7,8)
          left join    iem_mainpage_operation_2012 ieo on ieo.iem_mainpage_no=ie.iem_mainpage_no and ieo.valide='1'
          left join department d on d.id=i.outhosdept
          where i.status in(1500,1501)
          --add by zjy 2013-6-16 ����
          ORDER BY i.noofinpat ASC
;

prompt
prompt Creating view MED_REC_INHOSINP_OP_VIEW_ZY
prompt =========================================
prompt
create or replace force view emr.med_rec_inhosinp_op_view_zy as
select  distinct i.noofinpat,i.name,i.AGESTR as age,i.sexid,to_char(to_date(i.outhosdate,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss') as outhosdate,
             i.ADMITDATE,   i.patid,i.ISLOCK,
             i.isbaby,i.mother,--add by 2013-7-4 zjy
             isday(datediff('dd',i.ADMITDATE,nvl(i.outhosdate,to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'))))  as zyts,--zjy add 2013-6-27
             isday(datediff('dd',i.outhosdate,TO_CHAR(SYSDATE, 'yyyy-mm-dd')))  as ycyts,--zjy add 2013-6-27
             i.outhosdept,------Modify by xlb  ȡ���˱��г�Ժ���� 2013-05-30
             d.name as cyks, ied.diagnosis_name as cyzd,ied.create_time,ieo.operation_name,ieo.operation_date,
        --add by zjy ����µ���islock
              (case
           when ((i.islock is null) or islock='4700')  then 'δ���'
           when i.islock='4701'then '�ѹ鵵'
           when i.islock='4702' then '�����鵵'
             when i.islock='4704'then '�����'
           when i.islock='4705' then '�����ʿ�'
              when i.islock='4706' then '���ύ'
           else
            'δ֪'
         end) as gdzt,
         --xll �������ҽ���ֶ�
      (select users.name from users where users.id=i.resident) as ZZYS,
      i.resident
             from inpatient i
             left join iem_mainpage_basicinfo_Sx ie on  ie.noofinpat=i.noofinpat and ie.valide=1
             left join iem_mainpage_diagnosis_Sx  ied on ied.iem_mainpage_no=ie.iem_mainpage_no and ied.valide=1 and ied.diagnosis_type_id in(7,8)
             left join iem_mainpage_operation_Sx  ieo on ieo.iem_mainpage_no=ie.iem_mainpage_no and ieo.valide=1
             left join department d on d.id=i.outhosdept
             where i.status in (1500,1501)
             --add by zjy 2013-6-16 �޸�
             order by i.NOOFINPAT ASC
;

prompt
prompt Creating view MED_REC_INPATIENT_OP_ALL_VIEW
prompt ===========================================
prompt
create or replace force view emr.med_rec_inpatient_op_all_view as
select  distinct i.noofinpat,i.name,i.AGESTR as age,i.sexid,to_char(to_date(i.outhosdate,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss') as outhosdate,
             i.ADMITDATE, i.patid,

            /*  (case
              when datediff('dd',i.ADMITDATE,i.OUTHOSDATE)=0 then 1
              else datediff('dd',i.ADMITDATE,i.OUTHOSDATE)
              end) as zyts*/
               isday(datediff('dd',i.ADMITDATE,OUTHOSDATE))  as zyts,--zjy add 2013-6-27
              isday(datediff('dd',i.outhosdate,TO_CHAR(SYSDATE, 'yyyy-mm-dd')))  as ycyts,--zjy add 2013-6-27
             --trunc(sysdate,'DD') - trunc(to_date(outhosdate,'yyyy-MM-dd'),'DD') as ycyts,
             i.outhosdept,------Modify by xlb  ȡ���˱��г�Ժ���� 2013-05-30
             d.name as cyks, ied.diagnosis_name as cyzd,ied.create_time,ieo.operation_name,ieo.operation_date,
            'δ�鵵' as gdzt
             from inpatient i
             left join iem_mainpage_basicinfo_2012 ie on  ie.noofinpat=i.noofinpat and ie.valide=1
             left join iem_mainpage_diagnosis_2012 ied on ied.iem_mainpage_no=ie.iem_mainpage_no and ied.valide=1 and ied.diagnosis_type_id in(7,8)
             left join iem_mainpage_operation_2012 ieo on ieo.iem_mainpage_no=ie.iem_mainpage_no and ieo.valide=1
             left join department d on d.id=i.outhosdept
             where i.status in (1502,1503)
;

prompt
prompt Creating view MED_REC_INPATIENT_OP_VIEW
prompt =======================================
prompt
create or replace force view emr.med_rec_inpatient_op_view as
select  distinct i.noofinpat,i.name,i.AGESTR as age,i.sexid,i.outhosdate,i.PATID,i.ISLOCK,
             i.ADMITDATE, i.isbaby,i.mother,--add by 2013-7-4 zjy
             isday(datediff('dd',i.ADMITDATE,OUTHOSDATE))  as zyts,--zjy add 2013-6-27
             isday(datediff('dd',i.outhosdate,TO_CHAR(SYSDATE, 'yyyy-mm-dd')))  as ycyts,--zjy add 2013-6-27
             i.outhosdept,
             d.name as cyks, ied.diagnosis_name as cyzd,ied.create_time,ieo.operation_name,ieo.operation_date,
              --add by zjy ����µ���islock
              (case
           when ((i.islock is null) or islock='4700')  then 'δ�鵵'
           when i.islock='4701'then '�ѹ鵵'
           when i.islock='4702' then '�����鵵'
           else
            'δ֪'
         end) as gdzt,
         --add by ck 2013-8-26 �������ҽ���ֶ�
         (select users.name from users where users.id=i.resident) as ZZYS,
         i.resident
             from inpatient i
            left join  iem_mainpage_basicinfo_2012 ie on ie.noofinpat=i.noofinpat and ie.valide='1'
           left join iem_mainpage_diagnosis_2012 ied on ied.iem_mainpage_no=ie.iem_mainpage_no and ied.valide='1' and ied.diagnosis_type_id in(7,8)
          left join    iem_mainpage_operation_2012 ieo on ieo.iem_mainpage_no=ie.iem_mainpage_no and ieo.valide='1'
          left join department d on d.id=i.outhosdept
          where i.status in(1502,1503)
          --add by zjy 2013-6-16 ����
          ORDER BY i.noofinpat ASC
;

prompt
prompt Creating view MED_REC_INPATIENT_OP_VIEW_ZY
prompt ==========================================
prompt
create or replace force view emr.med_rec_inpatient_op_view_zy as
select  distinct i.noofinpat,i.name,i.AGESTR as age,i.sexid,to_char(to_date(i.outhosdate,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss') as outhosdate,
             i.ADMITDATE,   i.patid,i.ISLOCK,
             i.isbaby,i.mother,--add by 2013-7-4 zjy
             isday(datediff('dd',i.ADMITDATE,i.outhosdate))  as zyts,--zjy add 2013-6-27
             isday(datediff('dd',i.outhosdate,TO_CHAR(SYSDATE, 'yyyy-mm-dd')))  as ycyts,--zjy add 2013-6-27
             i.outhosdept,------Modify by xlb  ȡ���˱��г�Ժ���� 2013-05-30
             d.name as cyks, ied.diagnosis_name as cyzd,ied.create_time,ieo.operation_name,ieo.operation_date,
        --add by zjy ����µ���islock
              (case
           when ((i.islock is null) or islock='4700')  then 'δ���'
           when i.islock='4701'then '�ѹ鵵'
           when i.islock='4702' then '�����鵵'
             when i.islock='4704'then '�����'
           when i.islock='4705' then '�����ʿ�'
              when i.islock='4706' then '���ύ'
                  when i.islock='4707' then '��д�ύ'
           else
            'δ֪'
         end) as gdzt,
         --xll �������ҽ���ֶ�
      (select users.name from users where users.id=i.resident) as ZZYS,
      i.resident
             from inpatient i
             left join iem_mainpage_basicinfo_Sx ie on  ie.noofinpat=i.noofinpat and ie.valide=1
             left join iem_mainpage_diagnosis_Sx  ied on ied.iem_mainpage_no=ie.iem_mainpage_no and ied.valide=1 and ied.diagnosis_type_id in(7,8)
             left join iem_mainpage_operation_Sx  ieo on ieo.iem_mainpage_no=ie.iem_mainpage_no and ieo.valide=1
             left join department d on d.id=i.outhosdept
             where i.status in (1502,1503)
             --add by zjy 2013-6-16 �޸�
             order by i.NOOFINPAT ASC
;

prompt
prompt Creating view MED_REC_INPATIENT_VIEW
prompt ====================================
prompt
create or replace force view emr.med_rec_inpatient_view as
select distinct i.noofinpat,i.name,i.AGESTR as age,i.sexid,i.admitdate,i.patid,i.outhosdate,
isday(datediff('dd',i.ADMITDATE,i.outhosdate))  as zyts,--zjy add 2013-6-27
isday(datediff('dd',i.outhosdate,TO_CHAR(SYSDATE, 'yyyy-mm-dd')))  as ycyts,--zjy add 2013-6-27
            --to_char(to_date(i.outhosdate,'yyyy-MM-dd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss') as outhosdate,
            i.outhosdept,d.name as cyks, ied.diagnosis_name as cyzd,ied.create_time
            from inpatient i
           left join iem_mainpage_basicinfo_2012 ie on ie.noofinpat=i.noofinpat and ie.valide='1'
           left join  iem_mainpage_diagnosis_2012 ied on ie.iem_mainpage_no=ied.iem_mainpage_no and ied.valide=1 and ied.diagnosis_type_id in(7,8)
           left join  department d on d.id=i.outhosdept
           where i.status in (1502,1503)
            and  i.islock=4701--add by zjy 2013-6-20

            --and exists (select 1 from recorddetail r where r.noofinpat=i.noofinpat and r.islock=4701 and r.valid=1)

            ORDER BY i.noofinpat
;

prompt
prompt Creating view MED_REC_INPATIENT_VIEW_ZY
prompt =======================================
prompt
create or replace force view emr.med_rec_inpatient_view_zy as
select distinct i.noofinpat,i.name,i.AGESTR as age,i.sexid,i.admitdate,i.patid,i.outhosdate,

             isday(datediff('dd',i.ADMITDATE,i.outhosdate))  as zyts,--zjy add 2013-6-27
             isday(datediff('dd',i.outhosdate,TO_CHAR(SYSDATE, 'yyyy-mm-dd')))  as ycyts,--zjy add 2013-6-27
           -- to_char(to_date(i.outhosdate,'yyyy-MM-dd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss') as outhosdate,
            i.outhosdept,d.name as cyks, ied.diagnosis_name as cyzd,ied.create_time
            from inpatient i
           left join iem_mainpage_basicinfo_Sx ie on ie.noofinpat=i.noofinpat and ie.valide='1'
           left join  iem_mainpage_diagnosis_Sx ied on ie.iem_mainpage_no=ied.iem_mainpage_no and ied.valide=1 and ied.diagnosis_type_id in(7,8)
           left join  department d on d.id=i.outhosdept
           where i.status in (1502,1503)
             and i.islock=4701--add by zjy 2013-6-20
            --and exists (select 1 from recorddetail r where r.noofinpat=i.noofinpat and r.islock=4701 and r.valid=1)
              ORDER BY i.noofinpat ASC
;

prompt
prompt Creating view MED_REC_WRITEUP_VIEW
prompt ==================================
prompt
create or replace force view emr.med_rec_writeup_view as
Select  e.id,i.noofinpat, i.name,i.patid,---------Add by xlb 2013-05-30 ������Ӧ��ͬ������ҳ��ȡnoofrecord
             u.name as applyname,e.applydate,to_char(e.applydate,'yyyy-MM-dd hh24:mi:ss') as sqsj,
             i.isbaby,i.mother,--add by 2013-7-4 zjy
             e.applycontent,e.applytimes,e.approvedocid,e.approvecontent,
             e.approvedate,to_char(e.approvedate,'yyyy-MM-dd hh24:mi:ss') as shsj,
             nvl2(trim(e.yanqiflag),'��','��') as yq, e.status,'' as statusdes,
             i.AGESTR as age,i.outhosdate,i.outbed, i.outhosdept,--ieb.outhosdept, add by zjy 2013-6-20
             d.name as cyks, ied.diagnosis_name as cyzd,e.applydocid
             from EMR_RECORDWRITEUP e  inner join inpatient i
             on e.noofinpat = i.noofinpat
             left join users u on e.applydocid = u.id
             left join department d on i.outhosdept = d.id
              left join iem_mainpage_basicinfo_2012 ieb  on e.noofinpat = ieb.noofinpat
               left join iem_mainpage_diagnosis_2012 ied on ieb.iem_mainpage_no = ied.iem_mainpage_no
              and ieb.valide=1
              and ied.diagnosis_type_id<>13
             order by e.status,u.name,e.applydate,i.noofinpat,i.name,
             ied.create_time,ied.diagnosis_name
;

prompt
prompt Creating view MED_REC_WRITEUP_VIEW_ZY
prompt =====================================
prompt
create or replace force view emr.med_rec_writeup_view_zy as
Select  e.id,i.noofinpat, i.name,i.patid,---------Add by xlb 2013-05-30 ������Ӧ��ͬ������ҳ��ȡnoofrecord
             u.name as applyname,e.applydate,to_char(e.applydate,'yyyy-MM-dd hh24:mi:ss') as sqsj,
             i.isbaby,i.mother,--add by 2013-7-4 zjy
             e.applycontent,e.applytimes,e.approvedocid,e.approvecontent,
             e.approvedate,to_char(e.approvedate,'yyyy-MM-dd hh24:mi:ss') as shsj,
             nvl2(trim(e.yanqiflag),'��','��') as yq, e.status,'' as statusdes,
             i.AGESTR as age,i.outhosdate,i.outbed, i.outhosdept,--ieb.outhosdept, add by zjy 2013-6-20
             d.name as cyks, ied.diagnosis_name as cyzd,e.applydocid
             from EMR_RECORDWRITEUP e  inner join inpatient i
             on e.noofinpat = i.noofinpat
             left join users u on e.applydocid = u.id
             left join department d on i.outhosdept = d.id
              left join iem_mainpage_basicinfo_sx ieb  on e.noofinpat = ieb.noofinpat
               left join iem_mainpage_diagnosis_sx ied on ieb.iem_mainpage_no = ied.iem_mainpage_no
              and ieb.valide=1
              and ied.diagnosis_type_id<>13
             order by e.status,u.name,e.applydate,i.noofinpat,i.name,
             ied.create_time,ied.diagnosis_name
;

prompt
prompt Creating view MRMSBASE_CHECK_FLAG
prompt =================================
prompt
create or replace force view emr.mrmsbase_check_flag
(inpatient_no, static_save)
as
select inpatient.noofinpat, '0'
from inpatient;

prompt
prompt Creating view OPERATIONVIEW
prompt ===========================
prompt
create or replace force view emr.operationview as
select
oper.iem_mainpage_no,  --������ҳ��
oper.iem_mainpage_operation_no,  --������ҳ��
oper.operation_code,  --������Ϣ����
oper.operation_date,  --����ʱ��
oper.operation_name,  --��������
oper.execute_user1,  --����һ��
oper.execute_user2,  --��������
oper.execute_user3,  --��������
oper.anaesthesia_type_id,  --��������
oper.close_level,  --������
oper.anaesthesia_user as anaesthesia_userid,  --����ҽʦ
oper.valide as OPER_valide,  --�����Ƿ���Ч
oper.create_user as OPER_create_user,  --������Ϣ������
oper.create_time as OPER_create_time,  --������Ϣ����ʱ��
oper.cancel_user as OPER_cancel_user,  --������Ϣȡ����
oper.cancel_time as OPER_cancel_time,  --������Ϣȡ��ʱ��
oper.operation_level as operation_levelid,  --�����ȼ�    ������Ϊ�ļ�
oper.ischoosedate as ischoosedateid,  --�Ƿ���������
oper.isclearope as isclearopeid,  --�Ƿ��޾�����
oper.isganran as isganranid,  --�Ƿ��Ⱦ
excuteuser1.name as excuteuser1,  --����ҽʦ
excuteuser2.name as excuteuser2,  --һ��
excuteuser3.name as excuteuser3,  --����
ANAESTHESIA_TYPE.Name as ANAESTHESIA_TYPE,  --����ʽ
ANAESTHESIA_USER.Name as ANAESTHESIA_USER,  --����ҽʦ
CANCEL_USER.Name as CANCEL_USER,  --ȡ����
OPERATION_LEVEL.Name as OPERATION_LEVEL,  --�����ȼ�
ischoosedate.name as ischoosedate,  --�Ƿ���������
isclearope.name as isclearope,  --�Ƿ��޾�����
isganran.name as isganran  --�Ƿ��Ⱦ
from
iem_mainpage_operation_2012 oper
left join users excuteuser1
on excuteuser1.id = oper.execute_user1
left join users excuteuser2
on excuteuser2.id = oper.execute_user2
left join users excuteuser3
on excuteuser3.id = oper.execute_user3
left join anesthesia ANAESTHESIA_TYPE
on ANAESTHESIA_TYPE.Id = oper.anaesthesia_type_id
left join users ANAESTHESIA_USER
on ANAESTHESIA_USER.Id = oper.anaesthesia_user
left join users CANCEL_USER
on CANCEL_USER.Id = oper.cancel_user
left join dictionary_detail OPERATION_LEVEL
on OPERATION_LEVEL.detailid = oper.operation_level and
OPERATION_LEVEL.categoryid = '71'
left join dictionary_detail ischoosedate
on ischoosedate.detailid = oper.ischoosedate and
ischoosedate.categoryid = '69'
left join dictionary_detail isclearope
on isclearope.detailid = oper.isclearope and
isclearope.categoryid = '69'
left join dictionary_detail isganran
on isganran.detailid = oper.isganran and
isganran.categoryid = '69'
and oper.valide='1'
;

prompt
prompt Creating view PATIENTRECORDSTATUSQUERY
prompt ======================================
prompt
create or replace force view emr.patientrecordstatusquery as
select  distinct i.noofinpat,i.noofrecord,i.name,i.AGESTR as age,i.incount,i.sexid,i.address,to_char(to_date(i.outhosdate,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss') as outhosdate,
             i.ADMITDATE,   i.patid,i.ISLOCK,
             i.isbaby,i.mother,--add by 2013-7-4 zjy
             isday(datediff('dd',i.ADMITDATE,i.outhosdate))  as zyts,--zjy add 2013-6-27
             isday(datediff('dd',i.outhosdate,TO_CHAR(SYSDATE, 'yyyy-mm-dd')))  as ycyts,--zjy add 20
             i.outhosdept,------Modify by xlb  ȡ���˱��г�Ժ���� 2013-05-30
             d.name as cyks,
        --add by zjy ����µ���islock
              (case
           when ((i.islock is null) or islock='4700')  then 'δ���'
           when i.islock='4701'then '�ѹ鵵'
           when i.islock='4702' then '�����鵵'
             when i.islock='4704'then '�����'
           when i.islock='4705' then '�����ʿ�'
              when i.islock='4706' then '���ύ'
                  when i.islock='4707' then '��д�ύ'
           else
            'δ֪'
         end) as gdzt,
        ( case when(i.sexid=1) then '��'
              when (i.sexid=2) then 'Ů'
                else 'δ֪' end) as sexname,

         --xll �������ҽ���ֶ�
      (select users.name from users where users.id=i.resident) as ZZYS,
      i.resident
             from inpatient i
             left join iem_mainpage_basicinfo_Sx ie on  ie.noofinpat=i.noofinpat and ie.valide=1
               left join iem_mainpage_operation_Sx  ieo on ieo.iem_mainpage_no=ie.iem_mainpage_no and ieo.valide=1
             left join department d on d.id=i.outhosdept

             --add by zjy 2013-6-16 �޸�
             order by i.NOOFINPAT ASC
;

prompt
prompt Creating view PLATFORM_GETCOLUMNBYID
prompt ====================================
prompt
CREATE OR REPLACE FORCE VIEW EMR.PLATFORM_GETCOLUMNBYID AS
SELECT
   inp.noofinpatient as noofinpat,
   inp.currdepartname as departname,
   inp.currwardname as wardname,
   col.valuexml as valuexml,
   col.rowflow as rowflow,
   item.dataelementid as id
   from INCOMMONNOTE inp
   left join Incommonnote_Column col on inp.incommonnoteflow = col.incommonnoteflow
   left join commonnote_item item on col.COMMONNOTE_ITEM_FLOW = item.COMMONNOTE_ITEM_FLOW;

prompt
prompt Creating view QCTIME_INPATIENT
prompt ==============================
prompt
create or replace force view emr.qctime_inpatient as
select noofinpat, patnoofhis, noofclinic, noofrecord, patid, name,
admitdept, admitward, admitbed,
to_date(admitdate, 'yyyy-mm-dd hh24:mi:ss') admitdate,
to_date(inwarddate, 'yyyy-mm-dd hh24:mi:ss') inwarddate,
outhosdept, outhosward, outbed,
to_date(outwarddate, 'yyyy-mm-dd hh24:mi:ss') outwarddate,
to_date(outhosdate, 'yyyy-mm-dd hh24:mi:ss') outhosdate,status,
to_date(ChangeDeptDateTime, 'yyyy-mm-dd hh24:mi:ss') changedeptdatetime,
to_date(deathdatetime, 'yyyy-mm-dd hh24:mi:ss') deathdatetime,
nvl2(deathdatetime, '1', '0') isdeath
from inpatient;

prompt
prompt Creating view QUEST_SOO_AT_EXECUTION_PLAN_V
prompt ===========================================
prompt
CREATE OR REPLACE FORCE VIEW EMR.QUEST_SOO_AT_EXECUTION_PLAN_V AS
SELECT trace_file_id, ep.sql_id, ep.parse_id, ep.ID, ep.cnt, ep.pid,
          ep.pos, ep.obj, ep.cr, ep.pr, ep.pw, ep.time_us,
          o.operation_string op
     FROM quest_soo_at_execution_plan ep JOIN quest_soo_at_operations o
          USING (trace_file_id, operation_id);

prompt
prompt Creating view QUEST_SOO_AT_SQL_WAITS_V
prompt ======================================
prompt
CREATE OR REPLACE FORCE VIEW EMR.QUEST_SOO_AT_SQL_WAITS_V AS
SELECT "EVENT_ID","TRACE_FILE_ID","SQL_ID","PARSE_ID","EXECUTION_ID","WAIT_ID","OBJ#","WAIT_COUNT","SUM_ELAPSED","SUMSQUARES_ELAPSED","NAM"
  FROM quest_soo_at_sql_waits
  JOIN quest_soo_at_wait_names USING (event_id);

prompt
prompt Creating view VIEW_SEEDOCTRECORD
prompt ================================
prompt
create or replace force view emr.view_seedoctrecord as
select t.noofinpat,
       (select a.patnoofhis from inpatient a where a.noofinpat = t.noofinpat) as inpatient_no,
       substr(dbms_lob.substr(t.content,
                              900,
                              dbms_lob.instr(t.content,
                                             'name="�ֲ�ʷ" level="" print="True">',
                                             1,
                                             1) +
                              length('name="�ֲ�ʷ" level="" print="True">')),
              1,
              Instr(dbms_lob.substr(t.content,
                                    900,
                                    dbms_lob.instr(t.content,
                                                   'name="�ֲ�ʷ" level="" print="True">',
                                                   1,
                                                   1) +
                                    length('name="�ֲ�ʷ" level="" print="True">')),
                    '</replace><eof /></p>') - 1) as current_illness, /*'name="�ֲ�ʷ" level="" print="True">',1,1) + 33,1)*/ /*�ֲ�ʷ*/
       substr(dbms_lob.substr(t.content,
                              900,
                              dbms_lob.instr(t.content,
                                             'name="����" level="" print="True">',
                                             1,
                                             1) +
                              length('name="����" level="" print="True">')),
              1,
              Instr(dbms_lob.substr(t.content,
                                    900,
                                    dbms_lob.instr(t.content,
                                                   'name="����" level="" print="True">',
                                                   1,
                                                   1) +
                                    length('name="����" level="" print="True">')),
                    '</replace>') - 1) as host_tell /*'name="�ֲ�ʷ" level="" print="True">',1,1) + 33,1)*/ /*����*/,
       t.name
  from recorddetail t
 where t.valid = '1'
   and (t.name like '�״β���%')
   and t.firstdailyflag = '1'
   and t.sortid = 'AC'
   and t.captiondatetime = (select min(x.captiondatetime)
                              from recorddetail x
                             where x.noofinpat = t.noofinpat
                               and x.valid = '1'
                               and (x.name like '�״β���%')
                               and x.firstdailyflag = '1'
                               and x.sortid = 'AC');

prompt
prompt Creating view VIEW_TMP_QUERYINWARDPATIENTS_2
prompt ============================================
prompt
CREATE OR REPLACE FORCE VIEW EMR.VIEW_TMP_QUERYINWARDPATIENTS_2 AS
SELECT distinct b.noofinpat noofinpat, --��ҳ���
             b.patnoofhis patnoofhis, --HIS��ҳ���
             b.patid patid, --סԺ��
             b.name patname, --����
             b.sexid sex, --�����Ա�
             j.name sexname, --�����Ա�����
             b.agestr agestr, --����
             b.py py, --ƴ��
             b.wb wb, --���
             b.status brzt, --����״̬
             e.name brztname, --����״̬����
             RTRIM(b.criticallevel) wzjb, --Σ�ؼ���
             i.name wzjbmc, --Σ�ؼ�������
             case b.attendlevel
               when '1' then
                'һ������'
               when '2' then
                '��������'
               when '3' then
                '��������'
               when '4' then
                '�ؼ�����'
               else
                'һ������'
             end hljb, --������

             case b.attendlevel
               when '1' then
                '6101'
               when '2' then
                '6102'
               when '3' then
                '6103'
               when '4' then
                '6104'
               else
                '6101'
             end attendlevel, --������
             b.isbaby yebz, --Ӥ����־
             CASE
               WHEN b.isbaby = '0' THEN
                '��'
               WHEN b.isbaby IS NULL THEN
                ''
               ELSE
                '��'
             END yebzname,
             b.outhosward bqdm, --��������
             b.outhosdept ksdm, --���Ҵ���
             case when length(b.outbed) = 1 then '0' || b.outbed else b.outbed end bedid, --��λ����
             dg.NAME ksmc, --��������
             wh.NAME bqmc, --��������
            -- a.formerward ybqdm, --ԭ��������
            -- a.formerdeptid yksdm, --ԭ���Ҵ���
            -- a.formerdeptid ycwdm, --ԭ��λ����
            -- --a.inbed inbed, --ռ����־
            -- a.deptid beddeptid,
           --  a.wardid bedwardid,
             '' inbed,--ռ����־ add by ywk  2012��11��5��15:02:39
             --a.borrow jcbz, --�贲��־
            -- a.sexinfo cwlx, --��λ����
             SUBSTR(b.admitdate, 1, 16) admitdate, --��Ժ����
             f.NAME ryzd, --��Ժ���
             f.NAME zdmc, --�������
             b.resident zyysdm, --סԺҽ������
             c.NAME zyys, --סԺҽ��
             c.NAME cwys, --��λҽ��
             g.NAME zzys, --����ҽʦ
             h.NAME zrys, --����ҽʦ
            -- a.valid yxjl, --��Ч��¼
             --me.pzlx pzlx, --ƾ֤����
             dd1.NAME pzlx, --�������
             b.memo memo, --��ע
             CASE b.cpstatus
               WHEN 0 THEN
                'δ����'
               WHEN 1 THEN
                'ִ����'
               WHEN 2 THEN
                '�˳�'
             END cpstatus,
             decode( (SELECT count(*)
                         FROM recorddetail tmp
                         WHERE b.noofinpat = tmp.noofinpat
                         and tmp.valid = '1'),0,'�޲���','����д' )
            recordinfo,
            decode( (SELECT count(*)
                         FROM recorddetail tmp
                         WHERE b.noofinpat = tmp.noofinpat
                         and tmp.valid = '1'),0,'�޲���','����д' )
            extra,
             100 ye, --���
             (SELECT CASE
                       WHEN COUNT(qc.foulstate) > 0 THEN
                        '��'
                       ELSE
                        '��'
                     END
                FROM qcrecord qc
               WHERE qc.noofinpat = b.noofinpat
                 AND qc.valid = 1
                 AND qc.foulstate = 1) AS iswarn, --�Ƿ�Υ��
                 b.outhosdept,
                 b.outhosward,
             b.incount as rycs --��Ժ����
              ,b.outbed
        FROM
       /* inpatient b*/
       (select * from inpatient where
          inpatient.status in ('1500','1501') AND inpatient.isbaby != '1') b

        /*LEFT JOIN Dictionary_detail dd1 ON dd1.categoryid = '1'
                                       AND b.payid = dd1.detailid*/
       LEFT JOIN
        (select Dictionary_detail.Name,Dictionary_detail.Detailid from Dictionary_detail where Dictionary_detail.categoryid = '1'
        ) dd1 ON b.payid = dd1.detailid
        /*LEFT JOIN categorydetail e ON b.status = e.ID
                                  AND e.categoryid = '15'*/
         LEFT JOIN
         (select categorydetail.id,categorydetail.name from categorydetail where categorydetail.categoryid = '15') e ON b.status = e.ID

         LEFT JOIN department dg ON b.outhosdept = dg.id
        LEFT JOIN ward wh ON b.outhosward = wh.id
        LEFT JOIN diagnosis f ON f.icd = b.admitdiagnosis
        LEFT JOIN users c ON c.ID = b.resident
       /* LEFT JOIN
        dictionary_detail i ON i.detailid = b.criticallevel
                                     AND i.categoryid = '53'*/
        LEFT JOIN
        (select dictionary_detail.name,dictionary_detail.detailid from dictionary_detail where dictionary_detail.categoryid = '53')  i ON i.detailid = b.criticallevel
        LEFT JOIN users g ON b.attend = g.id
        LEFT JOIN users h ON b.chief = h.id
        /*LEFT JOIN dictionary_detail j ON j.detailid = b.sexid
                                     AND j.categoryid = '3'*/
        LEFT JOIN
        (select dictionary_detail.name,dictionary_detail.detailid from dictionary_detail where dictionary_detail.categoryid = '3') j ON j.detailid = b.sexid

        /*LEFT JOIN categorydetail cd ON b.attendlevel = cd.ID
                                   AND cd.categoryid = '63'*/
        LEFT JOIN( select categorydetail.name,categorydetail.id from categorydetail where   categorydetail.categoryid = '63' )cd ON b.attendlevel = cd.ID


         /* where b.status in ('1500','1501') AND b.isbaby != '1'*/
       ORDER BY bedid
;

prompt
prompt Creating view ZC_BEDS
prompt =====================
prompt
CREATE OR REPLACE FORCE VIEW EMR.ZC_BEDS AS
(
SELECT
trim(b.bed_label)       /*��λ����*/,
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
c.inp_no||'_'||a.visit_id patnoofhis /*HIS ��ҳ���*/,
1  valid     /*��Ч��¼*/
FROM  pats_in_hospital a,bed_rec b,pat_master_index c
where a.patient_id = c.patient_id and a.ward_code = b.ward_code and a.bed_no=b.bed_no

)
;

prompt
prompt Creating view ZC_DEPARTMENTS
prompt ============================
prompt
create or replace force view emr.zc_departments as
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
)
;

prompt
prompt Creating view ZC_DEPT2WARD
prompt ==========================
prompt
CREATE OR REPLACE FORCE VIEW EMR.ZC_DEPT2WARD AS
(
SELECT distinct
dept_vs_ward.ward_code deptid /*���Ҵ���*/,
dept_vs_ward.dept_code wardid /*��������*/,
0 totalbed /*��λ��*/
FROM dept_vs_ward
);

prompt
prompt Creating view ZC_INPAT
prompt ======================
prompt
create or replace force view emr.zc_inpat as
select "PATNOOFHIS","NOOFCLINIC","NOOFRECORD","PATID","NAME","PAYID","PACT_NAME","ORIGIN","SOURCE_NAME","INCOUNT","SEXID","SEXNAME","BIRTH","AGE","AGESTR","IDNO","MARITAL","MARI","JOBID","JOBNAME","PROVINCENAME","COUNTYNAME","NATIONALITYID","NATIONID","NATIONALITYNAME","ORGANIZATION","OFFICEPLACE","OFFICETEL","OFFICEPOST","PROVINCEID","NATIVEADDRESS","NATIVETEL","NATIVEPOST","ADDRESS","CONTACTPERSON","RELATIONSHIP","RELA_NAME","CONTACTADDRESS","CONTACTOFFICE","CONTACTTEL","CONTACTPOST","SOCIALCARE","INSURANCE","CARDNO","ADMITINFO","ADMITDEPT","ADMITWARD","ADMITBED","ADMITDATE","INWARDDATE","ADMITDIAGNOSIS","OUTHOSDEPT","OUTHOSWARD","OUTBED","OUTWARDDATE","OUTHOSDATE","OUTDIAGNOSIS","CLINICDIAGNOSIS","ADMITWAY","ADMITWAYNAME","OUTWAY","OUTWAYNAME","CLINICDOCTOR","CLINICDOCTORNAME","RESIDENT","RESIDENTNAME","ATTEND","ATTENDNAME","CHIEF","CHIEFNAME","STATUS","STATUSNAME","CRITICALLEVEL","CRITICALLEVELNAME","ATTENDLEVEL","ATTENDLEVELNAME","ISBABY","MOTHER","MEDICAREID","STYLE" from system.zc_inpatient;

prompt
prompt Creating view ZC_INPATIENT
prompt ==========================
prompt
create or replace force view emr.zc_inpatient as
select "PATNOOFHIS","NOOFCLINIC","NOOFRECORD","PATID","NAME","PAYID","PACT_NAME","ORIGIN","SOURCE_NAME","INCOUNT","SEXID","SEXNAME","BIRTH","AGE","AGESTR","IDNO","MARITAL","MARI","JOBID","JOBNAME","PROVINCENAME","COUNTYNAME","NATIONALITYID","NATIONNAME","NATIONID","NATIONALITYNAME","ORGANIZATION","OFFICEPLACE","OFFICETEL","OFFICEPOST","PROVINCEID","NATIVEADDRESS","NATIVETEL","NATIVEPOST","ADDRESS","CONTACTPERSON","RELATIONSHIP","RELA_NAME","CONTACTADDRESS","CONTACTOFFICE","CONTACTTEL","CONTACTPOST","SOCIALCARE","INSURANCE","CARDNO","ADMITINFO","ADMITDEPT","ADMITWARD","ADMITBED","ADMITDATE","INWARDDATE","ADMITDIAGNOSIS","OUTHOSDEPT","OUTHOSWARD","OUTBED","OUTWARDDATE","OUTHOSDATE","OUTDIAGNOSIS","CLINICDIAGNOSIS","ADMITWAY","ADMITWAYNAME","OUTWAY","OUTWAYNAME","CLINICDOCTOR","CLINICDOCTORNAME","RESIDENT","RESIDENTNAME","ATTEND","ATTENDNAME","CHIEF","CHIEFNAME","STATUS","STATUSNAME","CRITICALLEVEL","CRITICALLEVELNAME","ATTENDLEVEL","ATTENDLEVELNAME","ISBABY","MOTHER","MEDICAREID","STYLE" from system.zc_inpatient;

prompt
prompt Creating view ZC_MADEORDER
prompt ==========================
prompt
CREATE OR REPLACE FORCE VIEW EMR.ZC_MADEORDER AS
(
SELECT
orders.VISIT_ID            inpatient_no    ,--סԺ��ˮ��
pat_master_index.inp_no    patient_no      ,--סԺ������
orders.ORDERING_DEPT       deptid    ,--ҽ�����Ҵ���
''                         wardid,--ҽ������վ����
orders.ORDER_NO            MO_ORDER,--ҽ����ˮ��
orders.DOCTOR_USER         doc_code,--ҽ��ҽʦ����
orders.DOCTOR              DOC_NAME,--ҽ��ҽʦ����
orders.ENTER_DATE_TIME     MO_DATE ,--ҽ������
CASE  pat_visit.newborn    WHEN '1' THEN '1'
                           ELSE '2'
                           END  BABY_FLAG,--�Ƿ�Ӥ��ҽ��   1��/2��
orders.order_class         TYPE_NAME           ,--ҽ���������
CASE orders.BILLING_ATTR   WHEN 0 THEN '��'
                           WHEN 2 THEN '��'
                           ELSE '��'
                           END  CHARGE_STATE,--�Ƿ�Ʒ�   1��/2��
orders_costs.ITEM_CODE     ITEM_CODE           ,--��Ŀ����
orders_costs.ITEM_NAME     ITEM_NAME           ,--��Ŀ����
orders_costs.ITEM_CLASS    CLASS_NAME          ,--��Ŀ�������
''                         EXEC_DPNM           ,--ִ�п�������
''                         MIN_UNIT            ,--��С��λ
orders_costs.UNITS         PRICE_UNIT          ,--�Ƽ۵�λ
orders_costs.AMOUNT        PACK_QTY            ,--��װ����
orders_costs.ITEM_SPEC     SPECS               ,--���
''                         DOSE_MODEL_CODE     ,--���ʹ���
''                         DRUG_TYPE           ,--ҩƷ���
''                         ITEM_PRICE          ,--���ۼ�
''                         COMB_NO             ,--������
''                         MAIN_DRUG           ,--��ҩ���
orders.ORDER_STATUS        MO_STAT             ,--ҽ��״̬
orders.ADMINISTRATION      USE_NAME            ,--�÷�����
orders.FREQUENCY           DFQ_CEXP            ,--Ƶ������
orders.DOSAGE              DOSE_ONCE           ,--ÿ�μ���
orders.DOSAGE_UNITS        DOSE_UNIT           ,--������λ
''                         USE_DAYS            ,--ʹ������
orders_costs.TOTAL_AMOUNT  QTY_TOT             ,--��Ŀ����
orders.START_DATE_TIME     DATE_BGN            ,--��ʼʱ��
orders.STOP_DATE_TIME      DATE_END            ,--����ʱ��
''                         REC_USERCD          ,--¼����Ա���� ǰ���п�ҽ��ҽ������
''                         REC_USERNM          ,--¼����Ա����
CASE orders.processing_nurse         WHEN '' THEN 'δȷ��'
                                      ELSE '��ȷ��'
                                      END  CONFIRM_FLAG        ,--ȷ�ϱ��1δȷ��/2��
orders.processing_date_time      CONFIRM_DATE        ,--ȷ��ʱ�� ת��
''                                CONFIRM_USERCD      ,--ȷ����Ա���� ת��
''DC_FLAG             ,--Dc���1δdc/2��dc
''DC_DATE             ,--Dcʱ��
''DC_CODE             ,--DCԭ�����
''DC_NAME             ,--DCԭ������
''DC_DOCCD            ,--DCҽʦ����
''DC_DOCNM            ,--DCҽʦ����
''DC_USERCD           ,--Dc��Ա����
''DC_USERNM           ,--Dc��Ա����
CASE orders.processing_nurse          WHEN '' THEN 'δȷ��'
                                      ELSE '��ȷ��'
                                      END  EXECUTE_FLAG        ,--ִ�б��1δִ��/2��ִ��/3DCִ��
orders.PERFORM_SCHEDULE           EXECUTE_DATE        ,--ִ��ʱ��
''                                EXECUTE_USERCD      ,--ִ����Ա����
orders.FREQ_DETAIL                MO_NOTE1            ,--ҽ��˵��
''MO_NOTE2            ,--��ע
orders.REPEAT_INDICATOR           MOGP_CODE           ,--����������
CASE orders.REPEAT_INDICATOR          WHEN  1 THEN '����'
                                      ELSE '��ʱ'
                                      END   MOGP_NAME  ,--�����������
''GET_FLAG            ,--ҽ����ȡ���:1����ȡ/2����ȡ/3DC��ȡ
''SUBTBL_FLAG        ,--�Ƿ񸽲�'1'��
''SORT_ID             ,--������ţ�����������ɴ�С˳����ʾҽ��
''DC_CONFIRM_DATE     ,--DC���ʱ��
''DC_CONFIRM_OPER     ,--DC�����
''DC_CONFIRM_FLAG     ,--DC��˱�ǣ�0δ��ˣ�1�����
''VALID_USRN        ,
''PSJG                ,--Ƥ�Խ�� 1Ϊ����0Ϊ����
''PSBJ                 --Ƥ�Ա�� 1Ϊ��Ҫ0Ϊ����Ҫ

FROM  ORDERS,ORDERS_COSTS,PAT_MASTER_INDEX,PAT_VISIT
WHERE ORDERS.PATIENT_ID=ORDERS_COSTS.PATIENT_ID(+)  AND
      ORDERS.VISIT_ID=ORDERS_COSTS.VISIT_ID(+)      AND
      ORDERS.ORDER_NO=ORDERS_COSTS.ORDER_NO(+)      AND
      ORDERS.ORDER_SUB_NO=ORDERS_COSTS.ORDER_SUB_NO(+)  AND
      PAT_MASTER_INDEX.PATIENT_ID=ORDERS.PATIENT_ID  AND
      PAT_VISIT.PATIENT_ID=ORDERS.PATIENT_ID        AND
      PAT_VISIT.VISIT_ID=ORDERS.VISIT_ID


)

-- End of DDL Script for View YCHIS.YD_MADEORDER
;

prompt
prompt Creating view ZC_TRANSFER
prompt =========================
prompt
create or replace force view emr.zc_transfer as
select patient_id, visit_id, min(admission_date_time) adt_ward_datetime,max(discharge_date_time) dis_ward_datetime
  from transfer
 group by patient_id, visit_id;

prompt
prompt Creating view ZC_USERS
prompt ======================
prompt
create or replace force view emr.zc_users as
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

prompt
prompt Creating view ZC_USER2DEPT
prompt ==========================
prompt
CREATE OR REPLACE FORCE VIEW EMR.ZC_USER2DEPT AS
(
SELECT
to_char(nvl(staff_dict.id,00),'000000') userid  /*ְ������*/,
staff_dict.dept_code /*���Ҵ���*/,
'51201' /*��������*/
FROM staff_dict,zc_users
where staff_dict.name <> '����Ա' and
zc_users.id = to_char(nvl(staff_dict.id,00),'000000')

);

prompt
prompt Creating view ZC_WARDS
prompt ======================
prompt
create or replace force view emr.zc_wards as
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


spool off

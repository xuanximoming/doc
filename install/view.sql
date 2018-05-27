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
baby.iem_mainpage_no,  --病案主页号
baby.iem_mainpage_obsbabyid,  --婴儿主页号
baby.tc,  --胎次
baby.cc,  --产次
baby.tb,  --胎别
baby.cfhypld,  --产妇会阴破裂度
baby.midwifery,  --接产者
baby.sex as babySex,  --性别
baby.apj,  --阿帕加评加
baby.heigh,  --身长
baby.weight as BABY_weight,  --体重
baby.ccqk as ccqkID,  --产出情况
baby.bithday,  --出生时间
baby.fmfs as fmfsID,  --分娩方式
baby.cyqk as cyqkID,  --出院情况
baby.create_user as BABY_create_user,  --婴儿信息创建人
baby.create_time as BABY_create_time,  --婴儿信息创建时间
baby.valide as BABY_valide,  --婴儿信息是否有效
midwifery.name as midwiferyName,  --接产者
sex.name as sex,  --性别
ccqk.name as ccqk,  --产出情况
fmfs.name as fmfs,  --分娩方式
cyqk.name as cyqk,  --出院情况
create_user.name as create_user  --创建人
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
basic.IEM_MAINPAGE_NO,  --病案首页标识
basic.PATNOOFHIS,  --病案号
basic.NOOFINPAT,  --病人首页序号
basic.PAYID,  --医疗付款方式ID
basic.SOCIALCARE,  --社保卡号
basic.INCOUNT,  --入院次数
basic.NAME,  --患者姓名
basic.sexid,  --性别
basic.BIRTH,  --出生
basic.MARITAL,  --婚姻状况 1.未婚 2.已婚 3.丧偶4.离婚 9.其他
basic.JOBID,  --职业
basic.NATIONID,  --民族
basic.NATIONALITYID,  --国籍ID
basic.IDNO,  --身份证号码
basic.ORGANIZATION,  --工作单位
basic.OFFICEPLACE,  --工作单位地址
basic.OFFICETEL,  --工作单位电话
basic.OFFICEPOST,  --工作单位邮编
basic.CONTACTPERSON,  --联系人姓名
basic.RELATIONSHIP,  --与联系人关系
basic.CONTACTADDRESS,  --联系人地址
basic.CONTACTTEL,  --联系人电话
basic.ADMITDATE,  --入院时间
basic.ADMITDEPT,  --入院科室
basic.ADMITWARD,  --入院病区
basic.TRANS_DATE,  --转院时间
basic.TRANS_ADMITDEPT,  --转院科别
basic.TRANS_ADMITWARD,  --转院病区
basic.OUTWARDDATE,  --出院时间
basic.OUTHOSDEPT,  --出院科室
basic.OUTHOSWARD,  --出院病区
basic.ACTUALDAYS,  --实际住院天数
basic.PATHOLOGY_DIAGNOSIS_NAME,  --病理诊断名称
basic.PATHOLOGY_OBSERVATION_SN,  --病理检查号
basic.ALLERGIC_DRUG,  --过敏药物
basic.SECTION_DIRECTOR,  --科主任
basic.DIRECTOR,  --主（副主）任医师
basic.VS_EMPLOYEE_CODE,  --主治医师
basic.RESIDENT_EMPLOYEE_CODE,  --住院医师
basic.REFRESH_EMPLOYEE_CODE,  --进修医师
basic.DUTY_NURSE,  --责任护士
basic.INTERNE,  --实习医师
basic.CODING_USER,  --编码员
basic.MEDICAL_QUALITY_ID,  --病案质量
basic.QUALITY_CONTROL_DOCTOR,  --质控医师
basic.QUALITY_CONTROL_NURSE,  --质控护士
basic.QUALITY_CONTROL_DATE,  --质控时间
basic.XAY_SN,  --x线检查号
basic.CT_SN,  --CT检查号
basic.MRI_SN,  --mri检查号
basic.DSA_SN,  --Dsa检查号
basic.BLOODTYPE as bloodTypeID,  --血型
basic.RH as RHID,  --Rh
basic.IS_COMPLETED,  --完成否 y/n
basic.COMPLETED_TIME,  --完成时间
basic.VALIDE,  --作废否 1/0
basic.CREATE_USER,  --创建此记录者
basic.CREATE_TIME,  --创建时间
basic.MODIFIED_USER,  --修改此记录者
basic.MODIFIED_TIME,  --修改时间
basic.ZYMOSIS,  --医院传染病
basic.HURT_TOXICOSIS_ELE_ID,  --损伤、中毒的外部因素
basic.HURT_TOXICOSIS_ELE_NAME,  --损伤、中毒的外部因素
basic.ZYMOSISSTATE,  --医院传染病状态
basic.PATHOLOGY_DIAGNOSIS_ID,  --病理诊断编号
basic.MONTHAGE,  --（年龄不足1周岁的） 年龄(月)
basic.WEIGHT,  --新生儿出生体重(克)
basic.INWEIGHT,  --新生儿入院体重(克)
basic.INHOSTYPE,  --入院途径:1.急诊  2.门诊  3.其他医疗机构转入  9.其他
basic.OUTHOSTYPE,  --离院方式 □ 1.医嘱离院  2.医嘱转院 3.医嘱转社区卫生服务机构/乡镇卫生院 4.非医嘱离院5.死亡9.其他
basic.RECEIVEHOSPITAL,  --2.医嘱转院，拟接收医疗机构名称：
basic.RECEIVEHOSPITAL2,  --3.医嘱转社区卫生服务机构/乡镇卫生院，拟接收医疗机构名称：
basic.AGAININHOSPITAL,  --是否有出院31天内再住院计划 □ 1.无  2.有
basic.AGAININHOSPITALREASON,  --出院31天内再住院计划 目的:
basic.BEFOREHOSCOMADAY,  --颅脑损伤患者昏迷时间： 入院前    天
basic.BEFOREHOSCOMAHOUR,  --颅脑损伤患者昏迷时间： 入院前     小时
basic.BEFOREHOSCOMAMINUTE,  --颅脑损伤患者昏迷时间： 入院前    分钟
basic.LATERHOSCOMADAY,  --颅脑损伤患者昏迷时间： 入院后    天
basic.LATERHOSCOMAHOUR,  --颅脑损伤患者昏迷时间： 入院后    小时
basic.LATERHOSCOMAMINUTE,  --颅脑损伤患者昏迷时间： 入院后    分钟
basic.CARDNUMBER,  --健康卡号
basic.ALLERGIC_FLAG,  --药物过敏1.无 2.有
basic.AUTOPSY_FLAG,  --死亡患者尸检 □ 1.是  2.否
basic.CSD_PROVINCEID,  --出生地 省
basic.CSD_CITYID,  --出生地 市
basic.CSD_DISTRICTID,  --出生地 县
basic.CSD_PROVINCENAME,  --出生地 省名称
basic.CSD_CITYNAME,  --出生地 市名称
basic.CSD_DISTRICTNAME,  --出生地 县名称
basic.XZZ_PROVINCEID,  --现住址 省
basic.XZZ_CITYID,  --现住址 市
basic.XZZ_DISTRICTID,  --现住址 县
basic.XZZ_PROVINCENAME,  --现住址 省名称
basic.XZZ_CITYNAME,  --现住址 市名称
basic.XZZ_DISTRICTNAME,  --现住址 县名称
basic.XZZ_TEL,  --现住址 电话
basic.XZZ_POST,  --现住址 邮编
basic.HKDZ_PROVINCEID,  --户口地址 省
basic.HKDZ_CITYID,  --户口地址 市
basic.HKDZ_DISTRICTID,  --户口地址 县
basic.HKDZ_PROVINCENAME,  --户口地址 省名称
basic.HKDZ_CITYNAME,  --户口地址 市名称
basic.HKDZ_DISTRICTNAME,  --户口地址 县名称
basic.HKDZ_POST,  --户口所在地邮编
basic.JG_PROVINCEID,  --籍贯 省名称
basic.JG_CITYID,  --籍贯 市名称
basic.JG_PROVINCENAME,  --籍贯 省名称
basic.JG_CITYNAME,  --籍贯 市名称
basic.AGE,  --患者年龄
basic.ZG_FLAG,  --转归：□ 1.治愈 2.好转 3.未愈 4.死亡 5.其他
basic.ADMITINFO,  --
basic.CSDADDRESS,  --出生地地址
basic.JGADDRESS,  --籍贯地址
basic.XZZADDRESS,  --现住址
basic.HKADDRESS,  --户口住址
basic.MENANDINHOP as MENANDINHOPID,  --门诊与住院
basic.INHOPANDOUTHOP as INHOPANDOUTHOPID,  --入院与出院
basic.BEFOREOPEANDAFTEROPER as BEFOREOPEANDAFTEROPERID,  --术前与术后
basic.LINANDBINGLI as LINANDBINGLIID,  --临床与病理
basic.INHOPTHREE as INHOPTHREEID,  --入院三日内
basic.fangandbingli as fangandbingliID,  --放射与病理
paymethod.name as paymethod,  --付款方式
sex.name as sex,  --性别
marry.name as marry,  --婚姻状况
job.name as job,  --职业
nation.name as nation,  --民族
country.name as country,  --国籍
ralation.name as ralation,  --与联系人关系
departIn.Name as departIn,  --入院科室
wardIn.Name as wardIn,  --入院病区
departTran.Name as departTran,  --转院科别
wardTran.Name  as wardTran,  --转院病区
departOut.Name as departOut,  --出院科室
wardOut.Name as wardOut,  --出院病区
secDirect.Name as secDirect,  --科主任
direct.name as direct,  --主（副主）任医师
vsEmployee.Name as vsEmployee,  --主治医师
residentEmployee.Name as residentEmployee,  --住院医师
refreshEmployee.Name as refreshEmployee,  --进修医师
dutyNurse.Name as dutyNurse,  --责任护士
internEmployee.Name as internEmployee,  --实习医师
codingUser.Name as codingUser,  --编码员
quaCtrlDoctor.Name as quaCtrlDoctor,  --质控医师
quaCtrlNurse.Name as quaCtrlNurse,  --质控护士
bloodType.Name as bloodType,  --血型
rh.name as rh,  --Rh
createUser.Name as createUser,  --创建此记录者
modifyUser.Name as modifyUser,  --修改此记录者
diagno.name as diagnosis,  --病理诊断
inStype.Name as inStype,  --入院途径
outStype.Name as outStype,  --离院方式
autoPsy.Name as autoPsy,  --死亡患者尸检
zg.name as zg,  --转归
menandinhop.name as menandinhop,  --门诊与住院
inhopandouthop.name as inhopandouthop,  --入院与出院
beforeopeandafteroper.name as beforeopeandafteroper,  --术前与术后
linandbingli.name as linandbingli,  --临床与病理
inhopthree.name as inhopthree,  --入院三日内
fangandbingli.name as fangandbingli,  --放射与病理
basic.patflag--判断的是否符合出院卡片的验证，供HIS调用
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
             '药品'
            when 'B' then
             '药品'
            else
             '非药品'
          end)
         else
          ''
       end,
       case a.order_sub_no
         when 1 then
          (case ORDER_CLASS
            when 'A' then
             '药品'
            when 'B' then
             '药品'
            else
             '非药品'
          end)
         else
          ''
       end,
       case a.order_sub_no
         when 1 then
          (case a.repeat_indicator
            when 1 then
             '长期'
            else
             '临时'
          end)
         else
          ''
       end,
       to_char(a.stop_date_time, 'yyyy-mm-dd hh24:mi:ss'),
       a.order_no || '  ' || a.order_text || '  ' ||
       (decode(a.dosage, null, '', to_char(a.dosage, 'FM999990.0099'))) ||
       a.dosage_units|| '  '||
       decode(a.freq_detail,'','','说明：'||a.freq_detail),
       a.order_no
  from orders a;

prompt
prompt Creating view DIAGNOSISVIEW
prompt ===========================
prompt
create or replace force view emr.diagnosisview as
select
dia.iem_mainpage_no,  --病案首页标识
dia.iem_mainpage_diagnosis_no,  --诊断首页标识
dia.DIAGNOSIS_TYPE_ID,  --诊断类型
dia.DIAGNOSIS_CODE,  --诊断编码
dia.DIAGNOSIS_NAME as DIAGNOSIS_NAMEID,  --诊断名称编号
dia.STATUS_ID,  --诊断状态编码
dia.ORDER_VALUE,  --
dia.VALIDE as DIA_VALIDE,  --诊断是否有效
dia.CREATE_USER as DIA_CREATE_USER,  --诊断信息创建人
dia.CREATE_TIME as DIA_CREATE_TIME,  --诊断信息创建时间
dia.CANCEL_USER,  --诊断信息取消人
dia.CANCEL_TIME,  --诊断信息取消时间
dia.MENANDINHOP as DIA_MENANDINHOP,  --门诊与住院诊断符合情况
dia.INHOPANDOUTHOP as DIA_INHOPANDOUTHOP,  --入院与出院诊断符合情况
dia.BEFOREOPEANDAFTEROPER as DIA_BEFOREOPEANDAFTEROPER,  --术前与术后诊断符合情况
dia.LINANDBINGLI as IDA_LINANDBINGLI,  --临床与病理诊断符合情况
dia.INHOPTHREE as DIA_INHOPTHREE,  --入院三日内诊断符合情况
dia.FANGANDBINGLI as DIA_FANGANDBINGLI,  --放射与病理诊断符合情况
dia.ADMITINFO as DIA_ADMITINFO,  --入院病情
diagnosisName.Name as diagnosisName,  --诊断名称
createUser.Name as createUser,  --创建人
cancelUser.Name as cancelUser,  --取消人
menandinhop.name as menandinhop,  --门诊与住院
inhopandouthop.name as inhopandouthop,  --入院与出院
beforeopeandafteroper.name as beforeopeandafteroper,  --术前与术后
linandbingli.name as linandbingli,  --临床与病理
inhopthree.name as inhopthree,  --入院三日内
fangandbingli.name as fangandbingli  --放射与病理
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
select t.patnoofhis 住院号,t.name 姓名,(select dt.name from department dt where dt.id=t.admitdept) 科室
from inpatient t where t.noofinpat in(select rd.noofinpat from recorddetail rd where rd.name like '%手术%' and rd.createtime between '2011-08-01 00:00:00' and '2011-08-31 00:00:00');

prompt
prompt Creating view MED_REC_BORROW_VIEW
prompt =================================
prompt
create or replace force view emr.med_rec_borrow_view as
Select  e.id,i.noofinpat, i.name,i.patid,---------Add by xlb 2013-05-30 病历号应该同病案首页均取noofrecord
             u.name as applyname,e.applydate,to_char(e.applydate,'yyyy-MM-dd hh24:mi:ss') as sqsj,
             i.isbaby,i.mother,--add by 2013-7-4 zjy
             e.applycontent,e.applytimes,e.approvedocid,e.approvecontent,
             e.approvedate,to_char(e.approvedate,'yyyy-MM-dd hh24:mi:ss') as shsj,
             nvl2(trim(e.yanqiflag),'是','否') as yq, e.status,'' as statusdes,
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
Select  e.id,i.noofinpat, i.name,i.patid,---------Add by xlb 2013-05-30 病历号应该同病案首页均取noofrecord
             u.name as applyname,e.applydate,to_char(e.applydate,'yyyy-MM-dd hh24:mi:ss') as sqsj,
             i.isbaby,i.mother,--add by 2013-7-4 zjy
             e.applycontent,e.applytimes,e.approvedocid,e.approvecontent,
             e.approvedate,to_char(e.approvedate,'yyyy-MM-dd hh24:mi:ss') as shsj,
             nvl2(trim(e.yanqiflag),'是','否') as yq, e.status,'' as statusdes,
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
              --add by zjy 添加新的列islock
              (case
           when ((i.islock is null) or islock='4700')  then '未归档'
           when i.islock='4701'then '已归档'
           when i.islock='4702' then '撤销归档'
           else
            '未知'
         end) as gdzt,
         --add by ck 2013-8-26 添加主治医生字段
         (select users.name from users where users.id=i.resident) as ZZYS,
         i.resident
             from inpatient i
            left join  iem_mainpage_basicinfo_2012 ie on ie.noofinpat=i.noofinpat and ie.valide='1'
           left join iem_mainpage_diagnosis_2012 ied on ied.iem_mainpage_no=ie.iem_mainpage_no and ied.valide='1' and ied.diagnosis_type_id in(7,8)
          left join    iem_mainpage_operation_2012 ieo on ieo.iem_mainpage_no=ie.iem_mainpage_no and ieo.valide='1'
          left join department d on d.id=i.outhosdept
          where i.status in(1500,1501)
          --add by zjy 2013-6-16 新增
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
             i.outhosdept,------Modify by xlb  取病人表中出院科室 2013-05-30
             d.name as cyks, ied.diagnosis_name as cyzd,ied.create_time,ieo.operation_name,ieo.operation_date,
        --add by zjy 添加新的列islock
              (case
           when ((i.islock is null) or islock='4700')  then '未完成'
           when i.islock='4701'then '已归档'
           when i.islock='4702' then '撤销归档'
             when i.islock='4704'then '已完成'
           when i.islock='4705' then '科室质控'
              when i.islock='4706' then '已提交'
           else
            '未知'
         end) as gdzt,
         --xll 添加主治医生字段
      (select users.name from users where users.id=i.resident) as ZZYS,
      i.resident
             from inpatient i
             left join iem_mainpage_basicinfo_Sx ie on  ie.noofinpat=i.noofinpat and ie.valide=1
             left join iem_mainpage_diagnosis_Sx  ied on ied.iem_mainpage_no=ie.iem_mainpage_no and ied.valide=1 and ied.diagnosis_type_id in(7,8)
             left join iem_mainpage_operation_Sx  ieo on ieo.iem_mainpage_no=ie.iem_mainpage_no and ieo.valide=1
             left join department d on d.id=i.outhosdept
             where i.status in (1500,1501)
             --add by zjy 2013-6-16 修改
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
             i.outhosdept,------Modify by xlb  取病人表中出院科室 2013-05-30
             d.name as cyks, ied.diagnosis_name as cyzd,ied.create_time,ieo.operation_name,ieo.operation_date,
            '未归档' as gdzt
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
              --add by zjy 添加新的列islock
              (case
           when ((i.islock is null) or islock='4700')  then '未归档'
           when i.islock='4701'then '已归档'
           when i.islock='4702' then '撤销归档'
           else
            '未知'
         end) as gdzt,
         --add by ck 2013-8-26 添加主治医生字段
         (select users.name from users where users.id=i.resident) as ZZYS,
         i.resident
             from inpatient i
            left join  iem_mainpage_basicinfo_2012 ie on ie.noofinpat=i.noofinpat and ie.valide='1'
           left join iem_mainpage_diagnosis_2012 ied on ied.iem_mainpage_no=ie.iem_mainpage_no and ied.valide='1' and ied.diagnosis_type_id in(7,8)
          left join    iem_mainpage_operation_2012 ieo on ieo.iem_mainpage_no=ie.iem_mainpage_no and ieo.valide='1'
          left join department d on d.id=i.outhosdept
          where i.status in(1502,1503)
          --add by zjy 2013-6-16 新增
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
             i.outhosdept,------Modify by xlb  取病人表中出院科室 2013-05-30
             d.name as cyks, ied.diagnosis_name as cyzd,ied.create_time,ieo.operation_name,ieo.operation_date,
        --add by zjy 添加新的列islock
              (case
           when ((i.islock is null) or islock='4700')  then '未完成'
           when i.islock='4701'then '已归档'
           when i.islock='4702' then '撤销归档'
             when i.islock='4704'then '已完成'
           when i.islock='4705' then '科室质控'
              when i.islock='4706' then '已提交'
                  when i.islock='4707' then '补写提交'
           else
            '未知'
         end) as gdzt,
         --xll 添加主治医生字段
      (select users.name from users where users.id=i.resident) as ZZYS,
      i.resident
             from inpatient i
             left join iem_mainpage_basicinfo_Sx ie on  ie.noofinpat=i.noofinpat and ie.valide=1
             left join iem_mainpage_diagnosis_Sx  ied on ied.iem_mainpage_no=ie.iem_mainpage_no and ied.valide=1 and ied.diagnosis_type_id in(7,8)
             left join iem_mainpage_operation_Sx  ieo on ieo.iem_mainpage_no=ie.iem_mainpage_no and ieo.valide=1
             left join department d on d.id=i.outhosdept
             where i.status in (1502,1503)
             --add by zjy 2013-6-16 修改
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
Select  e.id,i.noofinpat, i.name,i.patid,---------Add by xlb 2013-05-30 病历号应该同病案首页均取noofrecord
             u.name as applyname,e.applydate,to_char(e.applydate,'yyyy-MM-dd hh24:mi:ss') as sqsj,
             i.isbaby,i.mother,--add by 2013-7-4 zjy
             e.applycontent,e.applytimes,e.approvedocid,e.approvecontent,
             e.approvedate,to_char(e.approvedate,'yyyy-MM-dd hh24:mi:ss') as shsj,
             nvl2(trim(e.yanqiflag),'是','否') as yq, e.status,'' as statusdes,
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
Select  e.id,i.noofinpat, i.name,i.patid,---------Add by xlb 2013-05-30 病历号应该同病案首页均取noofrecord
             u.name as applyname,e.applydate,to_char(e.applydate,'yyyy-MM-dd hh24:mi:ss') as sqsj,
             i.isbaby,i.mother,--add by 2013-7-4 zjy
             e.applycontent,e.applytimes,e.approvedocid,e.approvecontent,
             e.approvedate,to_char(e.approvedate,'yyyy-MM-dd hh24:mi:ss') as shsj,
             nvl2(trim(e.yanqiflag),'是','否') as yq, e.status,'' as statusdes,
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
oper.iem_mainpage_no,  --病案主页号
oper.iem_mainpage_operation_no,  --手术主页号
oper.operation_code,  --手术信息编码
oper.operation_date,  --手术时间
oper.operation_name,  --手术名称
oper.execute_user1,  --手术一助
oper.execute_user2,  --手术二助
oper.execute_user3,  --手术三助
oper.anaesthesia_type_id,  --麻醉类型
oper.close_level,  --麻醉级别
oper.anaesthesia_user as anaesthesia_userid,  --麻醉医师
oper.valide as OPER_valide,  --手术是否有效
oper.create_user as OPER_create_user,  --手术信息创建人
oper.create_time as OPER_create_time,  --手术信息创建时间
oper.cancel_user as OPER_cancel_user,  --手术信息取消人
oper.cancel_time as OPER_cancel_time,  --手术信息取消时间
oper.operation_level as operation_levelid,  --手术等级    手术分为四级
oper.ischoosedate as ischoosedateid,  --是否择期手术
oper.isclearope as isclearopeid,  --是否无菌手术
oper.isganran as isganranid,  --是否感染
excuteuser1.name as excuteuser1,  --手术医师
excuteuser2.name as excuteuser2,  --一助
excuteuser3.name as excuteuser3,  --二助
ANAESTHESIA_TYPE.Name as ANAESTHESIA_TYPE,  --麻醉方式
ANAESTHESIA_USER.Name as ANAESTHESIA_USER,  --麻醉医师
CANCEL_USER.Name as CANCEL_USER,  --取消人
OPERATION_LEVEL.Name as OPERATION_LEVEL,  --手术等级
ischoosedate.name as ischoosedate,  --是否择期手术
isclearope.name as isclearope,  --是否无菌手术
isganran.name as isganran  --是否感染
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
             i.outhosdept,------Modify by xlb  取病人表中出院科室 2013-05-30
             d.name as cyks,
        --add by zjy 添加新的列islock
              (case
           when ((i.islock is null) or islock='4700')  then '未完成'
           when i.islock='4701'then '已归档'
           when i.islock='4702' then '撤销归档'
             when i.islock='4704'then '已完成'
           when i.islock='4705' then '科室质控'
              when i.islock='4706' then '已提交'
                  when i.islock='4707' then '补写提交'
           else
            '未知'
         end) as gdzt,
        ( case when(i.sexid=1) then '男'
              when (i.sexid=2) then '女'
                else '未知' end) as sexname,

         --xll 添加主治医生字段
      (select users.name from users where users.id=i.resident) as ZZYS,
      i.resident
             from inpatient i
             left join iem_mainpage_basicinfo_Sx ie on  ie.noofinpat=i.noofinpat and ie.valide=1
               left join iem_mainpage_operation_Sx  ieo on ieo.iem_mainpage_no=ie.iem_mainpage_no and ieo.valide=1
             left join department d on d.id=i.outhosdept

             --add by zjy 2013-6-16 修改
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
                                             'name="现病史" level="" print="True">',
                                             1,
                                             1) +
                              length('name="现病史" level="" print="True">')),
              1,
              Instr(dbms_lob.substr(t.content,
                                    900,
                                    dbms_lob.instr(t.content,
                                                   'name="现病史" level="" print="True">',
                                                   1,
                                                   1) +
                                    length('name="现病史" level="" print="True">')),
                    '</replace><eof /></p>') - 1) as current_illness, /*'name="现病史" level="" print="True">',1,1) + 33,1)*/ /*现病史*/
       substr(dbms_lob.substr(t.content,
                              900,
                              dbms_lob.instr(t.content,
                                             'name="主诉" level="" print="True">',
                                             1,
                                             1) +
                              length('name="主诉" level="" print="True">')),
              1,
              Instr(dbms_lob.substr(t.content,
                                    900,
                                    dbms_lob.instr(t.content,
                                                   'name="主诉" level="" print="True">',
                                                   1,
                                                   1) +
                                    length('name="主诉" level="" print="True">')),
                    '</replace>') - 1) as host_tell /*'name="现病史" level="" print="True">',1,1) + 33,1)*/ /*主诉*/,
       t.name
  from recorddetail t
 where t.valid = '1'
   and (t.name like '首次病程%')
   and t.firstdailyflag = '1'
   and t.sortid = 'AC'
   and t.captiondatetime = (select min(x.captiondatetime)
                              from recorddetail x
                             where x.noofinpat = t.noofinpat
                               and x.valid = '1'
                               and (x.name like '首次病程%')
                               and x.firstdailyflag = '1'
                               and x.sortid = 'AC');

prompt
prompt Creating view VIEW_TMP_QUERYINWARDPATIENTS_2
prompt ============================================
prompt
CREATE OR REPLACE FORCE VIEW EMR.VIEW_TMP_QUERYINWARDPATIENTS_2 AS
SELECT distinct b.noofinpat noofinpat, --首页序号
             b.patnoofhis patnoofhis, --HIS首页序号
             b.patid patid, --住院号
             b.name patname, --姓名
             b.sexid sex, --病人性别
             j.name sexname, --病人性别名称
             b.agestr agestr, --年龄
             b.py py, --拼音
             b.wb wb, --五笔
             b.status brzt, --病人状态
             e.name brztname, --病人状态名称
             RTRIM(b.criticallevel) wzjb, --危重级别
             i.name wzjbmc, --危重级别名称
             case b.attendlevel
               when '1' then
                '一级护理'
               when '2' then
                '二级护理'
               when '3' then
                '三级护理'
               when '4' then
                '特级护理'
               else
                '一级护理'
             end hljb, --护理级别

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
             end attendlevel, --护理级别
             b.isbaby yebz, --婴儿标志
             CASE
               WHEN b.isbaby = '0' THEN
                '否'
               WHEN b.isbaby IS NULL THEN
                ''
               ELSE
                '是'
             END yebzname,
             b.outhosward bqdm, --病区代码
             b.outhosdept ksdm, --科室代码
             case when length(b.outbed) = 1 then '0' || b.outbed else b.outbed end bedid, --床位代码
             dg.NAME ksmc, --科室名称
             wh.NAME bqmc, --病区名称
            -- a.formerward ybqdm, --原病区代码
            -- a.formerdeptid yksdm, --原科室代码
            -- a.formerdeptid ycwdm, --原床位代码
            -- --a.inbed inbed, --占床标志
            -- a.deptid beddeptid,
           --  a.wardid bedwardid,
             '' inbed,--占床标志 add by ywk  2012年11月5日15:02:39
             --a.borrow jcbz, --借床标志
            -- a.sexinfo cwlx, --床位类型
             SUBSTR(b.admitdate, 1, 16) admitdate, --入院日期
             f.NAME ryzd, --入院诊断
             f.NAME zdmc, --诊断名称
             b.resident zyysdm, --住院医生代码
             c.NAME zyys, --住院医生
             c.NAME cwys, --床位医生
             g.NAME zzys, --主治医师
             h.NAME zrys, --主任医师
            -- a.valid yxjl, --有效记录
             --me.pzlx pzlx, --凭证类型
             dd1.NAME pzlx, --费用类别
             b.memo memo, --备注
             CASE b.cpstatus
               WHEN 0 THEN
                '未引入'
               WHEN 1 THEN
                '执行中'
               WHEN 2 THEN
                '退出'
             END cpstatus,
             decode( (SELECT count(*)
                         FROM recorddetail tmp
                         WHERE b.noofinpat = tmp.noofinpat
                         and tmp.valid = '1'),0,'无病历','已书写' )
            recordinfo,
            decode( (SELECT count(*)
                         FROM recorddetail tmp
                         WHERE b.noofinpat = tmp.noofinpat
                         and tmp.valid = '1'),0,'无病历','已书写' )
            extra,
             100 ye, --余额
             (SELECT CASE
                       WHEN COUNT(qc.foulstate) > 0 THEN
                        '是'
                       ELSE
                        '否'
                     END
                FROM qcrecord qc
               WHERE qc.noofinpat = b.noofinpat
                 AND qc.valid = 1
                 AND qc.foulstate = 1) AS iswarn, --是否违规
                 b.outhosdept,
                 b.outhosward,
             b.incount as rycs --入院次数
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
trim(b.bed_label)       /*床位代码*/,
b.dept_code /*科室代码*/,
b.ward_code /*病区代码*/,
nvl( b.room_no,1) room_no /*房间号*/,
'' resident /*住院医师代码*/,
'' attend   /*主治医师代码*/,
'' chief    /*主任医师代码*/,
case b.bed_sex_type         when '1' then '1100' /*男*/
                            when '2' then '1101' /*女*/
                            when '9' then '1102' /*混*/
end sexinfo,
case b.bed_approved_type      when '0' /*编制内*/   then '1200' /*在编*/
                              when '1' /*编制外*/   then '1201' /*非编*/
                              when '2' /*加床*/     then '1202' /*加床*/
                              when '3' /*童床*/     then '1203' /*童床*/
end style,
case b.bed_status             when '0' then '1300' --空床
                              when '1' then '1301' --占床
                              --when '9' then '1302' 未展开
                              else '1302'
end inbed,
c.inp_no||'_'||a.visit_id patnoofhis /*HIS 首页序号*/,
1  valid     /*有效记录*/
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
)
;

prompt
prompt Creating view ZC_DEPT2WARD
prompt ==========================
prompt
CREATE OR REPLACE FORCE VIEW EMR.ZC_DEPT2WARD AS
(
SELECT distinct
dept_vs_ward.ward_code deptid /*科室代码*/,
dept_vs_ward.dept_code wardid /*病区代码*/,
0 totalbed /*床位数*/
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
orders.VISIT_ID            inpatient_no    ,--住院流水号
pat_master_index.inp_no    patient_no      ,--住院病历号
orders.ORDERING_DEPT       deptid    ,--医嘱科室代码
''                         wardid,--医嘱护理站代码
orders.ORDER_NO            MO_ORDER,--医嘱流水号
orders.DOCTOR_USER         doc_code,--医嘱医师代号
orders.DOCTOR              DOC_NAME,--医嘱医师姓名
orders.ENTER_DATE_TIME     MO_DATE ,--医嘱日期
CASE  pat_visit.newborn    WHEN '1' THEN '1'
                           ELSE '2'
                           END  BABY_FLAG,--是否婴儿医嘱   1是/2否
orders.order_class         TYPE_NAME           ,--医嘱类别名称
CASE orders.BILLING_ATTR   WHEN 0 THEN '是'
                           WHEN 2 THEN '是'
                           ELSE '否'
                           END  CHARGE_STATE,--是否计费   1是/2否
orders_costs.ITEM_CODE     ITEM_CODE           ,--项目编码
orders_costs.ITEM_NAME     ITEM_NAME           ,--项目名称
orders_costs.ITEM_CLASS    CLASS_NAME          ,--项目类别名称
''                         EXEC_DPNM           ,--执行科室名称
''                         MIN_UNIT            ,--最小单位
orders_costs.UNITS         PRICE_UNIT          ,--计价单位
orders_costs.AMOUNT        PACK_QTY            ,--包装数量
orders_costs.ITEM_SPEC     SPECS               ,--规格
''                         DOSE_MODEL_CODE     ,--剂型代码
''                         DRUG_TYPE           ,--药品类别
''                         ITEM_PRICE          ,--零售价
''                         COMB_NO             ,--组合序号
''                         MAIN_DRUG           ,--主药标记
orders.ORDER_STATUS        MO_STAT             ,--医嘱状态
orders.ADMINISTRATION      USE_NAME            ,--用法名称
orders.FREQUENCY           DFQ_CEXP            ,--频次名称
orders.DOSAGE              DOSE_ONCE           ,--每次剂量
orders.DOSAGE_UNITS        DOSE_UNIT           ,--剂量单位
''                         USE_DAYS            ,--使用天数
orders_costs.TOTAL_AMOUNT  QTY_TOT             ,--项目总量
orders.START_DATE_TIME     DATE_BGN            ,--开始时间
orders.STOP_DATE_TIME      DATE_END            ,--结束时间
''                         REC_USERCD          ,--录入人员代码 前面有开医嘱医生名称
''                         REC_USERNM          ,--录入人员姓名
CASE orders.processing_nurse         WHEN '' THEN '未确认'
                                      ELSE '已确认'
                                      END  CONFIRM_FLAG        ,--确认标记1未确认/2已
orders.processing_date_time      CONFIRM_DATE        ,--确认时间 转抄
''                                CONFIRM_USERCD      ,--确认人员代码 转抄
''DC_FLAG             ,--Dc标记1未dc/2已dc
''DC_DATE             ,--Dc时间
''DC_CODE             ,--DC原因代码
''DC_NAME             ,--DC原因名称
''DC_DOCCD            ,--DC医师代码
''DC_DOCNM            ,--DC医师姓名
''DC_USERCD           ,--Dc人员代码
''DC_USERNM           ,--Dc人员名称
CASE orders.processing_nurse          WHEN '' THEN '未确认'
                                      ELSE '已确认'
                                      END  EXECUTE_FLAG        ,--执行标记1未执行/2已执行/3DC执行
orders.PERFORM_SCHEDULE           EXECUTE_DATE        ,--执行时间
''                                EXECUTE_USERCD      ,--执行人员代码
orders.FREQ_DETAIL                MO_NOTE1            ,--医嘱说明
''MO_NOTE2            ,--备注
orders.REPEAT_INDICATOR           MOGP_CODE           ,--长嘱组别代码
CASE orders.REPEAT_INDICATOR          WHEN  1 THEN '长期'
                                      ELSE '临时'
                                      END   MOGP_NAME  ,--长嘱组别名称
''GET_FLAG            ,--医嘱提取标记:1待提取/2已提取/3DC提取
''SUBTBL_FLAG        ,--是否附材'1'是
''SORT_ID             ,--排列序号，按排列序号由大到小顺序显示医嘱
''DC_CONFIRM_DATE     ,--DC审核时间
''DC_CONFIRM_OPER     ,--DC审核人
''DC_CONFIRM_FLAG     ,--DC审核标记，0未审核，1已审核
''VALID_USRN        ,
''PSJG                ,--皮试结果 1为阴性0为阳性
''PSBJ                 --皮试标记 1为需要0为不需要

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

prompt
prompt Creating view ZC_USER2DEPT
prompt ==========================
prompt
CREATE OR REPLACE FORCE VIEW EMR.ZC_USER2DEPT AS
(
SELECT
to_char(nvl(staff_dict.id,00),'000000') userid  /*职工代码*/,
staff_dict.dept_code /*科室代码*/,
'51201' /*病区代码*/
FROM staff_dict,zc_users
where staff_dict.name <> '管理员' and
zc_users.id = to_char(nvl(staff_dict.id,00),'000000')

);

prompt
prompt Creating view ZC_WARDS
prompt ======================
prompt
create or replace force view emr.zc_wards as
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


spool off

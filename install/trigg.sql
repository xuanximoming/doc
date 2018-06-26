-----------------------------------------------------
-- Export file for user EMR@ORCL                   --
-- Created by Administrator on 2018/5/27, 13:48:14 --
-----------------------------------------------------

set define off
spool trigg.log

prompt
prompt Creating trigger IEM2012INCOUNT
prompt ===============================
prompt
CREATE OR REPLACE TRIGGER EMR."IEM2012INCOUNT"
  before insert or update on iem_mainpage_basicinfo_2012
  for each row
declare
  -- local variables here
begin
  update inpatient i set i.incount=:new.incount where i.noofinpat=:new.noofinpat;
end iem2012Incount;
/

prompt
prompt Creating trigger IEMBASESXINCOUNT
prompt =================================
prompt
CREATE OR REPLACE TRIGGER EMR."IEMBASESXINCOUNT"
  before insert or update on iem_mainpage_basicinfo_SX
  for each row
declare
  -- local variables here
begin
  update inpatient i set i.incount=:new.incount where i.noofinpat=:new.noofinpat;
end iembaseSXIncount;
/

prompt
prompt Creating trigger IEMMAINPAGE_DEATH
prompt ==================================
prompt
CREATE OR REPLACE TRIGGER EMR."IEMMAINPAGE_DEATH"
  before update on iem_mainpage_basicinfo_2012
  for each row
declare
  -- local variables here
begin
  if :NEW.outhostype = '5' then
    begin
      update inpatient
      set deathdatetime = to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
      where noofinpat = :NEW.noofinpat;
    end;
  else
    begin
      update inpatient
      set deathdatetime = null
      where noofinpat = :NEW.noofinpat;
    end;
  end if;
end IEMMAINPAGE_DEATH;
/

prompt
prompt Creating trigger INPATIENTTRIGGERS
prompt ==================================
prompt
CREATE OR REPLACE TRIGGER EMR."INPATIENTTRIGGERS"
  before insert on INPATIENT
  for each row
begin
  select seq_InPatient_ID.nextval into :new.NoOfInpat from dual;
end;
/

prompt
prompt Creating trigger INPATIENTTRIGGERS_UPDATEAGE
prompt ============================================
prompt
CREATE OR REPLACE TRIGGER EMR."INPATIENTTRIGGERS_UPDATEAGE"
  before update of Birth,AdmitDate on INPATIENT
  for each row
-- 重新计算病人年龄
declare
  v_syxh int;
  v_csrq varchar(19);
  v_ryrq varchar(19);
  v_brnl int;
  v_xsnl varchar(19);
  PRAGMA AUTONOMOUS_TRANSACTION;--自治事务
begin

return;
  select m.noofinpat, m.birth, m.admitdate
    into v_syxh, v_csrq, v_ryrq
    from inpatient m
   where m.noofinpat = :new.noofinpat
     and rownum = 1;
 
  EMRPROC.usp_Emr_CalcAge(v_csrq, v_ryrq, v_brnl, v_xsnl);
  
  update InPatient
     set Age = v_brnl, AgeStr = v_xsnl
   where NoOfInpat = v_syxh;
   commit;
end;
/

prompt
prompt Creating trigger INPATIENTTRIGGER_UPDATESTATE
prompt =============================================
prompt
CREATE OR REPLACE TRIGGER EMR."INPATIENTTRIGGER_UPDATESTATE"
  before update of STATUS  on inpatient
  for each row
declare
begin
  if(:old.emrouthos='1') then
  begin
  :new.status:=:old.status;
 :new.outhosdept:=:old.outhosdept;
 :new.outhosward:=:old.outhosward;
 :new.outwarddate:=:old.outwarddate;
 :new.outhosdate:=:old.outhosdate;
end;
end if;
end InpatientTrigger_updateState;
/

prompt
prompt Creating trigger INPATIENT_CHANGEDEPTTIME
prompt =========================================
prompt
CREATE OR REPLACE TRIGGER EMR."INPATIENT_CHANGEDEPTTIME"
  before update on inpatient
  for each row
declare
begin
  /*
  if :NEW.Status = '1507' then
    begin
      select to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') into :NEW.ChangeDeptDateTime from dual;
    end;
  end if;
  */
  if (:NEW.outhosdept <> :OLD.outhosdept AND :NEW.outhosdept is not null AND :OLD.outhosdept is not null) then
    begin
      select to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') into :NEW.ChangeDeptDateTime from dual;
    end;
  end if;
end INPATIENT_CHANGEDEPTTIME;
/

prompt
prompt Creating trigger INPATIENT_CHANGEINFO1
prompt ======================================
prompt
CREATE OR REPLACE TRIGGER EMR."INPATIENT_CHANGEINFO1"
  after insert on inpatient
  for each row
declare
begin
  if :NEW.admitdept is not null AND :NEW.admitward is not null then
  insert into inpatientchangeinfo(id, noofinpat, newdeptid, newwardid, newbedid, changestyle, createuser, createtime, valid)
  values(seq_inpatientchangeinfo_id.nextval, :NEW.noofinpat, :NEW.admitdept, :NEW.admitward, :NEW.admitbed, '0', '00',
         to_char(sysdate, 'yyyy-MM-dd HH24:mi:ss'), '1');
  end if;
end INPATIENT_CHANGEINFO1;
/

prompt
prompt Creating trigger INPATIENT_CHANGEINFO2
prompt ======================================
prompt
CREATE OR REPLACE TRIGGER EMR."INPATIENT_CHANGEINFO2"
  after update on inpatient
  for each row
declare
begin
  if :NEW.outhosdept is not null and :NEW.outhosward is not null and :NEW.outhosdept <> :OLD.outhosdept then --转科
     insert into inpatientchangeinfo(id, noofinpat, newdeptid, newwardid, newbedid, olddeptid, oldwardid, oldbedid,
            changestyle, createuser, createtime, valid)
     values(seq_inpatientchangeinfo_id.nextval, :NEW.noofinpat, :NEW.outhosdept, :NEW.outhosward, :NEW.outbed, :OLD.outhosdept, :OLD.outhosward, :OLD.outbed,
            '1', '00', to_char(sysdate, 'yyyy-MM-dd HH24:mi:ss'), '1');
  elsif :NEW.outhosdept is not null and :NEW.outhosward is not null and :NEW.outhosward <> :OLD.outhosward then --转病区
     insert into inpatientchangeinfo(id, noofinpat, newdeptid, newwardid, newbedid, olddeptid, oldwardid, oldbedid,
            changestyle, createuser, createtime, valid)
     values(seq_inpatientchangeinfo_id.nextval, :NEW.noofinpat, :NEW.outhosdept, :NEW.outhosward, :NEW.outbed, :OLD.outhosdept, :OLD.outhosward, :OLD.outbed,
            '2', '00', to_char(sysdate, 'yyyy-MM-dd HH24:mi:ss'), '1');
  elsif :NEW.outhosdept is not null and :NEW.outhosward is not null and :NEW.outbed <> :OLD.outbed then --转床
     insert into inpatientchangeinfo(id, noofinpat, newdeptid, newwardid, newbedid, olddeptid, oldwardid, oldbedid,
            changestyle, createuser, createtime, valid)
     values(seq_inpatientchangeinfo_id.nextval, :NEW.noofinpat, :NEW.outhosdept, :NEW.outhosward, :NEW.outbed, :OLD.outhosdept, :OLD.outhosward, :OLD.outbed,
            '3', '00', to_char(sysdate, 'yyyy-MM-dd HH24:mi:ss'), '1');
  end if;
end INPATIENT_CHANGEINFO2;
/

prompt
prompt Creating trigger PLSQL_PROFILER_RUN_OWNER_TRG
prompt =============================================
prompt
CREATE OR REPLACE TRIGGER EMR."PLSQL_PROFILER_RUN_OWNER_TRG" BEFORE INSERT OR UPDATE OF run_owner ON plsql_profiler_runs FOR EACH ROW        WHEN (new.run_owner IS NULL) BEGIN :new.run_owner := user; END;
/

prompt
prompt Creating trigger RECORDDETAIL_DELETE
prompt ====================================
prompt
CREATE OR REPLACE TRIGGER EMR."RECORDDETAIL_DELETE"
  before delete on recorddetail
  for each row

begin
--先删除原纪录中为空的数据 add by ywk
--delete from OperationRECORDDETAIL where content is null or dbms_lob.getlength(content) = 0;
if :old.CONTENT is not null and dbms_lob.getlength(:old.CONTENT)<>0 then
insert into OperationRECORDDETAIL(ID,NOOFINPAT,TEMPLATEID,NAME,CONTENT,SORTID,OWNER,AUDITOR
,CREATETIME,AUDITTIME,VALID,HASSUBMIT,HASPRINT,CAPTIONDATETIME,ISLOCK,FIRSTDAILYFLAG,ISYIHUANGOUTONG
,IP,DEPARTCODE,WARDCODE,OPERTYPE,OPTIME)
 values (seq_OperationRECORDDETAIL_ID.Nextval,:OLD.NOOFINPAT,:OLD.TEMPLATEID,:OLD.NAME,
:OLD.CONTENT,:OLD.SORTID,:OLD.OWNER,:OLD.AUDITOR,:OLD.CREATETIME,:OLD.AUDITTIME,:OLD.VALID,:OLD.HASSUBMIT,
:OLD.HASPRINT,:OLD.CAPTIONDATETIME,:OLD.ISLOCK,:OLD.FIRSTDAILYFLAG,:OLD.ISYIHUANGOUTONG
,:OLD.IP,:OLD.DEPARTCODE,:OLD.WARDCODE,'DELETE',sysdate);
end if;
end RECORDDETAIL_DELETE;
/

prompt
prompt Creating trigger RECORDDETAIL_INSERT
prompt ====================================
prompt
CREATE OR REPLACE TRIGGER EMR."RECORDDETAIL_INSERT"
  after insert on recorddetail
  for each row

begin
--先删除原纪录中为空的数据 add by ywk
--delete from OperationRECORDDETAIL where content is null or dbms_lob.getlength(content) = 0;
if :NEW.CONTENT is not null and dbms_lob.getlength(:NEW.CONTENT)<>0 then
insert into OperationRECORDDETAIL(ID,NOOFINPAT,TEMPLATEID,NAME,CONTENT,SORTID,OWNER,AUDITOR
,CREATETIME,AUDITTIME,VALID,HASSUBMIT,HASPRINT,CAPTIONDATETIME,ISLOCK,FIRSTDAILYFLAG,ISYIHUANGOUTONG
,IP,DEPARTCODE,WARDCODE,OPERTYPE,OPTIME)
 values (seq_OperationRECORDDETAIL_ID.Nextval,:NEW.NOOFINPAT,:NEW.TEMPLATEID,:NEW.NAME,
:NEW.CONTENT,:NEW.SORTID,:NEW.OWNER,:NEW.AUDITOR,:NEW.CREATETIME,:NEW.AUDITTIME,:NEW.VALID,:NEW.HASSUBMIT,
:NEW.HASPRINT,:NEW.CAPTIONDATETIME,:NEW.ISLOCK,:NEW.FIRSTDAILYFLAG,:NEW.ISYIHUANGOUTONG
,:NEW.IP,:NEW.DEPARTCODE,:NEW.WARDCODE,'INSERT',sysdate);
end if;
end Recorddetail_Insert;
/

prompt
prompt Creating trigger RECORDDETAIL_UPDATE
prompt ====================================
prompt
CREATE OR REPLACE TRIGGER EMR."RECORDDETAIL_UPDATE"
  after update on recorddetail
  for each row
declare

  /*PRAGMA AUTONOMOUS_TRANSACTION;--自治事务*/
begin
--先删除原纪录中为空的数据 add by ywk
--delete from OperationRECORDDETAIL where content is null or dbms_lob.getlength(content) = 0;
if :old.CONTENT is not null and dbms_lob.getlength(:old.CONTENT)<>0 then
insert into OperationRECORDDETAIL(ID,NOOFINPAT,TEMPLATEID,NAME,CONTENT,SORTID,OWNER,AUDITOR
,CREATETIME,AUDITTIME,VALID,HASSUBMIT,HASPRINT,CAPTIONDATETIME,ISLOCK,FIRSTDAILYFLAG,ISYIHUANGOUTONG
,IP,DEPARTCODE,WARDCODE,OPERTYPE,OPTIME)
 values (seq_OperationRECORDDETAIL_ID.Nextval,:OLD.NOOFINPAT,:OLD.TEMPLATEID,:OLD.NAME,
:OLD.CONTENT,:OLD.SORTID,:OLD.OWNER,:OLD.AUDITOR,:OLD.CREATETIME,:OLD.AUDITTIME,:OLD.VALID,:OLD.HASSUBMIT,
:OLD.HASPRINT,:OLD.CAPTIONDATETIME,:OLD.ISLOCK,:OLD.FIRSTDAILYFLAG,:OLD.ISYIHUANGOUTONG
,:OLD.IP,:OLD.DEPARTCODE,:OLD.WARDCODE,'UPDATE',sysdate);
end if;
end Recorddetail_Update;
/

prompt
prompt Creating trigger TRG_CATEGORY
prompt =============================
prompt
CREATE OR REPLACE TRIGGER EMR."TRG_CATEGORY" before insert on qll for each row
begin
select qll_id_seq.nextval into :new.id from dual;
end;
/

prompt
prompt Creating trigger TRG_INSERT_MRMSBASE_TJ
prompt =======================================
prompt
CREATE OR REPLACE TRIGGER EMR."TRG_INSERT_MRMSBASE_TJ"
  before update on iem_mainpage_basicinfo_2012
  for each row
declare
  -- local variables here
begin
  --当病案首页检验审核完毕后，将检验后的信息插入到相应的HIS表中
  If :new.patflag = '1' /*and (:old.patflag is null or :old.patflag = '0')*/ Then
    delete from mrmsbase_tj t where t.inpatient_no = :new.patnoofhis;
    delete from ii_diagnose_tj where inpatient_no = :new.patnoofhis;
    delete from mrmschild where inpatient_no = :new.patnoofhis;
    delete from mrmsopdt_tj where inpatient_no = :new.patnoofhis;
    delete from mrmswombirth where inpatient_no = :new.patnoofhis;
    --病案首页
    INSERT INTO mrmsbase_tj
      (inpatient_no, --住院流水号
       patient_no, --住院号
       card_no, --就诊卡号
       name, --患者姓名
       sex, --患者性别
       birthday, --出生日期
       coun_code, --国籍
       nation_code, --民族
       prof_code, --职业
       blood_code, --血型
       mari, --婚姻
       in_source, --来源
       home_add, --家庭住址
       home_tel, --家庭电话
       home_zip, --家庭邮编
       work_name, --工作单位
       work_tel, --工作电话
       work_zip, --工作邮编
       linkma_name, --联系人
       rela_code, --联系人与患者关系
       linkman_tel, --联系人电话
       linkman_add, --联系人地址
       clinic_icd,
       clinic_icdnm,
       in_date, --入院日期
       dept_in, --入院科室
       dept_innm, --入院科室名称
       in_avenue, --入院途径
       oper_date, --操作时间
       out_date, --出院日期
       icd_code, --出院住诊断
       dept_code, --出院科室
       dept_name, --出院科室代码
       zg, --转归情况
       ce_pi, --门诊与住院诊断符合情况
       pi_po, --入院与出院诊断符合情况
       opb_opa, --术前与术后诊断符合情况
       cl_pa, --临床与病理诊断符合情况
       house_doc_code, --住院医生代码
       house_doc_name, --住院医生名称
       charge_doc_code, --主治医生代码
       charge_doc_name, --主治医生名称
       chief_doc_code, --主任医生代码
       chief_doc_name, --主任医生名称
       type_167, --诊断分类
       pi_days, --住院天数
       out_date2, --出院日期
       paykind_code, --医疗付款方式
       mrms_no, --病案号
       fs_bl, --放射与病理诊断符合情况
       codeing_code, --填报人
       idcardno, --身份证号
       homeplace, --出生地
       last_operator, --最后一次修改人
       changedeptcode, --转科1
       changedeptcode2, --转科2
       age, --年龄
       unit_age, --年龄单位
       mrm_valid, --病例是否有效
       static_save, --审核状态
       rysr, --入院三日内诊断符合情况
       bed_no, --床位号
       check_dtime, --审核日期
       check_oper, --审核人
       out_zy, --出院后转院
       in_circs) --入院病情
      select b.patnoofhis as inpatient_no, /*住院流水号*/
             b.noofrecord as patient_no, /*住院号*/
             b.noofclinic as card_no, /*就诊卡*/
             b.name as name, /*患者姓名*/
             b.sexid as sex, /*患者性别*/
             to_date(b.birth, 'yyyy-mm-dd') as birthday, /*出生日期*/
             b.nationalityid as coun_code, /*国籍*/
             b.nationid as nation_code, /*民族*/
             b.jobid as prof_code, /*职业*/
             :new.bloodtype as blood_code, /*血型*/
             decode(b.marital,
                    '0',
                    '1',
                    '1',
                    '2',
                    '2',
                    '3',
                    '3',
                    '4',
                    '5',
                    '2',
                    '9') as mari, /*婚姻*/
             decode(b.origin, '1', '2', '2', '1', '3', '3', '1') as in_source, /*来源*/
             /* b.xzzproviceid || b.xzzcityid || b.xzzdistrictid */
             b.xzzaddress as home_add, /*家庭住址*/
             b.xzztel as home_tel, /*家庭电话*/
             b.xzzpost as home_zip, /*家庭邮编*/
             b.officeplace as work_name, /*工作单位*/
             b.officetel as work_tel, /*工作电话*/
             b.officepost as work_zip, /*工作邮编*/
             b.contactperson as linkma_name, /*联系人*/
             b.relationship as rela_code, /*联系人与患者关系*/
             b.contacttel as linkman_tel, /*联系人电话*/
             b.contactaddress as linkman_add, /*联系人地址*/
             (select a.diagnosis_code
                from iem_mainpage_diagnosis_2012 a
               where a.iem_mainpage_no = :new.iem_mainpage_no
                 and a.valide = '1'
                 and a.diagnosis_type_id = '13'
                 and rownum = 1) as clinic_icd,
             (select a.diagnosis_name
                from iem_mainpage_diagnosis_2012 a
               where a.iem_mainpage_no = :new.iem_mainpage_no
                 and a.valide = '1'
                 and a.diagnosis_type_id = '13'
                 and rownum = 1) as clinic_icdnm,
             to_date(b.admitdate, 'yyyy-mm-dd hh24:mi:ss') as in_date, /*入院日期*/
             b.admitdept as dept_in, /*入院科室*/
             (select name from department s where s.id = b.admitdept) as dept_innm, /*入院科室名称*/
             b.admitway as in_avenue, /*入院途径*/
             to_date(:new.create_time,'yyyy-mm-dd hh24:mi:ss') as oper_date, /*操作时间*/
             to_date(b.outhosdate, 'yyyy-mm-dd hh24:mi:ss') as out_date, /*出院日期*/
             (select a.diagnosis_code
                from iem_mainpage_diagnosis_2012 a
               where a.iem_mainpage_no = :new.iem_mainpage_no
                 and a.valide = '1'
                 and a.diagnosis_type_id = '7'
                 and rownum = 1) as icd_code, /*出院主诊断*/
             b.outhosdept as dept_code, /*出院科室代码*/
             (select name from department s where s.id = b.outhosdept) as dept_innm, /*出院科室名称*/
             '0'||decode(:new.zg_flag,'9','05',:new.zg_flag), /*转归码*/
             decode(:new.menandinhop,'4','0',:new.menandinhop) as ce_pi, /*门诊与住院诊断符合情况*/
             decode(:new.inhopandouthop,'4','0',:new.inhopandouthop) as pi_po, /*入院与出院诊断符合情况*/
             decode(:new.beforeopeandafteroper,'4','0',:new.beforeopeandafteroper) as opb_opa, /*术前与术后诊断符合情况*/
             decode(:new.linandbingli,'4','0',:new.linandbingli) as cl_pa, /*临床与病理诊断符合情况*/
             b.resident as house_doc_code, /*住院医生代码*/
             (select name from users where id = b.resident) as house_doc_name, /*住院医生名称*/
             b.attend as charge_doc_code, /*主治医生代码*/
             (select name from users where id = b.attend) as charge_doc_name, /*主治医生名称*/
             b.chief as chief_doc_code, /*主任医生代码*/
             (select name from users where id = b.chief) as chief_doc_name, /*主任医生名称*/
             '' as type_167, /*诊断分类*/
             b.totaldays as pi_days, /*住院天数*/
             to_date(b.outhosdate, 'yyyy-mm-dd hh24:mi:ss') as out_date2, /*出院日期*/
             :new.payid, /*医疗付款方式--在emr_his用户中体现*/
             substr(:new.patnoofhis, 5, 10) as mrms_no, /*病案号*/
             decode(:new.fangandbingli,'4','0',:new.fangandbingli) as fs_bl, /*放射与病理诊断符合情况*/
             :new.create_user as codeing_code, /*填报人*/
             b.idno as idcardno, /*身份证号*/
             b.provinceid || b.countyid || b.districtid as homeplace, /*出生地*/
             :new.modified_user as last_operator, /*最后一次修改人*/
             :new.trans_admitdept as changedeptcode, /*转科1*/
             '' as changedeptcode2, /*转科2*/
             case
               when Months_between(to_date(b.admitdate,
                                           'yyyy-mm-dd hh24:mi:ss'),
                                   to_date(b.birth, 'yyyy-mm-dd hh24:mi:ss')) >= 12 then
                floor(Months_between(to_date(b.admitdate,
                                             'yyyy-mm-dd hh24:mi:ss'),
                                     to_date(b.birth, 'yyyy-mm-dd hh24:mi:ss')) / 12)
               when Months_between(to_date(b.admitdate,
                                           'yyyy-mm-dd hh24:mi:ss'),
                                   to_date(b.birth, 'yyyy-mm-dd hh24:mi:ss')) >= 1 then
                floor(Months_between(to_date(b.admitdate,
                                             'yyyy-mm-dd hh24:mi:ss'),
                                     to_date(b.birth, 'yyyy-mm-dd hh24:mi:ss')))
               else
                ceil(to_date(b.admitdate, 'yyyy-mm-dd hh24:mi:ss') -
                     to_date(b.birth, 'yyyy-mm-dd hh24:mi:ss'))
             end as age, /*年龄？*/
             case
               when Months_between(to_date(b.admitdate,
                                           'yyyy-mm-dd hh24:mi:ss'),
                                   to_date(b.birth, 'yyyy-mm-dd hh24:mi:ss')) >= 12 then
                'y'
               when Months_between(to_date(b.admitdate,
                                           'yyyy-mm-dd hh24:mi:ss'),
                                   to_date(b.birth, 'yyyy-mm-dd hh24:mi:ss')) >= 1 then
                'm'
               else
                'd'
             end as unit_age, /*年龄单位？*/
             '1' as mrm_valid, /*病例是否有效*/
             '0' as static_save, /*审核状态*/
             decode(:new.inhopthree,'4','0',:new.inhopthree) as rysr, /*入院三日内诊断符合情况*/
             b.admitbed as bed_no /*床位号*/,
             '' as check_dtime, /*审核日期*/
             '' as check_oper, /*审核人*/
             decode(:new.outhostype,'2','2','3','3','0') as out_zy,
             (select a.admitinfo
                from IEM_MAINPAGE_DIAGNOSIS_2012 a
               where a.iem_mainpage_no = :new.iem_mainpage_no
                 and a.valide = '1'
                 and a.diagnosis_type_id = '7'
                 and rownum = 1) as in_circs /*入院病情*/
        from inpatient b
       where b.noofinpat = :new.noofinpat;
    --手术信息
    INSERT INTO mrmsopdt_tj
      (inpatient_no, --住院流水号
       patient_no, --住院号
       card_no, --就诊卡号
       date_oper, --手术时间
       oper_code, --手术编码
       oper_cnname, --手术名称
       narc_kind, --麻醉方式
       nick_kind, --切口方式
       cica_kind, --愈合等级
       doc_code, --手术医生代码
       doc_name, --手术医生姓名
       in_date, --入院日期
       out_date, --出院日期
       oper_dept, --手术科室
       out_dept, --出院科室
       out_icd, --出院诊断
       doc_narc, --麻醉医生
       fungus, --是否有菌
       sfgr, --是否感染
       oper_zq) --是否择期手术
      select b.patnoofhis as inpatient_no, /*住院流水号*/
             b.noofrecord as patient_no, /*住院号*/
             b.noofclinic as card_no, /*就诊卡*/
             to_date(a.operation_date, 'yyyy-mm-dd hh24:mi:ss') as date_oper, /*手术时间*/
             a.operation_code as oper_code, /*手术编码*/
             a.operation_name as oper_cnname, /*手术名称*/
             decode(a.anaesthesia_type_id,'9','03','8','03','7','04','6','01','5','05','4','06','3','01','17','02','16','01','15','01','14','04','13','01','12','02','11','02','10','09','08') as narc_kind, /*麻醉方式*/
             decode(a.close_level,'1','01','2','02','3','03','4','01','5','02','6','03','7','01','8','02','9','03') as nick_kind, /*切口方式--HIS对应关系01一类02二类03三类*/
             decode(a.close_level,'1','01','2','01','3','01','4','02','5','02','6','02','7','03','8','03','9','03') as cica_kind, /*愈合等级--HIS对应关系01甲02乙03丙*/
             a.EXECUTE_USER1 as doc_code, /*手术医生代码*/
             (select name from users where id = a.create_user) as doc_name, /*手术医生姓名*/
             to_date(b.admitdate, 'yyyy-mm-dd hh24:mi:ss') as in_date, /*入院日期*/
             to_date(b.outhosdate, 'yyyy-mm-dd hh24:mi:ss') as out_date, /*出院日期*/
             '' as oper_dept, /*手术科室*/
             b.outhosdept as dept_code, /*出院科室代码*/
             (select a.diagnosis_code
                from iem_mainpage_diagnosis_2012 a
               where a.iem_mainpage_no = :new.iem_mainpage_no
                 and a.valide = '1'
                 and a.diagnosis_type_id = '7'
                 and rownum = 1) as out_icd, /*出院诊断*/
             a.anaesthesia_user as doc_narc, /*麻醉医生*/
             decode(a.isclearope,'1','1','2','0') as fungus, /*是否有菌*/
             decode(a.isganran,'1','1','2','0') as sfgr, /*是否感染*/
             decode(a.ischoosedate,'1','1','2','0') as oper_zq /*是否择期手术*/
        from iem_mainpage_operation_2012 a, inpatient b
       where a.iem_mainpage_no = :new.iem_mainpage_no
         and a.valide = '1'
         and b.noofinpat = :new.noofinpat;
    --诊断信息 1-出院诊断
    INSERT INTO ii_diagnose_tj
      (card_no, --就诊卡号
       inpatient_no, --住院流水号
       happen_no, --诊断序号
       diag_kind, --诊断类型3出院诊断o术前诊断p术后诊断……
       icd_code, --icd码
       diag_name, --诊断名称
       diag_date, --诊断日期
       doct_code, --诊断医生代码
       diag_doc_name, --诊断医生名称
       diag_state, --是否有效
       dept_code, --出院科室
       in_date, --入院日期
       out_date, --出院日期
       diag_outstate, --转归码
       diag_main, --是否主诊断
       oper_code, --操作员
       oper_time) --操作日期
      select b.noofclinic as card_no, /*就诊卡*/
             b.patnoofhis as inpatient_no, /*住院流水号*/
             rownum as happen_no,
             decode(a.diagnosis_type_id,'7','3','3') as diag_kind, /*诊断类型?*/
             a.diagnosis_code as icd_code, /*诊断代码*/
             a.diagnosis_name as diag_name, /*诊断名称*/
             to_date(a.create_time, 'yyyy-mm-dd hh24:mi:ss') as diag_date /*诊断日期*/,
             a.create_user as doct_code, /*诊断医生代码*/
             (select x.name from users x where x.id = a.create_user) as diag_doc_name, /*诊断医生名称*/
             a.valide as diag_state, /*是否有效*/
             b.outhosdept as dept_code, /*出院科室*/
             to_date(b.admitdate, 'yyyy-mm-dd hh24:mi:ss') as in_date, /*入院日期*/
             to_date(b.outhosdate, 'yyyy-mm-dd hh24:mi:ss') as out_date, /*出院日期*/
             '0'||:new.zg_flag as diag_outstate, /*转归码*/
             decode(a.diagnosis_type_id, '7', '1', '0') as diag_main, /*是否主诊断*/
             a.create_user as oper_code, /*操作员*/
             to_date(a.create_time, 'yyyy-mm-dd hh24:mi:ss') as oper_time /*操作时间*/
        from iem_mainpage_diagnosis_2012 a, inpatient b
       where a.iem_mainpage_no = :new.iem_mainpage_no
         and a.valide = '1'
         and a.diagnosis_type_id <> '13'
         and b.noofinpat = :new.noofinpat;
     --2-病理诊断 c  序号16固定
     If (:new.PATHOLOGY_DIAGNOSIS_NAME is not null) Then
       INSERT INTO ii_diagnose_tj
        (card_no, --就诊卡号
         inpatient_no, --住院流水号
         happen_no, --诊断序号
         diag_kind, --诊断类型3出院诊断o术前诊断p术后诊断……
         icd_code, --icd码
         diag_name, --诊断名称
         diag_date, --诊断日期
         doct_code, --诊断医生代码
         diag_doc_name, --诊断医生名称
         diag_state, --是否有效
         dept_code, --出院科室
         in_date, --入院日期
         out_date, --出院日期
         diag_outstate, --转归码
         diag_main, --是否主诊断
         oper_code, --操作员
         oper_time) --操作日期
        select b.noofclinic as card_no, /*就诊卡*/
               b.patnoofhis as inpatient_no, /*住院流水号*/
               16 as happen_no,
               'c' as diag_kind, /*诊断类型?*/
               'XXXX' as icd_code, /*诊断代码*/
               :new.Pathology_Diagnosis_Name as diag_name, /*诊断名称*/
               to_date(a.create_time, 'yyyy-mm-dd hh24:mi:ss') as diag_date /*诊断日期*/,
               a.create_user as doct_code, /*诊断医生代码*/
               (select x.name from users x where x.id = a.create_user) as diag_doc_name, /*诊断医生名称*/
               '1' as diag_state, /*是否有效*/
               b.outhosdept as dept_code, /*出院科室*/
               to_date(b.admitdate, 'yyyy-mm-dd hh24:mi:ss') as in_date, /*入院日期*/
               to_date(b.outhosdate, 'yyyy-mm-dd hh24:mi:ss') as out_date, /*出院日期*/
               '0'||:new.zg_flag as diag_outstate, /*转归码*/
               '0' as diag_main, /*是否主诊断*/
               a.create_user as oper_code, /*操作员*/
               to_date(a.create_time, 'yyyy-mm-dd hh24:mi:ss') as oper_time /*操作时间*/
          from iem_mainpage_diagnosis_2012 a, inpatient b
         where a.iem_mainpage_no = :new.iem_mainpage_no
           and a.valide = '1'
           and a.diagnosis_type_id <> '13'
           and rownum = 1
           and b.noofinpat = :new.noofinpat;
     End IF;
     --3-损伤、中毒的外部因素 a  序号 17固定
      If (:new.HURT_TOXICOSIS_ELE_NAME is not null) Then
       INSERT INTO ii_diagnose_tj
        (card_no, --就诊卡号
         inpatient_no, --住院流水号
         happen_no, --诊断序号
         diag_kind, --诊断类型3出院诊断o术前诊断p术后诊断……
         icd_code, --icd码
         diag_name, --诊断名称
         diag_date, --诊断日期
         doct_code, --诊断医生代码
         diag_doc_name, --诊断医生名称
         diag_state, --是否有效
         dept_code, --出院科室
         in_date, --入院日期
         out_date, --出院日期
         diag_outstate, --转归码
         diag_main, --是否主诊断
         oper_code, --操作员
         oper_time) --操作日期
        select b.noofclinic as card_no, /*就诊卡*/
               b.patnoofhis as inpatient_no, /*住院流水号*/
               17 as happen_no,
               'a' as diag_kind, /*诊断类型?*/
               :new.hurt_toxicosis_ele_id as icd_code, /*诊断代码*/
               :new.HURT_TOXICOSIS_ELE_NAME as diag_name, /*诊断名称*/
               to_date(a.create_time, 'yyyy-mm-dd hh24:mi:ss') as diag_date /*诊断日期*/,
               a.create_user as doct_code, /*诊断医生代码*/
               (select x.name from users x where x.id = a.create_user) as diag_doc_name, /*诊断医生名称*/
               '1' as diag_state, /*是否有效*/
               b.outhosdept as dept_code, /*出院科室*/
               to_date(b.admitdate, 'yyyy-mm-dd hh24:mi:ss') as in_date, /*入院日期*/
               to_date(b.outhosdate, 'yyyy-mm-dd hh24:mi:ss') as out_date, /*出院日期*/
               '0'||:new.zg_flag as diag_outstate, /*转归码*/
               '0' as diag_main, /*是否主诊断*/
               a.create_user as oper_code, /*操作员*/
               to_date(a.create_time, 'yyyy-mm-dd hh24:mi:ss') as oper_time /*操作时间*/
          from iem_mainpage_diagnosis_2012 a, inpatient b
         where a.iem_mainpage_no = :new.iem_mainpage_no
           and a.valide = '1'
           and a.diagnosis_type_id <> '13'
           and rownum = 1
           and b.noofinpat = :new.noofinpat;
     End IF;
     --说明：新病案首页中无医院感染信息，无法传送
    --婴儿信息
    INSERT INTO mrmschild --婴儿情况
      (inpatient_no, --母亲住院流水号
       child_no, --婴儿序号
       child_sex, --婴儿性别
       apj_evaluate, --阿帕加评分
       child_height, --婴儿身长CM
       child_weight, --婴儿体重g
       spawn_situation, --婴儿产出情况
       child_birthday, --婴儿出生时间(年月日时分)
       birth_fashion, --婴儿分娩方式
       childout_state, --婴儿出院情况
       sfqy) --是否畸形
      select b.patnoofhis as inpatient_no, /*住院流水号*/
             to_number(a.IBSBABYID) as CHILD_NO, /*婴儿序号*/
             a.sex as CHILD_SEX, /*婴儿性别*/
             a.apj as APJ_EVALUATE, /*阿帕加评分*/
             a.heigh as CHILD_HEIGHT, /*婴儿身长CM*/
             a.weight as CHILD_WEIGHT, /*婴儿体重g*/
             a.ccqk as SPAWN_SITUATION, /*婴儿产出情况*/
             to_date(a.bithday, 'yyyy-mm-dd hh24:mi:ss') as CHILD_BIRTHDAY, /*婴儿出生时间*/
             a.fmfs as BIRTH_FASHION, /*婴儿分娩方式*/
             a.cyqk as CHILDOUT_STATE, /*婴儿出院情况*/
             '' as sfqy
        from iem_mainpage_obstetricsbaby a, inpatient b
       where a.iem_mainpage_no = :new.iem_mainpage_no
         and b.noofinpat = :new.noofinpat;
    --妇产信息
    INSERT INTO mrmswombirth --产科产妇情况
      (inpatient_no, --住院流水号
       fetus_times, --胎次
       spawn_times, --产次
       fetus_kind, --胎别
       breach_kind, --产妇会阴破裂度(1、2、3)
       charge_birth_code, --接产者代码
       charge_birth_name) --接产者姓名
      select b.patnoofhis as inpatient_no, /*住院流水号*/
             a.tc as fetus_times, /*胎次*/
             a.cc as spawn_times, /*产次*/
             a.tb as fetus_kind, /*胎别*/
             a.cfhypld as breach_kind, /*产妇会阴破裂度*/
             a.midwifery as charge_birth_code, /*接产者代码*/
             (select name from users where id = a.midwifery) as charge_birth_name
        from iem_mainpage_obstetricsbaby a, inpatient b
       where a.iem_mainpage_no = :new.iem_mainpage_no
         and b.noofinpat = :new.noofinpat;
  
  End If;
end trg_insert_mrmsbase_tj;
/

prompt
prompt Creating trigger TRG_INSERT_PATDIAG
prompt ===================================
prompt
CREATE OR REPLACE TRIGGER EMR."TRG_INSERT_PATDIAG"
  before insert or update on patdiag  
  for each row
declare
  -- local variables here
    as_cardno varchar2(10);
    as_inpatientno varchar2(14);
    al_happend_no number(5);
    as_deptcode varchar2(4);
    adt_indate date;
begin

    select  a.patnoofhis,a.noofclinic,a.outhosdept,to_date(a.admitdate,'yyyy-mm-dd hh24:mi:ss') into as_inpatientno,as_cardno,as_deptcode,adt_indate from inpatient a where a.noofinpat = :new.patient_id;
    Select max(t.happen_no) into al_happend_no from ii_diagnose_send t where t.inpatient_no = as_inpatientno;
    If al_happend_no is null then al_happend_no := 0; end If;
    al_happend_no := al_happend_no + 1;
    
    INSERT INTO ii_diagnose_send   --患者诊断库--从一丹电子病历接收
          ( card_no,   --病历号
            inpatient_no,   --住院流水号
            happen_no,   --发生序号
            diag_kind,   --1：入院诊断 2：出院诊断  3：转科诊断
            icd_code,   --诊断ICD码
            diag_name,   --诊断名称
            diag_date,   --诊断日期
            doct_code,   --医师代号
            diag_doc_name,   --医师姓名(诊断)
            diag_state,   --O：旧诊断   N：新诊断
            sdept_code,   --大科代码
            dept_code,   --科室代码
            in_date,   --入院日期
            remark,   
            oper_code,   
            oper_time ) 
     VALUES 
          ( as_cardno,   --病历号
            as_inpatientno,   --住院流水号
            al_happend_no,   --发生序号
            substr('Y'||:new.diag_type,1,2),   --1：入院诊断 2：出院诊断  3：转科诊断
            :new.diag_code,   --诊断ICD码
            :new.diag_content,   --诊断名称
            :new.diag_date,   --诊断日期
            :new.diag_doctor_id,   --医师代号
            :new.diag_doctor_id,  --医师姓名(诊断)
            '1',   --O：旧诊断   N：新诊断
            null,   --大科代码
            substr(as_deptcode,1,4),   --科室代码
            adt_indate,   --入院日期
            '传入诊断',
            :new.diag_doctor_id,   
            sysdate  );
 
  
end trg_insert_patdiag;
/


spool off

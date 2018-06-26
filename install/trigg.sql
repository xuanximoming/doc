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
-- ���¼��㲡������
declare
  v_syxh int;
  v_csrq varchar(19);
  v_ryrq varchar(19);
  v_brnl int;
  v_xsnl varchar(19);
  PRAGMA AUTONOMOUS_TRANSACTION;--��������
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
  if :NEW.outhosdept is not null and :NEW.outhosward is not null and :NEW.outhosdept <> :OLD.outhosdept then --ת��
     insert into inpatientchangeinfo(id, noofinpat, newdeptid, newwardid, newbedid, olddeptid, oldwardid, oldbedid,
            changestyle, createuser, createtime, valid)
     values(seq_inpatientchangeinfo_id.nextval, :NEW.noofinpat, :NEW.outhosdept, :NEW.outhosward, :NEW.outbed, :OLD.outhosdept, :OLD.outhosward, :OLD.outbed,
            '1', '00', to_char(sysdate, 'yyyy-MM-dd HH24:mi:ss'), '1');
  elsif :NEW.outhosdept is not null and :NEW.outhosward is not null and :NEW.outhosward <> :OLD.outhosward then --ת����
     insert into inpatientchangeinfo(id, noofinpat, newdeptid, newwardid, newbedid, olddeptid, oldwardid, oldbedid,
            changestyle, createuser, createtime, valid)
     values(seq_inpatientchangeinfo_id.nextval, :NEW.noofinpat, :NEW.outhosdept, :NEW.outhosward, :NEW.outbed, :OLD.outhosdept, :OLD.outhosward, :OLD.outbed,
            '2', '00', to_char(sysdate, 'yyyy-MM-dd HH24:mi:ss'), '1');
  elsif :NEW.outhosdept is not null and :NEW.outhosward is not null and :NEW.outbed <> :OLD.outbed then --ת��
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
--��ɾ��ԭ��¼��Ϊ�յ����� add by ywk
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
--��ɾ��ԭ��¼��Ϊ�յ����� add by ywk
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

  /*PRAGMA AUTONOMOUS_TRANSACTION;--��������*/
begin
--��ɾ��ԭ��¼��Ϊ�յ����� add by ywk
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
  --��������ҳ���������Ϻ󣬽���������Ϣ���뵽��Ӧ��HIS����
  If :new.patflag = '1' /*and (:old.patflag is null or :old.patflag = '0')*/ Then
    delete from mrmsbase_tj t where t.inpatient_no = :new.patnoofhis;
    delete from ii_diagnose_tj where inpatient_no = :new.patnoofhis;
    delete from mrmschild where inpatient_no = :new.patnoofhis;
    delete from mrmsopdt_tj where inpatient_no = :new.patnoofhis;
    delete from mrmswombirth where inpatient_no = :new.patnoofhis;
    --������ҳ
    INSERT INTO mrmsbase_tj
      (inpatient_no, --סԺ��ˮ��
       patient_no, --סԺ��
       card_no, --���￨��
       name, --��������
       sex, --�����Ա�
       birthday, --��������
       coun_code, --����
       nation_code, --����
       prof_code, --ְҵ
       blood_code, --Ѫ��
       mari, --����
       in_source, --��Դ
       home_add, --��ͥסַ
       home_tel, --��ͥ�绰
       home_zip, --��ͥ�ʱ�
       work_name, --������λ
       work_tel, --�����绰
       work_zip, --�����ʱ�
       linkma_name, --��ϵ��
       rela_code, --��ϵ���뻼�߹�ϵ
       linkman_tel, --��ϵ�˵绰
       linkman_add, --��ϵ�˵�ַ
       clinic_icd,
       clinic_icdnm,
       in_date, --��Ժ����
       dept_in, --��Ժ����
       dept_innm, --��Ժ��������
       in_avenue, --��Ժ;��
       oper_date, --����ʱ��
       out_date, --��Ժ����
       icd_code, --��Ժס���
       dept_code, --��Ժ����
       dept_name, --��Ժ���Ҵ���
       zg, --ת�����
       ce_pi, --������סԺ��Ϸ������
       pi_po, --��Ժ���Ժ��Ϸ������
       opb_opa, --��ǰ��������Ϸ������
       cl_pa, --�ٴ��벡����Ϸ������
       house_doc_code, --סԺҽ������
       house_doc_name, --סԺҽ������
       charge_doc_code, --����ҽ������
       charge_doc_name, --����ҽ������
       chief_doc_code, --����ҽ������
       chief_doc_name, --����ҽ������
       type_167, --��Ϸ���
       pi_days, --סԺ����
       out_date2, --��Ժ����
       paykind_code, --ҽ�Ƹ��ʽ
       mrms_no, --������
       fs_bl, --�����벡����Ϸ������
       codeing_code, --���
       idcardno, --���֤��
       homeplace, --������
       last_operator, --���һ���޸���
       changedeptcode, --ת��1
       changedeptcode2, --ת��2
       age, --����
       unit_age, --���䵥λ
       mrm_valid, --�����Ƿ���Ч
       static_save, --���״̬
       rysr, --��Ժ��������Ϸ������
       bed_no, --��λ��
       check_dtime, --�������
       check_oper, --�����
       out_zy, --��Ժ��תԺ
       in_circs) --��Ժ����
      select b.patnoofhis as inpatient_no, /*סԺ��ˮ��*/
             b.noofrecord as patient_no, /*סԺ��*/
             b.noofclinic as card_no, /*���￨*/
             b.name as name, /*��������*/
             b.sexid as sex, /*�����Ա�*/
             to_date(b.birth, 'yyyy-mm-dd') as birthday, /*��������*/
             b.nationalityid as coun_code, /*����*/
             b.nationid as nation_code, /*����*/
             b.jobid as prof_code, /*ְҵ*/
             :new.bloodtype as blood_code, /*Ѫ��*/
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
                    '9') as mari, /*����*/
             decode(b.origin, '1', '2', '2', '1', '3', '3', '1') as in_source, /*��Դ*/
             /* b.xzzproviceid || b.xzzcityid || b.xzzdistrictid */
             b.xzzaddress as home_add, /*��ͥסַ*/
             b.xzztel as home_tel, /*��ͥ�绰*/
             b.xzzpost as home_zip, /*��ͥ�ʱ�*/
             b.officeplace as work_name, /*������λ*/
             b.officetel as work_tel, /*�����绰*/
             b.officepost as work_zip, /*�����ʱ�*/
             b.contactperson as linkma_name, /*��ϵ��*/
             b.relationship as rela_code, /*��ϵ���뻼�߹�ϵ*/
             b.contacttel as linkman_tel, /*��ϵ�˵绰*/
             b.contactaddress as linkman_add, /*��ϵ�˵�ַ*/
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
             to_date(b.admitdate, 'yyyy-mm-dd hh24:mi:ss') as in_date, /*��Ժ����*/
             b.admitdept as dept_in, /*��Ժ����*/
             (select name from department s where s.id = b.admitdept) as dept_innm, /*��Ժ��������*/
             b.admitway as in_avenue, /*��Ժ;��*/
             to_date(:new.create_time,'yyyy-mm-dd hh24:mi:ss') as oper_date, /*����ʱ��*/
             to_date(b.outhosdate, 'yyyy-mm-dd hh24:mi:ss') as out_date, /*��Ժ����*/
             (select a.diagnosis_code
                from iem_mainpage_diagnosis_2012 a
               where a.iem_mainpage_no = :new.iem_mainpage_no
                 and a.valide = '1'
                 and a.diagnosis_type_id = '7'
                 and rownum = 1) as icd_code, /*��Ժ�����*/
             b.outhosdept as dept_code, /*��Ժ���Ҵ���*/
             (select name from department s where s.id = b.outhosdept) as dept_innm, /*��Ժ��������*/
             '0'||decode(:new.zg_flag,'9','05',:new.zg_flag), /*ת����*/
             decode(:new.menandinhop,'4','0',:new.menandinhop) as ce_pi, /*������סԺ��Ϸ������*/
             decode(:new.inhopandouthop,'4','0',:new.inhopandouthop) as pi_po, /*��Ժ���Ժ��Ϸ������*/
             decode(:new.beforeopeandafteroper,'4','0',:new.beforeopeandafteroper) as opb_opa, /*��ǰ��������Ϸ������*/
             decode(:new.linandbingli,'4','0',:new.linandbingli) as cl_pa, /*�ٴ��벡����Ϸ������*/
             b.resident as house_doc_code, /*סԺҽ������*/
             (select name from users where id = b.resident) as house_doc_name, /*סԺҽ������*/
             b.attend as charge_doc_code, /*����ҽ������*/
             (select name from users where id = b.attend) as charge_doc_name, /*����ҽ������*/
             b.chief as chief_doc_code, /*����ҽ������*/
             (select name from users where id = b.chief) as chief_doc_name, /*����ҽ������*/
             '' as type_167, /*��Ϸ���*/
             b.totaldays as pi_days, /*סԺ����*/
             to_date(b.outhosdate, 'yyyy-mm-dd hh24:mi:ss') as out_date2, /*��Ժ����*/
             :new.payid, /*ҽ�Ƹ��ʽ--��emr_his�û�������*/
             substr(:new.patnoofhis, 5, 10) as mrms_no, /*������*/
             decode(:new.fangandbingli,'4','0',:new.fangandbingli) as fs_bl, /*�����벡����Ϸ������*/
             :new.create_user as codeing_code, /*���*/
             b.idno as idcardno, /*���֤��*/
             b.provinceid || b.countyid || b.districtid as homeplace, /*������*/
             :new.modified_user as last_operator, /*���һ���޸���*/
             :new.trans_admitdept as changedeptcode, /*ת��1*/
             '' as changedeptcode2, /*ת��2*/
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
             end as age, /*���䣿*/
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
             end as unit_age, /*���䵥λ��*/
             '1' as mrm_valid, /*�����Ƿ���Ч*/
             '0' as static_save, /*���״̬*/
             decode(:new.inhopthree,'4','0',:new.inhopthree) as rysr, /*��Ժ��������Ϸ������*/
             b.admitbed as bed_no /*��λ��*/,
             '' as check_dtime, /*�������*/
             '' as check_oper, /*�����*/
             decode(:new.outhostype,'2','2','3','3','0') as out_zy,
             (select a.admitinfo
                from IEM_MAINPAGE_DIAGNOSIS_2012 a
               where a.iem_mainpage_no = :new.iem_mainpage_no
                 and a.valide = '1'
                 and a.diagnosis_type_id = '7'
                 and rownum = 1) as in_circs /*��Ժ����*/
        from inpatient b
       where b.noofinpat = :new.noofinpat;
    --������Ϣ
    INSERT INTO mrmsopdt_tj
      (inpatient_no, --סԺ��ˮ��
       patient_no, --סԺ��
       card_no, --���￨��
       date_oper, --����ʱ��
       oper_code, --��������
       oper_cnname, --��������
       narc_kind, --����ʽ
       nick_kind, --�пڷ�ʽ
       cica_kind, --���ϵȼ�
       doc_code, --����ҽ������
       doc_name, --����ҽ������
       in_date, --��Ժ����
       out_date, --��Ժ����
       oper_dept, --��������
       out_dept, --��Ժ����
       out_icd, --��Ժ���
       doc_narc, --����ҽ��
       fungus, --�Ƿ��о�
       sfgr, --�Ƿ��Ⱦ
       oper_zq) --�Ƿ���������
      select b.patnoofhis as inpatient_no, /*סԺ��ˮ��*/
             b.noofrecord as patient_no, /*סԺ��*/
             b.noofclinic as card_no, /*���￨*/
             to_date(a.operation_date, 'yyyy-mm-dd hh24:mi:ss') as date_oper, /*����ʱ��*/
             a.operation_code as oper_code, /*��������*/
             a.operation_name as oper_cnname, /*��������*/
             decode(a.anaesthesia_type_id,'9','03','8','03','7','04','6','01','5','05','4','06','3','01','17','02','16','01','15','01','14','04','13','01','12','02','11','02','10','09','08') as narc_kind, /*����ʽ*/
             decode(a.close_level,'1','01','2','02','3','03','4','01','5','02','6','03','7','01','8','02','9','03') as nick_kind, /*�пڷ�ʽ--HIS��Ӧ��ϵ01һ��02����03����*/
             decode(a.close_level,'1','01','2','01','3','01','4','02','5','02','6','02','7','03','8','03','9','03') as cica_kind, /*���ϵȼ�--HIS��Ӧ��ϵ01��02��03��*/
             a.EXECUTE_USER1 as doc_code, /*����ҽ������*/
             (select name from users where id = a.create_user) as doc_name, /*����ҽ������*/
             to_date(b.admitdate, 'yyyy-mm-dd hh24:mi:ss') as in_date, /*��Ժ����*/
             to_date(b.outhosdate, 'yyyy-mm-dd hh24:mi:ss') as out_date, /*��Ժ����*/
             '' as oper_dept, /*��������*/
             b.outhosdept as dept_code, /*��Ժ���Ҵ���*/
             (select a.diagnosis_code
                from iem_mainpage_diagnosis_2012 a
               where a.iem_mainpage_no = :new.iem_mainpage_no
                 and a.valide = '1'
                 and a.diagnosis_type_id = '7'
                 and rownum = 1) as out_icd, /*��Ժ���*/
             a.anaesthesia_user as doc_narc, /*����ҽ��*/
             decode(a.isclearope,'1','1','2','0') as fungus, /*�Ƿ��о�*/
             decode(a.isganran,'1','1','2','0') as sfgr, /*�Ƿ��Ⱦ*/
             decode(a.ischoosedate,'1','1','2','0') as oper_zq /*�Ƿ���������*/
        from iem_mainpage_operation_2012 a, inpatient b
       where a.iem_mainpage_no = :new.iem_mainpage_no
         and a.valide = '1'
         and b.noofinpat = :new.noofinpat;
    --�����Ϣ 1-��Ժ���
    INSERT INTO ii_diagnose_tj
      (card_no, --���￨��
       inpatient_no, --סԺ��ˮ��
       happen_no, --������
       diag_kind, --�������3��Ժ���o��ǰ���p������ϡ���
       icd_code, --icd��
       diag_name, --�������
       diag_date, --�������
       doct_code, --���ҽ������
       diag_doc_name, --���ҽ������
       diag_state, --�Ƿ���Ч
       dept_code, --��Ժ����
       in_date, --��Ժ����
       out_date, --��Ժ����
       diag_outstate, --ת����
       diag_main, --�Ƿ������
       oper_code, --����Ա
       oper_time) --��������
      select b.noofclinic as card_no, /*���￨*/
             b.patnoofhis as inpatient_no, /*סԺ��ˮ��*/
             rownum as happen_no,
             decode(a.diagnosis_type_id,'7','3','3') as diag_kind, /*�������?*/
             a.diagnosis_code as icd_code, /*��ϴ���*/
             a.diagnosis_name as diag_name, /*�������*/
             to_date(a.create_time, 'yyyy-mm-dd hh24:mi:ss') as diag_date /*�������*/,
             a.create_user as doct_code, /*���ҽ������*/
             (select x.name from users x where x.id = a.create_user) as diag_doc_name, /*���ҽ������*/
             a.valide as diag_state, /*�Ƿ���Ч*/
             b.outhosdept as dept_code, /*��Ժ����*/
             to_date(b.admitdate, 'yyyy-mm-dd hh24:mi:ss') as in_date, /*��Ժ����*/
             to_date(b.outhosdate, 'yyyy-mm-dd hh24:mi:ss') as out_date, /*��Ժ����*/
             '0'||:new.zg_flag as diag_outstate, /*ת����*/
             decode(a.diagnosis_type_id, '7', '1', '0') as diag_main, /*�Ƿ������*/
             a.create_user as oper_code, /*����Ա*/
             to_date(a.create_time, 'yyyy-mm-dd hh24:mi:ss') as oper_time /*����ʱ��*/
        from iem_mainpage_diagnosis_2012 a, inpatient b
       where a.iem_mainpage_no = :new.iem_mainpage_no
         and a.valide = '1'
         and a.diagnosis_type_id <> '13'
         and b.noofinpat = :new.noofinpat;
     --2-������� c  ���16�̶�
     If (:new.PATHOLOGY_DIAGNOSIS_NAME is not null) Then
       INSERT INTO ii_diagnose_tj
        (card_no, --���￨��
         inpatient_no, --סԺ��ˮ��
         happen_no, --������
         diag_kind, --�������3��Ժ���o��ǰ���p������ϡ���
         icd_code, --icd��
         diag_name, --�������
         diag_date, --�������
         doct_code, --���ҽ������
         diag_doc_name, --���ҽ������
         diag_state, --�Ƿ���Ч
         dept_code, --��Ժ����
         in_date, --��Ժ����
         out_date, --��Ժ����
         diag_outstate, --ת����
         diag_main, --�Ƿ������
         oper_code, --����Ա
         oper_time) --��������
        select b.noofclinic as card_no, /*���￨*/
               b.patnoofhis as inpatient_no, /*סԺ��ˮ��*/
               16 as happen_no,
               'c' as diag_kind, /*�������?*/
               'XXXX' as icd_code, /*��ϴ���*/
               :new.Pathology_Diagnosis_Name as diag_name, /*�������*/
               to_date(a.create_time, 'yyyy-mm-dd hh24:mi:ss') as diag_date /*�������*/,
               a.create_user as doct_code, /*���ҽ������*/
               (select x.name from users x where x.id = a.create_user) as diag_doc_name, /*���ҽ������*/
               '1' as diag_state, /*�Ƿ���Ч*/
               b.outhosdept as dept_code, /*��Ժ����*/
               to_date(b.admitdate, 'yyyy-mm-dd hh24:mi:ss') as in_date, /*��Ժ����*/
               to_date(b.outhosdate, 'yyyy-mm-dd hh24:mi:ss') as out_date, /*��Ժ����*/
               '0'||:new.zg_flag as diag_outstate, /*ת����*/
               '0' as diag_main, /*�Ƿ������*/
               a.create_user as oper_code, /*����Ա*/
               to_date(a.create_time, 'yyyy-mm-dd hh24:mi:ss') as oper_time /*����ʱ��*/
          from iem_mainpage_diagnosis_2012 a, inpatient b
         where a.iem_mainpage_no = :new.iem_mainpage_no
           and a.valide = '1'
           and a.diagnosis_type_id <> '13'
           and rownum = 1
           and b.noofinpat = :new.noofinpat;
     End IF;
     --3-���ˡ��ж����ⲿ���� a  ��� 17�̶�
      If (:new.HURT_TOXICOSIS_ELE_NAME is not null) Then
       INSERT INTO ii_diagnose_tj
        (card_no, --���￨��
         inpatient_no, --סԺ��ˮ��
         happen_no, --������
         diag_kind, --�������3��Ժ���o��ǰ���p������ϡ���
         icd_code, --icd��
         diag_name, --�������
         diag_date, --�������
         doct_code, --���ҽ������
         diag_doc_name, --���ҽ������
         diag_state, --�Ƿ���Ч
         dept_code, --��Ժ����
         in_date, --��Ժ����
         out_date, --��Ժ����
         diag_outstate, --ת����
         diag_main, --�Ƿ������
         oper_code, --����Ա
         oper_time) --��������
        select b.noofclinic as card_no, /*���￨*/
               b.patnoofhis as inpatient_no, /*סԺ��ˮ��*/
               17 as happen_no,
               'a' as diag_kind, /*�������?*/
               :new.hurt_toxicosis_ele_id as icd_code, /*��ϴ���*/
               :new.HURT_TOXICOSIS_ELE_NAME as diag_name, /*�������*/
               to_date(a.create_time, 'yyyy-mm-dd hh24:mi:ss') as diag_date /*�������*/,
               a.create_user as doct_code, /*���ҽ������*/
               (select x.name from users x where x.id = a.create_user) as diag_doc_name, /*���ҽ������*/
               '1' as diag_state, /*�Ƿ���Ч*/
               b.outhosdept as dept_code, /*��Ժ����*/
               to_date(b.admitdate, 'yyyy-mm-dd hh24:mi:ss') as in_date, /*��Ժ����*/
               to_date(b.outhosdate, 'yyyy-mm-dd hh24:mi:ss') as out_date, /*��Ժ����*/
               '0'||:new.zg_flag as diag_outstate, /*ת����*/
               '0' as diag_main, /*�Ƿ������*/
               a.create_user as oper_code, /*����Ա*/
               to_date(a.create_time, 'yyyy-mm-dd hh24:mi:ss') as oper_time /*����ʱ��*/
          from iem_mainpage_diagnosis_2012 a, inpatient b
         where a.iem_mainpage_no = :new.iem_mainpage_no
           and a.valide = '1'
           and a.diagnosis_type_id <> '13'
           and rownum = 1
           and b.noofinpat = :new.noofinpat;
     End IF;
     --˵�����²�����ҳ����ҽԺ��Ⱦ��Ϣ���޷�����
    --Ӥ����Ϣ
    INSERT INTO mrmschild --Ӥ�����
      (inpatient_no, --ĸ��סԺ��ˮ��
       child_no, --Ӥ�����
       child_sex, --Ӥ���Ա�
       apj_evaluate, --����������
       child_height, --Ӥ����CM
       child_weight, --Ӥ������g
       spawn_situation, --Ӥ���������
       child_birthday, --Ӥ������ʱ��(������ʱ��)
       birth_fashion, --Ӥ�����䷽ʽ
       childout_state, --Ӥ����Ժ���
       sfqy) --�Ƿ����
      select b.patnoofhis as inpatient_no, /*סԺ��ˮ��*/
             to_number(a.IBSBABYID) as CHILD_NO, /*Ӥ�����*/
             a.sex as CHILD_SEX, /*Ӥ���Ա�*/
             a.apj as APJ_EVALUATE, /*����������*/
             a.heigh as CHILD_HEIGHT, /*Ӥ����CM*/
             a.weight as CHILD_WEIGHT, /*Ӥ������g*/
             a.ccqk as SPAWN_SITUATION, /*Ӥ���������*/
             to_date(a.bithday, 'yyyy-mm-dd hh24:mi:ss') as CHILD_BIRTHDAY, /*Ӥ������ʱ��*/
             a.fmfs as BIRTH_FASHION, /*Ӥ�����䷽ʽ*/
             a.cyqk as CHILDOUT_STATE, /*Ӥ����Ժ���*/
             '' as sfqy
        from iem_mainpage_obstetricsbaby a, inpatient b
       where a.iem_mainpage_no = :new.iem_mainpage_no
         and b.noofinpat = :new.noofinpat;
    --������Ϣ
    INSERT INTO mrmswombirth --���Ʋ������
      (inpatient_no, --סԺ��ˮ��
       fetus_times, --̥��
       spawn_times, --����
       fetus_kind, --̥��
       breach_kind, --�����������Ѷ�(1��2��3)
       charge_birth_code, --�Ӳ��ߴ���
       charge_birth_name) --�Ӳ�������
      select b.patnoofhis as inpatient_no, /*סԺ��ˮ��*/
             a.tc as fetus_times, /*̥��*/
             a.cc as spawn_times, /*����*/
             a.tb as fetus_kind, /*̥��*/
             a.cfhypld as breach_kind, /*�����������Ѷ�*/
             a.midwifery as charge_birth_code, /*�Ӳ��ߴ���*/
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
    
    INSERT INTO ii_diagnose_send   --������Ͽ�--��һ�����Ӳ�������
          ( card_no,   --������
            inpatient_no,   --סԺ��ˮ��
            happen_no,   --�������
            diag_kind,   --1����Ժ��� 2����Ժ���  3��ת�����
            icd_code,   --���ICD��
            diag_name,   --�������
            diag_date,   --�������
            doct_code,   --ҽʦ����
            diag_doc_name,   --ҽʦ����(���)
            diag_state,   --O�������   N�������
            sdept_code,   --��ƴ���
            dept_code,   --���Ҵ���
            in_date,   --��Ժ����
            remark,   
            oper_code,   
            oper_time ) 
     VALUES 
          ( as_cardno,   --������
            as_inpatientno,   --סԺ��ˮ��
            al_happend_no,   --�������
            substr('Y'||:new.diag_type,1,2),   --1����Ժ��� 2����Ժ���  3��ת�����
            :new.diag_code,   --���ICD��
            :new.diag_content,   --�������
            :new.diag_date,   --�������
            :new.diag_doctor_id,   --ҽʦ����
            :new.diag_doctor_id,  --ҽʦ����(���)
            '1',   --O�������   N�������
            null,   --��ƴ���
            substr(as_deptcode,1,4),   --���Ҵ���
            adt_indate,   --��Ժ����
            '�������',
            :new.diag_doctor_id,   
            sysdate  );
 
  
end trg_insert_patdiag;
/


spool off

-----------------------------------------------------
-- Export file for user EMR@ORCL                   --
-- Created by Administrator on 2018/5/27, 13:47:17 --
-----------------------------------------------------

set define off
spool proce.log

prompt
prompt Creating procedure AAA
prompt ======================
prompt
create or replace procedure emr.aaa
as
 
Cursor emp_cur IS  select cqlsbz, yzxh from tmp_newfzxh order by cqlsbz, yzxh;
v_ename tmp_newfzxh.cqlsbz%TYPE;
v_sal   tmp_newfzxh.yzxh%TYPE;
BEGIN
IF NOT emp_cur%ISOPEN THEN
   OPEN emp_cur;
   DBMS_OUTPUT.PUT_LINE('打开游标');
END IF;
NULL;
LOOP
   FETCH emp_cur INTO v_ename,v_sal;
   EXIT WHEN emp_cur%NOTFOUND;
   DBMS_OUTPUT.PUT_LINE('用户名：'||v_ename||'，工资：'||v_sal);
END LOOP;
NULL;
IF emp_cur%ISOPEN THEN
   CLOSE emp_cur;
   DBMS_OUTPUT.PUT_LINE('关闭游标');
END IF;
END;
/

prompt
prompt Creating procedure DROPTABLE
prompt ============================
prompt
CREATE OR REPLACE PROCEDURE EMR.DropTable(v_table_name varchar) AS
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  根据传入的表名，删除对应表；
   功能说明
   输入参数
   输出参数
   结果集、排序
  质量控制统计数据集
  
   调用的sp
   调用实例
   exec DropTable ''
   修改记录
  **********/
  -----------根据传入的表名：判断是否已经存在 如果存在 则删除

  v_count int;
  v_sql   varchar(4000);
begin
  -- Build the INSERT statement.
  select count(1)
    into v_count
    from all_objects a
   where a.object_type = 'TABLE'
     and a.object_name = upper(v_table_name);

  IF v_count > 0 then
    BEGIN
      v_sql := N' drop table ' || v_table_name;
      execute immediate v_sql;
    end;
  end if;

END;
/

prompt
prompt Creating procedure EXECUTE_IMMEDIATE
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE EMR.execute_immediate( p_sql_text VARCHAR2 ) IS

   COMPILATION_ERROR EXCEPTION;
   PRAGMA EXCEPTION_INIT(COMPILATION_ERROR,-24344);

   l_cursor INTEGER DEFAULT 0;
   rc       INTEGER DEFAULT 0;
   stmt     VARCHAR2(1000);

BEGIN

   l_cursor := DBMS_SQL.OPEN_CURSOR;
   DBMS_SQL.PARSE(l_cursor, p_sql_text, DBMS_SQL.NATIVE);
   rc := DBMS_SQL.EXECUTE(l_cursor);
   DBMS_SQL.CLOSE_CURSOR(l_cursor);
--
-- Ignore compilation errors because these sometimes happen due to
-- dependencies between views AND procedures
--
   EXCEPTION WHEN COMPILATION_ERROR THEN DBMS_SQL.CLOSE_CURSOR(l_cursor);
       WHEN OTHERS THEN
          BEGIN
              DBMS_SQL.CLOSE_CURSOR(l_cursor);
              raise_application_error(-20101,sqlerrm || '  when executing ''' || p_sql_text || '''   ');
          END;
END;
/

prompt
prompt Creating procedure PROC_STU1
prompt ============================
prompt
CREATE OR REPLACE PROCEDURE EMR.PROC_STU1 AS
BEGIN
--显示游标使用，使用while循环
declare
--1.定义游标，名称为cur_stu
cursor cur_stu is
select stuno,stuname from student order by stuno;
--定义变量，存放游标取出的数据
v_stuno varchar(4);
v_stuname varchar(20);
begin
--2.打开游标cur_stu
open cur_stu;
--3.将游标的当前行取出存放到变量中
fetch cur_stu into v_stuno,v_stuname;
while cur_stu%found --游标所指还有数据行，则继续循环
loop
--打印结果
dbms_output.PUT_LINE(v_stuno||'->'||v_stuname);
--继续将游标所指的当前行取出放到变量中
fetch cur_stu into v_stuno,v_stuname;
end loop;
close cur_stu; --4.关闭游标
end;
END PROC_STU1;
/

prompt
prompt Creating procedure USP_AUDITAPPLYRECORD
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_AuditApplyRecord(
                                                 
                                                 v_AuditType varchar, --审核类型
                                                 v_ManID     varchar, --审核人ID
                                                 v_ID        numeric --记录ID
                                                 ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  审批申请借阅病历
   功能说明
   输入参数
   输出参数
   结果集、排序
  
  
  
   调用的sp
   调用实例
  
   修改记录
  **********/

begin

  if v_AuditType = '5206' then
    --签收
  
    update ApplyRecord
       set SingInDate = to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),
           SingInMan  = v_ManID,
           Status     = v_AuditType
     where ID = v_ID;
  
  else
    --审核
  
    update ApplyRecord
       set AuditDate = to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),
           AuditMan  = v_ManID,
           Status    = v_AuditType
     where ID = v_ID;
  
  end if;

end;
/

prompt
prompt Creating procedure USP_DELETEJOB
prompt ================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_DeleteJob(v_ID VARCHAR) AS /**********
 版本号
 创建时间
 作者
 版权
 描述
 功能说明      删除选定岗位
 输出参数
 结果集、排序
 调用的sp
 调用实例
**********/

BEGIN
  UPDATE Users
     SET JobID = REPLACE(JobID, v_ID + ',', '')
   WHERE ID IN (SELECT ID FROM Users WHERE JobID LIKE '%v_ID%');

  DELETE FROM Job2Permission WHERE ID = v_ID;

  DELETE FROM Jobs WHERE Id = v_ID;
END;
/

prompt
prompt Creating procedure USP_DELETEJOBPERMISSION
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_DeleteJobPermission(v_ID VARCHAR) AS /**********
 版本号
 创建时间
 作者
 版权
 描述
 功能说明      删除权限控制信息
 输出参数
 结果集、排序
 调用的sp
 调用实例
**********/

BEGIN
  DELETE Job2Permission WHERE ID = v_ID;
end;
/

prompt
prompt Creating procedure USP_DELETEUSERINFO
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_DeleteUserInfo(v_ID VARCHAR) AS /**********
 版本号
 创建时间
 作者
 版权
 描述
 功能说明      删除某个员工信息
 输出参数
 结果集、排序
 调用的sp
 调用实例
**********/
BEGIN
  DELETE Users WHERE ID = v_ID;
end;
/

prompt
prompt Creating procedure USP_DEPTEMMANAGER
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_DepTemManager(v_dept varchar) as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取病历模板选择助手数据
   功能说明
   输入参数
   输出参数
   结果集、排序
  质量控制统计数据集
  
   调用的sp
   调用实例
   exec usp_DepTemManager   3202
   修改记录
  **********/
  v_sql varchar2(4000) default '';
begin

  v_sql := 'create table tmp_templet as
    select b.Name,
           b.ID,
           a.ID templetID,
           a.Name templetName,
           a.Describe,
           b.PrevID as PrevID,
           nvl(F_DepTemManager(0, b.ID, nvl(b.PrevID, '')), '') AS groupname,
           nvl(F_DepTemManager(1, b.ID, nvl(b.PrevID, '')), '') AS groupname2
      from Model_Docment a
      left join ModelDirectory b on a.SortID = b.ID
     order by b.ID, groupname';

  execute immediate v_sql;

  v_sql := 'select a.*,
         b.Department,
         (case
           when b.Department is null then
            ''0''
           else
            ''1''
         end) as checked
    from tmp_templet a
    left join (select t.* from Template_Department t where t.Department = ''' ||
           v_dept || ''') b on a.templetID = b.TemplateID';
  execute immediate v_sql;

end;
/

prompt
prompt Creating procedure USP_EDITALLERGYHISTORYINFO
prompt =============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_EditAllergyHistoryInfo(v_dept         varchar, --编辑信息类型：1：添加、2：修改、3：删除
                                                       v_ID           numeric, --唯一列
                                                       v_NoOfInpat    numeric default '-1', --病人首页序号
                                                       v_AllergyID    Int default '', --过敏类型 
                                                       v_AllergyLevel int default '', --过敏程度
                                                       v_Doctor       varchar default '', --代理医生
                                                       v_AllergyPart  varchar default '', --过敏部位
                                                       v_ReactionType varchar default '', --反应类型
                                                       v_Memo         varchar default '' --备注
                                                       ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  编辑过敏史信息
   功能说明
   输入参数
   输出参数
   结果集、排序
  
   调用的sp
   调用实例
  
   修改记录
  **********/

begin

  if v_dept = '1' then
  
    --添加
    insert into AllergyHistory
      (NoOfInpat,
       AllergyID,
       AllergyLevel,
       Doctor,
       AllergyPart,
       ReactionType,
       Memo)
    values
      (v_NoOfInpat,
       v_AllergyID,
       v_AllergyLevel,
       v_Doctor,
       v_AllergyPart,
       v_ReactionType,
       v_Memo);
  
  elsif (v_dept = '2') then
  
    --修改
    update AllergyHistory
       set NoOfInpat    = v_NoOfInpat,
           AllergyID    = v_AllergyID,
           AllergyLevel = v_AllergyLevel,
           Doctor       = v_Doctor,
           AllergyPart  = v_AllergyPart,
           ReactionType = v_ReactionType,
           Memo         = v_Memo
     where ID = v_ID;
  
  elsif (v_dept = '3') then
    --删除
    delete AllergyHistory where ID = v_ID;
  
  end if;

end;
/

prompt
prompt Creating procedure USP_EDITEMRBED
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_EditEmrBed(v_EditType     VARCHAR2 default '', --操作类型
                                           v_ID           VARCHAR2 default '',
                                           v_WARDID       VARCHAR2 default '',
                                           v_DEPTID       VARCHAR2 default '',
                                           v_ROOMID       VARCHAR2 default '',
                                           v_RESIDENT     VARCHAR2 default '',
                                           v_ATTEND       VARCHAR2 default '',
                                           v_CHIEF        VARCHAR2 default '',
                                           v_SEXINFO      INTEGER default 0,
                                           v_STYLE        INTEGER default 0,
                                           v_INBED        INTEGER default 0,
                                           v_ICU          INTEGER default 0,
                                           v_NOOFINPAT    NUMBER default 0,
                                           v_PATNOOFHIS   NUMBER default 0,
                                           v_FORMERWARD   VARCHAR2 default '',
                                           v_FORMERBEDID  VARCHAR2 default '',
                                           v_FORMERDEPTID VARCHAR2 default '',
                                           v_BORROW       INTEGER default 0,
                                           v_VALID        INTEGER default 0,
                                           v_MEMO         VARCHAR2 default '',
                                           o_reslut       out empcurtyp) as
begin
  --添加
  if v_EditType = 'Insert' then
    insert into Bed
      (ID,
       WARDID,
       DEPTID,
       ROOMID,
       RESIDENT,
       ATTEND,
       CHIEF,
       SEXINFO,
       STYLE,
       INBED,
       ICU,
       NOOFINPAT,
       PATNOOFHIS,
       FORMERWARD,
       FORMERBEDID,
       FORMERDEPTID,
       BORROW,
       VALID,
       MEMO)
    values
      (v_ID,
       v_WARDID,
       v_DEPTID,
       v_ROOMID,
       v_RESIDENT,
       v_ATTEND,
       v_CHIEF,
       v_SEXINFO,
       v_STYLE,
       v_INBED,
       v_ICU,
       v_NOOFINPAT,
       v_PATNOOFHIS,
       v_FORMERWARD,
       v_FORMERBEDID,
       v_FORMERDEPTID,
       v_BORROW,
       v_VALID,
       v_MEMO);
    --修改
  elsif v_EditType = 'Update' then
    update Bed
       set WARDID       = nvl(v_WARDID, WARDID),
           DEPTID       = nvl(v_DEPTID, DEPTID),
           ROOMID       = nvl(v_ROOMID, ROOMID),
           RESIDENT     = nvl(v_RESIDENT, RESIDENT),
           ATTEND       = nvl(v_ATTEND, ATTEND),
           CHIEF        = nvl(v_CHIEF, CHIEF),
           SEXINFO      = nvl(v_SEXINFO, SEXINFO),
           STYLE        = nvl(v_STYLE, STYLE),
           INBED        = nvl(v_INBED, INBED),
           ICU          = nvl(v_ICU, ICU),
           NOOFINPAT    = nvl(v_NOOFINPAT, NOOFINPAT),
           PATNOOFHIS   = nvl(v_PATNOOFHIS, PATNOOFHIS),
           FORMERWARD   = nvl(v_FORMERWARD, FORMERWARD),
           FORMERBEDID  = nvl(v_FORMERBEDID, FORMERBEDID),
           FORMERDEPTID = nvl(v_FORMERDEPTID, FORMERDEPTID),
           BORROW       = nvl(v_BORROW, BORROW),
           VALID        = nvl(v_VALID, VALID),
           MEMO         = nvl(v_MEMO, MEMO)
     where ID = v_ID
     and WARDID = v_WARDID;
    --查询
    /*  elsif v_EditType = 'Select' then
    select ID,
           WARDID,
           DEPTID,
           ROOMID,
           RESIDENT,
           ATTEND,
           CHIEF,
           SEXINFO,
           STYLE,
           INBED,
           ICU,
           NOOFINPAT,
           PATNOOFHIS,
           FORMERWARD,
           FORMERBEDID,
           FORMERDEPTID,
           BORROW,
           VALID,
           MEMO
           from Bed;*/
    --删除
  elsif v_EditType = 'Delete' then
    delete Bed where ID = v_ID;
  end if;
end;
/

prompt
prompt Creating procedure USP_EDITEMRBEDINFO
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_EditEmrBedInfo(v_EditType     VARCHAR2 default '', --操作类型
                                               v_ID           NUMBER default 0,
                                               v_NOOFINPAT    NUMBER default 0,
                                               v_FORMERWARD   VARCHAR2 default '',
                                               v_FORMERBEDID  VARCHAR2 default '',
                                               v_FORMERDEPTID VARCHAR2 default '',
                                               v_STARTDATE    CHAR default '',
                                               v_ENDDATE      CHAR default '',
                                               v_NEWDEPT      VARCHAR2 default '',
                                               v_NEWWARD      VARCHAR2 default '',
                                               v_NEWBED       VARCHAR2 default '',
                                               v_MARK         INTEGER default 0) as
begin
  --添加
  if v_EditType = 'Insert' then
    insert into BedInfo
      (ID,
       NOOFINPAT,
       FORMERWARD,
       FORMERBEDID,
       FORMERDEPTID,
       STARTDATE,
       ENDDATE,
       NEWDEPT,
       NEWWARD,
       NEWBED,
       MARK)
    values
      ((select max(ID) + 1 as NewID from BedInfo),
       v_NOOFINPAT,
       v_FORMERWARD,
       v_FORMERBEDID,
       v_FORMERDEPTID,
       v_STARTDATE,
       v_ENDDATE,
       v_NEWDEPT,
       v_NEWWARD,
       v_NEWBED,
       v_MARK);
    --修改
  elsif v_EditType = 'Update' then
    update BedInfo
       set NOOFINPAT    = nvl(v_NOOFINPAT, NOOFINPAT),
           FORMERWARD   = nvl(v_FORMERWARD, FORMERWARD),
           FORMERBEDID  = nvl(v_FORMERBEDID, FORMERBEDID),
           FORMERDEPTID = nvl(v_FORMERDEPTID, FORMERDEPTID),
           STARTDATE    = nvl(v_STARTDATE, STARTDATE),
           ENDDATE      = nvl(v_ENDDATE, ENDDATE),
           NEWDEPT      = nvl(v_NEWDEPT, NEWDEPT),
           NEWWARD      = nvl(v_NEWWARD, NEWWARD),
           NEWBED       = nvl(v_NEWBED, NEWBED),
           MARK         = nvl(v_MARK, MARK)
     where ID = v_ID;
    --删除
  elsif v_EditType = 'Delete' then
    delete Bedinfo where ID = v_ID;
    --查询
  elsif v_EditType = 'Select' then
    select ID,
           NOOFINPAT,
           FORMERWARD,
           FORMERBEDID,
           FORMERDEPTID,
           STARTDATE,
           ENDDATE,
           NEWDEPT,
           NEWWARD,
           NEWBED,
           MARK
      from Bedinfo;
  end if;
end;
/

prompt
prompt Creating procedure USP_EDITEMRLONG_ORDER
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_EditEmrLONG_ORDER(v_EditType         varchar default '', --操作类型
                                                  v_LONGID           NUMBER default '',
                                                  v_NOOFINPAT        NUMBER default '',
                                                  v_GROUPID          NUMBER default '',
                                                  v_GROUPFLAG        INTEGER default '',
                                                  v_WARDID           VARCHAR2 default '',
                                                  
                                                  v_DEPTID           VARCHAR2 default '',
                                                  v_TYPEDOCTOR       VARCHAR2 default '',
                                                  v_TYPEDATE         CHAR default '',
                                                  v_AUDITOR          VARCHAR2 default '',
                                                  v_DATEOFAUDIT      CHAR default '',
                                                  
                                                  v_EXECUTOR         VARCHAR2 default '',
                                                  v_EXECUTEDATE      CHAR default '',
                                                  v_CANCELDOCTOR     VARCHAR2 default '',
                                                  v_CANCELDATE       CHAR default '',
                                                  v_CEASEDCOCTOR     VARCHAR2 default '',
                                                  
                                                  v_CEASEDATE        CHAR default '',
                                                  v_CEASENURSE       VARCHAR2 default '',
                                                  v_CEASEADUDITDATE  CHAR default '',
                                                  v_STARTDATE        CHAR default '',
                                                  v_TOMORROW         INTEGER default '',
                                                  
                                                  v_PRODUCTNO        NUMBER default '',
                                                  v_NORMNO           NUMBER default '',
                                                  v_MEDICINENO       NUMBER default '',
                                                  v_DRUGNO           VARCHAR2 default '',
                                                  v_DRUGNAME         VARCHAR2 default '',
                                                  
                                                  v_DRUGNORM         VARCHAR2 default '',
                                                  v_ITEMTYPE         INTEGER default '',
                                                  v_MINUNIT          VARCHAR2 default '',
                                                  v_DRUGDOSE         NUMBER default '',
                                                  v_DOSEUNIT         VARCHAR2 default '',
                                                  
                                                  v_UNITRATE         NUMBER default '',
                                                  v_UNITTYPE         INTEGER default '',
                                                  v_DRUGUSE          VARCHAR2 default '',
                                                  v_BATCHNO          VARCHAR2 default '',
                                                  v_EXECUTECOUNT     INTEGER default '',
                                                  
                                                  v_EXECUTECYCLE     INTEGER default '',
                                                  v_CYCLEUNIT        INTEGER default '',
                                                  v_DATEOFWEEK       CHAR default '',
                                                  v_INNEREXECUTETIME VARCHAR2 default '',
                                                  v_EXECUTEDEPT      VARCHAR2 default '',
                                                  
                                                  v_ENTRUST          VARCHAR2 default '',
                                                  v_ORDERTYPE        INTEGER default '',
                                                  v_ORDERSTATUS      INTEGER default '',
                                                  v_SPECIALMARK      INTEGER default '',
                                                  v_CEASEREASON      INTEGER default '',
                                                  
                                                  v_CURGERYID        NUMBER default '',
                                                  v_CONTENT          VARCHAR2 default '',
                                                  v_SYNCH            INTEGER default '',
                                                  v_MEMO             VARCHAR2 default '',
                                                  v_DJFL             VARCHAR2 default '') as
begin
  --添加
  if v_EditType = '1' then
    insert into LONG_ORDER
    
      (LONGID,
       NOOFINPAT,
       GROUPID,
       GROUPFLAG,
       WARDID,
       DEPTID,
       TYPEDOCTOR,
       TYPEDATE,
       AUDITOR,
       DATEOFAUDIT,
       EXECUTOR,
       EXECUTEDATE,
       CANCELDOCTOR,
       CANCELDATE,
       CEASEDCOCTOR,
       CEASEDATE,
       CEASENURSE,
       CEASEADUDITDATE,
       STARTDATE,
       TOMORROW,
       PRODUCTNO,
       NORMNO,
       MEDICINENO,
       DRUGNO,
       DRUGNAME,
       DRUGNORM,
       ITEMTYPE,
       MINUNIT,
       DRUGDOSE,
       DOSEUNIT,
       UNITRATE,
       UNITTYPE,
       DRUGUSE,
       BATCHNO,
       EXECUTECOUNT,
       EXECUTECYCLE,
       CYCLEUNIT,
       DATEOFWEEK,
       INNEREXECUTETIME,
       EXECUTEDEPT,
       ENTRUST,
       ORDERTYPE,
       ORDERSTATUS,
       SPECIALMARK,
       CEASEREASON,
       CURGERYID,
       CONTENT,
       SYNCH,
       MEMO,
       DJFL)
    values
      (seq_long_order_id.nextval,
       v_NOOFINPAT,
       v_GROUPID,
       v_GROUPFLAG,
       v_WARDID,
       v_DEPTID,
       v_TYPEDOCTOR,
       v_TYPEDATE, --时间
       v_AUDITOR,
       v_DATEOFAUDIT,
       v_EXECUTOR,
       v_EXECUTEDATE, --时间
       v_CANCELDOCTOR,
       v_CANCELDATE, --时间
       v_CEASEDCOCTOR,
       v_CEASEDATE, --时间
       v_CEASENURSE,
       v_CEASEADUDITDATE, --时间
       v_STARTDATE, --时间
       v_TOMORROW,
       v_PRODUCTNO,
       v_NORMNO,
       v_MEDICINENO,
       v_DRUGNO,
       v_DRUGNAME,
       v_DRUGNORM,
       v_ITEMTYPE,
       v_MINUNIT,
       v_DRUGDOSE,
       v_DOSEUNIT,
       v_UNITRATE,
       v_UNITTYPE,
       v_DRUGUSE,
       v_BATCHNO,
       v_EXECUTECOUNT,
       v_EXECUTECYCLE,
       v_CYCLEUNIT,
       v_DATEOFWEEK,
       v_INNEREXECUTETIME, --时间
       v_EXECUTEDEPT,
       v_ENTRUST,
       v_ORDERTYPE,
       v_ORDERSTATUS,
       v_SPECIALMARK,
       v_CEASEREASON,
       v_CURGERYID,
       v_CONTENT,
       v_SYNCH,
       v_MEMO,
       v_DJFL);
    --修改
  elsif v_EditType = '2' then
    update LONG_ORDER
       set NOOFINPAT        = nvl(v_NOOFINPAT, NOOFINPAT),
           GROUPID          = nvl(v_GROUPID, GROUPID),
           GROUPFLAG        = nvl(v_GROUPFLAG, GROUPFLAG),
           WARDID           = nvl(v_WARDID, WARDID),
           DEPTID           = nvl(v_DEPTID, DEPTID),
           TYPEDOCTOR       = nvl(v_TYPEDOCTOR, TYPEDOCTOR),
           TYPEDATE         = nvl(v_TYPEDATE, TYPEDATE), --时间
           AUDITOR          = nvl(v_AUDITOR, AUDITOR),
           DATEOFAUDIT      = nvl(v_DATEOFAUDIT, DATEOFAUDIT),
           EXECUTOR         = nvl(v_EXECUTOR, EXECUTOR),
           EXECUTEDATE      = nvl(v_EXECUTEDATE, EXECUTEDATE), --时间
           CANCELDOCTOR     = nvl(v_CANCELDOCTOR, CANCELDOCTOR),
           CANCELDATE       = nvl(v_CANCELDATE, CANCELDATE), --时间
           CEASEDCOCTOR     = nvl(v_CEASEDCOCTOR, CEASEDCOCTOR),
           CEASEDATE        = nvl(v_CEASEDATE, CEASEDATE), --时间
           CEASENURSE       = nvl(v_CEASENURSE, CEASENURSE),
           CEASEADUDITDATE  = nvl(v_CEASEADUDITDATE, CEASEADUDITDATE), --时间
           STARTDATE        = nvl(v_STARTDATE, STARTDATE), --时间
           TOMORROW         = nvl(v_TOMORROW, TOMORROW),
           PRODUCTNO        = nvl(v_PRODUCTNO, PRODUCTNO),
           NORMNO           = nvl(v_NORMNO, NORMNO),
           MEDICINENO       = nvl(v_MEDICINENO, MEDICINENO),
           DRUGNO           = nvl(v_DRUGNO, DRUGNO),
           DRUGNAME         = nvl(v_DRUGNAME, DRUGNAME),
           DRUGNORM         = nvl(v_DRUGNORM, DRUGNORM),
           ITEMTYPE         = nvl(v_ITEMTYPE, ITEMTYPE),
           MINUNIT          = nvl(v_MINUNIT, MINUNIT),
           DRUGDOSE         = nvl(v_DRUGDOSE, DRUGDOSE),
           DOSEUNIT         = nvl(v_DOSEUNIT, DOSEUNIT),
           UNITRATE         = nvl(v_UNITRATE, UNITRATE),
           UNITTYPE         = nvl(v_UNITTYPE, UNITTYPE),
           DRUGUSE          = nvl(v_DRUGUSE, DRUGUSE),
           BATCHNO          = nvl(v_BATCHNO, BATCHNO),
           EXECUTECOUNT     = nvl(v_EXECUTECOUNT, EXECUTECOUNT),
           EXECUTECYCLE     = nvl(v_EXECUTECYCLE, EXECUTECYCLE),
           CYCLEUNIT        = nvl(v_CYCLEUNIT, CYCLEUNIT),
           DATEOFWEEK       = nvl(v_DATEOFWEEK, DATEOFWEEK),
           INNEREXECUTETIME = nvl(v_INNEREXECUTETIME, INNEREXECUTETIME), --时间
           EXECUTEDEPT      = nvl(v_EXECUTEDEPT, EXECUTEDEPT),
           ENTRUST          = nvl(v_ENTRUST, ENTRUST),
           ORDERTYPE        = nvl(v_ORDERTYPE, ORDERTYPE),
           ORDERSTATUS      = nvl(v_ORDERSTATUS, ORDERSTATUS),
           SPECIALMARK      = nvl(v_SPECIALMARK, SPECIALMARK),
           CEASEREASON      = nvl(v_CEASEREASON, CEASEREASON),
           CURGERYID        = nvl(v_CURGERYID, CURGERYID),
           CONTENT          = nvl(v_CONTENT, CONTENT),
           SYNCH            = nvl(v_SYNCH, SYNCH),
           MEMO             = nvl(v_MEMO, MEMO),
           DJFL             = nvl(v_DJFL, DJFL)
     where LONGID = V_LONGID;
    --删除
  elsif v_EditType = '3' then
    delete LONG_ORDER where LONGID = V_LONGID;
    --查询
/*  elsif v_EditType = '4' then
    select * from LONG_ORDER where LONGID = V_LONGID;*/
  end if;
end;
/

prompt
prompt Creating procedure USP_EDITEMRTEMPLET
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_EditEmrTemplet(v_EditType        varchar default '', --操作类型
                                               v_TEMPLET_ID      VARCHAR2 default '',
                                               v_FILE_NAME       VARCHAR2 default '',
                                               v_PATH            VARCHAR2 default '',
                                               v_TOPIC           VARCHAR2 default '',
                                               v_DEPT_ID         VARCHAR2 default '',
                                               v_CREATOR_ID      VARCHAR2 default '',
                                               v_CREATE_DATETIME date default '',
                                               v_LAST_TIME       date default '',
                                               v_PERMISSION      VARCHAR2 default '',
                                               v_MR_CLASS        VARCHAR2 default '',
                                               v_MR_CODE         VARCHAR2 default '',
                                               v_MR_NAME         VARCHAR2 default '',
                                               v_MR_ATTR         VARCHAR2 default '',
                                               v_QC_CODE         VARCHAR2 default '',
                                               v_NEW_PAGE_FLAG   NUMBER default 0,
                                               v_FILE_FLAG       NUMBER default 0,
                                               v_WRITE_TIMES     NUMBER default 0,
                                               v_CODE            VARCHAR2 default '',
                                               v_HOSPITAL_CODE   VARCHAR2 default '',
                                               v_XML_DOC         BLOB) as

begin
  --添加
  if v_EditType = '1' then
  
    insert into EMRTEMPLET
      (TEMPLET_ID,
       FILE_NAME,
       DEPT_ID,
       CREATOR_ID,
       CREATE_DATETIME,
       LAST_TIME,
       PERMISSION,
       MR_CLASS,
       MR_CODE,
       MR_NAME,
       MR_ATTR,
       QC_CODE,
       NEW_PAGE_FLAG,
       FILE_FLAG,
       WRITE_TIMES,
       CODE,
       HOSPITAL_CODE,
       XML_DOC)
    values
      (v_TEMPLET_ID,
       v_FILE_NAME,
       v_DEPT_ID,
       v_CREATOR_ID,
       v_CREATE_DATETIME,
       v_LAST_TIME,
       v_PERMISSION,
       v_MR_CLASS,
       v_MR_CODE,
       v_MR_NAME,
       v_MR_ATTR,
       v_QC_CODE,
       v_NEW_PAGE_FLAG,
       v_FILE_FLAG,
       v_WRITE_TIMES,
       v_CODE,
       v_HOSPITAL_CODE,
       v_XML_DOC);
       
    --修改
  elsif v_EditType = '2' then
  
    UPDATE EMRTEMPLET
       SET FILE_NAME       = v_FILE_NAME,
           DEPT_ID         = v_DEPT_ID,
           CREATOR_ID      = v_CREATOR_ID,
           CREATE_DATETIME = v_CREATE_DATETIME,
           LAST_TIME       = v_LAST_TIME,
           PERMISSION      = v_PERMISSION,
           MR_CLASS        = v_MR_CLASS,
           MR_CODE         = v_MR_CODE,
           MR_NAME         = v_MR_NAME,
           MR_ATTR         = v_MR_ATTR,
           QC_CODE         = v_QC_CODE,
           NEW_PAGE_FLAG   = v_NEW_PAGE_FLAG,
           FILE_FLAG       = v_FILE_FLAG,
           WRITE_TIMES     = v_WRITE_TIMES,
           CODE            = v_CODE,
           HOSPITAL_CODE   = v_HOSPITAL_CODE,
           XML_DOC         = v_XML_DOC
     WHERE TEMPLET_ID = v_TEMPLET_ID;
  
    --删除
  elsif v_EditType = '3' then
  
    delete EMRTEMPLET where TEMPLET_ID = v_TEMPLET_ID;
  
    --查询
/*  elsif v_EditType = '4' then
    select * from emrtemplet;*/
  end if;

end;
/

prompt
prompt Creating procedure USP_EDITEMRTEMPLETHEADER
prompt ===========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_EditEmrTempletHeader(v_EditType      varchar default '', --操作类型
                                                     v_HEADER_ID       VARCHAR2 default '',
                                                     v_NAME            VARCHAR2 default '',
                                                     v_CREATOR_ID      VARCHAR2 default '',
                                                     v_CREATE_DATETIME VARCHAR2 default '',
                                                     v_LAST_TIME       VARCHAR2 default '',
                                                     v_HOSPITAL_CODE   VARCHAR2 default '',
                                                     v_CONTENT         CLOB) as

begin
  --添加
  if v_EditType = '1' then
  
    insert into emrtempletHeader
      (HEADER_ID,
       NAME,
       CREATOR_ID,
       CREATE_DATETIME,
       LAST_TIME,
       HOSPITAL_CODE,
       CONTENT)
    values
      (v_HEADER_ID,
       v_NAME,
       v_CREATOR_ID,
       v_CREATE_DATETIME,
       v_LAST_TIME,
       v_HOSPITAL_CODE,
       v_CONTENT);
  
    --修改
  elsif v_EditType = '2' then
  
    UPDATE EMRTEMPLETHEADER
       SET NAME            = nvl(v_NAME, NAME),
           CREATOR_ID      = nvl(v_CREATOR_ID, CREATOR_ID),
           CREATE_DATETIME = nvl(v_CREATE_DATETIME, CREATE_DATETIME),
           LAST_TIME       = nvl(v_LAST_TIME, LAST_TIME),
           HOSPITAL_CODE   = nvl(v_HOSPITAL_CODE, HOSPITAL_CODE),
           CONTENT         = nvl(v_CONTENT, CONTENT)
     where HEADER_ID = v_HEADER_ID;
    --删除
     elsif v_EditType = '3' then
    
    delete EMRTEMPLETHEADER
     where HEADER_ID = v_HEADER_ID;
  
    --查询
    /*  elsif v_EditType = '4' then
    select * from EMRTEMPLETHEADER;*/
  end if;

end;
/

prompt
prompt Creating procedure USP_EDITEMRTEMPLET_ITEM
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_EditEmrTemplet_Item(v_EditType varchar default '', --操作类型
                                                    v_MR_CLASS VARCHAR2 default '',
                                                    v_MR_CODE VARCHAR2 default '',
                                                    v_MR_NAME VARCHAR2 default '',
                                                    v_MR_ATTR VARCHAR2 default '',
                                                    v_QC_CODE VARCHAR2 default '',
                                                    v_DEPT_ID VARCHAR2 default '',
                                                    v_CREATOR_ID VARCHAR2 default '',
                                                    v_CREATE_DATE_TIME VARCHAR2 default '',
                                                    v_LAST_TIME VARCHAR2 default '',
                                                    v_CONTENT_CODE VARCHAR2 default '',
                                                    v_PERMISSION int default 0,
                                                    v_VISIBLED int default 0,
                                                    v_INPUT VARCHAR2 default '',
                                                    v_HOSPITAL_CODE VARCHAR2 default '',
                                                    v_ITEM_DOC_NEW clob) as

begin
  --添加
  if v_EditType = '1' then
  
    insert into EMRTEMPLET_ITEM
      (MR_CLASS,
       MR_CODE,
       MR_NAME,
       MR_ATTR,
       QC_CODE,
       DEPT_ID,
       CREATOR_ID,
       CREATE_DATE_TIME,
       LAST_TIME,
       CONTENT_CODE,
       PERMISSION,
       VISIBLED,
       INPUT,
       HOSPITAL_CODE,
       ITEM_DOC_NEW)
    values
      (v_MR_CLASS,
       v_MR_CODE,
       v_MR_NAME,
       v_MR_ATTR,
       v_QC_CODE,
       v_DEPT_ID,
       v_CREATOR_ID,
       v_CREATE_DATE_TIME,
       v_LAST_TIME,
       v_CONTENT_CODE,
       v_PERMISSION,
       v_VISIBLED,
       v_INPUT,
       v_HOSPITAL_CODE,
       v_ITEM_DOC_NEW);
  
    --修改
  elsif v_EditType = '2' then
  update EMRTEMPLET_ITEM
set
MR_CLASS = nvl(v_MR_CLASS, MR_CLASS),
MR_NAME = nvl(v_MR_NAME, MR_NAME),
MR_ATTR = nvl(v_MR_ATTR, MR_ATTR),
QC_CODE = nvl(v_QC_CODE, QC_CODE),
DEPT_ID = nvl(v_DEPT_ID, DEPT_ID),
CREATOR_ID = nvl(v_CREATOR_ID, CREATOR_ID),
CREATE_DATE_TIME = nvl(v_CREATE_DATE_TIME, CREATE_DATE_TIME),
LAST_TIME = nvl(v_LAST_TIME, LAST_TIME),
CONTENT_CODE = nvl(v_CONTENT_CODE, CONTENT_CODE),
PERMISSION = nvl(v_PERMISSION, PERMISSION),
VISIBLED = nvl(v_VISIBLED, VISIBLED),
INPUT = nvl(v_INPUT, INPUT),
HOSPITAL_CODE = nvl(v_HOSPITAL_CODE, HOSPITAL_CODE),
ITEM_DOC_NEW = v_ITEM_DOC_NEW
where MR_CODE = v_MR_CODE;
 
  
    --删除
  elsif v_EditType = '3' then
  
    delete EMRTEMPLET_ITEM where MR_CODE = v_MR_CODE;
  
    --查询
  elsif v_EditType = '4' then
    select * from EMRTEMPLET_ITEM;
  end if;

end;
/

prompt
prompt Creating procedure USP_EDITEMRTEMP_ORDER
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_EditEmrTEMP_ORDER(v_EditType         VARCHAR2 default '', --操作类型
                                                  v_TEMPID           NUMBER default 0,
                                                  v_NOOFINPAT        NUMBER default 0,
                                                  v_GROUPID          NUMBER default 0,
                                                  v_GROUPFLAG        INTEGER default 0,
                                                  v_WARDID           VARCHAR2 default '',
                                                  v_DEPTID           VARCHAR2 default '',
                                                  v_TYPEDOCTOR       VARCHAR2 default '',
                                                  v_TYPEDATE         CHAR default '',
                                                  v_AUDITOR          VARCHAR2 default '',
                                                  v_DATEOFAUDIT      CHAR default '',
                                                  v_EXECUTOR         VARCHAR2 default '',
                                                  v_EXECUTEDATE      CHAR default '',
                                                  v_CANCELDOCTOR     VARCHAR2 default '',
                                                  v_CANCELDATE       CHAR default '',
                                                  v_STARTDATE        CHAR default '',
                                                  v_PRODUCTNO        NUMBER default 0,
                                                  v_NORMNO           NUMBER default 0,
                                                  v_MEDICINENO       NUMBER default 0,
                                                  v_DRUGNO           VARCHAR2 default '',
                                                  v_DRUGNAME         VARCHAR2 default '',
                                                  v_DRUGNORM         VARCHAR2 default '',
                                                  v_ITEMTYPE         INTEGER default 0,
                                                  v_MINUNIT          VARCHAR2 default '',
                                                  v_DRUGDOSE         NUMBER default 0,
                                                  v_DOSEUNIT         VARCHAR2 default '',
                                                  v_UNITRATE         NUMBER default 0,
                                                  v_UNITTYPE         INTEGER default 0,
                                                  v_DRUGUSE          VARCHAR2 default '',
                                                  v_BATCHNO          VARCHAR2 default '',
                                                  v_EXECUTECOUNT     INTEGER default 1,
                                                  v_EXECUTECYCLE     INTEGER default 1,
                                                  v_CYCLEUNIT        INTEGER default -1,
                                                  v_DATEOFWEEK       CHAR default (''),
                                                  v_INNEREXECUTETIME VARCHAR2 default '',
                                                  v_ZXTS             INTEGER default 0,
                                                  v_TOTALDOSE        NUMBER default 0,
                                                  v_ENTRUST          VARCHAR2 default '',
                                                  v_ORDERTYPE        INTEGER default 0,
                                                  v_ORDERSTATUS      INTEGER default 0,
                                                  v_SPECIALMARK      INTEGER default 0,
                                                  v_CEASEID          NUMBER default 0,
                                                  v_CEASEDATE        CHAR default '',
                                                  v_CONTENT          VARCHAR2 default '',
                                                  v_SYNCH            INTEGER default '',
                                                  v_MEMO             VARCHAR2 default '',
                                                  v_FORMTYPE         VARCHAR2 default '') as
begin
  --添加
  if v_EditType = '1' then
    insert into TEMP_ORDER
      (TEMPID,
       NOOFINPAT,
       GROUPID,
       GROUPFLAG,
       WARDID,
       DEPTID,
       TYPEDOCTOR,
       TYPEDATE,
       AUDITOR,
       DATEOFAUDIT,
       EXECUTOR,
       EXECUTEDATE,
       CANCELDOCTOR,
       CANCELDATE,
       STARTDATE,
       PRODUCTNO,
       NORMNO,
       MEDICINENO,
       DRUGNO,
       DRUGNAME,
       DRUGNORM,
       ITEMTYPE,
       MINUNIT,
       DRUGDOSE,
       DOSEUNIT,
       UNITRATE,
       UNITTYPE,
       DRUGUSE,
       BATCHNO,
       EXECUTECOUNT,
       EXECUTECYCLE,
       CYCLEUNIT,
       DATEOFWEEK,
       INNEREXECUTETIME,
       ZXTS,
       TOTALDOSE,
       ENTRUST,
       ORDERTYPE,
       ORDERSTATUS,
       SPECIALMARK,
       CEASEID,
       CEASEDATE,
       CONTENT,
       SYNCH,
       MEMO,
       FORMTYPE)
    values
      (seq_temp_order_id.nextval,
       v_NOOFINPAT,
       v_GROUPID,
       v_GROUPFLAG,
       v_WARDID,
       v_DEPTID,
       v_TYPEDOCTOR,
       v_TYPEDATE, --时间
       v_AUDITOR,
       v_DATEOFAUDIT,
       v_EXECUTOR,
       v_EXECUTEDATE, --时间
       v_CANCELDOCTOR,
       v_CANCELDATE, --时间
       v_STARTDATE, --时间
       v_PRODUCTNO,
       v_NORMNO,
       v_MEDICINENO,
       v_DRUGNO,
       v_DRUGNAME,
       v_DRUGNORM,
       v_ITEMTYPE,
       v_MINUNIT,
       v_DRUGDOSE,
       v_DOSEUNIT,
       v_UNITRATE,
       v_UNITTYPE,
       v_DRUGUSE,
       v_BATCHNO,
       v_EXECUTECOUNT,
       v_EXECUTECYCLE,
       v_CYCLEUNIT,
       v_DATEOFWEEK,
       v_INNEREXECUTETIME, --时间
       v_ZXTS,
       v_TOTALDOSE,
       v_ENTRUST,
       v_ORDERTYPE,
       v_ORDERSTATUS,
       v_SPECIALMARK,
       v_CEASEID,
       v_CEASEDATE, --时间
       v_CONTENT,
       v_SYNCH,
       v_MEMO,
       v_FORMTYPE);
    --修改
  elsif v_EditType = '2' then
    update TEMP_ORDER
       set NOOFINPAT        = nvl(v_NOOFINPAT, NOOFINPAT),
           GROUPID          = nvl(v_GROUPID, GROUPID),
           GROUPFLAG        = nvl(v_GROUPFLAG, GROUPFLAG),
           WARDID           = nvl(v_WARDID, WARDID),
           DEPTID           = nvl(v_DEPTID, DEPTID),
           TYPEDOCTOR       = nvl(v_TYPEDOCTOR, TYPEDOCTOR),
           TYPEDATE         = nvl(v_TYPEDATE, TYPEDATE), --时间
           AUDITOR          = nvl(v_AUDITOR, AUDITOR),
           DATEOFAUDIT      = nvl(v_DATEOFAUDIT, DATEOFAUDIT),
           EXECUTOR         = nvl(v_EXECUTOR, EXECUTOR),
           EXECUTEDATE      = nvl(v_EXECUTEDATE, EXECUTEDATE), --时间
           CANCELDOCTOR     = nvl(v_CANCELDOCTOR, CANCELDOCTOR),
           CANCELDATE       = nvl(v_CANCELDATE, CANCELDATE), --时间
           STARTDATE        = nvl(v_STARTDATE, STARTDATE), --时间
           PRODUCTNO        = nvl(v_PRODUCTNO, PRODUCTNO),
           NORMNO           = nvl(v_NORMNO, NORMNO),
           MEDICINENO       = nvl(v_MEDICINENO, MEDICINENO),
           DRUGNO           = nvl(v_DRUGNO, DRUGNO),
           DRUGNAME         = nvl(v_DRUGNAME, DRUGNAME),
           DRUGNORM         = nvl(v_DRUGNORM, DRUGNORM),
           ITEMTYPE         = nvl(v_ITEMTYPE, ITEMTYPE),
           MINUNIT          = nvl(v_MINUNIT, MINUNIT),
           DRUGDOSE         = nvl(v_DRUGDOSE, DRUGDOSE),
           DOSEUNIT         = nvl(v_DOSEUNIT, DOSEUNIT),
           UNITRATE         = nvl(v_UNITRATE, UNITRATE),
           UNITTYPE         = nvl(v_UNITTYPE, UNITTYPE),
           DRUGUSE          = nvl(v_DRUGUSE, DRUGUSE),
           BATCHNO          = nvl(v_BATCHNO, BATCHNO),
           EXECUTECOUNT     = nvl(v_EXECUTECOUNT, EXECUTECOUNT),
           EXECUTECYCLE     = nvl(v_EXECUTECYCLE, EXECUTECYCLE),
           CYCLEUNIT        = nvl(v_CYCLEUNIT, CYCLEUNIT),
           DATEOFWEEK       = nvl(v_DATEOFWEEK, DATEOFWEEK),
           INNEREXECUTETIME = nvl(v_INNEREXECUTETIME, INNEREXECUTETIME), --时间
           ZXTS             = nvl(v_ZXTS, ZXTS),
           TOTALDOSE        = nvl(v_TOTALDOSE, TOTALDOSE),
           ENTRUST          = nvl(v_ENTRUST, ENTRUST),
           ORDERTYPE        = nvl(v_ORDERTYPE, ORDERTYPE),
           ORDERSTATUS      = nvl(v_ORDERSTATUS, ORDERSTATUS),
           SPECIALMARK      = nvl(v_SPECIALMARK, SPECIALMARK),
           CEASEID          = nvl(v_CEASEID, CEASEID),
           CEASEDATE        = nvl(v_CEASEDATE, CEASEDATE), --时间
           CONTENT          = nvl(v_CONTENT, CONTENT),
           SYNCH            = nvl(v_SYNCH, SYNCH),
           MEMO             = nvl(v_MEMO, MEMO),
           FORMTYPE         = nvl(v_FORMTYPE, FORMTYPE)
     where TEMPID = v_TEMPID;
    --删除
  elsif v_EditType = '3' then
    delete TEMP_ORDER where TEMPID = v_TEMPID;
    --查看
  elsif v_EditType = '4' then
    select * from TEMP_ORDER where TEMPID = v_TEMPID;
  end if;
end;
/

prompt
prompt Creating procedure USP_EDITFAMILYHISTORYINFO
prompt ============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_EditFamilyHistoryInfo(v_EditType  varchar, --编辑信息类型：1：添加、2：修改、3：删除
                                                      v_ID        numeric, --联系人编号，是病人联系人的唯一标识
                                                      v_NoOfInpat numeric default '-1', --首页序号(住院流水号)(Inpatient.NoOfInpat)
                                                      v_Relation  varchar default '', --家族关系
                                                      v_Birthday  varchar default '', --出生日期（在前台显示年龄）
                                                      v_DiseaseID varchar default '', --病种代码
                                                      v_Breathing int default '', --是否健在(1:是：0否)
                                                      v_Cause     varchar default '', --死亡原因
                                                      v_Memo      varchar default '' --备注
                                                      ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  编辑家族信息
   功能说明
   输入参数
   输出参数
   结果集、排序
  
   exec usp_EditFamilyHistoryInfo v_EditType='3',v_ID='5'
  
   调用的sp
   调用实例
  
   修改记录
  **********/

begin

  if v_EditType = '1' then
  
    --添加
    insert into FamilyHistory
      (NoOfInpat, Relation, Birthday, DiseaseID, Breathing, Cause, Memo)
    values
      (v_NoOfInpat,
       v_Relation,
       v_Birthday,
       v_DiseaseID,
       v_Breathing,
       v_Cause,
       v_Memo);
  
  elsif v_EditType = '2' then
  
    --修改
    update FamilyHistory
       set NoOfInpat = v_NoOfInpat,
           Relation  = v_Relation,
           Birthday  = v_Birthday,
           DiseaseID = v_DiseaseID,
           Breathing = v_Breathing,
           Cause     = v_Cause,
           Memo      = v_Memo
     where ID = v_ID;
  
  elsif v_EditType = '3' then
  
    --删除
    delete FamilyHistory where ID = v_ID;
  end if;

end;
/

prompt
prompt Creating procedure USP_EDITILLNESSHISTORYINFO
prompt =============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_EditIllnessHistoryInfo(v_EditType     varchar, --编辑信息类型：1：添加、2：修改、3：删除
                                                       v_ID           numeric, --唯一列
                                                       v_NoOfInpat    numeric default '-1', --病人首页序号
                                                       v_DiagnosisICD varchar default '', --病种代码
                                                       v_Discuss      varchar default '', --疾病评论
                                                       v_DiseaseTime  varchar default '', --病发时间
                                                       v_Cure         int default '', --是否治愈
                                                       v_Memo         varchar default '' --备注
                                                       ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  编辑疾病史信息
   功能说明
   输入参数
   输出参数
   结果集、排序
  
   调用的sp
   调用实例
  
   修改记录
  **********/

begin

  if v_EditType = '1' then
  
    --添加
    insert into IllnessHistory
      (NoOfInpat, DiagnosisICD, Discuss, DiseaseTime, Cure, Memo)
    values
      (v_NoOfInpat,
       v_DiagnosisICD,
       v_Discuss,
       v_DiseaseTime,
       v_Cure,
       v_Memo);
  
  elsif v_EditType = '2' then
  
    --修改
    update IllnessHistory
       set NoOfInpat    = v_NoOfInpat,
           DiagnosisICD = v_DiagnosisICD,
           Discuss      = v_Discuss,
           DiseaseTime  = v_DiseaseTime,
           Cure         = v_Cure,
           Memo         = v_Memo
     where ID = v_ID;
  
  elsif v_EditType = '3' then
  
    --删除
    delete IllnessHistory where ID = v_ID;
  end if;

end;
/

prompt
prompt Creating procedure USP_EDITNOTESONNURSINGINFO
prompt =============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_EditNotesOnNursingInfo(v_NoOfInpat        numeric, --首页序号(住院流水号)
                                                       v_DateOfSurvey     varchar, --测量日期期（格式2010-01-01）
                                                       v_TimeSlot         varchar, --测量时间段
                                                       v_Temperature      varchar default '', --患者体温
                                                       v_WayOfSurvey      int default 8800, --体温测量方式代码
                                                       v_Pulse            varchar default '', --脉搏
                                                       v_HeartRate        varchar default '', --心率
                                                       v_Breathe          varchar default '', --患者呼吸
                                                       v_BloodPressure    varchar default '', --患者血压
                                                       v_TimeOfShit       varchar default '', --大便次数，格式：1*(3/2E ),'*'表示大便失禁
                                                       v_CountIn          varchar default '', --患者总入量
                                                       v_CountOut         varchar default '', --患者总出量
                                                       v_Drainage         varchar default '', --引流量
                                                       v_Height           varchar default '', --患者身高
                                                       v_Weight           varchar default '', --患者体重
                                                       v_Allergy          varchar default '', --患者过敏物
                                                       v_DaysAfterSurgery varchar default '', --手术后日数
                                                       v_DayOfHospital    varchar default '', --住院天数
                                                       v_PhysicalCooling  varchar default '', --物理降温
                                                       v_DoctorOfRecord   varchar --记录医生
                                                       ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  保存护理信息数据
   功能说明
   输入参数
   输出参数
   结果集、排序
  
  
   调用的sp
   调用实例
  
   修改记录
  **********/

begin

  --删除原数据
  delete NotesOnNursing
   where DateOfSurvey = v_DateOfSurvey
     and TimeSlot = v_TimeSlot;

  --保存护理信息数据
  insert into NotesOnNursing
    (NoOfInpat,
     DateOfSurvey,
     Temperature,
     WayOfSurvey,
     Pulse,
     HeartRate,
     Breathe,
     TimeSlot,
     BloodPressure,
     TimeOfShit,
     CountIn,
     CountOut,
     Drainage,
     Height,
     Weight,
     Allergy,
     DaysAfterSurgery,
     DayOfHospital,
     PhysicalCooling,
     DoctorOfRecord)
  values
    (v_NoOfInpat,
     v_DateOfSurvey,
     v_Temperature,
     v_WayOfSurvey,
     v_Pulse,
     v_HeartRate,
     v_Breathe,
     v_TimeSlot,
     v_BloodPressure,
     v_TimeOfShit,
     v_CountIn,
     v_CountOut,
     v_Drainage,
     v_Height,
     v_Weight,
     v_Allergy,
     v_DaysAfterSurgery,
     v_DayOfHospital,
     v_PhysicalCooling,
     v_DoctorOfRecord);

end;
/

prompt
prompt Creating procedure USP_EDITPATIENTCONTACTS
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_EditPatientContacts(v_EditType   varchar, --编辑信息类型：1：添加、2：修改、3：删除
                                                    v_ID         numeric default '0', --联系人编号，是病人联系人的唯一标识
                                                    v_NoOfInpat  numeric default '0', --首页序号(住院流水号)(Inpatient.NoOfInpat)
                                                    v_Name       varchar default '', --联系人名
                                                    v_Sex        varchar default '', --性别
                                                    v_Relation   varchar default '', --联系关系(Dictionary_detail.DetailID, ID = '44')
                                                    v_Address    varchar default '', --联系地址
                                                    v_WorkUnit   varchar default '', --联系(人)单位
                                                    v_HomeTel    varchar default '', --联系人家庭电话
                                                    v_WorkTel    varchar default '', --联系人工作电话
                                                    v_PostalCode varchar default '', --联系邮编
                                                    v_Tag        varchar default '' --联系人标志
                                                    ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  编辑第一联系人信息
   功能说明
   输入参数
   输出参数
   结果集、排序
  
  
   调用的sp
   调用实例
   exec usp_EditPatientContacts v_EditType='1',v_ID='0',v_NoOfInpat='75278',v_Name='李琼',v_Sex='2'
   ,v_Relation='05',v_Address='南京市浦口区雨山西路江浦街道',v_WorkUnit='南京市浦口区农业银行'
   ,v_HomeTel='15851867666',v_WorkTel='3422937293',v_PostalCode='3402334',v_Tag='0'
   修改记录
  **********/

begin

  if v_EditType = '1' then
  
    --添加
    insert into PatientContacts
      (NoOfInpat,
       Name,
       Sex,
       Relation,
       Address,
       WorkUnit,
       HomeTel,
       WorkTel,
       PostalCode,
       Tag)
    values
      (v_NoOfInpat,
       v_Name,
       v_Sex,
       v_Relation,
       v_Address,
       v_WorkUnit,
       v_HomeTel,
       v_WorkTel,
       v_PostalCode,
       v_Tag);
  
  elsif v_EditType = '2' then
  
    --修改
    update PatientContacts
       set Name       = v_Name,
           Sex        = v_Sex,
           Relation   = v_Relation,
           Address    = v_Address,
           WorkUnit   = v_WorkUnit,
           HomeTel    = v_HomeTel,
           WorkTel    = v_WorkTel,
           PostalCode = v_PostalCode,
           Tag        = v_Tag
     where ID = v_ID;
  
  elsif v_EditType = '3' then
  
    --删除
    delete PatientContacts where ID = v_ID;
  end if;

end;
/

prompt
prompt Creating procedure USP_EDITPERSONALHISTORYINFO
prompt ==============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_EditPersonalHistoryInfo(v_NoOfInpat    numeric, --病人首页序号
                                                        v_Marital      varchar, --婚姻状况
                                                        v_NoOfChild    int, --孩子数量
                                                        v_JobHistory   varchar, --职业经历
                                                        v_DrinkWine    int, --是否饮酒
                                                        v_WineHistory  varchar, --饮酒史
                                                        v_Smoke        int, --是否吸烟
                                                        v_SmokeHistory varchar, --吸烟史
                                                        v_BirthPlace   varchar, --出生地（省市）
                                                        v_PassPlace    varchar, --经历地（省市）
                                                        v_Memo         varchar default '' --备注
                                                        ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  编辑个人史信息
   功能说明
   输入参数
   输出参数
   结果集、排序
  
   调用的sp
   调用实例
  
   修改记录
  **********/

begin

  --删除当前记录
  delete PersonalHistory where NoOfInpat = v_NoOfInpat;
  --添加
  insert into PersonalHistory
    (NoOfInpat,
     Marital,
     NoOfChild,
     JobHistory,
     DrinkWine,
     WineHistory,
     Smoke,
     SmokeHistory,
     BirthPlace,
     PassPlace,
     Memo)
  values
    (v_NoOfInpat,
     v_Marital,
     v_NoOfChild,
     v_JobHistory,
     v_DrinkWine,
     v_WineHistory,
     v_Smoke,
     v_SmokeHistory,
     v_BirthPlace,
     v_PassPlace,
     v_Memo);

end;
/

prompt
prompt Creating procedure USP_EDITSURGERYHISTORYINFO
prompt =============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_EditSurgeryHistoryInfo(v_EditType    varchar, --编辑信息类型：1：添加、2：修改、3：删除
                                                       v_ID          numeric, --唯一列
                                                       v_NoOfInpat   numeric default '-1', --病人首页序号
                                                       v_SurgeryID   varchar default '', --手术代码(Surgery.ID)
                                                       v_DiagnosisID varchar default '', --疾病（Diagnosis.ICD）
                                                       v_Discuss     varchar default '', --评论
                                                       v_Doctor      varchar default '', --手术医生
                                                       v_Memo        varchar default '' --备注
                                                       ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  编辑手术史信息
   功能说明
   输入参数
   输出参数
   结果集、排序
  
   调用的sp
   调用实例
  
   修改记录
  **********/

begin

  if v_EditType = '1' then
  
    --添加
    insert into SurgeryHistory
      (NoOfInpat, SurgeryID, DiagnosisID, Discuss, Doctor, Memo)
    values
      (v_NoOfInpat,
       v_SurgeryID,
       v_DiagnosisID,
       v_Discuss,
       v_Doctor,
       v_Memo);
  
  elsif v_EditType = '2' then
  
    --修改
    update SurgeryHistory
       set NoOfInpat   = v_NoOfInpat,
           SurgeryID   = v_SurgeryID,
           DiagnosisID = v_DiagnosisID,
           Discuss     = v_Discuss,
           Doctor      = v_Doctor,
           Memo        = v_Memo
     where ID = v_ID;
  
  elsif v_EditType = '3' then
  
    --删除
    delete SurgeryHistory where ID = v_ID;
  end if;

end;
/

prompt
prompt Creating procedure USP_EDITUCVITALSIGNSRECORDINFO
prompt =================================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_EditUCVitalSignsRecordInfo
(
    v_Type               int,              --操作类型，1：保存，2：存档，3：作废
    v_ID                 numeric default '0',--记录序号（自动生成）
    v_NoOfInpat          numeric default '0',--首页序号(住院流水号)
    v_DateOfSurvey       varchar default '',    --测量日期期
    v_TimeSlot           varchar default '',    --测量时间段
    v_StatusOfInpat      int     default 0,            --患者状态代码
    v_Temperature        varchar default '',    --患者体温
    v_WayOfSurvey        int     default 0 ,        --体温测量方式代码
    v_Assist             int     default 0 ,           --体温测量辅助措施代码
    v_Pulse              varchar default '' ,  --脉搏
    v_HeartRate          varchar default '' ,  --心率
    v_IsPacemaker        int     default 0,        --起搏器 0-无，1-使用
    v_Breathe            varchar default '' ,  --患者呼吸
    v_IsRespirator       int     default 0,        --呼吸器 0-无，1-使用
    v_BloodPressure      varchar default '',    --患者血压
    v_Cause              int     default 0  ,      --未测量原因代码
    v_CauseMemo          varchar default '',  --未测量愿因说明
    v_IsOnFile           int     default 0,            --是否存档，0未存档，1存档
    v_DoctorOfRecord     varchar default '',    --登记医生ID
    v_DoctorOfCancel     varchar default ''    --作废人员ID
    )
as

/**********
 版本号  1.0.0.0.0
 创建时间
 作者
 版权
 描述  生命体征记录保存、存档和作废
 功能说明
 输入参数
 输出参数
 结果集、排序


 调用的sp
 调用实例

 修改记录
**********/

begin

    if v_Type='1' then

     --保存生命体征记录
     insert into VitalSignsRecord (NoOfInpat,DateOfSurvey,TimeSlot,StatusOfInpat,Temperature,WayOfSurvey,Assist,
        Pulse,HeartRate,IsPacemaker,Breathe,IsRespirator,BloodPressure,Cause,CauseMemo,DoctorOfRecord)
     values(v_NoOfInpat,v_DateOfSurvey,v_TimeSlot,v_StatusOfInpat,v_Temperature,v_WayOfSurvey,v_Assist,
        v_Pulse,v_HeartRate,v_IsPacemaker,v_Breathe,v_IsRespirator,v_BloodPressure,v_Cause,v_CauseMemo,v_DoctorOfRecord);

    elsif v_Type='2' then

        --生命体征记录存档
        update VitalSignsRecord set IsOnFile=1  where ID in(v_ID);

    elsif v_Type='3' then

        --生命体征记录作废
        update VitalSignsRecord
        set DateOfCancel=to_char(sysdate,'yyyy-mm-dd hh24:mi:ss')
           ,DoctorOfCancel=v_DoctorOfCancel
        where ID in(v_ID);

        end if;


end  ;
/

prompt
prompt Creating procedure USP_EDIT_DIAGNOSIS
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_Edit_Diagnosis(v_EditType      varchar default '', --操作类型
                                               v_MarkId        varchar default '',
                                               v_ICD           varchar default '',
                                               v_MapID         varchar default '',
                                               v_StandardCode  varchar default '',
                                               v_Name          varchar default '',
                                               v_Py            varchar default '',
                                               v_Wb            varchar default '',
                                               v_TumorID       varchar default '',
                                               v_Statist       varchar default '',
                                               v_InnerCategory varchar default '',
                                               v_Category      varchar default '',
                                               v_OtherCategroy int default '',
                                               v_Valid         int default 1,
                                               v_Memo          varchar default '') as
/*
Diagnosis  诊断库    
*/
begin
  --添加
  if v_EditType = '1' then
  
    INSERT INTO Diagnosis
      (MarkId,
       ICD,
       MapID,
       StandardCode,
       Name,
       Py,
       Wb,
       TumorID,
       Statist,
       InnerCategory,
       Category,
       OtherCategroy,
       Valid,
       Memo)
    VALUES
      (v_MarkId,
       v_ICD,
       v_MapID,
       v_StandardCode,
       v_Name,
       v_Py,
       v_Wb,
       v_TumorID,
       v_Statist,
       v_InnerCategory,
       v_Category,
       v_OtherCategroy,
       v_Valid,
       v_Memo);
  
    --修改
  elsif v_EditType = '2' then
  
    UPDATE Diagnosis
       SET ICD           = nvl(v_ICD, ICD),
           MapID         = nvl(v_MapID, MapID),
           StandardCode  = nvl(v_StandardCode, StandardCode),
           Name          = nvl(v_Name, Name),
           Py            = nvl(v_Py, Py),
           Wb            = nvl(v_Wb, Wb),
           TumorID       = nvl(v_TumorID, TumorID),
           Statist       = nvl(v_Statist, Statist),
           InnerCategory = nvl(v_InnerCategory, InnerCategory),
           Category      = nvl(v_Category, Category),
           OtherCategroy = nvl(v_OtherCategroy, OtherCategroy),
           Valid         = nvl(v_Valid, Valid),
           Memo          = nvl(v_Memo, Memo)
     WHERE MarkId = v_MarkId;
  
    --删除
  elsif v_EditType = '3' then
  
    delete Diagnosis where MarkId = v_MarkId;
  
    --查询
    /*  elsif v_EditType = '4' then
    select * from Diagnosis a where a.MarkId = v_MarkId;*/
  end if;

end;
/

prompt
prompt Creating procedure USP_EDIT_DIAGNOSISOFCHINESE
prompt ==============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_Edit_DiagnosisOfChinese(v_EditType varchar default '', --操作类型
                                                        v_ID       varchar default '',
                                                        v_MapID    varchar default '',
                                                        v_Name     varchar default '',
                                                        v_Py       varchar default '',
                                                        v_Wb       varchar default '',
                                                        v_Valid    int default 1,
                                                        v_Memo     varchar default '',
                                                        v_Memo1    varchar default '',
                                                        v_Category varchar default '') as

/*
DiagnosisOfChinese     中医诊断库 
*/
begin
  --添加
  if v_EditType = '1' then
  
    INSERT INTO DiagnosisOfChinese
      (ID, MapID, Name, Py, Wb, Valid, Memo, Memo1, Category)
    VALUES
      (v_ID,
       v_MapID,
       v_Name,
       v_Py,
       v_Wb,
       v_Valid,
       v_Memo,
       v_Memo1,
       v_Category);
  
    --修改
  elsif v_EditType = '2' then
  
    UPDATE DiagnosisOfChinese
       SET MapID    = nvl(v_MapID,MapID),
           Name     = nvl(v_Name,Name),
           Py       = nvl(v_Py,Py),
           Wb       = nvl(v_Wb,Wb),
           Valid    = nvl(v_Valid,Valid),
           Memo     = nvl(v_Memo,Memo),
           Memo1    = nvl(v_Memo1,Memo1),
           Category = nvl(v_Category,Category)
     WHERE ID = v_ID;
  
    --删除
  elsif v_EditType = '3' then
  
    delete DiagnosisOfChinese where ID = v_ID;
  
    --查询
    /*  elsif v_EditType = '4' then
    select * from DiagnosisOfChinese a where ID = v_ID;*/
  end if;

end;
/

prompt
prompt Creating procedure USP_EDIT_DISEASECFG
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_Edit_DiseaseCFG(v_EditType  varchar default '', --操作类型
                                                v_ID        varchar default '',
                                                v_MapID     varchar default '',
                                                v_Name      varchar default '',
                                                v_Py        varchar default '',
                                                v_Wb        varchar default '',
                                                v_DiseaseID varchar default '',
                                                v_SurgeryID varchar default '',
                                                v_Category  int default '',
                                                v_Mark      varchar default '',
                                                v_ParentID  varchar default '',
                                                v_Valid     int default 1,
                                                v_Memo      varchar default '') as
  /*
  DiseaseCFG  病种设置库      
  */
begin
  --添加
  if v_EditType = '1' then
  
    INSERT INTO DiseaseCFG
      (ID,
       MapID,
       Name,
       Py,
       Wb,
       DiseaseID,
       SurgeryID,
       Category,
       Mark,
       ParentID,
       Valid,
       Memo)
    VALUES
      (v_ID,
       v_MapID,
       v_Name,
       v_Py,
       v_Wb,
       v_DiseaseID,
       v_SurgeryID,
       v_Category,
       v_Mark,
       v_ParentID,
       v_Valid,
       v_Memo);
  
    --修改
  elsif v_EditType = '2' then
  
    UPDATE DiseaseCFG
       SET MapID     = nvl(v_MapID, MapID),
           Name      = nvl(v_Name, Name),
           Py        = nvl(v_Py, Py),
           Wb        = nvl(v_Wb, Wb),
           DiseaseID = nvl(v_DiseaseID, DiseaseID),
           SurgeryID = nvl(v_SurgeryID, SurgeryID),
           Category  = nvl(v_Category, Category),
           Mark      = nvl(v_Mark, MapID),
           ParentID  = nvl(v_ParentID, MapID),
           Valid     = nvl(v_Valid, Valid),
           Memo      = nvl(v_Memo, MapID)
     WHERE ID = v_ID;
 
  
    --删除
  elsif v_EditType = '3' then
  
    delete DiseaseCFG where ID = v_ID;
  
    --查询
    /*  elsif v_EditType = '4' then
    select * from DiseaseCFG a where a.ID = v_ID;*/
  end if;

end;
/

prompt
prompt Creating procedure USP_EDIT_SURGERY
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_Edit_Surgery(v_EditType     varchar default '', --操作类型
                                             v_ID           varchar default '',
                                             v_MapID        varchar default '',
                                             v_StandardCode varchar default '',
                                             v_Name         varchar default '',
                                             v_Py           varchar default '',
                                             v_Wb           varchar default '',
                                             v_Valid        int default 1,
                                             v_Memo         varchar default '',
                                             v_bzlb         varchar default '',
                                             v_sslb         int default '') as
  /*
  Surgery  手术代码库     
  */
begin
  --添加
  if v_EditType = '1' then
  
    INSERT INTO Surgery
      (ID, MapID, StandardCode, Name, Py, Wb, Valid, Memo, bzlb, sslb)
    VALUES
      (v_ID,
       v_MapID,
       v_StandardCode,
       v_Name,
       v_Py,
       v_Wb,
       v_Valid,
       v_Memo,
       v_bzlb,
       v_sslb);
  
    --修改
  elsif v_EditType = '2' then
    UPDATE Surgery
       SET MapID        = nvl(v_MapID, MapID),
           StandardCode = nvl(v_StandardCode, StandardCode),
           Name         = nvl(v_Name, Name),
           Py           = nvl(v_Py, Py),
           Wb           = nvl(v_Wb, Wb),
           Valid        = nvl(v_Valid, Valid),
           Memo         = nvl(v_Memo, Memo),
           bzlb         = nvl(v_bzlb, bzlb),
           sslb         = nvl(v_sslb, sslb)
     WHERE ID = v_ID;

    --删除
  elsif v_EditType = '3' then
  
    delete Surgery where ID = v_ID;
  
    --查询
    /*  elsif v_EditType = '4' then
    select * from Surgery a where a.ID = v_ID;*/
  end if;

end;
/

prompt
prompt Creating procedure USP_EDIT_TOXICOSIS
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_Edit_Toxicosis(v_EditType     varchar default '', --操作类型
                                               v_ID           varchar default '',
                                               v_MapID        varchar default '',
                                               v_StandardCode varchar default '',
                                               v_Name         varchar default '',
                                               v_Py           varchar default '',
                                               v_Wb           varchar default '',
                                               v_Valid        int default 1,
                                               v_Memo         varchar default '') as
  /*
  Toxicosis  损伤中毒库      
  */
begin
  --添加
  if v_EditType = '1' then
  
    INSERT INTO Toxicosis
      (ID, MapID, StandardCode, Name, Py, Wb, Valid, Memo)
    VALUES
      (v_ID, v_MapID, v_StandardCode, v_Name, v_Py, v_Wb, v_Valid, v_Memo);
  
    --修改
  elsif v_EditType = '2' then
  
    UPDATE Toxicosis
       set MapID        = nvl(v_MapID, MapID),
           StandardCode = nvl(v_StandardCode, StandardCode),
           Name         = nvl(v_Name, Name),
           Py           = nvl(v_Py, Py),
           Wb           = nvl(v_Wb, Wb),
           Valid        = nvl(v_Valid, Valid),
           Memo         = nvl(v_Memo, Memo)
     WHERE MapID = v_MapID;
  
    --删除
  elsif v_EditType = '3' then
  
    delete Toxicosis where MapID = v_MapID;
  
    --查询
    /*  elsif v_EditType = '4' then
    select * from Toxicosis a where a.MapID = v_MapID;*/
  end if;

end;
/

prompt
prompt Creating procedure USP_EDIT_TUMOR
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_Edit_Tumor(v_EditType     varchar default '', --操作类型
                                           v_ID           varchar default '',
                                           v_MapID        varchar default '',
                                           v_StandardCode varchar default '',
                                           v_Name         varchar default '',
                                           v_Py           varchar default '',
                                           v_Wb           varchar default '',
                                           v_Valid        int default 1,
                                           v_Memo         varchar default '') as
  /*
  Tumor  肿瘤库     
  */
begin
  --添加
  if v_EditType = '1' then
  
    INSERT INTO Tumor
      (ID, MapID, StandardCode, Name, Py, Wb, Valid, Memo)
    VALUES
      (v_ID, v_MapID, v_StandardCode, v_Name, v_Py, v_Wb, v_Valid, v_Memo);
  
    --修改
  elsif v_EditType = '2' then
  
    UPDATE Tumor
       SET MapID        = nvl(v_MapID, MapID),
           StandardCode = nvl(v_StandardCode, StandardCode),
           Name         = nvl(v_Name, Name),
           Py           = nvl(v_Py, Py),
           Wb           = nvl(v_Wb, Wb),
           Valid        = nvl(v_Valid, Valid),
           Memo         = nvl(v_Memo, Memo)
     WHERE ID = v_ID;
  
    --删除
  elsif v_EditType = '3' then
  
    delete Tumor where ID = v_ID;
  
    --查询
    /*  elsif v_EditType = '4' then
    select * from Tumor a where a.ID = v_ID;*/
  end if;

end;
/

prompt
prompt Creating procedure USP_EMR_CALCAGE
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_Emr_CalcAge(v_csrq varchar,
                                            v_dqrq varchar,
                                            v_sjnl out int,
                                            v_xsnl out varchar) as
  v_date3    varchar(24);
  v_date4    varchar(24);
  v_yy       int;
  v_mm       int;
  v_dd       int;
  v_hh       int;
  v_mi       int;
  v_tempdate varchar(24);
  v_decmm    int;
  v_decyy    int;
  v_dechh    int;
  v_decmi    int;
  /**********
   版本号  1.0.0.0.0
   创建时间  2010.8.10
   作者  周辉
   版权
   描述  计算病人年龄
   功能说明
    根据病案统计的要求，计算病人的精确年龄以及用来显示的年龄。
    对于婴幼儿患者，如果年龄只是笼统的几岁，则不能满足临床和统计分析的需要。
   输入参数
     v_csrq varchar(24)Time  --出生日期
    ,v_dqrq varchar(24)Time  --当前日期(截至到此日期的年龄)
    ,v_sjnl int = null output  --计算后的准确年龄(格式为YYYYMMDD,YYYY表示年的数值,MM表示月的数值,DD表示日的数值)
    ,v_xsnl varchar(16) = null output  --显示年龄(根据实际情况显示的年龄,如XXX年,XX月XX天,XX天)
   输出参数
   修改
  
      妇幼保健院新生儿科需求——出生时间在2小时以内的病人，年龄精确到分钟，出生日期在48小时以内的病人，年龄精确到小时。
   结果集、排序
   调用的sp
   调用实例
    declare v_csrq varchar(24), v_dqrq varchar(24), v_sjnl int, v_xsnl varchar(16)
    select v_csrq = '1978-08-01', v_dqrq = '1978-09-01'
    exec usp_EmrCalcAge v_csrq, v_dqrq, v_sjnl output, v_xsnl output
    select v_sjnl, v_xsnl
  **********/
begin

  --select v_date3 = substring(v_csrq, 1, 10)
  --  , v_date4 = substring(v_dqrq, 1, 10)
  v_date3 := substr(v_csrq, 1, 16);
  v_date4 := substr(v_dqrq, 1, 16);

  if (isdate(v_date3) <> 1) or (isdate(v_date4) <> 1) or
     (v_date3 > v_date4) then
    begin
      v_sjnl := 0;
      v_xsnl := '';
      return;
    end;
  end if;

  v_decmm := 0;
  v_decyy := 0;
  v_dechh := 0;
  v_decmi := 0;
  -- 分钟
  if to_char(v_date4,'mi') >= to_char(v_date3,'mi') then
    v_mi := to_char(v_date4,'mi') - to_char(v_date3,'mi');
  else
    begin
      v_decmi := 1;
      v_mi    := to_char(v_date4,'mi') + 60 - to_char(v_date3,'mi');
    end;
  end if;
  --小时
  if (to_char(v_date4,'hh') - v_decmi) >= to_char(v_date3,'hh') then
    v_hh := to_char(v_date4,'hh') - v_decmi - to_char(v_date3,'hh');
  else
    begin
      v_dechh := 1;
      v_hh    := to_char(v_date4,'hh') - v_decmi + 24 -
                 to_char(v_date3,'hh');
    
    end;
  end if;
  --天
  if (to_char(v_date4,'dd') - v_dechh) >= to_char(v_date3,'dd') then
    v_dd := to_char(v_date4,'dd') - v_dechh - to_char(v_date3,'dd');
  else
    begin
      v_decmm := 1;
      v_dd    := to_char(v_date4,'dd') - v_dechh +
                 datediff('dd', v_date3, add_months(v_date3,1)) -
                 to_char(v_date3,'dd');
    
    end;
  end if;
  --月
  if (to_char(v_date4,'mm') - v_decmm) >= to_char(v_date3,'mm') then
    v_mm := to_char(v_date4,'mm') - v_decmm - to_char(v_date3,'mm');
  else
    begin
      v_decyy := 1;
      v_mm    := to_char(v_date4,'mm') - v_decmm + 12 - to_char(v_date3,'mm');
    end;
  end if;
  --年
  v_yy := datediff('yy', v_date3, v_date4) - v_decyy;

  v_sjnl := v_yy * 10000 + v_mm * 100 + v_dd;

  if v_yy > 1 then
    -- 2岁及以上的情况
    v_xsnl := to_char( v_yy) || '岁';
  elsif v_yy = 1 then
    v_xsnl := to_char(v_yy * 12 + v_mm) || '个月';
  elsif (v_mm > 1) or ((v_mm = 1) and (v_dd = 0)) then
    v_xsnl := to_char( v_mm) || '个月';
  elsif v_mm = 1 then
    v_xsnl := to_char(v_mm) || '个月' || to_char(v_dd) || '天';
  elsif v_dd > 1 then
    v_xsnl := to_char( v_dd) || '天';
  elsif v_dd = 1 then
    v_xsnl := to_char(v_dd * 24 + v_hh) || '个小时';
  elsif v_hh > 1 then
    v_xsnl := to_char(v_hh) || '个小时';
  elsif v_hh = 1 then
    v_xsnl := to_char(v_hh * 60 + v_mi) || '分钟';
  else
    v_xsnl := to_char( v_mi) || '分钟';
  end if;
  return;
end;
/

prompt
prompt Creating procedure USP_EMR_GETAGE
prompt =================================
prompt
create or replace procedure emr.usp_EMR_GetAge(v_csrq varchar,
                                   v_dqrq varchar,
                                   v_sjnl out int,
                                   v_xsnl out varchar) as
  d_csrq date;
  d_dqrq date;                                 

begin
  d_csrq := to_date(substr(v_csrq,1,10),'yyyy-mm-dd');
  d_dqrq := to_date(substr(v_dqrq,1,10),'yyyy-mm-dd');

  v_sjnl := TRUNC(Months_between(d_dqrq, d_csrq) / 12);
  v_xsnl := v_sjnl || '岁' /*||
            (TRUNC(d_dqrq) - ADD_MONTHS(d_csrq, v_sjnl * 12)) || '天'*/;


end usp_EMR_GetAge;
/

prompt
prompt Creating procedure USP_EMR_GETPATINFO
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE EMR.USP_EMR_GETPATINFO(v_NoOfinpat varchar) AS

begin

SELECT b.noofinpat  noofinpat, --首页序号
       b.patnoofhis patnoofhis, --HIS首页序号
       b.patid      patid,--住院号
       b.NAME   patname, --姓名
       b.sexid  sex, --病人性别
       b.sexid  sexname, --病人性别名称
       b.agestr agestr,--年龄
       b.birth birth, --生日
       b.py py, --拼音
       b.wb wb, --五笔
       b.status brzt, --病人状态
       e.NAME brztname, --病人状态名称
       RTRIM(b.criticallevel) wzjb, --危重级别
       i.NAME wzjbmc, --危重级别名称
       --case when PatID is null then ''
       --     else '一级护理'
       --end hljb --护理级别 名称
       cd.NAME hljb,
       CASE
         WHEN b.attendlevel IS NULL THEN
          6105
       END attendlevel, --护理级别
       b.isbaby yebz, --婴儿标志
       CASE
         WHEN b.isbaby = '0' THEN
          '否'
         WHEN b.isbaby IS NULL THEN
          ''
         ELSE
          '是'
       END yebzname,
       a.wardid bqdm, --病区代码
       a.deptid ksdm, --科室代码
       a.ID bedid, --床位代码
       dg.NAME ksmc,--科室名称
       wh.NAME        bqmc, --病区名称
       a.formerward   ybqdm, --原病区代码
       a.formerdeptid yksdm,--原科室代码
       a.formerdeptid ycwdm, --原床位代码
       a.inbed inbed, --占床标志
       a.borrow jcbz, --借床标志
       a.sexinfo cwlx, --床位类型
       SUBSTR(b.admitdate, 1, 16) admitdate,--入院日期
       f.NAME     ryzd, --入院诊断
       f.NAME     zdmc, --诊断名称
       b.resident zyysdm, --住院医生代码
       c.NAME     zyys,
       --住院医生
       c.NAME cwys, --床位医生
       g.NAME zzys, --主治医师
       h.NAME zrys, --主任医师
       a.valid yxjl, --有效记录
       me.pzlx pzlx, --凭证类型
       /*TO_CHAR((CASE
                 WHEN INSTR(v_deptids, a.deptid) = 0 AND (b.noofinpat IS NULL) THEN
                  '属于其它科室'
                 ELSE
                  ''
               END)) extra, --额外信息*/
       b.memo memo, --备注
       (CASE b.cpstatus
         WHEN 0 THEN
          '未引入'
         WHEN 1 THEN
          '执行中'
         WHEN 2 THEN
          '退出'
       END) cpstatus,
       CASE
         WHEN b.noofinpat IS NULL THEN
          ''
         ELSE
          '己书写'
       END recordinfo,
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
           AND qc.foulstate = 1) AS iswarn --是否违规
  FROM bed a
  LEFT JOIN inpatient b ON a.noofinpat = b.noofinpat
                       AND a.patnoofhis = b.patnoofhis
                       /*AND INSTR(v_deptids, RTRIM(b.outhosdept)) > 0*/
                       and a.deptid = b.outhosdept
                       AND a.inbed = 1301
                       AND b.status IN (1501, 1504, 1505, 1506, 1507)
  LEFT JOIN categorydetail e ON b.status = e.ID
                            AND e.categoryid = '15'
  LEFT JOIN medicareinfo me ON b.voucherscode = me.ID
  LEFT JOIN department dg ON a.deptid = dg.ID
  LEFT JOIN ward wh ON a.ID = dg.ID
--   left join YY_SFXXMK e  on b.AttendLevel = e.sfxmdm
  LEFT JOIN diagnosis f ON f.icd = b.admitdiagnosis
  LEFT JOIN users c ON c.ID = b.resident
  LEFT JOIN dictionary_detail i ON i.detailid = b.criticallevel
                               AND i.categoryid = '53'
  LEFT JOIN users g ON g.ID = a.attend
  LEFT JOIN users h ON h.ID = a.chief
  LEFT JOIN dictionary_detail j ON j.detailid = b.sexid
                               AND j.categoryid = '3'
  LEFT JOIN categorydetail cd ON b.attendlevel = cd.ID
                             AND cd.categoryid = '63'
 WHERE a.noofinpat = v_NoOfinpat
   AND a.valid = 1;
end;
/

prompt
prompt Creating procedure USP_EMR_MODELSEARCHER
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_Emr_ModelSearcher(v_flag int,
                                                  v_type varchar) as
  /**********
   版本号 1.0.0.0.0
   创建时间 2007.02.8
   作者 周辉
   版权
   描述 .NET模型选择
   功能说明
   NET模型选择
   参数说明
    v_flag   int,  --模型分类类别
    v_type  int,  --模型类别
   返回值
   结果集、排序
   调用的sp
   调用实例
  exec  usp_Emr_ModelSearcher  0,3800
   修改历史
  **********/
  v_sql    varchar(500);
  v_dybm   varchar(20);
  v_sortID varchar(10);
  v_mbmc   varchar(10);
  v_mbms   varchar(10);
  v_mxmc   varchar(10);
begin

  if v_type = 3800 then
    begin
      v_dybm   := 'Model_Atom';
      v_sortID := 'DisMode';
      v_mbmc   := 'jdxsm';
      v_mbms   := 'jdms';
    end;
  elsif v_type = 3801 then
    begin
      v_dybm   := 'Model_Object';
      v_sortID := 'SortID';
      v_mbmc   := 'dxmc';
      v_mbms   := 'dxms';
    end;
  elsif v_type = 3802 then
    begin
      v_dybm   := 'Model_Embed';
      v_sortID := 'SortID';
      v_mbmc   := 'qrmbmc';
      v_mbms   := 'qrmbms';
    end;
  elsif v_type = 3804 then
    begin
      v_dybm   := 'Model_Docment';
      v_sortID := 'SortID';
      v_mbmc   := 'mbmc';
      v_mbms   := 'mbms';
    end;
  elsif v_type = 3805 then
    begin
      v_dybm   := 'Model_Record';
      v_sortID := 'SortID';
      v_mbmc   := 'zhmbmc';
      v_mbms   := 'zhmbms';
    end;
  elsif v_type = 3806 then
    begin
      v_dybm   := 'Model_Table';
      v_sortID := 'SortID';
      v_mbmc   := 'bgmc';
      v_mbms   := 'bgms';
    end;
  elsif v_type = 3807 then
    begin
      v_dybm   := 'Model_Structure';
      v_sortID := 'SortID';
      v_mbmc   := 'dxmc';
      v_mbms   := 'dxms';
    end;
  end if;
  if v_flag = 0 then
    begin
      v_sql := 'select a.ID,a.Name,a.Describe,b.ID CatalogID ,b.Name Catalog,a.' ||
               v_sortID || ' PrevID,a.' || v_sortID || ' SortID';
      if (v_type <> 3800) then
        v_sql := v_sql || ', a.Valid';
      else
        v_sql := v_sql || ',1 Valid';
      end if;
      v_sql := v_sql || ' from ' || v_dybm ||
               ' a(nolock) left join ModelDirectory b(nolock) on a.' ||
               v_sortID || ' = b.ID order by ID';
      execute immediate v_sql;
    end;
  end if;
end;
/

prompt
prompt Creating procedure USP_EMR_PATRECFILE
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE EMR.USP_EMR_PATRECFILE(
   v_flag INTEGER
   ,v_indx  INTEGER
  ,v_NOOFINPAT  INTEGER
  ,v_TEMPLATEID VARCHAR2
  ,v_FileNAME  VARCHAR2
  ,v_FileCONTENT    clob
  ,v_SORTID        VARCHAR2
  ,v_OWNER          VARCHAR2
  ,v_AUDITOR      VARCHAR2
  ,v_CREATETIME    CHAR
  ,v_AUDITTIME      CHAR
  ,v_VALID      INTEGER
  ,v_HASSUBMIT  INTEGER
  ,v_HASPRINT   INTEGER
  ,v_HASSIGN    INTEGER
  )
as
/**********        
[版本号] 1.0.0.0.0   
[创建时间]    
[作者]  
[版权]         
[描述] 更新或插入病历文件
[功能说明]        
[输入参数]  
  @NoOfInpat varchar(40)--首页序号
[输出参数]        
[结果集、排序]  
质量控制统计数据集  
 
[调用的sp]        
[调用实例]  
EXEC usp_Emr_PatRecFile 1,2,'T','FNAME','CONTENT','SORTID','OWN','AUDIT','CRAETE','AUDIT',1,1,1,1
[修改记录]
**********/
begin
         
         if v_flag=1 --插入
         then
          insert into RecordDetail(Id,Noofinpat, Templateid, Name, Content,
           Sortid, Owner, Auditor, Createtime,Audittime, Valid, Hassubmit, Hasprint, Hassign)
          values(v_indx,v_NOOFINPAT,v_TEMPLATEID,v_FileNAME,v_FileCONTENT,
          v_SORTID,v_OWNER,v_AUDITOR,v_CREATETIME,v_AUDITTIME,v_VALID,v_HASSUBMIT,v_HASPRINT,v_HASSIGN);
         
         elsif v_flag=2 then
         
              update RecordDetail
              set Content=v_FileCONTENT,AUDITOR=v_AUDITOR,AUDITTIME=v_AUDITTIME,Valid=v_Valid,Hassubmit=v_Hassubmit,Hasprint=v_Hasprint,Hassign=v_Hassign
              where ID=v_indx;
         end if;
end;
/

prompt
prompt Creating procedure USP_EMR_QUERYORDERSUITES
prompt ===========================================
prompt
create or replace procedure emr.usp_Emr_QueryOrderSuites(v_DeptID   varchar,
                                                     v_WardID   varchar,
                                                     v_DoctorID varchar,
                                                     v_yzlr     int default 1) as
  /**********
  [版本号] 1.0.0.0.0
  [创建时间] 2006.07.24
  [作者] 周辉
  [版权] Copyright ?
  [描述] 查询可用的成套医嘱
  [功能说明]
    现在按指定的科室进行查询。返回主记录和明细记录数据集
  [输入参数]
     v_DeptID  utKsdm  -- 科室代码
    ,v_WardID  utKsdm  -- 病区代码
    ,v_DoctorID  utCzyh  -- 医生工号
    ,v_yzlr  utBz  -- 是否是医嘱录入模块调用(0: 否  1:是)
  [输出参数]
  [结果集、排序]
    成套医嘱主记录数据集
    成套医嘱明细数据集
  [调用的sp]
  [调用实例]
    exec usp_Emr_QueryOrderSuites '2056', '2983', '001', 1
  **********/
  v_sql varchar2(4000);
begin
  v_sql := 'truncate table tmp_Emr_QueryOrderSuites ';
  EXECUTE IMMEDIATE v_sql;

  -- 在界面上将按照长期、临时分别显示相应的成套医嘱，所以在生成数据集时要特殊处理，以满足数据过滤的需要
  insert into tmp_Emr_QueryOrderSuites
    select e.ID GroupID,
           a.DetailID,
           a.Mark,
           a.SortMark,
           a.PlaceOfDrug,
           a.StandardOfDrug,
           a.ClinicIDOfDrug,
           a.DrugID,
           a.DrugName,
           a.ItemCategory,
           a.MinUnit,
           a.Dose,
           a.DoseUnit,
           a.MeasurementUnit,
           a.UnitCategory,
           a.UseageID,
           a.Frequency,
           a.EXECUTIONS,
           a.ExecuteCycle,
           a.CycleUnit,
           a.ZID,
           a.ExecuteDate,
           a.ExecuteDays,
           a.DrugGross,
           a.AdviceContent,
           a.AdviceCategory,
           e.Name,
           e.DeptID,
           e.WardID,
           e.DoctorID,
           e.UseRange,
           e.Memo,
           e.py,
           e.Wb,
           b.Name yfmc,
           c.Name pcmc --, d.Name yzbzmc--, f.Name yzlbmc
      from AdviceGroup e
      left join AdviceGroupDetail a on a.GroupID = e.ID
    --join YY_SJLBMXK d  on a.Mark = d.mxbh
    --join YY_SJLBMXK f  on a.AdviceCategory = f.mxbh
      left join DrugUseage b on a.UseageID = b.ID
      left join AdviceFrequency c on a.Frequency = c.ID
     where e.UseRange = 2900
        or (e.UseRange = 2901 and e.DeptID = v_DeptID)
        or (e.UseRange = 2903 and e.DoctorID = v_DoctorID);

  -- 输出结果集
  if v_yzlr = 1 then
    select distinct GroupID,
                    Name,
                    DeptID,
                    WardID,
                    DoctorID,
                    UseRange,
                    Memo,
                    py,
                    Wb,
                    Mark,
                    (case AdviceCategory
                      when 3104 then
                       AdviceCategory
                      else
                       -1
                    end) AdviceCategory
      from tmp_Emr_QueryOrderSuites
     order by UseRange, Mark, AdviceCategory, Name;
  else
    select distinct GroupID,
                    Name,
                    DeptID,
                    WardID,
                    DoctorID,
                    UseRange,
                    Memo,
                    py,
                    Wb
      from tmp_Emr_QueryOrderSuites
     order by UseRange, Name;
  end if;

  select DetailID,
         GroupID,
         Mark,
         SortMark,
         PlaceOfDrug,
         StandardOfDrug,
         ClinicIDOfDrug,
         DrugID,
         DrugName,
         ItemCategory,
         MinUnit,
         Dose,
         DoseUnit,
         MeasurementUnit,
         UnitCategory,
         UseageID,
         Frequency,
         EXECUTIONS,
         ExecuteCycle,
         CycleUnit,
         ZID,
         ExecuteDate,
         ExecuteDays,
         DrugGross,
         AdviceContent,
         AdviceCategory
    from tmp_Emr_QueryOrderSuites
   where DetailID is not null
   order by GroupID, DetailID;

end;
/

prompt
prompt Creating procedure USP_EMR_SETORDERGROUPSERIALNO
prompt ================================================
prompt
create or replace procedure emr.usp_Emr_SetOrderGroupSerialNo(v_NoOfInpat numeric,
                                                          v_OrderType int,
                                                          v_onlynew   int default 1) as
  /**********
  [版本号] 1.0.0.0.0
  [创建时间] 2007.02.14
  [作者]
  [版权] Copyright ?
  [描述] 设置医嘱的分组序号
  [功能说明]
    根据医嘱的分组标志重新设置指定病人的新长期或临时医嘱的分组序号。
    一般在医嘱保存后调用此存储过程进行统一设置（用来代替以前的医嘱表触发器）。
  [输入参数]
     v_NoOfInpat  utSyxh  -- EMR首页序号
    ,v_OrderType  utBz  -- 医嘱类别 0: 临时; 1: 长期; 2: 全部
    ,v_onlynew utBz = 1 -- 只处理新医嘱 1: 是; 0: 否
  [输出参数]
  [结果集、排序]
    成功 -- T
    失败 -- F, 失败原因
  [调用的sp]
  [调用实例]
     exec usp_Emr_SetOrderGroupSerialNo  32 , 1 ,1
  **********/
  v_tablename varchar2(40);
  v_cqlsbz    int;
  v_yzxh      int;
  v_GroupID   int;
  v_GroupFlag int;
  v_yznrlb    int;
  v_Memo      varchar2(50);
  --, v_lastcqlsbz utBz
  --, v_lastfzxh utXh12
  v_cyhzbz varchar2(50); -- 草药汇总信息标志
  v_sql    varchar2(4000);
begin

--yxy临时表暂时使用实体表
/* 
  v_tablename := 'tmp_newfzxh';

 droptable(v_tablename);
  --创建临时表

  v_sql := 'create table ' || v_tablename || '(
  cqlsbz  int    not null,  -- 长期临时标志, 0: 临时; 1: 长期
  yzxh  int  not null,  -- 医嘱序号
  GroupID  int  not null,  -- 分组序号
  GroupFlag  int  not null,  -- 分组标志
  OrderType  int  not null,  -- 医嘱类别(YY_SJLBMXK.mxbh, lbbh = 31)
  Memo  varchar(50)  null  ,  -- 备注
  constraint pk_newfzxh primary key (yzxh, cqlsbz)
  )';
  execute immediate v_sql;*/
  
    v_sql := 'truncate table tmp_newfzxh ';
    EXECUTE IMMEDIATE v_sql;

  if ((v_OrderType = 0) or (v_OrderType = 2)) then
  
    insert into tmp_newfzxh
      (cqlsbz, yzxh, GroupID, GroupFlag, OrderType, Memo)
      select 0, TempID, GroupID, GroupFlag, OrderType, Memo
        from Temp_Order
       where NoOfInpat = v_NoOfInpat
         and ((v_onlynew = 0) or ((v_onlynew = 1) and (OrderStatus = 3200)))
       order by TempID;
  end if;

  if ((v_OrderType = 1) or (v_OrderType = 2)) then
    insert into tmp_newfzxh
      (cqlsbz, yzxh, GroupID, GroupFlag, OrderType, Memo)
      select 1, LongID, GroupID, GroupFlag, OrderType, Memo
        from Long_Order
       where NoOfInpat = v_NoOfInpat
         and ((v_onlynew = 0) or ((v_onlynew = 1) and (OrderStatus = 3200)))
       order by LongID;
  end if;

  --select v_lastcqlsbz = 0, v_lastfzxh = 0
  v_cyhzbz := '草药汇总';
  declare
    cursor cr_fzxh is
      select cqlsbz, yzxh, GroupFlag, OrderType, Memo
        from tmp_newfzxh
       order by cqlsbz, yzxh
         for update of GroupID;
  
  begin
    open cr_fzxh;
    fetch cr_fzxh
      into v_cqlsbz, v_yzxh, v_GroupFlag, v_yznrlb, v_Memo;
    while cr_fzxh%found loop
      -- 以下处理分组序号的过程中是按照正常顺序进行处理，未考虑传入的数据分组有错误的情况！！！
      if (v_GroupFlag <= 3501) then
        -- 组开始或单条或未分组,分组序号与医嘱序号一致
        begin
          if ((v_yznrlb = 3110) and (instr(v_Memo, v_cyhzbz) > 0)) then
          
            update tmp_newfzxh
               set Memo = v_cyhzbz + to_char(v_GroupID)
             where current of cr_fzxh; -- 草药汇总的Memo中要保存草药明细的分组序号
          end if;
          select v_GroupID into v_yzxh from dual; --, v_lastfzxh = v_yzxh
        end;
      end if;
    
      update tmp_newfzxh set GroupID = v_GroupID where current of cr_fzxh; --yzxh = v_yzxh and cqlsbz = v_cqlsbz
    
      fetch cr_fzxh
        into v_cqlsbz, v_yzxh, v_GroupFlag, v_yznrlb, v_Memo;
    end loop;
  
    close cr_fzxh;
  
  end;

  update Temp_Order a
     set GroupID = (select b.GroupID
                      from tmp_newfzxh b
                     where a.TempID = b.yzxh
                       and b.cqlsbz = 0);

  update Long_Order a
     set GroupID = (select b.GroupID
                      from tmp_newfzxh b
                     where a.LongID = b.yzxh
                       and b.cqlsbz = 1);

end;
/

prompt
prompt Creating procedure USP_GETAPPLYRECORD
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetApplyRecord(v_DateBegin  varchar, --开始日期
                                               v_DateEnd    varchar, --结束日期
                                               v_OutHosDept varchar --出院科室科室
                                               ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取申请借阅病历
   功能说明
   输入参数
   输出参数
   结果集、排序
  
  
  
   调用的sp
   调用实例
   exec usp_GetApplyRecord v_DateBegin=N'2001-04-20',v_DateEnd=N'2011-04-27',v_OutHosDept=N'0000'
   exec usp_GetApplyRecord v_DateBegin=N'2011-04-20',v_DateEnd=N'2011-04-28',v_OutHosDept=N'0000'
   修改记录
  **********/

begin

  --获取申请借阅病历
  select ar.*,
         u.Name as ApplyDoctorName,
         cd1.Name as ApplyAimName,
         cd2.Name as UnitName,
         inp.NoOfRecord,
         inp.InCount,
         inp.Name,
         dd.Name as InpSexName,
         inp.Name as InpName,
         inp.AgeStr,
         dept.Name as OutHosDeptName,
         inp.PatID,
         inp.AdmitDate,
         inp.OutHosDate,
         d.Name as OutDiagnosisName,
         s.Name as SurgeryName,
         inp.OutWardDate
    from ApplyRecord ar
    left join InPatient inp on inp.NoOfInpat = ar.NoOfInpat
    left join Department dept on dept.ID = inp.OutHosDept
    left join Users u on u.ID = ar.ApplyDoctor
    left join CategoryDetail cd1 on cd1.CategoryID = '50'
                                and cd1.ID = ar.ApplyAim
    left join CategoryDetail cd2 on cd2.CategoryID = '51'
                                and cd2.ID = ar.Unit
    left join Dictionary_detail dd on dd.CategoryID = '3'
                                  and dd.DetailID = inp.SexID
    left join Diagnosis d on d.ICD = inp.OutDiagnosis
    left join MedicalRecord mr on mr.NoOfInpat = inp.NoOfInpat
    left join DiseaseCFG dc on dc.ID = mr.Disease
    left join Surgery s on s.ID = dc.SurgeryID
   where ar.ApplyDate >= v_DateBegin + ' 00:00:00 '
     and ar.ApplyDate < v_DateEnd + ' 24:00:00 '
     and (inp.OutHosDept = v_OutHosDept or v_OutHosDept = '0000')
     and ar.Status = '5201'
   order by OutWardDate;

end;
/

prompt
prompt Creating procedure USP_GETCONSULTATIONDATA
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetConsultationData(v_NoOfInpat        numeric default '0', --首页序号
                                                    v_ConsultApplySn   int default 0, --会诊序号
                                                    v_TypeID           numeric default '0', --类别
                                                    v_Param1           varchar default '', --参数1
                                                    v_ConsultTime_in   varchar default '',
                                                    v_ConsultTypeID    int default 0,
                                                    v_UrgencyTypeID    int default 0,
                                                    v_Name             varchar default '',
                                                    v_PatID            varchar default '',
                                                    v_BedID            varchar default '',
                                                    v_ConsultTimeBegin varchar default '',
                                                    v_ConsultTimeEnd   varchar default '',
                                                    v_DeptID           varchar default '') AS
  v_sql         varchar(4000);
  v_where       varchar(1000);
  v_ConsultTime varchar(24);
BEGIN

  v_ConsultTime := replace(v_ConsultTime_in, '/', '-');

  if v_TypeID = '1' then
    --医院列表
  
    select hi.ID as ID, hi. Name as Name
      from HospitalInfo hi
     order by hi.ID;
  end if;
  if v_TypeID = '2' then
    --部门列表，需要根据医院来判断
  
    select distinct d.ID as ID, d. Name, d.Py, d.Wb
      from Department d, Dept2Ward dw
     where d.Valid = '1'
       and d.ID = dw.DeptID
       and d.HosNo = v_Param1
     order by d.ID;
  end if;
  if v_TypeID = '3' then
    --医生列表，需要根据部门来判断
  
    select u.ID, u. Name, u.Py, u.Wb
      from Users u
     where u.DeptId = v_Param1
       and u.Valid = '1'
     order by u.ID;
  end if;
  if v_TypeID = '4' then
    --申请医师列表，需要根据当前病区来判断
  
    select u.ID, u. Name, u.Py, u.Wb
      from Users u
     where u.WardID is not null
       and u.WardID != ''
       and /*u.WardID = v_Param1 and*/
           u.Valid = '1'
     order by u.ID;
  end if;
  if v_TypeID = '5' then
    --申请医师科主任列表
  
    select *
      from Users u
     where u.WardID is not null
       and u.WardID != ''
       and /*u.WardID = v_Param1 and*/
           u.Valid = '1'
       and u.Grade = '2000'
     order by u.ID;
  end if;
  if v_TypeID = '6' then
    --根据类别从CategoryDetail表中捞取数据
  
    select cd.ID, cd. Name, cd.Py, cd.Wb
      from CategoryDetail cd
     where cd.CategoryID = v_Param1
     order by cd.CategoryID;
  end if;
  if v_TypeID = '7' then
    --床位,需要根据当前病区来判断
  
    select b.ID
      from Bed b
     where b.WardId = v_Param1
       and b.Valid = '1';
  end if;
  if v_TypeID = '8' then
    --得到所有临床医师
  
    select u.ID as EmployeeCode,
           u. Name as EmployeeName,
           u.Py,
           u.Wb,
           u.DeptId,
           d. Name as DeptName,
           d.ID as DeptCode
      from Users u
      left outer join Department d on d.ID = u.DeptId
                                  and d.Valid = '1'
     where u.WardID is not null
       and u.WardID != ''
       and u.Valid = '1'
     order by u.DeptId, u.ID;
  end if;
  if v_TypeID = '9' then
    --捞取医师资质
  
    select cd.ID, cd. Name, cd.Py, cd.Wb
      from CategoryDetail cd
     where cd.CategoryID = v_Param1
       and cd.ID in ('2000', '2001', '2002', '2003')
     order by cd.CategoryID;
  end if;
  if v_TypeID = '20' then
    --捞取会诊申请的详细信息
  
    --(1)ConsultApply
    select ca.ConsultApplySn,
           ca.NoOfInpat,
           ca.UrgencyTypeID,
           cd2. Name as UrgencyTypeName,
           ca.ConsultTypeID,
           cd1. Name as ConsultTypeName,
           ca.Abstract,
           ca.Purpose,
           ca.ApplyUser,
           u1. Name as ApplyUserName,
           ca.ApplyTime,
           ca.Director,
           u2. Name as DirectorName,
           ca.ConsultTime,
           ca.ConsultLocation,
           ca.StateID,
           cd3. Name as StatusName,
           ca.ConsultSuggestion,
           ca.FinishTime,
           ca.RejectReason,
           ca.Valid,
           ca.CreateUser,
           ca.CreateTime
      from ConsultApply ca
      left outer join CategoryDetail cd1 on cd1.CategoryID = 65
                                        and cd1.ID = ca.ConsultTypeID
      left outer join CategoryDetail cd2 on cd2.CategoryID = 66
                                        and cd2.ID = ca.UrgencyTypeID
      left outer join CategoryDetail cd3 on cd3.CategoryID = 67
                                        and cd3.ID = ca.StateID
      left outer join Users u1 on u1.ID = ca.ApplyUser
                              and u1.Valid = '1'
      left outer join Users u2 on u2.ID = ca.Director
                              and u2.Valid = '1'
     where ca.ConsultApplySn = v_ConsultApplySn
       and ca.Valid = '1';
  
    --(2)ConsultApplyDepartment
    select cad.ID,
           cad.ConsultApplySn,
           cad.OrderValue,
           cad.HospitalCode,
           hi. Name as HospitalName,
           cad.DepartmentCode,
           case
             when cad.DepartmentCode = '' or cad.DepartmentCode is null then
              cad.DepartmentName
             else
              d. Name
           end DepartmentName,
           cad.EmployeeCode,
           case
             when cad.EmployeeCode = '' or cad.EmployeeCode is null then
              cad.EmployeeName
             else
              u. Name
           end EmployeeName,
           cad.EmployeeLevelID,
           cd1. Name as EmployeeLevelName,
           cad.CreateUser,
           '删除' as DeleteButton
    
      from ConsultApplyDepartment cad
      left outer join HospitalInfo hi on hi.ID = cad.HospitalCode
      left outer join Department d on d.ID = cad.DepartmentCode
                                  and d.Valid = '1'
      left outer join Users u on u.ID = cad.EmployeeCode
                             and u.Valid = '1'
      left outer join CategoryDetail cd1 on cd1.CategoryID = 20
                                        and cd1.ID = cad.EmployeeLevelID
     where cad.Valid = '1'
       and cad.ConsultApplySn in
           (select ca.ConsultApplySn
              from ConsultApply ca
             where ca.ConsultApplySn = v_ConsultApplySn
               and ca.Valid = '1');
  
    --(3)ConsultRecordDepartment
    select cad.ID,
           cad.ConsultApplySn,
           cad.OrderValue,
           cad.HospitalCode,
           hi. Name as HospitalName,
           cad.DepartmentCode,
           case
             when cad.DepartmentCode = '' or cad.DepartmentCode is null then
              cad.DepartmentName
             else
              d. Name
           end DepartmentName,
           cad.EmployeeCode,
           case
             when cad.EmployeeCode = '' or cad.EmployeeCode is null then
              cad.EmployeeName
             else
              u. Name
           end EmployeeName,
           cad.EmployeeLevelID,
           cd1. Name as EmployeeLevelName,
           cad.CreateUser,
           '删除' as DeleteButton
    
      from ConsultRecordDepartment cad
      left outer join HospitalInfo hi on hi.ID = cad.HospitalCode
      left outer join Department d on d.ID = cad.DepartmentCode
                                  and d.Valid = '1'
      left outer join Users u on u.ID = cad.EmployeeCode
                             and u.Valid = '1'
      left outer join CategoryDetail cd1 on cd1.CategoryID = 20
                                        and cd1.ID = cad.EmployeeLevelID
     where cad.Valid = '1'
       and cad.ConsultApplySn in
           (select ca.ConsultApplySn
              from ConsultApply ca
             where ca.ConsultApplySn = v_ConsultApplySn
               and ca.Valid = '1');
  
  END if;

  if v_TypeID = '21' then
    --捞取符合条件的会诊申请信息(用于会诊审核列表)
    --把当前科室 = 申请人所在的科室 的都捞出来
  
    v_where := '';
  
    if ltrim(v_ConsultTime) != '' then
      v_where := v_where + ' and ca.ConsultTime like ''' + '%' +
                 rtrim(v_ConsultTime) + '%' + '''';
    end if;
    if v_ConsultTypeID != '0' then
      v_where := v_where + ' and ca.ConsultTypeID=' +
                 to_char(v_ConsultTypeID);
    end if;
    if v_UrgencyTypeID != '0' then
      v_where := v_where + ' and ca.UrgencyTypeID=' +
                 to_char(v_UrgencyTypeID);
    end if;
    if v_Name != '' then
      v_where := v_where + ' and inp. Name  like ''' + '%' + v_Name + '%' + '''';
    end if;
    if v_PatID != '' then
      v_where := v_where + ' and inp.PatID like ''' + '%' + v_PatID + '%' + '''';
    end if;
    if v_BedID != '' then
      v_where := v_where + ' and inp.OutBed=''' + v_BedID + '''';
    end if;
    if ltrim(v_ConsultTimeBegin) != '' then
      v_where := v_where + ' and LEFT(ca.ConsultTime, 10) >= ''' +
                 v_ConsultTimeBegin + '''';
    end if;
    if ltrim(v_ConsultTimeEnd) != '' then
      v_where := v_where + ' and LEFT(ca.ConsultTime, 10) <= ''' +
                 v_ConsultTimeEnd + '''';
    end if;
  
    v_sql := 'select inp. Name  as PatientName, inp.PatID, inp.OutBed,
       ca.ConsultApplySn, ca.NoOfInpat, ca.UrgencyTypeID, cd2. Name  as UrgencyTypeName,
       ca.ConsultTypeID, cd1. Name  as ConsultTypeName, ca.Abstract, ca.Purpose,
       ca.ApplyUser, u1. Name  as ApplyUserName, ca.ApplyTime, ca.Director,
       u2. Name  as DirectorName, ca.ConsultTime, ca.ConsultLocation, ca.StateID,
       cd3. Name  as StatusName, ca.ConsultSuggestion, ca.FinishTime, ca.RejectReason,
       ca.Valid, ca.CreateUser, ca.CreateTime, d. Name  as DeptName
  from ConsultApply ca
  left outer join CategoryDetail cd1 on cd1.CategoryID = 65 and cd1.ID = ca.ConsultTypeID
  left outer join CategoryDetail cd2 on cd2.CategoryID = 66 and cd2.ID = ca.UrgencyTypeID
  left outer join CategoryDetail cd3 on cd3.CategoryID = 67 and cd3.ID = ca.StateID
  left outer join Users u1 on u1.ID = ca.ApplyUser and u1.Valid = ''1''
  left outer join Users u2 on u2.ID = ca.Director and u2.Valid = ''1''
  left outer join InPatient inp on inp.NoOfInpat = ca.NoOfInpat
  left outer join Department d on d.ID = u1.DeptId and d.Valid = ''1''
  where ca.Valid = ''1'' and ca.StateID = ''6720'' and u1.DeptId = ''' +
             v_DeptID + '''
  and inp. Status  in (''1501'',''1502'',''1504'',''1505'',''1506'',''1507'')
  ';
  
    v_sql := v_sql + v_where;
    --print v_sql
  
    v_sql := v_sql + ' order by ca.ApplyTime ';
  
    execute immediate v_sql;
  END if;

  if v_TypeID = '22' then
    --捞取符合条件的会诊信息（用于会诊清单）
    --(1)把当前科室 = 申请人所在的科室 的都捞出来
    --(2)把当前科室 in 受邀科室 的都捞出来
    BEGIN
    
      v_where := '';
    
      if ltrim(v_ConsultTime) != '' then
        v_where := v_where + ' and ca.ConsultTime like ''' + '%' +
                   rtrim(v_ConsultTime) + '%' + '''';
      end if;
      if v_ConsultTypeID != '0' then
        v_where := v_where + ' and ca.ConsultTypeID=' +
                   to_char(v_ConsultTypeID);
      end if;
      if v_UrgencyTypeID != '0' then
        v_where := v_where + ' and ca.UrgencyTypeID=' +
                   to_char(v_UrgencyTypeID);
      end if;
      if v_Name != '' then
        v_where := v_where + ' and inp. Name  like ''' + '%' + v_Name + '%' + '''';
      end if;
      if v_PatID != '' then
        v_where := v_where + ' and inp.PatID like ''' + '%' + v_PatID + '%' + '''';
      end if;
      if v_BedID != '' then
        v_where := v_where + ' and inp.OutBed=''' + v_BedID + '''';
      end if;
      if ltrim(v_ConsultTimeBegin) != '' then
        v_where := v_where + ' and LEFT(ca.ConsultTime, 10) >= ''' +
                   v_ConsultTimeBegin + '''';
      end if;
      if ltrim(v_ConsultTimeEnd) != '' then
        v_where := v_where + ' and LEFT(ca.ConsultTime, 10) <= ''' +
                   v_ConsultTimeEnd + '''';
      end if;
    
      v_sql := 'select inp. Name  as PatientName, inp.PatID, inp.OutBed,
       ca.ConsultApplySn, ca.NoOfInpat, ca.UrgencyTypeID, cd2. Name  as UrgencyTypeName,
       ca.ConsultTypeID, cd1. Name  as ConsultTypeName, ca.Abstract, ca.Purpose,
       ca.ApplyUser, u1. Name  as ApplyUserName, ca.ApplyTime, ca.Director,
       u2. Name  as DirectorName, ca.ConsultTime, ca.ConsultLocation, ca.StateID,
       cd3. Name  as StatusName, ca.ConsultSuggestion, ca.FinishTime, ca.RejectReason,
       ca.Valid, ca.CreateUser, ca.CreateTime, d. Name  as DeptName
  from ConsultApply ca
  left outer join CategoryDetail cd1 on cd1.CategoryID = 65 and cd1.ID = ca.ConsultTypeID
  left outer join CategoryDetail cd2 on cd2.CategoryID = 66 and cd2.ID = ca.UrgencyTypeID
  left outer join CategoryDetail cd3 on cd3.CategoryID = 67 and cd3.ID = ca.StateID
  left outer join Users u1 on u1.ID = ca.ApplyUser and u1.Valid = ''1''
  left outer join Users u2 on u2.ID = ca.Director and u2.Valid = ''1''
  left outer join InPatient inp on inp.NoOfInpat = ca.NoOfInpat
  left outer join Department d on d.ID = u1.DeptId and d.Valid = ''1''
  where ca.Valid = ''1'' and (u1.DeptId = ''' + v_DeptID +
               ''' or
  exists
  (
    select *
    from ConsultApplyDepartment cad
    where cad.ConsultApplySn = ca.ConsultApplySn and cad.DepartmentCode = ''' +
               v_DeptID + '''
  ))
  and inp. Status  in (''1501'',''1502'',''1504'',''1505'',''1506'',''1507'')
  ';
    
      v_sql := v_sql + v_where;
      --print v_sql
    
      v_sql := v_sql + ' order by ca.ConsultTime ';
    
      execute immediate v_sql;
    end;
  end if;

  if v_TypeID = '23' then
    --捞取符合条件的会诊信息（用于会诊记录清单）
    --对于一般会诊被邀请的科室能够看到，对于多科会诊申请会诊的科室能够看到
    BEGIN
    
      v_where := '';
    
      if ltrim(v_ConsultTime) != '' then
        v_where := v_where + ' and ca.ConsultTime like ''' + '%' +
                   rtrim(v_ConsultTime) + '%' + '''';
      end if;
      if v_ConsultTypeID != '0' then
        v_where := v_where + ' and ca.ConsultTypeID=' +
                   to_char(v_ConsultTypeID);
      end if;
      if v_UrgencyTypeID != '0' then
        v_where := v_where + ' and ca.UrgencyTypeID=' +
                   to_char(v_UrgencyTypeID);
      end if;
      if v_Name != '' then
        v_where := v_where + ' and inp. Name  like ''' + '%' + v_Name + '%' + '''';
      end if;
      if v_PatID != '' then
        v_where := v_where + ' and inp.PatID like ''' + '%' + v_PatID + '%' + '''';
      end if;
      if v_BedID != '' then
        v_where := v_where + ' and inp.OutBed=''' + v_BedID + '''';
      end if;
      if ltrim(v_ConsultTimeBegin) != '' then
        v_where := v_where + ' and LEFT(ca.ConsultTime, 10) >= ''' +
                   v_ConsultTimeBegin + '''';
      end if;
      if ltrim(v_ConsultTimeEnd) != '' then
        v_where := v_where + ' and LEFT(ca.ConsultTime, 10) <= ''' +
                   v_ConsultTimeEnd + '''';
      end if;
    
      v_sql := 'select inp. Name  as PatientName, inp.PatID, inp.OutBed,
       ca.ConsultApplySn, ca.NoOfInpat, ca.UrgencyTypeID, cd2. Name  as UrgencyTypeName,
       ca.ConsultTypeID, cd1. Name  as ConsultTypeName, ca.Abstract, ca.Purpose,
       ca.ApplyUser, u1. Name  as ApplyUserName, ca.ApplyTime, ca.Director,
       u2. Name  as DirectorName, ca.ConsultTime, ca.ConsultLocation, ca.StateID,
       cd3. Name  as StatusName, ca.ConsultSuggestion, ca.FinishTime, ca.RejectReason,
       ca.Valid, ca.CreateUser, ca.CreateTime, d. Name  as DeptName
  from ConsultApply ca
  left outer join CategoryDetail cd1 on cd1.CategoryID = 65 and cd1.ID = ca.ConsultTypeID
  left outer join CategoryDetail cd2 on cd2.CategoryID = 66 and cd2.ID = ca.UrgencyTypeID
  left outer join CategoryDetail cd3 on cd3.CategoryID = 67 and cd3.ID = ca.StateID
  left outer join Users u1 on u1.ID = ca.ApplyUser and u1.Valid = ''1''
  left outer join Users u2 on u2.ID = ca.Director and u2.Valid = ''1''
  left outer join InPatient inp on inp.NoOfInpat = ca.NoOfInpat
  left outer join Department d on d.ID = u1.DeptId and d.Valid = ''1''
  where ca.Valid = ''1'' and ca.StateID in ( ''6730'', ''6740'' ) and
    exists
    (
      select *
      from ConsultApplyDepartment cad
      where cad.ConsultApplySn = ca.ConsultApplySn and cad.DepartmentCode = ''' +
               v_DeptID + '''
    )
    and ca.ConsultTypeID = ''6501''
    and inp. Status  in (''1501'',''1502'',''1504'',''1505'',''1506'',''1507'')
  ';
    
      v_sql := v_sql + v_where;
      v_sql := v_sql + ' union
  select inp. Name  as PatientName, inp.PatID, inp.OutBed,
       ca.ConsultApplySn, ca.NoOfInpat, ca.UrgencyTypeID, cd2. Name  as UrgencyTypeName,
       ca.ConsultTypeID, cd1. Name  as ConsultTypeName, ca.Abstract, ca.Purpose,
       ca.ApplyUser, u1. Name  as ApplyUserName, ca.ApplyTime, ca.Director,
       u2. Name  as DirectorName, ca.ConsultTime, ca.ConsultLocation, ca.StateID,
       cd3. Name  as StatusName, ca.ConsultSuggestion, ca.FinishTime, ca.RejectReason,
       ca.Valid, ca.CreateUser, ca.CreateTime, d. Name  as DeptName
  from ConsultApply ca
  left outer join CategoryDetail cd1 on cd1.CategoryID = 65 and cd1.ID = ca.ConsultTypeID
  left outer join CategoryDetail cd2 on cd2.CategoryID = 66 and cd2.ID = ca.UrgencyTypeID
  left outer join CategoryDetail cd3 on cd3.CategoryID = 67 and cd3.ID = ca.StateID
  left outer join Users u1 on u1.ID = ca.ApplyUser and u1.Valid = ''1''
  left outer join Users u2 on u2.ID = ca.Director and u2.Valid = ''1''
  left outer join InPatient inp on inp.NoOfInpat = ca.NoOfInpat
  left outer join Department d on d.ID = u1.DeptId and d.Valid = ''1''
  where ca.Valid = ''1'' and ca.StateID in ( ''6730'', ''6740'' )
    and u1.DeptId = ''' + v_DeptID + '''
    and ca.ConsultTypeID = ''6502''
    and inp. Status  in (''1501'',''1502'',''1504'',''1505'',''1506'',''1507'')
  ';
    
      v_sql := v_sql + v_where;
    
      --print v_sql
    
      v_sql := v_sql + ' order by ca.ConsultTime ';
    
      execute immediate v_sql;
    end;
  END if;
END;
/

prompt
prompt Creating procedure USP_GETCURRSYSTEMPARAM
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetCurrSystemParam(v_GetType int --操作类型
                                                   ) as

  /**********
   版本号  1.0.0.0.0
   创建时间 2011-03-27
   作者   hjh
   版权
   描述  获取系统当前参数
   功能说明
   输入参数
   输出参数
   结果集、排序
  
  
  
   调用的sp
   调用实例
  
   修改记录
  **********/

begin

  if v_GetType = 1 then
    --获取当前系统时间
    select to_char(sysdate, 'yyyy-mm-dd HH24:mi:ss') as CurrServerDateTime
      from dual;
  end if;
end;
/

prompt
prompt Creating procedure USP_GETDEPTDEDUCTPOINT
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetDeptDeductPoint(v_DeptCode      varchar default '',
                                                   v_DateTimeBegin varchar,
                                                   v_DateTimeEnd   varchar,
                                                   v_PointID       varchar default '',
                                                   v_QCStatType    int) as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取科室病历失分点
   功能说明
   输入参数
    v_DeptCode varchar(10)    --科室编号
   ,  v_DateTimeBegin varchar(9)  --开始时间
   ,  v_v_DateTimeEnd  varchar(9)  --结束时间
   ,  v_QCStatType int        --统计资料类型
   输出参数
   结果集、排序
  失分统计信息
  
   调用的sp
   调用实例
   exec usp_GetInpatientFiling '','', '2007-06-01', '2012-06-30',2
   修改记录
  **********/
begin
  IF v_QCStatType = 1 then
  
    --科室病历失分统计
    select dept.Name DeptName,
           point.DeductPointResult,
           point.DeductPointCnt,
           point.ID
      from Dept_DeductPoint point
      left join Department dept on to_char(dept.ID) =
                                   to_char(point.DeptCode)
     where to_char(point.CreatTime, 'yyyy-mm-dd') >= v_DateTimeBegin
       AND to_char(point.CreatTime, 'yyyy-mm-dd') <= v_DateTimeEnd
       and (to_char(dept.ID) = v_DeptCode or v_DeptCode = '');
  
  ELSIF v_QCStatType = 2 then
  
    --科室病历失分点明细
    select ROW_NUMBER() OVER(ORDER BY detail.ID ASC) AS ROWID,
           dept.Name DeptName,
           inp.PatID,
           dd.Name SexName,
           inp.Name InPatientName,
           ResidentUser.Name ResidentName,
           AttendUser.Name AttendName,
           ChiefUser.Name ChiefName,
           detail.DeductPointCnt,
           detail.DeductPointResult,
           inp.NoOfInpat
      from Dept_DeductPointDetail detail
      left join Dept_DeductPoint point on detail.FaID = point.ID
      left join Department dept on to_char(dept.ID) =
                                   to_char(point.DeptCode)
      left join InPatient inp on inp.NoOfInpat = detail.NoOfInpat
      left join Dictionary_detail dd ON dd.CategoryID = '3'
                                    AND inp.SexID = dd.DetailID
      left join Users ResidentUser on ResidentUser.ID = inp.Resident
      left join Users AttendUser on AttendUser.ID = inp.Attend
      left join Users ChiefUser on ChiefUser.ID = inp.Chief
    
     where to_char(point.CreatTime, 'yyyy-mm-dd') >= v_DateTimeBegin
       AND to_char(point.CreatTime, 'yyyy-mm-dd') <= v_DateTimeEnd
       and (to_char(dept.ID) = v_DeptCode or v_DeptCode = '')
       and (to_char(point.ID) = v_PointID or v_PointID = '');
  
  elsIF v_QCStatType = 3 then
  
    --科室病历失分大类
    select point.ID, point.DeductPointResult as Name, point.CreatTime
      from Dept_DeductPoint point
     where to_char(point.CreatTime, 'yyyy-mm-dd') >= v_DateTimeBegin
       AND to_char(point.CreatTime, 'yyyy-mm-dd') <= v_DateTimeEnd
       and (to_char(point.DeptCode) = v_DeptCode or v_DeptCode = '')
       and (to_char(point.ID) = v_PointID or v_PointID = '');
  end if;

end;
/

prompt
prompt Creating procedure USP_GETDOCTORTASKINFO
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetDoctorTaskInfo
(
    v_Wardid varchar  ,--病区
    v_Deptids varchar  ,--科室
    v_UserID varchar,--用户ID
    v_Time varchar  ,--时间
    v_QueryType int default 0 --类型
    )
as /**********
 版本号  1.0.0.0.0
 创建时间
 作者
 版权
 描述  获取医生任务信息内容
 功能说明
 输入参数
 输出参数
 结果集、排序

 exec usp_GetDoctorTaskInfo v_Wardid='2911',v_Deptids='3202',v_UserID='00',v_Time='2011/05/09 00:00:00'

 调用的sp
 调用实例

 修改记录
**********/

    begin



  --今日任务
        select  inp.NoOfInpat ,
                inp.Name ,
                inp.OutHosDept ,
                inp.OutHosWard ,
                '' Memo ,
                '患者手术' TaskName
        from    InPatient inp
        where   inp.Status in ( 1501, 1502, 1504, 1505, 1506, 1507 )
                and exists ( select 1
                             from   Temp_Order tor
                             where  tor.NoOfInpat = inp.NoOfInpat
                                    and tor.OrderType = 3105
                                    and tor.OrderStatus = 3201
                                    and to_char(tor.DateOfAudit, 'yyyy-mm-dd HH24:mi:ss') <= to_char( v_Time, 'yyyy-mm-dd HH24:mi:ss'))
                and exists ( select 1
                             from   Doctor_AssignPatient dca
                             where  dca.NoOfInpat = inp.NoOfInpat
                                    and dca.ID = v_UserID
                                    and dca.Valid = 1 )
        union all
        select  inp.NoOfInpat ,
                inp.Name ,
                inp.OutHosDept ,
                inp.OutHosWard ,
                qcr.Reminder as Memo ,
                '病历书写' TaskNameTaskName
        from    InPatient inp ,
                QCRecord qcr
        where   inp.Status in ( 1501, 1502, 1504, 1505, 1506, 1507 )
                and  --                             qcr.FoulState = 0
--                                    and qcr.Result = 1
--                                    and
                qcr.NoOfInpat = inp.NoOfInpat
                and exists ( select 1
                             from   Doctor_AssignPatient dca
                             where  dca.NoOfInpat = inp.NoOfInpat
                                    and dca.ID = v_UserID
                                    and dca.Valid = 1 )
        order by NoOfInpat;


   --遗留任务
        select  inp.NoOfInpat ,
                inp.Name ,
                inp.OutHosDept ,
                inp.OutHosWard ,
                qcr.FoulMessage as Memo ,
                '病历书写' TaskName
        from    InPatient inp ,
                QCRecord qcr
        where   inp.Status in ( 1501, 1502, 1504, 1505, 1506, 1507 )
                and qcr.FoulState = 1
                and qcr.Result = 0
                and qcr.NoOfInpat = inp.NoOfInpat
                and exists ( select 1
                             from   Doctor_AssignPatient dca
                             where  dca.NoOfInpat = inp.NoOfInpat
                                    and dca.ID = v_UserID
                                    and dca.Valid = 1 )
        order by inp.NoOfInpat;


   --后续任务
        select  inp.NoOfInpat ,
                inp.Name ,
                inp.OutHosDept ,
                inp.OutHosWard ,
                ( case when b.LockInfo = 4700 then '未归档'
                       when b.LockInfo = 4701 then '已归档'
                       else '撤销归档'
                  end ) Memo ,
                '病历归档' TaskName
        from    InPatient inp ,
                MedicalRecord b ,
                Department d ,
                Ward e ,
                CategoryDetail f
        where   inp.Status in ( 1502, 1503 )
                and inp.NoOfInpat = b.NoOfInpat
                and inp.OutHosDept = d.ID
                and inp.OutHosWard = e.ID
                and inp.Status = f.ID
                and b.LockInfo not in ( 4701 )
                and not exists ( select 1
                                 from   RecordDetail c
                                 where  inp.NoOfInpat = c.NoOfInpat
                                        and c.Valid = 1
                                        and c.HasSubmit = 0 );

    --会诊信息 Add By wwj 2011-05-26

    --待审核(申请科室)， 待会诊（申请科室）
    select ip. Name  as InpatientName, to_char(ca.ConsultTime, 'mm-dd hh24:mi:ss') as ConsultTime,
      cd. Name  as ConsultStatus, cd1. Name  as UrgencyType,
      ip. Name  + '_' + cd1. Name  + '_' + ca.ConsultTime as InpatientInfo
    from ConsultApply ca
    left outer join Users u on u.ID = ca.ApplyUser and u.Valid = '1'
    left outer join InPatient ip on ip.NoOfInpat = ca.NoOfInpat
    left outer join CategoryDetail cd on cd.CategoryID = '67'
      and ca.StateID = cd.ID
    left outer join CategoryDetail cd1 on cd1.CategoryID = '66'
        and cd1.ID = ca.UrgencyTypeID
    where ca.Valid = '1'
      and ca.Valid = '1'
      and ip. Status  in ('1501','1502','1504','1505','1506','1507')
      and
      (
        (instr(u.DeptId, v_Deptids) > 0 and ca.StateID in ('6720','6730')) --待审核,待会诊
        or
        (ca.StateID in ('6730') --待会诊
        and exists
        (
          select *
          from ConsultApplyDepartment cad
          where cad.ConsultApplySn = ca.ConsultApplySn
          and instr(cad.DepartmentCode,v_Deptids) > 0
        ))
      );
    end;
/

prompt
prompt Creating procedure USP_GETHOSPITALINFO
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetHospitalInfo AS
BEGIN

  select * from HospitalInfo hi;

end;
/

prompt
prompt Creating procedure USP_GETIEMINFO
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetIemInfo(v_NoOfInpat int) as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取质量评分
   功能说明
   输入参数
    v_NoOfInpat varchar(40)--首页序号
   输出参数
   结果集、排序
  质量控制统计数据集
  
   调用的sp
   调用实例
   exec usp_GetIemInfo  9
   修改记录
  **********/
  v_infono numeric;
begin

  select max(imb.Iem_Mainpage_NO)
    into v_infono
    from Iem_Mainpage_Basicinfo imb
   where imb.NoOfInpat = v_NoOfInpat
     and imb.Valide = 1;

  --数据顺序不可变，与程序里相关
  --基本信息
  select *
    from Iem_Mainpage_Basicinfo
   where Iem_Mainpage_NO = v_infono
     and Valide = 1;

  --诊断
  select *
    from Iem_Mainpage_Diagnosis
   where Iem_Mainpage_NO = v_infono
     and Valide = 1
   order by Order_Value;

  --手术
  select *
    from Iem_MainPage_Operation
   where IEM_MainPage_NO = v_infono
     and Valide = 1;

end;
/

prompt
prompt Creating procedure USP_GETINPATIENTFILING
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetInpatientFiling
(
 v_DeptCode varchar default '',
 v_NoOfInpat varchar default '',
 v_DateTimeBegin varchar ,
 v_DateTimeEnd  varchar ,
 v_QCStatType int
 )
as
/**********
 版本号  1.0.0.0.0
 创建时间
 作者
 版权
 描述  获取科室质量管理未归档病历
 功能说明
 输入参数
  v_DeptCode varchar(10)    --科室编号
   v_NoOfInpat varchar(10) = '', --病人首页序号
  v_DateTimeBegin varchar(9) --开始时间
 ,  v_v_DateTimeEnd  varchar(9) --结束时间
 ,  v_QCStatType int --统计资料类型
 输出参数
 结果集、排序
质量控制统计数据集

 调用的sp
 调用实例
 exec usp_GetInpatientFiling '','', '2011-02-24', '2011-03-24',1
 修改记录
**********/
begin



IF v_QCStatType = 1 then
--出院未归档病历
  select ROW_NUMBER() OVER (ORDER BY inp.NoOfInpat ) AS ROWID,

    inp.OutHosDept,
    de.Name DeptName,
    inp.NoOfInpat AS NoOfInpat,
    inp.PatNoOfHis AS PatNoOfHis,
    inp.PatID AS PatID,
    inp.Name AS Name,
    inp.SexID AS SexID,
    dd.Name AS SexName,
    inp.AgeStr AS AgeStr,
    to_char(inp.AdmitDate,'yyyy-mm-dd') AS AdmitDate,
    to_char(inp.OutHosDate,'yyyy-mm-dd') as OutHosDate ,
    1 InHosCnt,    ---住院次数
    ResidentUser.Name ResidentName,
    AttendUser.Name AttendName,
    ChiefUser.Name ChiefName,
    diag.Name AdmitDiag,
    datediff('dd',inp.AdmitDate,nvl(inp.OutWardDate,to_char(sysdate,'yyyy-mm-dd'))) inhosdays,
    nvl(datediff('dd',inp.OutWardDate,to_char(sysdate,'yyyy-mm-dd')),0) outhosdays
  FROM InPatient inp
  JOIN MedicalRecord med ON inp.NoOfInpat = med.NoOfInpat
  LEFT JOIN Dictionary_detail dd ON dd.CategoryID = '3' AND inp.SexID = dd.DetailID
  left join Users ResidentUser on ResidentUser.ID = inp.Resident
  left join Users AttendUser on AttendUser.ID = inp.Attend
  left join Users ChiefUser on ChiefUser.ID = inp.Chief
  left join Department de on de.ID = inp.OutHosDept
  left join Diagnosis diag on diag.MarkId  = inp.AdmitDiagnosis

  WHERE inp.Status = 1503
    AND med.LockInfo IN (4700,4702,4703)
    AND to_char(inp.AdmitDate,'yyyy.mm.dd') >= v_DateTimeBegin
    AND to_char(inp.AdmitDate,'yyyy.mm.dd') <= v_DateTimeEnd
    and (to_char(OutHosDept) = v_DeptCode or v_DeptCode = '')
    and (to_char(inp.NoOfInpat) = v_NoOfInpat or v_NoOfInpat = '')
  order by inp.NoOfInpat;
  

ELSIF v_QCStatType = 2 then
--归档病历
    select ROW_NUMBER() OVER (ORDER BY inp.NoOfInpat ) AS ROWID,
      inp.OutHosDept,
      de.Name DeptName,
      inp.NoOfInpat AS NoOfInpat,
      inp.PatNoOfHis AS PatNoOfHis,
      inp.PatID AS PatID,
      inp.Name AS Name,
      inp.SexID AS SexID,
      dd.Name AS SexName,
      inp.AgeStr AS AgeStr,
    to_char(inp.AdmitDate,'yyyy-mm-dd') AS AdmitDate,
    to_char(inp.OutHosDate,'yyyy-mm-dd') as OutHosDate ,
      1 InHosCnt,    ---住院次数
      ResidentUser.Name ResidentName,
      AttendUser.Name AttendName,
      ChiefUser.Name ChiefName,
      diag.Name AdmitDiag,
      datediff('dd',inp.AdmitDate,nvl(inp.OutWardDate,to_char(sysdate,'yyyy-mm-dd'))) inhosdays,
      nvl(datediff('dd',inp.OutWardDate,to_char(sysdate,'yyyy-mm-dd')),0) outhosdays
    FROM InPatient inp
    JOIN MedicalRecord med ON inp.NoOfInpat = med.NoOfInpat
    LEFT JOIN Dictionary_detail dd  ON dd.CategoryID = '3' AND inp.SexID = dd.DetailID
    left join Users ResidentUser on ResidentUser.ID = inp.Resident
    left join Users AttendUser on AttendUser.ID = inp.Attend
    left join Users ChiefUser on ChiefUser.ID = inp.Chief
    left join Department de on de.ID = inp.OutHosDept
    left join Diagnosis diag on diag.MapID  = inp.AdmitDiagnosis

    WHERE inp.Status = 1503
    AND med.LockInfo = 4701
    AND to_char(inp.AdmitDate,'yyyy.mm.dd') >= v_DateTimeBegin
    AND to_char(inp.AdmitDate,'yyyy.mm.dd') <= v_DateTimeEnd
    and (to_char(OutHosDept) = v_DeptCode or v_DeptCode = '')
    and (to_char(inp.NoOfInpat) = v_NoOfInpat or v_NoOfInpat = '')
    order by inp.NoOfInpat;
    end if;
end  ;
/

prompt
prompt Creating procedure USP_GETINPATIENTREPORT
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetInpatientReport(v_NoOfInpat     varchar default '',
                                                   v_DateTimeBegin varchar default '',
                                                   v_DateTimeEnd   varchar default '',
                                                   v_SubmitDocID   varchar default '',
                                                   v_ReportID      varchar default '',
                                                   v_QCStatType    varchar default '') as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  根据传入的时间段以及病人首页序号  查询病人医技报告信息
   功能说明
   输入参数
   v_NoOfInpat  varchar(10) = '', --病人首页序号
   v_DateTimeBegin  varchar(10) = '', --开始时间
   v_DateTimeEnd  varchar(10) = '', --结束时间
   v_SubmitDocID  varchar(10) = '', --送检医生
   v_ReportID   varchar(12) = '', --主表唯一标示列（查询子表信息时候使用）
   v_QCStatType  varchar(3)  = '' --类型   默认查询主表信息   LIS：查询检查类信息  RIS：查询检验类信息
   输出参数
   结果集、排序
  质量控制统计数据集
  
   调用的sp
   调用实例
  usp_GetInpatientReport '62','','','','',''
  
   修改记录
  **********/

begin

  -----查询主表信息
  if v_QCStatType = '' then
  
    select Report.HospitalNo,
           Report.NoOfInpat,
           inp.Name,
           Report.RePortCatalog,
           Report.ReportType,
           ReportNo,
           ReportName,
           users.Name as SubmitDocName,
           Report.SubmitDate,
           Report.ReleaseDate,
           Report.HadRead,
           Report.ID ReportID
      from InpatientReport Report
      left join InPatient inp on Report.NoOfInpat = inp.NoOfInpat
      left join Users users on to_char(Report.SubmitDocID) =
                               to_char(users.ID)
     where (to_char(inp.NoOfInpat) = v_NoOfInpat or v_NoOfInpat = '')
       and to_char(Report.SubmitDate, 'yyyy-mm-dd') >= v_DateTimeBegin
       and to_char(Report.SubmitDate, 'yyyy-mm-dd') <= v_DateTimeEnd
       and (to_char(Report.SubmitDocID) = v_SubmitDocID or
           v_SubmitDocID = '');
    -----查询RIS信息
  elsif v_QCStatType = 'RIS' then
  
    select (select Name from HospitalInfo where rownum <= 1) HospName,
           '【' + inp.Name + '】' + '检查报告' ReportTitle,
           report.ReportNo ApplyNo,
           report.ID TechNo,
           '检查报告' TechNoName,
           '' WardorRegDesc,
           inp.Name PatName,
           de.Name Sex,
           inp.AgeStr Age,
           inp.NoOfRecord HospNo,
           dept.Name ApplyDeptName,
           inp.OutBed BedNo,
           inp.OutHosWard Ward,
           diag.Name Lczd,
           '' ApplyDoctor,
           to_char(report.SubmitDate, 'yyyy-mm-dd') ExecTime,
           '' ExecDoctor,
           '' Instrument,
           risreslut.Line,
           risreslut.ItemName,
           risreslut.Result
      from InpatientReportRISReslut risreslut
      left join InpatientReport report on risreslut.ReportID = report.ID
      left join InPatient inp on inp.NoOfInpat = report.NoOfInpat
      left join Dictionary_detail de on de.CategoryID = '3'
                                    and de.DetailID = inp.SexID
      left join Department dept on dept.ID = inp.OutHosDept
      left join Diagnosis diag on diag.ICD = inp.AdmitDiagnosis
      left join Users users on to_char(users.ID) =
                               to_char(report.SubmitDocID)
     where to_char(risreslut.ReportID) = v_ReportID;
  
    -----查询LIS信息
  elsif v_QCStatType = 'LIS' then
    select (select Name from HospitalInfo where rownum <= 1) ReportTitle,
           report.ReportNo ApplyNo,
           report.ID TechNoDesc,
           inp.Name PatName,
           de.Name SexDesc,
           inp.AgeStr AgeDesc,
           inp.NoOfRecord HospNo,
           dept.Name ApplyDeptName,
           inp.OutBed BedNo,
           '' SampleDesc,
           to_char(report.SubmitDate, 'yyyy-mm-dd') ReceiveTime,
           '' SampleTime,
           diag.Name ClinicDesc,
           '' SampleDescDesc,
           '' PatPropNoDesc,
           inp.OutHosWard WardDesc,
           users.Name ToDocName,
           '' ExecDocName,
           '' ExecTime,
           '' ReportTime,
           '' VerifierName,
           to_char(report.ReleaseDate, 'yyyy-mm-dd') pubtime,
           '' Comment,
           report.ReportName,
           lisreslut.Line,
           lisreslut.ItemName,
           lisreslut.Result,
           lisreslut.ReferValue Refer,
           lisreslut.Unit,
           lisreslut.ResultColor
    
      from InpatientReportLISReslut lisreslut
      left join InpatientReport report on lisreslut.ReportID = report.ID
      left join InPatient inp on inp.NoOfInpat = report.NoOfInpat
      left join Dictionary_detail de on de.CategoryID = '3'
                                    and de.DetailID = inp.SexID
      left join Department dept on dept.ID = inp.OutHosDept
      left join Diagnosis diag on diag.ICD = inp.AdmitDiagnosis
      left join Users users on to_char(users.ID) =
                               to_char(report.SubmitDocID)
    
     where to_char(lisreslut.ReportID) = v_ReportID
    
     order by lisreslut.Line;
  end if;

end;
/

prompt
prompt Creating procedure USP_GETJOBPERMISSIONINFO
prompt ===========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetJobPermissionInfo  (v_JobId VARCHAR)
AS /**********
 版本号
 创建时间
 作者
 版权
 描述
 功能说明      输出所有岗位信息
 输出参数
 结果集、排序
 调用的sp
 调用实例
**********/

    BEGIN
        SELECT  *
        FROM    Job2Permission
        WHERE   ID = v_JobId;
    end;
/

prompt
prompt Creating procedure USP_GETKNOWLEDGEPUBLICINFO
prompt =============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetKnowledgePublicInfo(v_OrderType numeric --所属类别
                                                       ) as /**********
 版本号  1.0.0.0.0
 创建时间
 作者
 版权
 描述  编辑家族信息
 功能说明
 输入参数
 输出参数
 结果集、排序

 exec usp_GetKnowledgePublicInfo v_OrderType=

 调用的sp
 调用实例

 修改记录
**********/

begin

  select Node, Title, ParentNode, Context, OrderValue, OrderType
    from KnowledgePublic
   where OrderType = v_OrderType
     and Valid = 1
   order by Node, OrderValue;

end;
/

prompt
prompt Creating procedure USP_GETLOOKUPEDITORDATA
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetLookUpEditorData(v_QueryType numeric, --查询的类型
                                                    v_QueryID   numeric default 0) as /**********
 版本号  1.0.0.0.0
 创建时间
 作者
 版权
 描述  获取需要在lookupeditor里显示的数据,最好包括ID，Name,Py,Memo，这样可以在APP里调用时用统一的方法
 功能说明
 输入参数
 输出参数
 结果集、排序

 调用的sp
 调用实例

 修改记录
**********/
begin
  if v_QueryType = 1 then
    --病人性质(即 医疗付款方式)
  
    select DetailID as ID, 
    Name,
     Py,
      Memo
      from Dictionary_detail
     where CategoryID = 1
       and Valid = 1
     order by ID;
  
  elsif v_QueryType = 2 then
    --病人性别
  
    select DetailID as ID, Name, Py, Memo
      from Dictionary_detail
     where CategoryID = 3
       and Valid = 1
     order by ID;
  
  elsif v_QueryType = 3 then
    --婚姻状况
  
    select DetailID as ID, Name, Py, Memo
      from Dictionary_detail
     where CategoryID = 4
       and Valid = 1
     order by ID;
  
  elsif v_QueryType = 4 then
    --职业代码
  
    select DetailID as ID, Name, Py, Memo
      from Dictionary_detail
     where CategoryID = 41
       and Valid = 1
     order by ID;
  
  elsif v_QueryType = 5 then
    --省市代码
  
    select ID, Name, Py, Memo from Areas where Category = 1000 order by ID;
  
  elsif v_QueryType = 6 then
    --民族代码
  
    select DetailID as ID, Name, Py, Memo
      from Dictionary_detail
     where CategoryID = 42
       and Valid = 1
     order by ID;
  
  elsif v_QueryType = 7 then
    --国籍代码
  
    select DetailID as ID, Name, Py, Memo
      from Dictionary_detail
     where CategoryID = 43
       and Valid = 1
     order by ID;
  
  elsif v_QueryType = 8 then
    --联系关系
  
    select DetailID as ID, Name, Py, Memo
      from Dictionary_detail
     where CategoryID = 44
       and Valid = 1
     order by ID;
  
  elsif v_QueryType = 9 then
    --临床科室
  
    select ID, Name, Py, Memo
      from Department dept
     where Valid = 1
       and exists (select 1 from Dept2Ward where DeptID = dept.ID)
     order by ID;
  
  elsif v_QueryType = 10 then
    --临床病区
  
    select ID, Name, Py, Memo from Ward where Valid = 1 order by ID;
  
  elsif v_QueryType = 11 then
    --操作人员，所有
  
    select ID, Name, Py, Memo from Users where Valid = 1 order by ID;
  
  elsif v_QueryType = 12 then
    --诊断，所有
  
    select MarkId as ID, Name, Py, Memo, ICD
      from Diagnosis
     where Valid = 1
     order by ID;
  
  elsif v_QueryType = 13 then
    --区县代码
  
    select ID, Name, Py, Memo, ParentID, ParentName
      from Areas
     where Category = 1001
     order by ID;
  
  elsif v_QueryType = 14 then
    --麻醉方式,需要修改
  
    select DetailID as ID, Name, Py, Memo
      from Dictionary_detail
     where CategoryID = 30
       and Valid = 1
     order by ID;
  
  elsif v_QueryType = 15 then
    --切口愈合等级,需要修改
  
    select 1 as ID, 'I/甲' Name, 'yj' Py, null Memo
      from dual
    union all
    select 2 as ID, 'II/甲' Name, 'ej' Py, null Memo
      from dual
    union all
    select 3 as ID, 'III/甲' Name, 'sj' Py, null Memo
      from dual
    union all
    select 4 as ID, 'I/乙' Name, 'yy' Py, null Memo
      from dual
    union all
    select 5 as ID, 'II/乙' Name, 'ey' Py, null Memo
      from dual
    union all
    select 6 as ID, 'III/乙' Name, 'sy' Py, null Memo
      from dual
    union all
    select 7 as ID, 'I/丙' Name, 'yb' Py, null Memo
      from dual
    union all
    select 8 as ID, 'II/丙' Name, 'eb' Py, null Memo
      from dual
    union all
    select 9 as ID, 'III/丙' Name, 'sb' Py, null Memo
      from dual
     order by ID;
  
  elsif v_QueryType = 16 then
    -- 
  
    select ID, Name, Py, Memo
      from CategoryDetail
     where CategoryID = v_QueryID
     order by ID;
     
  elsif v_QueryType = 111 then
    --操作人员，护理  402
  
    select ID, Name, Py, Memo from Users where  Valid = 1 and category = '402'  order by ID;
  elsif v_QueryType = 112 then
    --操作人员，护理  401 400 403 
  
    select ID, Name, Py, Memo from Users where  Valid = 1 and (category = '400' or category = '401' or category = '403' )  order by ID;
  end if;
end;
/

prompt
prompt Creating procedure USP_GETMEDICALRRECORDVIEW
prompt ============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetMedicalRrecordView(v_DeptCode      varchar default '',
                                                      v_DateTimeBegin varchar,
                                                      v_DateTimeEnd   varchar,
                                                      v_PatientName   varchar default '',
                                                      v_RecordID      varchar default '',
                                                      v_ApplyDoctor   varchar default '',
                                                      v_QCStatType    int,
                                                      
                                                      --Add wwj 用于模糊查询
                                                      v_PatID varchar default '') as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  按科室或科室对应病人的归档或未归档电子病历
   功能说明
   输入参数
    v_DeptCode varchar(10)=''    --科室编号
    v_DateTimeBegin varchar(9)       --开始时间
     v_v_DateTimeEnd  varchar(9)       --结束时间
     v_PatientName  varchar(20)='',   --病人姓名
      v_RecordID  varchar(20)='',      --病历
     v_QCStatType int,                 --统计资料类型，1：已归档、2：申请借阅
     v_ApplyDoctor     varchar(6) ,        --申请医师代码
  
     --Add wwj 用于模糊查询
     v_PatID           varchar(32),       --病历号
   输出参数
   结果集、排序
  质量控制统计数据集
  
   调用的sp
   调用实例
   exec usp_GetMedicalRrecordView '', '2011-01-01', '2011-05-26','','','',1, ''
    exec usp_GetMedicalRrecordView '10', '', '','','','',3
    exec usp_GetMedicalRrecordView v_DeptCode='',v_DateTimeBegin='2001-03-01'
    ,v_DateTimeEnd='2011-03-10',v_QCStatType='1',v_PatientName='',v_RecordID='',v_ApplyDoctor=''
    exec usp_GetMedicalRrecordView v_DeptCode='3202',v_DateTimeBegin='2011-03-01',v_DateTimeEnd='2011-03-25'
    ,v_QCStatType='2',v_PatientName='',v_RecordID='',v_ApplyDoctor='00'
  
    exec usp_GetMedicalRrecordView v_DeptCode='3202',v_DateTimeBegin='2011-03-01'
    ,v_DateTimeEnd='2011-04-27',v_QCStatType='2',v_PatientName='',v_RecordID='',v_ApplyDoctor='00'
  
    exec usp_GetMedicalRrecordView v_DeptCode='3202',v_DateTimeBegin='2011-04-01'
    ,v_DateTimeEnd='2011-04-27',v_QCStatType='2',v_PatientName='',v_RecordID='',v_ApplyDoctor='00'
  
   修改记录
  **********/
  v_sql       varchar(4000);
  v_where     varchar(100) default '';
  v_LeftWhere varchar(100) default '';
  v_DeptWhere varchar(100) default '';
begin

  if v_DeptCode != '' then
    v_where := 'and inp.OutHosDept=''' + v_DeptCode + '''';
  end if;

  if v_PatID != '' then
    v_where := v_where + ' and inp.PatID like ' + '''%' + v_PatID + '%''';
  end if;

  if v_PatientName != '' then
    v_where := v_where + ' and inp.Name like ' + '''%' + v_PatientName +
               '%''';
  end if;

  if v_RecordID != '' then
    v_where := v_where + ' and inp.NoOfRecord=''' + v_RecordID + '''';
  end if;

  if v_ApplyDoctor != '' then
    v_where := v_where + ' and ar.ApplyDoctor=''' + v_ApplyDoctor + '''';
    --set v_LeftWhere=' and ar.ApplyDoctor='''+v_ApplyDoctor+''''
  end if;

  if v_QCStatType = '1' then
  
    --患者已归档病历阅览
    v_sql := N' SELECT ROW_NUMBER() OVER (ORDER BY inp.NoOfInpat ASC) AS RowID
      ,inp.NoOfInpat AS NoOfInpat,inp.PatNoOfHis AS PatNoOfHis
    ,inp.Name AS Name,dd.Name AS SexName,inp.InCount as InCount, inp.AgeStr AS AgeStr
    ,inp.AdmitDate as AdmitDate, bed.WardId AS WardId, bed.DeptID AS DeptID, bed.ID  AS BedID
    ,datediff(dd,inp.AdmitDate,isnull(inp.OutWardDate,getdate()))+1 inhosdays,inp.OutWardDate
    ,case when (SELECT count(NoOfInpat)  FROM MedicalRecord where MedicalRecord.NoOfInpat = inp.NoOfInpat)>0
    then ''已经治'' else ''未经治'' end as StatusName,inp.Resident,us3.Name as ResidentName
    ,inp.Attend,us1.Name as AttendName ,inp.Chief ,us2.Name as ChiefName,inp.Status
    ,inp.PatID RecordID --mr.ID as RecordID
    ,inp.NoOfRecord,inp.OutBed,inp.OutHosDept,de1.Name as DeptName,med.LockInfo
    ,ar. Status  as ApplyStatusID,cd1.Name as ApplyStatus
    FROM InPatient inp
    left join MedicalRecord med ON inp.NoOfInpat = med.NoOfInpat
    left join Dictionary_detail dd (nolock) ON dd.CategoryID = ''3'' AND inp.SexID = dd.DetailID
    left join Bed bed (nolock) ON inp.NoOfInpat = bed.NoOfInpat
    left join Ward ward (nolock) on bed.WardId = ward.ID
    left join Department de (nolock) on bed.DeptID = de.ID
    left join Users us1 on us1.ID=inp.Attend
    left join Users us2 on us2.ID=inp.Chief
    left join Users us3 on us3.ID=inp.Resident
    left join Department de1 (nolock) on inp.OutHosDept = de1.ID
    --left join MedicalRecord mr on mr.NoOfInpat = inp.NoOfInpat
    --left join ApplyRecord ar on ar.NoOfInpat=inp.NoOfInpat

    --串病历借阅记录表，得到病历借阅的状态
    left join ApplyRecord ar on ar.NoOfInpat=inp.NoOfInpat
    left join CategoryDetail cd1 on cd1.CategoryID = 52 and cd1.ID = ar. Status

    WHERE inp.Status IN  (''1502'',''1503'') AND CONVERT(varchar(10),ar.ApplyDate,102) >= ''' +
             v_DateTimeBegin + '''
     AND CONVERT(varchar(10),ar.ApplyDate,102) <= ''' +
             v_DateTimeEnd + '''' + v_where +
             'AND med.LockInfo=''4701''   order by inp.NoOfInpat';
  
  elsif v_QCStatType = '2' then
  
    --申请借阅患者病历
    v_sql := N' SELECT ROW_NUMBER() OVER (ORDER BY inp.NoOfInpat ASC) AS RowID
      ,inp.NoOfInpat AS NoOfInpat,inp.PatNoOfHis AS PatNoOfHis,inp.PatID AS PatID,de.Name as DeptName
    ,inp.Name AS Name,dd.Name AS SexName,inp.InCount as InCount, inp.AgeStr AS AgeStr
    ,inp.AdmitDate as AdmitDate,inp.OutWardDate, inp.OutHosDept AS DeptID,ds.Name as DiagnosisName
    ,inp.PatID RecordID --mr.ID as RecordID
    ,inp.NoOfRecord
    FROM InPatient inp
    left join MedicalRecord med ON inp.NoOfInpat = med.NoOfInpat
    left join Dictionary_detail dd (nolock) ON dd.CategoryID = ''3'' AND inp.SexID = dd.DetailID
    left join Bed bed (nolock) ON inp.NoOfInpat = bed.NoOfInpat
    left join Ward ward (nolock) on bed.WardId = ward.ID
    left join Department de (nolock) on inp.OutHosDept = de.ID
    left join Diagnosis  ds on inp.OutDiagnosis=ds.MarkId
    left join MedicalRecord mr on mr.NoOfInpat = inp.NoOfInpat
    WHERE inp.Status IN  (''1502'',''1503'')' + v_where +
             ' AND med.LockInfo=''4701''  order by inp.NoOfInpat';
  
  end if;
  execute immediate v_sql;

end;
/

prompt
prompt Creating procedure USP_GETMEDICALRRECORDVIEWFRM
prompt ===============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetMedicalRrecordViewFrm(v_GetType varchar --获取数据类型，1：科室、2：申请借阅目的、3：申请期限单位
                                                         ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  保存申请借阅电子病历信息
   功能说明
   输入参数
   输出参数
   结果集、排序
  
  
   调用的sp
   调用实例
  exec usp_GetMedicalRrecordViewFrm '1'
   修改记录
  **********/

begin

  if v_GetType = '1' then
    --查询科室 全院 + 临床科室
    select '0000' as ID, '全院' as Name
      from dual
    union
    select ID, Name
      from Department, Dept2Ward dw
     where Department.ID = dw.DeptID
     order by ID;
  
  elsif v_GetType = '2' then
  
    --查询借阅目的
    select ID, Name
      from CategoryDetail
     where CategoryID = '50'
     order by ID;
  
  elsif v_GetType = '3' then
  
    --借阅时间单位
    select ID, Name
      from CategoryDetail
     where CategoryID = '51'
     order by ID;
  end if;
end;
/

prompt
prompt Creating procedure USP_GETNOTESONNURSINGINFO
prompt ============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetNotesOnNursingInfo(v_NoOfInpat    numeric, --首页序号(住院流水号)
                                                      v_DateOfSurvey varchar --测量日期期（格式2010-01-01）
                                                      ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取护理信息数据
   功能说明
   输入参数
   输出参数
   结果集、排序
  
  
   调用的sp
   调用实例
  
   修改记录
  **********/

begin
  --获取护理信息数据
  select *
    from NotesOnNursing
   where DateOfSurvey = v_DateOfSurvey
     and NoOfInpat = v_NoOfInpat;

end;
/

prompt
prompt Creating procedure USP_GETNURSINGRECORDBYDATE
prompt =============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetNursingRecordByDate(v_NoOfInpat numeric default '0', --首页序号
                                                       v_BeginDate varchar, --起始时间
                                                       v_EndDate   varchar --终止时间
                                                       ) as
begin

  select non.*,
         CASE
           WHEN non.WayOfSurvey = '8800' THEN
            '8801'
           ELSE
            to_char(non.WayOfSurvey)
         end TestType --护理级别
    from NotesOnNursing non
   where non.NoOfInpat = v_NoOfInpat
     and v_BeginDate <= non.DateOfSurvey
     and non.DateOfSurvey <= v_EndDate
   order by non.DateOfSurvey, to_number(non.TimeSlot);

end;
/

prompt
prompt Creating procedure USP_GETNURSINGRECORDPARAM
prompt ============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetNursingRecordParam(v_FrmType varchar --窗体操作类型
                                                      ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取护理文书项目窗体参数
   功能说明
   输入参数
   输出参数
   结果集、排序
  
  
   调用的sp
   调用实例
  
   修改记录
  **********/

begin

  if v_FrmType = '1' then
  
    --获取生命体征记录时间段
    select Configkey, Value
      from APPCFG
     where Configkey in ('VITALSIGNSRECORDTIME', 'MODIFYNURSINGINFO');
  end if;
end;
/

prompt
prompt Creating procedure USP_GETPATIENTBEDINFOBYDATE
prompt ==============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetPatientBedInfoByDate(v_NoOfInpat    numeric default '0', --首页序号
                                                        v_AllocateDate varchar --指定的时间
                                                        ) AS
BEGIN

  select *
    from (select bi.FormerBedID, --病床号
                 d. Name as DeptName, --部门名称
                 (select hi. Name from HospitalInfo hi) as HospitalName
            from BedInfo bi
            left outer join Department d on d.ID = bi.FormerDeptID
           where bi.NoOfInpat = v_NoOfInpat
             and bi.StartDate <= v_AllocateDate
           order by bi.StartDate desc) temp
   where rownum <= 1;

end;
/

prompt
prompt Creating procedure USP_GETPATIENTINFOFORTHREEMEAS
prompt =================================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetPatientInfoForThreeMeas(v_NoOfInpat numeric default '0' --首页序号
                                                           ) AS
BEGIN

  select dd. Name as gender,
         d. Name as dept_name,
         ip.AdmitBed,
         ip. Name as patient_name,
         ip.AgeStr,
         ip.AdmitDate,
         ip.PatID,
         ip.OutHosDate,
         ip.AdmitBed,
         ip.NoOfInpat
    from InPatient ip
    LEFT OUTER JOIN Dictionary_detail dd on dd.DetailID = ip.SexID
                                        AND dd.CategoryID = 3 --性别
    LEFT OUTER JOIN Department d on d.ID = ip.AdmitDept --部门
   where ip.NoOfInpat = v_NoOfInpat; --根据首页序号得到病人的基本信息
end;
/

prompt
prompt Creating procedure USP_GETRECORDMANAGEFRM
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetRecordManageFrm(v_FrmType    varchar, --窗体类型，1n：病人信息管理维护窗体、2n：病人病历史信息窗体
                                                   v_PatNoOfHis numeric default '0', --首页序号
                                                   v_CategoryID varchar default '' --(字典)类别代码 、或父节点代码 、首页序号
                                                   ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取病历管理窗体控件初始化数据
   功能说明
   输入参数
   输出参数
   结果集、排序
  
  
   调用的sp
   调用实例
  
   修改记录
  **********/

begin

  if v_FrmType = '1' then
  
    --获取字典表信息
    select CategoryID, cast(ID as varchar(4)) as DetailID, Name, Py, Wb
      from CategoryDetail
     where CategoryID = v_CategoryID
       and ID != '4701';
  
  elsif v_FrmType = '2' then
  
    --获取手术名称
    select * from Surgery order by Name;
  end if;
end;
/

prompt
prompt Creating procedure USP_GETRECORDNOONFILE
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetRecordNoOnFile(v_DateBegin   varchar, --开始日期
                                                  v_DateEnd     varchar, --结束日期
                                                  v_DeptID      varchar, --科室代码
                                                  v_Status      varchar, --病历状态
                                                  v_PatientName varchar default '', --病人姓名
                                                  v_RecordID    varchar default '' --病历号
                                                  ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取未归档病历
   功能说明
   输入参数
   输出参数
   结果集、排序
  
  
  
   调用的sp
   调用实例
   exec usp_GetRecordNoOnFileNew v_DateBegin='2011-04-01',v_DateEnd='2011-04-26',v_DeptID='0000',v_Status='4700,4702,4703'
  
   修改记录
  **********/
  v_sql varchar(4000);
begin

  --获取未归档病历
  v_sql := 'select mr.LockInfo,inp.*,dept.Name as OutHosDeptName,dd.Name as SexName
      ,d.Name as DiagnosisName,cd.Name as LockInfoName
      ,datediff(yy,inp.Birth,getdate()) as InpAgeNum
      ,datediff(dd,inp.AdmitDate,isnull(inp.OutWardDate,getdate()))+1 as InHosDay
      ,datediff(dd,inp.OutWardDate,getdate()) as OutHosDay
      ,case when (SELECT count(NoOfInpat)  FROM MedicalRecord where MedicalRecord.NoOfInpat = inp.NoOfInpat)>0
      then ''已经治'' else ''未经治'' end as StatusName
      ,us3.Name as ResidentName,us1.Name as AttendName,us2.Name as ChiefName
      ,mr.ID as RecordID,b.ID  AS BedID,b.WardId as WardId

  from InPatient inp
    left join  Department dept on dept.ID=inp.OutHosDept
    left join  Dictionary_detail dd on dd.CategoryID=''3'' and dd.DetailID=inp.SexID
    left join  Diagnosis d on d.ICD=inp.OutDiagnosis
    left join  MedicalRecord mr on mr.NoOfInpat=inp.NoOfInpat
    left join  CategoryDetail cd on cd.CategoryID=''47'' and cd.ID=mr.LockInfo
    left join  Bed b ON inp.NoOfInpat = b.NoOfInpat
    left join Users us1 on us1.ID=inp.Attend
    left join Users us2 on us2.ID=inp.Chief
    left join Users us3 on us3.ID=inp.Resident

  where inp.OutWardDate>= ''' + v_DateBegin + ' 00:00:00''' + '
        and inp.OutWardDate<''' + v_DateEnd + ' 24:00:00''' + '
        and inp.Status in(''1502'',''1503'')
        and (inp.OutHosDept=''' + v_DeptID + ''' or ''' +
           v_DeptID + '''=''0000'')
        and  mr.LockInfo in (' + v_Status + ')
        and (inp.Name=''' + v_PatientName + ''' or ''' +
           v_PatientName + '''='''')
        and (inp.NoOfRecord=''' + v_RecordID + ''' or ''' +
           v_RecordID + '''='''')
  order by OutWardDate';

  execute immediate v_sql;

end;
/

prompt
prompt Creating procedure USP_GETRECORDNOONFILENEW
prompt ===========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetRecordNoOnFileNew(v_DateBegin   varchar, --开始日期
                                                     v_DateEnd     varchar, --结束日期
                                                     v_DeptID      varchar, --科室代码
                                                     v_Status      varchar, --病历状态
                                                     v_PatientName varchar default '', --病人姓名
                                                     v_RecordID    varchar default '' --病历号
                                                     ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取未归档病历
   功能说明
   输入参数
   输出参数
   结果集、排序
  
  
  
   调用的sp
   调用实例
   exec usp_GetRecordNoOnFileNew v_DateBegin='2011-04-01',v_DateEnd='2011-04-26',v_DeptID='0000',v_Status='4700,4703'
  
   修改记录
  **********/
  v_sql varchar(4000);
begin

  --获取未归档病历
  v_sql := 'select mr.LockInfo,inp.*,dept.Name as OutHosDeptName,dd.Name as SexName
      ,d.Name as DiagnosisName,cd.Name as LockInfoName
      ,datediff(yy,inp.Birth,getdate()) as InpAgeNum
      ,datediff(dd,inp.AdmitDate,isnull(inp.OutWardDate,getdate()))+1 as InHosDay
      ,datediff(dd,inp.OutWardDate,getdate()) as OutHosDay
      ,case when (SELECT count(NoOfInpat)  FROM MedicalRecord where MedicalRecord.NoOfInpat = inp.NoOfInpat)>0
      then ''已经治'' else ''未经治'' end as StatusName
      ,us3.Name as ResidentName,us1.Name as AttendName,us2.Name as ChiefName
      ,mr.ID as RecordID,b.ID  AS BedID,b.WardId as WardId
  from InPatient inp
    left join  Department dept on dept.ID=inp.OutHosDept
    left join  Dictionary_detail dd on dd.CategoryID=''3'' and dd.DetailID=inp.SexID
    left join  Diagnosis d on d.ICD=inp.OutDiagnosis
    left join  MedicalRecord mr on mr.NoOfInpat=inp.NoOfInpat
    left join  CategoryDetail cd on cd.CategoryID=''47'' and cd.ID=mr.LockInfo
    left join  Bed b ON inp.NoOfInpat = b.NoOfInpat
    left join Users us1 on us1.ID=inp.Attend
    left join Users us2 on us2.ID=inp.Chief
    left join Users us3 on us3.ID=inp.Resident
  where inp.OutWardDate>= ''' + v_DateBegin + ' 00:00:00''' + '
        and inp.OutWardDate<''' + v_DateEnd + ' 24:00:00''' + '
        and inp.Status in(''1502'',''1503'')
        and (inp.OutHosDept=''' + v_DeptID + ''' or ''' +
           v_DeptID + '''=''0000'')
        and  mr.LockInfo in (' + v_Status + ')
        and (inp.Name=''' + v_PatientName + ''' or ''' +
           v_PatientName + '''='''')
        and (inp.NoOfRecord=''' + v_RecordID + ''' or ''' +
           v_RecordID + '''='''')
  order by OutWardDate';

  execute immediate v_sql;

end;
/

prompt
prompt Creating procedure USP_GETRECORDONFILE
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetRecordOnFile(v_DateBegin    varchar, --开始日期
                                                v_DateEnd      varchar, --结束日期
                                                v_PatID        varchar default '', --住院号码
                                                v_Name         varchar default '', --患者姓名
                                                v_SexID        varchar default '', --病人性别
                                                v_AgeBegin     varchar default '', --开始年龄
                                                v_AgeEnd       varchar default '', --结束年龄
                                                v_OutHosDept   varchar default '', --出院科室科室
                                                v_OutDiagnosis varchar default '', --出院诊断
                                                v_SurgeryID    varchar default '' --手术代码
                                                ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取已归档病历
   功能说明
   输入参数
   输出参数
   结果集、排序
  
  
  
   调用的sp
   调用实例
  
   exec usp_GetRecordOnFile v_DateBegin='2011-03-02'
       ,v_DateEnd='2011-03-10',v_PatID='',v_Name='',v_SexID=''
       ,v_AgeBegin='',v_AgeEnd='',v_OutHosDept='0000',v_OutDiagnosis=''
       ,v_SurgeryID=''
   修改记录
  **********/

begin

  --获取已归档病历
  select inp.*,
         dept.Name as OutHosDeptName,
         dd.Name as SexName,
         u1.Name as ResidentName,
         u2.Name as AttendName,
         u3.Name as ChiefName,
         d.Name as OutDiagnosisName,
         s.Name as SurgeryName,
         mr.LockDate
    from InPatient inp
    left join Department dept on dept.ID = inp.OutHosDept
    left join Dictionary_detail dd on dd.CategoryID = '3'
                                  and dd.DetailID = inp.SexID
    left join Users u1 on u1.ID = inp.Resident
    left join Users u2 on u2.ID = inp.Attend
    left join Users u3 on u3.ID = inp.Chief
    left join Diagnosis d on d.ICD = inp.OutDiagnosis
    left join MedicalRecord mr on mr.NoOfInpat = inp.NoOfInpat
    left join DiseaseCFG dc on dc.ID = mr.Disease
    left join Surgery s on s.ID = dc.SurgeryID
   where inp.OutWardDate >= v_DateBegin + ' 00:00:00 '
     and inp.OutWardDate < v_DateEnd + ' 24:00:00 '
     and (inp.PatID = v_PatID or v_PatID = '')
     and (inp.Name = v_Name or v_Name = '')
     and (inp.SexID = v_SexID or v_SexID = '')
     and (datediff('yy',
                   inp.Birth,
                   to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss')) - 1 >=
         v_AgeBegin or v_AgeBegin = '')
     and (datediff('yy',
                   inp.Birth,
                   to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss')) - 1 <=
         v_AgeEnd or v_AgeEnd = '')
     and (inp.OutHosDept = v_OutHosDept or v_OutHosDept = '0000')
     and (inp.OutDiagnosis = v_OutDiagnosis or v_OutDiagnosis = '')
     and (s.ID = v_SurgeryID or v_SurgeryID = '')
     and inp.Status in ('1502', '1503')
     and mr.LockInfo = '4701'
   order by OutWardDate;

end;
/

prompt
prompt Creating procedure USP_GETSIGNINRECORD
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetSignInRecord(v_DateBegin  varchar, --开始日期
                                                v_DateEnd    varchar, --结束日期
                                                v_OutHosDept varchar --出院科室科室
                                                ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取待签收归还病历
   功能说明
   输入参数
   输出参数
   结果集、排序
  
  
  
   调用的sp
   调用实例
  
   exec usp_GetSignInRecord v_DateBegin=N'2011-03-02',v_DateEnd=N'2011-03-09',v_OutHosDept=N'0000'
  
   修改记录
  **********/

begin

  --获取待签收归还病历
  select ar.*,
         u1.Name as ApplyDoctorName,
         u2.Name as AuditManName,
         cd1.Name as ApplyAimName,
         cd2.Name as UnitName,
         inp.NoOfRecord,
         inp.InCount,
         inp.Name,
         dd.Name as InpSexName,
         inp.AgeStr,
         dept.Name as OutHosDeptName,
         inp.PatID,
         inp.AdmitDate,
         inp.OutHosDate,
         d.Name as OutDiagnosisName,
         s.Name as SurgeryName,
         inp.Name as InpName
    from ApplyRecord ar
    left join InPatient inp on inp.NoOfInpat = ar.NoOfInpat
    left join Department dept on dept.ID = inp.OutHosDept
    left join Users u1 on u1.ID = ar.ApplyDoctor
    left join Users u2 on u2.ID = ar.AuditMan
    left join CategoryDetail cd1 on cd1.CategoryID = '50'
                                and cd1.ID = ar.ApplyAim
    left join CategoryDetail cd2 on cd2.CategoryID = '51'
                                and cd2.ID = ar.Unit
    left join Dictionary_detail dd on dd.CategoryID = '3'
                                  and dd.DetailID = inp.SexID
    left join Diagnosis d on d.ICD = inp.OutDiagnosis
    left join MedicalRecord mr on mr.NoOfInpat = inp.NoOfInpat
    left join DiseaseCFG dc on dc.ID = mr.Disease
    left join Surgery s on s.ID = dc.SurgeryID
   where ar.ApplyDate >= v_DateBegin + ' 00:00:00 '
     and ar.ApplyDate < v_DateEnd + ' 24:00:00'
     and (inp.OutHosDept = v_OutHosDept or v_OutHosDept = '0000')
     and ar.Status = '5205'
   order by OutHosDeptName;

end;
/

prompt
prompt Creating procedure USP_GETTEMPLATEPERSONGROUP
prompt =============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetTemplatePersonGroup(v_UserID varchar default '')

 as /**********
 版本号  1.0.0.0.0
 创建时间
 作者
 版权
 描述  获取质量评分
 功能说明
 输入参数
    v_NoOfInpat    numeric(9,0),     首页序号
  v_NodeID       int,      节点ID
  v_TemplateID   varchar(64),   模板ID
  v_ParentNodeID int,      父节点ID
  v_Name         varchar(64),   节点名称
  v_UserID       varchar(18),     用户ID
  v_TypeID       int       类别：判断是插入还是删除
 输出参数
 结果集、排序
质量控制统计数据集

 调用的sp
 调用实例
 修改记录
**********/
begin

  select t.ID,
         t.NodeID,
         t.ParentNodeID,
         tsp.TemplateID as TemplateID,
         t.TemplatePersonID,
         tsp. Name,
         t.NodeName,
         t.UserID,
         tsp.SortID,
         tsp.Memo
    from TemplatePersonGroup t
    left outer join Template_Person tsp on tsp.ID = t.TemplatePersonID
                                       and tsp.Valid = '1'
   where t.UserID = v_UserID
   order by t.NodeID;

  select ID, TemplateID, Name, Memo, '是' as Used, SortID
    from Template_Person
   Where UserID = v_UserID
     and SortID <> '0000'
     and Valid = 1;

end;
/

prompt
prompt Creating procedure USP_GETUSERINFO
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_GetUserInfo(v_userid varchar) as
  /**********
   版本号  1.0.0.0.0
   创建时间  2011.5.10
   作者
   版权
   描述  获取职工相关信息
   功能说明
   输入参数
    v_userid 职工代码
   输出参数
   结果集、排序
   调用的sp
      usp_GetUserInfo '00'
   调用实例
  
  **********/
  v_status   int;
  v_masterid varchar(16);
  v_flag     int default - 1;
  v_sql      varchar(4000);
begin

  /*create table tmp_getuserinfo(
  userid    varchar(12) null,
  masterid  varchar(12) null,
  status    int      null
  );*/
  
  v_sql := 'truncate table tmp_getuserinfo ';
  
  execute immediate v_sql;

  insert into tmp_getuserinfo
    select a.ID, b.MasterID, a.Status
      from Users a
      left join TempUsers b on a.ID = b.UserID
     where a.ID = v_userid;
     
  select status into v_status from tmp_getuserinfo;
  
  select masterid into v_masterid from tmp_getuserinfo;

  if (v_status = 0) then
    --此账号为临时账号
    begin
      select 1
        into v_flag
        from TempUsers
       where UserID = v_userid
         and StartDate < sysdate
         and EndDate > sysdate;
         
      if v_flag > 0 then
        begin
          select '该账号尚未启用' from dual;
          return;
        end;
      end if;
    end;
  end if;
  --捞取用户基本信息
  select d.Status,
         d.ID UserID,
         a.masterid MasterID,
         d.Name UserName,
         d.Passwd,
         d.DeptId,
         d.WardID,
         b.Name DeptName,
         c.Name WardName,
         d.RegDate,
         d.ID,
         d.JobID,
         d.Valid
    from tmp_getuserinfo a, Users d
    left join Department b on d.DeptId = b.ID
    left join Ward c on d.WardID = c.ID
   where a.userid = d.ID;
   
  --捞取用户科室信息
  if (v_userid = '00') then
    begin
      select distinct a.OutHosDept DeptId,
                      b.Name       DeptName,
                      a.OutHosWard WardId,
                      c.Name       WardName
        from InPatient a, Department b, Ward c
       where a.Status not in (1500, 1503, 1508, 1509)
         and a.OutHosDept = b.ID
         and a.OutHosWard = c.ID
       order by DeptId, WardId;
    end;
  
  else
    begin
      --如果是临时用户则捞取其附属老师的账号信息
      if (v_status = 1) then
        v_masterid := v_userid;
      
        select a.DeptId, b.Name DeptName, a.WardId, c.Name WardName
          from User2Dept a
          left join Department b on a.DeptId = b.ID
          left join Ward c on a.WardId = b.ID
         where UserId = v_masterid
           and DeptId <> ''
        union
        select distinct a.DeptId,
                        b.Name DeptName,
                        c.OutHosWard WardId,
                        d.Name WardName
          from User2Dept a, Department b, InPatient c, Ward d
         where a.UserId = v_masterid
           and a.DeptId = b.ID
           and (a.WardId is null or a.WardId = '')
           and c.OutHosDept = a.DeptId
           and c.Status not in (1500, 1503, 1508, 1509)
           and c.OutHosWard = d.ID
         order by DeptName, WardName;
      end if;
    end;
  end if;
end;
/

prompt
prompt Creating procedure USP_INPATIENT_TRIGGER
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_Inpatient_Trigger(v_syxh varchar2 --病人首页序号
                                                  ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  修改病人基本信息表中数据时候，同步更新对应信息
   功能说明
   输入参数
   输出参数
   结果集、排序
  
  
  
   调用的sp
   调用实例
    exec usp_Inpatient_Trigger ''
   修改记录
  **********/
  v_csrq     varchar(19);
  v_ryrq     varchar(19);
  v_brnl     int;
  v_xsnl     varchar(19);
  v_InnerPIX varchar(24);
begin
  if v_syxh is null then
    return;
  end if;
  ---更新年龄信息
  select inp.birth, inp.admitdate
    into v_csrq, v_ryrq
    from inpatient inp
   where inp.noofinpat = v_syxh
     and rownum = 1;

  EMRPROC.usp_Emr_CalcAge(v_csrq, v_ryrq, v_brnl, v_xsnl);

  update InPatient
     set Age = v_brnl, AgeStr = v_xsnl
   where NoOfInpat = v_syxh;

  commit;

  -- 记录床位信息
  -- 找出病人床位或科室、病区信息有变化的病人

  -- 更新当前床位信息
  /*  update BedInfo set EndDate = to_char(sysdate,'yyyy-mm-dd HH24:mi:ss'), NewDept = b.OutHosDept, NewWard = b.OutHosWard, NewBed = b.OutBed, Mark = 0
  from BedInfo a, inpatient b 
  where c.NoOfInpat = b.NoOfInpat
    and a.Mark = 1*/

  update BedInfo a
     set (EndDate, NewDept, NewWard, NewBed, Mark) = (select to_char(sysdate,
                                                                     'yyyy-mm-dd HH24:mi:ss'),
                                                             b.OutHosDept,
                                                             b.OutHosWard,
                                                             b.OutBed,
                                                             0
                                                        from inpatient b
                                                       where a.noofinpat =
                                                             b.NoOfInpat)
   where a.Mark = 1
     and exists
   (select 1 from inpatient b where a.noofinpat = b.NoOfInpat);

  -- 插入最新的床位信息记录
  insert into BedInfo
    (NoOfInpat, FormerDeptID, FormerWard, FormerBedID, StartDate, Mark)
    select a.NoOfInpat,
           a.OutHosDept,
           a.OutHosWard,
           a.OutBed,
           to_char(sysdate, 'yyyy-mm-dd HH24:mi:ss'),
           1
      from inpatient a
     where a.NoOfInpat = v_syxh;

  -- 处理关联病人

  -- 有社保卡号的，找出社保卡号相同的最小住院号
  select min(a.PatID)
    into v_InnerPIX
    from inpatient a
   where a.idno =
         (select b.idno from inpatient b where b.noofinpat = v_syxh);

  -- 更新关联的住院号码
  update InPatient a set InnerPIX = v_InnerPIX where a.NoOfInpat = v_syxh;

end;
/

prompt
prompt Creating procedure USP_INSERTCONSULTATIONAPPLY
prompt ==============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_InsertConsultationApply(
                                                        -- Add the parameters for the stored procedure here
                                                        v_TypeID          int default 0,
                                                        v_ConsultApplySN  int default 0,
                                                        v_NoOfInpat       numeric default '0', --首页序号
                                                        v_UrgencyTypeID   int default 0,
                                                        v_ConsultTypeID   int default 0,
                                                        v_Abstract        varchar default '',
                                                        v_Purpose         varchar default '',
                                                        v_ApplyUser       varchar default '',
                                                        v_ApplyTime       varchar default '',
                                                        v_Director        varchar default '',
                                                        v_ConsultTime     varchar default '',
                                                        v_ConsultLocation varchar default '',
                                                        v_StateID         int default 0,
                                                        v_CreateUser      varchar default '',
                                                        v_CreateTime      varchar default '',
                                                        
                                                        v_ConsultSuggestion varchar default '',
                                                        v_FinishTime        varchar default '',
                                                        v_RejectReason      varchar default '') AS
BEGIN
  -- SET NOCOUNT ON added to prevent extra result sets from
  -- interfering with SELECT statements.

  if v_TypeID = 1 then
    --(会诊申请界面)插入数据
    BEGIN
    
      -- Insert statements for procedure here
      insert into ConsultApply
        (
         ConsultApplySn, -- this column value is auto-generated,
         NoOfInpat,
         UrgencyTypeID,
         ConsultTypeID,
         Abstract,
         Purpose,
         ApplyUser,
         ApplyTime,
         Director,
         ConsultTime,
         ConsultLocation,
         StateID,
         ConsultSuggestion,
         FinishTime,
         RejectReason,
         CreateUser,
         CreateTime,
         ModifiedUser,
         ModifiedTime,
         Valid,
         CancelUser,
         CancelTime)
      values
        (seq_ConsultApply_ID.Nextval,
        v_NoOfInpat,
         v_UrgencyTypeID,
         v_ConsultTypeID,
         v_Abstract,
         v_Purpose,
         v_ApplyUser,
         v_ApplyTime,
         v_Director,
         v_ConsultTime,
         v_ConsultLocation,
         v_StateID,
         v_ConsultSuggestion,
         v_ConsultTime,
         v_RejectReason,
         v_CreateUser,
         v_CreateTime,
         null,
         null,
         '1',
         null,
         null);
    
    end;
  end if;

  if v_TypeID = 2 then
    --（会诊申请界面）修改数据
    BEGIN
    
      update ConsultApply
         set UrgencyTypeID   = v_UrgencyTypeID,
             ConsultTypeID   = ConsultTypeID,
             Abstract        = v_Abstract,
             Purpose         = v_Purpose,
             ApplyUser       = v_ApplyUser,
             ApplyTime       = v_ApplyTime,
             Director        = v_Director,
             ConsultTime     = v_ConsultTime,
             ConsultLocation = v_ConsultLocation,
             StateID         = v_StateID,
             ModifiedUser    = v_CreateUser,
             ModifiedTime    = v_CreateTime
       where ConsultApplySn = v_ConsultApplySN;
    
      update ConsultApplyDepartment
         set Valid = '0'
       where ConsultApplySn = v_ConsultApplySN;
    end;
  end if;

  if v_TypeID = 3 then
    -- (会诊记录填写界面) 修改数据
  
    Begin
      update ConsultApply
         set ConsultSuggestion = v_ConsultSuggestion,
             FinishTime        = v_FinishTime,
             StateID           = v_StateID
       where ConsultApplySn = v_ConsultApplySN;
    
      update ConsultRecordDepartment
         set Valid = '0'
       where ConsultApplySn = v_ConsultApplySN;
    end;
  end if;

  select ca.ConsultApplySn
    from ConsultApply ca
   where ca.NoOfInpat = v_NoOfInpat
     and ca.Valid = '1'
   order by ca.ConsultApplySn desc;

end;
/

prompt
prompt Creating procedure USP_INSERTCONSULTATIONAPPLYD
prompt ===============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_InsertConsultationApplyD(
                                                         -- Add the parameters for the stored procedure here
                                                         v_ConsultApplySn  int,
                                                         v_OrderValue      int,
                                                         v_HospitalCode    varchar,
                                                         v_DepartmentCode  varchar,
                                                         v_DepartmentName  varchar,
                                                         v_EmployeeCode    varchar,
                                                         v_EmployeeName    varchar,
                                                         v_EmployeeLevelID varchar,
                                                         v_CreateUser      varchar,
                                                         v_CreateTime      varchar) AS
BEGIN
  -- SET NOCOUNT ON added to prevent extra result sets from
  -- interfering with SELECT statements.
  -- Insert statements for procedure here
  insert into ConsultApplyDepartment
    (ID, -- this column value is auto-generated,
     ConsultApplySn,
     OrderValue,
     HospitalCode,
     DepartmentCode,
     DepartmentName,
     EmployeeCode,
     EmployeeName,
     EmployeeLevelID,
     CreateUser,
     CreateTime,
     Valid,
     CancelUser,
     CancelTime)
  values
    (seq_ConsultApplyDepartment_ID.Nextval,
     v_ConsultApplySn,
     v_OrderValue,
     v_HospitalCode,
     v_DepartmentCode,
     v_DepartmentName,
     v_EmployeeCode,
     v_EmployeeName,
     v_EmployeeLevelID,
     v_CreateUser,
     v_CreateTime,
     '1',
     null,
     null);
end;
/

prompt
prompt Creating procedure USP_INSERTCONSULTATIONRECORD
prompt ===============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_InsertConsultationRecord(
                                                         -- Add the parameters for the stored procedure here
                                                         v_ConsultApplySn  int,
                                                         v_OrderValue      int,
                                                         v_HospitalCode    varchar,
                                                         v_DepartmentCode  varchar,
                                                         v_DepartmentName  varchar,
                                                         v_EmployeeCode    varchar,
                                                         v_EmployeeName    varchar,
                                                         v_EmployeeLevelID varchar,
                                                         v_CreateUser      varchar,
                                                         v_CreateTime      varchar) AS
BEGIN
  -- SET NOCOUNT ON added to prevent extra result sets from
  -- interfering with SELECT statements.

  -- Insert statements for procedure here
  insert into ConsultRecordDepartment
    (ID, -- this column value is auto-generated,
     ConsultApplySn,
     OrderValue,
     HospitalCode,
     DepartmentCode,
     DepartmentName,
     EmployeeCode,
     EmployeeName,
     EmployeeLevelID,
     CreateUser,
     CreateTime,
     Valid,
     CancelUser,
     CancelTime)
  values
    (seq_ConsultRecordDepartment_ID.Nextval,
     v_ConsultApplySn,
     v_OrderValue,
     v_HospitalCode,
     v_DepartmentCode,
     v_DepartmentName,
     v_EmployeeCode,
     v_EmployeeName,
     v_EmployeeLevelID,
     v_CreateUser,
     v_CreateTime,
     '1',
     null,
     null);
end;
/

prompt
prompt Creating procedure USP_INSERTIMAGE
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_InsertImage(v_Sort    int,
                                            v_Name    varchar,
                                            v_Content long,
                                            v_Memo    varchar default '',
                                            v_Image   clob,
                                            v_ID      numeric default '') AS
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述
   功能说明
   输入参数
  v_Sort int         --查询方式
  v_Name varchar(64)       --模板名称
  v_Content varchar(max)    --模板内容（需更改）
  v_Memo varchar(255)=''  --模板描述
  v_Image image         --模板内容
  v_ID numeric(12,0)=''       --模板ID
  
   输出参数
   结果集、排序
  图片管理器模板对图片信息进行保存更新
  
   调用的sp
   调用实例
  
   修改记录
  **********/
begin

  if v_Sort = 0 then
    insert into ImageLibrary
    values
      (seq_imagelibrary_id.nextval, v_Name, v_Content, v_Memo, 1, v_Image);
  end if;
  if v_Sort = 1 then
    update ImageLibrary
       set Name    = v_Name,
           Memo    = v_Memo,
           Image   = v_Image,
           Content = v_Content
     where ID = v_ID;
  end if;
  if v_Sort = 2 then
    update ImageLibrary set Name = v_Name, Memo = v_Memo where ID = v_ID;
  end if;
end;
/

prompt
prompt Creating procedure USP_INSERTJOB
prompt ================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_InsertJob(v_Id    VARCHAR,
                                          v_Title VARCHAR,
                                          v_Memo  VARCHAR) AS /**********
 版本号
 创建时间
 作者
 版权
 描述
 功能说明      插入岗位信息
 输出参数
 结果集、排序
 调用的sp
 调用实例
**********/

BEGIN
  INSERT INTO Jobs (Id, Title, Memo) VALUES (v_Id, v_Title, v_Memo);
end;
/

prompt
prompt Creating procedure USP_INSERTJOBPERMISSION
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_InsertJobPermission(v_ID         VARCHAR,
                                                    v_Moduleid   VARCHAR,
                                                    v_Modulename VARCHAR) AS /**********
 版本号
 创建时间
 作者
 版权
 描述
 功能说明      增加新的授权信息
 输出参数
 结果集、排序
 调用的sp
 调用实例
**********/

BEGIN
  INSERT INTO Job2Permission
    (ID, Moduleid, Modulename)
  VALUES
    (v_ID, v_Moduleid, v_Modulename);
end;
/

prompt
prompt Creating procedure USP_INSERTNURSRECORDTABLE
prompt ============================================
prompt
create or replace procedure emr.usp_InsertNursRecordTable(v_NoOfInpat  numeric, --首页序号(住院流水号)
                                           v_name       varchar, --记录单名称（模板名称+日期+时间）
                                           v_Content    clob, --数据内容
                                           v_TemplateID numeric, --模板ID
                                           v_version    varchar, --模板版本(自定义输入,默认为1.00.00,可以自增长最后1位)
                                           v_Department varchar, --病人所属科室代码
                                           v_SortID     numeric, --模板分类代码
                                           v_Valid      int --有效记录(CategoryDetail.ID CategoryID = 0)
                                           ) as

  /**********
  [版本号] 1.0.0.0.0
  [创建时间]2011-06-10
  [作者]hjh
  [版权]
  [描述]添加病人护理文档
  [功能说明]
  [输入参数]
  [输出参数]
  [结果集、排序]


  [调用的sp]
  [调用实例]

  [修改记录]
  **********/

begin
 
  --添加病人护理文档信息
  insert into NursRecordTable(NoOfInpat,
                         TemplateID,
                         Content,
                         Department,
                         version,
                         SortID,
                         Valid,
                         name) values(v_NoOfInpat,
                                      v_TemplateID,
                                      v_Content,
                                      v_Department,
                                      v_version,
                                      v_SortID,
                                      v_Valid,
                                      v_name);

end;
/

prompt
prompt Creating procedure USP_INSERTNURSTABLETEMPLATE
prompt ==============================================
prompt
create or replace procedure emr.usp_InsertNursTableTemplate(v_Name     varchar, --模板名称
                                                        v_Describe varchar, --模板描述
                                                        v_Content  clob, --模板内容
                                                        v_version  varchar, --模板版本(自定义输入,默认为1.00.00,可以自增长最后1位)
                                                        v_SortID   varchar, --模板分类代码
                                                        v_Valid    smallint --有效记录(CategoryDetail.ID CategoryID = 0)
                                                        ) as

  /**********
  [版本号] 1.0.0.0.0
  [创建时间]2011-06-10
  [作者]hjh
  [版权]
  [描述]新增护理文档模板，并返回ID
  [功能说明]
  [输入参数]
  [输出参数]
  [结果集、排序]
  
  
  [调用的sp]
  [调用实例]
  
  [修改记录]
  **********/

begin
  --新增模板
  insert into Template_Table
    (Name, Describe, Content, version, SortID, Valid)
  values
    (v_Name, v_Describe, v_Content, v_version, v_SortID, v_Valid);

  --返回新增模板ID
  select temp.ID
    from (select ID from Template_Table where Valid = 1 order by ID desc) temp
   where rownum < 1;

end;
/

prompt
prompt Creating procedure USP_INSERTTEMPLATEPERSONGROUP
prompt ================================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_InsertTemplatePersonGroup(v_UserID             varchar default '',
                                                          v_NodeID             int default 0,
                                                          v_TemplatePersonID   int default 0,
                                                          v_ParentNodeID       int default 0,
                                                          v_Name               varchar default '',
                                                          v_TypeID             int default 0,
                                                          v_TemplatePersonName varchar default '',
                                                          v_TemplatePersonMemo varchar default '') as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取质量评分
   功能说明
   输入参数
      v_NoOfInpat    numeric(9,0),     首页序号
    v_NodeID       int,      节点ID
    v_TemplateID   varchar(64),   模板ID
    v_ParentNodeID int,      父节点ID
    v_Name         varchar(64),   节点名称
    v_UserID       varchar(18),     用户ID
    v_TypeID       int       类别：判断是插入还是删除
   输出参数
   结果集、排序
  质量控制统计数据集
   execute usp_InsertTemplatePersonGroup '00', 0, '', 0, '', 2
   调用的sp
   调用实例
   修改记录
  **********/
  v_MaxNodeID           int;
  v_MaxTemplatePersonID int;
begin

  if v_TypeID = 1 then
  
    insert into TemplatePersonGroup
      (UserID, NodeID, ParentNodeID, TemplatePersonID, NodeName)
    values
      (v_UserID, v_NodeID, v_ParentNodeID, v_TemplatePersonID, v_Name);
  end if;
  if v_TypeID = 2 then
  
    delete from TemplatePersonGroup where UserID = v_UserID;
  end if;
  if v_TypeID = 3 then
  
    update Template_Person
       set Name = v_TemplatePersonName, Memo = v_TemplatePersonMemo
     where UserID = v_UserID
       and Valid = '1'
       and ID = v_TemplatePersonID;
  end if;
  if v_TypeID = 4 then
  
    begin
    
      select nvl(max(tp.NodeID) + 1, 0)
        into v_MaxNodeID
        from TemplatePersonGroup tp
       where tp.UserID = v_UserID;
    
      select nvl(max(tp.ID), 0)
        into v_MaxTemplatePersonID
        from Template_Person tp
       where tp.UserID = v_UserID
         and tp.Valid = '1'
         and tp.SortMark = '0'
         and tp.SharedID = '0';
    
      insert into TemplatePersonGroup
        (ID, UserID, NodeID, ParentNodeID, NodeName, TemplatePersonID)
      values
        (seq_TemplatePersonGroup_ID.Nextval,
         v_UserID,
         v_MaxNodeID,
         v_ParentNodeID,
         v_Name,
         v_MaxTemplatePersonID);
    end;
  end if;
end;
/

prompt
prompt Creating procedure USP_INSERTUSERLOGIN
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_InsertUserLogIn(v_ID          varchar,
                                                v_ModuleId    varchar,
                                                v_HostName    varchar,
                                                v_MACADDR     varchar,
                                                v_Client_ip   varchar,
                                                v_Reason_id   Varchar,
                                                v_Create_user varchar) as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  用户登录相关修改
   功能说明
   输入参数
  v_ID varchar(4) NOT NULL,--模块登录者ID
  v_Module_id varchar(255) ,--模块名称
  v_MACADDR varchar(255) NOT NULL,--MAC地址
  v_HostName varchar(255) NOT NULL,--HostName
  v_Client_ip varchar(255) NOT NULL,--机器Ip地址
  v_Reason_id Varchar(1) ,--登录/登出 reason 0/null 正常，1强制
  v_Create_user varchar(4) NOT NULL --登录者ID
   输出参数
   结果集、排序
  在病区的病人数据集
  
   调用的sp
   调用实例
   exec usp_InsertUserLogIn '00', '00', '00','00', '00', '00','00'
   修改记录
  **********/
begin
  INSERT INTO User_LogIn
    (ID, Module_id, HostName, MACADDR, Client_ip, Reason_id, Create_user)
  VALUES
    (v_ID,
     v_ModuleId,
     v_HostName,
     v_MACADDR,
     v_Client_ip,
     v_Reason_id,
     v_Create_user);

end;
/

prompt
prompt Creating procedure USP_INSERT_IEM_MAINPAGE_BASIC
prompt ================================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_Insert_Iem_Mainpage_Basic(v_PatNoOfHis               numeric,
                                                          v_NoOfInpat                numeric,
                                                          v_PayID                    varchar,
                                                          v_SocialCare               varchar,
                                                          v_InCount                  int,
                                                          v_Name                     varchar,
                                                          v_SexID                    varchar,
                                                          v_Birth                    char,
                                                          v_Marital                  varchar,
                                                          v_JobID                    varchar,
                                                          v_ProvinceID               varchar,
                                                          v_CountyID                 varchar,
                                                          v_NationID                 varchar,
                                                          v_NationalityID            varchar,
                                                          v_IDNO                     varchar,
                                                          v_Organization             varchar,
                                                          v_OfficePlace              varchar,
                                                          v_OfficeTEL                varchar,
                                                          v_OfficePost               varchar,
                                                          v_NativeAddress            varchar,
                                                          v_NativeTEL                varchar,
                                                          v_NativePost               varchar,
                                                          v_ContactPerson            varchar,
                                                          v_Relationship             varchar,
                                                          v_ContactAddress           varchar,
                                                          v_ContactTEL               varchar,
                                                          v_AdmitDate                varchar,
                                                          v_AdmitDept                varchar,
                                                          v_AdmitWard                varchar,
                                                          v_Days_Before              numeric,
                                                          v_Trans_Date               varchar,
                                                          v_Trans_AdmitDept          varchar,
                                                          v_Trans_AdmitWard          varchar,
                                                          v_Trans_AdmitDept_Again    varchar,
                                                          v_OutWardDate              varchar,
                                                          v_OutHosDept               varchar,
                                                          v_OutHosWard               varchar,
                                                          v_Actual_Days              numeric,
                                                          v_Death_Time               varchar,
                                                          v_Death_Reason             varchar,
                                                          v_AdmitInfo                varchar,
                                                          v_In_Check_Date            varchar,
                                                          v_Pathology_Diagnosis_Name varchar,
                                                          v_Pathology_Observation_Sn varchar,
                                                          v_Ashes_Diagnosis_Name     varchar,
                                                          v_Ashes_Anatomise_Sn       varchar,
                                                          v_Allergic_Drug            varchar,
                                                          v_Hbsag                    numeric,
                                                          v_Hcv_Ab                   numeric,
                                                          v_Hiv_Ab                   numeric,
                                                          v_Opd_Ipd_Id               numeric,
                                                          v_In_Out_Inpatinet_Id      numeric,
                                                          v_Before_After_Or_Id       numeric,
                                                          v_Clinical_Pathology_Id    numeric,
                                                          v_Pacs_Pathology_Id        numeric,
                                                          v_Save_Times               numeric,
                                                          v_Success_Times            numeric,
                                                          v_Section_Director         varchar,
                                                          v_Director                 varchar,
                                                          v_Vs_Employee_Code         varchar,
                                                          v_Resident_Employee_Code   varchar,
                                                          v_Refresh_Employee_Code    varchar,
                                                          v_Master_Interne           varchar,
                                                          v_Interne                  varchar,
                                                          v_Coding_User              varchar,
                                                          v_Medical_Quality_Id       numeric,
                                                          v_Quality_Control_Doctor   varchar,
                                                          v_Quality_Control_Nurse    varchar,
                                                          v_Quality_Control_Date     varchar,
                                                          v_Xay_Sn                   varchar,
                                                          v_Ct_Sn                    varchar,
                                                          v_Mri_Sn                   varchar,
                                                          v_Dsa_Sn                   varchar,
                                                          v_Is_First_Case            numeric,
                                                          v_Is_Following             numeric,
                                                          v_Following_Ending_Date    varchar,
                                                          v_Is_Teaching_Case         numeric,
                                                          v_Blood_Type_id            numeric,
                                                          v_Rh                       numeric,
                                                          v_Blood_Reaction_Id        numeric,
                                                          v_Blood_Rbc                numeric,
                                                          v_Blood_Plt                numeric,
                                                          v_Blood_Plasma             numeric,
                                                          v_Blood_Wb                 numeric,
                                                          v_Blood_Others             varchar,
                                                          v_Is_Completed             varchar,
                                                          v_completed_time           varchar,
                                                          --v_Valide numeric ,
                                                          v_Create_User varchar
                                                          --v_Create_Time varchar(19)
                                                          --v_Modified_User varchar(10) ,
                                                          --v_Modified_Time varchar(19)
                                                          ) as /**********
 版本号  1.0.0.0.0
 创建时间
 作者
 版权
 描述  插入功病案首页基本信息TABLE
 功能说明
 输入参数
 输出参数
 结果集、排序

 调用的sp
 调用实例

 修改记录
**********/
begin
  insert into Iem_Mainpage_Basicinfo
    (Iem_Mainpage_NO,PatNoOfHis,
     NoOfInpat,
     PayID,
     SocialCare,
     InCount,
     Name,
     SexID,
     Birth,
     Marital,
     JobID,
     ProvinceID,
     CountyID,
     NationID,
     NationalityID,
     IDNO,
     Organization,
     OfficePlace,
     OfficeTEL,
     OfficePost,
     NativeAddress,
     NativeTEL,
     NativePost,
     ContactPerson,
     Relationship,
     ContactAddress,
     ContactTEL,
     AdmitDate,
     AdmitDept,
     AdmitWard,
     Days_Before,
     Trans_Date,
     Trans_AdmitDept,
     Trans_AdmitWard,
     Trans_AdmitDept_Again,
     OutWardDate,
     OutHosDept,
     OutHosWard,
     Actual_Days,
     Death_Time,
     Death_Reason,
     AdmitInfo,
     In_Check_Date,
     Pathology_Diagnosis_Name,
     Pathology_Observation_Sn,
     Ashes_Diagnosis_Name,
     Ashes_Anatomise_Sn,
     Allergic_Drug,
     Hbsag,
     Hcv_Ab,
     Hiv_Ab,
     Opd_Ipd_Id,
     In_Out_Inpatinet_Id,
     Before_After_Or_Id,
     Clinical_Pathology_Id,
     Pacs_Pathology_Id,
     Save_Times,
     Success_Times,
     Section_Director,
     Director,
     Vs_Employee_Code,
     Resident_Employee_Code,
     Refresh_Employee_Code,
     Master_Interne,
     Interne,
     Coding_User,
     Medical_Quality_Id,
     Quality_Control_Doctor,
     Quality_Control_Nurse,
     Quality_Control_Date,
     Xay_Sn,
     Ct_Sn,
     Mri_Sn,
     Dsa_Sn,
     Is_First_Case,
     Is_Following,
     Following_Ending_Date,
     Is_Teaching_Case,
     Blood_Type_id,
     Rh,
     Blood_Reaction_Id,
     Blood_Rbc,
     Blood_Plt,
     Blood_Plasma,
     Blood_Wb,
     Blood_Others,
     Is_Completed,
     completed_time,
     Valide,
     Create_User,
     Create_Time)
  values
    (seq_iem_mainpage_basicinfo_id.nextval,
    v_PatNoOfHis, -- numeric
     v_NoOfInpat, -- numeric
     v_PayID, -- varchar(4)
     v_SocialCare, -- varchar(32)
     v_InCount, -- int
     v_Name, -- varchar(60)
     v_SexID, -- varchar(4)
     v_Birth, -- char(10)
     v_Marital, -- varchar(4)
     v_JobID, -- varchar(4)
     v_ProvinceID, -- varchar(10)
     v_CountyID, -- varchar(10)
     v_NationID, -- varchar(4)
     v_NationalityID, -- varchar(4)
     v_IDNO, -- varchar(18)
     v_Organization, -- varchar(64)
     v_OfficePlace, -- varchar(64)
     v_OfficeTEL, -- varchar(16)
     v_OfficePost, -- varchar(16)
     v_NativeAddress, -- varchar(64)
     v_NativeTEL, -- varchar(16)
     v_NativePost, -- varchar(16)
     v_ContactPerson, -- varchar(32)
     v_Relationship, -- varchar(4)
     v_ContactAddress, -- varchar(255)
     v_ContactTEL, -- varchar(16)
     v_AdmitDate, -- varchar(19)
     v_AdmitDept, -- varchar(12)
     v_AdmitWard, -- varchar(12)
     v_Days_Before, -- numeric
     v_Trans_Date, -- varchar(19)
     v_Trans_AdmitDept, -- varchar(12)
     v_Trans_AdmitWard, -- varchar(12)
     v_Trans_AdmitDept_Again, -- varchar(12)
     v_OutWardDate, -- varchar(19)
     v_OutHosDept, -- varchar(12)
     v_OutHosWard, -- varchar(12)
     v_Actual_Days, -- numeric
     v_Death_Time, -- varchar(19)
     v_Death_Reason, -- varchar(300)
     v_AdmitInfo, -- varchar(4)
     v_In_Check_Date, -- varchar(19)
     v_Pathology_Diagnosis_Name, -- varchar(300)
     v_Pathology_Observation_Sn, -- varchar(60)
     v_Ashes_Diagnosis_Name, -- varchar(300)
     v_Ashes_Anatomise_Sn, -- varchar(60)
     v_Allergic_Drug, -- varchar(300)
     v_Hbsag, -- numeric
     v_Hcv_Ab, -- numeric
     v_Hiv_Ab, -- numeric
     v_Opd_Ipd_Id, -- numeric
     v_In_Out_Inpatinet_Id, -- numeric
     v_Before_After_Or_Id, -- numeric
     v_Clinical_Pathology_Id, -- numeric
     v_Pacs_Pathology_Id, -- numeric
     v_Save_Times, -- numeric
     v_Success_Times, -- numeric
     v_Section_Director, -- varchar(20)
     v_Director, -- varchar(20)
     v_Vs_Employee_Code, -- varchar(20)
     v_Resident_Employee_Code, -- varchar(20)
     v_Refresh_Employee_Code, -- varchar(20)
     v_Master_Interne, -- varchar(20)
     v_Interne, -- varchar(20)
     v_Coding_User, -- varchar(20)
     v_Medical_Quality_Id, -- numeric
     v_Quality_Control_Doctor, -- varchar(20)
     v_Quality_Control_Nurse, -- varchar(20)
     v_Quality_Control_Date, -- varchar(19)
     v_Xay_Sn, -- varchar(300)
     v_Ct_Sn, -- varchar(300)
     v_Mri_Sn, -- varchar(300)
     v_Dsa_Sn, -- varchar(300)
     v_Is_First_Case, -- numeric
     v_Is_Following, -- numeric
     v_Following_Ending_Date, -- varchar(19)
     v_Is_Teaching_Case, -- numeric
     v_Blood_Type_id, -- numeric
     v_Rh, -- numeric
     v_Blood_Reaction_Id, -- numeric
     v_Blood_Rbc, -- numeric
     v_Blood_Plt, -- numeric
     v_Blood_Plasma, -- numeric
     v_Blood_Wb, -- numeric
     v_Blood_Others, -- varchar(60)
     v_Is_Completed, -- varchar(1)
     v_completed_time, -- varchar(19)
     1, -- numeric
     v_Create_User, -- varchar(10)
     to_char(sysdate, 'yyyy-mm-dd HH24:mi:ss') -- varchar(19)
     );

  select  seq_iem_mainpage_basicinfo_id.currval from dual;
end;
/

prompt
prompt Creating procedure USP_INSERT_IEM_MAINPAGE_DIAG
prompt ===============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_Insert_Iem_Mainpage_Diag(v_Iem_Mainpage_NO   numeric,
                                                         v_Diagnosis_Type_Id numeric,
                                                         v_Diagnosis_Code    varchar,
                                                         v_Diagnosis_Name    varchar,
                                                         v_Status_Id         numeric,
                                                         v_Order_Value       numeric,
                                                         --v_Valide numeric ,
                                                         v_Create_User varchar
                                                         --v_Create_Time varchar(19) ,
                                                         --v_Cancel_User varchar(10) ,
                                                         --v_Cancel_Time varchar(19)
                                                         ) as /**********
 版本号  1.0.0.0.0
 创建时间
 作者
 版权
 描述  插入功病案首页诊断TABLE
 功能说明
 输入参数
 输出参数
 结果集、排序

 调用的sp
 调用实例

 修改记录
**********/
begin

  insert into Iem_Mainpage_Diagnosis
    (Iem_Mainpage_NO,
     Diagnosis_Type_Id,
     Diagnosis_Code,
     Diagnosis_Name,
     Status_Id,
     Order_Value,
     Valide,
     Create_User,
     Create_Time)
  values
    (v_Iem_Mainpage_NO, -- Iem_Mainpage_NO - numeric
     v_Diagnosis_Type_Id, -- Diagnosis_Type_Id - numeric
     v_Diagnosis_Code, -- Diagnosis_Code - varchar(60)
     v_Diagnosis_Name, -- Diagnosis_Name - varchar(300)
     v_Status_Id, -- Status_Id - numeric
     v_Order_Value, -- Order_Value - numeric
     1, -- Valide - numeric
     v_Create_User, -- Create_User - varchar(10)
     to_char(sysdate, 'yyyy-mm-dd HH24:mi:ss') -- Create_Time - varchar(19)
     );
end;
/

prompt
prompt Creating procedure USP_INSERT_IEM_MAINPAGE_OPER
prompt ===============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_Insert_Iem_MainPage_Oper(v_IEM_MainPage_NO     numeric,
                                                         v_Operation_Code      varchar,
                                                         v_Operation_Date      varchar,
                                                         v_Operation_Name      varchar,
                                                         v_Execute_User1       varchar,
                                                         v_Execute_User2       varchar,
                                                         v_Execute_User3       varchar,
                                                         v_Anaesthesia_Type_Id numeric,
                                                         v_Close_Level         numeric,
                                                         v_Anaesthesia_User    varchar,
                                                         --v_Valide numeric ,
                                                         v_Create_User varchar
                                                         --v_Create_Time varchar(19)
                                                         --v_Cancel_User varchar(10) ,
                                                         --v_Cancel_Time varchar(19)
                                                         ) as /**********
 版本号  1.0.0.0.0
 创建时间
 作者
 版权
 描述  插入功病案首页手术TABLE
 功能说明
 输入参数
 输出参数
 结果集、排序

 调用的sp
 调用实例

 修改记录
**********/
begin
  insert into Iem_MainPage_Operation
    (IEM_MainPage_NO,
     Operation_Code,
     Operation_Date,
     Operation_Name,
     Execute_User1,
     Execute_User2,
     Execute_User3,
     Anaesthesia_Type_Id,
     Close_Level,
     Anaesthesia_User,
     Valide,
     Create_User,
     Create_Time)
  values
    (v_IEM_MainPage_NO, --numeric
     v_Operation_Code, -- varchar(60)
     v_Operation_Date, -- varchar(19)
     v_Operation_Name, -- varchar(300)
     v_Execute_User1, -- varchar(20)
     v_Execute_User2, -- varchar(20)
     v_Execute_User3, -- varchar(20)
     v_Anaesthesia_Type_Id, -- numeric
     v_Close_Level, -- numeric
     v_Anaesthesia_User, -- varchar(20)
     1, -- numeric
     v_Create_User, -- varchar(10)
     to_char(sysdate, 'yyyy-mm-dd HH24:mi:ss'));
end;
/

prompt
prompt Creating procedure USP_MEDQCANALYSIS
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_MedQCAnalysis(v_DateTimeBegin varchar, --查询开始日期
                                              v_DateTimeEnd   varchar --查询结束日期
                                              )

 AS
  /**********
   版本号  1.0.0.0.0
   创建时间   2011-03-03
   作者     yxy
   版权     YidanSoft
   描述  医疗质量统计分析
   功能说明
   输入参数
   输出参数
   结果集、排序
  医疗质量统计分析
  
   调用的sp
   调用实例
  usp_MedQCAnalysis   '2009-11-25','2010-11-25'
   修改记录
      Medical quality statistic analysis
  
  
  **********/
  v_sql varchar2(4000);
BEGIN

  --DeptCode DeptName InHos NewInHos NewOutHos BedCnt  EmptyBedCnt  AddBedCnt DieCnt SurgeryCnt GraveCnt OutHosFail
  --创建医疗统计分析临时表
  /*  create table #temptable(DeptCode varchar(10) COLLATE Chinese_PRC_BIN
  NOT NULL, --科室代码
  DeptName varchar(100) NOT NULL, --科室名称
  InHos int null, --在院病人
  NewInHos int null, --新入院病人
  NewOutHos int null, --新出院病人
  BedCnt int null, --床位数
  EmptyBedCnt int null, --空床位数
  AddBedCnt int null, --加床数
  DieCnt int null, --死亡人数
  SurgeryCnt int null, --手术人数
  GraveCnt int null, --危重数
  OutHosFail int null --出院未提交数
  );*/

  v_sql := 'truncate table tmp_MedQCAnalysis ';
  execute immediate v_sql;

  --插入挂有病区的科室
  insert into tmp_MedQCAnalysis
    (DeptCode, DeptName)
    select dept.ID, dept.Name
      from Department dept
     where exists
     (select 1 from Dept2Ward ward where dept.ID = ward.DeptID);

  --更新在院人数
  UPDATE tmp_MedQCAnalysis
     SET InHos = nvl((SELECT count(1)
                       FROM InPatient inp
                      WHERE inp.Status IN
                            (1500, 1501, 1504, 1505, 1506, 1507)
                           --                        AND CONVERT(varchar(10),inp.AdmitDate,102) >= v_DateTimeBegin
                           --                        AND CONVERT(varchar(10),inp.AdmitDate,102) <= v_DateTimeEnd
                        and inp.OutHosDept = DeptCode),
                     0);

  --新入院病人
  UPDATE tmp_MedQCAnalysis
     SET NewInHos = nvl((SELECT count(1)
                          FROM InPatient inp
                         WHERE inp.Status IN
                               (1500, 1501, 1504, 1505, 1506, 1507)
                           AND to_char(inp.AdmitDate, 'yyyy.mm.dd') >=
                               v_DateTimeBegin
                           AND to_char(inp.AdmitDate, 'yyyy.mm.dd') <=
                               v_DateTimeEnd
                           and inp.OutHosDept = DeptCode),
                        0);
  --新出院病人
  UPDATE tmp_MedQCAnalysis
     SET NewOutHos = nvl((SELECT count(1)
                           FROM InPatient inp
                          WHERE inp.Status IN (1502, 1503)
                            AND to_char(inp.AdmitDate, 'yyyy.mm.dd') >=
                                v_DateTimeBegin
                            AND to_char(inp.AdmitDate, 'yyyy.mm.dd') <=
                                v_DateTimeEnd
                            and inp.OutHosDept = DeptCode),
                         0);

  --床位数
  UPDATE tmp_MedQCAnalysis
     SET BedCnt = nvl((select count(1)
                        from Bed bed
                       where bed.Valid = 1
                         and bed.DeptID = DeptCode),
                      0);

  --空床位数
  UPDATE tmp_MedQCAnalysis
     SET EmptyBedCnt = nvl((select count(1)
                             from Bed bed
                            where bed.Valid = 1
                              and bed.InBed = 1300
                              and bed.DeptID = DeptCode),
                           0);

  --加床数
  UPDATE tmp_MedQCAnalysis
     SET AddBedCnt = nvl((select count(1)
                           from Bed bed
                          where bed.Valid = 1
                            and bed.Style = 1202
                            and bed.DeptID = DeptCode),
                         0);

  --死亡人数  （。。。）
  UPDATE tmp_MedQCAnalysis
     SET DieCnt = nvl((SELECT count(1)
                        FROM InPatient inp
                       WHERE inp.Status IN
                             (1500, 1501, 1504, 1505, 1506, 1507)
                         AND to_char(inp.AdmitDate, 'yyyy.mm.dd') >=
                             v_DateTimeBegin
                         AND to_char(inp.AdmitDate, 'yyyy.mm.dd') <=
                             v_DateTimeEnd
                         AND (to_number(sysdate - inp.AdmitDate) > 30)
                         and inp.OutHosDept = DeptCode),
                      0);
  --手术病人
  UPDATE tmp_MedQCAnalysis
     SET SurgeryCnt = nvl((SELECT count(1)
                            FROM InPatient inp
                           WHERE inp.Status IN
                                 (1500, 1501, 1504, 1505, 1506, 1507)
                             AND to_char(inp.AdmitDate, 'yyyy.mm.dd') >=
                                 v_DateTimeBegin
                             AND to_char(inp.AdmitDate, 'yyyy.mm.dd') <=
                                 v_DateTimeEnd
                             AND (to_number(sysdate - inp.AdmitDate) > 30)
                             and inp.OutHosDept = DeptCode),
                          0);

  --危重病人
  UPDATE tmp_MedQCAnalysis
     SET GraveCnt = nvl((SELECT count(1)
                          FROM InPatient inp
                         WHERE inp.CriticalLevel = 1
                           AND inp.Status IN
                               (1500, 1501, 1504, 1505, 1506, 1507)
                           AND to_char(inp.AdmitDate, 'yyyy.mm.dd') >=
                               v_DateTimeBegin
                           AND to_char(inp.AdmitDate, 'yyyy.mm.dd') <=
                               v_DateTimeEnd
                           and inp.OutHosDept = DeptCode),
                        0);

  --出院未提交

  UPDATE tmp_MedQCAnalysis
     SET OutHosFail = nvl((SELECT count(1)
                            FROM InPatient inp
                           WHERE inp.Status IN (1502, 1503)
                             AND to_char(inp.AdmitDate, 'yyyy.mm.dd') >=
                                 v_DateTimeBegin
                             AND to_char(inp.AdmitDate, 'yyyy.mm.dd') <=
                                 v_DateTimeEnd
                             and inp.OutHosDept = DeptCode),
                          0);

  select '_' DeptCode,
         '总计' DeptName,
         sum(InHos) InHos,
         sum(NewInHos) NewInHos,
         sum(NewOutHos) NewOutHos,
         sum(BedCnt) BedCnt,
         sum(EmptyBedCnt) EmptyBedCnt,
         sum(AddBedCnt) AddBedCnt,
         sum(DieCnt) DieCnt,
         sum(SurgeryCnt) SurgeryCnt,
         sum(GraveCnt) GraveCnt,
         sum(OutHosFail) OutHosFail
    from tmp_MedQCAnalysis
  union all
  select DeptCode,
         DeptName,
         InHos,
         NewInHos,
         NewOutHos,
         BedCnt,
         EmptyBedCnt,
         AddBedCnt,
         DieCnt,
         SurgeryCnt,
         GraveCnt,
         OutHosFail
    from tmp_MedQCAnalysis;
end;
/

prompt
prompt Creating procedure USP_MSQUERYTEMPLATE
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_MSQueryTemplate(v_ID         VARCHAR,
                                                v_User       varchar,
                                                v_Type       int,
                                                v_Department varchar default '') as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取病历模板选择助手数据
   功能说明
   输入参数
    v_InitStauts int     --初始化ID
    ,v_ID VARCHAR(12) --ModelDirectory.ID
    ,v_SortID VARCHAR(12) --Model_Docment.SortID
    ,v_Department varchar(12)   --科室ID
   输出参数
   结果集、排序
  质量控制统计数据集
  
   调用的sp
   调用实例
   exec usp_MSQueryTemplate  0,'RM0',''
   修改记录
  **********/
  v_sql varchar(400);
begin

  IF v_Type = 0 then
    BEGIN
      v_sql := 'SELECT ID AS TemplateID ,Name, null SortID from ModelDirectory
WHERE Valid = 1 AND ID IN (' + v_ID + ')';
      execute immediate v_sql;
    
    END;
  
  ELSIF v_Type = 1 then
    begin
      v_sql := 'SELECT a.ID AS TemplateID,a.Name, a.SortID, b.Memo from Model_Docment a,Template_Department b
WHERE a.ID=b.TemplateID and a.Valid = 1 AND a.SortID like ''' + v_ID +
               '%'' and b.Department =''' + v_Department +
               '''  order by a.SortID ';
      execute immediate v_sql;
    END;
  
  ELSIF v_Type = 2 then
    SELECT ID AS TemplateID, Name, NULL SortID
      from ModelDirectory
     WHERE Valid = 1
       AND ID = v_ID;
  
  ELSIF v_Type = 3 then
    SELECT ID AS TemplateID, Name, NULL SortID
      FROM TemplateSort_Person
     WHERE Mark = '0'
       AND Valid = '1'
       AND UserID = v_User;
  
  ELSIF v_Type = 4 then
    SELECT TemplateID, Name, SortID
      FROM Template_Person
     WHERE SortID = v_ID
       AND Valid = '1'
       AND UserID = v_User;
  end if;

END;
/

prompt
prompt Creating procedure USP_NURSRECORDOPERATE
prompt ========================================
prompt
create or replace procedure emr.usp_NursRecordOperate(v_ID        numeric default 0, --记录ID
                                                  v_NoOfInpat numeric default 0, --首页序号(住院流水号)
                                                  v_SortID    numeric default 0, --模板分类代码
                                                  v_Type      int --操作类型
                                                  ) as

  /**********
  [版本号] 1.0.0.0.0
  [创建时间]2011-06-10
  [作者]hjh
  [版权]
  [描述]护理
  [功能说明]
  [输入参数]
  [输出参数]
  [结果集、排序]
  
  
  [调用的sp]
  [调用实例]
  
  [修改记录]
  **********/

begin

  if v_Type = 1 then
    --打开模板
  
    select Content
      from Template_Table
     where Valid = 1
       and ID = v_ID;
  
  elsif v_Type = 2 then
    --打开病人护理单
  
    select *
      from NursRecordTable
     where Valid = 1
       and NoOfInpat = v_NoOfInpat
       and ID = v_ID;
  
  elsif v_Type = 3 then
    --从数据库中读取模板信息列表
  
    select tts.name as SortName, tt.*
      from Template_Table tt
      left join TemplateTableSort tts on tts.ID = tt.SortID
     where tt.Valid = 1
       and (v_SortID = 0 or tt.SortID = v_SortID)
     order by tt.SortID;
  
  elsif v_Type = 4 then
    --获取病人会理表单
  
    select *
      from NursRecordTable
     where Valid = 1
       and NoOfInpat = v_NoOfInpat
     order by name;
  
  elsif v_Type = 5 then
    --删除模板
  
    update Template_Table set Valid = 0 where ID = v_ID;
  
  elsif v_Type = 6 then
    --删除病历护理表单
  
    update NursRecordTable
       set Valid = 0
     where ID = v_ID
       and NoOfInpat = v_NoOfInpat;
  
  elsif v_Type = 7 then
    --获取护理文档模板分类
  
    select * from TemplateTableSort where Valid = 1 order by ID;
  
  end if;
end;
/

prompt
prompt Creating procedure USP_QCITEMSCORE
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_QCItemScore(v_ItemName           varchar,
                                            v_ItemInstruction    varchar,
                                            v_ItemDefaultScore   int,
                                            v_ItemStandardScore  int,
                                            v_ItemCategory       int,
                                            v_ItemDefaultTarget  int,
                                            v_ItemTargetStandard int,
                                            v_ItemScoreStandard  int,
                                            v_ItemOrder          int,
                                            v_TypeCode           varchar,
                                            v_ItemMemo           varchar,
                                            v_TypeStatus         int,
                                            v_ItemCode           varchar) as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取质量控制统计数据
   功能说明
   输入参数
    v_ItemName varchar(40)
   ,v_ItemInstruction varchar(60)
   ,v_ItemDefaultScore int
   ,v_ItemStandardScore int
   ,v_ItemCategory int
   ,v_ItemDefaultTarget int
   ,v_ItemTargetStandard int
   ,v_ItemScoreStandard int
   ,v_ItemOrder int
   ,v_TypeCode varchar(4)
   ,v_ItemMemo varchar(60)
  ,v_TypeStatus int
   ,v_ItemCode varchar(5)
   输出参数
   结果集、排序
  质量控制统计数据集
  
   调用的sp
   调用实例
   exec usp_QCItemScore  'test', 'test',3,4,5,6,7,8,9,'E001','test',0
   修改记录
  **********/
  v_itemCodetemp varchar(5);
begin

  IF v_TypeStatus = 0 then
    begin
    
      select 'I' ||
             (case
              nvl(length(to_number(substr(MAX(ItemCode), 2, 5)) + 1), 0)
               when 0 then
                '0001'
               when 1 then
                '000' ||
                to_char(to_number(substr(MAX(ItemCode), 2, 5)) + 1)
               when 2 then
                '00' || to_char(to_number(substr(MAX(ItemCode), 2, 5)) + 1)
               when 3 then
                '0' || to_char(to_number(substr(MAX(ItemCode), 2, 5)) + 1)
               else
                to_char(to_number(substr(MAX(ItemCode), 2, 5)) + 1)
             end)
        into v_itemCodetemp
        from QCScoreItem;
    
      insert into QCScoreItem
        (ItemCode,
         ItemName,
         ItemInstruction,
         ItemDefaultScore,
         ItemStandardScore,
         ItemCategory,
         ItemDefaultTarget,
         ItemTargetStandard,
         ItemScoreStandard,
         ItemOrder,
         TypeCode,
         ItemMemo)
      values
        (v_itemCodetemp,
         v_ItemName,
         v_ItemInstruction,
         v_ItemDefaultScore,
         v_ItemStandardScore,
         v_ItemCategory,
         v_ItemDefaultTarget,
         v_ItemTargetStandard,
         v_ItemScoreStandard,
         v_ItemOrder,
         v_TypeCode,
         v_ItemMemo);
    END;
  
  ELSIF v_TypeStatus = 1 then
    --修改
    begin
      UPDATE QCScoreItem
         SET ItemName           = v_ItemName,
             ItemInstruction    = v_ItemInstruction,
             ItemDefaultScore   = v_ItemDefaultScore,
             ItemStandardScore  = v_ItemStandardScore,
             ItemCategory       = v_ItemCategory,
             ItemDefaultTarget  = v_ItemDefaultTarget,
             ItemTargetStandard = v_ItemTargetStandard,
             ItemScoreStandard  = v_ItemScoreStandard,
             ItemOrder          = v_ItemOrder,
             TypeCode           = v_TypeCode,
             ItemMemo           = v_ItemMemo
       WHERE ItemCode = v_ItemCode;
    end;
  
  ELSIF v_TypeStatus = 2 then
    --删除
    begin
      UPDATE QCScoreItem SET Valide = 0 WHERE ItemCode = v_ItemCode;
    END;
  end if;
end;
/

prompt
prompt Creating procedure USP_QCOPERPROBLEMINFO
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_QCOperProblemInfo(v_ID             int,
                                                  v_NoOfInpat      int,
                                                  v_Category       int,
                                                  v_Status         int,
                                                  v_TypeCode       varchar,
                                                  v_Description    varchar,
                                                  v_AnsewerContent varchar,
                                                  v_ConfirmContent varchar,
                                                  v_ProblemDate    varchar,
                                                  v_RegisterDate   varchar,
                                                  v_RegisterUser   varchar,
                                                  v_AnswerDate     varchar,
                                                  v_AnswerUser     varchar,
                                                  v_ConfirmDate    varchar,
                                                  v_ConfirmUser    varchar,
                                                  v_DelDate        varchar,
                                                  v_DelUser        varchar,
                                                  v_OperStatus     int) as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取质量问题数据
   功能说明
   输入参数
    v_DateTimeBegin varchar(9) --开始时间
   ,v_v_DateTimeEnd  varchar(9) --结束时间
   ,v_QCStatType int --统计资料类型
   输出参数
   结果集、排序
  质量控制统计数据集
  
   调用的sp
   调用实例
   exec usp_QCOperProblemInfo '2007-06-01', '2010-06-30',1
   修改记录
  **********/
  v_DoctorId varchar(6);
begin

  IF v_OperStatus = 0 then
    --提交
    BEGIN
      SELECT Operator
        into v_DoctorId
        FROM MedicalRecord
       WHERE NoOfInpat = v_NoOfInpat
         and rownum < 2;
    
      INSERT INTO QCProblemDescription
        (NoOfInpat,
         Category,
         Status,
         TypeCode,
         Description,
         ProblemDate,
         RegisterDate,
         RegisterUser,
         Doctor_ID)
      VALUES
        (v_NoOfInpat,
         v_Category,
         v_Status,
         v_TypeCode,
         v_Description,
         v_ProblemDate,
         v_RegisterDate,
         v_RegisterUser,
         v_DoctorId);
    
    END;
  
  ELSIF v_OperStatus = 1 then
    -- 审核
    BEGIN
      UPDATE QCProblemDescription
         SET ConfirmContent = v_ConfirmContent,
             ConfirmDate    = v_ConfirmDate,
             ConfirmUser    = v_ConfirmUser,
             Category       = v_Category
       WHERE ID = v_ID;
    END;
  
  ELSIF v_OperStatus = 2 then
    --作废
    BEGIN
      UPDATE QCProblemDescription
         SET ConfirmContent = v_ConfirmContent,
             DelDate        = v_DelDate,
             DelUser        = v_DelUser,
             Category       = v_Category
       WHERE ID = v_ID;
    END;
  end if;
END;
/

prompt
prompt Creating procedure USP_QCTYPESCORE
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_QCTypeScore(v_TypeName        varchar,
                                            v_TypeInstruction varchar,
                                            v_TypeCategory    int,
                                            v_TypeOrder       int,
                                            v_TypeMemo        varchar,
                                            v_TypeStatus      int,
                                            v_TypeCode        varchar) as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  质控TypeScore操作
   功能说明
   输入参数
   v_TypeName varchar(40)
   ,v_TypeInstruction  varchar(60)
   ,v_TypeCategory int
   ,v_TypeOrder int
   ,v_TypeMemo varchar(60)
  ,v_TypeStatus int
  ,v_TypeCode varchar(4)
   输出参数
   结果集、排序
  质量控制统计数据集
  
   调用的sp
   调用实例
   exec usp_QCTypeScore  'test', 'test',0,0,'test',0
   修改记录
  **********/
  v_typeCodeTemp VARCHAR(4);
begin

  IF v_TypeStatus = 0 then
    --新增
    BEGIN
      SELECT 'T' ||
             (CASE
              nvl(length((to_number(substr(MAX(TypeCode), 2, 4)) + 1)), 0)
               WHEN 0 THEN
                '001'
               WHEN 1 THEN
                '00' || to_char(to_number(substr(MAX(TypeCode), 2, 4)) + 1)
               WHEN 2 THEN
                '0' || to_char(to_number(substr(MAX(TypeCode), 2, 4)) + 1)
               ELSE
                to_char(to_number(substr(MAX(TypeCode), 2, 4) + 1))
             END)
        into v_typeCodeTemp
      
        FROM QCScoreType;
    
      INSERT INTO QCScoreType
        (TypeCode,
         TypeName,
         TypeInstruction,
         TypeCategory,
         TypeOrder,
         TypeMemo)
      VALUES
        (v_typeCodeTemp,
         v_TypeName,
         v_TypeInstruction,
         v_TypeCategory,
         v_TypeOrder,
         v_TypeMemo);
    END;
  
  ELSIF v_TypeStatus = 1 then
    --修改
    BEGIN
      UPDATE QCScoreType
         SET TypeName        = v_TypeName,
             TypeInstruction = v_TypeInstruction,
             TypeCategory    = v_TypeCategory,
             TypeOrder       = v_TypeOrder,
             TypeMemo        = v_TypeMemo
       WHERE TypeCode = v_TypeCode;
    END;
  
  ELSIF v_TypeStatus = 2 then
    --删除
    BEGIN
      UPDATE QCScoreType SET Valide = 0 WHERE TypeCode = v_TypeCode;
    END;
  end if;

end;
/

prompt
prompt Creating procedure USP_QUERYBROWSERINWARDPATIENTS
prompt =================================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_QueryBrowserInwardPatients(v_ID        varchar,
                                                           v_QueryType int,
                                                           v_Wardid_in varchar,
                                                           v_Deptids   varchar,
                                                           v_zyhm      varchar default '',
                                                           v_hzxm      varchar default '',
                                                           v_cyzd      varchar default '',
                                                           v_ryrqbegin varchar default '',
                                                           v_ryrqend   varchar default '',
                                                           v_cyrqbegin varchar default '',
                                                           v_cyrqend   varchar default '') as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取对应病区的床位信息(病区一览时调用）
  -- 功能说明
   输入参数
    v_Wardid   varchar(6)   --病区代码
    v_Deptids varchar(255)  --科室代码集合(形如: '代码1','代码2')
    v_zyhm  varchar(30)=''  --住院号
    v_hzxm  varchar(30)=''  --姓名
    v_cyzd  varchar(30)=''  --出院诊断
    v_cyrqbegin varchar(19)=''  --出院日期最小值
    v_cyrqend varchar(19)=''  --出院日期最大值
    v_ryrqbegin varchar(19)=''  --入院日期最小值
    v_ryrqend varchar(19)=''  --入院日期最大值
   输出参数
   结果集、排序
  在病区的病人数据集
  
   调用的sp
   调用实例
   exec usp_QueryBrowserInwardPatients 0,0,'2911', '3202'
   修改记录
  护理级别待处理
  **********/
  v_existData number;
  v_dqrq      varchar(10);
  v_ksrq      varchar(10);
  v_jsrq      varchar(10);
  v_now       varchar(24);
  v_Wardid    varchar(40);
  v_sql       varchar(4000);
begin

  v_sql := 'truncate table tmp_QueryBrowserinwardPat ';
  execute immediate v_sql;

  v_sql := 'truncate table tmp_QueryBrowserInward_extraop ';
  execute immediate v_sql;

  v_sql := 'truncate table tmp_QueryBrowserinwardPatExist ';
  execute immediate v_sql;

  if v_Wardid_in is null then
    v_Wardid := '';
  end if;

  select count(*)
    into v_existData
    from Doctor_AssignPatient
   where ID = v_ID
     and Valid = 1;

  v_dqrq := to_char(sysdate, 'yyyy-mm-dd');
  v_ksrq := to_char(sysdate - 3, 'yyyy-mm-dd');
  v_jsrq := to_char(sysdate + 2, 'yyyy-mm-dd');
  v_now  := to_char(sysdate, 'yyyy-mm-dd HH24:mi:sss');

  -- 先找出病人记录，然后读取病人的附加信息（手术、出院、转科等）
  insert into tmp_QueryBrowserinwardPat
    select b.NoOfInpat NoOfInpat, --首页序号                
           b.PatNoOfHis PatNoOfHis, --HIS首页序号                
           b.PatID PatID, --住院号                
           b.Name PatName, --姓名                
           b.SexID Sex, --病人性别                
           b.SexID SexName, --病人性别名称                
           b.AgeStr AgeStr, --年龄                
           b.Py py, --拼音                
           b.Wb wb, --五笔                
           b.Status brzt, --病人状态                
           rtrim(b.CriticalLevel) wzjb, --危重级别                
           i.Name wzjbmc, --危重级别名称                
           (case
             when PatID is null then
              ''
             else
              '一级护理'
           end) hljb, --护理级别                
           b.IsBaby yebz, --婴儿标志                
           a.WardId bqdm, --病区代码                
           a.DeptID ksdm, --科室代码                
           a.ID BedID, --床位代码                
           a.FormerWard ybqdm, --原病区代码                
           a.FormerDeptID yksdm, --原科室代码                
           a.FormerDeptID ycwdm, --原床位代码                
           a.InBed InBed, --占床标志                
           a.Borrow jcbz, --借床标志                
           a.SexInfo cwlx, --床位类型                
           substr(b.AdmitDate, 1, 16) AdmitDate, --入院日期                
           f.Name ryzd, --入院诊断                
           f.Name zdmc, --诊断名称                
           b.Resident zyysdm, --住院医生代码                
           c.Name zyys, --住院医生                
           c.Name cwys, --床位医生                
           g.Name zzys, --主治医师                
           h.Name zrys, --主任医师                
           a.Valid yxjl, --有效记录                
           me.pzlx pzlx, --凭证类型                
           to_char(case
                     when instr(a.DeptID, v_Deptids) = 0 and (b.NoOfInpat is null) then
                      '属于其它科室'
                     else
                      ''
                   end) extra, --额外信息                
           b.Memo memo, --备注                
           (case b.CPStatus
             when 0 then
              '未引入'
             when 1 then
              '执行中'
             when 2 then
              '退出'
           end) CPStatus,
           (select case
                     when count(qc.FoulState) > 0 then
                      '是'
                     else
                      '否'
                   end
              from QCRecord qc
             where qc.NoOfInpat = b.NoOfInpat
               and qc.Valid = 1
               and qc.FoulState = 1) as IsWarn, --是否违规
           100 ye --余额
      from Bed a
      left join InPatient b on a.NoOfInpat = b.NoOfInpat
                           and a.PatNoOfHis = b.PatNoOfHis
                           and instr(rtrim(b.OutHosDept), v_Deptids) > 0
                           and a.InBed = 1301
      left join MedicareInfo me on b.VouchersCode = me.ID
    --   left join YY_SFXXMK e  on b.AttendLevel = e.sfxmdm
      left join Diagnosis f on f.ICD = b.AdmitDiagnosis
      left join Users c on c.ID = b.Resident
      left join Dictionary_detail i on i.DetailID = b.CriticalLevel
                                   and i.CategoryID = '53'
      left join Users g on g.ID = a.Attend
      left join Users h on h.ID = a.Chief
      left join Dictionary_detail j on j.DetailID = b.SexID
                                   and j.CategoryID = '3'
     where a.WardId = v_Wardid
       and a.Valid = 1;

  -- 检查手术信息:临时医嘱，已审核和已执行的，开始时间、手术时间在当前日期-3、+1之内
  insert into tmp_QueryBrowserInward_extraop
    select a.NoOfInpat,
           datediff('dd', v_now, to_char(a.Entrust, 'yyyy-mm-dd')) diff
      from Temp_Order a, tmp_QueryBrowserinwardPat b
     where a.NoOfInpat = b.noofinpat
       and a.StartDate between v_ksrq and v_jsrq
       and a.OrderType = 3105
       and a.OrderStatus in (3201, 3202);

  update tmp_QueryBrowserinwardPat a
     set extra = (select a.extra + (case b.diff
                           when 1 then
                            '明日手术'
                           when 0 then
                            '今日手术'
                           when -1 then
                            '术后1天'
                           when -2 then
                            '术后2天'
                           when -3 then
                            '术后3天'
                           else
                            ''
                         end) || ' '
                    from tmp_QueryBrowserInward_extraop b
                   where a.NoOfInpat = b.NoOfInpat
                     and rownum <= 1);

  -- 检查出院医嘱:临时医嘱，已审核和已执行的，开始时间、出院时间在当前日期0时之后
  v_sql := 'truncate table tmp_QueryBrowserInward_extraop ';
  execute immediate v_sql;

  insert into tmp_QueryBrowserInward_extraop
    select a.NoOfInpat,
           datediff('dd', v_now, to_char(a.Entrust, 'yyyy-mm-dd')) diff
      from Temp_Order a, tmp_QueryBrowserinwardPat b
     where a.NoOfInpat = b.NoOfInpat
       and a.StartDate >= v_dqrq
       and a.OrderType = 3113
       and a.OrderStatus in (3201, 3202);

  update tmp_QueryBrowserinwardPat a
     set extra = (select a.extra || (case b.diff
                           when 0 then
                            '今日出院'
                           when 1 then
                            '明日出院'
                           else
                            to_char(b.diff) || '天后出院'
                         end) + ' '
                    from tmp_QueryBrowserInward_extraop b
                   where a.NoOfInpat = b.NoOfInpat
                     and rownum <= 1);

  -- 检查转科医嘱:根据病人状态
  update tmp_QueryBrowserinwardPat a
     set extra = (select a.extra + b.Name + ' '
                    from CategoryDetail b
                   where b.CategoryID = a.brzt
                     and rownum < 1)
   where a.brzt in (1505, 1506, 1507);

  -- 检查病人是否有病历
  update tmp_QueryBrowserinwardPat a
     set extra = a.extra + '无病历'
   where NoOfInpat is not null
     and not exists
   (select 1 from MedicalRecord b where a.NoOfInpat = b.NoOfInpat);

  if v_QueryType = 0 then
    --全部
    begin
      select *
        from tmp_QueryBrowserinwardPat
       order by to_char(BedID, '0000');
    end;
  else
    --分管
    if (v_existData = 0) then
      begin
        select *
          from tmp_QueryBrowserinwardPat
         order by to_char(BedID, '0000');
      end;
    else
      begin
        insert into tmp_QueryBrowserinwardPatExist
          select b.NoOfInpat NoOfInpat, --首页序号                                  
                 b.PatNoOfHis PatNoOfHis, --HIS首页序号                                  
                 b.PatID PatID, --住院号                                  
                 b.Name PatName, --姓名                                  
                 b.SexID Sex, --病人性别                                  
                 b.SexID SexName, --病人性别名称                                  
                 b.AgeStr AgeStr, --年龄                                  
                 b.Py py, --拼音                                  
                 b.Wb wb, --五笔                                 
                 b.Status brzt, --病人状态                                  
                 rtrim(b.CriticalLevel) wzjb, --危重级别                                  
                 i.Name wzjbmc, --危重级别名称                                  
                 (case
                   when PatID is null then
                    ''
                   else
                    '一级护理'
                 end) hljb, --护理级别                                  
                 b.IsBaby yebz, --婴儿标志                                  
                 a.WardId bqdm, --病区代码                                  
                 a.DeptID ksdm, --科室代码                                  
                 a.ID BedID, --床位代码                                  
                 a.FormerWard ybqdm, --原病区代码                                  
                 a.FormerDeptID yksdm, --原科室代码                                  
                 a.FormerDeptID ycwdm, --原床位代码                                  
                 a.InBed InBed, --占床标志                                 
                 a.Borrow jcbz, --借床标志                                  
                 a.SexInfo cwlx, --床位类型                                  
                 substr(b.AdmitDate, 1, 16) AdmitDate, --入院日期                                  
                 f.Name ryzd, --入院诊断                                  
                 f.Name zdmc, --诊断名称                                  
                 b.Resident zyysdm, --住院医生代码                                  
                 c.Name zyys, --住院医生                                  
                 c.Name cwys, --床位医生                                  
                 g.Name zzys, --主治医师                                  
                 h.Name zrys, --主任医师                                  
                 a.Valid yxjl, --有效记录                                  
                 me.pzlx pzlx, --凭证类型                                  
                 to_char(case
                           when instr(a.DeptID, v_Deptids) = 0 and
                                (b.NoOfInpat is null) then
                            '属于其它科室'
                           else
                            ''
                         end) extra, --额外信息                                  
                 b.Memo memo, --备注                                  
                 100 ye --余额
            from Doctor_AssignPatient da
            left join Bed a on da.NoOfInpat = a.NoOfInpat
                           and a.Valid = 1
            left join InPatient b on a.NoOfInpat = b.NoOfInpat
                                 and a.PatNoOfHis = b.PatNoOfHis
                                 and instr(rtrim(b.OutHosDept), v_Deptids) > 0
                                 and a.InBed = 1301
            left join MedicareInfo me on b.VouchersCode = me.ID
          --   left join YY_SFXXMK e  on b.AttendLevel = e.sfxmdm
            left join Diagnosis f on f.ICD = b.AdmitDiagnosis
            left join Users c on c.ID = b.Resident
            left join Dictionary_detail i on i.DetailID = b.CriticalLevel
                                         and i.CategoryID = '53'
            left join Users g on g.ID = a.Attend
            left join Users h on h.ID = a.Chief
            left join Dictionary_detail j on j.DetailID = b.SexID
                                         and j.CategoryID = '3'
           where da.ID = v_ID
             and da.Valid = 1;
      
        -- 检查手术信息:临时医嘱，已审核和已执行的，开始时间、手术时间在当前日期-3、+1之内
        v_sql := 'truncate table tmp_QueryBrowserInward_extraop ';
        execute immediate v_sql;
      
        insert into tmp_QueryBrowserInward_extraop
          select a.NoOfInpat,
                 datediff('dd', v_now, to_char(substr(a.Entrust, 1, 19))) diff
            from Temp_Order a, tmp_QueryBrowserinwardPatExist b
           where a.NoOfInpat = b.NoOfInpat
             and a.StartDate between v_ksrq and v_jsrq
             and a.OrderType = 3105
             and a.OrderStatus in (3201, 3202);
      
        update tmp_QueryBrowserinwardPatExist a
           set extra = (select a.extra + (case b.diff
                                 when 1 then
                                  '明日手术'
                                 when 0 then
                                  '今日手术'
                                 when -1 then
                                  '术后1天'
                                 when -2 then
                                  '术后2天'
                                 when -3 then
                                  '术后3天'
                                 else
                                  ''
                               end) + ' '
                          from tmp_QueryBrowserInward_extraop b
                         where a.NoOfInpat = b.NoOfInpat
                           and rownum < 1);
      
        -- 检查出院医嘱:临时医嘱，已审核和已执行的，开始时间、出院时间在当前日期0时之后
        v_sql := 'truncate table tmp_QueryBrowserInward_extraop ';
        execute immediate v_sql;
      
        insert into tmp_QueryBrowserInward_extraop
          select a.NoOfInpat,
                 datediff('dd', v_now, to_char(a.Entrust, 'yyyy-mm-dd')) diff
            from Temp_Order a, tmp_QueryBrowserinwardPatExist b
           where a.NoOfInpat = b.NoOfInpat
             and a.StartDate >= v_dqrq
             and a.OrderType = 3113
             and a.OrderStatus in (3201, 3202);
      
        update tmp_QueryBrowserinwardPatExist a
           set extra = (select a.extra + (case b.diff
                                 when 0 then
                                  '今日出院'
                                 when 1 then
                                  '明日出院'
                                 else
                                  to_char(b.diff) || '天后出院'
                               end) + ' '
                          from tmp_QueryBrowserInward_extraop b
                         where a.NoOfInpat = b.NoOfInpat
                           and rownum < 1);
      
        -- 检查转科医嘱:根据病人状态
        update tmp_QueryBrowserinwardPatExist a
           set extra = (select a.extra + b.Name + ' '
                          from CategoryDetail b
                         where b.CategoryID = a.brzt
                         and rownum < 1)
         where a.brzt in (1505, 1506, 1507);
      
        -- 检查病人是否有病历
        update tmp_QueryBrowserinwardPatExist a
           set extra = a.extra + '无病历'
         where NoOfInpat is not null
           and not exists (select 1
                  from MedicalRecord b
                 where a.NoOfInpat = b.NoOfInpat);
      
        select *
          from tmp_QueryBrowserinwardPatExist
         order by to_char(BedID, '0000');
      
      end;
    end if;
  
  end if;

end;
/

prompt
prompt Creating procedure USP_QUERYHISTORYPATIENTS
prompt ===========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_QueryHistoryPatients(v_wardid_in       varchar,
                                                     v_deptids         varchar,
                                                     v_PatID           varchar default '',
                                                     v_PatName         varchar default '',
                                                     v_OutDiagnosis    varchar default '',
                                                     v_AdmitDatebegin  varchar default '',
                                                     v_AdmitDatend     varchar default '',
                                                     v_OutHosDatebegin varchar default '',
                                                     v_OutHosDatend    varchar default '') as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取对应病区的床位信息
   功能说明
   输入参数
    v_wardid   varchar(6)   --病区代码
    v_deptids varchar(255)  --科室代码集合(形如: '代码1','代码2')
    v_PatID  varchar(30)=''  --住院号
    v_PatName  varchar(30)=''  --姓名
    v_OutDiagnosis  varchar(30)=''  --出院诊断
    v_OutHosDatebegin varchar(19)=''  --出院日期最小值
    v_OutHosDatend varchar(19)=''  --出院日期最大值
    v_AdmitDatebegin varchar(19)=''  --入院日期最小值
    v_AdmitDatend varchar(19)=''  --入院日期最大值
   输出参数
   结果集、排序
  在本病区住过的病人的病人信息
  病人的历次住院信息
  
   调用的sp
   调用实例
   exec usp_QueryInwardPatients   '2922','3225'
   修改记录
  
  **********/
  v_wardid           varchar2(6);
  v_nPatID           varchar(30);
  v_nPatName         varchar(30);
  v_nOutDiagnosis    varchar(19);
  v_nOutHosDatebegin varchar(19);
  v_nOutHosDatend    varchar(19);
  v_nAdmitDatebegin  varchar(19);
  v_nAdmitDatend     varchar(19);
  v_sql              varchar(400);
begin
  v_sql := 'truncate table tmp_QueryHistory_pats ';
  execute immediate v_sql;

  v_sql := 'truncate table tmp_QueryHistory_result ';
  execute immediate v_sql;


  if v_wardid_in is null then
    v_wardid := '';
  end if;
  --查询历史病人

  v_nPatID           := rtrim(v_PatID);
  v_nPatName         := rtrim(v_PatName);
  v_nOutDiagnosis    := rtrim(v_OutDiagnosis);
  v_nOutHosDatebegin := rtrim(v_OutHosDatebegin);
  v_nOutHosDatend    := rtrim(v_OutHosDatend);
  v_nAdmitDatebegin  := rtrim(v_AdmitDatebegin);
  v_nAdmitDatend     := rtrim(v_AdmitDatend);

  -- 找出入院或出院是在本科室的病人（不分在院和出院）
  insert into tmp_QueryHistory_pats
  select distinct InnerPIX
    from InPatient
   where (OutHosDept = v_deptids or AdmitDept = v_deptids)
     and (v_nPatID = '' or PatID like v_nPatID + '%')
     and (v_nPatName = '' or Name like v_nPatName + '%')
     and (v_nOutDiagnosis = '' or OutDiagnosis like v_nOutDiagnosis)
     and (v_nOutHosDatebegin = '' or (OutHosDate >= v_nOutHosDatebegin and
         OutHosDate <= v_nOutHosDatend))
     and (v_nAdmitDatebegin = '' or
         (AdmitDate >= v_nAdmitDatebegin and AdmitDate <= v_nAdmitDatend));

  -- 找出病人的历次住院信息
  insert into tmp_QueryHistory_result
  select b.NoOfInpat, --首页序号
         b.PatNoOfHis, --HIS首页序号
         b.PatID, --住院号
         b.Name, --姓名
         b.SexID, --病人性别
         b.NativeAddress, --户口地址
         substr(b.AdmitDate, 1, 16) AdmitDate, --入院日期
         c.Name AdmitDept, --入院科室
         d.Name AdmitWard, --入院病区
         e.Name AdmitDiagnosis, --入院诊断
         substr(b.OutHosDate, 1, 16) OutHosDate, --出院日期
         f.Name OutHosDept, --出院科室
         g.Name OutHosWard, --出院病区
         h.Name OutDiagnosis --出院诊断
    from tmp_QueryHistory_pats a
    join InPatient b on a.InnerPIX = b.InnerPIX
                            and b.Status in (1502, 1503)
    left join Department c on b.AdmitDept = c.ID
    left join Ward d on b.OutHosWard = d.ID
    left join Diagnosis e on b.AdmitDiagnosis = e.ICD
    left join Department f on b.OutHosDept = f.ID
    left join Ward g on b.OutHosWard = g.ID
    left join Diagnosis h on b.OutDiagnosis = h.ICD;

  -- 首先返回基本信息记录
  select PatID, --住院号
         Name, --姓名
         SexID, --病人性别
         NativeAddress --户口地址
    from tmp_QueryHistory_result
   where NoOfInpat in
         (select max(NoOfInpat) from tmp_QueryHistory_result group by PatID)
   order by PatID;

  -- 再返回历次住院信息
  select * from tmp_QueryHistory_result order by PatID, AdmitDate;

end;
/

prompt
prompt Creating procedure USP_QUERYINWARDPATIENTS
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_QueryInwardPatients(v_Wardid_in varchar,
                                                    v_Deptids   varchar,
                                                    v_zyhm      varchar default '',
                                                    v_hzxm      varchar default '',
                                                    v_cyzd      varchar default '',
                                                    v_ryrqbegin varchar default '',
                                                    v_ryrqend   varchar default '',
                                                    v_cyrqbegin varchar default '',
                                                    v_cyrqend   varchar default '',
                                                    --add by xjt
                                                    v_ID        varchar default '',
                                                    v_QueryType int default 0,
                                                    v_QueryNur  varchar default '',
                                                    v_QueryBed  varchar default 'Y') as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取对应病区的床位信息
   功能说明
   输入参数
    v_Wardid   varchar(6)   --病区代码
    v_Deptids varchar(255)  --科室代码集合(形如: '代码1','代码2')
    v_zyhm  varchar(30)=''  --住院号
    v_hzxm  varchar(30)=''  --姓名
    v_cyzd  varchar(30)=''  --出院诊断
    v_cyrqbegin varchar(19)=''  --出院日期最小值
    v_cyrqend varchar(19)=''  --出院日期最大值
    v_ryrqbegin varchar(19)=''  --入院日期最小值
    v_ryrqend varchar(19)=''  --入院日期最大值
   输出参数
   结果集、排序
  在病区的病人数据集
  
   调用的sp
   调用实例
   exec usp_QueryInwardPatients  '2911', '3202','','','','','','','','',3,'Y'
   修改记录
  护理级别待处理
  **********/
  v_Wardid varchar(6);
  v_dqrq   varchar(10);
  v_ksrq   varchar(10);
  v_jsrq   varchar(10);
  v_now    varchar(24);
  v_sql    varchar(4000);
begin

  v_sql := 'truncate table tmp_QueryInwardPatients ';
  execute immediate v_sql;

  v_sql := 'truncate table tmp_QueryInwardPats_extraop ';
  execute immediate v_sql;

  if v_Wardid_in is null then
    v_Wardid := ''; 
  end if;

  -- 先找出病人记录，然后读取病人的附加信息（手术、出院、转科等）
  insert into tmp_QueryInwardPatients
  select b.NoOfInpat NoOfInpat, --首页序号                
         b.PatNoOfHis PatNoOfHis, --HIS首页序号                
         b.PatID PatID, --住院号                
         b.Name PatName, --姓名                
         b.SexID Sex, --病人性别                
         b.SexID SexName, --病人性别名称                
         b.AgeStr AgeStr, --年龄                
         b.Py py, --拼音                
         b.Wb wb, --五笔                
         b.Status brzt, --病人状态                
         e.Name brztname, --病人状态名称                
         rtrim(b.CriticalLevel) wzjb, --危重级别                
         i.Name wzjbmc, --危重级别名称                
         --case when PatID is null then ''
         --     else '一级护理'
         --end hljb --护理级别 名称
         cd. Name hljb,
         case
           when b.AttendLevel is null then
            6105
         end AttendLevel, --护理级别
         b.IsBaby yebz, --婴儿标志                
         case
           when b.IsBaby = '0' then
            '否'
           when b.IsBaby is null then
            ''
           else
            '是'
         end yebzname,
         a.WardId bqdm, --病区代码                
         a.DeptID ksdm, --科室代码                
         a.ID BedID, --床位代码                
         dg.Name ksmc, --科室名称                
         wh.Name bqmc, --病区名称                
         a.FormerWard ybqdm, --原病区代码                
         a.FormerDeptID yksdm, --原科室代码                
         a.FormerDeptID ycwdm, --原床位代码                
         a.InBed InBed, --占床标志                
         a.Borrow jcbz, --借床标志                
         a.SexInfo cwlx, --床位类型                
         substr(b.AdmitDate, 1, 16) AdmitDate, --入院日期                
         f.Name ryzd, --入院诊断                
         f.Name zdmc, --诊断名称                
         b.Resident zyysdm, --住院医生代码                
         c.Name zyys, --住院医生                
         c.Name cwys, --床位医生                
         g.Name zzys, --主治医师
         h.Name zrys, --主任医师
         a.Valid yxjl, --有效记录
         me.pzlx pzlx, --凭证类型
         to_char((case
                   when instr(a.DeptID, v_Deptids) = 0 and (b.NoOfInpat is null) then
                    '属于其它科室'
                   else
                    ''
                 end)) extra, --额外信息
         b.Memo memo, --备注
         (case b.CPStatus
           when 0 then
            '未引入'
           when 1 then
            '执行中'
           when 2 then
            '退出'
         end) CPStatus,
         case
           when b.NoOfInpat is null then
            ''
           else
            '己书写'
         end recordinfo,
         100 ye, --余额
         (select case
                   when count(qc.FoulState) > 0 then
                    '是'
                   else
                    '否'
                 end
            from QCRecord qc
           where qc.NoOfInpat = b.NoOfInpat
             and qc.Valid = 1
             and qc.FoulState = 1) as IsWarn --是否违规
    from Bed a
    left join InPatient b on a.NoOfInpat = b.NoOfInpat
                         and a.PatNoOfHis = b.PatNoOfHis
                         and instr(rtrim(b.OutHosDept), v_Deptids) > 0
                         and a.InBed = 1301
                         and b.Status in (1501, 1504, 1505, 1506, 1507)
    left join CategoryDetail e on b.Status = e.ID
                              and e.CategoryID = 15
    left join MedicareInfo me on b.VouchersCode = me.ID
    left join Department dg on a.DeptID = dg.ID
    left join Ward wh on a.ID = dg.ID
  --   left join YY_SFXXMK e  on b.AttendLevel = e.sfxmdm
    left join Diagnosis f on f.ICD = b.AdmitDiagnosis
    left join Users c on c.ID = b.Resident
    left join Dictionary_detail i on i.DetailID = b.CriticalLevel
                                 and i.CategoryID = '53'
    left join Users g on g.ID = a.Attend
    left join Users h on h.ID = a.Chief
    left join Dictionary_detail j on j.DetailID = b.SexID
                                 and j.CategoryID = '3'
    left join CategoryDetail cd on b.AttendLevel = cd.ID
                               and cd.CategoryID = 63
  
   where a.WardId = v_Wardid
     and a.Valid = 1;

  v_dqrq := to_char(sysdate, 'yyyy-mm-dd');
  v_ksrq := to_char(sysdate - 3, 'yyyy-mm-dd');
  v_jsrq := to_char(sysdate + 2, 'yyyy-mm-dd');
  v_now  := to_char(sysdate, 'yyyy-mm-dd HH24:mi:sss');

  -- 检查手术信息:临时医嘱，已审核和已执行的，开始时间、手术时间在当前日期-3、+1之内
  insert into tmp_QueryInwardPats_extraop
  select a.NoOfInpat,
         datediff('dd', v_now, to_char(substr(a.Entrust, 1, 19))) diff
    from Temp_Order a, tmp_QueryInwardPatients b
   where a.NoOfInpat = b.NoOfInpat
     and a.StartDate between v_ksrq and v_jsrq
     and a.OrderType = 3105
     and a.OrderStatus in (3201, 3202);

  update tmp_QueryInwardPatients a
     set extra = (select a.extra + (case b.diff
                           when 1 then
                            '明日手术'
                           when 0 then
                            '今日手术'
                           when -1 then
                            '术后1天'
                           when -2 then
                            '术后2天'
                           when -3 then
                            '术后3天'
                           else
                            ''
                         end) || ' '
                    from tmp_QueryInwardPats_extraop b
                   where a.NoOfInpat = b.NoOfInpat
                     and rownum < 1);

  -- 检查出院医嘱:临时医嘱，已审核和已执行的，开始时间、出院时间在当前日期0时之后
  
    v_sql := 'truncate table tmp_QueryInwardPats_extraop ';
  execute immediate v_sql;
  insert into tmp_QueryInwardPats_extraop
  select a.NoOfInpat,
         datediff('dd', v_now, to_char(a.Entrust, 'yyyy-mm-dd')) diff
    from Temp_Order a, tmp_QueryInwardPatients b
   where a.NoOfInpat = b.NoOfInpat
     and a.StartDate >= v_dqrq
     and a.OrderType = 3113
     and a.OrderStatus in (3201, 3202);

  update tmp_QueryInwardPatients a
     set extra = (select a.extra || (case b.diff
                           when 0 then
                            '今日出院'
                           when 1 then
                            '明日出院'
                           else
                            to_char(b.diff) || '天后出院'
                         end) || ' '
                    from tmp_QueryInwardPats_extraop b
                   where a.NoOfInpat = b.NoOfInpat
                     and rownum < 1);

  -- 检查转科医嘱:根据病人状态
  update tmp_QueryInwardPatients a
     set extra = (select a.extra || b.Name || ' '
                    from CategoryDetail b
                   where b.CategoryID = a.brzt
                     and rownum < 1)
   where a.brzt in (1505, 1506, 1507);

  -- 检查病人是否有病历
  update tmp_QueryInwardPatients a
     set extra = extra || '无病历', recordinfo = '无病历'
   where NoOfInpat is not null
     and not exists
   (select 1 from MedicalRecord b where a.NoOfInpat = b.NoOfInpat);

  if v_QueryType = 0 then
    --全部
    begin
      select *
        from tmp_QueryInwardPatients
       order by to_char(BedID, '0000');
    end;
  elsif v_QueryType = 1 then
    --分管
    begin
      select *
        from tmp_QueryInwardPatients a
        join Doctor_AssignPatient da on a.NoOfInpat = da.NoOfInpat
                                    and da.ID = v_ID
                                    and da.Valid = 1
       order by to_char(BedID, '0000');
    end;
  
  elsif v_QueryType = 3 then
    --护理
    begin
      if v_QueryBed = 'N' then
        --不包含空床
        begin
          v_sql := 'select * from
                  tmp_QueryInwardPatients a
                  where a.NoOfInpat is not null ';
        
          execute immediate v_sql;
        end;
      end if;
      if v_QueryBed = 'Y' then
        --包含空床
        begin
          v_sql := 'select * from
                  tmp_QueryInwardPatients a
                  where 1 =1 ';
          execute immediate v_sql;
        
        end;
      end if;
    end;
  end if;

end;
/

prompt
prompt Creating procedure USP_QUERYNONARCHIVEPATIENTS
prompt ==============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_QueryNonarchivePatients(v_wardid_in varchar,
                                                        v_deptids   varchar) as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取对应病区的床位信息
   功能说明
   输入参数
    v_wardid  varchar(6)   --病区代码
    v_deptids varchar(255)  --科室代码集合(形如: '代码1','代码2')
   输出参数
   结果集、排序
  病区未归档病人数据集
  
   调用的sp
   调用实例
   exec usp_QueryInwardPatients  '2821', '7006'
   修改记录
  
  **********/
  v_wardid varchar2(6);
begin
  if v_wardid_in is null then
    v_wardid := '';
  
    select b.NoOfInpat NoOfInpat, --首页序号
           b.PatNoOfHis PatNoOfHis, --HIS首页序号
           b.PatID PatID, --住院号
           b.Name InpatName, --姓名
           b.SexID SexID, --病人性别
           b.AgeStr AgeStr, --年龄
           b.Status Status, --病人状态
           f.Name StatusName, --病人状态名称
           b.CriticalLevel CriticalLevel, --危重级别
           h.Name CriticalLevelName, --危重级别名称
           z.Name ResidentName, --住院医生
           substr(b.AdmitDate, 1, 16) AdmitDate, --入院日期
           b.AdmitDiagnosis AdmitDiagnosis, --入院诊断
           substr(b.OutHosDate, 1, 16) OutHosDate, --出院日期
           b.OutBed OutBed, --出院床位
           b.Memo Memo --备注
      from InPatient b
     inner join MedicalRecord k on b.NoOfInpat = k.NoOfInpat
                               and k.LockInfo in (4700, 4702, 4703)
      left join CategoryDetail f on b.Status = f.ID
      left join Users z on z.ID = b.Resident
      left join Dictionary_detail h on h.DetailID = b.CriticalLevel
                                   and h.CategoryID = '53'
     where b.OutHosDept = v_deptids
       and (v_wardid = '' or b.OutHosWard = v_wardid)
       and b.Status in (1502, 1503, 1504);
  end if;
end;
/

prompt
prompt Creating procedure USP_QUERYORDERSUITES
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_QueryOrderSuites
(
  v_DeptID varchar 
 ,v_WardID varchar 
 ,v_DoctorID varchar 
 ,v_IfInvoke int default 1
 )
as
/**********
 版本号  1.0.0.0.0
 创建时间
 作者
 版权
 描述  查询可用的成套医嘱
 功能说明
 现在按指定的科室进行查询。返回主记录和明细记录数据集
 输入参数
  v_DeptID varchar(6)  -- 科室代码
 ,v_WardID varchar(6)  -- 病区代码
 ,v_DoctorID varchar(6) -- 医生工号
 ,v_IfInvoke int -- 是否是医嘱录入模块调用(0: 否  1:是)
 输出参数
 结果集、排序
 成套医嘱主记录数据集
 成套医嘱明细数据集
 调用的sp
 调用实例
 exec usp_QueryOrderSuites '3225','2922', '00', 1
**********/
 begin

-- 在界面上将按照长期、临时分别显示相应的成套医嘱，所以在生成数据集时要特殊处理，以满足数据过滤的需要
select e.ID, a.DetailID, a.AdviceMark, a.SortMark, a.PlaceID, a.StandardID, a.ClinicID, a.DrugID, a.DrugName, a.ItemCategory, a.MinUnit, a.Dose, a.DoseUnit, a.UnitModulus, a.UnitCategory
 , a.UseageID, a.TimesID, a.RunTimes, a.RunCycle, a.RunCycleUnit, a.ZID, a.RunTime, a.RunDays, a.DrugGross, a.AdviceContent, a.AdviceCategory
 , e.Name, e.DeptID, e.WardID, e.DoctorID, e.UseRange, e.Memo, e.Py, e.Wb
 , b.Name UseageName, c.Name TimesName
into #tempdetail
 from UnitAdvice e (nolock) left join UnitAdviceDetail a (nolock) on a.UnitAdviceID = e.ID
  left join DrugUseage b (nolock) on a.UseageID = b.UseageID
  left join AdviceTimes c (nolock) on a.TimesID = c.TimesID
 where e.UseRange = 2900
    or (e.UseRange = 2901 and e.DeptID = v_DeptID)
    or (e.UseRange = 2903 and e.DoctorID = v_DoctorID);

-- 输出结果集
if v_IfInvoke = 1 then
 select distinct ID, Name, DeptID, WardID, DoctorID, UseRange, Memo, Py, Wb, AdviceMark, (case SortMark when 3104 then SortMark else -1 end) SortMark
  from #tempdetail
  order by UseRange, AdviceMark, SortMark, Name;
else
 select distinct ID, Name, DeptID, WardID, DoctorID, UseRange, Memo, Py, Wb
  from #tempdetail
  order by UseRange, Name;
 

select DetailID, ID, AdviceMark, SortMark, PlaceID, StandardID, ClinicID, DrugID, DrugName, ItemCategory, MinUnit, Dose, DoseUnit, UnitModulus, UnitCategory
 , UseageID, TimesID, RunTimes, RunCycle, RunCycleUnit, ZID, RunTime, RunDays, DrugGross, AdviceContent, AdviceCategory
 from #tempdetail
 where DetailID is not null
 order by ID, DetailID

return
end;
/

prompt
prompt Creating procedure USP_QUERYOWNMANAGERPAT
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_QueryOwnManagerPat(v_QueryType int,
                                                   v_UserID    varchar,
                                                   v_DeptID    varchar,
                                                   v_WardId    varchar) as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取病人提取界面病人列表
   功能说明
   输入参数
   v_QueryType int     查询类别
   v_UserID varchar(8) 用户ID
   v_DeptID varchar(6)     科室代码
   v_WardId varchar(6)     病区代码
   输出参数
   结果集、排序
  在病区的病人数据集
  
   调用的sp
   调用实例
  
   修改记录
  护理级别待处理
  **********/
  v_sql varchar(3000);
begin
  v_sql := 'truncate table tmp_QueryOwnManagerPat ';
  execute immediate v_sql;

  if v_QueryType = 0 then
    --获得除分管外的病人
    begin
      v_sql := 'select
    a.NoOfInpat  NoOfInpat--首页序号
  , a.PatNoOfHis PatNoOfHis --HIS首页序号
  , a.PatID PatID --住院号
  , a.Name PatName --姓名
  , a.SexID Sex  --病人性别
  , b.Name SexName  --病人性别名称
  , a.AgeStr AgeStr  --年龄
  , rtrim(a.CriticalLevel) wzjb --危重级别
  , a.Status arzt --病人状态
  , c.Name wzjbmc --危重级别名称
  , substring(a.AdmitDate,1,16) AdmitDate  --入院日期
  , d.ICD ryzd --入院诊断
  , d.Name zdmc --诊断名称
  , e.Note pzlx --凭证类型
  , f.DeptID ksdm
from InPatient a (nolock)
left join Dictionary_detail b  on b.DetailID = a.SexID and b.CategoryID = ''3''
left join Dictionary_detail c  on c.DetailID = a.CriticalLevel and c.CategoryID = ''53''
left join Diagnosis d  on d.ICD = a.AdmitDiagnosis
left join MedicareInfo e  ON a.VouchersCode = e.ID
left join Bed f   on f.NoOfInpat = a.NoOfInpat and f.PatNoOfHis = a.PatNoOfHis and f.InBed = 1301
where a.Status in (1501,1504,1505,1506,1507)
and  not exists (select 1 from Doctor_AssignPatient da where da.NoOfInpat=a.NoOfInpat and ID=' +
               v_UserID + ' and Valid=1)
and f.DeptID=''' + v_DeptID + ''' and  f.WardId=''' +
               v_WardId + '''
';
      --exec sp_executesql v_sql
      execute immediate v_sql;
    end;
  end if;

  if v_QueryType = 1 then
    --获得分管病人
    begin
      insert into Doctor_AssignPatient
        select v_UserID, NoOfInpat, 1, sysdate, v_UserID
          from InPatient a
         where Resident = v_UserID
           and Status in (1501, 1504, 1505, 1506, 1507)
           and not exists (select 1
                  from Doctor_AssignPatient da
                 where da.NoOfInpat = a.NoOfInpat
                   and ID = v_UserID
                   and Valid = 1);
                   
    insert into tmp_QueryOwnManagerPat
      select a.NoOfInpat NoOfInpat, --首页序号
             a.PatNoOfHis PatNoOfHis, --HIS首页序号
             a.PatID PatID, --住院号
             a.Name PatName, --姓名
             a.SexID Sex, --病人性别
             b.Name SexName, --病人性别名称
             a.AgeStr AgeStr, --年龄
             a.Status arzt, --病人状态
             ce.Name arztname, --病人状态name
             c.Name wzjbmc, --危重级别名称
             c.DetailID wzjb, --危重级别编码
             substr(a.AdmitDate, 1, 16) AdmitDate, --入院日期
             d.ICD ryzd ,--入院诊断  
             d.Name zdmc, --诊断名称
             e.Note pzlx, --凭证类型
             g.Name ksmc, --科室名称
             h.Name bqmc, --病区名称
             a.OutBed BedID, --出院床位号
             (select case
                       when count(qc.FoulState) > 0 then
                        '是'
                       else
                        '否'
                     end
                from QCRecord qc
               where qc.NoOfInpat = da.NoOfInpat
                 and qc.Valid = 1
                 and qc.FoulState = 1) as IsWarn --是否违规
            ,
             '己书写' recordinfo --有无病历
        from Doctor_AssignPatient da
        join InPatient a on da.NoOfInpat = a.NoOfInpat
                                and Valid = 1
                                and da.ID = v_UserID
        left join CategoryDetail ce on a.Status = ce.ID
                                   and ce.CategoryID = 15
        left join Dictionary_detail b on b.DetailID = a.SexID
                                             and b.CategoryID = '3'
        left join Dictionary_detail c on c.DetailID =
                                                 a.CriticalLevel
                                             and c.CategoryID = '53'
        left join Diagnosis d on d.ICD = a.AdmitDiagnosis
        left join MedicareInfo e ON a.VouchersCode = e.ID
        left join Bed f on f.NoOfInpat = a.NoOfInpat
                               and f.PatNoOfHis = a.PatNoOfHis
                               and f.InBed = 1301
        left join Department g on f.DeptID = g.ID
        left join Ward h on f.WardId = g.ID
       where a.Status in (1501, 1504, 1505, 1506, 1507);
    
      -- 检查病人是否有病历
      update tmp_QueryOwnManagerPat a
         set recordinfo = '无病历'  
       where NoOfInpat is not null
         and not exists
       (select 1 from MedicalRecord b where a.NoOfInpat = b.NoOfInpat);
    
      select * from tmp_QueryOwnManagerPat order by to_char(BedID, '0000');
    end;
  end if;

end;
/

prompt
prompt Creating procedure USP_QUERYOWNMANAGERPAT2
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_QueryOwnManagerPat2(QueryType int,
                                                    UserID    varchar,
                                                    DeptID    varchar,
                                                    WardId    varchar) as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取病人提取界面病人列表
   功能说明
   输入参数
   QueryType int     查询类别
   UserID varchar(8) 用户ID
   DeptID varchar(6)     科室代码
   WardId varchar(6)     病区代码
   输出参数
   结果集、排序
  在病区的病人数据集
  
   调用的sp
   调用实例
  
   修改记录
  护理级别待处理
  **********/
  v_sql varchar(3000);
begin

  if QueryType = 0 then
    --获得除分管外的病人
    begin
      v_sql := 'select
    a.NoOfInpat  NoOfInpat--首页序号
  , a.PatNoOfHis PatNoOfHis --HIS首页序号
  , a.PatID PatID --住院号
  , a.Name PatName --姓名
  , a.SexID Sex  --病人性别
  , b.Name SexName  --病人性别名称
  , a.AgeStr AgeStr  --年龄
  , rtrim(a.CriticalLevel) wzjb --危重级别
  , a.Status arzt --病人状态
  , c.Name wzjbmc --危重级别名称
  , substring(a.AdmitDate,1,16) AdmitDate  --入院日期
  , d.ICD ryzd --入院诊断
  , d.Name zdmc --诊断名称
  , e.Note pzlx --凭证类型
  , f.DeptID ksdm
from InPatient a (nolock)
left join Dictionary_detail b (nolock) on b.DetailID = a.SexID and b.CategoryID = ''3''
left join Dictionary_detail c (nolock) on c.DetailID = a.CriticalLevel and c.CategoryID = ''53''
left join Diagnosis d (nolock) on d.ICD = a.AdmitDiagnosis
left join MedicareInfo e (nolock) ON a.VouchersCode = e.ID
left join Bed f (nolock)  on f.NoOfInpat = a.NoOfInpat and f.PatNoOfHis = a.PatNoOfHis and f.InBed = 1301
where a.Status in (1501,1504,1505,1506,1507)
and  not exists (select 1 from Doctor_AssignPatient da where da.NoOfInpat=a.NoOfInpat and ID=' +
               UserID + ' and Valid=1)
and f.DeptID=''' + DeptID + ''' and  f.WardId=''' + WardId + '''
';
      --exec sp_executesql v_sql
      execute immediate v_sql;
    end;
  end if;

  if QueryType = 1 then
    --获得分管病人
    begin
      insert into Doctor_AssignPatient
        select UserID, NoOfInpat, 1, sysdate, UserID
          from InPatient a
         where Resident = UserID
           and Status in (1501, 1504, 1505, 1506, 1507)
           and not exists (select 1
                  from Doctor_AssignPatient da
                 where da.NoOfInpat = a.NoOfInpat
                   and ID = UserID
                   and Valid = 1);
      select a.NoOfInpat NoOfInpat, --首页序号         
             a.PatNoOfHis PatNoOfHis, --HIS首页序号    
             a.PatID PatID, --住院号
             a.Name PatName, --姓名
             a.SexID Sex, --病人性别
             b.Name SexName, --病人性别名称
             a.AgeStr AgeStr, --年龄
             a.Status arzt, --病人状态
             c.Name wzjbmc, --危重级别名称
             c.DetailID wzjb, --危重级别编码
             substr(a.AdmitDate, 1, 16) AdmitDate, --入院日期
             d.ICD ryzd, --入院诊断
             d.Name zdmc, --诊断名称
             e.Note pzlx, --凭证类型
             g.Name ksmc, --科室名称
             h.Name bqmc, --病区名称
             a.OutBed BedID, --出院床位号
             (select case
                       when count(qc.FoulState) > 0 then
                        '是'
                       else
                        '否'
                     end
                from QCRecord qc
               where qc.NoOfInpat = da.NoOfInpat
                 and qc.Valid = 1
                 and qc.FoulState = 1) as IsWarn --是否违规
        from Doctor_AssignPatient da
        join InPatient a on da.NoOfInpat = a.NoOfInpat
                        and Valid = 1
                        and da.ID = UserID
        left join Dictionary_detail b on b.DetailID = a.SexID
                                     and b.CategoryID = '3'
        left join Dictionary_detail c on c.DetailID = a.CriticalLevel
                                     and c.CategoryID = '53'
        left join Diagnosis d on d.ICD = a.AdmitDiagnosis
        left join MedicareInfo e ON a.VouchersCode = e.ID
        left join Bed f on f.NoOfInpat = a.NoOfInpat
                       and f.PatNoOfHis = a.PatNoOfHis
                       and f.InBed = 1301
        left join Department g on f.DeptID = g.ID
        left join Ward h on f.WardId = g.ID
       where a.Status in (1501, 1504, 1505, 1506, 1507)
      --group by  a.NoOfInpat,a.PatNoOfHis,a.PatID,a.Name,a.SexID,b.Name,a.AgeStr,a.Status,c.Name,substring(a.AdmitDate,1,16),d.ICD,d.Name,e.pzlx,g.Name,h.Name
      --and f.DeptID in DeptID
      ;
    end;
  end if;

end;
/

prompt
prompt Creating procedure USP_QUERYPATIENTINFOBYNOOFINP
prompt ================================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_QueryPatientInfoByNoOfInp(v_NoOfInpat int) as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  根据首页序号获取病人对应信息
   功能说明
   输入参数
   v_NoOfInpat int --首页序号
   输出参数
   结果集、排序
  在病区的病人数据集
  
   调用的sp
   调用实例
   exec usp_QueryPatientInfoByNoOfInpat 2
   修改记录
  护理级别待处理
  **********/
begin

  SELECT inp.NoOfInpat AS NoOfInpat,
         inp.PatNoOfHis AS PatNoOfHis,
         inp.PatID AS PatID,
         inp.Name AS Name,
         inp.SexID AS SexID,
         dd.Name AS SexName,
         inp.AgeStr AS AgeStr,
         bed.WardId AS WardId,
         bed.DeptID AS DeptID,
         bed.ID AS BedID,
         inp.AdmitDate AS AdmitDate,
         bed.WardId,
         bed.DeptID,
         ward.Name AS wardname,
         de.Name AS deptname,
         inp.OutHosDate AS OutHosDate,
         did.Name AS levelname,
         '一级护理' as carelevel,
         dia.Name as dianame,
         Users.Name as doctorname,
         cad.Name AS statusname
    FROM InPatient inp
    LEFT JOIN Dictionary_detail dd ON dd.CategoryID = '3'
                                  AND inp.SexID = dd.DetailID
    LEFT JOIN Bed bed ON inp.NoOfInpat = bed.NoOfInpat
                     and inp.PatNoOfHis = bed.PatNoOfHis
                     and bed.InBed = 1301
    left join Ward ward on bed.WardId = ward.ID
    left join Department de on bed.DeptID = de.ID
    left join Dictionary_detail did on inp.CriticalLevel = did.DetailID
                                   and did.CategoryID = '53'
    left join Diagnosis dia on inp.AdmitDiagnosis = dia.ICD
    LEFT JOIN Users ON inp.Resident = Users.ID
                   AND Users.Valid = 1
    LEFT JOIN CategoryDetail cad ON inp.Status = cad.ID
                                AND cad.CategoryID = 15
   WHERE inp.NoOfInpat = v_NoOfInpat
   order by inp.NoOfInpat;
end;
/

prompt
prompt Creating procedure USP_QUERYQCGRADE
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_QueryQCGrade(v_NoOfInpat int,
                                             v_OperUser  varchar) as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取质量评分
   功能说明
   输入参数
    v_NoOfInpat varchar(40)--首页序号,
    v_OperUser varchar(6) --操作人
   输出参数
   结果集、排序
  质量控制统计数据集
  
   调用的sp
   调用实例
   exec usp_QueryQCGrade  9,'00'
   修改记录
  **********/
  v_DoctorId varchar(6);
  v_sql      varchar2(400);
begin

  v_sql := 'truncate table tmp_QueryQCGrade ';
  execute immediate v_sql;

  --基本评分项目(INSERT 进评分表)
  insert into tmp_QueryQCGrade
    SELECT qct.TypeCode,
           qct.TypeName,
           qct.TypeInstruction,
           qct.TypeCategory,
           qct.TypeOrder,
           qct.TypeMemo,
           qci.ItemCode,
           qci.ItemName,
           qci.ItemInstruction, --项目说明
           qci.ItemDefaultScore,
           qci.ItemDefaultTarget, --指标标准，指标分
           '00' ower,
           'YIDAN' owername,
           qci.ItemTargetStandard,
           qci.ItemStandardScore,
           qci.ItemOrder,
           qci.ItemMemo
      FROM QCScoreType qct
      JOIN QCScoreItem qci ON qct.TypeCode = qci.TypeCode
                          AND qct.Valide = 1
                          AND qci.Valide = 1
                          AND NOT EXISTS
     (SELECT 1
                                 FROM QCGrade
                                WHERE QCGrade.ItemCode = ItemCode
                                  AND QCGrade.NoOfInpat = v_NoOfInpat)
     ORDER BY qct.TypeCode, qci.ItemOrder;

  SELECT Operator
    into v_DoctorId
    FROM MedicalRecord
   WHERE NoOfInpat = v_NoOfInpat
     and rownum < 1;

  INSERT INTO QCGrade
    (NoOfInpat, Doctor_ID, TypeCode, ItemCode, Create_Time, Create_User)
    SELECT v_NoOfInpat,
           v_DoctorId,
           tmp_QueryQCGrade.TypeCode,
           tmp_QueryQCGrade.ItemCode,
           sysdate,
           v_OperUser
      FROM tmp_QueryQCGrade;

  --基本评分项目
  SELECT qcg.ID,
         qcg.NoOfInpat,
         qct.TypeCode,
         qct.TypeName, --评分大项code&name
         qci.ItemCode,
         qci.ItemName, --项目代码code&name
         qci.ItemInstruction, --项目说明
         qcg.Doctor_ID AS Doctor_ID, --医师代码
         Users.Name AS DoctorName, --医师姓名
         qci.ItemDefaultScore, --标准分
         qcg.Grade, --评分
         qci.ItemTargetStandard,
         qci.ItemStandardScore, --指标标准，指标分
         qci.ItemOrder,
         qci.ItemMemo --评分说明
    FROM QCGrade qcg
    JOIN QCScoreType qct ON qcg.TypeCode = qct.TypeCode
                        AND qct.Valide = 1
    JOIN QCScoreItem qci ON qcg.TypeCode = qci.TypeCode
                        AND qcg.ItemCode = qci.ItemCode
                        AND qci.Valide = 1
    LEFT JOIN Users ON qcg.Doctor_ID = Users.ID
                   AND Users.Valid = 1
   WHERE qcg.NoOfInpat = v_NoOfInpat
   ORDER BY qcg.TypeCode, qci.ItemOrder;
END;
/

prompt
prompt Creating procedure USP_QUERYQCPATIENTINFO
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_QueryQCPatientInfo(v_DateTimeFrom varchar,
                                                   v_DateTimeTo   varchar,
                                                   v_DeptId       varchar,
                                                   v_WardId       varchar,
                                                   v_bedId        varchar,
                                                   v_name         varchar,
                                                   v_archives     varchar) as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取质量控制病患数据
   功能说明
   输入参数
    v_DateTimeFrom varchar(9) --开始时间
   ,v_DateTimeTo  varchar(9) --结束时间
   ,v_DeptId varchar(10) --科室
   ,v_WardId varchar(10) --病区
   ,v_bedId varchar (10) --床位
   ,v_name varchar(20) --姓名
   ,v_archives varchar(1)--归档类型
   输出参数
   结果集、排序
  质量控制统计数据集
  
   调用的sp
   调用实例
   exec usp_QueryQCPatientInfo '2007-06-01', '2010-06-30','','','','',''
   修改记录
  ,环节质控次数 CycleTimes,环节质控扣分 Deduction,书写文书份数 Copies
  **********/
  v_sql varchar(3000);
begin

  v_sql := 'SELECT inp.NoOfInpat AS NoOfInpat,inp.PatNoOfHis AS PatNoOfHis,inp.PatID AS PatID
,inp.Name AS Name,inp.SexID AS SexID,dd.Name AS SexName,inp.AgeStr AS AgeStr
, bed.WardId AS WardId, bed.DeptID AS DeptID, bed.ID  AS BedID,inp.AdmitDate AS AdmitDate
,bed.WardId,bed.DeptID,ward.Name AS wardname,de.Name AS deptname
,NULL CycleTimes,NULL Deduction
,(SELECT count(NoOfInpat)  FROM RecordDetail where RecordDetail.NoOfInpat = inp.NoOfInpat) as Copies
, isnull(inp.Name,''-'') +''/''+ isnull(dd.Name,''-'')+''/''+ isnull(inp.AgeStr,''-'')
+''/''+isnull(ward.Name,''-'')+''/''+isnull(de.Name,''-'') +''/'' + isnull(bed.ID,''-'') +''床/''
+ isnull(inp.AdmitDate,''-'') + ''入院'' as showinfo
FROM InPatient inp';
  if v_archives = '0' then
    --未归档
    begin
      v_sql := v_sql +
               ' JOIN MedicalRecord med ON inp.NoOfInpat = med.NoOfInpat AND med.LockInfo IN (4700)';
    end;
  elsif v_archives = '1' then
    --已归档
    begin
      v_sql := v_sql +
               ' JOIN MedicalRecord med ON inp.NoOfInpat = med.NoOfInpat AND med.LockInfo IN (4701)';
    end;
  elsif v_archives = '2' then
    --撤销归档
    begin
      v_sql := v_sql +
               ' JOIN MedicalRecord med ON inp.NoOfInpat = med.NoOfInpat AND med.LockInfo IN (4702)';
    end;
  end if;
  v_sql := v_sql +
           ' LEFT JOIN Dictionary_detail dd (nolock) ON dd.CategoryID = ''3'' AND inp.SexID = dd.DetailID
LEFT JOIN Bed bed (nolock) ON inp.NoOfInpat = bed.NoOfInpat and inp.PatNoOfHis =bed.PatNoOfHis and bed.InBed = 1301';
  IF v_bedId != '' then
    BEGIN
      v_sql := v_sql + ' and isnull(bed.ID,'''') like ''' + '%' + v_bedId + '''';
    END;
  end if;
  v_sql := v_sql + ' left join Ward ward (nolock) on bed.WardId = ward.ID';
  IF v_WardId != '' then
    BEGIN
      v_sql := v_sql + ' and isnull(ward.ID,'''') = ''' + v_WardId + '''';
    END;
  end if;
  v_sql := v_sql +
           ' left join Department de (nolock) on bed.DeptID = de.ID';
  IF v_DeptId != '' then
    BEGIN
      v_sql := v_sql + ' and isnull(de.ID,'''') = ''' + v_DeptId + '''';
    END;
  end if;
  v_sql := v_sql +
           ' WHERE inp.Status NOT IN (1509) AND CONVERT(varchar(10),inp.AdmitDate,102) >= ''' +
           v_DateTimeFrom + '''';
  v_sql := v_sql + ' AND CONVERT(varchar(10),inp.AdmitDate,102) <= ''' +
           v_DateTimeTo + '''';
  IF v_name != '' then
    BEGIN
      v_sql := v_sql + ' and isnull(inp.Name,'''') like ''' + '%' + v_name + '%' + '''';
    END;
  end if;

  v_sql := v_sql + ' order by inp.NoOfInpat';

  execute immediate v_sql;

end;
/

prompt
prompt Creating procedure USP_QUERYQCPROBLEMINFO
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_QueryQCProblemInfo(v_NoOfInpat int) as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取问题登记数据
   功能说明
   输入参数
    v_NoOfInpat int
   输出参数
   结果集、排序
  质量控制统计数据集
  
   调用的sp
   调用实例
   exec usp_QueryQCProblemInfo 2
   修改记录
  **********/
begin

  SELECT qcd.ID,
         ip.Name,
         ip.PatID,
         to_char(qcd.ProblemDate, 'yyyy.mm.dd') AS ProblemDate,
         qcd.TypeCode AS TypeCode,
         qct.TypeName AS TypeName,
         to_char(qcd.RegisterDate, 'yyyy.mm.dd') AS RegisterDate,
         us1.Name AS RegisterName,
         to_char(qcd.AnswerDate, 'yyyy.mm.dd') AS AnswerDate,
         us2.Name AS AnsewerName,
         to_char(qcd.ConfirmDate, 'yyyy.mm.dd') AS ConfirmDate,
         us3.Name AS ConfirmUser,
         qcd.Category,
         qcd.NoOfInpat,
         CASE qcd.Category
           WHEN 0 THEN
            '提交'
           WHEN 1 THEN
            '审核'
           WHEN 2 THEN
            '作废'
         END CategoryName,
         qcd.Status,
         CASE qcd.Status
           WHEN 0 THEN
            '登记'
           WHEN 1 THEN
            '答复'
         END StatusName,
         qcd.Description,
         qcd.AnsewerContent,
         qcd.ConfirmContent
  
    FROM QCProblemDescription qcd
    JOIN InPatient ip ON qcd.NoOfInpat = ip.NoOfInpat
    LEFT JOIN Users us1 ON qcd.RegisterUser = us1.ID
    LEFT JOIN Users us2 ON qcd.AnswerUser = us2.ID
    LEFT JOIN Users us3 ON qcd.ConfirmUser = us3.ID
    JOIN QCScoreType qct ON qcd.TypeCode = qct.TypeCode
   WHERE qcd.NoOfInpat = v_NoOfInpat
     AND qcd.Category NOT IN (2)
   ORDER BY qcd.RegisterDate;

end;
/

prompt
prompt Creating procedure USP_QUERYQCSTATDETAILINFO
prompt ============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_QueryQCStatDetailInfo
(
  v_DateTimeBegin varchar 
 ,v_DateTimeEnd  varchar 
 ,v_QCStatType int
 )
as
/**********
 版本号  1.0.0.0.0
 创建时间
 作者
 版权
 描述  获取质量控制统计数据
 功能说明
 输入参数
  v_DateTimeBegin varchar(9) --开始时间
 ,v_v_DateTimeEnd  varchar(9) --结束时间
 ,v_QCStatType int --统计资料类型
 输出参数
 结果集、排序
质量控制统计数据集

 调用的sp
 调用实例
 exec usp_QueryQCStatDetailInfo '2007-06-01', '2010-06-30',1
 修改记录
**********/
begin


IF v_QCStatType = 1 then
  --在院患者 isnull(,'-')
  SELECT inp.NoOfInpat AS NoOfInpat,inp.PatNoOfHis AS PatNoOfHis,inp.PatID AS PatID
  ,inp.Name AS Name,inp.SexID AS SexID,dd.Name AS SexName,inp.AgeStr AS AgeStr
  , bed.WardId AS WardId, bed.DeptID AS DeptID, bed.ID  AS BedID,inp.AdmitDate AS AdmitDate
  ,bed.WardId,bed.DeptID,ward.Name AS wardname,de.Name AS deptname
  ,NULL CycleTimes,NULL Deduction
  ,(SELECT count(NoOfInpat)  FROM RecordDetail where RecordDetail.NoOfInpat = inp.NoOfInpat) as Copies
  , nvl(inp.Name,'-') +'/'+ nvl(dd.Name,'-')+'/'+ nvl(inp.AgeStr,'-')
  +'/'+nvl(ward.Name,'-')+'/'+nvl(de.Name,'-') +'/' + nvl(bed.ID,'-') +'床/'
  +nvl(inp.AdmitDate,'-') + '入院' as showinfo
  FROM InPatient inp
  LEFT JOIN Dictionary_detail dd  ON dd.CategoryID = '3' AND inp.SexID = dd.DetailID
  LEFT JOIN Bed bed  ON inp.NoOfInpat = bed.NoOfInpat and inp.PatNoOfHis =bed.PatNoOfHis and bed.InBed = 1301
  left join Ward ward  on bed.WardId = ward.ID
  left join Department de  on bed.DeptID = de.ID
  WHERE inp.Status IN  (1500,1501,1504,1505,1506,1507) AND to_char(inp.AdmitDate, 'yyyy.mm.dd') >= v_DateTimeBegin
  AND to_char(inp.AdmitDate, 'yyyy.mm.dd') <= v_DateTimeEnd
  order by inp.NoOfInpat;
  
ELSIF v_QCStatType = 2 then
  --出院已提交
  SELECT inp.NoOfInpat AS NoOfInpat,inp.PatNoOfHis AS PatNoOfHis,inp.PatID AS PatID
  ,inp.Name AS Name,inp.SexID AS SexID,dd.Name AS SexName,inp.AgeStr AS AgeStr
  , bed.WardId AS WardId, bed.DeptID AS DeptID, bed.ID  AS BedID,inp.AdmitDate AS AdmitDate
  ,bed.WardId,bed.DeptID,ward.Name AS wardname,de.Name AS deptname
  ,NULL CycleTimes,NULL Deduction
  ,(SELECT count(NoOfInpat)  FROM RecordDetail where RecordDetail.NoOfInpat = inp.NoOfInpat) as Copies
  , nvl(inp.Name,'-') +'/'+ nvl(dd.Name,'-')+'/'+ nvl(inp.AgeStr,'-')
  +'/'+nvl(ward.Name,'-')+'/'+nvl(de.Name,'-') +'/' + nvl(bed.ID,'-') +'床/'
  +nvl(inp.AdmitDate,'-') + '入院' as showinfo
  FROM InPatient inp
  JOIN MedicalRecord med ON inp.NoOfInpat = med.NoOfInpat AND med.LockInfo IN (4701)
  LEFT JOIN Dictionary_detail dd  ON dd.CategoryID = '3' AND inp.SexID = dd.DetailID
  LEFT JOIN Bed bed  ON inp.NoOfInpat = bed.NoOfInpat and inp.PatNoOfHis =bed.PatNoOfHis and bed.InBed = 1301
  left join Ward ward  on bed.WardId = ward.ID
  left join Department de  on bed.DeptID = de.ID
  WHERE inp.Status IN  (1502,1503) AND to_char(inp.AdmitDate, 'yyyy.mm.dd') >= v_DateTimeBegin
  AND to_char(inp.AdmitDate, 'yyyy.mm.dd') <= v_DateTimeEnd
  order by inp.NoOfInpat;
ELSIF v_QCStatType = 3 then
  --当日违规数
  SELECT inp.NoOfInpat AS NoOfInpat,inp.PatNoOfHis AS PatNoOfHis,inp.PatID AS PatID
  ,inp.Name AS Name,inp.SexID AS SexID,dd.Name AS SexName,inp.AgeStr AS AgeStr
  , bed.WardId AS WardId, bed.DeptID AS DeptID, bed.ID  AS BedID,inp.AdmitDate AS AdmitDate
  ,bed.WardId,bed.DeptID,ward.Name AS wardname,de.Name AS deptname
  ,NULL CycleTimes,NULL Deduction
  ,(SELECT count(NoOfInpat)  FROM RecordDetail where RecordDetail.NoOfInpat = inp.NoOfInpat) as Copies
  , nvl(inp.Name,'-') +'/'+ nvl(dd.Name,'-')+'/'+ nvl(inp.AgeStr,'-')
  +'/'+nvl(ward.Name,'-')+'/'+nvl(de.Name,'-') +'/' + nvl(bed.ID,'-') +'床/'
  +nvl(inp.AdmitDate,'-') + '入院' as showinfo
  from QCRecord a join InPatient inp on a.NoOfInpat = inp.NoOfInpat AND inp.Status IN (1500,1501,1504,1505,1506,1507)
  AND to_char(inp.AdmitDate, 'yyyy.mm.dd') >= v_DateTimeBegin
  AND to_char(inp.AdmitDate, 'yyyy.mm.dd') <= v_DateTimeEnd
  LEFT JOIN Dictionary_detail dd  ON dd.CategoryID = '3' AND inp.SexID = dd.DetailID
  LEFT JOIN Bed bed  ON inp.NoOfInpat = bed.NoOfInpat and inp.PatNoOfHis =bed.PatNoOfHis and bed.InBed = 1301
  left join Ward ward  on bed.WardId = ward.ID
  left join Department de  on bed.DeptID = de.ID
  JOIN QCRule d on a.RuleCode=d.RuleCode
  LEFT JOIN Users c  on a.DocotorID=c.ID
  where a.Valid != 0
  and a.FoulState in (1,3)
  order by inp.NoOfInpat;
ELSIF v_QCStatType = 4 then
  --危重病人
  SELECT inp.NoOfInpat AS NoOfInpat,inp.PatNoOfHis AS PatNoOfHis,inp.PatID AS PatID
  ,inp.Name AS Name,inp.SexID AS SexID,dd.Name AS SexName,inp.AgeStr AS AgeStr
  , bed.WardId AS WardId, bed.DeptID AS DeptID, bed.ID  AS BedID,inp.AdmitDate AS AdmitDate
  ,bed.WardId,bed.DeptID,ward.Name AS wardname,de.Name AS deptname
  ,NULL CycleTimes,NULL Deduction
  ,(SELECT count(NoOfInpat)  FROM RecordDetail where RecordDetail.NoOfInpat = inp.NoOfInpat) as Copies
  , nvl(inp.Name,'-') +'/'+ nvl(dd.Name,'-')+'/'+ nvl(inp.AgeStr,'-')
  +'/'+nvl(ward.Name,'-')+'/'+nvl(de.Name,'-') +'/' + nvl(bed.ID,'-') +'床/'
  +nvl(inp.AdmitDate,'-') + '入院' as showinfo
  FROM InPatient inp
  LEFT JOIN Dictionary_detail dd  ON dd.CategoryID = '3' AND inp.SexID = dd.DetailID
  LEFT JOIN Bed bed  ON inp.NoOfInpat = bed.NoOfInpat and inp.PatNoOfHis =bed.PatNoOfHis and bed.InBed = 1301
  left join Ward ward  on bed.WardId = ward.ID
  left join Department de  on bed.DeptID = de.ID
  WHERE inp.CriticalLevel = 1 AND inp.Status IN (1500,1501,1504,1505,1506,1507) 
  AND to_char(inp.AdmitDate, 'yyyy.mm.dd') >= v_DateTimeBegin
  AND to_char(inp.AdmitDate, 'yyyy.mm.dd') <= v_DateTimeEnd
  order by inp.NoOfInpat;

ELSIF v_QCStatType = 5 then
  --手术病人数,需要修改
  SELECT inp.NoOfInpat AS NoOfInpat,inp.PatNoOfHis AS PatNoOfHis,inp.PatID AS PatID
  ,inp.Name AS Name,inp.SexID AS SexID,dd.Name AS SexName,inp.AgeStr AS AgeStr
  , bed.WardId AS WardId, bed.DeptID AS DeptID, bed.ID  AS BedID,inp.AdmitDate AS AdmitDate
  ,bed.WardId,bed.DeptID,ward.Name AS wardname,de.Name AS deptname
  ,NULL CycleTimes,NULL Deduction
  ,(SELECT count(NoOfInpat)  FROM RecordDetail where RecordDetail.NoOfInpat = inp.NoOfInpat) as Copies
  , nvl(inp.Name,'-') +'/'+ nvl(dd.Name,'-')+'/'+ nvl(inp.AgeStr,'-')
  +'/'+nvl(ward.Name,'-')+'/'+nvl(de.Name,'-') +'/' + nvl(bed.ID,'-') +'床/'
  +nvl(inp.AdmitDate,'-') + '入院' as showinfo
  FROM InPatient inp
  LEFT JOIN Dictionary_detail dd  ON dd.CategoryID = '3' AND inp.SexID = dd.DetailID
  LEFT JOIN Bed bed  ON inp.NoOfInpat = bed.NoOfInpat and inp.PatNoOfHis =bed.PatNoOfHis and bed.InBed = 1301
  left join Ward ward  on bed.WardId = ward.ID
  left join Department de  on bed.DeptID = de.ID
  WHERE inp.Status IN (1500,1501,1504,1505,1506,1507) AND to_char(inp.AdmitDate, 'yyyy.mm.dd') >= v_DateTimeBegin
  AND to_char(inp.AdmitDate, 'yyyy.mm.dd') <= v_DateTimeEnd
  AND (to_number(sysdate - inp.AdmitDate) > 30)
  order by inp.NoOfInpat;

ELSIF v_QCStatType = 6 then
  --死亡病人数,需要修改
  SELECT inp.NoOfInpat AS NoOfInpat,inp.PatNoOfHis AS PatNoOfHis,inp.PatID AS PatID
  ,inp.Name AS Name,inp.SexID AS SexID,dd.Name AS SexName,inp.AgeStr AS AgeStr
  , bed.WardId AS WardId, bed.DeptID AS DeptID, bed.ID  AS BedID,inp.AdmitDate AS AdmitDate
  ,bed.WardId,bed.DeptID,ward.Name AS wardname,de.Name AS deptname
  ,NULL CycleTimes,NULL Deduction
  ,(SELECT count(NoOfInpat)  FROM RecordDetail where RecordDetail.NoOfInpat = inp.NoOfInpat) as Copies
  , nvl(inp.Name,'-') +'/'+ nvl(dd.Name,'-')+'/'+ nvl(inp.AgeStr,'-')
  +'/'+nvl(ward.Name,'-')+'/'+nvl(de.Name,'-') +'/' + nvl(bed.ID,'-') +'床/'
  +nvl(inp.AdmitDate,'-') + '入院' as showinfo
  FROM InPatient inp
  LEFT JOIN Dictionary_detail dd  ON dd.CategoryID = '3' AND inp.SexID = dd.DetailID
  LEFT JOIN Bed bed  ON inp.NoOfInpat = bed.NoOfInpat and inp.PatNoOfHis =bed.PatNoOfHis and bed.InBed = 1301
  left join Ward ward  on bed.WardId = ward.ID
  left join Department de  on bed.DeptID = de.ID
  WHERE inp.Status IN (1500,1501,1504,1505,1506,1507) AND to_char(inp.AdmitDate, 'yyyy.mm.dd') >= v_DateTimeBegin
  AND to_char(inp.AdmitDate, 'yyyy.mm.dd') <= v_DateTimeEnd
  AND (to_number(sysdate - inp.AdmitDate) > 30)
  order by inp.NoOfInpat;

ELSIF v_QCStatType = 7 then
  --住院超过30天
  SELECT inp.NoOfInpat AS NoOfInpat,inp.PatNoOfHis AS PatNoOfHis,inp.PatID AS PatID
  ,inp.Name AS Name,inp.SexID AS SexID,dd.Name AS SexName,inp.AgeStr AS AgeStr
  , bed.WardId AS WardId, bed.DeptID AS DeptID, bed.ID  AS BedID,inp.AdmitDate AS AdmitDate
  ,bed.WardId,bed.DeptID,ward.Name AS wardname,de.Name AS deptname
  ,NULL CycleTimes,NULL Deduction
  ,(SELECT count(NoOfInpat)  FROM RecordDetail where RecordDetail.NoOfInpat = inp.NoOfInpat) as Copies
  , nvl(inp.Name,'-') +'/'+ nvl(dd.Name,'-')+'/'+ nvl(inp.AgeStr,'-')
  +'/'+nvl(ward.Name,'-')+'/'+nvl(de.Name,'-') +'/' + nvl(bed.ID,'-') +'床/'
  +nvl(inp.AdmitDate,'-') + '入院' as showinfo
  FROM InPatient inp
  LEFT JOIN Dictionary_detail dd  ON dd.CategoryID = '3' AND inp.SexID = dd.DetailID
  LEFT JOIN Bed bed  ON inp.NoOfInpat = bed.NoOfInpat and inp.PatNoOfHis =bed.PatNoOfHis and bed.InBed = 1301
  left join Ward ward  on bed.WardId = ward.ID
  left join Department de  on bed.DeptID = de.ID
  WHERE inp.Status IN (1500,1501,1504,1505,1506,1507) AND to_char(inp.AdmitDate, 'yyyy.mm.dd') >= v_DateTimeBegin
  AND to_char(inp.AdmitDate, 'yyyy.mm.dd') <= v_DateTimeEnd
  AND (to_number(sysdate - inp.AdmitDate) > 30)
  order by inp.NoOfInpat;

ELSIF v_QCStatType = 8 then
--出院未提交
  SELECT inp.NoOfInpat AS NoOfInpat,inp.PatNoOfHis AS PatNoOfHis,inp.PatID AS PatID
  ,inp.Name AS Name,inp.SexID AS SexID,dd.Name AS SexName,inp.AgeStr AS AgeStr
  , bed.WardId AS WardId, bed.DeptID AS DeptID, bed.ID  AS BedID,inp.AdmitDate AS AdmitDate
  ,bed.WardId,bed.DeptID,ward.Name AS wardname,de.Name AS deptname
  ,NULL CycleTimes,NULL Deduction
  ,(SELECT count(NoOfInpat)  FROM RecordDetail where RecordDetail.NoOfInpat = inp.NoOfInpat) as Copies
  , nvl(inp.Name,'-') +'/'+ nvl(dd.Name,'-')+'/'+ nvl(inp.AgeStr,'-')
  +'/'+nvl(ward.Name,'-')+'/'+nvl(de.Name,'-') +'/' + nvl(bed.ID,'-') +'床/'
  +nvl(inp.AdmitDate,'-') + '入院' as showinfo
  FROM InPatient inp
  JOIN MedicalRecord med ON inp.NoOfInpat = med.NoOfInpat AND med.LockInfo IN (4700,4702,4703)
  LEFT JOIN Dictionary_detail dd  ON dd.CategoryID = '3' AND inp.SexID = dd.DetailID
  LEFT JOIN Bed bed  ON inp.NoOfInpat = bed.NoOfInpat and inp.PatNoOfHis =bed.PatNoOfHis and bed.InBed = 1301
  left join Ward ward  on bed.WardId = ward.ID
  left join Department de  on bed.DeptID = de.ID
  WHERE inp.Status IN  (1502,1503) AND to_char(inp.AdmitDate, 'yyyy.mm.dd') >= v_DateTimeBegin
  AND to_char(inp.AdmitDate, 'yyyy.mm.dd') <= v_DateTimeEnd
  order by inp.NoOfInpat;

ELSIF v_QCStatType = 9 then
--归档病历
SELECT inp.NoOfInpat AS NoOfInpat,inp.PatNoOfHis AS PatNoOfHis,inp.PatID AS PatID
  ,inp.Name AS Name,inp.SexID AS SexID,dd.Name AS SexName,inp.AgeStr AS AgeStr
  , bed.WardId AS WardId, bed.DeptID AS DeptID, bed.ID  AS BedID,inp.AdmitDate AS AdmitDate
  ,bed.WardId,bed.DeptID,ward.Name AS wardname,de.Name AS deptname
  ,NULL CycleTimes,NULL Deduction
  ,(SELECT count(NoOfInpat)  FROM RecordDetail where RecordDetail.NoOfInpat = inp.NoOfInpat) as Copies
  , nvl(inp.Name,'-') +'/'+ nvl(dd.Name,'-')+'/'+ nvl(inp.AgeStr,'-')
  +'/'+nvl(ward.Name,'-')+'/'+nvl(de.Name,'-') +'/' + nvl(bed.ID,'-') +'床/'
  +nvl(inp.AdmitDate,'-') + '入院' as showinfo
  FROM InPatient inp
  JOIN MedicalRecord med ON inp.NoOfInpat = med.NoOfInpat AND med.LockInfo IN (4700,4702,4703)
  LEFT JOIN Dictionary_detail dd  ON dd.CategoryID = '3' AND inp.SexID = dd.DetailID
  LEFT JOIN Bed bed  ON inp.NoOfInpat = bed.NoOfInpat and inp.PatNoOfHis =bed.PatNoOfHis and bed.InBed = 1301
  left join Ward ward  on bed.WardId = ward.ID
  left join Department de  on bed.DeptID = de.ID
  WHERE inp.Status IN (1500,1501,1504,1505,1506,1507) AND to_char(inp.AdmitDate, 'yyyy.mm.dd') >= v_DateTimeBegin
  AND to_char(inp.AdmitDate, 'yyyy.mm.dd') <= v_DateTimeEnd
  order by inp.NoOfInpat;
  
  end if;
 
end;
/

prompt
prompt Creating procedure USP_QUERYQCSTATINFO
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_QueryQCStatInfo
(
  v_DateTimeBegin varchar 
 ,v_DateTimeEnd  varchar 
 )
as
/**********
 版本号  1.0.0.0.0
 创建时间
 作者
 版权
 描述  获取质量控制统计数据(有查询条件)
 功能说明
 输入参数
  v_DateTimeBegin varchar(9) --开始时间
 ,v_v_DateTimeEnd  varchar(9) --结束时间
 输出参数
 结果集、排序
质量控制统计数据集

 调用的sp
 调用实例
 exec usp_QueryQCStatQueryInfo  '2007-06-14', '2007-09-20'
 修改记录
**********/
begin


--在院患者
SELECT count(*) statnumber,'在院患者' statitem,1 qctype  FROM InPatient
WHERE Status IN  (1501,1505,1506,1507)
UNION
----出院以提交
--SELECT count(*) statnumber,'出院已提交' statitem,2 qctype FROM InPatient inp JOIN MedicalRecord med
--ON inp.NoOfInpat = med.NoOfInpat AND med.LockInfo IN (4701) AND CONVERT(varchar(10),AdmitDate,102) >= v_DateTimeBegin
--AND CONVERT(varchar(10),AdmitDate,102) <= v_DateTimeEnd
--WHERE inp.Status IN  (1502,1503)
--UNION
--新入院患者
SELECT count(*) statnumber,'新入院患者' statitem,2 qctype  FROM InPatient
WHERE Status IN  (1501,1505,1506,1507)
--AND CONVERT(varchar(10),AdmitDate,102) >= v_DateTimeBegin
--AND CONVERT(varchar(10),AdmitDate,102) <= v_DateTimeEnd
UNION
--当日违规数
select count(*) statnumber,'违规病历' statitem,3 qctype
from QCRecord a join InPatient b on a.NoOfInpat=b.NoOfInpat AND b.Status IN (1500,1501,1504,1505,1506,1507)
AND to_char(AdmitDate, 'yyyy.mm.dd') >= v_DateTimeBegin
AND to_char(AdmitDate, 'yyyy.mm.dd') <= v_DateTimeEnd
join QCRule d on a.RuleCode=d.RuleCode
left join Users c on a.DocotorID=c.ID
where a.Valid!=0
and a.FoulState in (1,3)
--
UNION
--危重病人
SELECT count(*) statnumber,'危重病人' statitem,4 qctype  FROM InPatient
WHERE CriticalLevel = 1 AND Status IN (1500,1501,1504,1505,1506,1507) AND to_char(AdmitDate, 'yyyy.mm.dd') >= v_DateTimeBegin
AND to_char(AdmitDate, 'yyyy.mm.dd') <= v_DateTimeEnd
UNION
--手术病人数,需要修改
SELECT  count(*) statnumber,'手术病人' statitem ,5 qctype FROM InPatient
WHERE Status IN (1500,1501,1504,1505,1506,1507) AND to_char(AdmitDate, 'yyyy.mm.dd') >= v_DateTimeBegin
AND to_char(AdmitDate, 'yyyy.mm.dd') <= v_DateTimeEnd
AND (to_number(sysdate - AdmitDate) > 30)
--
UNION
--死亡病人数,需要修改
SELECT  count(*) statnumber,'死亡病人' statitem,6 qctype  FROM InPatient
WHERE Status IN (1500,1501,1504,1505,1506,1507) AND to_char(AdmitDate, 'yyyy.mm.dd') >= v_DateTimeBegin
AND to_char(AdmitDate, 'yyyy.mm.dd') <= v_DateTimeEnd
AND (to_number(sysdate - AdmitDate) > 30)

--住院超过30天
UNION
SELECT  count(*) statnumber,'住院超过30天' statitem,7 qctype  FROM InPatient
WHERE Status IN (1500,1501,1504,1505,1506,1507) AND to_char(AdmitDate, 'yyyy.mm.dd') >= v_DateTimeBegin
AND to_char(AdmitDate, 'yyyy.mm.dd') <= v_DateTimeEnd
AND (to_number(sysdate - AdmitDate) > 30)

--出院未提交
UNION
SELECT count(*) statnumber,'出院未提交' statitem,8 qctype FROM InPatient inp JOIN MedicalRecord med
ON inp.NoOfInpat = med.NoOfInpat AND med.LockInfo IN (4700,4702,4703) AND to_char(AdmitDate, 'yyyy.mm.dd') >= v_DateTimeBegin
AND to_char(AdmitDate, 'yyyy.mm.dd') <= v_DateTimeEnd
WHERE inp.Status IN  (1502,1503)

--归档病历
UNION
SELECT count(*) statnumber,'归档病历' statitem,9 qctype FROM InPatient inp JOIN MedicalRecord med
ON inp.NoOfInpat = med.NoOfInpat AND med.LockInfo IN (4700,4702,4703) AND to_char(AdmitDate, 'yyyy.mm.dd') >= v_DateTimeBegin
AND to_char(AdmitDate, 'yyyy.mm.dd') <= v_DateTimeEnd
WHERE inp.Status IN (1500,1501,1504,1505,1506,1507) order by qctype;
end    ;
/

prompt
prompt Creating procedure USP_QUERYQUITPATIENTNODOCTOR
prompt ===============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_QueryQuitPatientNoDoctor(v_Wardid_in varchar,
                                                         v_Deptids   varchar,
                                                         v_TimeFrom  varchar,
                                                         v_TimeTo    varchar,
                                                         v_QueryType int default 0) as
  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取对应病区的出院病患
   功能说明
   输入参数
    v_Wardid   varchar(6)   --病区代码
    v_Deptids varchar(255)  --科室代码集合(形如: '代码1','代码2')
      v_TimeFrom varchar(24),--开始时间
      v_TimeTo varchar(24),--结束时间
      v_QueryType int = 0,--类型
   输出参数
   结果集、排序
  在病区的病人数据集
  
   调用的sp
   调用实例
   exec usp_QueryQuitPatientNoDoctor  '2911', '3202' ,'2011-05-09','2011-05-09',1
   修改记录
  护理级别待处理
  **********/
  v_Wardid varchar(40);
  v_dqrq   varchar(10);
  v_ksrq   varchar(10);
  v_jsrq   varchar(10);
  v_now    varchar(24);
  v_sql    varchar(400);
begin
  v_sql := 'truncate table tmp_QueryQuitPatientNoDoctor ';
  execute immediate v_sql;

  v_sql := 'truncate table tmp_QueryQuitPatientNo_extraop ';
  execute immediate v_sql;

  if v_Wardid_in is null then
    v_Wardid := '';
  end if;
  -- 先找出病人记录，然后读取病人的附加信息（手术、出院、转科等）
  
  insert into tmp_QueryQuitPatientNoDoctor
  select b.NoOfInpat NoOfInpat, --首页序号          
         b.PatNoOfHis PatNoOfHis, --HIS首页序号          
         b.PatID PatID, --住院号          
         b.Name PatName, --姓名         
         b.SexID Sex, --病人性别          
         b.SexID SexName, --病人性别名称          
         b.AgeStr AgeStr, --年龄          
         b.Py py, --拼音          
         b.Wb wb, --五笔          
         b.Status brzt, --病人状态          
         e.Name brztname, --病人状态名称          
         rtrim(b.CriticalLevel) wzjb, --危重级别          
         i.Name wzjbmc, --危重级别名称          
         (case
           when PatID is null then
            ''
           else
            '一级护理'
         end) hljb, --护理级别          
         b.IsBaby yebz, --婴儿标志          
         (case
           when b.IsBaby = '0' then
            '否'
           when b.IsBaby is null then
            ''
           else
            '是'
         end) yebzname,
         b.OutHosWard bqdm, --病区代码          
         b.OutHosDept ksdm, --科室代码          
         b.OutBed BedID, --床位代码          
         dg.Name ksmc, --科室名称          
         wh.Name bqmc, --病区名称          
         b.AdmitWard ybqdm, --原病区代码          
         b.AdmitDept yksdm, --原科室代码          
         b.AdmitBed ycwdm, --原床位代码          
         --b.InBed InBed  --占床标志
         --                ,
         --                a.Borrow jcbz --借床标志
         --                ,
         --                a.SexInfo cwlx --床位类型
         --                ,
         substr(b.AdmitDate, 1, 16) AdmitDate, --入院日期          
         f.Name ryzd, --入院诊断          
         f.Name zdmc, --诊断名称         
         b.Resident zyysdm, --住院医生代码          
         c.Name zyys, --住院医生          
         c.Name cwys, --床位医生          
         g.Name zzys, --主治医师          
         h.Name zrys, --主任医师          
         --                b.Valid yxjl --有效记录
         --                ,
         me.pzlx pzlx, --凭证类型          
         to_char(case
                   when instr(b.OutHosDept, v_Deptids) = 0 and (b.NoOfInpat is null) then
                    '属于其它科室'
                   else
                    ''
                 end) extra, --额外信息          
         b.Memo memo, --备注          
         (case b.CPStatus
           when 0 then
            '未引入'
           when 1 then
            '执行中'
           when 2 then
            '退出'
         end) CPStatus,
         case
           when b.NoOfInpat is null then
            ''
           else
            '己书写'
         end recordinfo,
         100 ye, --余额          
         (select case
                   when count(qc.FoulState) > 0 then
                    '是'
                   else
                    '否'
                 end
            from QCRecord qc
           where qc.NoOfInpat = b.NoOfInpat
             and qc.Valid = 1
             and qc.FoulState = 1) as IsWarn --是否违规
    from InPatient b
    left join CategoryDetail e on b.Status = e.ID
                              and e.CategoryID = 15
    left join MedicareInfo me on b.VouchersCode = me.ID
    left join Department dg on b.OutHosDept = dg.ID
    left join Ward wh on b.OutHosWard = dg.ID
  --   left join YY_SFXXMK e  on b.AttendLevel = e.sfxmdm
    left join Diagnosis f on f.ICD = b.AdmitDiagnosis
    left join Users c on c.ID = b.Resident
    left join Dictionary_detail i on i.DetailID = b.CriticalLevel
                                 and i.CategoryID = '53'
    left join Users g on g.ID = b.Attend
    left join Users h on h.ID = b.Chief
    left join Dictionary_detail j on j.DetailID = b.SexID
                                 and j.CategoryID = '3'
   where b.OutHosWard = v_Wardid
     and b.Status not in (1509)
     and (v_TimeFrom is null or
         to_char(b.AdmitDate, 'yyyy-mm-dd') >= substr(v_TimeFrom, 10))
     and (v_TimeTo is null or
         to_char(b.AdmitDate, 'yyyy-mm-dd') <= substr(v_TimeTo, 10));

  v_dqrq := to_char(sysdate, 'yyyy-mm-dd');
  v_ksrq := to_char(sysdate - 3, 'yyyy-mm-dd');
  v_jsrq := to_char(sysdate + 2, 'yyyy-mm-dd');
  v_now  := to_char(sysdate, 'yyyy-mm-dd HH24:mi:sss');

  -- 检查手术信息:临时医嘱，已审核和已执行的，开始时间、手术时间在当前日期-3、+1之内
  insert into tmp_QueryQuitPatientNo_extraop
  select a.NoOfInpat, datediff('dd', v_now, substr(a.Entrust, 1, 19)) diff
    from Temp_Order a, tmp_QueryQuitPatientNoDoctor b
   where a.NoOfInpat = b.NoOfInpat
     and a.StartDate between v_ksrq and v_jsrq
     and a.OrderType = 3105
     and a.OrderStatus in (3201, 3202);

  update tmp_QueryQuitPatientNoDoctor a
     set extra = (select a.extra || (case b.diff
                           when 1 then
                            '明日手术'
                           when 0 then
                            '今日手术'
                           when -1 then
                            '术后1天'
                           when -2 then
                            '术后2天'
                           when -3 then
                            '术后3天'
                           else
                            ''
                         end) || ' '
                    from tmp_QueryQuitPatientNo_extraop b
                   where a.NoOfInpat = b.NoOfInpat
                     and rownum < 1);

  -- 检查出院医嘱:临时医嘱，已审核和已执行的，开始时间、出院时间在当前日期0时之后

  v_sql := 'truncate table tmp_QueryQuitPatientNo_extraop ';
  execute immediate v_sql;
  
  insert into tmp_QueryQuitPatientNo_extraop
  select a.NoOfInpat, datediff('dd', v_now, substr(a.Entrust, 10)) diff
    from Temp_Order a, tmp_QueryQuitPatientNoDoctor b
   where a.NoOfInpat = b.NoOfInpat
     and a.StartDate >= v_dqrq
     and a.OrderType = 3113
     and a.OrderStatus in (3201, 3202);

  update tmp_QueryQuitPatientNoDoctor a
     set extra = (select a.extra || (case b.diff
                           when 0 then
                            '今日出院'
                           when 1 then
                            '明日出院'
                           else
                            to_char(b.diff) || '天后出院'
                         end) || ' '
                    from tmp_QueryQuitPatientNo_extraop b
                   where a.NoOfInpat = b.NoOfInpat
                     and rownum < 1);

  -- 检查转科医嘱:根据病人状态
  update tmp_QueryQuitPatientNoDoctor a
     set extra = (select a.extra + b.Name + ' '
                    from CategoryDetail b
                   where b.CategoryID = a.brzt
                     and rownum < 1)
   where a.brzt in (1505, 1506, 1507);

  -- 检查病人是否有病历
  update tmp_QueryQuitPatientNoDoctor a
     set extra = a.extra + '无病历', recordinfo = '无病历'
   where NoOfInpat is not null
     and not exists
   (select 1 from MedicalRecord b where a.NoOfInpat = b.NoOfInpat);

  if v_QueryType = 0 then
    --出院末分配医生
    begin
      select *
        from tmp_QueryQuitPatientNoDoctor a
       where a.zyysdm is null
       order by to_char(BedID, '0000');
    end;
  else
    --全部病患
    begin
      select *
        from tmp_QueryQuitPatientNoDoctor
      --where   a.zyysdm in ( 1502, 1503 )
       order by to_char(BedID, '0000');
    end;
  end if;

end;
/

prompt
prompt Creating procedure USP_QUERYWARDINFO
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_QueryWardInfo
(
  v_Wardid    varchar ,
  v_Deptids  varchar
  )
as
/**********
 版本号  1.0.0.0.0
 创建时间
 作者   周辉
 版权
 描述  获取对应病区的概况
 功能说明
 输入参数
 exec usp_QueryWardInfo  '2914', '2210'
****************/
begin


   create table #wardinfo
 (
  InTotal  int  null,--在院人数
  OutTotal int  null,--今日出院人数
  OPTotal  int  null,--手术人数
  ArTotal  int  null,--未归档人数
  ShiftTotal int  null,--转科人数
  DangerTotal int  null,--病危人数
  QcTotal  int  null --超时限人数
 )

if v_Wardid is null
 select v_Wardid = ''

 -- 先找出病人记录，然后读取病人的附加信息（手术、出院、转科等）
 select
    a.NoOfInpat  --首页序号
  , a.PatNoOfHis  --HIS首页序号
  , a.PatID  --住院号
  , a.Name PatName --姓名
  , c.Name Sex  --病人性别
  , a.AgeStr --年龄
  , a.Py  --拼音
  , a.Wb  --五笔
  , a.Status  --病人状态
  , f.Name StatusName  --病人状态
  , d.Name CriticalName  --危重级别
  ,a.CriticalLevel
  , a.IsBaby  --婴儿标志
  , b.WardId  --病区代码
  , b.DeptID  --科室代码
  , b.ID BedID --床位代码
  , b.FormerWard  --原病区代码
  , b.FormerDeptID  --原科室代码
  , b.FormerBedID  --原床位代码
  , b.InBed  --占床标志
  , b.Borrow  --借床标志
  , substring(a.AdmitDate,1,16) AdmitDate --入院日期
  , substring(a.InWardDate,1,16) InWardDate --入区日期
  , substring(a.OutWardDate,1,16) OutWardDate --出区区日期
  , substring(a.OutHosDate,1,16) OutHosDate --结算日期
  ,  _Users .Name as Resident  --住院医生代码
 -- , a.Resident  --住院医生代码
  , a.Memo Memo --备注
  into #inward
  from InPatient a  (nolock)
  LEFT JOIN dbo.Users _Users (nolock) on  _Users .ID = a.Resident
  left join  Bed b(nolock)  on a.NoOfInpat = b.NoOfInpat
  left join Dictionary_detail c (nolock) on a.SexID=c.DetailID and c.CategoryID='3'
  left join Dictionary_detail d (nolock) on a.CriticalLevel=d.DetailID and d.CategoryID='53'
  left join Dictionary_detail f (nolock) on a.Status=f.DetailID and f.CategoryID='15'
  where charindex(rtrim(a.OutHosDept), v_Deptids) > 0  and a.Status in(1501,1505,1506,1507)


 declare v_dqrq varchar(10), v_ksrq varchar(10), v_jsrq varchar(10), v_now varchar(24)
 select v_dqrq = substring(convert(varchar, getdate(), 120), 1, 10)
  , v_ksrq = substring(convert(varchar, dateadd(d, -3, getdate()), 120), 1, 10)
  , v_jsrq = substring(convert(varchar, dateadd(d, 2, getdate()), 120), 1, 10)
  , v_now = getdate()

 -- 检查手术信息:临时医嘱，已审核和已执行的，开始时间、手术时间在当前日期-3、+1之内
 select a.*, datediff(d, v_now, convert(varchar(24), substring(a.Entrust, 1, 19)))  diff
 into #extraop
  from Temp_Order a (nolock) , #inward b
  where a.NoOfInpat = b.NoOfInpat
    and a.StartDate between v_ksrq and v_jsrq
    and a.OrderType = 3105
    and a.OrderStatus in (3201, 3202)


 -- 检查出院医嘱:临时医嘱，已审核和已执行的，开始时间、出院时间在当前日期0时之后
 select a.*, datediff(d,v_now,convert(varchar(24), a.Entrust)) diff
 into #extracy
  from Temp_Order a (nolock), #inward b
  where a.NoOfInpat = b.NoOfInpat
    and a.StartDate >= v_dqrq
    and a.OrderType = 3113
    and a.OrderStatus in (3201, 3202)

 --检查未归档病人病历:
 select a.* into #archive
 from #inward a(nolock), MedicalRecord b (nolock)
    where a.NoOfInpat = b.NoOfInpat
    and b.LockInfo in( 4700,4702,4703) and a.Status  in(1502,1503,1508)
 --检查转科医嘱:根据病人状态
 select * into #shiftward
 from #inward where Status in (1505, 1506, 1507)



 declare v_inTotal int,
   v_outTotal int,
   v_oPTotal int,
   v_arTotal int,
   v_shiftTotal int,
   v_danager int
 select v_inTotal=  count(*) from #inward where Status in(1501,1505,1506,1507)
 select v_outTotal= count(*) from #extracy
 select v_arTotal= count(*) from #archive
 select v_oPTotal= count(*) from #extraop
 select v_shiftTotal=count(*)from #shiftward
select v_danager=count(*)from #inward where  CriticalLevel=1
 insert #wardinfo values(v_inTotal,v_outTotal,v_oPTotal,v_arTotal,v_shiftTotal,v_danager,0)

  --返回病区概况
  select * from #wardinfo
  --  返回在院病人
  select * from #inward
  --返回今日出院病人
  select *from #extracy
  --返回近三日手术病人
  select *from #extraop
  --返回未归档病人
  select *from #archive
  --返回转科病人
  select *from #shiftward
  -- 还需要增加：病危病人统计、超时病人统计
  select *from #inward where  CriticalLevel=1
  select *from #inward where 1=2

end ;
/

prompt
prompt Creating procedure USP_REDACTPATIENTINFOFRM
prompt ===========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_RedactPatientInfoFrm(v_FrmType    varchar, --窗体类型，1n：病人信息管理维护窗体、2n：病人病历史信息窗体
                                                     v_NoOfInpat  numeric default '0', --首页序号
                                                     v_CategoryID varchar default '' --(字典)类别代码 、或父节点代码 、首页序号
                                                     ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  获取病人信息维护窗体控件初始化数据
   功能说明
   输入参数
   输出参数
   结果集、排序
  
  
   调用的sp
   调用实例
  exec usp_RedactPatientInfoFrm '16','0','1'
  exec usp_RedactPatientInfoFrm '14','75278','0'
  exec usp_RedactPatientInfoFrm '24','13','0'
   修改记录
  **********/

begin

  --  print v_FrmType
  --  print v_CategoryID

  if v_FrmType = '11' then
  
    --省市代码(病人信息管理维护窗体)
    select ParentID, ID, Name, Py, Wb
      from Areas
     where Category = v_CategoryID
     order by Name;
  
  elsif v_FrmType = '12' then
  
    --区县代码(病人信息管理维护窗体)
    select ParentID, ID, Name, Py, Wb
      from Areas
     where ParentID = v_CategoryID
     order by Name;
  
  elsif v_FrmType = '13' then
  
    --字典分类明细库(病人信息管理维护窗体)
    select CategoryID, DetailID, Name, Py, Wb Lens
      from Dictionary_detail
     where CategoryID = v_CategoryID
     order by DetailID;
  
  elsif v_FrmType = '14' then
  
    --病人基本信息
    select ip.*,
           u.Name as ClinicDoctorName,
           dd1.Name as StyleName,
           dd2.Name as OriginName,
           d.Name as ClinicDiagnosisName,
           cd.Name as StatusName,
           dd3.Name as CriticalLevelName,
           dd4.Name as AdmitInfoName,
           dd5.Name as AdmitWayName,
           dept1.Name as AdmitDeptName,
           w1.Name as AdmitWardName,
           dept2.Name as OutHosDeptName,
           w2.Name as OutHosWardName,
           dd6. Name as Gender,
           dd7. Name as Marriage,
           dd8. Name as JobName
      from InPatient ip
      left join Dictionary_detail dd1 on dd1.CategoryID = '45'
                                     and dd1.DetailID = ip.Style
      left join Dictionary_detail dd2 on dd2.CategoryID = '2'
                                     and dd2.DetailID = ip.Origin
      left join Users u on u.ID = ip.ClinicDoctor
      left join Diagnosis d on d.ICD = ip.ClinicDiagnosis
      left join CategoryDetail cd on cd.ID = ip.Status
                                 and cd.CategoryID = '15'
      left join Dictionary_detail dd3 on dd3.CategoryID = '53'
                                     and dd3.DetailID = ip.CriticalLevel
      left join Dictionary_detail dd4 on dd4.CategoryID = '5'
                                     and dd4.DetailID = ip.AdmitInfo
      left join Dictionary_detail dd5 on dd5.CategoryID = '6'
                                     and dd5.DetailID = ip.AdmitWay
      left join Department dept1 on dept1.ID = ip.AdmitDept
      left join Ward w1 on w1.ID = ip.AdmitWard
      left join Department dept2 on dept2.ID = ip.OutHosDept
      left join Ward w2 on w2.ID = ip.OutHosWard
    
    --Add By wwj 2011-05-17
      left join Dictionary_detail dd6 on dd6.CategoryID = '3'
                                     and dd6.DetailID = ip.SexID
      left join Dictionary_detail dd7 on dd7.CategoryID = '4'
                                     and dd7.DetailID = ip.Marital
      left join Dictionary_detail dd8 on dd8.CategoryID = '41'
                                     and dd8.DetailID = ip.JobID
     where ip.NoOfInpat = v_NoOfInpat;
  
  elsif v_FrmType = '15' then
  
    --第一联系人信息(病人信息管理维护窗体)
    select case
             when Tag = '1' then
              '是'
             else
              '否'
           end as TagName,
           a.*
      from PatientContacts a
     where a.NoOfInpat = v_NoOfInpat;
    --        select ID,pc.Name,dd1.Name as SexName,dd2.Name as RelationName,Address,WorkUnit,HomeTel,WorkTel,PostalCode,Tag
    --     from PatientContacts pc
    --     left join Dictionary_detail dd1 on dd1.CategoryID='3' and dd1.DetailID=Sex
    --     left join Dictionary_detail dd2 on dd2.CategoryID='44' and dd2.DetailID=Relation
    --     where NoOfInpat=v_NoOfInpat
  
  elsif v_FrmType = '16' then
  
    --过去诊断病种
    select * from Diagnosis;
  
  elsif v_FrmType = '21' then
  
    --获取字典表信息
    select CategoryID, cast(ID as varchar(4)) as DetailID, Name, Py, Wb
      from CategoryDetail
     where CategoryID = v_CategoryID;
  
  elsif v_FrmType = '22' then
  
    --获取家族史
    select cd.Name RelationExplain,
           datediff('yy', fh.Birthday, to_char(sysdate)) + 1 Age,
           d.Name DiseaseName,
           (case
             when Breathing = 1 then
              '是'
             else
              '否'
           end) IsBreathing,
           fh.*
      from FamilyHistory fh
      left join CategoryDetail cd on cd.ID = fh.Relation
                                 and cd.CategoryID = '62'
      left join Diagnosis d on d.ICD = fh.DiseaseID
     where NoOfInpat = v_NoOfInpat;
  
  elsif v_FrmType = '23' then
  
    --获取个人史
    select * from PersonalHistory;
  
  elsif v_FrmType = '24' then
  
    --获取过敏史
    select ah.*, cd1.Name as AllergyName, cd2.Name as AllergyLevelName
      from AllergyHistory ah
      left join CategoryDetail cd1 on cd1.ID = ah.AllergyID
                                  and cd1.CategoryID = '60'
      left join CategoryDetail cd2 on cd2.ID = ah.AllergyLevel
                                  and cd2.CategoryID = '61'
     where NoOfInpat = v_NoOfInpat;
  
  elsif v_FrmType = '25' then
  
    --获取手术名称
    select * from Surgery;
  
  elsif v_FrmType = '26' then
  
    --获取手术史
    select sh.*, s.Name as SurgeryName, d.Name as DiagnosisName
      from SurgeryHistory sh
      left join Surgery s on s.ID = sh.SurgeryID
      left join Diagnosis d on d.ICD = sh.DiagnosisID
     where NoOfInpat = v_NoOfInpat;
  
  elsif v_FrmType = '27' then
  
    --获取疾病史
    select ih.*,
           d.Name as DiagnosisName,
           (case
             when Cure = 1 then
              '是'
             else
              '否'
           end) IsCure
      from IllnessHistory ih
      left join Diagnosis d on d.ICD = ih.DiagnosisICD
     where NoOfInpat = v_NoOfInpat;
  end if;

end;
/

prompt
prompt Creating procedure USP_SAVEAPPLYRECORD
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_SaveApplyRecord(v_NoOfInpat   numeric, --首页序号(住院流水号)
                                                v_ApplyDoctor varchar, --申请医生代码
                                                v_DeptID      varchar, --科室代码
                                                v_ApplyAim    varchar, --申请目的
                                                v_DueTime     numeric, --申请期限
                                                v_Unit        varchar --期限单位
                                                --v_ApplyDate           varchar(24),  --申请日期
                                                --v_Status              varchar(6)        --状态
                                                ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  保存申请借阅电子病历信息
   功能说明
   输入参数
   输出参数
   结果集、排序
  
  
   调用的sp
   调用实例
   exec
   修改记录
  **********/

begin

  insert into ApplyRecord
    (NoOfInpat,
     ApplyDoctor,
     DeptID,
     ApplyAim,
     DueTime,
     Unit,
     ApplyDate,
     Status)
  values
    (v_NoOfInpat,
     v_ApplyDoctor,
     v_DeptID,
     v_ApplyAim,
     v_DueTime,
     v_Unit,
     to_char(sysdate, 'yyyy-mm-dd HH24:mi:ss'),
     '5201');

end;
/

prompt
prompt Creating procedure USP_SELECTALLJOBS
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_SelectAllJobs AS /**********
 版本号
 创建时间
 作者
 版权
 描述
 功能说明      输出所有岗位信息
 输出参数
 结果集、排序
 调用的sp
 调用实例
**********/

BEGIN
  SELECT * FROM Jobs;
END;
/

prompt
prompt Creating procedure USP_SELECTALLUSERS
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_SelectAllUsers AS /**********
 版本号
 创建时间
 作者
 版权
 描述
 功能说明       输出所有员工信息
 输出参数
 结果集、排序
 调用的sp
 调用实例
**********/

BEGIN
  SELECT * FROM Users;
END;
/

prompt
prompt Creating procedure USP_SELECTALLUSERS2
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_SelectAllUsers2 AS /**********
 版本号
 创建时间
 作者
 版权
 描述
 功能说明       输出所有员工信息
 输出参数
 结果集、排序
 调用的sp
 调用实例
**********/
BEGIN
  SELECT a.*, b.Name AS Deptname, c.Name AS WardName
    FROM Users a
    LEFT JOIN Department b ON a.DeptId = b.ID
    LEFT JOIN Ward c ON a.WardID = c.ID;
  --        SELECT  a.* ,
  --                b.Name AS Deptname ,
  --                c.Name AS WardName
  --        FROM    dbo.Department b
  --                LEFT JOIN dbo.Users a ON a.DeptId = b.ID
  --                LEFT JOIN dbo.Ward c ON a.WardID = c.ID
END;
/

prompt
prompt Creating procedure USP_SELECTDEPARTMENT
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_SelectDepartment AS /**********
 版本号
 创建时间
 作者
 版权
 描述
 功能说明       输出所有部门信息
 输出参数
 结果集、排序
 调用的sp
 调用实例
**********/

BEGIN
  SELECT * FROM Department;
END;
/

prompt
prompt Creating procedure USP_SELECTJOB
prompt ================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_SelectJob(v_Id VARCHAR) AS /**********
 版本号
 创建时间
 作者
 版权
 描述
 功能说明      输出某个员工信息
 输出参数
 结果集、排序
 调用的sp
 调用实例
**********/
BEGIN
  Select * from Jobs where Id = v_Id;
end;
/

prompt
prompt Creating procedure USP_SELECTPERMISSION
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_SelectPermission AS /**********
 版本号
 创建时间
 作者
 版权
 描述
 功能说明      输出所有岗位信息
 输出参数
 结果集、排序
 调用的sp
 调用实例
**********/

BEGIN
  SELECT * FROM Job2Permission;
end;
/

prompt
prompt Creating procedure USP_SELECTWARD
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_SelectWard AS /**********
 版本号
 创建时间
 作者
 版权
 描述
 功能说明       输出所有部门信息
 输出参数
 结果集、排序
 调用的sp
 调用实例
**********/

BEGIN
  SELECT * FROM Ward;
END;
/

prompt
prompt Creating procedure USP_SETORDERGROUPSERIALNO
prompt ============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_SetOrderGroupSerialNo
(
  v_NoOfInpat numeric 
 ,v_AdviceCategory int
 ,v_onlynew int default 1
 )
as
/**********
 版本号  1.0.0.0.0
 创建时间
 作者
 版权
 描述  设置医嘱的分组序号
 功能说明
 根据医嘱的分组标志重新设置指定病人的新长期或临时医嘱的分组序号。
 一般在医嘱保存后调用此存储过程进行统一设置（用来代替以前的医嘱表触发器）。
 输入参数
  v_NoOfInpat numeric(9,0) -- EMR首页序号
 ,v_AdviceCategory int -- 医嘱类别 0: 临时; 1: 长期; 2: 全部
 ,v_onlynew int = 1 -- 只处理新医嘱 1: 是; 0: 否
 输出参数
 结果集、排序
 成功 -- T
 失败 -- F, 失败原因
 调用的sp
 调用实例
  exec usp_SetOrderGroupSerialNo  5 , 1 ,1
**********/
 begin

create table #newsortid(
 Flag int not null, -- 长期临时标志, 0: 临时; 1: 长期
 OrderID numeric(12,0)  not null, -- 医嘱序号
 GroupID numeric(12,0) not null, -- 分组序号
 GroupFlag int not null, -- 分组标志
 OrderType int not null, -- 医嘱类别
 Memo varchar(64) null , -- 备注
 constraint pk_newsortid primary key (OrderID, Flag)
 )

if ((v_AdviceCategory = 0) or (v_AdviceCategory = 2))
 insert into #newsortid(Flag, OrderID, GroupID, GroupFlag, OrderType, Memo)
 select 0, TempID, GroupID, GroupFlag, OrderType, Memo
  from Temp_Order (nolock)
  where NoOfInpat = v_NoOfInpat
    and ((v_onlynew = 0) or ((v_onlynew = 1) and (OrderStatus = 3200)))
  order by TempID

if ((v_AdviceCategory = 1) or (v_AdviceCategory = 2))
 insert into #newsortid(Flag, OrderID, GroupID, GroupFlag, OrderType, Memo)
 select 1, LongID, GroupID, GroupFlag, OrderType, Memo
  from Long_Order (nolock)
  where NoOfInpat = v_NoOfInpat
    and ((v_onlynew = 0) or ((v_onlynew = 1) and (OrderStatus = 3200)))
  order by LongID

declare v_Flag int
 , v_OrderID numeric(12,0)
 , v_GroupID numeric(12,0)
 , v_GroupFlag numeric(12,0)
 , v_OrderType int
 , v_Memo varchar(64)
 , v_cyhzbz varchar(16) -- 草药汇总信息标志


select v_cyhzbz = '草药汇总'

declare cr_sortid cursor for
 select Flag, OrderID, GroupFlag,OrderType,Memo from #newsortid order by Flag, OrderID
 for update of GroupID

open cr_sortid
fetch cr_sortid into v_Flag, v_OrderID, v_GroupFlag, v_OrderType, v_Memo
while v_v_fetch_status = 0
begin
 -- 以下处理分组序号的过程中是按照正常顺序进行处理，未考虑传入的数据分组有错误的情况！！！
 if (v_OrderID <= 3501) -- 组开始或单条或未分组,分组序号与医嘱序号一致
 begin
  if ((v_OrderType = 3110) and (charindex(v_cyhzbz, v_Memo) > 0))
   update #newsortid set Memo = v_cyhzbz + convert(varchar, v_GroupID) where current of cr_sortid -- 草药汇总的memo中要保存草药明细的分组序号
  select v_GroupID = v_OrderID
 end

 update #newsortid set GroupID = v_GroupID where current of cr_sortid

 fetch cr_sortid into v_Flag, v_OrderID, v_GroupFlag, v_OrderType, v_Memo
end

deallocate cr_sortid

update Temp_Order set GroupID = b.GroupID
 from Temp_Order a, #newsortid b
 where a.TempID = b.OrderID
   and b.Flag = 0

update Long_Order  set GroupID = b.GroupID
 from Long_Order   a, #newsortid b
 where a.LongID = b.OrderID
   and b.Flag = 1
 end;
/

prompt
prompt Creating procedure USP_SYMBOLMANAGER
prompt ====================================
prompt
create or replace procedure emr.usp_SymbolManager(v_type               varchar,
                                              v_SymbolCategroyID   int default 0, --特殊字符类型名称
                                              v_SymbolCategoryName varchar default '', --特殊字符类型名称
                                              v_SymbolCategoryMemo varchar default '' --特殊字符类型备注
                                              
                                              --  v_SymbolRTF  varchar default '',--特殊字符类型ID(Inpatient.NoOfInpat)
                                              --  v_SymbolCategroyID int  default 0,  --特殊字符编码
                                              --  v_SymbolLength int  default  0,       --特殊字符长度
                                              --  v_SymbolMemo varchar default  '' --特殊字符备注
                                              ) as

  /**********
  [版本号] 1.0.0.0.0
  [创建时间]
  [作者]
  [版权]
  [描述] 特殊字符处理模块中负责插入、获取编号？
  [功能说明]
  [输入参数]
  [输出参数]
  [结果集、排序]
  [调用的sp]
  [调用实例]
  
  [修改记录]
  **********/

begin

  if v_type = 'InsertSymCategory' then
  
    --新增特殊字符类型
    INSERT INTO SymbolCategory
      (ID, Name, Memo)
    VALUES
      (seq_symbolcategory_id.nextval,
       v_SymbolCategoryName /* Name  */,
       v_SymbolCategoryMemo /* Memo  */);
  
  --查询特殊字符类型新的编号
  elsif v_type = 'SelectSymCategoryID' then
  
    SELECT nvl((SELECT max(a.ID) + 1 FROM SymbolCategory a), 1)
      from dual;
  --根据特殊字符类型编号查询出特殊字符编号
  elsif v_type = 'SelectSymbolID' then
  
    SELECT nvl((SELECT max(a.ID) + 1
                    FROM Symbols a
                   WHERE a.CategroyID = v_SymbolCategroyID),
                  v_SymbolCategroyID * 1000 + 0)
      from dual;
  end if;

end;
/

prompt
prompt Creating procedure USP_UPDATABASEPATIENTINFO
prompt ============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_UpDataBasePatientInfo(v_NoOfInpat     numeric, --首页序号(住院流水号)
                                                      v_Birth         varchar, --出生日期
                                                      v_Marital       varchar, --婚姻状况
                                                      v_NationID      varchar, --民族代码
                                                      v_NationalityID varchar, --国籍代码
                                                      v_SexID         varchar, --病人性别
                                                      v_EDU           varchar, --文化程度
                                                      v_ProvinceID    varchar, --(出生地)省市代码
                                                      v_CountyID      varchar, --(出生地)区县代码
                                                      v_Nativeplace_P varchar, --籍贯省市代码
                                                      v_Nativeplace_C varchar, --籍贯区县代码
                                                      v_PayID         varchar, --病人性质
                                                      v_Age           int, --病人年龄
                                                      v_Religion      varchar, --宗教信仰
                                                      v_EDUC          numeric, --(受)教育年限(单位:年)
                                                      v_IDNO          varchar, --身份证号
                                                      v_JobID         varchar, --职业代码
                                                      v_Organization  varchar, --工作单位(暂缺)
                                                      v_OfficePlace   varchar, --单位地址
                                                      v_OfficePost    varchar, --单位邮编
                                                      v_OfficeTEL     varchar, --单位电话
                                                      v_NativeAddress varchar, --户口地址
                                                      v_NativeTEL     varchar, --户口电话
                                                      v_NativePost    varchar, --户口邮编
                                                      v_Address       varchar --当前地址
                                                      ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  更新病人基本信息
   功能说明
   输入参数
   输出参数
   结果集、排序
  
  
   调用的sp
   调用实例
  
   修改记录
  **********/

begin

  --修改
  update InPatient
     set Birth         = v_Birth,
         Marital       = v_Marital,
         NationID      = v_NationID,
         NationalityID = v_NationalityID,
         SexID         = v_SexID,
         EDU           = v_EDU,
         ProvinceID    = v_ProvinceID,
         CountyID      = v_CountyID,
         Nativeplace_P = v_Nativeplace_P,
         Nativeplace_C = v_Nativeplace_C,
         PayID         = v_PayID,
         Age           = v_Age,
         Religion      = v_Religion,
         EDUC          = v_EDUC,
         IDNO          = v_IDNO,
         JobID         = v_JobID,
         Organization  = v_Organization,
         OfficePlace   = v_OfficePlace,
         OfficePost    = v_OfficePost,
         OfficeTEL     = v_OfficeTEL,
         NativeAddress = v_NativeAddress,
         NativeTEL     = v_NativeTEL,
         NativePost    = v_NativePost,
         Address       = v_Address
   where NoOfInpat = v_NoOfInpat;

end;
/

prompt
prompt Creating procedure USP_UPDATADIACRISISINFO
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_UpDataDiacrisisInfo(
                                                    
                                                    v_NoOfInpat      numeric, --首页序号(住院流水号)(Inpatient.NoOfInpat)
                                                    v_AdmitDiagnosis varchar2 --入院诊断
                                                    ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  更新病人就诊信息
   功能说明
   输入参数
   输出参数
   结果集、排序
  
  
   调用的sp
   调用实例
  
   修改记录
  **********/

begin

  --修改
  update InPatient
     set AdmitDiagnosis = v_AdmitDiagnosis
   where NoOfInpat = v_NoOfInpat;

end;
/

prompt
prompt Creating procedure USP_UPDATECONSULTATIONDATA
prompt =============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_UpdateConsultationData
-- Add the parameters for the stored procedure here
  --@NoOfInpat           numeric(9,0)='0',    --首页序号
(v_ConsultApplySn int default 0, --会诊号
 v_TypeID         int default 0, --类型
 v_StateID        int default 0, --状态
 v_RejectReason   varchar default '' --审核意见
 ) AS
BEGIN
  -- SET NOCOUNT ON added to prevent extra result sets from
  -- interfering with SELECT statements.

  if v_TypeID = 1 then
  
    update ConsultApply
       set StateID = v_StateID, RejectReason = v_RejectReason
     where ConsultApplySn = v_ConsultApplySn
       and Valid = '1';
  
  end if;
end;
/

prompt
prompt Creating procedure USP_UPDATEDUEAPPLYRECORD
prompt ===========================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_UpDateDueApplyRecord(v_ApplyDoctor varchar2 --申请医师代码
                                                     ) as

  /**********
   版本号  1.0.0.0.0
   创建时间
   作者
   版权
   描述  更新到期的借阅病历
   功能说明
   输入参数
   输出参数
   结果集、排序
  
  
  
   调用的sp
   调用实例
    exec usp_UpDateDueApplyRecord ''
   修改记录
  **********/
  v_CurrDateTime varchar2(20);
begin

  v_CurrDateTime := to_char(sysdate, 'yyyy-mm-dd HH24:mi:ss');

  update ApplyRecord
     set Status = '5205'
   where (ApplyDoctor = v_ApplyDoctor or v_ApplyDoctor = '')
     and Status = '5202'
     and ((Unit = '5101' and
         datediff('mi', AuditDate, v_CurrDateTime) >= DueTime * 60) --小时
         or (Unit = '5102' and
         datediff('hh', AuditDate, v_CurrDateTime) >= DueTime * 24) --天
         or (Unit = '5103' and
         datediff('dd', AuditDate, v_CurrDateTime) / 7 >= DueTime) --周
         or (Unit = '5104' and
         datediff('dd', AuditDate, v_CurrDateTime) >= DueTime * 30) --月
         or (Unit = '5105' and
         datediff('dd', AuditDate, v_CurrDateTime) >= DueTime * 360) --年
         );

end;
/

prompt
prompt Creating procedure USP_UPDATEJOBINFO
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_UpdateJobInfo(v_Id    varchar2,
                                              v_Title varchar2,
                                              v_Memo  varchar2) AS /**********
 版本号
 创建时间
 作者
 版权
 描述
 功能说明      修改岗位信息
 输出参数
 结果集、排序
 调用的sp
 调用实例
**********/
BEGIN
  UPDATE Jobs SET Title = v_Title, Memo = v_Memo WHERE Id = v_Id;
end;
/

prompt
prompt Creating procedure USP_UPDATENURSRECORDTABLE
prompt ============================================
prompt
create or replace procedure emr.usp_UpdateNursRecordTable
   (
    v_ID          numeric,    --记录ID
    v_NoOfInpat    numeric,    --首页序号(住院流水号)
    v_Content      clob    --表单内容
  )
as

/**********
[版本号] 1.0.0.0.0
[创建时间]2011-06-10
[作者]hjh
[版权]
[描述]更新病人护理文档
[功能说明]
[输入参数]
[输出参数]
[结果集、排序]


[调用的sp]
[调用实例]

[修改记录]
**********/

begin
     --更新病人护理文档信息
    update NursRecordTable
    Set
    Content=v_Content
  where    Valid=1
     and ID=v_ID
     and NoOfInpat=v_NoOfInpat;

end ;
/

prompt
prompt Creating procedure USP_UPDATENURSTABLETEMPLATE
prompt ==============================================
prompt
create or replace procedure emr.usp_UpdateNursTableTemplate(v_ID       numeric, --模板代码
                                                        v_Name     varchar, --模板名称
                                                        v_Describe varchar, --模板描述
                                                        v_Content  clob, --模板内容
                                                        v_version  varchar, --模板版本(自定义输入,默认为1.00.00,可以自增长最后1位)
                                                        v_SortID   varchar --模板分类代码
                                                        ) as

  /**********
  [版本号] 1.0.0.0.0
  [创建时间]2011-06-10
  [作者]hjh
  [版权]
  [描述]更新护理文档模板
  [功能说明]
  [输入参数]
  [输出参数]
  [结果集、排序]
  
  
  [调用的sp]
  [调用实例]
  
  [修改记录]
  **********/

begin

  --更新模板
  update Template_Table
     set Name     = v_Name,
         Describe = v_Describe,
         Content  = v_Content,
         version  = v_version,
         SortID   = v_SortID
   where ID = v_ID;

end;
/

prompt
prompt Creating procedure USP_UPDATEUSERINFO
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_UpdateUserInfo(v_ID     VARCHAR2,
                                               v_Name   VARCHAR2,
                                               v_DeptId VARCHAR2,
                                               v_WardID VARCHAR2,
                                               v_JobID  VARCHAR2) AS /**********
 版本号
 创建时间
 作者
 版权
 描述
 功能说明      输出更新某个员工信息
 输出参数
 结果集、排序
 调用的sp
 调用实例
**********/
BEGIN
  UPDATE Users
     SET Name   = v_Name,
         DeptId = v_DeptId,
         WardID = v_WardID,
         JobID  = v_JobID
   WHERE ID = v_ID;
END;
/

prompt
prompt Creating procedure USP_UPDATE_IEM_MAINPAGE_BASIC
prompt ================================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_Update_Iem_Mainpage_Basic(v_Iem_Mainpage_NO          numeric,
                                                          v_PatNoOfHis               numeric,
                                                          v_NoOfInpat                numeric,
                                                          v_PayID                    varchar,
                                                          v_SocialCare               varchar,
                                                          v_InCount                  int,
                                                          v_Name                     varchar,
                                                          v_SexID                    varchar,
                                                          v_Birth                    char,
                                                          v_Marital                  varchar,
                                                          v_JobID                    varchar,
                                                          v_ProvinceID               varchar,
                                                          v_CountyID                 varchar,
                                                          v_NationID                 varchar,
                                                          v_NationalityID            varchar,
                                                          v_IDNO                     varchar,
                                                          v_Organization             varchar,
                                                          v_OfficePlace              varchar,
                                                          v_OfficeTEL                varchar,
                                                          v_OfficePost               varchar,
                                                          v_NativeAddress            varchar,
                                                          v_NativeTEL                varchar,
                                                          v_NativePost               varchar,
                                                          v_ContactPerson            varchar,
                                                          v_Relationship             varchar,
                                                          v_ContactAddress           varchar,
                                                          v_ContactTEL               varchar,
                                                          v_AdmitDate                varchar,
                                                          v_AdmitDept                varchar,
                                                          v_AdmitWard                varchar,
                                                          v_Days_Before              numeric,
                                                          v_Trans_Date               varchar,
                                                          v_Trans_AdmitDept          varchar,
                                                          v_Trans_AdmitWard          varchar,
                                                          v_Trans_AdmitDept_Again    varchar,
                                                          v_OutWardDate              varchar,
                                                          v_OutHosDept               varchar,
                                                          v_OutHosWard               varchar,
                                                          v_Actual_Days              numeric,
                                                          v_Death_Time               varchar,
                                                          v_Death_Reason             varchar,
                                                          v_AdmitInfo                varchar,
                                                          v_In_Check_Date            varchar,
                                                          v_Pathology_Diagnosis_Name varchar,
                                                          v_Pathology_Observation_Sn varchar,
                                                          v_Ashes_Diagnosis_Name     varchar,
                                                          v_Ashes_Anatomise_Sn       varchar,
                                                          v_Allergic_Drug            varchar,
                                                          v_Hbsag                    numeric,
                                                          v_Hcv_Ab                   numeric,
                                                          v_Hiv_Ab                   numeric,
                                                          v_Opd_Ipd_Id               numeric,
                                                          v_In_Out_Inpatinet_Id      numeric,
                                                          v_Before_After_Or_Id       numeric,
                                                          v_Clinical_Pathology_Id    numeric,
                                                          v_Pacs_Pathology_Id        numeric,
                                                          v_Save_Times               numeric,
                                                          v_Success_Times            numeric,
                                                          v_Section_Director         varchar,
                                                          v_Director                 varchar,
                                                          v_Vs_Employee_Code         varchar,
                                                          v_Resident_Employee_Code   varchar,
                                                          v_Refresh_Employee_Code    varchar,
                                                          v_Master_Interne           varchar,
                                                          v_Interne                  varchar,
                                                          v_Coding_User              varchar,
                                                          v_Medical_Quality_Id       numeric,
                                                          v_Quality_Control_Doctor   varchar,
                                                          v_Quality_Control_Nurse    varchar,
                                                          v_Quality_Control_Date     varchar,
                                                          v_Xay_Sn                   varchar,
                                                          v_Ct_Sn                    varchar,
                                                          v_Mri_Sn                   varchar,
                                                          v_Dsa_Sn                   varchar,
                                                          v_Is_First_Case            numeric,
                                                          v_Is_Following             numeric,
                                                          v_Following_Ending_Date    varchar,
                                                          v_Is_Teaching_Case         numeric,
                                                          v_Blood_Type_id            numeric,
                                                          v_Rh                       numeric,
                                                          v_Blood_Reaction_Id        numeric,
                                                          v_Blood_Rbc                numeric,
                                                          v_Blood_Plt                numeric,
                                                          v_Blood_Plasma             numeric,
                                                          v_Blood_Wb                 numeric,
                                                          v_Blood_Others             varchar,
                                                          v_Is_Completed             varchar,
                                                          v_completed_time           varchar,
                                                          --v_Valide numeric ,
                                                          v_Modified_User varchar) as /**********
 版本号  1.0.0.0.0
 创建时间
 作者
 版权
 描述  更新功病案首页基本信息TABLE
 功能说明
 输入参数
 输出参数
 结果集、排序

 调用的sp
 调用实例

 修改记录
**********/
begin
  update Iem_Mainpage_Basicinfo
     set PatNoOfHis               = v_PatNoOfHis, -- numeric
         NoOfInpat                = v_NoOfInpat, -- numeric
         PayID                    = v_PayID, -- varchar(4)
         SocialCare               = v_SocialCare, -- varchar(32)
         InCount                  = v_InCount, -- int
         Name                     = v_Name, -- varchar(60)
         SexID                    = v_SexID, -- varchar(4)
         Birth                    = v_Birth, -- char(10)
         Marital                  = v_Marital, -- varchar(4)
         JobID                    = v_JobID, -- varchar(4)
         ProvinceID               = v_ProvinceID, -- varchar(10)
         CountyID                 = v_CountyID, -- varchar(10)
         NationID                 = v_NationID, -- varchar(4)
         NationalityID            = v_NationalityID, -- varchar(4)
         IDNO                     = v_IDNO, -- varchar(18)
         Organization             = v_Organization, -- varchar(64)
         OfficePlace              = v_OfficePlace, -- varchar(64)
         OfficeTEL                = v_OfficeTEL, -- varchar(16)
         OfficePost               = v_OfficePost, -- varchar(16)
         NativeAddress            = v_NativeAddress, -- varchar(64)
         NativeTEL                = v_NativeTEL, -- varchar(16)
         NativePost               = v_NativePost, -- varchar(16)
         ContactPerson            = v_ContactPerson, -- varchar(32)
         Relationship             = v_Relationship, -- varchar(4)
         ContactAddress           = v_ContactAddress, -- varchar(255)
         ContactTEL               = v_ContactTEL, -- varchar(16)
         AdmitDate                = v_AdmitDate, -- varchar(19)
         AdmitDept                = v_AdmitDept, -- varchar(12)
         AdmitWard                = v_AdmitWard, -- varchar(12)
         Days_Before              = v_Days_Before, -- numeric
         Trans_Date               = v_Trans_Date, -- varchar(19)
         Trans_AdmitDept          = v_Trans_AdmitDept, -- varchar(12)
         Trans_AdmitWard          = v_Trans_AdmitWard, -- varchar(12)
         Trans_AdmitDept_Again    = v_Trans_AdmitDept_Again, -- varchar(12)
         OutWardDate              = v_OutWardDate, -- varchar(19)
         OutHosDept               = v_OutHosDept, -- varchar(12)
         OutHosWard               = v_OutHosWard, -- varchar(12)
         Actual_Days              = v_Actual_Days, -- numeric
         Death_Time               = v_Death_Time, -- varchar(19)
         Death_Reason             = v_Death_Reason, -- varchar(300)
         AdmitInfo                = v_AdmitInfo, -- varchar(4)
         In_Check_Date            = v_In_Check_Date, -- varchar(19)
         Pathology_Diagnosis_Name = v_Pathology_Diagnosis_Name, -- varchar(300)
         Pathology_Observation_Sn = v_Pathology_Observation_Sn, -- varchar(60)
         Ashes_Diagnosis_Name     = v_Ashes_Diagnosis_Name, -- varchar(300)
         Ashes_Anatomise_Sn       = v_Ashes_Anatomise_Sn, -- varchar(60)
         Allergic_Drug            = v_Allergic_Drug, -- varchar(300)
         Hbsag                    = v_Hbsag, -- numeric
         Hcv_Ab                   = v_Hcv_Ab, -- numeric
         Hiv_Ab                   = v_Hiv_Ab, -- numeric
         Opd_Ipd_Id               = v_Opd_Ipd_Id, -- numeric
         In_Out_Inpatinet_Id      = v_In_Out_Inpatinet_Id, -- numeric
         Before_After_Or_Id       = v_Before_After_Or_Id, -- numeric
         Clinical_Pathology_Id    = v_Clinical_Pathology_Id, -- numeric
         Pacs_Pathology_Id        = v_Pacs_Pathology_Id, -- numeric
         Save_Times               = v_Save_Times, -- numeric
         Success_Times            = v_Success_Times, -- numeric
         Section_Director         = v_Section_Director, -- varchar(20)
         Director                 = v_Director, -- varchar(20)
         Vs_Employee_Code         = v_Vs_Employee_Code, -- varchar(20)
         Resident_Employee_Code   = v_Resident_Employee_Code, -- varchar(20)
         Refresh_Employee_Code    = v_Refresh_Employee_Code, -- varchar(20)
         Master_Interne           = v_Master_Interne, -- varchar(20)
         Interne                  = v_Interne, -- varchar(20)
         Coding_User              = v_Coding_User, -- varchar(20)
         Medical_Quality_Id       = v_Medical_Quality_Id, -- numeric
         Quality_Control_Doctor   = v_Quality_Control_Doctor, -- varchar(20)
         Quality_Control_Nurse    = v_Quality_Control_Nurse, -- varchar(20)
         Quality_Control_Date     = v_Quality_Control_Date, -- varchar(19)
         Xay_Sn                   = v_Xay_Sn, -- varchar(300)
         Ct_Sn                    = v_Ct_Sn, -- varchar(300)
         Mri_Sn                   = v_Mri_Sn, -- varchar(300)
         Dsa_Sn                   = v_Dsa_Sn, -- varchar(300)
         Is_First_Case            = v_Is_First_Case, -- numeric
         Is_Following             = v_Is_Following, -- numeric
         Following_Ending_Date    = v_Following_Ending_Date, -- varchar(19)
         Is_Teaching_Case         = v_Is_Teaching_Case, -- numeric
         Blood_Type_id            = v_Blood_Type_id, -- numeric
         Rh                       = v_Rh, -- numeric
         Blood_Reaction_Id        = v_Blood_Reaction_Id, -- numeric
         Blood_Rbc                = v_Blood_Rbc, -- numeric
         Blood_Plt                = v_Blood_Plt, -- numeric
         Blood_Plasma             = v_Blood_Plasma, -- numeric
         Blood_Wb                 = v_Blood_Wb, -- numeric
         Blood_Others             = v_Blood_Others, -- varchar(60)
         Is_Completed             = v_Is_Completed, -- varchar(1)
         completed_time           = v_completed_time, -- varchar(19)
         --Valide = v_Valide ,-- numeric
         --Create_User = v_Create_User ,-- varchar(10)
         --Create_Time = v_Create_Time ,-- varchar(19)
         Modified_User = v_Modified_User, -- varchar(10)
         Modified_Time = to_char(sysdate, 'yyyy-mm-dd HH24:mi:ss') -- varchar(19)
   where Iem_Mainpage_NO = v_Iem_Mainpage_NO
     and Valide = 1;
end;
/

prompt
prompt Creating procedure USP_UPDATE_IEM_MAINPAGE_DIAG
prompt ===============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_Update_Iem_Mainpage_Diag(v_Iem_Mainpage_NO numeric,
                                                         --v_Diagnosis_Type_Id numeric ,
                                                         --v_Diagnosis_Code varchar(60) ,
                                                         --v_Diagnosis_Name varchar(300) ,
                                                         --v_Status_Id numeric ,
                                                         --v_Order_Value numeric ,
                                                         --v_Valide numeric ,
                                                         --v_Create_User varchar(10),
                                                         --v_Create_Time varchar(19) ,
                                                         v_Cancel_User varchar2
                                                         --v_Cancel_Time varchar(19)
                                                         ) as /**********
 版本号  1.0.0.0.0
 创建时间
 作者
 版权
 描述  更新病案首页诊断TABLE,在插入之前调用
 功能说明
 输入参数
 输出参数
 结果集、排序

 调用的sp
 调用实例

 修改记录
**********/
begin
  update Iem_Mainpage_Diagnosis
     set --        Iem_Mainpage_NO  = v_Iem_Mainpage_NO,
         --          Diagnosis_Type_Id = v_Diagnosis_Type_Id,
         --          Diagnosis_Code = v_Diagnosis_Code,
         --          Diagnosis_Name = v_Diagnosis_Name,
         --          Status_Id = Status_Id,
         --          Order_Value = v_Order_Value,
           Cancel_User = v_Cancel_User,
         Valide      = 0,
         Cancel_Time = to_char(sysdate, 'yyyy-mm-dd HH24:mi:ss')
   where Iem_Mainpage_NO = v_Iem_Mainpage_NO
     and Valide = 1;
end;
/

prompt
prompt Creating procedure USP_UPDATE_IEM_MAINPAGE_OPER
prompt ===============================================
prompt
CREATE OR REPLACE PROCEDURE EMR.usp_Update_Iem_MainPage_Oper(v_IEM_MainPage_NO numeric,
                                                         v_Cancel_User     varchar) as /**********
 版本号  1.0.0.0.0
 创建时间
 作者
 版权
 描述  更新功病案首页手术TABLE
 功能说明
 输入参数
 输出参数
 结果集、排序

 调用的sp
 调用实例

 修改记录
**********/
begin
  update Iem_MainPage_Operation
     set Valide      = 0,
         Cancel_User = v_Cancel_User,
         Cancel_Time = to_char(sysdate, 'yyyy-mm-dd HH24:mi:ss')
   where IEM_MainPage_NO = v_IEM_MainPage_NO
     and Valide = 1;
end;
/


spool off

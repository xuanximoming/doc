-----------------------------------------------------
-- Export file for user EMR@ORCL                   --
-- Created by Administrator on 2018/5/27, 13:46:05 --
-----------------------------------------------------

set define off
spool pack.log

prompt
prompt Creating package EMRBASEINFO
prompt ============================
prompt
create or replace package emr.emrbaseinfo is

  TYPE empcurtype IS REF CURSOR;

  --插入或修改诊断别名表
  PROCEDURE usp_AddOrModDiaOther(v_id    varchar2,
                                 v_ICDID varchar2,
                                 v_NAME  varchar2,
                                 v_PY    varchar2,
                                 v_WB    varchar2,
                                 v_VALID varchar2);

  --插入或修改中医诊断别名表
  PROCEDURE usp_AddOrModDiaChiOther(v_id    varchar2,
                                    v_ICDID varchar2,
                                    v_NAME  varchar2,
                                    v_PY    varchar2,
                                    v_WB    varchar2,
                                    v_VALID varchar2);

  --插入或修改手术别名表
  PROCEDURE usp_AddOrModOperOther(v_id    varchar2,
                                  v_ICDID varchar2,
                                  v_NAME  varchar2,
                                  v_PY    varchar2,
                                  v_WB    varchar2,
                                  v_VALID varchar2);

end EMRBaseInfo;
/

prompt
prompt Creating package EMRPROC
prompt ========================
prompt
CREATE OR REPLACE PACKAGE EMR.emrproc IS
  -- global 变量宣言
  /* 变量名 数据型; */
  -- PROCEDURE，函数宣言
  /* PROCEDURE名字(变量...); */
  /* FUNCTION  名称(参数...) RETURN 数据型; */
  TYPE empcurtyp IS REF CURSOR;

  PROCEDURE USP_EMR_PATRECFILE(v_flag             INTEGER,
                               v_indx             INTEGER,
                               v_NOOFINPAT        INTEGER,
                               v_TEMPLATEID       VARCHAR2,
                               v_FileNAME         VARCHAR2,
                               v_FileCONTENT      clob,
                               v_SORTID           VARCHAR2,
                               v_OWNER            VARCHAR2,
                               v_AUDITOR          VARCHAR2,
                               v_CREATETIME       CHAR,
                               v_AUDITTIME        CHAR,
                               v_VALID            INTEGER,
                               v_HASSUBMIT        INTEGER,
                               v_HASPRINT         INTEGER,
                               v_HASSIGN          INTEGER,
                               v_captiondatetime  varchar2,
                               v_FIRSTDAILYFLAG   varchar2,
                               v_py               varchar2,
                               v_wb               varchar2,
                               v_isyihuangoutong  varchar2,
                               v_isconfigpagesize varchar2,
                               v_DepartCode       varchar2,
                               v_wardCode         varchar2,
                               o_result           OUT empcurtyp);

  /*
  * 描述  审批申请借阅病历
  */
  PROCEDURE usp_AuditApplyRecord(

                                 v_AuditType varchar, --审核类型
                                 v_ManID     varchar, --审核人ID
                                 v_ID        numeric --记录ID
                                 );

  /*
  * 功能说明      删除选定岗位
  */
  PROCEDURE usp_DeleteJob(v_ID VARCHAR);

  /*
  * 功能说明      删除选定岗位
  */

  /*
  * 功能说明      删除选定岗位
  */
  PROCEDURE usp_DeleteJobPermission(v_ID VARCHAR);

  /*
  *  功能说明      删除某个员工信息
  */
  PROCEDURE usp_DeleteUserInfo(v_ID VARCHAR);

  /*
  *  描述  获取病历模板选择助手数据
  */
  PROCEDURE usp_DepTemManager(v_dept varchar, o_result OUT empcurtyp);

  /*
  *  描述  编辑LONG_ORDER模板
  */
  PROCEDURE usp_EditEmrLONG_ORDER(v_EditType         varchar default '', --操作类型
                                  v_LONGID           INTEGER default '',
                                  v_NOOFINPAT        INTEGER default '',
                                  v_GROUPID          INTEGER default '',
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
                                  v_PRODUCTNO        INTEGER default '',
                                  v_NORMNO           INTEGER default '',
                                  v_MEDICINENO       INTEGER default '',
                                  v_DRUGNO           VARCHAR2 default '',
                                  v_DRUGNAME         VARCHAR2 default '',
                                  v_DRUGNORM         VARCHAR2 default '',
                                  v_ITEMTYPE         INTEGER default '',
                                  v_MINUNIT          VARCHAR2 default '',
                                  v_DRUGDOSE         INTEGER default '',
                                  v_DOSEUNIT         VARCHAR2 default '',
                                  v_UNITRATE         INTEGER default '',
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
                                  v_CURGERYID        INTEGER default '',
                                  v_CONTENT          VARCHAR2 default '',
                                  v_SYNCH            INTEGER default '',
                                  v_MEMO             VARCHAR2 default '',
                                  v_DJFL             VARCHAR2 default '',
                                  o_result           OUT empcurtyp);

  /*
  *  描述  编辑TEMP_ORDER临时医嘱表
  */
  PROCEDURE usp_EditEmrTEMP_ORDER(v_EditType         VARCHAR2 default '', --操作类型
                                  v_TEMPID           INTEGER default '',
                                  v_NOOFINPAT        INTEGER default '',
                                  v_GROUPID          INTEGER default '',
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
                                  v_STARTDATE        CHAR default '',
                                  v_PRODUCTNO        INTEGER default '',
                                  v_NORMNO           INTEGER default '',
                                  v_MEDICINENO       INTEGER default '',
                                  v_DRUGNO           VARCHAR2 default '',
                                  v_DRUGNAME         VARCHAR2 default '',
                                  v_DRUGNORM         VARCHAR2 default '',
                                  v_ITEMTYPE         INTEGER default '',
                                  v_MINUNIT          VARCHAR2 default '',
                                  v_DRUGDOSE         INTEGER default '',
                                  v_DOSEUNIT         VARCHAR2 default '',
                                  v_UNITRATE         INTEGER default '',
                                  v_UNITTYPE         INTEGER default '',
                                  v_DRUGUSE          VARCHAR2 default '',
                                  v_BATCHNO          VARCHAR2 default '',
                                  v_EXECUTECOUNT     INTEGER default '',
                                  v_EXECUTECYCLE     INTEGER default '',
                                  v_CYCLEUNIT        INTEGER default '',
                                  v_DATEOFWEEK       CHAR default '',
                                  v_INNEREXECUTETIME VARCHAR2 default '',
                                  v_ZXTS             INTEGER default '',
                                  v_TOTALDOSE        INTEGER default '',
                                  v_ENTRUST          VARCHAR2 default '',
                                  v_ORDERTYPE        INTEGER default '',
                                  v_ORDERSTATUS      INTEGER default '',
                                  v_SPECIALMARK      INTEGER default '',
                                  v_CEASEID          INTEGER default '',
                                  v_CEASEDATE        CHAR default '',
                                  v_CONTENT          VARCHAR2 default '',
                                  v_SYNCH            INTEGER default '',
                                  v_MEMO             VARCHAR2 default '',
                                  v_FORMTYPE         VARCHAR2 default '',
                                  o_result           OUT empcurtyp);
  /*
  *  描述  编辑过敏史信息
  */
  PROCEDURE usp_EditAllergyHistoryInfo(v_EditType     varchar, --编辑信息类型：1：添加、2：修改、3：删除
                                       v_ID           numeric, --唯一列
                                       v_NoOfInpat    numeric default '-1', --病人首页序号
                                       v_AllergyID    Int default -1, --过敏类型
                                       v_AllergyLevel int default -1, --过敏程度
                                       v_Doctor       varchar default '', --代理医生
                                       v_AllergyPart  varchar default '', --过敏部位
                                       v_ReactionType varchar default '', --反应类型
                                       v_Memo         varchar default '' --备注
                                       );

  /*
  *  描述  编辑家族信息
  */
  PROCEDURE usp_EditFamilyHistoryInfo(v_EditType  varchar, --编辑信息类型：1：添加、2：修改、3：删除
                                      v_ID        numeric, --联系人编号，是病人联系人的唯一标识
                                      v_NoOfInpat numeric default '-1', --首页序号(住院流水号)(Inpatient.NoOfInpat)
                                      v_Relation  varchar default '', --家族关系
                                      v_Birthday  varchar default '', --出生日期（在前台显示年龄）
                                      v_DiseaseID varchar default '', --病种代码
                                      v_Breathing int default '', --是否健在(1:是：0否)
                                      v_Cause     varchar default '', --死亡原因
                                      v_Memo      varchar default '' --备注
                                      );

  /*
  *  描述  编辑疾病史信息
  */
  PROCEDURE usp_EditIllnessHistoryInfo(v_EditType     varchar, --编辑信息类型：1：添加、2：修改、3：删除
                                       v_ID           numeric, --唯一列
                                       v_NoOfInpat    numeric default '-1', --病人首页序号
                                       v_DiagnosisICD varchar default '', --病种代码
                                       v_Discuss      varchar default '', --疾病评论
                                       v_DiseaseTime  varchar default '', --病发时间
                                       v_Cure         int default '', --是否治愈
                                       v_Memo         varchar default '' --备注
                                       );

  /*
  *  描述  保存护理信息数据
  */
  PROCEDURE usp_EditNotesOnNursingInfoNew(v_NoOfInpat        numeric, --首页序号(住院流水号)
                                          v_DateOfSurvey     varchar, --测量日期期（格式2010-01-01）
                                          v_Indx             varchar, --序号
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
                                          v_DoctorOfRecord   varchar, --记录医生
                                          v_PhysicalHotting  varchar default '', --物理升温 edit by ywk
                                          v_PainInfo         varchar default '' --疼痛
                                          );
  /*
  *  描述  保存护理信息数据
  */
  PROCEDURE usp_EditNotesOnNursingInfo(v_NoOfInpat        numeric, --首页序号(住院流水号)
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
                                       v_DoctorOfRecord   varchar, --记录医生
                                       v_PhysicalHotting  varchar default '', --物理升温 edit by ywk
                                       v_PainInfo         varchar default '' --疼痛
                                       );
  --护士三测单信息维护中。病人状态信息的维护 add by ywk 2012年4月23日14:05:18

  PROCEDURE usp_Edit_PatStates(v_EditType  varchar default '', --操作类型
                               v_CCode     varchar default '',
                               V_ID        varchar default '',
                               v_NoofInPat varchar default '',
                               v_DoTime    varchar default '',
                               v_Patid     varchar default '',
                               o_result    OUT empcurtyp);

  /*
  * 编辑第一联系人信息
  */
  PROCEDURE usp_EditPatientContacts(v_EditType   varchar, --编辑信息类型：1：添加、2：修改、3：删除
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
                                    );

  /*
  * 编辑个人史信息
  */
  PROCEDURE usp_EditPersonalHistoryInfo(v_NoOfInpat    numeric, --病人首页序号
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
                                        );

  /*
  * 编辑手术史信息
  */
  PROCEDURE usp_EditSurgeryHistoryInfo(v_EditType    varchar, --编辑信息类型：1：添加、2：修改、3：删除
                                       v_ID          numeric, --唯一列
                                       v_NoOfInpat   numeric default '-1', --病人首页序号
                                       v_SurgeryID   varchar default '', --手术代码(Surgery.ID)
                                       v_DiagnosisID varchar default '', --疾病（Diagnosis.ICD）
                                       v_Discuss     varchar default '', --评论
                                       v_Doctor      varchar default '', --手术医生
                                       v_Memo        varchar default '' --备注
                                       );

  /*
  * 描述 .NET模型选择
  */
  PROCEDURE usp_Emr_ModelSearcher(v_flag   int,
                                  v_type   varchar,
                                  o_result OUT empcurtyp);

  /*
  * 描述 根据病人首页序号获取病人信息
  */
  PROCEDURE USP_EMR_GETPATINFO(v_NoOfinpat varchar, o_result OUT empcurtyp);

  /*
  * 描述 查询可用的成套医嘱
  */
  procedure usp_Emr_QueryOrderSuites(v_DeptID   varchar,
                                     v_WardID   varchar,
                                     v_DoctorID varchar,
                                     v_yzlr     int default 1,
                                     o_result   OUT empcurtyp,
                                     o_result1  OUT empcurtyp);

  /*
  * 描述 设置医嘱的分组序号
  */
  procedure usp_Emr_SetOrderGroupSerialNo(v_NoOfInpat numeric,
                                          v_OrderType int,
                                          v_onlynew   int default 1);

  /*
  * 获取申请借阅病历
  */
  PROCEDURE usp_GetApplyRecordNew(v_DateBegin varchar, --开始日期
                                  v_DateEnd   varchar, --结束日期
                                  --v_DateInBegin  varchar, --入院开始日期
                                  --v_DateInEnd    varchar, --入院结束日期
                                  v_PatientName varchar, --病人姓名
                                  v_DocName     VARCHAR, --申请医师姓名
                                  v_OutHosDept  varchar, --出院科室科室
                                  o_result      OUT empcurtyp);
  /*
  * 获取申请借阅病历
  */
  PROCEDURE usp_GetApplyRecord(v_DateBegin  varchar, --开始日期
                               v_DateEnd    varchar, --结束日期
                               v_OutHosDept varchar, --出院科室科室
                               o_result     OUT empcurtyp);

  /*
  * 描述  获取系统当前参数
  */
  PROCEDURE usp_GetCurrSystemParam(v_GetType int, --操作类型
                                   o_result  OUT empcurtyp);

  /*
  * 描述  获取科室病历失分点
  */
  PROCEDURE usp_GetDeptDeductPoint(v_DeptCode      varchar default '',
                                   v_DateTimeBegin varchar,
                                   v_DateTimeEnd   varchar,
                                   v_PointID       varchar default '',
                                   v_QCStatType    int,
                                   o_result        OUT empcurtyp);

  /*
  * 描述  获取医生任务信息内容
  */
  PROCEDURE usp_GetDoctorTaskInfo(v_Wardid  varchar, --病区
                                  v_Deptids varchar, --科室
                                  v_UserID  varchar, --用户ID
                                  v_Time    varchar, --时间
                                  o_result  OUT empcurtyp);

  /*
  * 描述  获取医院信息
  */
  PROCEDURE usp_GetHospitalInfo(o_result OUT empcurtyp);

  /*
  * 描述  获取质量评分
  */
  PROCEDURE usp_GetIemInfo(v_NoOfInpat int,
                           o_result    OUT empcurtyp,
                           o_result1   OUT empcurtyp,
                           o_result2   OUT empcurtyp,
                           o_result3   OUT empcurtyp);

  /*
  * 描述  获取科室质量管理未归档病历
  */
  PROCEDURE usp_GetInpatientFiling(v_DeptCode      varchar default '',
                                   v_InpatName     varchar default '',
                                   v_DateTimeBegin varchar,
                                   v_DateTimeEnd   varchar,
                                   v_QCStatType    int,
                                   o_result        OUT empcurtyp);

  /*
  * 描述  根据传入的时间段以及病人首页序号  查询病人医技报告信息
  */
  PROCEDURE usp_GetInpatientReport(v_NoOfInpat     varchar default '',
                                   v_DateTimeBegin varchar default '',
                                   v_DateTimeEnd   varchar default '',
                                   v_SubmitDocID   varchar default '',
                                   v_ReportID      varchar default '',
                                   v_QCStatType    varchar default '',
                                   o_result        OUT empcurtyp);

  /*
  * 描述    输出所有岗位信息
  */
  PROCEDURE usp_GetJobPermissionInfo(v_JobId  VARCHAR,
                                     o_result out empcurtyp);

  /*
  * 描述    输出所有岗位信息
  */
  PROCEDURE usp_GetKnowledgePublicInfo(v_OrderType numeric, --所属类别
                                       o_result    out empcurtyp);

  /*
  * 描述    取需要在lookupeditor里显示的数据,最好包括ID，Name,Py,Memo，这样可以在APP里调用时用统一的方法
  */
  PROCEDURE usp_GetLookUpEditorData(v_QueryType numeric, --查询的类型
                                    v_QueryID   numeric default 0,
                                    o_result    out empcurtyp);

  /*********************************************************************************/
  PROCEDURE usp_getmedicalrrecordviewnew(v_deptcode        VARCHAR DEFAULT '',
                                         v_datetimebegin   VARCHAR,
                                         v_datetimeend     VARCHAR,
                                         v_datetimeinbegin VARCHAR,
                                         v_datetimeinend   VARCHAR,
                                         v_patientname     VARCHAR DEFAULT '',
                                         v_recordid        VARCHAR DEFAULT '',
                                         v_applydoctor     VARCHAR DEFAULT '',
                                         v_qcstattype      INT,
                                         --Add wwj 用于模糊查询
                                         v_patid   VARCHAR DEFAULT '',
                                         v_indiag  VARCHAR DEFAULT '', --入院诊断
                                         v_outdiag VARCHAR DEFAULT '', --出院诊断
                                         v_curdiag VARCHAR DEFAULT '', --当前诊断
                                         o_result  OUT empcurtyp);

  /*
  * 描述    按科室或科室对应病人的归档或未归档电子病历
  */
  PROCEDURE usp_GetMedicalRrecordView(v_DeptCode      varchar default '',
                                      v_DateTimeBegin varchar,
                                      v_DateTimeEnd   varchar,
                                      v_PatientName   varchar default '',
                                      v_RecordID      varchar default '',
                                      v_ApplyDoctor   varchar default '',
                                      v_QCStatType    int,
                                      --Add wwj 用于模糊查询
                                      v_PatID   varchar default '',
                                      v_outdiag VARCHAR DEFAULT '', --add by cyq 2012-12-07
                                      o_result  out empcurtyp);

  /*
  * 描述    保存申请借阅电子病历信息
  */
  PROCEDURE usp_GetMedicalRrecordViewFrm(v_GetType varchar, --获取数据类型，1：科室、2：申请借阅目的、3：申请期限单位
                                         o_result  out empcurtyp);

  /*
  * 描述    获取护理信息数据
  */
  PROCEDURE usp_GetNotesOnNursingInfo(v_NoOfInpat    numeric, --首页序号(住院流水号)
                                      v_DateOfSurvey varchar, --测量日期期（格式2010-01-01）
                                      o_result       out empcurtyp);

  /*
  * 描述    获取护理信息数据
  */
  PROCEDURE usp_GetNursingRecordByDate(v_NoOfInpat numeric default '0', --首页序号
                                       v_BeginDate varchar, --起始时间
                                       v_EndDate   varchar, --终止时间
                                       o_result    out empcurtyp);

  /*
  * 描述    获取护理文书项目窗体参数
  */
  PROCEDURE usp_GetNursingRecordParam(v_FrmType varchar, --窗体操作类型
                                      o_result  out empcurtyp);

  /*
  * 描述    获取护理文书项目窗体参数
  */
  PROCEDURE usp_GetPatientBedInfoByDate(v_NoOfInpat    numeric default '0', --首页序号
                                        v_AllocateDate varchar, --指定的时间
                                        o_result       out empcurtyp);

  /*
  * 描述    usp_GetPatientInfoForThreeMeas
  */
  PROCEDURE usp_GetPatientInfoForThreeMeas(v_NoOfInpat numeric default '0', --首页序号
                                           o_result    out empcurtyp);

  --根据病种name返回病种ICD
  PROCEDURE usp_getdiagicdbyname(v_name   varchar, --病种名称
                                 o_result OUT empcurtyp);

  --根据病种ICD返回病种名称
  /*********add by wyt 2012-08-15************************************************************************/
  PROCEDURE usp_getdiagnamebyicd(v_icd    varchar, --病种编号
                                 o_result OUT empcurtyp);

  --查询某诊断医师关联病种
  /*************add by wyt 2012-08-15****************************************************************/
  PROCEDURE usp_getdiagbyattendphysician(v_userid varchar, --用户编号
                                         o_result OUT empcurtyp);

  /*
  * 描述    获取病历管理窗体控件初始化数据
  */
  PROCEDURE usp_GetRecordManageFrm(v_FrmType    varchar, --窗体类型，1n：病人信息管理维护窗体、2n：病人病历史信息窗体
                                   v_PatNoOfHis numeric default '0', --首页序号
                                   v_CategoryID varchar default '', --(字典)类别代码 、或父节点代码 、首页序号
                                   o_result     out empcurtyp);

  /*
  *描述 获取诊断医师未归档病历（多条件查询）
  */
  PROCEDURE usp_getattendrecordnoonfile(v_dateOutHosBegin VARCHAR, --出院开始日期
                                        v_dateOutHosEnd   VARCHAR, --出院结束日期
                                        v_dateInHosBegin  VARCHAR, --入院开始日期
                                        v_dateInHosEnd    VARCHAR, --入院截止日期
                                        v_deptid          VARCHAR, --科室代码
                                        v_status          VARCHAR, --病历状态
                                        v_patientname     VARCHAR DEFAULT '', --病人姓名
                                        v_recordid        VARCHAR DEFAULT '', --病历号
                                        v_indiag          VARCHAR DEFAULT '', --入院诊断
                                        v_outdiag         VARCHAR DEFAULT '', --出院诊断
                                        v_curdiag         VARCHAR DEFAULT '', --当前诊断
                                        v_diaGroupStatus  VARCHAR, --诊断分组状态
                                        v_PatientStatus   VARCHAR, --病人状态
                                        v_ingroupid       VARCHAR, --分组ID1
                                        v_outgroupid      VARCHAR, --分组ID2
                                        o_result          OUT empcurtyp);

  /*
  *描述 获取未归档病历（多条件查询）
  */
  PROCEDURE usp_getrecordnoonfileWyt(v_dateOutHosBegin VARCHAR, --出院开始日期
                                     v_dateOutHosEnd   VARCHAR, --出院结束日期
                                     v_dateInHosBegin  VARCHAR, --入院开始日期
                                     v_dateInHosEnd    VARCHAR, --入院截止日期
                                     v_deptid          VARCHAR, --科室代码
                                     v_indiag          VARCHAR, --入院诊断
                                     v_outdiag         VARCHAR, --出院诊断
                                     v_status          VARCHAR, --病历状态
                                     v_patientname     VARCHAR DEFAULT '', --病人姓名
                                     v_patientid       VARCHAR DEFAULT '', --病人ID
                                     v_recordid        VARCHAR DEFAULT '', --病历号
                                     v_physician       VARCHAR DEFAULT '', --住院医师号
                                     o_result          OUT empcurtyp);
  /*
  * 描述    获取未归档病历
  */
  PROCEDURE usp_GetRecordNoOnFile(v_DateBegin   varchar, --开始日期
                                  v_DateEnd     varchar, --结束日期
                                  v_DeptID      varchar, --科室代码
                                  v_Status      varchar, --病历状态
                                  v_PatientName varchar default '', --病人姓名
                                  v_RecordID    varchar default '', --病历号
                                  o_result      out empcurtyp);

  /*
  * 描述    获取未归档病历
  */
  PROCEDURE usp_GetRecordNoOnFileNew(v_DateBegin   varchar, --开始日期
                                     v_DateEnd     varchar, --结束日期
                                     v_DeptID      varchar, --科室代码
                                     v_Status      varchar, --病历状态
                                     v_PatientName varchar default '', --病人姓名
                                     v_RecordID    varchar default '', --病历号
                                     o_result      out empcurtyp);

  /*
  * 描述    获取已归档病历
  */
  PROCEDURE usp_getrecordonfile(v_datebegin  VARCHAR, --开始日期
                                v_dateend    VARCHAR, --结束日期
                                v_patid      VARCHAR DEFAULT '', --住院号码
                                v_name       VARCHAR DEFAULT '', --患者姓名
                                v_sexid      VARCHAR DEFAULT '', --病人性别
                                v_agebegin   VARCHAR DEFAULT '', --开始年龄
                                v_ageend     VARCHAR DEFAULT '', --结束年龄
                                v_outhosdept VARCHAR DEFAULT '', --出院科室科室
                                v_indiag     VARCHAR DEFAULT '', --入院诊断
                                v_outdiag    VARCHAR DEFAULT '', --出院诊断
                                v_surgeryid  VARCHAR DEFAULT '', --手术代码
                                v_physician  VARCHAR DEFAULT '', --住院医师代码
                                o_result     OUT empcurtyp);

  /*
  * 描述    获取待签收归还病历
  */
  PROCEDURE usp_GetSignInRecordNew(v_DateBegin   varchar, --开始日期
                                   v_DateEnd     varchar, --结束日期
                                   v_DateInBegin varchar, --入院开始日期
                                   v_DateInEnd   varchar, --入院结束日期
                                   v_PatientName varchar, --病人姓名
                                   v_OutHosDept  varchar, --出院科室科室
                                   o_result      out empcurtyp);

  /*
  * 描述    获取待签收归还病历
  */
  PROCEDURE usp_GetSignInRecord(v_DateBegin  varchar, --开始日期
                                v_DateEnd    varchar, --结束日期
                                v_OutHosDept varchar, --出院科室科室
                                o_result     out empcurtyp);
  /*
  * 描述    获取质量评分
  */
  PROCEDURE usp_GetTemplatePersonGroup(v_UserID  varchar default '',
                                       o_result  OUT empcurtyp,
                                       o_result1 OUT empcurtyp);

  /*
  * 描述    病人信息表触发过程，
  */
  PROCEDURE usp_Inpatient_Trigger(v_syxh varchar2 --病人首页序号
                                  );

  /*
  * 描述    插入图片信息
  */
  PROCEDURE usp_InsertImage(v_Sort   int,
                            v_Name   varchar,
                            v_Memo   varchar default '',
                            v_ID     numeric default 0,
                            o_result OUT empcurtyp);

  /*
  * 描述    插入岗位信息
  */
  PROCEDURE usp_InsertJob(v_Id VARCHAR, v_Title VARCHAR, v_Memo VARCHAR);

  /*
  * 描述    增加新的授权信息
  */
  PROCEDURE usp_InsertJobPermission(v_ID         VARCHAR,
                                    v_Moduleid   VARCHAR,
                                    v_Modulename VARCHAR);

  /*
  * 描述    添加病人护理文档
  */
  procedure usp_InsertNursRecordTable(v_NoOfInpat  numeric, --首页序号(住院流水号)
                                      v_name       varchar, --记录单名称（模板名称+日期+时间）
                                      v_Content    blob, --数据内容
                                      v_TemplateID numeric, --模板ID
                                      v_version    varchar, --模板版本(自定义输入,默认为1.00.00,可以自增长最后1位)
                                      v_Department varchar, --病人所属科室代码
                                      v_SortID     numeric, --模板分类代码
                                      v_Valid      int --有效记录(CategoryDetail.ID CategoryID = 0)
                                      );

  /*
  * 描述    新增护理文档模板，并返回ID
  */
  procedure usp_InsertNursTableTemplate(v_Name     varchar, --模板名称
                                        v_Describe varchar, --模板描述
                                        v_Content  blob, --模板内容
                                        v_version  varchar, --模板版本(自定义输入,默认为1.00.00,可以自增长最后1位)
                                        v_SortID   varchar, --模板分类代码
                                        v_Valid    int, --有效记录(CategoryDetail.ID CategoryID = 0)
                                        o_result   OUT empcurtyp);
  /*
  * 描述    获取质量评分
  */
  PROCEDURE usp_InsertTemplatePersonGroup(v_UserID             varchar default '',
                                          v_NodeID             int default 0,
                                          v_TemplatePersonID   int default 0,
                                          v_ParentNodeID       int default 0,
                                          v_Name               varchar default '',
                                          v_TypeID             int default 0,
                                          v_TemplatePersonName varchar default '',
                                          v_TemplatePersonMemo varchar default '');

  /*
  * 描述    用户登录相关修改
  */
  PROCEDURE usp_InsertUserLogIn(v_ID          varchar,
                                v_ModuleId    varchar,
                                v_HostName    varchar,
                                v_MACADDR     varchar,
                                v_Client_ip   varchar,
                                v_Reason_id   Varchar,
                                v_Create_user varchar);

  PROCEDURE usp_Insert_Iem_Mainpage_Basic(v_PatNoOfHis               numeric,
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
                                          v_Create_User varchar,
                                          --v_Create_Time varchar(19)
                                          --v_Modified_User varchar(10) ,
                                          --v_Modified_Time varchar(19)
                                          o_result OUT empcurtyp);

  /*
  * 插入功病案首页诊断TABLE
  */
  PROCEDURE usp_Insert_Iem_Mainpage_Diag(v_Iem_Mainpage_NO   numeric,
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
                                         );
  /*
  * 插入功病案首页手术TABLE
  */
  PROCEDURE usp_Insert_Iem_MainPage_Oper(v_IEM_MainPage_NO     numeric,
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
                                         );

  /*********************************************************************************/
  /*输出更新某个病人的当前诊断信息(wyt 2012-08-15)*/
  PROCEDURE usp_updatecurrentdiaginfo(v_patient_id   VARCHAR2,
                                      v_patient_name VARCHAR2,
                                      v_diag_code    VARCHAR2,
                                      v_diag_content varchar2);

  /*输出更新某个主诊医师病种查看权限信息(wyt 2012-08-13)*/
  PROCEDURE usp_updateattendphysicianinfo(v_id            VARCHAR2,
                                          v_name          VARCHAR2,
                                          v_py            VARCHAR2,
                                          v_wb            VARCHAR2,
                                          v_deptid        VARCHAR2,
                                          v_relatedisease varchar2);

  /*输出更新某个员工信息*/
  PROCEDURE usp_updateuserinfo(v_id           VARCHAR2,
                               v_name         VARCHAR2,
                               v_deptid       VARCHAR2,
                               v_wardid       VARCHAR2,
                               v_jobid        VARCHAR2,
                               v_Py           VARCHAR2,
                               v_Wb           VARCHAR2,
                               v_Sexy         VARCHAR2,
                               v_Birth        VARCHAR2,
                               v_Marital      VARCHAR2,
                               v_Idno         VARCHAR2,
                               v_Category     VARCHAR2,
                               v_Jobtitle     VARCHAR2,
                               v_Recipeid     VARCHAR2,
                               v_Recipemark   VARCHAR2,
                               v_Narcosismark VARCHAR2,
                               v_Grade        VARCHAR2,
                               v_Status       VARCHAR2,
                               v_Memo         varchar2);

  /*修改岗位信息*/
  PROCEDURE usp_updatejobinfo(v_id    VARCHAR2,
                              v_title VARCHAR2,
                              v_memo  VARCHAR2);

  /*更新病人护理文档*/
  procedure usp_UpdateNursRecordTable(v_ID        numeric, --记录ID
                                      v_NoOfInpat numeric, --首页序号(住院流水号)
                                      v_Content   blob --表单内容
                                      );

  /*更新护理文档模板*/
  procedure usp_UpdateNursTableTemplate(v_ID       numeric, --模板代码
                                        v_Name     varchar, --模板名称
                                        v_Describe varchar, --模板描述
                                        v_Content  blob, --模板内容
                                        v_version  varchar, --模板版本(自定义输入,默认为1.00.00,可以自增长最后1位)
                                        v_SortID   varchar --模板分类代码
                                        );

  /*更新到期的借阅病历*/
  PROCEDURE usp_updatedueapplyrecord(v_applydoctor VARCHAR2 --申请医师代码
                                     );

  /*更新功病案首页手术TABLE*/
  PROCEDURE usp_update_iem_mainpage_oper(v_iem_mainpage_no NUMERIC,
                                         v_cancel_user     VARCHAR);

  /*更新病案首页诊断TABLE,在插入之前调用*/
  PROCEDURE usp_update_iem_mainpage_diag(v_iem_mainpage_no NUMERIC,
                                         v_cancel_user     VARCHAR2);

  /*更新功病案首页基本信息TABLE*/
  PROCEDURE usp_update_iem_mainpage_basic(v_iem_mainpage_no          NUMERIC,
                                          v_patnoofhis               NUMERIC,
                                          v_noofinpat                NUMERIC,
                                          v_payid                    VARCHAR,
                                          v_socialcare               VARCHAR,
                                          v_incount                  INT,
                                          v_name                     VARCHAR,
                                          v_sexid                    VARCHAR,
                                          v_birth                    CHAR,
                                          v_marital                  VARCHAR,
                                          v_jobid                    VARCHAR,
                                          v_provinceid               VARCHAR,
                                          v_countyid                 VARCHAR,
                                          v_nationid                 VARCHAR,
                                          v_nationalityid            VARCHAR,
                                          v_idno                     VARCHAR,
                                          v_organization             VARCHAR,
                                          v_officeplace              VARCHAR,
                                          v_officetel                VARCHAR,
                                          v_officepost               VARCHAR,
                                          v_nativeaddress            VARCHAR,
                                          v_nativetel                VARCHAR,
                                          v_nativepost               VARCHAR,
                                          v_contactperson            VARCHAR,
                                          v_relationship             VARCHAR,
                                          v_contactaddress           VARCHAR,
                                          v_contacttel               VARCHAR,
                                          v_admitdate                VARCHAR,
                                          v_admitdept                VARCHAR,
                                          v_admitward                VARCHAR,
                                          v_days_before              NUMERIC,
                                          v_trans_date               VARCHAR,
                                          v_trans_admitdept          VARCHAR,
                                          v_trans_admitward          VARCHAR,
                                          v_trans_admitdept_again    VARCHAR,
                                          v_outwarddate              VARCHAR,
                                          v_outhosdept               VARCHAR,
                                          v_outhosward               VARCHAR,
                                          v_actual_days              NUMERIC,
                                          v_death_time               VARCHAR,
                                          v_death_reason             VARCHAR,
                                          v_admitinfo                VARCHAR,
                                          v_in_check_date            VARCHAR,
                                          v_pathology_diagnosis_name VARCHAR,
                                          v_pathology_observation_sn VARCHAR,
                                          v_ashes_diagnosis_name     VARCHAR,
                                          v_ashes_anatomise_sn       VARCHAR,
                                          v_allergic_drug            VARCHAR,
                                          v_hbsag                    NUMERIC,
                                          v_hcv_ab                   NUMERIC,
                                          v_hiv_ab                   NUMERIC,
                                          v_opd_ipd_id               NUMERIC,
                                          v_in_out_inpatinet_id      NUMERIC,
                                          v_before_after_or_id       NUMERIC,
                                          v_clinical_pathology_id    NUMERIC,
                                          v_pacs_pathology_id        NUMERIC,
                                          v_save_times               NUMERIC,
                                          v_success_times            NUMERIC,
                                          v_section_director         VARCHAR,
                                          v_director                 VARCHAR,
                                          v_vs_employee_code         VARCHAR,
                                          v_resident_employee_code   VARCHAR,
                                          v_refresh_employee_code    VARCHAR,
                                          v_master_interne           VARCHAR,
                                          v_interne                  VARCHAR,
                                          v_coding_user              VARCHAR,
                                          v_medical_quality_id       NUMERIC,
                                          v_quality_control_doctor   VARCHAR,
                                          v_quality_control_nurse    VARCHAR,
                                          v_quality_control_date     VARCHAR,
                                          v_xay_sn                   VARCHAR,
                                          v_ct_sn                    VARCHAR,
                                          v_mri_sn                   VARCHAR,
                                          v_dsa_sn                   VARCHAR,
                                          v_is_first_case            NUMERIC,
                                          v_is_following             NUMERIC,
                                          v_following_ending_date    VARCHAR,
                                          v_is_teaching_case         NUMERIC,
                                          v_blood_type_id            NUMERIC,
                                          v_rh                       NUMERIC,
                                          v_blood_reaction_id        NUMERIC,
                                          v_blood_rbc                NUMERIC,
                                          v_blood_plt                NUMERIC,
                                          v_blood_plasma             NUMERIC,
                                          v_blood_wb                 NUMERIC,
                                          v_blood_others             VARCHAR,
                                          v_is_completed             VARCHAR,
                                          v_completed_time           VARCHAR,
                                          v_modified_user            VARCHAR);

  /*更新病人就诊信息*/
  PROCEDURE usp_updatadiacrisisinfo(v_noofinpat      NUMERIC, --首页序号(住院流水号)(Inpatient.NoOfInpat)
                                    v_admitdiagnosis VARCHAR2 --入院诊断
                                    );

  /*更新病人基本信息*/
  PROCEDURE usp_updatabasepatientinfo(v_noofinpat     NUMERIC, --首页序号(住院流水号)
                                      v_birth         VARCHAR, --出生日期
                                      v_marital       VARCHAR, --婚姻状况
                                      v_nationid      VARCHAR, --民族代码
                                      v_nationalityid VARCHAR, --国籍代码
                                      v_sexid         VARCHAR, --病人性别
                                      v_edu           VARCHAR, --文化程度
                                      v_provinceid    VARCHAR, --(出生地)省市代码
                                      v_countyid      VARCHAR, --(出生地)区县代码
                                      v_nativeplace_p VARCHAR, --籍贯省市代码
                                      v_nativeplace_c VARCHAR, --籍贯区县代码
                                      v_payid         VARCHAR, --病人性质
                                      v_age           INT, --病人年龄
                                      v_religion      VARCHAR, --宗教信仰
                                      v_educ          NUMERIC, --(受)教育年限(单位:年)
                                      v_idno          VARCHAR, --身份证号
                                      v_jobid         VARCHAR, --职业代码
                                      v_organization  VARCHAR, --工作单位(暂缺)
                                      v_officeplace   VARCHAR, --单位地址
                                      v_officepost    VARCHAR, --单位邮编
                                      v_officetel     VARCHAR, --单位电话
                                      v_nativeaddress VARCHAR, --户口地址
                                      v_nativetel     VARCHAR, --户口电话
                                      v_nativepost    VARCHAR, --户口邮编
                                      v_address       VARCHAR --当前地址
                                      );

  procedure usp_SymbolManager(v_type               varchar,
                              v_SymbolCategroyID   int default 0, --特殊字符类型名称
                              v_SymbolCategoryName varchar default '', --特殊字符类型名称
                              v_SymbolCategoryMemo varchar default '', --特殊字符类型备注

                              --  v_SymbolRTF  varchar default '',--特殊字符类型ID(Inpatient.NoOfInpat)
                              --  v_SymbolCategroyID int  default 0,  --特殊字符编码
                              --  v_SymbolLength int  default  0,       --特殊字符长度
                              --  v_SymbolMemo varchar default  '' --特殊字符备注
                              o_result OUT empcurtyp);

  /*按部门输出员工信息*/
  PROCEDURE usp_selectusers(v_DeptId   VARCHAR,
                            v_UserName VARCHAR,
                            o_result   OUT empcurtyp);

  /*输出所有员工信息（编号显示其对应名称）*/
  procedure usp_selectuserinfo(o_result out empcurtyp);

  /*输出所有部门信息*/
  PROCEDURE usp_selectward(o_result OUT empcurtyp);

  /*输出所有岗位信息*/
  PROCEDURE usp_selectpermission(o_result OUT empcurtyp);

  /*输出某个员工信息*/
  PROCEDURE usp_selectjob(v_id VARCHAR, o_result OUT empcurtyp);

  /*输出所有部门信息*/
  PROCEDURE usp_selectdepartment(o_result OUT empcurtyp);

  /*输出所有员工信息*/
  PROCEDURE usp_selectallusers2(o_result  OUT empcurtyp,
                                o_result1 OUT empcurtyp);

  /*输出所有员工信息*/
  PROCEDURE usp_selectallusers(o_result OUT empcurtyp);

  /*输出所有岗位信息*/
  PROCEDURE usp_selectalljobs(o_result OUT empcurtyp);

  /*保存申请借阅电子病历信息*/
  PROCEDURE usp_saveapplyrecord(v_noofinpat   NUMERIC, --首页序号(住院流水号)
                                v_applydoctor VARCHAR, --申请医生代码
                                v_deptid      VARCHAR, --科室代码
                                v_applyaim    VARCHAR, --申请目的
                                v_duetime     NUMERIC, --申请期限
                                v_unit        VARCHAR --期限单位
                                );

  /*获取病人信息维护窗体控件初始化数据*/
  PROCEDURE usp_redactpatientinfofrm(v_frmtype VARCHAR,
                                     --窗体类型，1n：病人信息管理维护窗体、2n：病人病历史信息窗体
                                     v_noofinpat  NUMERIC DEFAULT '0', --首页序号
                                     v_categoryid VARCHAR DEFAULT '',
                                     --(字典)类别代码 、或父节点代码 、首页序号
                                     o_result OUT empcurtyp);

  /*获取质量控制统计数据(有查询条件)*/
  PROCEDURE usp_queryqcstatinfo(v_datetimebegin VARCHAR, --开始时间
                                v_datetimeend   VARCHAR, --结束时间
                                o_result        OUT empcurtyp);

  /*获取质量控制统计数据*/
  PROCEDURE usp_queryqcstatdetailinfo(v_datetimebegin VARCHAR, --开始时间
                                      v_datetimeend   VARCHAR, --结束时间
                                      v_qcstattype    INT, --统计资料类型
                                      o_result        OUT empcurtyp);

  /*获取问题登记数据*/
  PROCEDURE usp_queryqcprobleminfo(v_noofinpat INT, o_result OUT empcurtyp);

  /*获取质量控制病患数据*/
  PROCEDURE usp_queryqcpatientinfo(v_datetimefrom VARCHAR,
                                   v_datetimeto   VARCHAR,
                                   v_deptid       VARCHAR,
                                   v_wardid       VARCHAR,
                                   v_bedid        VARCHAR,
                                   v_name         VARCHAR,
                                   v_archives     VARCHAR,
                                   o_result       OUT empcurtyp);

  /*根据首页序号获取病人对应信息*/
  PROCEDURE usp_querypatientinfobynoofinp(v_noofinpat INT,
                                          o_result    OUT empcurtyp);

  /*获取病人提取界面病人列表*/
  PROCEDURE usp_queryownmanagerpat2(v_querytype INT,
                                    v_userid    VARCHAR,
                                    v_deptid    VARCHAR,
                                    v_wardid    VARCHAR,
                                    o_result    OUT empcurtyp);

  /*获取对应病区的床位信息*/
  PROCEDURE usp_querynonarchivepatients(v_wardid  VARCHAR,
                                        v_deptids VARCHAR,
                                        o_result  OUT empcurtyp);

  /*质控TypeScore操作*/
  PROCEDURE usp_qctypescore(v_typename        VARCHAR default '',
                            v_typeinstruction VARCHAR default '',
                            v_typecategory    INT default 0,
                            v_typeorder       INT default 0,
                            v_typememo        VARCHAR default '',
                            v_typestatus      INT,
                            v_typecode        VARCHAR);

  /*获取质量问题数据*/
  PROCEDURE usp_qcoperprobleminfo(v_id             INT,
                                  v_noofinpat      INT,
                                  v_category       INT,
                                  v_status         INT,
                                  v_typecode       VARCHAR,
                                  v_description    VARCHAR,
                                  v_ansewercontent VARCHAR,
                                  v_confirmcontent VARCHAR,
                                  v_problemdate    VARCHAR,
                                  v_registerdate   VARCHAR,
                                  v_registeruser   VARCHAR,
                                  v_answerdate     VARCHAR,
                                  v_answeruser     VARCHAR,
                                  v_confirmdate    VARCHAR,
                                  v_confirmuser    VARCHAR,
                                  v_deldate        VARCHAR,
                                  v_deluser        VARCHAR,
                                  v_operstatus     INT);

  /*获取质量控制统计数据*/
  PROCEDURE usp_qcitemscore(v_itemname           VARCHAR,
                            v_iteminstruction    VARCHAR,
                            v_itemdefaultscore   INT,
                            v_itemstandardscore  INT,
                            v_itemcategory       INT,
                            v_itemdefaulttarget  INT,
                            v_itemtargetstandard INT,
                            v_itemscorestandard  INT,
                            v_itemorder          INT,
                            v_typecode           VARCHAR,
                            v_itemmemo           VARCHAR,
                            v_typestatus         INT,
                            v_itemcode           VARCHAR);

  /*获取病历模板选择助手数据*/
  PROCEDURE usp_msquerytemplate(v_id         VARCHAR,
                                v_user       VARCHAR,
                                v_type       INT,
                                v_department VARCHAR DEFAULT '',
                                o_result     OUT empcurtyp);

  /*
  * 更改用户密码
  */
  PROCEDURE usp_updateuserpassword(v_id      IN users.ID%TYPE,
                                   v_passwd  IN users.passwd%TYPE,
                                   v_regdate IN users.regdate%TYPE);

  /*
  * 得到用户帐户信息
  */
  PROCEDURE usp_getuseraccount(v_id     IN users.ID%TYPE,
                               o_result OUT empcurtyp);

  /*
  * 取职工科室对应设置, 若未指定病区，则通过指定的科室关联出所有的病区
  */
  PROCEDURE usp_getuserdeptandward(v_userid IN users.ID%TYPE,
                                   o_result OUT empcurtyp);

  /*
  *
  */
  PROCEDURE usp_getuseroutdeptandward(o_result OUT empcurtyp);

  /**使用到临时表的存储过程**/

  /*
  *获取职工相关信息
  */
  PROCEDURE usp_GetUserInfo(v_userid  varchar,
                            o_result  OUT empcurtyp,
                            o_result1 OUT empcurtyp);

  /*
  *获取职工相关信息
  */
  procedure usp_NursRecordOperate(v_ID        numeric default 0, --记录ID
                                  v_NoOfInpat numeric default 0, --首页序号(住院流水号)
                                  v_SortID    numeric default 0, --模板分类代码
                                  v_Type      int, --操作类型
                                  o_result    OUT empcurtyp);
  /*
  *医疗质量统计分析
  */
  PROCEDURE usp_MedQCAnalysis(v_DateTimeBegin varchar, --查询开始日期
                              v_DateTimeEnd   varchar, --查询结束日期
                              o_result        OUT empcurtyp);

  /*
  *获取对应病区的床位信息(病区一览时调用）
  */
  PROCEDURE usp_QueryBrowserInwardPatients(v_ID        varchar,
                                           v_QueryType int,
                                           v_wardid    varchar,
                                           v_Deptids   varchar,
                                           v_zyhm      varchar default '',
                                           v_hzxm      varchar default '',
                                           v_cyzd      varchar default '',
                                           v_ryrqbegin varchar default '',
                                           v_ryrqend   varchar default '',
                                           v_cyrqbegin varchar default '',
                                           v_cyrqend   varchar default '',
                                           o_result    OUT empcurtyp);
  /*
  *获取对应病区的床位信息
  */
  PROCEDURE usp_QueryHistoryPatients(v_wardid          varchar,
                                     v_deptids         varchar,
                                     v_PatID           varchar default '',
                                     v_PatName         varchar default '',
                                     v_OutDiagnosis    varchar default '',
                                     v_AdmitDatebegin  varchar default '',
                                     v_AdmitDatend     varchar default '',
                                     v_OutHosDatebegin varchar default '',
                                     v_OutHosDatend    varchar default '',
                                     o_result          OUT empcurtyp,
                                     o_result1         OUT empcurtyp);

  /*
  *获取对应病区的床位信息
  */
  PROCEDURE usp_QueryInwardPatients_old(v_wardid    varchar,
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
                                        v_QueryBed  varchar default 'Y',
                                        o_result    OUT empcurtyp);

  /*
    获取对应病区的床位信息
  bwj 20121108 解决usp_QueryInwardPatients_old中医生工作站中用临时表出资源竞争悲观锁
  通过视图
  */
  PROCEDURE usp_queryinwardpatients(v_wardid    VARCHAR,
                                    v_deptids   VARCHAR,
                                    v_zyhm      VARCHAR DEFAULT '',
                                    v_hzxm      VARCHAR DEFAULT '',
                                    v_cyzd      VARCHAR DEFAULT '',
                                    v_ryrqbegin VARCHAR DEFAULT '',
                                    v_ryrqend   VARCHAR DEFAULT '',
                                    v_cyrqbegin VARCHAR DEFAULT '',
                                    v_cyrqend   VARCHAR DEFAULT '',
                                    --add by xjt
                                    v_id        VARCHAR DEFAULT '',
                                    v_querytype INT DEFAULT 0,
                                    v_querynur  VARCHAR DEFAULT '',
                                    v_querybed  VARCHAR DEFAULT 'Y',
                                    o_result    OUT empcurtyp);

  /*
  xuliangliang2012-12-17从青龙上库导出
  解决青龙山科室病区代码问题 用like语句
  */
  PROCEDURE usp_queryinwardpatientsQLS(v_wardid    VARCHAR,
                                       v_deptids   VARCHAR,
                                       v_zyhm      VARCHAR DEFAULT '',
                                       v_hzxm      VARCHAR DEFAULT '',
                                       v_cyzd      VARCHAR DEFAULT '',
                                       v_ryrqbegin VARCHAR DEFAULT '',
                                       v_ryrqend   VARCHAR DEFAULT '',
                                       v_cyrqbegin VARCHAR DEFAULT '',
                                       v_cyrqend   VARCHAR DEFAULT '',
                                       --add by xjt
                                       v_id        VARCHAR DEFAULT '',
                                       v_querytype INT DEFAULT 0,
                                       v_querynur  VARCHAR DEFAULT '',
                                       v_querybed  VARCHAR DEFAULT 'Y',
                                       o_result    OUT empcurtyp);

  /*
  *获取对应病区的床位信息
  */
  PROCEDURE usp_QueryInwardPatients2(v_wardid    varchar,
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
                                     v_QueryBed  varchar default 'Y',
                                     o_result    OUT empcurtyp);

  /*
  *获取病人提取界面病人列表
  */
  PROCEDURE usp_QueryOwnManagerPat(v_QueryType int,
                                   v_UserID    varchar,
                                   v_DeptID    varchar,
                                   v_WardId    varchar,
                                   o_result    OUT empcurtyp);
  /*
  *获取质量评分
  */
  PROCEDURE usp_QueryQCGrade(v_NoOfInpat int,
                             v_OperUser  varchar,
                             o_result    OUT empcurtyp);

  /*
  *获取对应病区的出院病患
  */
  PROCEDURE usp_QueryQuitPatientNoDoctor(v_wardid    varchar,
                                         v_Deptids   varchar,
                                         v_TimeFrom  varchar,
                                         v_TimeTo    varchar,
                                         v_PatientSN varchar default '', --病历号
                                         v_Name      varchar default '', --病人名称
                                         v_QueryType int default 0,
                                         o_result    OUT empcurtyp);

  /***************************************************************************/

  /*
  *计算病人年龄
  */
  PROCEDURE usp_Emr_CalcAge(v_csrq varchar,
                            v_dqrq varchar,
                            v_sjnl out int,
                            v_xsnl out varchar);
  /*
  *计算病人年龄
  */
  procedure usp_EMR_GetAge(v_csrq varchar,
                           v_dqrq varchar,
                           v_sjnl out int,
                           v_xsnl out varchar);

  --医师工作站得到出院病人
  PROCEDURE usp_queryinwardpatientsout(v_wardid    VARCHAR,
                                       v_deptids   VARCHAR,
                                       v_id        VARCHAR DEFAULT '',
                                       v_querytype INT DEFAULT 0,
                                       o_result    OUT empcurtyp);

  ----医生工作站中获得会诊信息（全部符合条件的）
  PROCEDURE usp_GetMyConsultion(v_Deptids varchar, --部门编号
                                V_userid  varchar, --登录人编号
                                o_result  OUT empcurtyp);

  -----------------------------为病人设定婴儿的存储过程  -add by ywk 2012年6月7日 09:47:34------------------------------
  /*更新功病案首页基本信息TABLE*/
  PROCEDURE usp_editBabyinfo(v_Noofinpat  NUMERIC,
                             v_patnoofhis VARCHAR,
                             v_Noofclinic VARCHAR,
                             v_Noofrecord VARCHAR,
                             v_patid      VARCHAR,
                             v_Innerpix   VARCHAR,
                             v_outpix     VARCHAR,

                             v_Name            VARCHAR,
                             v_py              VARCHAR,
                             v_wb              VARCHAR,
                             v_payid           VARCHAR,
                             v_ORIGIN          VARCHAR,
                             v_InCount         int DEFAULT 0,
                             v_sexid           VARCHAR,
                             v_Birth           VARCHAR,
                             v_Age             int DEFAULT 0,
                             v_AgeStr          VARCHAR,
                             v_IDNO            VARCHAR,
                             v_Marital         VARCHAR,
                             v_JobID           VARCHAR,
                             v_CSDProvinceID   VARCHAR,
                             v_CSDCityID       VARCHAR,
                             v_CSDDistrictID   VARCHAR,
                             v_NationID        VARCHAR,
                             v_NationalityID   VARCHAR,
                             v_JGProvinceID    VARCHAR,
                             v_JGCityID        VARCHAR,
                             v_Organization    VARCHAR,
                             v_OfficePlace     VARCHAR,
                             v_OfficeTEL       VARCHAR,
                             v_OfficePost      VARCHAR,
                             v_HKDZProvinceID  VARCHAR,
                             v_HKDZCityID      VARCHAR,
                             v_HKDZDistrictID  VARCHAR,
                             v_NATIVEPOST      VARCHAR,
                             v_NATIVETEL       VARCHAR,
                             v_NATIVEADDRESS   VARCHAR,
                             v_ADDRESS         VARCHAR,
                             v_ContactPerson   VARCHAR,
                             v_RelationshipID  VARCHAR,
                             v_ContactAddress  VARCHAR,
                             v_ContactTEL      VARCHAR,
                             v_CONTACTOFFICE   VARCHAR,
                             v_CONTACTPOST     VARCHAR,
                             v_OFFERER         VARCHAR,
                             v_SocialCare      VARCHAR,
                             v_INSURANCE       VARCHAR,
                             v_CARDNO          VARCHAR,
                             v_ADMITINFO       VARCHAR,
                             v_AdmitDeptID     VARCHAR,
                             v_AdmitWardID     VARCHAR,
                             v_ADMITBED        VARCHAR,
                             v_AdmitDate       VARCHAR,
                             v_INWARDDATE      VARCHAR,
                             v_ADMITDIAGNOSIS  VARCHAR,
                             v_OutWardDate     VARCHAR,
                             v_OutHosDeptID    VARCHAR,
                             v_OutHosWardID    VARCHAR,
                             v_OutBed          VARCHAR,
                             v_OUTHOSDATE      VARCHAR,
                             v_OUTDIAGNOSIS    VARCHAR,
                             v_TOTALDAYS       int DEFAULT 0,
                             v_CLINICDIAGNOSIS VARCHAR,
                             v_SOLARTERMS      VARCHAR,
                             v_ADMITWAY        VARCHAR,
                             v_OUTWAY          VARCHAR,
                             v_CLINICDOCTOR    VARCHAR,
                             v_RESIDENT        VARCHAR,
                             v_ATTEND          VARCHAR,
                             v_CHIEF           VARCHAR,
                             v_EDU             VARCHAR,
                             v_EDUC            int DEFAULT 0,
                             v_RELIGION        VARCHAR,
                             v_STATUS          int DEFAULT 0,
                             v_CRITICALLEVEL   VARCHAR,
                             v_ATTENDLEVEL     VARCHAR,
                             v_EMPHASIS        int DEFAULT 0,
                             v_ISBABY          int DEFAULT 0,
                             v_MOTHER          NUMERIC,
                             v_MEDICAREID      VARCHAR,
                             v_MEDICAREQUOTA   int DEFAULT 0,
                             v_VOUCHERSCODE    VARCHAR,
                             v_STYLE           VARCHAR,
                             v_OPERATOR        VARCHAR,
                             v_MEMO            VARCHAR,
                             v_CPSTATUS        int DEFAULT 0,
                             v_OUTWARDBED      int DEFAULT 0,
                             v_XZZProvinceID   VARCHAR,
                             v_XZZCityID       VARCHAR,
                             v_XZZDistrictID   VARCHAR,
                             v_XZZTEL          VARCHAR,
                             v_XZZPost         VARCHAR,
                             v_EditType        varchar);
  ----质控出院未归档病历查询
  -----Add by xlb 2013-06-04
  PROCEDURE usp_GetOutHosButNotLocks(v_deptId    VARCHAR2, ---科室代码
                                     v_sex       VARCHAR2, --性别
                                     v_dateBegin VARCHAR2, --出院起始时间
                                     v_dateEnd   VARCHAR2, --出院结束时间
                                     v_patName   VARCHAR2, ----病人姓名
                                     v_PatId     VARCHAR2,
                                     o_result    OUT empcurtyp);
END;
/

prompt
prompt Creating package EMRPROC_WWJ
prompt ============================
prompt
CREATE OR REPLACE PACKAGE EMR.EMRPROC_WWJ IS
  TYPE empcurtyp IS REF CURSOR;

  /*输出更新某个员工信息*/
  PROCEDURE usp_updateuserinfo(v_id     VARCHAR2,
                               v_name   VARCHAR2,
                               v_deptid VARCHAR2,
                               v_wardid VARCHAR2,
                               v_jobid  VARCHAR2);

  /*修改岗位信息*/
  PROCEDURE usp_updatejobinfo(v_id    VARCHAR2,
                              v_title VARCHAR2,
                              v_memo  VARCHAR2);

  /*更新到期的借阅病历*/
  PROCEDURE usp_updatedueapplyrecord(v_applydoctor VARCHAR2 --申请医师代码
                                     );

  /*会诊审核更新状态*/
  PROCEDURE usp_updateconsultationdata(v_consultapplysn INT DEFAULT 0, --会诊号
                                       v_typeid         INT DEFAULT 0, --类型
                                       v_stateid        INT DEFAULT 0, --状态
                                       v_rejectreason   VARCHAR DEFAULT '' --审核意见
                                       );

  /*更新功病案首页手术TABLE*/
  PROCEDURE usp_update_iem_mainpage_oper(v_iem_mainpage_no NUMERIC,
                                         v_cancel_user     VARCHAR);

  /*更新病案首页诊断TABLE,在插入之前调用*/
  PROCEDURE usp_update_iem_mainpage_diag(v_iem_mainpage_no NUMERIC,
                                         v_cancel_user     VARCHAR2);

  /*更新功病案首页基本信息TABLE*/
  PROCEDURE usp_update_iem_mainpage_basic(v_iem_mainpage_no          NUMERIC,
                                          v_patnoofhis               NUMERIC,
                                          v_noofinpat                NUMERIC,
                                          v_payid                    VARCHAR,
                                          v_socialcare               VARCHAR,
                                          v_incount                  INT,
                                          v_name                     VARCHAR,
                                          v_sexid                    VARCHAR,
                                          v_birth                    CHAR,
                                          v_marital                  VARCHAR,
                                          v_jobid                    VARCHAR,
                                          v_provinceid               VARCHAR,
                                          v_countyid                 VARCHAR,
                                          v_nationid                 VARCHAR,
                                          v_nationalityid            VARCHAR,
                                          v_idno                     VARCHAR,
                                          v_organization             VARCHAR,
                                          v_officeplace              VARCHAR,
                                          v_officetel                VARCHAR,
                                          v_officepost               VARCHAR,
                                          v_nativeaddress            VARCHAR,
                                          v_nativetel                VARCHAR,
                                          v_nativepost               VARCHAR,
                                          v_contactperson            VARCHAR,
                                          v_relationship             VARCHAR,
                                          v_contactaddress           VARCHAR,
                                          v_contacttel               VARCHAR,
                                          v_admitdate                VARCHAR,
                                          v_admitdept                VARCHAR,
                                          v_admitward                VARCHAR,
                                          v_days_before              NUMERIC,
                                          v_trans_date               VARCHAR,
                                          v_trans_admitdept          VARCHAR,
                                          v_trans_admitward          VARCHAR,
                                          v_trans_admitdept_again    VARCHAR,
                                          v_outwarddate              VARCHAR,
                                          v_outhosdept               VARCHAR,
                                          v_outhosward               VARCHAR,
                                          v_actual_days              NUMERIC,
                                          v_death_time               VARCHAR,
                                          v_death_reason             VARCHAR,
                                          v_admitinfo                VARCHAR,
                                          v_in_check_date            VARCHAR,
                                          v_pathology_diagnosis_name VARCHAR,
                                          v_pathology_observation_sn VARCHAR,
                                          v_ashes_diagnosis_name     VARCHAR,
                                          v_ashes_anatomise_sn       VARCHAR,
                                          v_allergic_drug            VARCHAR,
                                          v_hbsag                    NUMERIC,
                                          v_hcv_ab                   NUMERIC,
                                          v_hiv_ab                   NUMERIC,
                                          v_opd_ipd_id               NUMERIC,
                                          v_in_out_inpatinet_id      NUMERIC,
                                          v_before_after_or_id       NUMERIC,
                                          v_clinical_pathology_id    NUMERIC,
                                          v_pacs_pathology_id        NUMERIC,
                                          v_save_times               NUMERIC,
                                          v_success_times            NUMERIC,
                                          v_section_director         VARCHAR,
                                          v_director                 VARCHAR,
                                          v_vs_employee_code         VARCHAR,
                                          v_resident_employee_code   VARCHAR,
                                          v_refresh_employee_code    VARCHAR,
                                          v_master_interne           VARCHAR,
                                          v_interne                  VARCHAR,
                                          v_coding_user              VARCHAR,
                                          v_medical_quality_id       NUMERIC,
                                          v_quality_control_doctor   VARCHAR,
                                          v_quality_control_nurse    VARCHAR,
                                          v_quality_control_date     VARCHAR,
                                          v_xay_sn                   VARCHAR,
                                          v_ct_sn                    VARCHAR,
                                          v_mri_sn                   VARCHAR,
                                          v_dsa_sn                   VARCHAR,
                                          v_is_first_case            NUMERIC,
                                          v_is_following             NUMERIC,
                                          v_following_ending_date    VARCHAR,
                                          v_is_teaching_case         NUMERIC,
                                          v_blood_type_id            NUMERIC,
                                          v_rh                       NUMERIC,
                                          v_blood_reaction_id        NUMERIC,
                                          v_blood_rbc                NUMERIC,
                                          v_blood_plt                NUMERIC,
                                          v_blood_plasma             NUMERIC,
                                          v_blood_wb                 NUMERIC,
                                          v_blood_others             VARCHAR,
                                          v_is_completed             VARCHAR,
                                          v_completed_time           VARCHAR,
                                          v_modified_user            VARCHAR);

  /*更新病人就诊信息*/
  PROCEDURE usp_updatadiacrisisinfo(v_noofinpat      NUMERIC, --首页序号(住院流水号)(Inpatient.NoOfInpat)
                                    v_admitdiagnosis VARCHAR2 --入院诊断
                                    );

  /*更新病人基本信息*/
  PROCEDURE usp_updatabasepatientinfo(v_noofinpat     NUMERIC, --首页序号(住院流水号)
                                      v_birth         VARCHAR, --出生日期
                                      v_marital       VARCHAR, --婚姻状况
                                      v_nationid      VARCHAR, --民族代码
                                      v_nationalityid VARCHAR, --国籍代码
                                      v_sexid         VARCHAR, --病人性别
                                      v_edu           VARCHAR, --文化程度
                                      v_provinceid    VARCHAR, --(出生地)省市代码
                                      v_countyid      VARCHAR, --(出生地)区县代码
                                      v_nativeplace_p VARCHAR, --籍贯省市代码
                                      v_nativeplace_c VARCHAR, --籍贯区县代码
                                      v_payid         VARCHAR, --病人性质
                                      v_age           INT, --病人年龄
                                      v_religion      VARCHAR, --宗教信仰
                                      v_educ          NUMERIC, --(受)教育年限(单位:年)
                                      v_idno          VARCHAR, --身份证号
                                      v_jobid         VARCHAR, --职业代码
                                      v_organization  VARCHAR, --工作单位(暂缺)
                                      v_officeplace   VARCHAR, --单位地址
                                      v_officepost    VARCHAR, --单位邮编
                                      v_officetel     VARCHAR, --单位电话
                                      v_nativeaddress VARCHAR, --户口地址
                                      v_nativetel     VARCHAR, --户口电话
                                      v_nativepost    VARCHAR, --户口邮编
                                      v_address       VARCHAR --当前地址
                                      );

  /*输出所有部门信息*/
  PROCEDURE usp_selectward(o_result OUT empcurtyp);

  /*输出所有岗位信息*/
  PROCEDURE usp_selectpermission(o_result OUT empcurtyp);

  /*输出某个员工信息*/
  PROCEDURE usp_selectjob(v_id VARCHAR, o_result OUT empcurtyp);

  /*输出所有部门信息*/
  PROCEDURE usp_selectdepartment(o_result OUT empcurtyp);

  /*输出所有员工信息*/
  PROCEDURE usp_selectallusers2(o_result OUT empcurtyp);

  /*输出所有员工信息*/
  PROCEDURE usp_selectallusers(o_result OUT empcurtyp);

  /*输出所有岗位信息*/
  PROCEDURE usp_selectalljobs(o_result OUT empcurtyp);

  /*保存申请借阅电子病历信息*/
  PROCEDURE usp_saveapplyrecord(v_noofinpat   NUMERIC, --首页序号(住院流水号)
                                v_applydoctor VARCHAR, --申请医生代码
                                v_deptid      VARCHAR, --科室代码
                                v_applyaim    VARCHAR, --申请目的
                                v_duetime     NUMERIC, --申请期限
                                v_unit        VARCHAR --期限单位
                                );

  /*获取病人信息维护窗体控件初始化数据*/
  PROCEDURE usp_redactpatientinfofrm(v_frmtype VARCHAR,
                                     --窗体类型，1n：病人信息管理维护窗体、2n：病人病历史信息窗体
                                     v_noofinpat  NUMERIC DEFAULT '0', --首页序号
                                     v_categoryid VARCHAR DEFAULT '',
                                     --(字典)类别代码 、或父节点代码 、首页序号
                                     o_result OUT empcurtyp);

  /*获取质量控制统计数据(有查询条件)*/
  PROCEDURE usp_queryqcstatinfo(v_datetimebegin VARCHAR, --开始时间
                                v_datetimeend   VARCHAR, --结束时间
                                o_result        OUT empcurtyp);

  /*获取质量控制统计数据*/
  PROCEDURE usp_queryqcstatdetailinfo(v_datetimebegin VARCHAR, --开始时间
                                      v_datetimeend   VARCHAR, --结束时间
                                      v_qcstattype    INT, --统计资料类型
                                      o_result        OUT empcurtyp);

  /*获取问题登记数据*/
  PROCEDURE usp_queryqcprobleminfo(v_noofinpat INT, o_result OUT empcurtyp);

  /*获取质量控制病患数据*/
  PROCEDURE usp_queryqcpatientinfo(v_datetimefrom VARCHAR,
                                   v_datetimeto   VARCHAR,
                                   v_deptid       VARCHAR,
                                   v_wardid       VARCHAR,
                                   v_bedid        VARCHAR,
                                   v_name         VARCHAR,
                                   v_archives     VARCHAR,
                                   o_result       OUT empcurtyp);

  /*根据首页序号获取病人对应信息*/
  PROCEDURE usp_querypatientinfobynoofinp(v_noofinpat INT,
                                          o_result    OUT empcurtyp);

  /*获取病人提取界面病人列表*/
  PROCEDURE usp_queryownmanagerpat2(v_querytype INT,
                                    v_userid    VARCHAR,
                                    v_deptid    VARCHAR,
                                    v_wardid    VARCHAR,
                                    o_result    OUT empcurtyp);

  /*获取对应病区的床位信息*/
  PROCEDURE usp_querynonarchivepatients(v_wardid_in VARCHAR,
                                        v_deptids   VARCHAR,
                                        o_result    OUT empcurtyp);

  /*质控TypeScore操作*/
  PROCEDURE usp_qctypescore(v_typename        VARCHAR,
                            v_typeinstruction VARCHAR,
                            v_typecategory    INT,
                            v_typeorder       INT,
                            v_typememo        VARCHAR,
                            v_typestatus      INT,
                            v_typecode        VARCHAR);

  /*获取质量问题数据*/
  PROCEDURE usp_qcoperprobleminfo(v_id             INT,
                                  v_noofinpat      INT,
                                  v_category       INT,
                                  v_status         INT,
                                  v_typecode       VARCHAR,
                                  v_description    VARCHAR,
                                  v_ansewercontent VARCHAR,
                                  v_confirmcontent VARCHAR,
                                  v_problemdate    VARCHAR,
                                  v_registerdate   VARCHAR,
                                  v_registeruser   VARCHAR,
                                  v_answerdate     VARCHAR,
                                  v_answeruser     VARCHAR,
                                  v_confirmdate    VARCHAR,
                                  v_confirmuser    VARCHAR,
                                  v_deldate        VARCHAR,
                                  v_deluser        VARCHAR,
                                  v_operstatus     INT);

  /*获取质量控制统计数据*/
  PROCEDURE usp_qcitemscore(v_itemname           VARCHAR,
                            v_iteminstruction    VARCHAR,
                            v_itemdefaultscore   INT,
                            v_itemstandardscore  INT,
                            v_itemcategory       INT,
                            v_itemdefaulttarget  INT,
                            v_itemtargetstandard INT,
                            v_itemscorestandard  INT,
                            v_itemorder          INT,
                            v_typecode           VARCHAR,
                            v_itemmemo           VARCHAR,
                            v_typestatus         INT,
                            v_itemcode           VARCHAR);

  /*获取病历模板选择助手数据*/
  PROCEDURE usp_msquerytemplate(v_id         VARCHAR,
                                v_user       VARCHAR,
                                v_type       INT,
                                v_department VARCHAR DEFAULT '',
                                o_result     OUT empcurtyp);
END;
/

prompt
prompt Creating package EMRQCMANAGER
prompt =============================
prompt
CREATE OR REPLACE PACKAGE EMR.emrqcmanager IS
  TYPE empcurtype IS REF CURSOR;

  --得到病人列表
  PROCEDURE usp_getpatientlist(v_deptid         VARCHAR2,
                               v_patid          VARCHAR2,
                               v_name           VARCHAR2,
                               v_status         VARCHAR2,
                               v_admitbegindate VARCHAR2,
                               v_admitenddate   VARCHAR2,
                               o_result         OUT empcurtype);
  PROCEDURE usp_getpatientlistandpat(v_deptid         VARCHAR2,
                                     v_patid          VARCHAR2,
                                     v_name           VARCHAR2,
                                     v_status         VARCHAR2,
                                     v_admitbegindate VARCHAR2,
                                     v_admitenddate   VARCHAR2,
                                     o_result         OUT empcurtype);

PROCEDURE usp_getpatientlistandpat_ZY(v_deptid         VARCHAR2,
                                     v_patid          VARCHAR2,
                                     v_name           VARCHAR2,
                                     v_status         VARCHAR2,
                                     v_admitbegindate VARCHAR2,
                                     v_admitenddate   VARCHAR2,
                                     o_result         OUT empcurtype);


  PROCEDURE usp_getpatientlistandpatSZ(v_deptid         VARCHAR2,
                                       v_patid          VARCHAR2,
                                       v_name           VARCHAR2,
                                       v_status         VARCHAR2,
                                       v_admitbegindate VARCHAR2,
                                       v_admitenddate   VARCHAR2,
                                       o_result         OUT empcurtype);


   PROCEDURE usp_getpatientlistandpatSZ_ZY(v_deptid         VARCHAR2,
                                       v_patid          VARCHAR2,
                                       v_name           VARCHAR2,
                                       v_status         VARCHAR2,
                                       v_admitbegindate VARCHAR2,
                                       v_admitenddate   VARCHAR2,
                                       o_result         OUT empcurtype);


  --得到科室统计信息
  procedure usp_GetAllDepartmentStatInfo(v_deptid         varchar2,
                                         v_patid          varchar2,
                                         v_name           varchar2,
                                         v_status         varchar2,
                                         v_admitbegindate varchar2,
                                         v_admitenddate   varchar2,
                                         o_result         OUT empcurtype);

  --统计科室的病历评分信息 add by wyt 2012-12-12
  procedure usp_getdepartmentpatqcinfo(v_deptid         VARCHAR2,
                                       v_patid          VARCHAR2,
                                       v_name           VARCHAR2,
                                       v_status         VARCHAR2,
                                       v_admitbegindate VARCHAR2,
                                       v_admitenddate   VARCHAR2,
                                       v_sortid         varchar2,
                                       v_sumpoint1      int,
                                       v_sumpoint2      int,
                                       V_type           varchar2,
                                       V_userid         varchar2,
                                       V_auth           varchar2,
                                       o_result         OUT empcurtype);

  ---获得科室内病人，（在评分表中存在记录的病人）
  PROCEDURE usp_getdepartmentpatstatinfo(v_deptid         VARCHAR2,
                                         v_patid          VARCHAR2,
                                         v_name           VARCHAR2,
                                         v_status         VARCHAR2,
                                         v_admitbegindate VARCHAR2,
                                         v_admitenddate   VARCHAR2,
                                         v_sortid         VARCHAR2,
                                         v_sumpoint       int, --新增的总分 ywk 2012年6月12日 14:51:41
                                         V_type           varchar2, --新增的按类型查询 ywk 2012年11月6日10:55:58
                                         o_result         OUT empcurtype);

  --仁和 获取科室统计信息 通过病人状态获取
  PROCEDURE usp_RHgetalldepstatinfo(v_deptid         VARCHAR2,
                                    v_patid          VARCHAR2,
                                    v_name           VARCHAR2,
                                    v_status         VARCHAR2,
                                    v_admitbegindate VARCHAR2,
                                    v_admitenddate   VARCHAR2,
                                    o_result         OUT empcurtype);

  --仁和 获取科室统计信息 住院和出院病人汇总
  PROCEDURE usp_RHgetDepstatinfoAll(v_deptid         VARCHAR2,
                                    v_patid          VARCHAR2,
                                    v_name           VARCHAR2,
                                    v_admitbegindate VARCHAR2,
                                    v_admitenddate   VARCHAR2,
                                    o_result         OUT empcurtype);

  ---仁和 获得科室内病人，（在评分表中存在记录的病人 并且记录状态是8701 科室主任）
  PROCEDURE usp_GetRHGetDeptinfo(v_deptid         VARCHAR2,
                                 v_patid          VARCHAR2,
                                 v_name           VARCHAR2,
                                 v_status         VARCHAR2,
                                 v_admitbegindate VARCHAR2,
                                 v_admitenddate   VARCHAR2,
                                 o_result         OUT empcurtype);

  --得到病人的统计信息(仁和版本的，不连接评分表edit by ywk 2012年7月13日 08:58:34)
  procedure usp_GetrhDepartmentPatStatInfo(v_deptid         varchar2,
                                           v_patid          varchar2,
                                           v_name           varchar2,
                                           v_status         varchar2,
                                           v_admitbegindate varchar2,
                                           v_admitenddate   varchar2,
                                           o_result         OUT empcurtype);

  --得到病人的统计信息 质控科人员 入院出院 (仁和版本的，不连接评分表edit by ywk 2012年8月2日 08:58:34)
  procedure usp_GetrhDepPatStatInfoAll(v_deptid         varchar2,
                                       v_patid          varchar2,
                                       v_name           varchar2,
                                       v_admitbegindate varchar2,
                                       v_admitenddate   varchar2,
                                       o_result         OUT empcurtype);

  --得到病人的统计信息 科室指控员 (仁和版本的，不连接评分表edit by ywk 2012年8月2日 08:58:34)
  procedure usp_GetrhDepPatStatInfoCY(v_deptid         varchar2,
                                      v_patid          varchar2,
                                      v_name           varchar2,
                                      v_admitbegindate varchar2,
                                      v_admitenddate   varchar2,
                                      o_result         OUT empcurtype);

  --得到病人的所有病历
  procedure usp_GetAllEmrDocByNoofinpat(v_noofinpat varchar2,
                                        o_result    OUT empcurtype);

  --得到科室所有医生
  procedure usp_GetAllDoctorByUserNO(v_userid varchar2,
                                     o_result OUT empcurtype);

  --得到科室所有医生
  procedure usp_GetAllDoctorByNoofinpat(v_noofinpat varchar2,
                                        o_result    OUT empcurtype);

  --得到病历评分表的信息 //edit by wyt 2012-12-06 新增评分主记录ID条件
  procedure usp_GetEmrPointByNoofinpat(v_noofinpat varchar2,
                                       v_chiefid   varchar2,
                                       o_result    OUT empcurtype);

  -- 仁和 得到病历评分表的详细信息
  procedure usp_GetRHPoint(v_rhqc_tableId varchar2,
                           o_result       OUT empcurtype);

  procedure usp_insertEmrPoint(v_doctorid       varchar2,
                               v_doctorname     varchar2,
                               v_create_user    varchar2,
                               v_createusername varchar2,
                               v_problem_desc   varchar2,
                               v_reducepoint    varchar2,
                               v_num            varchar2,
                               --v_grade varchar2,  王冀 2012 11 30
                               v_recorddetailid   varchar2,
                               v_noofinpat        varchar2,
                               v_recorddetailname varchar2,
                               v_sortid           varchar2, --新增大类编号
                               -- v_emrpointid INT DEFAULT 0,---新增字段
                               v_emrpointid varchar2, ---新增字段 --edit by wyt 2012-12-11
                               v_chiefid    varchar2, ---新增字段,
                               v_emrpointchildid varchar2
                               );

  --删除仁和评分表的项
  procedure usp_cancelRHEmrPoint(v_id              varchar2,
                                 v_cancel_user     varchar2,
                                 v_cancel_userName varchar2);

  procedure usp_cancelEmrPoint(v_id varchar2, v_cancel_user varchar2);

  procedure usp_GetPatientInfo(v_noofinpat varchar2,
                               o_result    OUT empcurtype);

  procedure usp_GetPointByDoctorID(v_doctorID varchar2,
                                   o_result   OUT empcurtype);

  ------病历评分类别配置
  PROCEDURE usp_Edit_ConfigPoint(v_EditType   varchar default '', --操作类型
                                 V_ID         varchar default '',
                                 v_CCode      varchar default '',
                                 v_CChildCode varchar default '',
                                 v_CChildName varchar default '',
                                 v_Valid      varchar default '1',
                                 o_result     OUT empcurtype);

  ------病历评分（扣分理由）配置       ywk 2012年5月28日 09:22:10
  PROCEDURE usp_Edit_ConfigReduction(v_EditType        varchar default '', --操作类型
                                     V_REDUCEPOINT     varchar default '',
                                     v_PROBLEMDESC     varchar default '',
                                     v_CREATEUSER      varchar default '',
                                     v_CREATETIME      varchar default '',
                                     v_ID              varchar default '',
                                     v_Valid           varchar default '1',
                                     v_Parents         varchar default '',
                                     v_Children        varchar default '',
                                     v_Isauto          varchar default '',
                                     v_Selectcondition varchar default '',
                                     o_result          OUT empcurtype);

  --病历评分中要显示的跟节点
  procedure usp_GetPointClass(o_result OUT empcurtype);

  ------科室质控员的配置操作 2012年7月10日13:45:29 ywk
  PROCEDURE usp_Edit_ConfigPointManager(v_EditType      varchar default '', --操作类型
                                        V_ID            varchar default '',
                                        v_DeptID        varchar default '',
                                        v_QcManagerID   varchar default '',
                                        v_ChiefDoctorID varchar default '',
                                        v_Valid         varchar default '1',
                                        o_result        OUT empcurtype);

  PROCEDURE usp_getRHdepartpatstatinfo(v_deptid         VARCHAR2,
                                       v_patid          VARCHAR2,
                                       v_name           VARCHAR2,
                                       v_status         VARCHAR2,
                                       v_admitbegindate VARCHAR2,
                                       v_admitenddate   VARCHAR2,
                                       o_result         OUT empcurtype);

  ------病历评分（扣分理由）配置 仁和质控       ywk 2012年8月7日 09:22:10
  PROCEDURE usp_Edit_RHConfigReduction(v_EditType    varchar default '', --操作类型
                                       V_REDUCEPOINT varchar default '',
                                       v_PROBLEMDESC varchar default '',
                                       v_CREATEUSER  varchar default '',
                                       v_CREATETIME  varchar default '',
                                       v_ID          varchar default '',
                                       v_Valid       varchar default '1',
                                       v_UserType    varchar default '',
                                       o_result      OUT empcurtype);
  ------质控统计详情   wj 2013 3 21
  PROCEDURE usp_QcmanagerDepartmentlist(o_result OUT empcurtype);

  procedure usp_QcmanagerDepartmentDetail(v_deptid varchar default '',
                                         o_result OUT empcurtype);
END; -- Package spec
/

prompt
prompt Creating package EMRSYSTABLE
prompt ============================
prompt
CREATE OR REPLACE PACKAGE EMR.emrsystable IS
  -- 维护基本数据表
  TYPE empcurtyp IS REF CURSOR;

  /*
  Diagnosis  诊断库
  */
  PROCEDURE usp_Edit_Diagnosis(v_EditType      varchar default '', --操作类型
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
                               v_Memo          varchar default '',
                               o_result        OUT empcurtyp);

  /*
  Diagnosis  科室常用诊断库
  */
  PROCEDURE usp_Edit_DeptDiagnosis(v_EditType varchar default '', --操作类型
                                   v_DeptID   varchar default '',
                                   v_MarkID   varchar default '',
                                   o_result   OUT empcurtyp);

  /*
  DiagnosisOfChinese     中医诊断库
  */
  PROCEDURE usp_Edit_DiagnosisOfChinese(v_EditType varchar default '', --操作类型
                                        v_ID       varchar default '',
                                        v_MapID    varchar default '',
                                        v_Name     varchar default '',
                                        v_Py       varchar default '',
                                        v_Wb       varchar default '',
                                        v_Valid    int default 1,
                                        v_Memo     varchar default '',
                                        v_Memo1    varchar default '',
                                        v_Category varchar default '',
                                        o_result   OUT empcurtyp);

  /*
  DiseaseCFG  病种设置库
  */
  PROCEDURE usp_Edit_DiseaseCFG(v_EditType  varchar default '', --操作类型
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
                                v_Memo      varchar default '',
                                o_result    OUT empcurtyp);

  /*
  Surgery  手术代码库
  */
  PROCEDURE usp_Edit_Surgery(v_EditType     varchar default '', --操作类型
                             v_ID           varchar default '',
                             v_MapID        varchar default '',
                             v_StandardCode varchar default '',
                             v_Name         varchar default '',
                             v_Py           varchar default '',
                             v_Wb           varchar default '',
                             v_Valid        int default 1,
                             v_Memo         varchar default '',
                             v_bzlb         varchar default '',
                             v_sslb         int default '',
                             o_result       OUT empcurtyp);

  /*
  Toxicosis  损伤中毒库
  */
  PROCEDURE usp_Edit_Toxicosis(v_EditType     varchar default '', --操作类型
                               v_ID           varchar default '',
                               v_MapID        varchar default '',
                               v_StandardCode varchar default '',
                               v_Name         varchar default '',
                               v_Py           varchar default '',
                               v_Wb           varchar default '',
                               v_Valid        int default 1,
                               v_Memo         varchar default '',
                               o_result       OUT empcurtyp);

   ------------手术信息的维护
  PROCEDURE usp_Edit_OperInfo(v_EditType     varchar default '', --操作类型
                             v_ID           varchar default '',
                             v_MapID        varchar default '',
                             --v_StandardCode varchar default '',
                             v_Name         varchar default '',
                             v_Py           varchar default '',
                             v_Wb           varchar default '',
                             v_Valid        int default 1,
                             v_Memo         varchar default '',
                           --  v_bzlb         varchar default '',
                             v_sslb         int default '',
                             o_result       OUT empcurtyp);

  /*
  Tumor  肿瘤库
  */
  PROCEDURE usp_Edit_Tumor(v_EditType     varchar default '', --操作类型
                           v_ID           varchar default '',
                           v_MapID        varchar default '',
                           v_StandardCode varchar default '',
                           v_Name         varchar default '',
                           v_Py           varchar default '',
                           v_Wb           varchar default '',
                           v_Valid        int default 1,
                           v_Memo         varchar default '',
                           o_result       OUT empcurtyp);







/*
  Tumor  模板工厂库
*/

PROCEDURE usp_Edit_ModelEmr(v_EditType      varchar default '', --操作类型
                               v_ModelId        varchar default '',
                               v_DestEmrName           varchar default '',
                               v_SourceEmrName         varchar default '',
                               v_DestItemName  varchar default '',
                               v_SourceItemName          varchar default '',
                               v_Valid         int default 1,
                               o_result        OUT empcurtyp);



end;
/

prompt
prompt Creating package EMRTEMPLETFACTORY
prompt ==================================
prompt
CREATE OR REPLACE PACKAGE EMR.emrtempletfactory IS
  -- 模板工厂模块使用到存储过程

  TYPE empcurtyp IS REF CURSOR;

  /*
  *  描述  编辑EMRTEMPLET模板
  */
  PROCEDURE usp_EditEmrTemplet(v_EditType        varchar default '', --操作类型
                               v_TEMPLET_ID      VARCHAR2 default '',
                               v_FILE_NAME       VARCHAR2 default '',
                               v_DEPT_ID         VARCHAR2 default '',
                               v_CREATOR_ID      VARCHAR2 default '',
                               v_CREATE_DATETIME VARCHAR2 default '',
                               v_LAST_TIME       VARCHAR2 default '',
                               v_PERMISSION      VARCHAR2 default '',
                               v_MR_CLASS        VARCHAR2 default '',
                               v_MR_CODE         VARCHAR2 default '',
                               v_MR_NAME         VARCHAR2 default '',
                               v_MR_ATTR         VARCHAR2 default '',
                               v_QC_CODE         VARCHAR2 default '',
                               v_NEW_PAGE_FLAG   INTEGER default 0,
                               v_FILE_FLAG       INTEGER default 0,
                               v_WRITE_TIMES     INTEGER default 0,
                               v_CODE            VARCHAR2 default '',
                               v_HOSPITAL_CODE   VARCHAR2 default '',
                               v_XML_DOC_NEW     clob default '',
                               v_PY              varchar2 default '',
                               v_WB              varchar2 default '',
                               v_ISSHOWFILENAME  varchar2 default '0',
                               v_ISFIRSTDAILY    varchar2 default '0',
                               v_ISYIHUANGOUTONG varchar2 default '0',
                               v_NEW_PAGE_END    INTEGER default 0,
                               v_state           varchar2 default '0',
                               v_auditor         varchar2 default '',
                                v_isconfigpagesize    varchar2 default '0',
                               o_result          OUT empcurtyp);

  /*
  *  描述  编辑EMRTEMPLET_Item子模板
  */
  PROCEDURE usp_EditEmrTemplet_Item(v_EditType         varchar default '', --操作类型
                                    v_MR_CLASS         VARCHAR2 default '',
                                    v_MR_CODE          VARCHAR2 default '',
                                    v_MR_NAME          VARCHAR2 default '',
                                    v_MR_ATTR          VARCHAR2 default '',
                                    v_QC_CODE          VARCHAR2 default '',
                                    v_DEPT_ID          VARCHAR2 default '',
                                    v_CREATOR_ID       VARCHAR2 default '',
                                    v_CREATE_DATE_TIME VARCHAR2 default '',
                                    v_LAST_TIME        VARCHAR2 default '',
                                    v_CONTENT_CODE     VARCHAR2 default '',
                                    v_PERMISSION       int default 0,
                                    v_VISIBLED         int default 1,
                                    v_INPUT            VARCHAR2 default '',
                                    v_HOSPITAL_CODE    VARCHAR2 default '',
                                    v_ITEM_DOC_NEW     clob default '',
                                    o_result           OUT empcurtyp);

  /*
  *  描述  编辑EditEmrTempletHeader表  模板页眉
  */
  PROCEDURE usp_EditEmrTempletHeader(v_EditType        varchar default '', --操作类型
                                     v_HEADER_ID       VARCHAR2 default '',
                                     v_NAME            VARCHAR2 default '',
                                     v_CREATOR_ID      VARCHAR2 default '',
                                     v_CREATE_DATETIME VARCHAR2 default '',
                                     v_LAST_TIME       VARCHAR2 default '',
                                     v_HOSPITAL_CODE   VARCHAR2 default '',
                                     v_CONTENT         CLOB default '',
                                     o_result          OUT empcurtyp);


                                       /*
  *  描述  编辑EditEmrTempletHeader表  模板页脚
  */
  PROCEDURE usp_EditEmrTemplet_Foot(v_EditType        varchar default '', --操作类型
                                     v_FOOT_ID       VARCHAR2 default '',
                                     v_NAME            VARCHAR2 default '',
                                     v_CREATOR_ID      VARCHAR2 default '',
                                     v_CREATE_DATETIME VARCHAR2 default '',
                                     v_LAST_TIME       VARCHAR2 default '',
                                     v_HOSPITAL_CODE   VARCHAR2 default '',
                                     v_CONTENT         CLOB default '',
                                     o_result          OUT empcurtyp);

  --保存诊断按钮
  PROCEDURE usp_SaveDiagButton(v_diagname   varchar);

  --个人模版维护
  PROCEDURE usp_EditMyEmrTemplet(v_EditType        varchar default '',
                               v_CODE      VARCHAR2 default '',
                               v_CREATEUSER      VARCHAR2 default '',
                               v_MR_CLASS        VARCHAR2 default '',
                               v_MR_NAME         VARCHAR2 default '',
                               v_EMRTEMLETCONTENT     clob default '',
                               o_result          OUT empcurtyp);
end;
/

prompt
prompt Creating package EMR_COMMONNOTE
prompt ===============================
prompt
create or replace package emr.emr_commonnote IS
  TYPE empcurtype IS REF CURSOR;

  --通过检索条件获取数据元
  PROCEDURE usp_GetDateElement(v_ElementId    VARCHAR2,
                               v_ElementName  VARCHAR2,
                               v_ElementClass VARCHAR2,
                               v_ElementPYM   VARCHAR2,
                               o_result       OUT empcurtype);

  --通过检索条件获取数据元
  PROCEDURE usp_GetDateElementOne(v_ElementFlow VARCHAR2,
                                  o_result      OUT empcurtype);

  --通过数据元ID查找是够存在该数据元
  PROCEDURE usp_ValiDateElement(v_ElementId VARCHAR2,
                                o_result    OUT empcurtype);

  --插入数据元
  PROCEDURE usp_InsertElement(v_ElementFlow     VARCHAR2,
                              v_ElementId       VARCHAR2,
                              v_ElementName     VARCHAR2,
                              v_ElementType     VARCHAR2,
                              v_ElementForm     VARCHAR2,
                              v_ElementRange    VARCHAR2,
                              v_ElementDescribe VARCHAR2,
                              v_ElementClass    VARCHAR2,
                              v_IsDataElemet    VARCHAR2,
                              v_ElementPYM      VARCHAR2);
  --修改数据元
  PROCEDURE usp_UpDateElement(v_ElementFlow     VARCHAR2,
                              v_ElementId       VARCHAR2,
                              v_ElementName     VARCHAR2,
                              v_ElementType     VARCHAR2,
                              v_ElementForm     VARCHAR2,
                              v_ElementRange    VARCHAR2,
                              v_ElementDescribe VARCHAR2,
                              v_ElementClass    VARCHAR2,
                              v_IsDataElemet    VARCHAR2,
                              v_ElementPYM      VARCHAR2,
                              v_Valid           VARCHAR2);

  --获取简单版通用单
  PROCEDURE usp_GetSimpleCommonNote(v_CommonNoteName VARCHAR2,
                                    o_result         OUT empcurtype);

  --获取通用单对应科室和病区
  PROCEDURE usp_GetCommonNoteSite(v_CommonNoteFlow VARCHAR2,
                                  o_result         OUT empcurtype,
                                  o_result1        OUT empcurtype);

  --获取详细通用单
  PROCEDURE usp_GetDetailCommonNote(v_CommonNoteFlow VARCHAR2,
                                    o_result         OUT empcurtype,
                                    o_result1        OUT empcurtype,
                                    o_result2        OUT empcurtype);

  --插入或修改通用单
  PROCEDURE usp_AddOrModCommonNote(v_CommonNoteFlow   VARCHAR2,
                                   v_CommonNoteName   VARCHAR2,
                                   v_PrinteModelName  VARCHAR2,
                                   v_ShowType         VARCHAR2,
                                   v_CreateDoctorID   VARCHAR2,
                                   v_CreateDoctorName VARCHAR2,
                                   v_UsingFlag        VARCHAR2,
                                   v_Valide           VARCHAR2,
                                   v_PYM              varchar2,
                                   v_WBM              varchar2,
                                   v_UsingPicSign     varchar2,
                                   v_UsingCheckDoc    varchar2);

  --插入或修改通用单标签
  PROCEDURE usp_AddOrModCommonNote_Tab(v_CommonNote_Tab_Flow VARCHAR2,
                                       v_CommonNoteFlow      VARCHAR2,
                                       v_CommonNoteTabName   VARCHAR2,
                                       v_UsingRole           VARCHAR2,
                                       v_ShowType            VARCHAR2,
                                       v_OrderCode           VARCHAR2,
                                       v_CreateDoctorID      VARCHAR2,
                                       v_CreateDoctorName    VARCHAR2,
                                       v_Valide              VARCHAR2,
                                       v_RowMax              VARCHAR2);

  --插入或修改通用单项目
  PROCEDURE usp_AddOrModCommonNote_Item(v_CommonNote_Item_Flow VARCHAR2,
                                        v_CommonNote_Tab_Flow  VARCHAR2,
                                        v_CommonNoteFlow       VARCHAR2,
                                        v_DataElementFlow      VARCHAR2,
                                        v_DataElementId        VARCHAR2,
                                        v_DataElementName      VARCHAR2,
                                        v_OrderCode            VARCHAR2,
                                        v_IsValidate           VARCHAR2,
                                        v_CreateDoctorID       VARCHAR2,
                                        v_CreateDoctorName     VARCHAR2,
                                        v_Valide               VARCHAR2,
                                        v_OtherName            varchar2);

  --插入或修改通用单关联
  PROCEDURE usp_AddOrModCommonNote_Site(v_Site_Flow      VARCHAR2,
                                        v_CommonNoteFlow VARCHAR2,
                                        v_RelationType   VARCHAR2,
                                        v_Site_ID        VARCHAR2,
                                        v_Valide         VARCHAR2);

  --删除该通用单的所用科室
  PROCEDURE usp_DelCommonNote_Site(v_CommonNoteFlow VARCHAR2);

  --获取所有科室和病区
  PROCEDURE usp_GetAllDepartAndAreas(o_result  OUT empcurtype,
                                     o_result1 OUT empcurtype);

  --获取当前科室或病区下的所有配置单据 v_type 01科室 02病区
  PROCEDURE usp_GetCommonNoteForDeptWard(v_SiteCode varchar2,
                                         v_Type     varchar2,
                                         o_result   out empcurtype);

  --通过配置单流水号获取病人单据
  PROCEDURE usp_GetSimInCommonNote(v_noofInpant varchar2,
                                   o_result     out empcurtype);

  PROCEDURE usp_GetSimInCommonNoteByFlow(v_noofInpant     varchar2,
                                         v_commonnoteflow varchar2,
                                         o_result         out empcurtype);

  --病人配置单流水号获取通用单详细信息
  PROCEDURE usp_GetDetailInCommonNoteByDay(v_InCommonNoteFlow     varchar2,
                                           v_incommonnote_tabflow varchar2,
                                           v_StartDate            varchar2,
                                           v_EndDate              varchar2,
                                           o_result               out empcurtype,
                                           o_result1              out empcurtype,
                                           o_result2              out empcurtype);

  --病人配置单流水号获取通用单详细信息
  PROCEDURE usp_GetDetailInCommonNote(v_InCommonNoteFlow varchar2,
                                      o_result           out empcurtype,
                                      o_result1          out empcurtype,
                                      o_result2          out empcurtype);

  --添加或修改病人配置单
  PROCEDURE usp_AddorModInCommon(v_InCommonNoteFlow varchar2,
                                 v_CommonNoteFlow   varchar2,
                                 v_InCommonNoteName varchar2,
                                 v_PrinteModelName  varchar2,
                                 v_NoofInpatient    varchar2,
                                 v_InPatientName    varchar2,
                                 v_CurrDepartID     varchar2,
                                 v_CurrDepartName   varchar2,
                                 v_CurrWardID       varchar2,
                                 v_CurrWardName     varchar2,
                                 v_CreateDoctorID   varchar2,
                                 v_CreateDoctorName varchar2,
                                 v_CreateDateTime   varchar2,
                                 v_Valide           varchar2,
                                 v_CheckDocId       varchar2,
                                 v_CheckDocName     varchar2);

  --添加或修改病人配置单tab
  PROCEDURE usp_AddorModInCommonTab(v_InCommonNote_Tab_Flow varchar2,
                                    v_CommonNote_Tab_Flow   varchar2,
                                    v_InCommonNoteFlow      varchar2,
                                    v_CommonNoteTabName     varchar2,
                                    v_UsingRole             varchar2,
                                    v_ShowType              varchar2,
                                    v_OrderCode             varchar2,
                                    v_CreateDoctorID        varchar2,
                                    v_CreateDoctorName      varchar2,
                                    v_CreateDateTime        varchar2,
                                    v_Valide                varchar2);

  --添加或修改病人配置单项目
  PROCEDURE usp_AddorModInCommonitem(v_InCommonNote_Item_Flow varchar2,
                                     v_InCommonNote_Tab_Flow  varchar2,
                                     v_InCommonNoteFlow       varchar2,
                                     v_CommonNote_Item_Flow   varchar2,
                                     v_CommonNote_Tab_Flow    varchar2,
                                     v_CommonNoteFlow         varchar2,
                                     v_DataElementFlow        varchar2,
                                     v_DataElementId          varchar2,
                                     v_DataElementName        varchar2,
                                     v_OtherName              varchar2,
                                     v_OrderCode              varchar2,
                                     v_IsValidate             varchar2,
                                     v_CreateDoctorID         varchar2,
                                     v_CreateDoctorName       varchar2,
                                     v_CreateDateTime         varchar2,
                                     v_Valide                 varchar2,
                                     v_ValueXml               clob,
                                     v_RecordDate             varchar2,
                                     v_RecordTime             varchar2,
                                     v_RecordDoctorId         varchar2,
                                     v_RecordDoctorName       varchar2,
                                     v_GroupFlow              varchar2);

  --添加或修改使用单据列 xll 20130325
  PROCEDURE usp_AddInCommonType(v_CommonNote_Item_Flow  varchar2,
                                v_InCommonNote_Tab_Flow varchar2,
                                v_DataElementFlow       varchar2,
                                v_OtherName             varchar2);

  --获取病人信息 包括病人信息和所在科室信息
  PROCEDURE usp_GetInpatient(v_noofInpat varchar2, o_result out empcurtype);

  --获取一天的单据数据
  PROCEDURE usp_GetInCommomItemDay(v_commonNoteFlow varchar2,
                                   v_date           varchar2,
                                   v_dept           varchar2,
                                   v_ward           varchar2,
                                   o_result         out empcurtype);

  --根据项目获取病人信息
  PROCEDURE usp_GetInpatientSim(v_incommonnoteitemflow varchar2,
                                o_result               out empcurtype);

  --获取病人的最新一条单据
  PROCEDURE usp_GetIncommonNew(v_noofinpat      varchar2,
                               v_commonnoteflow varchar2,
                               o_result         out empcurtype);

  --获取某个表格中存在多少行
  PROCEDURE usp_GetIncommonTabCount(v_incommonnote_tab_flow varchar2,
                                    o_result                out empcurtype);

  --获取当前病区当前科室的所有病人
  --xlb 2013-01-18
  PROCEDURE usp_GetDeptAndWardInpatient(

                                        v_outhosdept varchar,
                                        v_outhosward varchar,
                                        o_result     out empcurtype);

  --病人同步时，更新婴儿状态和母亲一样 与通用单据无关  xll 20130307
  PROCEDURE usp_ChangeBabyStatus;

  PROCEDURE usp_AddOrModCommonNoteCount(v_CommonNoteCountFlow VARCHAR2,
                                        v_CommonNoteFlow      VARCHAR2,
                                        v_ItemCount           VARCHAR2,
                                        v_Hour12Name          VARCHAR2,
                                        v_Hour12Time          VARCHAR2,
                                        v_Hour24Name          VARCHAR2,
                                        v_Hour24Time          VARCHAR2,
                                        v_Valide              VARCHAR2);

  --插入历史记录
  PROCEDURE usp_AddPrintHistory(v_phflow          VARCHAR2,
                                v_printrecordflow VARCHAR2,
                                v_startpage       integer,
                                v_endpage         integer,
                                v_printpages      integer,
                                v_printdocid      VARCHAR2,
                                v_printdatetime   VARCHAR2,
                                v_printtype       VARCHAR2);

  --插入护理单据的历史记录
  PROCEDURE usp_AddInCommHistory(v_historyflow      varchar2,
                                 v_rowflow          varchar2,
                                 v_createdoctorid   varchar2,
                                 v_createdoctorname varchar2,
                                 v_createdatetime   varchar2,
                                 v_recorddate       varchar2,
                                 v_recordtime       varchar2,
                                 v_recorddoctorid   varchar2,
                                 v_recorddoctorname varchar2,
                                  v_valide varchar2 );

  --插入护理单据的历史记录 列
  PROCEDURE usp_AddInCommColHistory(v_incommonnote_item_flow varchar2,
                                    v_hisrowflow             varchar2,
                                    v_valuexml               varchar2,
                                    v_commonnote_item_flow   varchar2,
                                    v_incommonnote_tab_flow  varchar2,
                                    v_incommonnoteflow       varchar2);

                                    --病人护理单据从第几页开始打印
  PROCEDURE usp_AddOrModIncommPagefrom(v_incommonnoteflow   VARCHAR2,
                                   v_PageFrom   VARCHAR2) ;

end EMR_CommonNote;
/

prompt
prompt Creating package EMR_CONSULTATION
prompt =================================
prompt
CREATE OR REPLACE PACKAGE EMR.emr_consultation IS
  TYPE empcurtyp IS REF CURSOR;

  /*
  * 获取申请借阅病历
  */
  PROCEDURE usp_GetConsultationData(v_NoOfInpat        numeric default '0', --首页序号
                                    v_ConsultApplySn   int default 0, --会诊序号
                                    v_TypeID           numeric default 0, --类别
                                    v_Param1           varchar default '', --参数1
                                    v_ConsultTime      varchar default '',
                                    v_ConsultTypeID    int default 0,
                                    v_UrgencyTypeID    int default 0,
                                    v_Name             varchar default '',
                                    v_PatID            varchar default '',
                                    v_BedID            varchar default '',
                                    v_ConsultTimeBegin varchar default '',
                                    v_ConsultTimeEnd   varchar default '',
                                    v_DeptID           varchar default '',
                                    o_result           OUT empcurtyp,
                                    o_result1          OUT empcurtyp,
                                    o_result2          OUT empcurtyp);

  /*
  * 描述    (会诊申请界面)插入数据
  */
  PROCEDURE usp_InsertConsultationApply(
                                        -- Add the parameters for the stored procedure here
                                        v_typeid            INT DEFAULT 0,
                                        v_consultapplysn    INT DEFAULT 0,
                                        v_noofinpat         NUMERIC DEFAULT '0', --首页序号
                                        v_urgencytypeid     INT DEFAULT 0,
                                        v_consulttypeid     INT DEFAULT 0,
                                        v_abstract          VARCHAR DEFAULT '',
                                        v_purpose           VARCHAR DEFAULT '',
                                        v_applyuser         VARCHAR DEFAULT '',
                                        v_applytime         VARCHAR DEFAULT '',
                                        v_director          VARCHAR DEFAULT '',
                                        v_consulttime       VARCHAR DEFAULT '',
                                        v_consultlocation   VARCHAR DEFAULT '',
                                        v_stateid           INT DEFAULT 0,
                                        v_createuser        VARCHAR DEFAULT '',
                                        v_createtime        VARCHAR DEFAULT '',
                                        v_consultsuggestion VARCHAR DEFAULT '',
                                        v_finishtime        VARCHAR DEFAULT '',
                                        v_rejectreason      VARCHAR DEFAULT '',
                                        --V_mydept            VARCHAR DEFAULT '',
                                        v_APPLYDEPT         VARCHAR DEFAULT '',

                                        V_AuditUserID       VARCHAR DEFAULT '',
                                        v_AuditLevel        VARCHAR DEFAULT '',
                                        o_result            OUT empcurtyp);

  /*
  * 描述    插入ConsultApplyDepartment数据
  */
  PROCEDURE usp_InsertConsultationApplyD(
                                         -- Add the parameters for the stored procedure here
                                         v_consultapplysn  INT DEFAULT 0,
                                         v_ordervalue      INT DEFAULT 0,
                                         v_hospitalcode    VARCHAR DEFAULT '',
                                         v_departmentcode  VARCHAR DEFAULT '',
                                         v_departmentname  VARCHAR DEFAULT '',
                                         v_employeecode    VARCHAR DEFAULT '',
                                         v_employeename    VARCHAR DEFAULT '',
                                         v_employeelevelid VARCHAR DEFAULT '',
                                         v_createuser      VARCHAR DEFAULT '',
                                         v_createtime      VARCHAR DEFAULT '');
  /*
  * 描述    插入ConsultRecordDepartment数据
  */
  PROCEDURE usp_insertconsultationrecord(
                                         -- Add the parameters for the stored procedure here
                                         v_consultapplysn  INT DEFAULT 0,
                                         v_ordervalue      INT DEFAULT 0,
                                         v_hospitalcode    VARCHAR DEFAULT '',
                                         v_departmentcode  VARCHAR DEFAULT '',
                                         v_departmentname  VARCHAR DEFAULT '',
                                         v_employeecode    VARCHAR DEFAULT '',
                                         v_employeename    VARCHAR DEFAULT '',
                                         v_employeelevelid VARCHAR DEFAULT '',
                                         v_createuser      VARCHAR DEFAULT '',
                                         v_createtime      VARCHAR DEFAULT '');
  /*会诊审核更新状态*/
  PROCEDURE usp_updateconsultationdata(v_consultapplysn INT DEFAULT 0, --会诊号
                                       v_typeid         INT DEFAULT 0, --类型
                                       v_stateid        INT DEFAULT 0, --状态
                                       v_rejectreason   VARCHAR DEFAULT '' --审核意见
                                       );

  /*根据提供的会诊申请单编号获取会诊信息*/
  PROCEDURE usp_GetConsultationBySN(v_consultapplysn INT DEFAULT 0, --会诊号
                                    o_result         OUT empcurtyp);

  ---用于签到数据
  PROCEDURE usp_GetConsultUseSign(v_consultapplysn INT DEFAULT 0, --会诊号
                                  o_result         OUT empcurtyp);

  PROCEDURE usp_GetMessageInfo(v_userid VARCHAR DEFAULT '',
                               o_result OUT empcurtyp);

  ----医生工作站中获得会诊信息（全部符合条件的）
  PROCEDURE usp_GetMyConsultion(v_Deptids varchar, --部门编号
                                v_userid  varchar, --登录人编号
                                --v_seetype   varchar,--增加参数区别查询会诊信息的时间段是三天内的还是查询所有的会诊信息  add by ywk 2012年7月24日 14:59:14
                                o_result OUT empcurtyp);

  ----医生工作站中获得会诊信息（全部符合条件的）
  PROCEDURE usp_GetAllMyConsultion(v_Deptids varchar, --部门编号
                                   v_userid  varchar, --登录人编号
                                   v_seetype varchar, --增加参数区别查询会诊信息的时间段是三天内的还是查询所有的会诊信息  add by ywk 2012年7月24日 14:59:14
                                   o_result  OUT empcurtyp);
  ---根据条件获取所有会诊信息（质控办医务人员专用）
  PROCEDURE usp_GetAllConsultion(v_ApplyDeptid    varchar, --部门编号
                                 v_EmployeeDeptid varchar, --部门编号
                                 v_DateTimeBegin  varchar, --开始时间
                                 v_DateTimeEnd    varchar, --结束时间
                                 o_result         OUT empcurtyp);

  -------------------------------------------------会诊数据捞取 新需求  2012-11-07  add by tj -------------
  ----护士工作站中获得会诊信息 tj
  PROCEDURE usp_GetConsultionNurse(v_Deptids varchar, --部门编号
                                   o_result  OUT empcurtyp);

  ----医生工作站中获得会诊信息（全部符合条件的）  by tj
  PROCEDURE usp_GetConsultionDoctor(v_Deptids varchar, --部门编号
                                    v_userid  varchar, --登录人ID
                                    v_levelid varchar, ---登录人级别
                                    o_result  OUT empcurtyp);

  ----会诊提醒信息   by tj
  PROCEDURE usp_GetConsultionMessage(v_Deptids varchar, --部门编号
                                     v_levelid varchar, ---登录人级别
                                     o_result  OUT empcurtyp);

  --Add by wwj 2013-02-18 护士工作站的会诊数据捞取
  PROCEDURE usp_GetConsultionForNurse(v_Deptids varchar,      --部门编号
                                       v_ConsultDateFrom date, --会诊日期
                                       v_ConsultDateTo date,   --会诊日期
                                       v_ConsultState varchar, --会诊状态
                                       o_result OUT empcurtyp);


  --获得已会诊未缴费的记录 Add by wwj 2013-02-19
  PROCEDURE usp_GetAlreadyConsultNotFee(v_Deptids varchar, --部门编号
                                        o_result  OUT empcurtyp);

  --获取待审核的会诊记录 Add by wwj 2013-02-27
  PROCEDURE usp_GetUnAuditConsult(v_timefrom date, --会诊起始时间
                                  v_timeto date,   --会诊终止时间
                                  v_inpatientname varchar, --病人姓名
                                  v_patid  varchar, --病历号
                                  v_urgencyTypeID varchar, --紧急度
                                  v_currentuserid varchar, --当前系统登录人
                                  v_currentuserlevel varchar, --当前用户级别
                                  o_result OUT empcurtyp);

  --获取与系统登录人相关的待会诊、会诊记录保存的记录 Add by wwj 2013-02-27
  PROCEDURE usp_GetWaitConsult(v_timefrom date, --会诊起始时间
                               v_timeto date,   --会诊终止时间
                               v_inpatientname varchar, --病人姓名
                               v_patid  varchar, --病历号
                               v_urgencyTypeID varchar, --紧急度
                               v_bedCode varchar, --床位号
                               v_currentuserid varchar, --当前系统登录人
                               v_currentuserlevel varchar, --当前用户级别
                               o_result OUT empcurtyp);

  --会诊费用测试
  PROCEDURE usp_FeeTest(arg_inp varchar,
                        arg_name varchar,
                        arg_item varchar,
                        arg_itemname varchar,
                        arg_amount number,
                        arg_doct varchar,
                        arg_doctdept varchar,
                        arg_date date,
                        arg_dept varchar,
                        arg_hzdoct varchar,
                        arg_opercode varchar,
                        arg_operdate date,
                        return_code out number,
                        return_result out varchar);

    ---Add by xlb 2013-03-07
 PROCEDURE usp_SaveConsultRecord(
                                         v_TypeID          INT DEFAULT 0,
                                         v_ConsultId            INT DEFAULT 0,
                                         v_consultapplysn  INT DEFAULT 0,
                                         v_ordervalue      INT DEFAULT 0,
                                         v_hospitalcode    VARCHAR DEFAULT '',
                                         v_departmentcode  VARCHAR DEFAULT '',
                                         v_departmentname  VARCHAR DEFAULT '',
                                         v_employeecode    VARCHAR DEFAULT '',
                                         v_employeename    VARCHAR DEFAULT '',
                                         v_employeelevelid VARCHAR DEFAULT '',
                                         v_createuser      VARCHAR DEFAULT '',
                                         v_createtime      VARCHAR DEFAULT '',
                                         v_canceluser      VARCHAR DEFAULT '',
                                         v_modifyuser      VARCHAR DEFAULT '');
 --Add by xlb 2013-03-08
  PROCEDURE usp_SaveApplyDepartOrRecord(
                                         v_TypeId          INT DEFAULT 0,
                                         v_consultapplysn  INT DEFAULT 0,
                                         v_ordervalue      INT DEFAULT 0,
                                         v_hospitalcode    VARCHAR DEFAULT '',
                                         v_departmentcode  VARCHAR DEFAULT '',
                                         v_departmentname  VARCHAR DEFAULT '',
                                         v_employeecode    VARCHAR DEFAULT '',
                                         v_employeename    VARCHAR DEFAULT '',
                                         v_employeelevelid VARCHAR DEFAULT '',
                                         v_createuser      VARCHAR DEFAULT '',
                                         v_createtime      VARCHAR DEFAULT '');

END;
/

prompt
prompt Creating package EMR_DOCTOR_STATION
prompt ===================================
prompt
CREATE OR REPLACE PACKAGE EMR.emr_doctor_station
-----------------------------------------------------------
------------------Add By wwj 2012-07-02--------------------
-----------------医生工作站涉及到的逻辑--------------------
-----------------------------------------------------------
IS
   TYPE empcurtyp IS REF CURSOR;

   --得到三级检诊审核列表
   PROCEDURE usp_getthreelevelcheckList (
      v_deptid        VARCHAR,
      o_result    OUT   empcurtyp
   );
END;
/

prompt
prompt Creating package EMR_NURSE_STATION
prompt ==================================
prompt
create or replace package emr.emr_nurse_station IS
  TYPE empcurtype IS REF CURSOR;

  -- Author  : xll
  -- Created : 2012-8-9 9:26:11

  --通过单据ID和人员ID获取单据信息
  PROCEDURE usp_GetNurseRecord(v_NoOfInpatient  IN varchar2,
                               v_FatherRecordId IN varchar2,
                               o_result         OUT empcurtype);

  --添加或修改记录单记录
  PROCEDURE usp_AddOrModNurseRecord(v_ID              IN varchar2,
                                    v_NOOFINPATENT    IN varchar2,
                                    v_FATHER_RECORDID IN varchar2,
                                    v_RECORD_DATETIME IN varchar2,
                                    v_TIWEN           IN varchar2,
                                    v_MAIBO           IN varchar2,
                                    v_HUXI            IN varchar2,
                                    v_XUEYA           IN varchar2,
                                    v_YISHI           IN varchar2,
                                    v_XYBHD           IN varchar2,
                                    v_QKFL            IN varchar2,
                                    v_SYPF            IN varchar2,
                                    v_OTHER_ONE       IN varchar2,
                                    v_OTHER_TWO       IN varchar2,
                                    v_OTHER_THREE     IN varchar2,
                                    v_OTHER_FOUR      IN varchar2,
                                    v_ZTKDX           IN varchar2,
                                    v_YTKDX           IN varchar2,
                                    v_TKDGFS          IN varchar2,
                                    v_WOWEI           IN varchar2,
                                    v_JMZG            IN varchar2,
                                    v_DGJYLG_ONE      IN varchar2,
                                    v_DGJYLG_TWO      IN varchar2,
                                    v_DGJYLG_THREE    IN varchar2,
                                    v_In_ITEM         IN varchar2,
                                    v_In_VALUE        IN varchar2,
                                    v_OUT_ITEM        IN varchar2,
                                    v_OUT_VALUE       IN varchar2,
                                    v_OUT_COLOR       IN varchar2,
                                    v_OUT_STATUE      IN varchar2,
                                    v_OTHER           IN varchar2,
                                    v_HXMS            IN varchar2,
                                    v_FCIMIAO         IN varchar2,
                                    v_XRYND           IN varchar2,
                                    v_CGSD            IN varchar2,
                                    v_LXXZYTQ         IN varchar2,
                                    v_BDG             IN varchar2,
                                    v_SINGE_DOCTOR    IN varchar2,
                                    v_SINGE_DOCTORID  IN varchar2,
                                    v_CREATE_DOCTORID IN varchar2,
                                    v_CREATE_TIME     IN varchar2,
                                    v_VALID           IN varchar2);

  --删除记录单
  PROCEDURE usp_DelNurseRecord(v_NurseId IN varchar2);

  --查询某科室下所有的病人数据 add by tj 2012-10-30
  procedure usp_GetPatientsOfDept(v_departCode  varchar2,
                                  v_wardcode    varchar2,
                                  v_Timelot     varchar2,
                                  v_TimelotSave varchar2,
                                  v_date        varchar2,
                                  o_result      OUT empcurtype);

  procedure usp_GetPatientsOfDept2(v_departCode  varchar2,
                                   v_wardcode    varchar2,
                                   v_Timelot     varchar2,
                                   v_TimelotSave varchar2,
                                   v_date        varchar2,
                                   o_result      OUT empcurtype,
                                   o_result1     OUT empcurtype,
                                   o_result2     OUT empcurtype);

end EMR_NURSE_STATION;
/

prompt
prompt Creating package EMR_RECORD_INPUT
prompt =================================
prompt
CREATE OR REPLACE PACKAGE EMR.emr_record_input
IS
--
-- To modify this template, edit file PKGSPEC.TXT in TEMPLATE
-- directory of SQL Navigator
--
-- Purpose: Briefly explain the functionality of the package
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  ------------------------------------------
   -- Enter package declarations as shown below
   TYPE empcurtyp IS REF CURSOR;

    --得到用户病历操作记录
   PROCEDURE usp_getoperrecordlog (
      v_user_id      VARCHAR,
      v_patient_id   VARCHAR,
      v_startDate  VARCHAR,
      v_endDate    VARCHAR,
      o_result     OUT empcurtyp
   );

      --插入病历操作记录
PROCEDURE usp_insertoperrecordlog (
      v_user_id          VARCHAR,
      v_user_name        VARCHAR,
      v_patient_id       VARCHAR,
      v_patient_name     VARCHAR,
      v_dept_id          VARCHAR,
      v_record_id        VARCHAR,
      v_record_type      VARCHAR,
      v_record_title     VARCHAR,
      v_oper_id          VARCHAR,
      v_oper_time        VARCHAR,
      v_oper_content     clob
   );

PROCEDURE usp_inserttemplateperson (
      v_templateid   VARCHAR,
      v_name         VARCHAR,
      v_userid       VARCHAR,
      v_content      CLOB,
      v_sortid       VARCHAR,
      v_memo         VARCHAR,
      v_py           VARCHAR,
      v_wb           VARCHAR,
      v_type         VARCHAR,
      v_ISCONFIGPAGESIZE VARCHAR,
      v_deptid       VARCHAR,
      o_result       OUT empcurtyp
   );

   PROCEDURE usp_insertthreelevelcheck (
      v_residentid     VARCHAR,
      v_residentname   VARCHAR,
      v_attendid       VARCHAR,
      v_attentname     VARCHAR,
      v_chiefid        VARCHAR,
      v_chiefname      VARCHAR,
      v_deptid         VARCHAR,
      v_deptname       VARCHAR,
      v_createuser     VARCHAR
   );

   --得到历史病人记录
   PROCEDURE usp_getHistoryInpatient (
      v_noofinpat      VARCHAR,
      v_admitbegindate VARCHAR,--add by xlb 2013-01-14
      v_admitenddate   VARCHAR,--add by xlb 2013-01-14
      o_result     OUT empcurtyp
   );

   --得到历史病人文件夹
   PROCEDURE usp_getHistoryInpatientFolder (
      v_noofinpat      VARCHAR,

      o_result     OUT empcurtyp
   );

   --得到住院次数（******进入我们电子病历系统的次数，而非实际的入院次数**********）
   PROCEDURE usp_getHistoryInCount (
     v_noofinpat       VARCHAR,
     o_result      OUT empcurtyp
   );

   --得到病人的基本信息
   PROCEDURE usp_getPatinetInfo(
     v_noofinpat       VARCHAR,
     o_result      OUT empcurtyp
   );

   --得到病人历史病历，用于历史病历导入
   PROCEDURE usp_getHistoryEMR(
     v_noofinpat        VARCHAR,
     v_sortid           VARCHAR,
     o_result      OUT empcurtyp
   );

   --得到病历内容
   PROCEDURE usp_EmrContentByID(
     v_recorddetailid   VARCHAR,
     o_result      OUT empcurtyp
   );

   /*插入转科记录 add by cyq 2013-03-26*/
   PROCEDURE usp_Inpatient_ChangeInfo(
                               v_id              INTEGER,
                               v_noofinpat       INTEGER,
                               v_newdeptid       VARCHAR2 default '',
                               v_newwardid       VARCHAR2 default '',
                               v_newbedid        VARCHAR2 default '',
                               v_olddeptid       VARCHAR2 default '',
                               v_oldwardid       VARCHAR2 default '',
                               v_oldbedid        VARCHAR2 default '',
                               v_changestyle     CHAR default '',
                               v_createuser      VARCHAR2 default '',
                               v_createtime      CHAR default '',
                               v_modifyuser      VARCHAR2 default '',
                               v_modifytime      CHAR default '',
                               v_valid           INTEGER);

   /*--新历史病历导入
   PROCEDURE usp_BatchInHistoryEMR(
     v_noofinpat       VARCHAR,
     v_templateid      VARCHAR,
     v_name            VARCHAR,
     v_sortid          VARCHAR,
     v_owner           VARCHAR,
     v_createtime      VARCHAR,
     v_captiondatetime VARCHAR,
     v_firstdailyflag  VARCHAR,
     v_isyihuangougong VARCHAR,
     v_ip              VARCHAR,
     v_isconfigpagesize VARCHAR,
     v_departcode      VARCHAR,
     v_wardcode        VARCHAR,
     v_changeid        VARCHAR
   );
   */
END;                                                           -- Package spec
/

prompt
prompt Creating package EMR_VIEW_TOOL
prompt ==============================
prompt
CREATE OR REPLACE PACKAGE EMR.EMR_VIEW_TOOL IS
  TYPE empcurtype IS REF CURSOR;

  --**********************************历次出院病历查阅**************************************
  --获取病人基本信息
  PROCEDURE usp_inpatient_info(v_patnoofhis VARCHAR2,
                               o_result     OUT empcurtype);

  --获取历史病人
  PROCEDURE usp_history_inpatient(v_patnoofhis VARCHAR2,
                                  o_result     OUT empcurtype);

  --获取病人病历
  PROCEDURE usp_inpatient_emr(v_noofinpat VARCHAR2,
                              o_result    OUT empcurtype);

  --获取病人病历
  PROCEDURE usp_inpatient_emr2(v_id VARCHAR2, o_result OUT empcurtype);

  --**********************************门急诊历史病历查阅**************************************

  --获取病人基本信息【门诊】
  PROCEDURE usp_inpatient_info_clinic(v_patnoofhis VARCHAR2,
                                      o_result     OUT empcurtype);

  --获取历史病人【门诊】
  PROCEDURE usp_history_inpatient_clinic(v_patnoofhis VARCHAR2,
                                         o_result     OUT empcurtype);

  --获取病人病历【门诊】
  PROCEDURE usp_inpatient_emr_clinic(v_noofinpat VARCHAR2,
                                     o_result    OUT empcurtype);

  --获取病人病历【门诊】
  PROCEDURE usp_inpatient_emr2_clinic(v_id     VARCHAR2,
                                      o_result OUT empcurtype);

  --获取门诊电子病历的宏元素的值
  PROCEDURE usp_macro_inpatient_clinic(v_noofinpat VARCHAR2,
                                       o_result    OUT empcurtype);

  --********************************病人信息维护******************************************
  --获取门诊电子病历的宏元素的值
  PROCEDURE usp_get_inpatient_list(v_deptID         VARCHAR2,
                                   v_visitTypeID    VARCHAR2,
                                   v_name           VARCHAR2,
                                   v_patID          VARCHAR2,
                                   v_visitTimeBegin date,
                                   v_visitTimeEnd   date,
                                   o_result         OUT empcurtype);

  --通过病历号或病人姓名抓取病人
  PROCEDURE usp_get_inpatient_list2(v_patID  VARCHAR2,
                                    v_name   VARCHAR2,
                                    o_result OUT empcurtype);

  --获取门诊科室列表                                   
  PROCEDURE usp_get_dept_list(o_result OUT empcurtype);

  --********************************测试，用于解析XML*************************************
  PROCEDURE usp_xml_content(v_recordDetailID varchar2,
                            v_roElementName  varchar2,
                            o_result         OUT empcurtype);

END; -- Package spec                                             -- Package spec
/

prompt
prompt Creating package EMR_ZYMOSIS_REPORT
prompt ===================================
prompt
CREATE OR REPLACE PACKAGE EMR.EMR_ZYMOSIS_REPORT IS
  TYPE empcurtyp IS REF CURSOR;

  /*
  * 插入传染病报告卡内容
  */
  PROCEDURE usp_EditZymosis_Report(v_EditType         varchar,
                                   v_Report_ID        NUMERIC DEFAULT 0,
                                   v_Report_NO        varchar DEFAULT '', --报告卡卡号
                                   v_Report_Type      varchar default '', --报告卡类型   1、初次报告  2、订正报告
                                   v_Noofinpat        varchar default '', --首页序号
                                   v_PatID            varchar default '', --住院号
                                   v_Name             varchar default '', --患者姓名
                                   v_ParentName       varchar default '', --家长姓名
                                   v_IDNO             varchar default '', --身份证号码
                                   v_Sex              varchar default '', --患者性别
                                   v_Birth            varchar default '', --出生日期
                                   v_Age              varchar default '', --实足年龄
                                   v_AgeUnit          varchar default '', --实足年龄单位
                                   v_Organization     varchar default '', --工作单位
                                   v_OfficePlace      varchar default '', --单位地址
                                   v_OfficeTEL        varchar default '', --单位电话
                                   v_AddressType      varchar default '', --病人属于地区  1、本县区 2、本市区其他县区  3、本省其他地区  4、外省  5、港澳台  6、外籍
                                   v_HomeTown         varchar default '', --家乡
                                   v_Address          varchar default '', --详细地址[村 街道 门牌号]
                                   v_JobID            varchar default '', --职业代码（按页面顺序记录编号）
                                   v_RecordType1      varchar default '', --病历分类  1、疑似病历  2、临床诊断病历  3、实验室确诊病历  4病原携带者
                                   v_RecordType2      varchar default '', --病历分类（乙型肝炎、血吸虫病填写）  1、急性  2、慢性
                                   v_AttackDate       varchar default '', --发病日期（病原携带者填初检日期或就诊日期）
                                   v_DiagDate         varchar default '', --诊断日期
                                   v_DieDate          varchar default '', --死亡日期
                                   v_DiagICD10        varchar default '', --传染病病种(对应传染病诊断库)
                                   v_DiagName         varchar default '', --传染病病种名称
                                   v_INFECTOTHER_FLAG varchar default '', --有无感染其他人[0无 1有]
                                   v_Memo             varchar default '', --备注
                                   v_Correct_flag     varchar default '', --订正标志【0、未订正 1、已订正】
                                   v_Correct_Name     varchar default '', --订正病名
                                   v_Cancel_Reason    varchar default '', --退卡原因
                                   v_ReportDeptCode   varchar default '', --报告科室编号
                                   v_ReportDeptName   varchar default '', --报告科室名称
                                   v_ReportDocCode    varchar default '', --报告医生编号
                                   v_ReportDocName    varchar default '', --报告医生名称
                                   v_DoctorTEL        varchar default '', --报告医生联系电话
                                   v_Report_Date      varchar default '', --填卡时间
                                   v_State            varchar default '', --报告状态【 1、新增保存 2、提交 3、撤回 4、审核通过 5、审核未通过撤回 6、上报  7、作废】
                                   v_StateName        varchar default '', --操作状态，方便记录操作流水中
                                   v_create_date      varchar default '', --创建时间
                                   v_create_UserCode  varchar default '', --创建人
                                   v_create_UserName  varchar default '', --创建人
                                   v_create_deptCode  varchar default '', --创建人科室
                                   v_create_deptName  varchar default '', --创建人科室
                                   v_Modify_date      varchar default '', --修改时间
                                   v_Modify_UserCode  varchar default '', --修改人
                                   v_Modify_UserName  varchar default '', --修改人
                                   v_Modify_deptCode  varchar default '', --修改人科室
                                   v_Modify_deptName  varchar default '', --修改人科室
                                   v_Audit_date       varchar default '', --审核时间
                                   v_Audit_UserCode   varchar default '', --审核人
                                   v_Audit_UserName   varchar default '', --审核人
                                   v_Audit_deptCode   varchar default '', --审核人科室
                                   v_Audit_deptName   varchar default '', --审核人科室
                                   v_OtherDiag        varchar default '',
                                   o_result           OUT empcurtyp);

  PROCEDURE usp_GetInpatientByNofinpat(v_Noofinpat varchar default '', --首页序号
                                       o_result    OUT empcurtyp);

  PROCEDURE usp_geteditzymosisreport(v_report_type1    varchar default '',
                                     v_report_type2    varchar default '',
                                     v_name            varchar default '',
                                     v_patid           varchar default '',
                                     v_deptid          varchar default '',
                                     v_applicant       varchar default '',
                                     v_status          varchar default '',
                                     v_createdatestart varchar default '', --新增的上报日期开始
                                     v_createdateend   varchar default '', --新增的上报日期结束
                                     v_querytype       varchar default '', --查询类型
                                     o_result          OUT empcurtyp);

  PROCEDURE usp_getReportBrowse(v_report_type1 varchar default '',
                                v_report_type2 varchar default '',
                                v_recordtype1  varchar default '',
                                v_beginDate    varchar default '',
                                v_EndDate      varchar default '',
                                v_deptid       varchar default '',
                                v_diagICD      varchar default '',
                                v_status       varchar default '',
                                o_result       OUT empcurtyp);

  PROCEDURE usp_GetReportAnalyse(v_beginDate varchar default '',
                                 v_EndDate   varchar default '',
                                 o_result    OUT empcurtyp);

  --分职业统计传染病信息
  PROCEDURE usp_GetJobDisease(v_beginDate varchar default '',
                              v_EndDate   varchar default '',
                              v_DiagCode  varchar default '',
                              o_result    OUT empcurtyp);

  --得到所有有效的诊断
  PROCEDURE usp_GetDiagnosis(o_result OUT empcurtyp);

  --得到传染病病种信息
  PROCEDURE usp_GetDisease2(o_result OUT empcurtyp);

  --得到所有有效的诊断
  PROCEDURE usp_GetDiagnosisTo(v_categoryid varchar default '',
                               o_result     OUT empcurtyp);

  --得到所有有效的诊断
  PROCEDURE usp_GetDiagnosisTo_ZY(v_categoryid varchar default '',
                                  o_result     OUT empcurtyp);

  --得到传染病病种信息
  PROCEDURE usp_GetDisease2To(v_categoryid varchar default '',
                              o_result     OUT empcurtyp);

  --保存病种记录
  PROCEDURE usp_SaveZymosisDiagnosis(v_markid   varchar default '',
                                     v_icd      varchar default '',
                                     v_name     varchar default '',
                                     v_py       varchar default '',
                                     v_wb       varchar default '',
                                     v_levelID  varchar default '',
                                     v_valid    varchar default '',
                                     v_statist  varchar default '',
                                     v_memo     varchar default '',
                                     v_namestr  varchar default '',
                                     v_upcount  integer,
                                     v_fukatype varchar default '');
  --保存病种记录
  PROCEDURE usp_SaveZymosisDiagnosisTo(v_markid     varchar default '',
                                       v_icd        varchar default '',
                                       v_name       varchar default '',
                                       v_py         varchar default '',
                                       v_wb         varchar default '',
                                       v_levelID    varchar default '',
                                       v_valid      varchar default '',
                                       v_statist    varchar default '',
                                       v_memo       varchar default '',
                                       v_namestr    varchar default '',
                                       v_upcount    integer,
                                       v_categoryid integer);

  PROCEDURE usp_EditTherioma_Report(v_EditType              varchar,
                                    v_Report_ID             NUMERIC DEFAULT 0,
                                    v_REPORT_DISTRICTID     varchar DEFAULT '', --传染病上报卡表区(县)编码
                                    v_REPORT_DISTRICTNAME   varchar default '', --传染病上报卡表区(县)名称
                                    v_REPORT_ICD10          varchar default '', --传染病报告卡ICD-10编码
                                    v_REPORT_ICD0           varchar default '', --传染病报告卡ICD-0编码
                                    v_REPORT_CLINICID       varchar default '', --门诊号
                                    v_REPORT_PATID          varchar default '', --住院号
                                    v_REPORT_INDO           varchar default '', --身份证号码
                                    v_REPORT_INPATNAME      varchar default '', --病患姓名
                                    v_SEXID                 varchar default '', --病患性别
                                    v_REALAGE               varchar default '', --病患实足年龄
                                    v_BIRTHDATE             varchar default '', --病患生日
                                    v_NATIONID              varchar default '', --病患民族编号
                                    v_NATIONNAME            varchar default '', --病患民族全称
                                    v_CONTACTTEL            varchar default '', --家庭电话
                                    v_MARTIAL               varchar default '', --婚姻状况
                                    v_OCCUPATION            varchar default '', --病患职业
                                    v_OFFICEADDRESS         varchar default '', --工作单位地址
                                    v_ORGPROVINCEID         varchar default '', --户口地址省份编码
                                    v_ORGCITYID             varchar default '', --户口地址所在市编码
                                    v_ORGDISTRICTID         varchar default '', --户口所在地区县编码
                                    v_ORGTOWNID             varchar default '', --户口所在地镇(街道)编码
                                    v_ORGVILLIAGE           varchar default '', --户口所在地居委会对应编码
                                    v_ORGPROVINCENAME       varchar default '', --户口所在地省份全称
                                    v_ORGCITYNAME           varchar default '', --户口所在地市全名称
                                    v_ORGDISTRICTNAME       varchar default '', --户口所在地区(县)全称
                                    v_ORGTOWN               varchar default '', --户口所在地镇全称
                                    v_ORGVILLAGENAME        varchar default '', --户口所在地村全称
                                    v_XZZPROVINCEID         varchar default '', --现住址所在省份编码
                                    v_XZZCITYID             varchar default '', --现住址所在市编码
                                    v_XZZDISTRICTID         varchar default '', --现住址所在区(县)代码
                                    v_XZZTOWNID             varchar default '', --现住址所在镇代码
                                    v_XZZVILLIAGEID         varchar default '', --报现住址所在村编码
                                    v_XZZPROVINCE           varchar default '', --现住址所在省份全称
                                    v_XZZCITY               varchar default '', --现住址所在市全称
                                    v_XZZDISTRICT           varchar default '', --现住址所在区全称
                                    v_XZZTOWN               varchar default '', --现住址所在镇全称
                                    v_XZZVILLIAGE           varchar default '', --现住址所在村全称
                                    v_REPORT_DIAGNOSIS      varchar default '', --诊断
                                    v_PATHOLOGICALTYPE      varchar default '', --病理类型
                                    v_PATHOLOGICALID        varchar default '', --病理诊断病理号
                                    v_QZDIAGTIME_T          varchar default '', --确诊时期_T期
                                    v_QZDIAGTIME_N          varchar default '', --确诊时期_N期
                                    v_QZDIAGTIME_M          varchar default '', --确诊时期_M期
                                    v_FIRSTDIADATE          varchar default '', --首次确诊时间
                                    v_REPORTINFUNIT         varchar default '', --报告单位
                                    v_REPORTDOCTOR          varchar default '', --报告医生
                                    v_REPORTDATE            varchar default '', --报告时间
                                    v_DEATHDATE             varchar default '', --死亡时间
                                    v_DEATHREASON           varchar default '', --死亡原因
                                    v_REJEST                varchar default '', --病历摘要
                                    v_REPORT_YDIAGNOSIS     varchar default '', --原诊断
                                    v_REPORT_YDIAGNOSISDATA varchar default '', --原诊断日期
                                    v_REPORT_DIAGNOSISBASED varchar default '', --诊断依据
                                    v_REPORT_NO             varchar default '', --传染病上报卡表编号
                                    v_REPORT_NOOFINPAT      varchar default '', --患者ID
                                    v_STATE                 varchar default '', --报告状态【 1、新增保存 2、提交 3、撤回 4、审核通过 5、审核未通过撤回 6、上报  7、作废】
                                    v_CREATE_DATE           varchar default '', --创建人日期  
                                    v_CREATE_USERCODE       varchar default '', --创建人
                                    v_CREATE_USERNAME       varchar default '', --创建人
                                    v_CREATE_DEPTCODE       varchar default '', --创建人科室
                                    v_CREATE_DEPTNAME       varchar default '', --创建人科室
                                    v_MODIFY_DATE           varchar default '', --修改时间
                                    v_MODIFY_USERCODE       varchar default '', --修改人
                                    v_MODIFY_USERNAME       varchar default '', --修改人
                                    v_MODIFY_DEPTCODE       varchar default '', --修改人科室
                                    v_MODIFY_DEPTNAME       varchar default '', --修改人科室
                                    v_AUDIT_DATE            varchar default '', --审核时间
                                    v_AUDIT_USERCODE        varchar default '', --审核人
                                    v_AUDIT_USERNAME        varchar default '', --审核人
                                    v_AUDIT_DEPTCODE        varchar default '', --审核人科室
                                    v_AUDIT_DEPTNAME        varchar default '', --审核人科室
                                    v_VAILD                 varchar default '', --状态是否有效  1、有效   0、无效
                                    v_DIAGICD10             varchar default '', --传染病病种(对应传染病诊断库)
                                    v_CANCELREASON          varchar default '', --否决原因   
                                    V_CARDTYPE              varchar default '', --卡片类型死亡或者发病                     
                                    V_clinicalstages        varchar default '',
                                    V_ReportDiagfunit       varchar default '',
                                    o_result                OUT empcurtyp);

  --脑卒中报告卡  add  by  ywk 2013年8月21日 15:47:00
  PROCEDURE usp_EditCardiovacular_Report(v_EditType      varchar, --操作类型
                                         v_REPORT_NO     varchar DEFAULT '', --报告卡卡号                                 
                                         v_NOOFCLINIC    varchar DEFAULT '', --门诊号 
                                         v_PATID         varchar default '',
                                         v_NAME          varchar default '',
                                         v_IDNO          varchar default '',
                                         v_SEXID         varchar default '',
                                         v_BIRTH         varchar default '',
                                         v_AGE           varchar DEFAULT '',
                                         v_NATIONID      varchar default '',
                                         v_JOBID         varchar default '',
                                         v_OFFICEPLACE   varchar default '',
                                         v_CONTACTTEL    varchar default '',
                                         v_HKPROVICE     varchar default '',
                                         v_HKCITY        varchar default '',
                                         v_HKSTREET      varchar default '',
                                         v_HKADDRESSID   varchar default '',
                                         v_XZZPROVICE    varchar default '',
                                         v_XZZCITY       varchar default '',
                                         v_XZZSTREET     varchar default '',
                                         v_XZZADDRESSID  varchar default '',
                                         v_XZZCOMMITTEES varchar default '',
                                         v_XZZPARM         varchar default '',
                                         v_ICD             varchar default '',
                                         v_DIAGZWMXQCX     varchar default '',
                                         v_DIAGNCX         varchar default '',
                                         v_DIAGNGS         varchar default '',
                                         v_DIAGWFLNZZ      varchar default '',
                                         v_DIAGJXXJGS      varchar default '',
                                         v_DIAGXXCS        varchar default '',
                                         v_DIAGNOSISBASED  varchar default '',
                                         v_DIAGNOSEDATE    varchar default '',
                                         v_ISFIRSTSICK     varchar default '',
                                         v_DIAGHOSPITAL    varchar default '',
                                         v_OUTFLAG         varchar default '',
                                         v_DIEDATE         varchar default '',
                                         v_REPORTDEPT      varchar default '',
                                         v_REPORTUSERCODE  varchar default '',
                                         v_REPORTUSERNAME  varchar default '',
                                         v_REPORTDATE      varchar default '',
                                         v_CREATE_DATE     varchar default '',
                                         v_CREATE_USERCODE varchar default '',
                                         v_CREATE_USERNAME varchar default '',
                                         v_CREATE_DEPTCODE varchar default '',
                                         v_CREATE_DEPTNAME varchar default '',
                                         v_MODIFY_DATE     varchar default '',
                                         v_MODIFY_USERCODE varchar default '',
                                         v_MODIFY_USERNAME varchar default '',
                                         v_MODIFY_DEPTCODE varchar default '',
                                         v_MODIFY_DEPTNAME varchar default '',
                                         v_AUDIT_DATE      varchar default '',
                                         v_AUDIT_USERCODE  varchar default '',
                                         v_AUDIT_USERNAME  varchar default '',
                                         v_AUDIT_DEPTCODE  varchar default '',
                                         v_AUDIT_DEPTNAME  varchar default '',
                                         v_VAILD           varchar default '',
                                         v_CANCELREASON    varchar default '',
                                         v_STATE           varchar default '',
                                         v_CARDPARAM1      varchar default '',
                                         v_CARDPARAM2      varchar default '',
                                         v_CARDPARAM3      varchar default '',
                                         v_CARDPARAM4      varchar default '',
                                         v_CARDPARAM5      varchar default '',
                                         v_NOOFINPAT       varchar default '',
                                           v_REPORTID      varchar DEFAULT '',
                                         o_result          OUT empcurtyp);

  --出生儿缺陷报告卡  add  by  jxh  2013-08-16   暂时放这
  PROCEDURE usp_EditTbirthdefects_Report(v_EditType         varchar,
                                         v_ID               NUMERIC DEFAULT 0,
                                         v_REPORT_NOOFINPAT varchar DEFAULT '', --病人编号
                                         v_REPORT_ID        varchar default '', --报告卡序号
                                         v_DIAG_CODE        varchar default '', --报告卡诊断编码
                                         v_STRING3          varchar default '', --预留
                                         v_STRING4          varchar default '', --预留
                                         v_STRING5          varchar default '', --预留
                                         v_REPORT_PROVINCE  varchar DEFAULT '', --上报告卡省份
                                         v_REPORT_CITY      varchar default '', --报告卡市（县）
                                         v_REPORT_TOWN      varchar default '', --报告卡乡镇
                                         v_REPORT_VILLAGE   varchar default '', --报告卡村
                                         v_REPORT_HOSPITAL  varchar default '', --报告卡医院
                                         v_REPORT_NO        varchar default '', --报告卡序号
                                         v_MOTHER_PATID     varchar default '', --产妇住院号
                                         v_MOTHER_NAME      varchar default '', --姓名
                                         v_MOTHER_AGE       varchar default '', --年龄
                                         v_NATIONAL         varchar default '', --民族
                                         v_ADDRESS_POST     varchar default '', --地址and邮编
                                         v_PREGNANTNO       varchar default '', --孕次
                                         v_PRODUCTIONNO     varchar default '', --产次
                                         v_LOCALADD         varchar default '', --常住地
                                         
                                         v_PERCAPITAINCOME         varchar default '', --年人均收入     
                                         v_EDUCATIONLEVEL          varchar default '', --文化程度     
                                         v_CHILD_PATID             varchar default '', --孩子住院号     
                                         v_CHILD_NAME              varchar default '', --孩子姓名     
                                         v_ISBORNHERE              varchar default '', --是否本院出生     
                                         v_CHILD_SEX               varchar default '', --孩子性别      
                                         v_BORN_YEAR               varchar default '', --出生年     
                                         v_BORN_MONTH              varchar default '', --  出生月     
                                         v_BORN_DAY                varchar default '', --出生日      
                                         v_GESTATIONALAGE          varchar default '', --胎龄     
                                         v_WEIGHT                  varchar default '', --体重     
                                         v_BIRTHS                  varchar default '', --胎数     
                                         v_ISIDENTICAL             varchar default '', --是否同卵      
                                         v_OUTCOME                 varchar default '', --转归      
                                         v_INDUCEDLABOR            varchar default '', --是否引产     
                                         v_DIAGNOSTICBASIS         varchar default '', --诊断依据——临床      
                                         v_DIAGNOSTICBASIS1        varchar default '', --诊断依据——超声波      
                                         v_DIAGNOSTICBASIS2        varchar default '', --诊断依据——尸解     
                                         v_DIAGNOSTICBASIS3        varchar default '', --诊断依据——生化检查     
                                         v_DIAGNOSTICBASIS4        varchar default '', --诊断依据——生化检查——其他     
                                         v_DIAGNOSTICBASIS5        varchar default '', --诊断依据——染色体      
                                         v_DIAGNOSTICBASIS6        varchar default '', --诊断依据——其他     
                                         v_DIAGNOSTICBASIS7        varchar default '', --诊断依据——其他——内容     
                                         v_DIAG_ANENCEPHALY        varchar default '', --出生缺陷诊断——无脑畸形     
                                         v_DIAG_SPINA              varchar default '', --出生缺陷诊断——脊柱裂      
                                         v_DIAG_PENGOUT            varchar default '', --出生缺陷诊断——脑彭出      
                                         v_DIAG_HYDROCEPHALUS      varchar default '', --出生缺陷诊断——先天性脑积水     
                                         v_DIAG_CLEFTPALATE        varchar default '', --出生缺陷诊断——腭裂     
                                         v_DIAG_CLEFTLIP           varchar default '', --出生缺陷诊断——唇裂      
                                         v_DIAG_CLEFTMERGER        varchar default '', --出生缺陷诊断——唇裂合并腭裂     
                                         v_DIAG_SMALLEARS          varchar default '', --出生缺陷诊断——小耳（包括无耳）     
                                         v_DIAG_OUTEREAR           varchar default '', --出生缺陷诊断——外耳其它畸形（小耳、无耳除外）     
                                         v_DIAG_ESOPHAGEAL         varchar default '', --出生缺陷诊断——食道闭锁或狭窄     
                                         v_DIAG_RECTUM             varchar default '', --出生缺陷诊断——直肠肛门闭锁或狭窄（包括无肛）     
                                         v_DIAG_HYPOSPADIAS        varchar default '', --出生缺陷诊断——尿道下裂     
                                         v_DIAG_BLADDER            varchar default '', --出生缺陷诊断——膀胱外翻     
                                         v_DIAG_HORSESHOEFOOTLEFT  varchar default '', --出生缺陷诊断——马蹄内翻足_左      
                                         v_DIAG_HORSESHOEFOOTRIGHT varchar default '', --出生缺陷诊断——马蹄内翻足_右     
                                         v_DIAG_MANYPOINTLEFT      varchar default '', --出生缺陷诊断——多指（趾）_左      
                                         v_DIAG_MANYPOINTRIGHT     varchar default '', --出生缺陷诊断——多指（趾）_右     
                                         v_DIAG_LIMBSUPPERLEFT     varchar default '', --出生缺陷诊断——肢体短缩_上肢 _左      
                                         v_DIAG_LIMBSUPPERRIGHT    varchar default '', --出生缺陷诊断——肢体短缩_上肢 _右     
                                         v_DIAG_LIMBSLOWERLEFT     varchar default '', --出生缺陷诊断——肢体短缩_下肢 _左      
                                         v_DIAG_LIMBSLOWERRIGHT    varchar default '', --出生缺陷诊断——肢体短缩_下肢 _右     
                                         v_DIAG_HERNIA             varchar default '', --出生缺陷诊断——先天性膈疝     
                                         v_DIAG_BULGINGBELLY       varchar default '', --出生缺陷诊断——脐膨出     
                                         v_DIAG_GASTROSCHISIS      varchar default '', --出生缺陷诊断——腹裂     
                                         v_DIAG_TWINS              varchar default '', --出生缺陷诊断——联体双胎     
                                         v_DIAG_TSSYNDROME         varchar default '', --出生缺陷诊断——唐氏综合征（21-三体综合征）     
                                         v_DIAG_HEARTDISEASE       varchar default '', --出生缺陷诊断——先天性心脏病（类型）      
                                         v_DIAG_OTHER              varchar default '', --出生缺陷诊断——其他（写明病名或详细描述）      
                                         v_DIAG_OTHERCONTENT       varchar default '', --出生缺陷诊断——其他内容      
                                         v_FEVER                   varchar default '', --发烧（＞38℃）      
                                         v_VIRUSINFECTION          varchar default '', --病毒感染     
                                         v_ILLOTHER                varchar default '', --患病其他     
                                         v_SULFA                   varchar default '', --磺胺类     
                                         v_ANTIBIOTICS             varchar default '', --抗生素     
                                         v_BIRTHCONTROLPILL        varchar default '', --避孕药      
                                         v_SEDATIVES               varchar default '', --镇静药     
                                         v_MEDICINEOTHER           varchar default '', --服药其他      
                                         v_DRINKING                varchar default '', --饮酒     
                                         v_PESTICIDE               varchar default '', --农药      
                                         v_RAY                     varchar default '', --射线      
                                         v_CHEMICALAGENTS          varchar default '', --化学制剂     
                                         v_FACTOROTHER             varchar default '', --其他有害因素      
                                         v_STILLBIRTHNO            varchar default '', --死胎例数     
                                         v_ABORTIONNO              varchar default '', --自然流产例数     
                                         v_DEFECTSNO               varchar default '', --缺陷儿例数     
                                         v_DEFECTSOF1              varchar default '', --缺陷名1     
                                         v_DEFECTSOF2              varchar default '', --缺陷名2     
                                         v_DEFECTSOF3              varchar default '', --缺陷名3     
                                         v_YCDEFECTSOF1            varchar default '', --遗传缺陷名1     
                                         v_YCDEFECTSOF2            varchar default '', --遗传缺陷名2     
                                         v_YCDEFECTSOF3            varchar default '', --遗传缺陷名3     
                                         v_KINSHIPDEFECTS1         varchar default '', --与缺陷儿亲缘关系1     
                                         v_KINSHIPDEFECTS2         varchar default '', --与缺陷儿亲缘关系2     
                                         v_KINSHIPDEFECTS3         varchar default '', --与缺陷儿亲缘关系3     
                                         v_COUSINMARRIAGE          varchar default '', --近亲婚配史      
                                         v_COUSINMARRIAGEBETWEEN   varchar default '', --近亲婚配史关系     
                                         v_PREPARER                varchar default '', --填表人      
                                         v_THETITLE1               varchar default '', --填表人职称     
                                         v_FILLDATEYEAR            varchar default '', --填表日期年      
                                         v_FILLDATEMONTH           varchar default '', --填表日期月     
                                         v_FILLDATEDAY             varchar default '', --填表日期日     
                                         v_HOSPITALREVIEW          varchar default '', --医院审表人      
                                         v_THETITLE2               varchar default '', --医院审表人职称     
                                         v_HOSPITALAUDITDATEYEAR   varchar default '', --医院审表日期年     
                                         v_HOSPITALAUDITDATEMONTH  varchar default '', --医院审表日期月      
                                         v_HOSPITALAUDITDATEDAY    varchar default '', --医院审表日期日      
                                         v_PROVINCIALVIEW          varchar default '', --省级审表人      
                                         v_THETITLE3               varchar default '', --省级审表人职称     
                                         v_PROVINCIALVIEWDATEYEAR  varchar default '', --省级审表日期年      
                                         v_PROVINCIALVIEWDATEMONTH varchar default '', --省级审表日期月     
                                         v_PROVINCIALVIEWDATEDAY   varchar default '', --省级审表日期日     
                                         v_FEVERNO                 varchar default '', --发烧度数      
                                         v_ISVIRUSINFECTION        varchar default '', --是否病毒感染     
                                         v_ISDIABETES              varchar default '', --是否糖尿病      
                                         v_ISILLOTHER              varchar default '', --是否患病其他     
                                         v_ISSULFA                 varchar default '', --是否磺胺类     
                                         v_ISANTIBIOTICS           varchar default '', --是否抗生素     
                                         v_ISBIRTHCONTROLPILL      varchar default '', --是否避孕药      
                                         v_ISSEDATIVES             varchar default '', --是否镇静药     
                                         v_ISMEDICINEOTHER         varchar default '', --是否服药其他      
                                         v_ISDRINKING              varchar default '', --是否饮酒     
                                         v_ISPESTICIDE             varchar default '', --是否农药      
                                         v_ISRAY                   varchar default '', --是否射线      
                                         v_ISCHEMICALAGENTS        varchar default '', --是否化学制剂     
                                         v_ISFACTOROTHER           varchar default '', --是否其他有害因素      
                                         v_STATE                   varchar default '', -- "报告状态【 1、新增保存 2、提交 3、撤回 4、?to open this dialog next """     
                                         v_CREATE_DATE             varchar default '', --创建时间      
                                         v_CREATE_USERCODE         varchar default '', --创建人     
                                         v_CREATE_USERNAME         varchar default '', ---创建人      
                                         v_CREATE_DEPTCODE         varchar default '', --创建人科室     
                                         v_CREATE_DEPTNAME         varchar default '', --创建人科室     
                                         v_MODIFY_DATE             varchar default '', --修改时间      
                                         v_MODIFY_USERCODE         varchar default '', --修改人     
                                         v_MODIFY_USERNAME         varchar default '', --修改人     
                                         v_MODIFY_DEPTCODE         varchar default '', --修改人科室     
                                         v_MODIFY_DEPTNAME         varchar default '', --修改人科室     
                                         v_AUDIT_DATE              varchar default '', --审核时间     
                                         v_AUDIT_USERCODE          varchar default '', --审核人      
                                         v_AUDIT_USERNAME          varchar default '', --审核人      
                                         v_AUDIT_DEPTCODE          varchar default '', --审核人科室      
                                         v_AUDIT_DEPTNAME          varchar default '', --审核人科室      
                                         v_VAILD                   varchar default '', --状态是否有效  1、有效   0、无效     
                                         v_CANCELREASON            varchar default '', --否决原因     
                                         v_PRENATAL                varchar default '', --产前     
                                         v_PRENATALNO              varchar default '', --产前周数     
                                         v_POSTPARTUM              varchar default '', --产后     
                                         v_ANDTOSHOWLEFT           varchar default '', --并指左     
                                         v_ANDTOSHOWRIGHT          varchar default '', --并指右
                                         o_result                  OUT empcurtyp);

  --报表部分---肿瘤登记月报表 add by ywk 2013年7月31日 14:59:19
  PROCEDURE usp_GetTheriomaReportBYMonth( --v_searchtype varchar default '',--增加此字段主要后期为i区分中心医院及其他的查询
                                         v_year          varchar default '', --年
                                         v_month         varchar default '', --月
                                         v_deptcode      varchar default '', --科室编码
                                         v_diagstartdate varchar default '', --诊断开始时间
                                         v_diagenddate   varchar default '', --诊断结束时间
                                         o_result        OUT empcurtyp);

  --报表部分---恶性肿瘤新发病例登记簿 add by ywk 2013年8月2日 11:29:02
  PROCEDURE usp_GetTheriomaReportBYNew( --v_searchtype varchar default '',--增加此字段主要后期为i区分中心医院及其他的查询
                                       v_year   varchar default '', --年
                                       v_month  varchar default '', --月
                                       o_result OUT empcurtyp);

  --报表部分---恶性肿瘤死亡病例登记簿 add by ywk 2013年8月2日 11:29:02
  PROCEDURE usp_GetTheriomaReportBYDead( --v_searchtype varchar default '',--增加此字段主要后期为i区分中心医院及其他的查询
                                        v_year   varchar default '', --年
                                        v_month  varchar default '', --月
                                        o_result OUT empcurtyp);

  --报表部分---肿瘤登记月报表 add by ywk 2013年8月5日 11:32:52中心医院
  PROCEDURE usp_GetTheriomaReportBYMonthZX( --v_searchtype varchar default '',--增加此字段主要后期为i区分中心医院及其他的查询
                                           v_year          varchar default '', --年
                                           v_month         varchar default '', --月
                                           v_deptcode      varchar default '', --科室编码
                                           v_diagstartdate varchar default '', --诊断开始时间
                                           v_diagenddate   varchar default '', --诊断结束时间
                                           o_result        OUT empcurtyp);
                                           
   --报表部分---肿瘤登记月报表 add by jxh 2013年9月12日 14:05:52中心医院
  PROCEDURE usp_CardiovascularReport( --v_searchtype varchar default '',--增加此字段主要后期为i区分中心医院及其他的查询
                                           v_year          varchar default '', --年
                                           v_month         varchar default '', --月
                                           v_deptcode      varchar default '', --科室编码
                                           v_diagstartdate varchar default '', --诊断开始时间
                                           v_diagenddate   varchar default '', --诊断结束时间
                                           o_result        OUT empcurtyp);

  --保存或修改艾滋病报表
  --保存或修改艾滋病报表
  PROCEDURE usp_AddOrModHIVReport(v_HIVID               varchar2,
                                  v_REPORTID            integer,
                                  v_REPORTNO            varchar2,
                                  v_MARITALSTATUS       varchar2,
                                  v_NATION              varchar2,
                                  v_CULTURESTATE        varchar2,
                                  v_HOUSEHOLDSCOPE      varchar2,
                                  v_HOUSEHOLDADDRESS    varchar2,
                                  v_ADDRESS             varchar2,
                                  v_CONTACTHISTORY      varchar2,
                                  v_VENERISMHISTORY     varchar2,
                                  v_INFACTWAY           varchar2,
                                  v_SAMPLESOURCE        varchar2,
                                  v_DETECTIONCONCLUSION varchar2,
                                  v_AFFIRMDATE          varchar2,
                                  v_AFFIRMLOCAL         varchar2,
                                  v_DIAGNOSEDATE        varchar2,
                                  v_DOCTOR              varchar2,
                                  v_WRITEDATE           varchar2,
                                  v_ALIKESYMBOL         varchar2,
                                  v_REMARK              varchar2,
                                  v_VAILD               varchar2,
                                  v_CREATOR             varchar2,
                                  v_CREATEDATE          varchar2,
                                  v_MENDER              varchar2,
                                  v_ALTERDATE           varchar2);

  --保存或修改沙眼衣原体感染
  PROCEDURE usp_AddOrModSYYYTReport(v_SZDYYTID            varchar,
                                    v_REPORTID            integer,
                                    v_REPORTNO            varchar,
                                    v_MARITALSTATUS       varchar,
                                    v_NATION              varchar,
                                    v_CULTURESTATE        varchar,
                                    v_HOUSEHOLDSCOPE      varchar,
                                    v_HOUSEHOLDADDRESS    varchar,
                                    v_ADDRESS             varchar,
                                    v_SYYYTGR             varchar,
                                    v_CONTACTHISTORY      varchar,
                                    v_VENERISMHISTORY     varchar,
                                    v_INFACTWAY           varchar,
                                    v_SAMPLESOURCE        varchar,
                                    v_DETECTIONCONCLUSION varchar,
                                    v_AFFIRMDATE          varchar,
                                    v_AFFIRMLOCAL         varchar,
                                    v_VAILD               varchar,
                                    v_CREATOR             varchar,
                                    v_CREATEDATE          varchar,
                                    v_MENDER              varchar,
                                    v_ALTERDATE           varchar);

  --保存或修改乙肝报告表
  PROCEDURE usp_AddOrModHBVReport(v_HBVID varchar2,
                                  
                                  v_REPORTID      integer,
                                  v_HBSAGDATE     varchar2,
                                  v_FRISTDATE     varchar2,
                                  v_ALT           varchar2,
                                  v_ANTIHBC       varchar2,
                                  v_LIVERBIOPSY   varchar2,
                                  v_RECOVERYHBSAG varchar2,
                                  
                                  v_VAILD      varchar2,
                                  v_CREATOR    varchar2,
                                  v_CREATEDATE varchar2,
                                  v_MENDER     varchar2,
                                  v_ALTERDATE  varchar2);

  -- -保存或修改尖锐湿疣项目
  PROCEDURE usp_AddOrModJRSYReport(v_JRSY_ID             varchar,
                                   v_REPORTID            integer,
                                   v_REPORTNO            varchar,
                                   v_MARITALSTATUS       varchar,
                                   v_NATION              varchar,
                                   v_CULTURESTATE        varchar,
                                   v_HOUSEHOLDSCOPE      varchar,
                                   v_HOUSEHOLDADDRESS    varchar,
                                   v_ADDRESS             varchar,
                                   v_CONTACTHISTORY      varchar,
                                   v_VENERISMHISTORY     varchar,
                                   v_INFACTWAY           varchar,
                                   v_SAMPLESOURCE        varchar,
                                   v_DETECTIONCONCLUSION varchar,
                                   v_AFFIRMDATE          varchar,
                                   v_AFFIRMLOCAL         varchar,
                                   v_VAILD               varchar,
                                   v_CREATOR             varchar,
                                   v_CREATEDATE          varchar,
                                   v_MENDER              varchar,
                                   v_ALTERDATE           varchar);
  --保存或修改甲型H1N1流感报表
  PROCEDURE usp_AddOrModH1N1Report(v_H1N1ID         varchar2,
                                   v_REPORTID       integer,
                                   v_CASETYPE       varchar2,
                                   v_HOSPITALSTATUS varchar2,
                                   v_ISCURE         varchar2,
                                   v_ISOVERSEAS     varchar2,
                                   v_VAILD          varchar2,
                                   v_CREATOR        varchar2,
                                   v_CREATEDATE     varchar2,
                                   v_MENDER         varchar2,
                                   v_ALTERDATE      varchar2);

  --保存或修改手足口病报告表
  PROCEDURE usp_AddOrModHFMDReport(v_HFMDID     varchar2,
                                   v_REPORTID   integer,
                                   v_LABRESULT  varchar2,
                                   v_ISSEVERE   varchar2,
                                   v_VAILD      varchar2,
                                   v_CREATOR    varchar2,
                                   v_CREATEDATE varchar2,
                                   v_MENDER     varchar2,
                                   v_ALTERDATE  varchar2);

  --保存或修改AFP报告表
  PROCEDURE usp_AddOrModAFPReport(v_AFPID            varchar2,
                                  v_REPORTID         integer,
                                  v_HOUSEHOLDSCOPE   varchar2,
                                  v_HOUSEHOLDADDRESS varchar2,
                                  v_ADDRESS          varchar2,
                                  v_PALSYDATE        varchar2,
                                  v_PALSYSYMPTOM     varchar2,
                                  v_VAILD            varchar2,
                                  v_CREATOR          varchar2,
                                  v_CREATEDATE       varchar2,
                                  v_MENDER           varchar2,
                                  v_ALTERDATE        varchar2,
                                  v_DIAGNOSISDATE    varchar2);

END;
/

prompt
prompt Creating package IEM_MAIN_PAGE
prompt ==============================
prompt
CREATE OR REPLACE PACKAGE EMR.iem_main_page IS
  TYPE empcurtyp IS REF CURSOR;

  /*插入病案首页信息*/
  PROCEDURE usp_insertiembasicinfo(v_patnoofhis               varchar,
                                   v_noofinpat                varchar,
                                   v_payid                    VARCHAR,
                                   v_socialcare               VARCHAR,
                                   v_incount                  VARCHAR,
                                   v_name                     VARCHAR,
                                   v_sexid                    VARCHAR,
                                   v_birth                    VARCHAR,
                                   v_marital                  VARCHAR,
                                   v_jobid                    VARCHAR,
                                   v_provinceid               VARCHAR,
                                   v_countyid                 VARCHAR,
                                   v_nationid                 VARCHAR,
                                   v_nationalityid            VARCHAR,
                                   v_idno                     VARCHAR,
                                   v_organization             VARCHAR,
                                   v_officeplace              VARCHAR,
                                   v_officetel                VARCHAR,
                                   v_officepost               VARCHAR,
                                   v_nativeaddress            VARCHAR,
                                   v_nativetel                VARCHAR,
                                   v_nativepost               VARCHAR,
                                   v_contactperson            VARCHAR,
                                   v_relationship             VARCHAR,
                                   v_contactaddress           VARCHAR,
                                   v_contacttel               VARCHAR,
                                   v_admitdate                VARCHAR,
                                   v_admitdept                VARCHAR,
                                   v_admitward                VARCHAR,
                                   v_days_before              VARCHAR,
                                   v_trans_date               VARCHAR,
                                   v_trans_admitdept          VARCHAR,
                                   v_trans_admitward          VARCHAR,
                                   v_trans_admitdept_again    VARCHAR,
                                   v_outwarddate              VARCHAR,
                                   v_outhosdept               VARCHAR,
                                   v_outhosward               VARCHAR,
                                   v_actual_days              VARCHAR,
                                   v_death_time               VARCHAR,
                                   v_death_reason             VARCHAR,
                                   v_admitinfo                VARCHAR,
                                   v_in_check_date            VARCHAR,
                                   v_pathology_diagnosis_name VARCHAR,
                                   v_pathology_observation_sn VARCHAR,
                                   v_ashes_diagnosis_name     VARCHAR,
                                   v_ashes_anatomise_sn       VARCHAR,
                                   v_allergic_drug            VARCHAR,
                                   v_hbsag                    VARCHAR,
                                   v_hcv_ab                   VARCHAR,
                                   v_hiv_ab                   VARCHAR,
                                   v_opd_ipd_id               VARCHAR,
                                   v_in_out_inpatinet_id      VARCHAR,
                                   v_before_after_or_id       VARCHAR,
                                   v_clinical_pathology_id    VARCHAR,
                                   v_pacs_pathology_id        VARCHAR,
                                   v_save_times               VARCHAR,
                                   v_success_times            VARCHAR,
                                   v_section_director         VARCHAR,
                                   v_director                 VARCHAR,
                                   v_vs_employee_code         VARCHAR,
                                   v_resident_employee_code   VARCHAR,
                                   v_refresh_employee_code    VARCHAR,
                                   v_master_interne           VARCHAR,
                                   v_interne                  VARCHAR,
                                   v_coding_user              VARCHAR,
                                   v_medical_quality_id       VARCHAR,
                                   v_quality_control_doctor   VARCHAR,
                                   v_quality_control_nurse    VARCHAR,
                                   v_quality_control_date     VARCHAR,
                                   v_xay_sn                   VARCHAR,
                                   v_ct_sn                    VARCHAR,
                                   v_mri_sn                   VARCHAR,
                                   v_dsa_sn                   VARCHAR,
                                   v_is_first_case            VARCHAR,
                                   v_is_following             VARCHAR,
                                   v_following_ending_date    VARCHAR,
                                   v_is_teaching_case         VARCHAR,
                                   v_blood_type_id            VARCHAR,
                                   v_rh                       VARCHAR,
                                   v_blood_reaction_id        VARCHAR,
                                   v_blood_rbc                VARCHAR,
                                   v_blood_plt                VARCHAR,
                                   v_blood_plasma             VARCHAR,
                                   v_blood_wb                 VARCHAR,
                                   v_blood_others             VARCHAR,
                                   v_is_completed             VARCHAR,
                                   v_completed_time           VARCHAR,
                                   v_create_user              VARCHAR,
                                   v_Zymosis                  varchar,
                                   v_Hurt_Toxicosis_Ele       varchar,
                                   v_ZymosisState             varchar,
                                   o_result                   OUT empcurtyp);

  /*修改病案首页信息*/
  PROCEDURE usp_Upateiembasicinfo(v_iem_mainpage_no varchar,
                                  v_patnoofhis      varchar,
                                  v_noofinpat       integer,
                                  v_payid           VARCHAR,
                                  v_socialcare      VARCHAR,
                                  
                                  v_incount VARCHAR,
                                  v_name    VARCHAR,
                                  v_sexid   VARCHAR,
                                  v_birth   VARCHAR,
                                  v_marital VARCHAR,
                                  
                                  v_jobid         VARCHAR,
                                  v_provinceid    VARCHAR,
                                  v_countyid      VARCHAR,
                                  v_nationid      VARCHAR,
                                  v_nationalityid VARCHAR,
                                  
                                  v_idno         VARCHAR,
                                  v_organization VARCHAR,
                                  v_officeplace  VARCHAR,
                                  v_officetel    VARCHAR,
                                  v_officepost   VARCHAR,
                                  
                                  v_nativeaddress VARCHAR,
                                  v_nativetel     VARCHAR,
                                  v_nativepost    VARCHAR,
                                  v_contactperson VARCHAR,
                                  v_relationship  VARCHAR,
                                  
                                  v_contactaddress VARCHAR,
                                  v_contacttel     VARCHAR,
                                  v_admitdate      VARCHAR,
                                  v_admitdept      VARCHAR,
                                  v_admitward      VARCHAR,
                                  
                                  v_days_before           VARCHAR,
                                  v_trans_date            VARCHAR,
                                  v_trans_admitdept       VARCHAR,
                                  v_trans_admitward       VARCHAR,
                                  v_trans_admitdept_again VARCHAR,
                                  
                                  v_outwarddate VARCHAR,
                                  v_outhosdept  VARCHAR,
                                  v_outhosward  VARCHAR,
                                  v_actual_days VARCHAR,
                                  v_death_time  VARCHAR,
                                  
                                  v_death_reason VARCHAR,
                                  
                                  v_admitinfo                VARCHAR,
                                  v_in_check_date            VARCHAR,
                                  v_pathology_diagnosis_name VARCHAR,
                                  v_pathology_observation_sn VARCHAR,
                                  v_ashes_diagnosis_name     VARCHAR,
                                  v_ashes_anatomise_sn       VARCHAR,
                                  v_allergic_drug            VARCHAR,
                                  v_hbsag                    VARCHAR,
                                  v_hcv_ab                   VARCHAR,
                                  v_hiv_ab                   VARCHAR,
                                  v_opd_ipd_id               VARCHAR,
                                  v_in_out_inpatinet_id      VARCHAR,
                                  v_before_after_or_id       VARCHAR,
                                  v_clinical_pathology_id    VARCHAR,
                                  v_pacs_pathology_id        VARCHAR,
                                  v_save_times               VARCHAR,
                                  v_success_times            VARCHAR,
                                  v_section_director         VARCHAR,
                                  v_director                 VARCHAR,
                                  v_vs_employee_code         VARCHAR,
                                  v_resident_employee_code   VARCHAR,
                                  v_refresh_employee_code    VARCHAR,
                                  v_master_interne           VARCHAR,
                                  v_interne                  VARCHAR,
                                  v_coding_user              VARCHAR,
                                  v_medical_quality_id       VARCHAR,
                                  v_quality_control_doctor   VARCHAR,
                                  v_quality_control_nurse    VARCHAR,
                                  v_quality_control_date     VARCHAR,
                                  v_xay_sn                   VARCHAR,
                                  v_ct_sn                    VARCHAR,
                                  v_mri_sn                   VARCHAR,
                                  v_dsa_sn                   VARCHAR,
                                  v_is_first_case            VARCHAR,
                                  v_is_following             VARCHAR,
                                  v_following_ending_date    VARCHAR,
                                  v_is_teaching_case         VARCHAR,
                                  v_blood_type_id            VARCHAR,
                                  v_rh                       VARCHAR,
                                  v_blood_reaction_id        VARCHAR,
                                  v_blood_rbc                VARCHAR,
                                  v_blood_plt                VARCHAR,
                                  v_blood_plasma             VARCHAR,
                                  v_blood_wb                 VARCHAR,
                                  
                                  v_blood_others   VARCHAR,
                                  v_is_completed   VARCHAR,
                                  v_completed_time VARCHAR,
                                  
                                  v_Zymosis            varchar,
                                  v_Hurt_Toxicosis_Ele varchar,
                                  v_ZymosisState       varchar,
                                  o_result             OUT empcurtyp);

  /*
  * 插入功病案首页诊断TABLE
  */
  PROCEDURE usp_insert_iem_mainpage_diag(v_iem_mainpage_no   VARCHAR,
                                         v_diagnosis_type_id VARCHAR,
                                         v_diagnosis_code    VARCHAR,
                                         v_diagnosis_name    VARCHAR,
                                         v_status_id         VARCHAR,
                                         v_order_value       VARCHAR,
                                         --v_Valide numeric ,
                                         v_create_user VARCHAR
                                         --v_Create_Time varchar(19) ,
                                         --v_Cancel_User varchar(10) ,
                                         --v_Cancel_Time varchar(19)
                                         );

  /*
  * 插入功病案首页手术TABLE
  */
  PROCEDURE usp_insert_iem_mainpage_oper(v_iem_mainpage_no     NUMERIC,
                                         v_operation_code      VARCHAR,
                                         v_operation_date      VARCHAR,
                                         v_operation_name      VARCHAR,
                                         v_execute_user1       VARCHAR,
                                         v_execute_user2       VARCHAR,
                                         v_execute_user3       VARCHAR,
                                         v_anaesthesia_type_id NUMERIC,
                                         v_close_level         NUMERIC,
                                         v_anaesthesia_user    VARCHAR,
                                         --v_Valide numeric ,
                                         v_create_user VARCHAR
                                         --v_Create_Time varchar(19)
                                         --v_Cancel_User varchar(10) ,
                                         --v_Cancel_Time varchar(19)
                                         );
  /*
  * 插入功病案首页 产妇婴儿信息
  */
  PROCEDURE usp_insert_iem_main_ObsBaby(v_iem_mainpage_no NUMERIC,
                                        v_IBSBABYID       VARCHAR, --编号
                                        v_TC              VARCHAR, --胎次
                                        v_CC              VARCHAR, -- 产次
                                        v_TB              VARCHAR, -- 胎别
                                        v_CFHYPLD         VARCHAR, --产妇会阴破裂度
                                        v_MIDWIFERY       VARCHAR, --接产者
                                        v_SEX             VARCHAR, --性别
                                        v_APJ             VARCHAR, -- 阿帕加评加
                                        v_HEIGH           VARCHAR, --身长
                                        v_WEIGHT          VARCHAR, --体重
                                        v_CCQK            VARCHAR, --产出情况
                                        v_BITHDAY         VARCHAR, --出生时间
                                        v_FMFS            VARCHAR, --     分娩方式
                                        v_CYQK            VARCHAR,
                                        v_create_user     VARCHAR);

  /*
  * 插入一条病人信息
  */
  PROCEDURE usp_insertpatientinfo(v_noofinpat       varchar,
                                  v_patnoofhis      VARCHAR,
                                  v_Noofclinic      VARCHAR,
                                  v_Noofrecord      VARCHAR,
                                  v_patid           VARCHAR,
                                  v_Innerpix        VARCHAR,
                                  v_outpix          VARCHAR,
                                  v_Name            VARCHAR,
                                  v_py              VARCHAR,
                                  v_wb              VARCHAR,
                                  v_payid           VARCHAR,
                                  v_ORIGIN          VARCHAR,
                                  v_InCount         int DEFAULT 0,
                                  v_sexid           VARCHAR,
                                  v_Birth           VARCHAR,
                                  v_Age             int DEFAULT 0,
                                  v_AgeStr          VARCHAR,
                                  v_IDNO            VARCHAR,
                                  v_Marital         VARCHAR,
                                  v_JobID           VARCHAR,
                                  v_CSDProvinceID   VARCHAR,
                                  v_CSDCityID       VARCHAR,
                                  v_CSDDistrictID   VARCHAR,
                                  v_NationID        VARCHAR,
                                  v_NationalityID   VARCHAR,
                                  v_JGProvinceID    VARCHAR,
                                  v_JGCityID        VARCHAR,
                                  v_Organization    VARCHAR,
                                  v_OfficePlace     VARCHAR,
                                  v_OfficeTEL       VARCHAR,
                                  v_OfficePost      VARCHAR,
                                  v_HKDZProvinceID  VARCHAR,
                                  v_HKDZCityID      VARCHAR,
                                  v_HKDZDistrictID  VARCHAR,
                                  v_NATIVEPOST      VARCHAR,
                                  v_NATIVETEL       VARCHAR,
                                  v_NATIVEADDRESS   VARCHAR,
                                  v_ADDRESS         VARCHAR,
                                  v_ContactPerson   VARCHAR,
                                  v_RelationshipID  VARCHAR,
                                  v_ContactAddress  VARCHAR,
                                  v_ContactTEL      VARCHAR,
                                  v_CONTACTOFFICE   VARCHAR,
                                  v_CONTACTPOST     VARCHAR,
                                  v_OFFERER         VARCHAR,
                                  v_SocialCare      VARCHAR,
                                  v_INSURANCE       VARCHAR,
                                  v_CARDNO          VARCHAR,
                                  v_ADMITINFO       VARCHAR,
                                  v_AdmitDeptID     VARCHAR,
                                  v_AdmitWardID     VARCHAR,
                                  v_ADMITBED        VARCHAR,
                                  v_AdmitDate       VARCHAR,
                                  v_INWARDDATE      VARCHAR,
                                  v_ADMITDIAGNOSIS  VARCHAR,
                                  v_OutWardDate     VARCHAR,
                                  v_OutHosDeptID    VARCHAR,
                                  v_OutHosWardID    VARCHAR,
                                  v_OutBed          VARCHAR,
                                  v_OUTHOSDATE      VARCHAR,
                                  v_OUTDIAGNOSIS    VARCHAR,
                                  v_TOTALDAYS       int DEFAULT 0,
                                  v_CLINICDIAGNOSIS VARCHAR,
                                  v_SOLARTERMS      VARCHAR,
                                  v_ADMITWAY        VARCHAR,
                                  v_OUTWAY          VARCHAR,
                                  v_CLINICDOCTOR    VARCHAR,
                                  v_RESIDENT        VARCHAR,
                                  v_ATTEND          VARCHAR,
                                  v_CHIEF           VARCHAR,
                                  v_EDU             VARCHAR,
                                  v_EDUC            int DEFAULT 0,
                                  v_RELIGION        VARCHAR,
                                  v_STATUS          int DEFAULT 0,
                                  v_CRITICALLEVEL   VARCHAR,
                                  v_ATTENDLEVEL     VARCHAR,
                                  v_EMPHASIS        int DEFAULT 0,
                                  v_ISBABY          int DEFAULT 0,
                                  v_MOTHER          NUMERIC,
                                  v_MEDICAREID      VARCHAR,
                                  v_MEDICAREQUOTA   int DEFAULT 0,
                                  v_VOUCHERSCODE    VARCHAR,
                                  v_STYLE           VARCHAR,
                                  v_OPERATOR        VARCHAR,
                                  v_MEMO            VARCHAR,
                                  v_CPSTATUS        int DEFAULT 0,
                                  v_OUTWARDBED      int DEFAULT 0,
                                  v_XZZProvinceID   VARCHAR,
                                  v_XZZCityID       VARCHAR,
                                  v_XZZDistrictID   VARCHAR,
                                  v_XZZTEL          VARCHAR,
                                  v_XZZPost         VARCHAR);

  /*
  * 捞出所有的数据供报表设计器打印
  */
  PROCEDURE usp_get_iem_mainpage_all(
                                     --      v_noofinpat             VARCHAR,
                                     o_result  OUT empcurtyp,
                                     o_result1 OUT empcurtyp,
                                     o_result2 OUT empcurtyp);

  /*
  * 获取病案首页信息
  */
  PROCEDURE usp_GetIemInfo_new(v_NoOfInpat int,
                               o_result    OUT empcurtyp,
                               o_result1   OUT empcurtyp,
                               o_result2   OUT empcurtyp,
                               o_result3   OUT empcurtyp);

  /*
  * 维护病案首页信息
  */
  PROCEDURE usp_Edit_Iem_BasicInfo_2012(v_edittype        varchar2 default '',
                                        v_IEM_MAINPAGE_NO varchar2 default '', ---- '病案首页标识';
                                        v_PATNOOFHIS      varchar2 default '', ---- '病案号';
                                        v_NOOFINPAT       varchar2 default '', ---- '病人首页序号';
                                        v_PAYID           varchar2 default '', ---- '医疗付款方式ID';
                                        v_SOCIALCARE      varchar2 default '', ---- '社保卡号';
                                        
                                        v_INCOUNT varchar2 default '', ---- '入院次数';
                                        v_NAME    varchar2 default '', ---- '患者姓名';
                                        v_SEXID   varchar2 default '', ---- '性别';
                                        v_BIRTH   varchar2 default '', ---- '出生';
                                        v_MARITAL varchar2 default '', ---- '婚姻状况 1.未婚 2.已婚 3.丧偶4.离婚 9.其他';
                                        
                                        v_JOBID         varchar2 default '', ---- '职业';
                                        v_NATIONALITYID varchar2 default '', ---- '国籍ID';
                                        v_NATIONID      varchar2 default '', --民族
                                        v_IDNO          varchar2 default '', ---- '身份证号码';
                                        v_ORGANIZATION  varchar2 default '', ---- '工作单位';
                                        v_OFFICEPLACE   varchar2 default '', ---- '工作单位地址';
                                        
                                        v_OFFICETEL      varchar2 default '', ---- '工作单位电话';
                                        v_OFFICEPOST     varchar2 default '', ---- '工作单位邮编';
                                        v_CONTACTPERSON  varchar2 default '', ---- '联系人姓名';
                                        v_RELATIONSHIP   varchar2 default '', ---- '与联系人关系';
                                        v_CONTACTADDRESS varchar2 default '', ---- '联系人地址';
                                        
                                        v_CONTACTTEL varchar2 default '', ---- '联系人电话';
                                        v_ADMITDATE  varchar2 default '', ---- '入院时间';
                                        v_ADMITDEPT  varchar2 default '', ---- '入院科室';
                                        v_ADMITWARD  varchar2 default '', ---- '入院病区';
                                        v_TRANS_DATE varchar2 default '', ---- '转院时间';
                                        
                                        v_TRANS_ADMITDEPT varchar2 default '', ---- '转院科别';
                                        v_TRANS_ADMITWARD varchar2 default '', ---- '转院病区';
                                        v_OUTWARDDATE     varchar2 default '', ---- '出院时间';
                                        v_OUTHOSDEPT      varchar2 default '', ---- '出院科室';
                                        v_OUTHOSWARD      varchar2 default '', ---- '出院病区';
                                        
                                        v_ACTUALDAYS               varchar2 default '', ---- '实际住院天数';
                                        v_PATHOLOGY_DIAGNOSIS_NAME varchar2 default '', ---- '病理诊断名称';
                                        v_PATHOLOGY_OBSERVATION_SN varchar2 default '', ---- '病理检查号 ';
                                        v_ALLERGIC_DRUG            varchar2 default '', ---- '过敏药物';
                                        v_SECTION_DIRECTOR         varchar2 default '', ---- '科主任';
                                        
                                        v_DIRECTOR               varchar2 default '', ---- '主（副主）任医师';
                                        v_VS_EMPLOYEE_CODE       varchar2 default '', ---- '主治医师';
                                        v_RESIDENT_EMPLOYEE_CODE varchar2 default '', ---- '住院医师';
                                        v_REFRESH_EMPLOYEE_CODE  varchar2 default '', ---- '进修医师';
                                        v_DUTY_NURSE             varchar2 default '', ---- '责任护士';
                                        
                                        v_INTERNE                varchar2 default '', ---- '实习医师';
                                        v_CODING_USER            varchar2 default '', ---- '编码员';
                                        v_MEDICAL_QUALITY_ID     varchar2 default '', ---- '病案质量';
                                        v_QUALITY_CONTROL_DOCTOR varchar2 default '', ---- '质控医师';
                                        v_QUALITY_CONTROL_NURSE  varchar2 default '', ---- '质控护士';
                                        
                                        v_QUALITY_CONTROL_DATE varchar2 default '', ---- '质控时间';
                                        v_XAY_SN               varchar2 default '', ---- 'x线检查号';
                                        v_CT_SN                varchar2 default '', ---- 'CT检查号';
                                        v_MRI_SN               varchar2 default '', ---- 'mri检查号';
                                        v_DSA_SN               varchar2 default '', ---- 'Dsa检查号';
                                        
                                        v_BLOODTYPE      varchar2 default '', ---- '血型';
                                        v_RH             varchar2 default '', ---- 'Rh';
                                        v_IS_COMPLETED   varchar2 default '', ---- '完成否 y/n ';
                                        v_COMPLETED_TIME varchar2 default '', ---- '完成时间';
                                        v_VALIDE         varchar2 default '1', ---- '作废否 1/0';
                                        
                                        v_CREATE_USER   varchar2 default '', ---- '创建此记录者';
                                        v_CREATE_TIME   varchar2 default '', ---- '创建时间';
                                        v_MODIFIED_USER varchar2 default '', ---- '修改此记录者';
                                        v_MODIFIED_TIME varchar2 default '', ---- '修改时间';
                                        v_ZYMOSIS       varchar2 default '', ---- '医院传染病';
                                        
                                        v_HURT_TOXICOSIS_ELE_ID   varchar2 default '', ---- '损伤、中毒的外部因素';
                                        v_HURT_TOXICOSIS_ELE_Name varchar2 default '', ---- '损伤、中毒的外部因素';
                                        v_ZYMOSISSTATE            varchar2 default '', ---- '医院传染病状态';
                                        v_PATHOLOGY_DIAGNOSIS_ID  varchar2 default '', ---- '病理诊断编号';
                                        v_MONTHAGE                varchar2 default '', ---- '（年龄不足1周岁的） 年龄(月)';
                                        v_WEIGHT                  varchar2 default '', ---- '新生儿出生体重(克)';
                                        
                                        v_INWEIGHT         varchar2 default '', ---- '新生儿入院体重(克)';
                                        v_INHOSTYPE        varchar2 default '', ---- '入院途径:1.急诊  2.门诊  3.其他医疗机构转入  9.其他';
                                        v_OUTHOSTYPE       varchar2 default '', ---- '离院方式 □ 1.医嘱离院  2.医嘱转院 3.医嘱转社区卫生服务机构/乡镇卫生院 4.非医嘱离院5.死亡9.其他';
                                        v_RECEIVEHOSPITAL  varchar2 default '', ---- '2.医嘱转院，拟接收医疗机构名称：';
                                        v_RECEIVEHOSPITAL2 varchar2 default '', ---- '3.医嘱转社区卫生服务机构/乡镇卫生院，拟接收医疗机构名;
                                        
                                        v_AGAININHOSPITAL       varchar2 default '', ---- '是否有出院31天内再住院计划 □ 1.无  2.有';
                                        v_AGAININHOSPITALREASON varchar2 default '', ---- '出院31天内再住院计划 目的:            ';
                                        v_BEFOREHOSCOMADAY      varchar2 default '', ---- '颅脑损伤患者昏迷时间： 入院前    天';
                                        v_BEFOREHOSCOMAHOUR     varchar2 default '', ---- '颅脑损伤患者昏迷时间： 入院前     小时';
                                        v_BEFOREHOSCOMAMINUTE   varchar2 default '', ---- '颅脑损伤患者昏迷时间： 入院前    分钟';
                                        
                                        v_LATERHOSCOMADAY    varchar2 default '', ---- '颅脑损伤患者昏迷时间： 入院后    天';
                                        v_LATERHOSCOMAHOUR   varchar2 default '', ---- '颅脑损伤患者昏迷时间： 入院后    小时';
                                        v_LATERHOSCOMAMINUTE varchar2 default '', ---- '颅脑损伤患者昏迷时间： 入院后    分钟';
                                        v_CARDNUMBER         varchar2 default '', ---- '健康卡号';
                                        v_ALLERGIC_FLAG      varchar2 default '', ---- '药物过敏1.无 2.有';
                                        
                                        v_AUTOPSY_FLAG     varchar2 default '', ---- '死亡患者尸检 □ 1.是  2.否';
                                        v_CSD_PROVINCEID   varchar2 default '', ---- '出生地 省';
                                        v_CSD_CITYID       varchar2 default '', ---- '出生地 市';
                                        v_CSD_DISTRICTID   varchar2 default '', ---- '出生地 县';
                                        v_CSD_PROVINCENAME varchar2 default '', ---- '出生地 省名称';
                                        
                                        v_CSD_CITYNAME     varchar2 default '', ---- '出生地 市名称';
                                        v_CSD_DISTRICTNAME varchar2 default '', ---- '出生地 县名称';
                                        v_XZZ_PROVINCEID   varchar2 default '', ---- '现住址 省';
                                        v_XZZ_CITYID       varchar2 default '', ---- '现住址 市';
                                        v_XZZ_DISTRICTID   varchar2 default '', ---- '现住址 县';
                                        
                                        v_XZZ_PROVINCENAME varchar2 default '', ---- '现住址 省名称';
                                        v_XZZ_CITYNAME     varchar2 default '', ---- '现住址 市名称';
                                        v_XZZ_DISTRICTNAME varchar2 default '', ---- '现住址 县名称';
                                        v_XZZ_TEL          varchar2 default '', ---- '现住址 电话';
                                        v_XZZ_POST         varchar2 default '', ---- '现住址 邮编';
                                        
                                        v_HKDZ_PROVINCEID   varchar2 default '', ---- '户口地址 省';
                                        v_HKDZ_CITYID       varchar2 default '', ---- '户口地址 市';
                                        v_HKDZ_DISTRICTID   varchar2 default '', ---- '户口地址 县';
                                        v_HKDZ_PROVINCENAME varchar2 default '', ---- '户口地址 省名称';
                                        v_HKDZ_CITYNAME     varchar2 default '', ---- '户口地址 市名称';
                                        
                                        v_HKDZ_DISTRICTNAME     varchar2 default '', ---- '户口地址 县名称';
                                        v_HKDZ_POST             varchar2 default '', ---- '户口所在地邮编';
                                        v_JG_PROVINCEID         varchar2 default '', ---- '籍贯 省名称';
                                        v_JG_CITYID             varchar2 default '', ---- '籍贯 市名称';
                                        v_JG_PROVINCENAME       varchar2 default '', ---- '籍贯 省名称';
                                        v_JG_CITYNAME           varchar2 default '', ---- '籍贯 市名称'
                                        v_Age                   varchar2 default '',
                                        v_zg_flag               varchar2 default '', -----转归：□ 1.治愈 2.好转 3.未愈 4.死亡 5.其他
                                        v_admitinfo             varchar2 default '', --  v入院病情□ 1.危 2.重 3.一般 4.急 add 二〇一二年六月二十六日 10:14:09
                                        v_CSDADDRESS            varchar2 default '', --出生地具体地址 add by ywk 2012年7月11日 10:13:49
                                        v_JGADDRESS             varchar2 default '', --籍贯地址具体地址 add by ywk 2012年7月11日 10:13:49
                                        v_XZZADDRESS            varchar2 default '', --现住址具体地址 add by ywk 2012年7月11日 10:13:49
                                        v_HKDZADDRESS           varchar2 default '', --户口地址具体地址 add by ywk 2012年7月11日 10:13:49
                                        v_MenAndInHop           varchar, --门诊和住院
                                        v_InHopAndOutHop        varchar, --入院和出院
                                        v_BeforeOpeAndAfterOper varchar, --术前和术后
                                        v_LinAndBingLi          varchar, --临床与病理
                                        v_InHopThree            varchar, --入院三日内
                                        v_FangAndBingLi         varchar, --放射和病理
                                        o_result                OUT empcurtyp);

  /*
  *查询病案首页信息
  **********/
  PROCEDURE usp_getieminfo_2012(v_noofinpat INT,
                                o_result    OUT empcurtyp,
                                o_result1   OUT empcurtyp,
                                o_result2   OUT empcurtyp,
                                o_result3   OUT empcurtyp,
                                o_result4   OUT empcurtyp);

  PROCEDURE usp_edit_iem_mainpage_oper2012(v_iem_mainpage_no     NUMERIC,
                                           v_operation_code      VARCHAR,
                                           v_operation_date      VARCHAR,
                                           v_operation_name      VARCHAR,
                                           v_execute_user1       VARCHAR,
                                           v_execute_user2       VARCHAR,
                                           v_execute_user3       VARCHAR,
                                           v_anaesthesia_type_id NUMERIC,
                                           v_close_level         NUMERIC,
                                           v_anaesthesia_user    VARCHAR,
                                           --v_Valide numeric ,
                                           v_create_user     VARCHAR,
                                           v_OPERATION_LEVEL varchar,
                                           v_IsChooseDate    varchar, --手术相关字段
                                           v_IsClearOpe      varchar,
                                           v_IsGanRan        varchar,
                                           v_anesthesia_level varchar,
                                           v_opercomplication_code varchar
                                           
                                           --v_Create_Time varchar(19)
                                           --v_Cancel_User varchar(10) ,
                                           --v_Cancel_Time varchar(19)
                                           );

 PROCEDURE usp_edif_iem_mainpage_diag2012(v_iem_mainpage_no   VARCHAR,
                                           v_diagnosis_type_id VARCHAR,
                                           v_diagnosis_code    VARCHAR,
                                           v_diagnosis_name    VARCHAR,
                                           v_status_id         VARCHAR,
                                           v_order_value       VARCHAR,
                                           --v_Valide numeric ,
                                           v_create_user           VARCHAR,
                                           v_MenAndInHop           varchar, --门诊和住院
                                           v_InHopAndOutHop        varchar, --入院和出院
                                           v_BeforeOpeAndAfterOper varchar, --术前和术后
                                           v_LinAndBingLi          varchar, --临床与病理
                                           v_InHopThree            varchar, --入院三日内
                                           v_FangAndBingLi         varchar, --放射和病理
                                           v_AdmitInfo             varchar --子入院病情
                                           --v_Create_Time varchar(19) ,
                                           --v_Cancel_User varchar(10) ,
                                           --v_Cancel_Time varchar(19)
                                           );
                                           
 ------------------------湖北首页专用存储过程 add jxh-----------------------------------------------------------------------------------------------
  PROCEDURE usp_edif_iem_mainpage_diag_hb(v_iem_mainpage_no   VARCHAR,
                                           v_diagnosis_type_id VARCHAR,
                                           v_diagnosis_code    VARCHAR,
                                           v_diagnosis_name    VARCHAR,
                                           v_status_id         VARCHAR,
                                           v_order_value       VARCHAR,
                                           v_morphologyicd     VARCHAR,--形态学诊断编码
                                           v_morphologyname    VARCHAR,--形态学诊断名称                                 
                                           --v_Valide numeric ,
                                           v_create_user           VARCHAR,
                                           v_MenAndInHop           varchar, --门诊和住院
                                           v_InHopAndOutHop        varchar, --入院和出院
                                           v_BeforeOpeAndAfterOper varchar, --术前和术后
                                           v_LinAndBingLi          varchar, --临床与病理
                                           v_InHopThree            varchar, --入院三日内
                                           v_FangAndBingLi         varchar, --放射和病理
                                           v_AdmitInfo             varchar --子入院病情 
                                           --v_Create_Time varchar(19) ,
                                           --v_Cancel_User varchar(10) ,
                                           --v_Cancel_Time varchar(19)
                                           );                                         

  --更新病案首页信息后，对病人信息表进行数据同步 add by ywk 二〇一二年五月四日 15:20:27
  PROCEDURE usp_Edit_Iem_PaientInfo(v_NOOFINPAT      varchar2 default '', ---- '病人首页序号';
                                    v_NAME           varchar2 default '', ---- '患者姓名';
                                    v_SEXID          varchar2 default '', ---- '性别';
                                    v_BIRTH          varchar2 default '', ---- '出生';
                                    v_Age            INTEGER default '', --年龄
                                    v_IDNO           varchar2 default '', ---- '身份证号码';
                                    v_MARITAL        varchar2 default '', ---- '婚姻状况 1.未婚 2.已婚 3.丧偶4.离婚 9.其他';
                                    v_JOBID          varchar2 default '', ---- '职业';
                                    v_CSD_PROVINCEID varchar2 default '', ---- '出生地 省';
                                    v_CSD_CITYID     varchar2 default '', ---- '出生地 市';
                                    v_NATIONID       varchar2 default '', --民族
                                    v_NATIONALITYID  varchar2 default '', ---- '国籍ID';
                                    v_JG_PROVINCEID  varchar2 default '', ---- '籍贯 省';
                                    v_JG_CITYID      varchar2 default '', ---- '籍贯 市';
                                    v_OFFICEPLACE    varchar2 default '', ---- '工作单位地址';
                                    v_OFFICETEL      varchar2 default '', ---- '工作单位电话';
                                    v_OFFICEPOST     varchar2 default '', ---- '工作单位邮编';
                                    v_HKDZ_POST      varchar2 default '', ---- '户口所在地邮编';
                                    v_CONTACTPERSON  varchar2 default '', ---- '联系人姓名';
                                    v_RELATIONSHIP   varchar2 default '', ---- '与联系人关系';
                                    v_CONTACTADDRESS varchar2 default '', ---- '联系人地址';
                                    v_CONTACTTEL     varchar2 default '', ---- '联系人电话';
                                    v_ADMITDEPT      varchar2 default '', ---- '入院科室';
                                    v_ADMITWARD      varchar2 default '', ---- '入院病区';
                                    v_ADMITDATE      varchar2 default '', ---- '入院时间';
                                    v_OUTWARDDATE    varchar2 default '', ---- '出院时间';
                                    v_OUTHOSDEPT     varchar2 default '', ---- '出院科室';
                                    v_OUTHOSWARD     varchar2 default '', ---- '出院病区';
                                    v_ACTUALDAYS     varchar2 default '', ---- '实际住院天数';
                                    v_AgeStr         varchar2 default '', ---- '年龄 精确到月天;2012年5月9日9:31:03 （杨维康 泗县修改）
                                    v_PatId          varchar2 default '', --新增的付款方式 add by ywk 2012年5月14日 16:02:13
                                    v_CardNo         varchar2 default '', --健康卡号
                                    
                                    -----add by ywk  2012年5月16日9:45:27 Inpatient表l里增加病案首页里相应的字段
                                    v_Districtid     varchar2 default '', --出生地‘县’
                                    v_xzzproviceid   varchar2 default '', --现在住址省
                                    v_xzzcityid      varchar2 default '', --现在住址市
                                    v_xzzdistrictid  varchar2 default '', --现在住址县
                                    v_xzztel         varchar2 default '', --现在住址电话
                                    v_hkdzproviceid  varchar2 default '', --户口住址省
                                    v_hkzdcityid     varchar2 default '', --户口住址市
                                    v_hkzddistrictid varchar2 default '', --户口住址县
                                    v_xzzpost        varchar2 default '', --现住址邮编
                                    v_isupdate       varchar2 default '', ---2012年5月24日 17:19:10 ywk 是否更新身份证号字段
                                    /*  v_csdprovicename   varchar2 default '',      --出生地省名称
                                                                                                                                                                                               v_csdcityname   varchar2 default '',      --出生地市名称
                                                                                                                                                                                               v_csddistrictname  varchar2 default '',---出生地县名称
                                                                                                                                                                                                 v_jgprovicename  varchar2 default '',---籍贯省名称
                                                                                                                                                                                                 v_jgcityname  varchar2 default '',---籍贯市名称
                                                                                                                                                                                                 v_xzzprovicename  varchar2 default '',---现住址省名称
                                                                                                                                                                                                   v_xzzcityname  varchar2 default '',---现住址市名称
                                                                                                                                                                                                    v_xzzdistrictname  varchar2 default '',---现住址县名称
                                                                                                                                                                                                    v_hkzzprovicename    varchar2 default '',---户口住址省名称
                                                                                                                                                                                               v_hkzzcityname      varchar2 default '',---户口住址市名称
                                                                                                                                                                                               v_hkzzdistrictname    varchar2 default ''---户口住址县名称*/
                                    v_CSDADDRESS  varchar2 default '', --出生地具体地址 add by ywk 2012年7月11日 10:13:49
                                    v_JGADDRESS   varchar2 default '', --籍贯地址具体地址 add by ywk 2012年7月11日 10:13:49
                                    v_XZZADDRESS  varchar2 default '', --现住址具体地址 add by ywk 2012年7月11日 10:13:49
                                    v_HKDZADDRESS varchar2 default '' --户口地址具体地址 add by ywk 2012年7月11日 10:13:49
                                    ,v_XZZDetailAddr varchar2 default '', --现住址详细地址(县级以下) add by cyq 2012-12-27
                                    v_HKDZDetailAddr varchar2 default '' --户口地址详细地址(县级以下) add by cyq 2012-12-27
                                    );

  --获得首页默认表里的数据
  --add by ywk 2012年5月17日 09:36:46

  PROCEDURE usp_GetDefaultInpatient(o_result OUT empcurtyp);
  --根据病案首页序号。取得病人的信息 用来填充病案首页
  PROCEDURE usp_GetInpatientByNo(v_noofinpat varchar2 default '',
                                 o_result    OUT empcurtyp);

  /*
  * 维护病案首页的费用信息
  add by ywk 2012年10月16日 19:29:53
  */
  PROCEDURE usp_editiem_mainpage_feeinfo(v_edittype        varchar2 default '',
                                         v_IEM_MAINPAGE_NO varchar2 default '', ---- '病案首页标识';
                                         v_TotalFee        varchar2 default '', ---- 总费用;
                                         v_OwnerFee        varchar2 default '', ---- '自付金额
                                         v_YbMedServFee    varchar2 default '', ---- 一般医疗服务费
                                         v_YbMedOperFee    varchar2 default '', ---- 一般治疗操作费
                                         v_NurseFee        varchar2 default '', ----护理费
                                         v_OtherInfo       varchar2 default '', ---- 综合类 其他费用
                                         v_BLZDFee         varchar2 default '', ---- 诊断类 病理诊断费
                                         v_SYSZDFee        varchar2 default '', ---- 实验室诊断费
                                         v_YXXZDFee        varchar2 default '', ----  诊断类 影像学诊断费
                                         v_LCZDItemFee     varchar2 default '', ----  诊断类 临床诊断项目费
                                         v_FSSZLItemFee    varchar2 default '', ----  非手术治疗项目费
                                         v_LCWLZLFee       varchar2 default '', ---- 治疗类 临床物理治疗费
                                         v_OperMedFee      varchar2 default '', ----治疗类 手术治疗费
                                         v_KFFee           varchar2 default '', ----康复类 康复费
                                         v_ZYZLFee         varchar2 default '', ----中医类 中医治疗费
                                         v_XYMedFee        varchar2 default '', ---西药类 西药费
                                         v_KJYWFee         varchar2 default '', ---西药类 抗菌药物费用
                                         v_ZCYFFee         varchar2 default '', ---中药类 中成药费
                                         v_ZCaoYFFee       varchar2 default '', ---中药类 中草药费
                                         v_BloodFee        varchar2 default '', ---血液和血液制品类 血费
                                         v_BDBLZPFFee      varchar2 default '', ---血液和血液制品类 白蛋白类制品费
                                         v_QDBLZPFFee      varchar2 default '', ---球蛋白类制品费
                                         v_NXYZLZPFFee     varchar2 default '', ---血液和血液制品类 凝血因子类制品费
                                         v_XBYZLZPFFee     varchar2 default '', ---细胞因子类制品费
                                         v_JCYYCXYYCLFFee  varchar2 default '', -- 检查用一次性医用材料费
                                         v_ZLYYCXYYCLFFee  varchar2 default '', -- /耗材类 治疗用一次性医用材料费
                                         v_SSYYCXYYCLFFee  varchar2 default '', -- 材类 手术用一次性医用材料费
                                         v_QTFee           varchar2 default '', -- 其他类：（24）其他费        
                                         v_Memo1           varchar2 default '', -- 预留字段   1    
                                         v_Memo2           varchar2 default '', -- 预留字段    2  
                                          v_Memo3           varchar2 default '', -- 预留字段     3 
                                          v_MaZuiFee           varchar2 default '', -- 麻醉费
                                         v_ShouShuFee           varchar2 default ''-- 手术费 
                                             
                                                                            );
                                                                            
  
  ----操作病案首页自动评分配置表                                                              
  procedure usp_operiem_mainpage_qc
  (
            v_OperType         varchar2 default '0',
            v_id               varchar2 default '0',
            v_tabletype        varchar2 default '0',
            v_fields           varchar2 default '',
            v_fieldsvalue      varchar2 default '',
            v_conditiontabletype         varchar2 default '',
            v_conditionfields            varchar2 default '',
            v_conditionfieldsvalue       varchar2 default '',
            v_REDUCTSCORE                varchar2 default '0',
            v_REDUCTREASON               varchar2 default '',
            v_VALIDE                     varchar2 default '0',
            o_result                     OUT empcurtyp
            
  );
  
  
 

END;
/

prompt
prompt Creating package IEM_MAIN_PAGE_SX
prompt =================================
prompt
CREATE OR REPLACE PACKAGE EMR.iem_main_page_sx IS
  TYPE empcurtyp IS REF CURSOR;

  /*
  * 插入功病案首页 产妇婴儿信息
  */
  PROCEDURE usp_insert_iem_main_ObsBaby(v_iem_mainpage_no NUMERIC,
                                        v_TC              VARCHAR, --胎次
                                        v_CC              VARCHAR, -- 产次
                                        v_TB              VARCHAR, -- 胎别
                                        v_CFHYPLD         VARCHAR, --产妇会阴破裂度
                                        v_MIDWIFERY       VARCHAR, --接产者
                                        v_SEX             VARCHAR, --性别
                                        v_APJ             VARCHAR, -- 阿帕加评加
                                        v_HEIGH           VARCHAR, --身长
                                        v_WEIGHT          VARCHAR, --体重
                                        v_CCQK            VARCHAR, --产出情况
                                        v_BITHDAY         VARCHAR, --出生时间
                                        v_FMFS            VARCHAR, --     分娩方式
                                        v_CYQK            VARCHAR,
                                        v_create_user     VARCHAR);

  /*
  * 维护病案首页信息 MOdify by xlb 2013-07-03 解决江西九江需求 新增字段
  */
  PROCEDURE usp_Edit_Iem_BasicInfo_sx(v_edittype        varchar2 default '',
                                      v_IEM_MAINPAGE_NO varchar2 default '', ---- '病案首页标识';
                                      v_PATNOOFHIS      varchar2 default '', ---- '病案号';
                                      v_NOOFINPAT       varchar2 default '', ---- '病人首页序号';
                                      v_PAYID           varchar2 default '', ---- '医疗付款方式ID';
                                      v_SOCIALCARE      varchar2 default '', ---- '社保卡号';
                                      
                                      v_INCOUNT varchar2 default '', ---- '入院次数';
                                      v_NAME    varchar2 default '', ---- '患者姓名';
                                      v_SEXID   varchar2 default '', ---- '性别';
                                      v_BIRTH   varchar2 default '', ---- '出生';
                                      v_MARITAL varchar2 default '', ---- '婚姻状况 1.未婚 2.已婚 3.丧偶4.离婚 9.其他';
                                      
                                      v_JOBID         varchar2 default '', ---- '职业';
                                      v_NATIONALITYID varchar2 default '', ---- '国籍ID';
                                      v_NATIONID      varchar2 default '', --民族
                                      v_IDNO          varchar2 default '', ---- '身份证号码';
                                      v_ORGANIZATION  varchar2 default '', ---- '工作单位';
                                      v_OFFICEPLACE   varchar2 default '', ---- '工作单位地址';
                                      
                                      v_OFFICETEL      varchar2 default '', ---- '工作单位电话';
                                      v_OFFICEPOST     varchar2 default '', ---- '工作单位邮编';
                                      v_CONTACTPERSON  varchar2 default '', ---- '联系人姓名';
                                      v_RELATIONSHIP   varchar2 default '', ---- '与联系人关系';
                                      v_CONTACTADDRESS varchar2 default '', ---- '联系人地址';
                                      
                                      v_CONTACTTEL varchar2 default '', ---- '联系人电话';
                                      v_ADMITDATE  varchar2 default '', ---- '入院时间';
                                      v_ADMITDEPT  varchar2 default '', ---- '入院科室';
                                      v_ADMITWARD  varchar2 default '', ---- '入院病区';
                                      v_TRANS_DATE varchar2 default '', ---- '转院时间';
                                      
                                      v_TRANS_ADMITDEPT varchar2 default '', ---- '转院科别';
                                      v_TRANS_ADMITWARD varchar2 default '', ---- '转院病区';
                                      v_OUTWARDDATE     varchar2 default '', ---- '出院时间';
                                      v_OUTHOSDEPT      varchar2 default '', ---- '出院科室';
                                      v_OUTHOSWARD      varchar2 default '', ---- '出院病区';
                                      
                                      v_ACTUALDAYS               varchar2 default '', ---- '实际住院天数';
                                      v_PATHOLOGY_DIAGNOSIS_NAME varchar2 default '', ---- '病理诊断名称';
                                      v_PATHOLOGY_OBSERVATION_SN varchar2 default '', ---- '病理检查号 ';
                                      v_ALLERGIC_DRUG            varchar2 default '', ---- '过敏药物';
                                      v_SECTION_DIRECTOR         varchar2 default '', ---- '科主任';
                                      
                                      v_DIRECTOR               varchar2 default '', ---- '主（副主）任医师';
                                      v_VS_EMPLOYEE_CODE       varchar2 default '', ---- '主治医师';
                                      v_RESIDENT_EMPLOYEE_CODE varchar2 default '', ---- '住院医师';
                                      v_REFRESH_EMPLOYEE_CODE  varchar2 default '', ---- '进修医师';
                                      v_DUTY_NURSE             varchar2 default '', ---- '责任护士';
                                      
                                      v_INTERNE                varchar2 default '', ---- '实习医师';
                                      v_CODING_USER            varchar2 default '', ---- '编码员';
                                      v_MEDICAL_QUALITY_ID     varchar2 default '', ---- '病案质量';
                                      v_QUALITY_CONTROL_DOCTOR varchar2 default '', ---- '质控医师';
                                      v_QUALITY_CONTROL_NURSE  varchar2 default '', ---- '质控护士';
                                      
                                      v_QUALITY_CONTROL_DATE varchar2 default '', ---- '质控时间';
                                      v_XAY_SN               varchar2 default '', ---- 'x线检查号';
                                      v_CT_SN                varchar2 default '', ---- 'CT检查号';
                                      v_MRI_SN               varchar2 default '', ---- 'mri检查号';
                                      v_DSA_SN               varchar2 default '', ---- 'Dsa检查号';
                                      
                                      v_BLOODTYPE      varchar2 default '', ---- '血型';
                                      v_RH             varchar2 default '', ---- 'Rh';
                                      v_IS_COMPLETED   varchar2 default '', ---- '完成否 y/n ';
                                      v_COMPLETED_TIME varchar2 default '', ---- '完成时间';
                                      v_VALIDE         varchar2 default '1', ---- '作废否 1/0';
                                      
                                      v_CREATE_USER   varchar2 default '', ---- '创建此记录者';
                                      v_CREATE_TIME   varchar2 default '', ---- '创建时间';
                                      v_MODIFIED_USER varchar2 default '', ---- '修改此记录者';
                                      v_MODIFIED_TIME varchar2 default '', ---- '修改时间';
                                      v_ZYMOSIS       varchar2 default '', ---- '医院传染病';
                                      
                                      v_HURT_TOXICOSIS_ELE_ID   varchar2 default '', ---- '损伤、中毒的外部因素';
                                      v_HURT_TOXICOSIS_ELE_Name varchar2 default '', ---- '损伤、中毒的外部因素';
                                      v_ZYMOSISSTATE            varchar2 default '', ---- '医院传染病状态';
                                      v_PATHOLOGY_DIAGNOSIS_ID  varchar2 default '', ---- '病理诊断编号';
                                      v_MONTHAGE                varchar2 default '', ---- '（年龄不足1周岁的） 年龄(月)';
                                      v_WEIGHT                  varchar2 default '', ---- '新生儿出生体重(克)';
                                      
                                      v_INWEIGHT         varchar2 default '', ---- '新生儿入院体重(克)';
                                      v_INHOSTYPE        varchar2 default '', ---- '入院途径:1.急诊  2.门诊  3.其他医疗机构转入  9.其他';
                                      v_OUTHOSTYPE       varchar2 default '', ---- '离院方式 □ 1.医嘱离院  2.医嘱转院 3.医嘱转社区卫生服务机构/乡镇卫生院 4.非医嘱离院5.死亡9.其他';
                                      v_RECEIVEHOSPITAL  varchar2 default '', ---- '2.医嘱转院，拟接收医疗机构名称：';
                                      v_RECEIVEHOSPITAL2 varchar2 default '', ---- '3.医嘱转社区卫生服务机构/乡镇卫生院，拟接收医疗机构名;
                                      
                                      v_AGAININHOSPITAL       varchar2 default '', ---- '是否有出院31天内再住院计划 □ 1.无  2.有';
                                      v_AGAININHOSPITALREASON varchar2 default '', ---- '出院31天内再住院计划 目的:            ';
                                      v_BEFOREHOSCOMADAY      varchar2 default '', ---- '颅脑损伤患者昏迷时间： 入院前    天';
                                      v_BEFOREHOSCOMAHOUR     varchar2 default '', ---- '颅脑损伤患者昏迷时间： 入院前     小时';
                                      v_BEFOREHOSCOMAMINUTE   varchar2 default '', ---- '颅脑损伤患者昏迷时间： 入院前    分钟';
                                      
                                      v_LATERHOSCOMADAY    varchar2 default '', ---- '颅脑损伤患者昏迷时间： 入院后    天';
                                      v_LATERHOSCOMAHOUR   varchar2 default '', ---- '颅脑损伤患者昏迷时间： 入院后    小时';
                                      v_LATERHOSCOMAMINUTE varchar2 default '', ---- '颅脑损伤患者昏迷时间： 入院后    分钟';
                                      v_CARDNUMBER         varchar2 default '', ---- '健康卡号';
                                      v_ALLERGIC_FLAG      varchar2 default '', ---- '药物过敏1.无 2.有';
                                      
                                      v_AUTOPSY_FLAG     varchar2 default '', ---- '死亡患者尸检 □ 1.是  2.否';
                                      v_CSD_PROVINCEID   varchar2 default '', ---- '出生地 省';
                                      v_CSD_CITYID       varchar2 default '', ---- '出生地 市';
                                      v_CSD_DISTRICTID   varchar2 default '', ---- '出生地 县';
                                      v_CSD_PROVINCENAME varchar2 default '', ---- '出生地 省名称';
                                      
                                      v_CSD_CITYNAME     varchar2 default '', ---- '出生地 市名称';
                                      v_CSD_DISTRICTNAME varchar2 default '', ---- '出生地 县名称';
                                      v_XZZ_PROVINCEID   varchar2 default '', ---- '现住址 省';
                                      v_XZZ_CITYID       varchar2 default '', ---- '现住址 市';
                                      v_XZZ_DISTRICTID   varchar2 default '', ---- '现住址 县';
                                      
                                      v_XZZ_PROVINCENAME varchar2 default '', ---- '现住址 省名称';
                                      v_XZZ_CITYNAME     varchar2 default '', ---- '现住址 市名称';
                                      v_XZZ_DISTRICTNAME varchar2 default '', ---- '现住址 县名称';
                                      v_XZZ_TEL          varchar2 default '', ---- '现住址 电话';
                                      v_XZZ_POST         varchar2 default '', ---- '现住址 邮编';
                                      
                                      v_HKDZ_PROVINCEID   varchar2 default '', ---- '户口地址 省';
                                      v_HKDZ_CITYID       varchar2 default '', ---- '户口地址 市';
                                      v_HKDZ_DISTRICTID   varchar2 default '', ---- '户口地址 县';
                                      v_HKDZ_PROVINCENAME varchar2 default '', ---- '户口地址 省名称';
                                      v_HKDZ_CITYNAME     varchar2 default '', ---- '户口地址 市名称';
                                      
                                      v_HKDZ_DISTRICTNAME varchar2 default '', ---- '户口地址 县名称';
                                      v_HKDZ_POST         varchar2 default '', ---- '户口所在地邮编';
                                      v_JG_PROVINCEID     varchar2 default '', ---- '籍贯 省名称';
                                      v_JG_CITYID         varchar2 default '', ---- '籍贯 市名称';
                                      v_JG_PROVINCENAME   varchar2 default '', ---- '籍贯 省名称';
                                      v_JG_CITYNAME       varchar2 default '', ---- '籍贯 市名称'
                                      v_Age               varchar2 default '',
                                      
                                      v_CURE_TYPE   VARCHAR2 default '', ----  Y    治疗类别 □ 1.中医（ 1.1 中医   1.2民族医）    2.中西医     3.西医
                                      v_MZZYZD_NAME VARCHAR2 default '', ---- Y   门（急）诊诊断（中医诊断）
                                      v_MZZYZD_CODE VARCHAR2 default '', ---- Y   门（急）诊诊断（中医诊断） 编码
                                      v_MZXYZD_NAME VARCHAR2 default '', ---- Y   门（急）诊诊断（西医诊断）
                                      v_MZXYZD_CODE VARCHAR2 default '', ---- Y   门（急）诊诊断（西医诊断） 编码
                                      v_SSLCLJ      VARCHAR2 default '', ---- Y   实施临床路径：□ 1. 中医  2. 西医  3 否
                                      v_ZYZJ        VARCHAR2 default '', ---- Y   使用医疗机构中药制剂：□ 1.是  2. 否
                                      
                                      v_ZYZLSB       VARCHAR2 default '', ---- Y   使用中医诊疗设备：□  1.是 2. 否
                                      v_ZYZLJS       VARCHAR2 default '', ---- Y   使用中医诊疗技术：□ 1. 是  2. 否
                                      v_BZSH         VARCHAR2 default '', ---- Y   辨证施护：□ 1.是  2. 否
                                      v_outHosStatus VARCHAR2 default '', ---出院状况
                                      v_JBYNZZ       VARCHAR2 default '',
                                      v_MZYCY        VARCHAR2 default '',
                                      v_InAndOutHos  VARCHAR2 default '',
                                      v_LCYBL        VARCHAR2 default '',
                                      v_FSYBL        VARCHAR2 default '',
                                      v_qJCount      VARCHAR2 default '',
                                      v_successCount VARCHAR2 default '',
                                      v_InPatLY      VARCHAR2 default '',
                                      v_asaScore     VARCHAR2 default '',
                                      o_result       OUT empcurtyp);

  /*
  *查询病案首页信息
  **********/
  ---Modify by xlb 2013-07-02 新增字段
  PROCEDURE usp_getieminfo_sx(v_noofinpat INT,
                              o_result    OUT empcurtyp,
                              o_result1   OUT empcurtyp,
                              o_result2   OUT empcurtyp,
                              o_result3   OUT empcurtyp,
                              o_result4   OUT empcurtyp);

  PROCEDURE usp_edit_iem_mainpage_oper_sx(v_iem_mainpage_no     NUMERIC,
                                          v_operation_code      VARCHAR,
                                          v_operation_date      VARCHAR,
                                          v_operation_name      VARCHAR,
                                          v_execute_user1       VARCHAR,
                                          v_execute_user2       VARCHAR,
                                          v_execute_user3       VARCHAR,
                                          v_anaesthesia_type_id NUMERIC,
                                          v_close_level         NUMERIC,
                                          v_anaesthesia_user    VARCHAR,
                                          --v_Valide numeric ,
                                          v_create_user     VARCHAR,
                                          v_OPERATION_LEVEL varchar,
                                          --v_Create_Time varchar(19)
                                          --v_Cancel_User varchar(10) ,
                                          v_OperInTimes VARCHAR2
                                          --v_Cancel_Time varchar(19)
                                          );

  PROCEDURE usp_edif_iem_mainpage_diag_sx(v_iem_mainpage_no   VARCHAR,
                                          v_diagnosis_type_id VARCHAR,
                                          v_diagnosis_code    VARCHAR,
                                          v_diagnosis_name    VARCHAR,
                                          v_status_id         VARCHAR,
                                          v_order_value       VARCHAR,
                                          --v_Valide numeric ,
                                          v_create_user VARCHAR,
                                          v_type        varchar,
                                          v_typeName    varchar
                                          --v_Create_Time varchar(19) ,
                                          --v_Cancel_User varchar(10) ,
                                          --v_Cancel_Time varchar(19)
                                          );

  --更新病案首页信息后，对病人信息表进行数据同步 add by ywk 二〇一二年五月四日 15:20:27
  PROCEDURE usp_Edit_Iem_PaientInfo_sx(v_NOOFINPAT      varchar2 default '', ---- '病人首页序号';
                                       v_NAME           varchar2 default '', ---- '患者姓名';
                                       v_SEXID          varchar2 default '', ---- '性别';
                                       v_BIRTH          varchar2 default '', ---- '出生';
                                       v_Age            INTEGER default 1, --年龄
                                       v_IDNO           varchar2 default '', ---- '身份证号码';
                                       v_MARITAL        varchar2 default '', ---- '婚姻状况 1.未婚 2.已婚 3.丧偶4.离婚 9.其他';
                                       v_JOBID          varchar2 default '', ---- '职业';
                                       v_CSD_PROVINCEID varchar2 default '', ---- '出生地 省';
                                       v_CSD_CITYID     varchar2 default '', ---- '出生地 市';
                                       v_NATIONID       varchar2 default '', --民族
                                       v_NATIONALITYID  varchar2 default '', ---- '国籍ID';
                                       v_JG_PROVINCEID  varchar2 default '', ---- '籍贯 省';
                                       v_JG_CITYID      varchar2 default '', ---- '籍贯 市';
                                       v_OFFICEPLACE    varchar2 default '', ---- '工作单位地址';
                                       v_OFFICETEL      varchar2 default '', ---- '工作单位电话';
                                       v_OFFICEPOST     varchar2 default '', ---- '工作单位邮编';
                                       v_HKDZ_POST      varchar2 default '', ---- '户口所在地邮编';
                                       v_CONTACTPERSON  varchar2 default '', ---- '联系人姓名';
                                       v_RELATIONSHIP   varchar2 default '', ---- '与联系人关系';
                                       v_CONTACTADDRESS varchar2 default '', ---- '联系人地址';
                                       v_CONTACTTEL     varchar2 default '', ---- '联系人电话';
                                       v_ADMITDEPT      varchar2 default '', ---- '入院科室';
                                       v_ADMITWARD      varchar2 default '', ---- '入院病区';
                                       v_ADMITDATE      varchar2 default '', ---- '入院时间';
                                       v_OUTWARDDATE    varchar2 default '', ---- '出院时间';
                                       v_OUTHOSDEPT     varchar2 default '', ---- '出院科室';
                                       v_OUTHOSWARD     varchar2 default '', ---- '出院病区';
                                       v_ACTUALDAYS     varchar2 default '', ---- '实际住院天数';
                                       v_AgeStr         varchar2 default '', ---- '年龄 精确到月天;2012年5月9日9:31:03 （杨维康 泗县修改）
                                       v_PatId          varchar2 default '', --新增的付款方式 add by ywk 2012年5月14日 16:02:13
                                       v_CardNo         varchar2 default '', --健康卡号
                                       -----add by ywk  2012年5月16日9:45:27 Inpatient表l里增加病案首页里相应的字段
                                       v_Districtid     varchar2 default '', --出生地‘县’
                                       v_xzzproviceid   varchar2 default '', --现在住址省
                                       v_xzzcityid      varchar2 default '', --现在住址市
                                       v_xzzdistrictid  varchar2 default '', --现在住址县
                                       v_xzztel         varchar2 default '', --现在住址电话
                                       v_hkdzproviceid  varchar2 default '', --户口住址省
                                       v_hkzdcityid     varchar2 default '', --户口住址市
                                       v_hkzddistrictid varchar2 default '', --户口住址县
                                       v_xzzpost        varchar2 default '', --现住址邮编
                                       v_isupdate       varchar2 default '' ---2012年5月24日 17:19:10 ywk 是否更新身份证号字段
                                       
                                       );

  --获得首页默认表里的数据
  --add by ywk 2012年5月17日 09:36:46

  PROCEDURE usp_GetDefaultInpatient(o_result OUT empcurtyp);

  --根据病案首页序号。取得病人的信息 用来填充病案首页
  PROCEDURE usp_GetInpatientByNo(v_noofinpat varchar2 default '',
                                 o_result    OUT empcurtyp);

  /*
  * 维护病案首页的费用信息
  add by ywk 2012年10月16日 19:29:53
  */
  PROCEDURE usp_editiem_mainpage_feeinfo(v_edittype        varchar2 default '',
                                         v_IEM_MAINPAGE_NO varchar2 default '', ---- '病案首页标识';
                                         v_TotalFee        varchar2 default '', ---- 总费用;
                                         v_OwnerFee        varchar2 default '', ---- '自付金额
                                         v_YbMedServFee    varchar2 default '', ---- 一般医疗服务费
                                         v_YbMedOperFee    varchar2 default '', ---- 一般治疗操作费
                                         v_NurseFee        varchar2 default '', ----护理费
                                         v_OtherInfo       varchar2 default '', ---- 综合类 其他费用
                                         v_BLZDFee         varchar2 default '', ---- 诊断类 病理诊断费
                                         v_SYSZDFee        varchar2 default '', ---- 实验室诊断费
                                         v_YXXZDFee        varchar2 default '', ----  诊断类 影像学诊断费
                                         v_LCZDItemFee     varchar2 default '', ----  诊断类 临床诊断项目费
                                         v_FSSZLItemFee    varchar2 default '', ----  非手术治疗项目费
                                         v_LCWLZLFee       varchar2 default '', ---- 治疗类 临床物理治疗费
                                         v_OperMedFee      varchar2 default '', ----治疗类 手术治疗费
                                         v_KFFee           varchar2 default '', ----康复类 康复费
                                         v_ZYZLFee         varchar2 default '', ----中医类 中医治疗费
                                         v_XYMedFee        varchar2 default '', ---西药类 西药费
                                         v_KJYWFee         varchar2 default '', ---西药类 抗菌药物费用
                                         v_ZCYFFee         varchar2 default '', ---中药类 中成药费
                                         v_ZCaoYFFee       varchar2 default '', ---中药类 中草药费
                                         v_BloodFee        varchar2 default '', ---血液和血液制品类 血费
                                         v_BDBLZPFFee      varchar2 default '', ---血液和血液制品类 白蛋白类制品费
                                         v_QDBLZPFFee      varchar2 default '', ---球蛋白类制品费
                                         v_NXYZLZPFFee     varchar2 default '', ---血液和血液制品类 凝血因子类制品费
                                         v_XBYZLZPFFee     varchar2 default '', ---细胞因子类制品费
                                         v_JCYYCXYYCLFFee  varchar2 default '', -- 检查用一次性医用材料费
                                         v_ZLYYCXYYCLFFee  varchar2 default '', -- /耗材类 治疗用一次性医用材料费
                                         v_SSYYCXYYCLFFee  varchar2 default '', -- 材类 手术用一次性医用材料费
                                         v_QTFee           varchar2 default '', -- 其他类：（24）其他费        
                                         v_Memo1           varchar2 default '', -- 预留字段   1    
                                         v_Memo2           varchar2 default '', -- 预留字段    2  
                                         v_Memo3           varchar2 default '', -- 预留字段     3 
                                         v_MaZuiFee        varchar2 default '', -- 麻醉费
                                         v_ShouShuFee      varchar2 default '' -- 手术费 
                                         
                                         );

  PROCEDURE usp_AddOrModIemFeeZY(v_id        varchar,
                                 v_NOOFINPAT varchar,
                                 v_TOTAL     varchar,
                                 v_OWNFEE    varchar,
                                 v_YBYLFY    varchar,
                                 v_ZYBZLZF   varchar,
                                 v_ZYBZLZHZF varchar,
                                 v_YBZLFY    varchar,
                                 v_CARE      varchar,
                                 v_ZHQTFY    varchar,
                                 v_BLZDF     varchar,
                                 v_SYSZDF    varchar,
                                 v_YXXZDF    varchar,
                                 v_LCZDF     varchar,
                                 v_FSSZLF    varchar,
                                 v_LCWLZLF   varchar,
                                 v_SSZLF     varchar,
                                 v_MZF       varchar,
                                 v_SSF       varchar,
                                 v_KFF       varchar,
                                 v_ZYZDF     varchar,
                                 v_ZYZLF     varchar,
                                 v_ZYWZ      varchar,
                                 v_ZYGS      varchar,
                                 v_ZCYJF     varchar,
                                 v_ZYTNZL    varchar,
                                 v_ZYGCZL    varchar,
                                 v_ZYTSZL    varchar,
                                 v_ZYQT      varchar,
                                 v_ZYTSTPJG  varchar,
                                 v_BZSS      varchar,
                                 v_XYF       varchar,
                                 v_KJYWF     varchar,
                                 v_CPMEDICAL varchar,
                                 v_YLJGZYZJF varchar,
                                 v_CMEDICAL  varchar,
                                 v_BLOODFEE  varchar,
                                 v_XDBLZPF   varchar,
                                 v_QDBLZPF   varchar,
                                 v_NXYZLZPF  varchar,
                                 v_XBYZLZPF  varchar,
                                 v_JCYYCXCLF varchar,
                                 v_ZLYYCXCLF varchar,
                                 v_SSYYCXCLF varchar,
                                 v_OTHERFEE  varchar,
                                 v_VALID     varchar);

  PROCEDURE usp_GetIemFeeZYbyInpat(v_noofinpat varchar,
                                   o_result    OUT empcurtyp);

end;
/

prompt
prompt Creating package MAINPAGEEXTENSION
prompt ==================================
prompt
create or replace package emr.mainpageextension is

  -- Author  : xlb
  -- Created : 2013/4/10 16:51:22
  -- Purpose : 病案首页扩展功能包
  TYPE empcurtype IS REF CURSOR;

-------抓取扩展维护记录---------------------------------------------------------------------------------------
-------------Add by xlb 2013-04-10----------------------------------------------------------------------------
PROCEDURE GETIEMEXCEPT(
                       o_result out empcurtype
                      );

----新增或修改维护记录  Add by xlb 2013-04-11
PROCEDURE ADDORMODIFYIEMEXCEPT
                            (
                            v_iemexId         VARCHAR2,
                            v_iemexName       VARCHAR2,
                            v_dateElementFlow VARCHAR2,
                            v_iemControl      VARCHAR2,
                            v_iemOtherName    VARCHAR2,
                            v_orderCode       VARCHAR2,
                            v_isOtherLine     VARCHAR2,
                            v_valide          VARCHAR2,
                            v_createDocId     VARCHAR2,
                            v_createDateTime  CHAR,
                            v_modifyDocId     VARCHAR2,
                            v_modifyDateTime  VARCHAR2

                            );
 ---------------------------------新增或修改病案扩展维护功能编辑界面病人使用记录Add by xlb 2013-04-16--------
Procedure ADDORMODIFYIEMUS
                         (
                          v_iemExUserId   VARCHAR2,
                          v_iemExId       VARCHAR2,
                          v_nOofInpat     VARCHAR2,
                          v_value         VARCHAR2,
                          v_createDocId   VARCHAR2,
                          v_modifyDocId   VARCHAR2,
                          v_modifyDateTime CHAR
                          );
end;
/

prompt
prompt Creating package QUEST_SOO_ALERTTRACE
prompt =====================================
prompt
CREATE OR REPLACE PACKAGE EMR.quest_soo_alerttrace
AS
/******************************************************************************
   NAME:       quest_soo_alerttrace
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        30/10/2007  Joe Tyrrell      Initial Creation
******************************************************************************/

   --initializeLines
   PROCEDURE initializelines (p_lines NUMBER, p_chunksize NUMBER);

   --  Readfile

   -- Input paramters:
   --   p_filename
   --       NULL -- Alert Log File Name
   --
   --   p_nav
   --       0  --  previous,
   --       1  --  forward.
   --       2  --  Search by Bytes
   --      -1  --  reset a file.
   --      -2  --  reset all the files position.
   --     100  --  Start of the file
   --     101  --  End of the file
   --
   --   p_search
   --       NULL - No search
   --       If p_nav is 2 then it must be numeric.
   --
   --   p_casesensitive
   --       0 - No Case Sensitive
   --       1 - Case Sensitive
   --   r_read_seconds
   --       5 - Default number of seconds a string search
   --           will be performed on file.
   --           If no values are found in allocated time
   --           1 row will be returned with position, date, and 'STRING NOT FOUND' text

   FUNCTION readfile (
      p_filename        VARCHAR2 DEFAULT NULL,
      p_nav             NUMBER   DEFAULT 101,
      p_search          VARCHAR2 DEFAULT NULL,
      p_casesensitive   NUMBER   DEFAULT 0,
      p_read_seconds    NUMBER 	 DEFAULT 5
   )
      RETURN quest_soo_alerttrace_log_typ;

END quest_soo_alerttrace;
/

prompt
prompt Creating package QUEST_SOO_PKG
prompt ==============================
prompt
CREATE OR REPLACE PACKAGE EMR.QUEST_SOO_PKG
IS
--
-- This package contains routines to support Spotlight On Oracle
--
-- Person      Date    Comments
-- ---------   ------  -----------------------------------------------
-- Guy         7oct98  Initial
-- Megh        20Jun99 Added procedures obj_keep, obj_unkeep and
--                     flush_shared_pool. Also added function obj_type
-- Han B Xie   Jun2000 - now.

    -- Global indicating that the object cache is initialized
    g_object_cache_initialized     NUMBER:=0;
    g_debug                        NUMBER:=0;

    -- And make them global accessible
    /* -------------------------------------------------------------
    || The following statements define the "segment cache".  This
    || comprises a number of PL/SQL tables which contain details
    || of file/block ranges for all existing segments.
    ||
    || get_segname uses a binary chop to find the appropriate entry
    */ -------------------------------------------------------------
    TYPE object_cache_numtype       IS TABLE OF NUMBER      INDEX BY BINARY_INTEGER;
    TYPE object_cache_tabtype       IS TABLE OF VARCHAR(61) INDEX BY BINARY_INTEGER;

    object_cache_fileno             object_cache_numtype;
    object_cache_extno              object_cache_numtype;
    object_cache_blockno            object_cache_numtype;
    object_cache_length             object_cache_numtype;
    object_cache_segname            object_cache_tabtype;
    object_cache_count              NUMBER := 0;

    object_cache                    object_cache_tabtype;

    --
    -- Function to format SQL
    --
    Function format_sql ( p_sql_text IN varchar2,
                          p_max_len  IN number:=256)
             RETURN  varchar2;
    PRAGMA restrict_references(format_sql, WNDS, RNDS, WNPS, RNPS);

    --
    -- Event_category returns the event "category" so we can group
    -- like categories.  It's overloaded to accept either a event anme
    -- or the INDX from X$KSLEI
    --
    FUNCTION event_category(p_event varchar2, tag VARCHAR2 := 'pre 4.0') RETURN varchar2;
    PRAGMA   RESTRICT_REFERENCES (event_category, WNDS, RNDS, WNPS);

    FUNCTION event_category(p_indx number, tag VARCHAR2 := 'pre 4.0') RETURN varchar2;
    PRAGMA   RESTRICT_REFERENCES (event_category, WNDS, RNDS, WNPS);

    FUNCTION latch_category(p_latch_name varchar2) RETURN varchar2;
    PRAGMA   RESTRICT_REFERENCES (latch_category, WNDS, RNDS, WNPS);

    FUNCTION obj_type(object_t varchar2) RETURN char;
    PRAGMA   RESTRICT_REFERENCES (obj_type, WNDS, RNDS, WNPS);

    FUNCTION IsSpOk RETURN number;
    PRAGMA   RESTRICT_REFERENCES (IsSpOk, WNDS, WNPS);

    FUNCTION SgaOther RETURN number;
    PRAGMA   RESTRICT_REFERENCES (SgaOther, WNDS, WNPS);

    --
    -- Procedure initialize to initialize PL/SQL tables , etc
    --
    PROCEDURE initialize;

    -- Quick but essential initialize
    PROCEDURE initialize_fast;
    -- Slower initialize which can be defered until main screen collected
    PROCEDURE initialize_objects;

    -- Print the current lock-tree
    PROCEDURE locktree(p_agent_id VARCHAR2 DEFAULT 'N/A');

    -- Set a normal trace on for the session
    PROCEDURE set_trace(p_sid NUMBER, p_serial NUMBER, p_level NUMBER);

    -- overload for backward compatibility
    PROCEDURE set_trace(p_sid NUMBER, p_serial NUMBER, p_mode boolean);

    -- Kill the nominated session
    PROCEDURE kill_session(p_sid NUMBER, p_serial NUMBER);

    -- Turn timed statistics on
    PROCEDURE set_timed_statistics;

    -- Keep object in shared pool
    -- PROCEDURE obj_keep(name in varchar2, type in varchar2);

    -- Unkeep object from shared pool
    -- PROCEDURE obj_unkeep(name in varchar2, type in varchar2);

    -- Flush shared pool
    PROCEDURE flush_shared_pool;

    --
    -- Translate values in the form 999{K|M} to byte values so
    -- instance monitor can deal with them
    --

    FUNCTION TRANSLATE_PARAMETER( p_value VARCHAR2) RETURN  varchar2;

    PRAGMA  RESTRICT_REFERENCES (translate_parameter, WNDS, RNDS, WNPS);

    --
    -- These routines support the "show locked row" facility
    --
    --Published procedures
    --Show the row locks being waited for by the specified sid
    FUNCTION show_locked_row(lsid in number) return varchar2;
    FUNCTION toRadixString(num in number, radix in number) return varchar2;
    PRAGMA   restrict_references(toRadixString, WNDS, WNPS, RNDS, RNPS);
    FUNCTION digitToString(num in number) return varchar2;
    PRAGMA   restrict_references(digitToString, WNDS, WNPS, RNDS, RNPS);

    FUNCTION sga_cat(p_pool VARCHAR2, p_name VARCHAR2) RETURN VARCHAR2;
    PRAGMA   restrict_references(sga_cat, WNDS, RNDS, WNPS, RNPS);

    FUNCTION sga_cat2(p_pool VARCHAR2, p_name VARCHAR2) RETURN VARCHAR2;
    PRAGMA   restrict_references(sga_cat2, WNDS, RNDS, WNPS, RNPS);

    FUNCTION sga_pool7(p_name VARCHAR2) RETURN VARCHAR2;
    PRAGMA   restrict_references(sga_pool7, WNDS, RNDS, WNPS, RNPS);

    FUNCTION sga_area7(p_name VARCHAR2) RETURN VARCHAR2;
    PRAGMA   restrict_references(sga_area7, WNDS, RNDS, WNPS, RNPS);

    -- Stuff for getting full SQL text
    -- FUNCTION exact_db_version(p_major OUT NUMBER,
    --                          p_minor1 OUT NUMBER,
    --                          p_minor2 OUT NUMBER)
    --         RETURN VARCHAR2;
    --

    FUNCTION get_long_sqltext(p_hash_value NUMBER,
                              p_address RAW)
             RETURN VARCHAR2;

    FUNCTION get_session_long_sqltext(p_sid NUMBER)
             RETURN VARCHAR2;

    -- Decode lock details: TYPE, MODE, REQUEST
    FUNCTION lock_type_decode(type_p VARCHAR2, id2_p NUMBER default -1)
             RETURN VARCHAR2;
    PRAGMA restrict_references(lock_type_decode, WNDS, WNPS, RNPS);

    FUNCTION lock_mode_decode(mode_p NUMBER) RETURN VARCHAR2;
    PRAGMA   restrict_references(lock_mode_decode, WNDS, WNPS, RNPS);

    FUNCTION event_detail ( event_p  IN VARCHAR2,
                            p1text_p IN VARCHAR2, p1_p IN NUMBER,
                            p2text_p IN VARCHAR2 DEFAULT '', p2_p IN NUMBER DEFAULT 0,
                            p3text_p IN VARCHAR2 DEFAULT '', p3_p IN NUMBER DEFAULT 0) RETURN VARCHAR2;

    -- wait_detail is a quicker version of event_detail to be used in SELECT cluase.
    FUNCTION wait_detail ( event_p  IN VARCHAR2,
                           p1text_p IN VARCHAR2, p1_p IN NUMBER,
                           p2text_p IN VARCHAR2 DEFAULT '', p2_p IN NUMBER DEFAULT 0,
                           p3text_p IN VARCHAR2 DEFAULT '', p3_p IN NUMBER DEFAULT 0) RETURN VARCHAR2;
    PRAGMA   RESTRICT_REFERENCES (wait_detail, WNDS, WNPS);

    FUNCTION dataobj_object(dataobj_p NUMBER) RETURN VARCHAR2;

    FUNCTION job_interval(next_date_p DATE, interval_p VARCHAR2) RETURN DATE;

    --
    -- I18N versions
    --
    PROCEDURE locktree_41(p_agent_id VARCHAR2 DEFAULT 'N/A');
    FUNCTION show_locked_row_41(lsid in number) return varchar2;

    FUNCTION lock_type_decode_41(type_p VARCHAR2, id2_p NUMBER default -1)
             RETURN VARCHAR2;
    PRAGMA restrict_references(lock_type_decode_41, WNDS, WNPS, RNPS);

    FUNCTION lock_mode_decode_41(mode_p NUMBER) RETURN VARCHAR2;
    PRAGMA   restrict_references(lock_mode_decode_41, WNDS, WNPS, RNPS);

    FUNCTION event_detail_41 ( event_p  IN VARCHAR2,
                            p1text_p IN VARCHAR2, p1_p IN NUMBER,
                            p2text_p IN VARCHAR2 DEFAULT '', p2_p IN NUMBER DEFAULT 0,
                            p3text_p IN VARCHAR2 DEFAULT '', p3_p IN NUMBER DEFAULT 0) RETURN VARCHAR2;

    FUNCTION wait_detail_41 ( event_p  IN VARCHAR2,
                           p1text_p IN VARCHAR2, p1_p IN NUMBER,
                           p2text_p IN VARCHAR2 DEFAULT '', p2_p IN NUMBER DEFAULT 0,
                           p3text_p IN VARCHAR2 DEFAULT '', p3_p IN NUMBER DEFAULT 0) RETURN VARCHAR2;
    PRAGMA   RESTRICT_REFERENCES (wait_detail_41, WNDS, WNPS);

  PROCEDURE populate_event_table;
END;
/

prompt
prompt Creating package QUEST_SOO_SCHEMA_MGR
prompt =====================================
prompt
CREATE OR REPLACE PACKAGE EMR.QUEST_SOO_SCHEMA_MGR
IS
   -- Check that a table exists
   FUNCTION table_exists (p_table_name VARCHAR2)
      RETURN BOOLEAN;

   -- Get the version of an SOO schema
   FUNCTION get_version (p_schema_id VARCHAR2)
      RETURN NUMBER;

   -- Set the version of an SOO schema
   PROCEDURE set_version (p_schema_id VARCHAR2, p_version NUMBER);

   -- initialize the package objects (tables, etc)
   PROCEDURE init;
END;
/

prompt
prompt Creating package QUEST_SOO_SQLTRACE
prompt ===================================
prompt
CREATE OR REPLACE PACKAGE EMR.QUEST_SOO_SQLTRACE
IS
   /*-------------------------------------------------------------------------
   ** Package for loading a SQL trace file in the USER_DUMP_DEST into spotlight
   ** tables
   ** Default usage:
   **   load_trace(file_name=>'Sid_Pid.trc')
   **
   ** Revision History:
   **
   **    Guy Harrison    July 2007   Initial
   *--------------------------------------------------------------------------*/

   /*-------------------------------------------------------------------------
   ** Load the nominated trace file
   **   The named file must exist in the USER_DUMP_DEST
   **   File name is case sensitive on UNIX
   **
   ** Revision History:
   **
   **    Guy Harrison    July 2007   Initial
   *--------------------------------------------------------------------------*/
   PROCEDURE aaatestit;       -- temporary entry point for convenient testing

   -- Return text description for a given Oracle error code
   FUNCTION ERROR_TEXT (ERROR_CODE NUMBER)
      RETURN VARCHAR2;

   --
   -- Set tracing on for the nominated session and take a guess at the
   -- trace name (might be wrong if tracefile_identifier set)
   --
   FUNCTION set_trace (p_sid NUMBER, p_serial NUMBER, p_level NUMBER)
      RETURN VARCHAR2;

   --
   -- Run load trace as a background (DBMS_JOB) job
   --
   FUNCTION background_load_trace (
      file_name        VARCHAR2,
      process_waits    INTEGER := 1 /*process wait lines*/,
      process_binds    INTEGER := 1 /* process bind info*/,
      load_recursive   INTEGER := 1 /* load/process recursive SQL*/,
      line_limit       INTEGER := NULL /* # of lines to read: -1 for all */,
      comment_text     VARCHAR2 := NULL,
      debug_level      INTEGER := 0,
      pga_limit        NUMBER := NULL
   )
      RETURN NUMBER;

   --
   -- Process every row scheduled for background processing
   --
   PROCEDURE background_loadjob;

   --
   -- Foreground load trace
   --
   PROCEDURE load_trace (
      file_name        VARCHAR2,
      load_all_lines   BOOLEAN
            := TRUE /*load individual FETCH and WAIT lines */,
      process_waits    INTEGER := 1 /*process wait lines*/,
      process_binds    INTEGER := 1 /* process bind info*/,
      load_recursive   INTEGER := 1 /* load/process recursive SQL*/,
      line_limit       INTEGER := NULL /* # of lines to read: -1 for all */,
      comment_text     VARCHAR2 := NULL,
      debug_level      INTEGER := 0,
      pga_limit        NUMBER := NULL
   );
END;
/

prompt
prompt Creating package QUEST_SOO_USER_MANAGER
prompt =======================================
prompt
CREATE OR REPLACE PACKAGE EMR.QUEST_SOO_USER_MANAGER
IS
--
-- This package contains routines for user management, mostly for QCO
--
-- Person      Date    Comments
-- ---------   ------  -----------------------------------------------
-- Han B Xie   May2001 Created.

    PROCEDURE grant_user    (user_p VARCHAR2);
    PROCEDURE revoke_user   (user_p VARCHAR2);
    FUNCTION  validate_user (user_p VARCHAR2) RETURN INTEGER;

END; -- QUEST_SOO_USER_MANAGER
/

prompt
prompt Creating package QUEST_SOO_UTIL
prompt ===============================
prompt
CREATE OR REPLACE PACKAGE EMR.quest_soo_util
AS
--
-- This package contains utility routines to support Spotlight On Oracle
--
-- Person      Date         Comments
-- ---------   -----------  -----------------------------------------------
-- Joe T       14-Jan-2008  Initial

   -- Get details about events on system.
   -- Replacement for quest_soo_pkb.event_detail_41 and wait_detail_41
   FUNCTION event_detail (
      p_event    VARCHAR2,
      p_p1text   VARCHAR2,
      p_p1       NUMBER,
      p_p2text   VARCHAR2,
      p_p2       NUMBER,
      p_p3text   VARCHAR2,
      p_p3       NUMBER,
      p_type     PLS_INTEGER DEFAULT 1               -- 1 is Event, 2 is Wait
   )
      RETURN VARCHAR2;

   -- Do some transformation and return a lock type description
   FUNCTION get_lock_type_desc (p_lock_type VARCHAR2, p_id2 NUMBER DEFAULT -1)
      RETURN VARCHAR2;

   -- Get lock mode description
   -- It's a number so use indexing from 0 to 6
   FUNCTION get_lock_mode_desc (p_idx PLS_INTEGER)
      RETURN VARCHAR2;

   -- Get lock mode description
   -- If part of Q, X, N etc then will be ok
   FUNCTION get_lock_mode_desc (p_idx VARCHAR2)
      RETURN VARCHAR2;

END quest_soo_util;
/

prompt
prompt Creating package TEST
prompt =====================
prompt
CREATE OR REPLACE PACKAGE EMR.TEST IS
  -- 返回值
  TYPE empcurtyp IS REF CURSOR;

  --TYPE empcurtyp IS REF CURSOR;
  /*BedInfo维护*/
  PROCEDURE usp_EditEmrBedInfo(v_EditType     VARCHAR2 default '', --操作类型
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
                               v_MARK         INTEGER default 0,
                               o_reslut       out empcurtyp);
  /*Bed维护*/
  PROCEDURE usp_EditEmrBed(v_EditType     VARCHAR2 default '', --操作类型
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
                           o_reslut       out empcurtyp);
  /*InPatient维护*/
  PROCEDURE usp_EditEmrInPatient(v_EditType        VARCHAR2 default '', --操作类型
                                 v_NOOFINPAT       NUMBER default 0,
                                 v_PATNOOFHIS      NUMBER default 0,
                                 v_NOOFCLINIC      VARCHAR2 default '',
                                 v_NOOFRECORD      VARCHAR2 default '',
                                 v_PATID           VARCHAR2 default '',
                                 v_INNERPIX        VARCHAR2 default '',
                                 v_OUTPIX          VARCHAR2 default '',
                                 v_NAME            VARCHAR2 default '',
                                 v_PY              VARCHAR2 default '',
                                 v_WB              VARCHAR2 default '',
                                 v_PAYID           VARCHAR2 default '',
                                 v_ORIGIN          VARCHAR2 default '',
                                 v_INCOUNT         INTEGER default 0,
                                 v_SEXID           VARCHAR2 default '',
                                 v_BIRTH           CHAR default '',
                                 v_AGE             INTEGER default 0,
                                 v_AGESTR          VARCHAR2 default '',
                                 v_IDNO            VARCHAR2 default '',
                                 v_MARITAL         VARCHAR2 default '',
                                 v_JOBID           VARCHAR2 default '',
                                 v_PROVINCEID      VARCHAR2 default '',
                                 v_COUNTYID        VARCHAR2 default '',
                                 v_NATIONID        VARCHAR2 default '',
                                 v_NATIONALITYID   VARCHAR2 default '',
                                 v_NATIVEPLACE_P   VARCHAR2 default '',
                                 v_NATIVEPLACE_C   VARCHAR2 default '',
                                 v_ORGANIZATION    VARCHAR2 default '',
                                 v_OFFICEPLACE     VARCHAR2 default '',
                                 v_OFFICETEL       VARCHAR2 default '',
                                 v_OFFICEPOST      VARCHAR2 default '',
                                 v_NATIVEADDRESS   VARCHAR2 default '',
                                 v_NATIVETEL       VARCHAR2 default '',
                                 v_NATIVEPOST      VARCHAR2 default '',
                                 v_ADDRESS         VARCHAR2 default '',
                                 v_CONTACTPERSON   VARCHAR2 default '',
                                 v_RELATIONSHIP    VARCHAR2 default '',
                                 v_CONTACTADDRESS  VARCHAR2 default '',
                                 v_CONTACTOFFICE   VARCHAR2 default '',
                                 v_CONTACTTEL      VARCHAR2 default '',
                                 v_CONTACTPOST     VARCHAR2 default '',
                                 v_OFFERER         VARCHAR2 default '',
                                 v_SOCIALCARE      VARCHAR2 default '',
                                 v_INSURANCE       VARCHAR2 default '',
                                 v_CARDNO          VARCHAR2 default '',
                                 v_ADMITINFO       VARCHAR2 default '',
                                 v_ADMITDEPT       VARCHAR2 default '',
                                 v_ADMITWARD       VARCHAR2 default '',
                                 v_ADMITBED        VARCHAR2 default '',
                                 v_ADMITDATE       CHAR default '',
                                 v_INWARDDATE      CHAR default '',
                                 v_ADMITDIAGNOSIS  VARCHAR2 default '',
                                 v_OUTHOSDEPT      VARCHAR2 default '',
                                 v_OUTHOSWARD      VARCHAR2 default '',
                                 v_OUTBED          VARCHAR2 default '',
                                 v_OUTWARDDATE     CHAR default '',
                                 v_OUTHOSDATE      CHAR default '',
                                 v_OUTDIAGNOSIS    VARCHAR2 default '',
                                 v_TOTALDAYS       NUMBER default 0,
                                 v_CLINICDIAGNOSIS VARCHAR2 default '',
                                 v_SOLARTERMS      VARCHAR2 default '',
                                 v_ADMITWAY        VARCHAR2 default '',
                                 v_OUTWAY          VARCHAR2 default '',
                                 v_CLINICDOCTOR    VARCHAR2 default '',
                                 v_RESIDENT        VARCHAR2 default '',
                                 v_ATTEND          VARCHAR2 default '',
                                 v_CHIEF           VARCHAR2 default '',
                                 v_EDU             VARCHAR2 default '',
                                 v_EDUC            NUMBER default 0,
                                 v_RELIGION        VARCHAR2 default '',
                                 v_STATUS          INTEGER default 0,
                                 v_CRITICALLEVEL   VARCHAR2 default '',
                                 v_ATTENDLEVEL     VARCHAR2 default '',
                                 v_EMPHASIS        INTEGER default 0,
                                 v_ISBABY          INTEGER default 0,
                                 v_MOTHER          NUMBER default 0,
                                 v_MEDICAREID      VARCHAR2 default '',
                                 v_MEDICAREQUOTA   NUMBER default 0,
                                 v_VOUCHERSCODE    VARCHAR2 default '',
                                 v_STYLE           VARCHAR2 default '',
                                 v_OPERATOR        VARCHAR2 default '',
                                 v_MEMO            VARCHAR2 default '',
                                 v_CPSTATUS        INTEGER default 0,
                                 v_OUTWARDBED      INTEGER default 0,
                                 o_reslut          out empcurtyp);

END;
/

prompt
prompt Creating package TEST1
prompt ======================
prompt
CREATE OR REPLACE PACKAGE EMR.TEST1
IS
    -- global 变量宣言
  /* 变量名 数据型; */
    -- PROCEDURE，函数宣言
  /* PROCEDURE名字(变量...); */
  /* FUNCTION  名称(参数...) RETURN 数据型; */

  
TYPE empcurtyp IS REF CURSOR;

procedure aaaa
(
       testid in varchar2,
       testout OUT empcurtyp
);
END ;
/

prompt
prompt Creating package TEST1TEST1
prompt ===========================
prompt
CREATE OR REPLACE PACKAGE EMR.TEST1TEST1
IS
    -- global 变量宣言
  /* 变量名 数据型; */
    -- PROCEDURE，函数宣言
  /* PROCEDURE名字(变量...); */
  /* FUNCTION  名称(参数...) RETURN 数据型; */

  
TYPE empcurtyp IS REF CURSOR;

create or replace procedure aaaa
(
       ID in number,
       vName in number,
       mess out varchar,
       testout OUT empcurtyp
);
END ;
/

prompt
prompt Creating package WWJ
prompt ====================
prompt
CREATE OR REPLACE PACKAGE EMR.WWJ
  IS
--
-- To modify this template, edit file PKGSPEC.TXT in TEMPLATE 
-- directory of SQL Navigator
--
-- Purpose: Briefly explain the functionality of the package
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  ------------------------------------------       
   -- Enter package declarations as shown below

   TYPE empcurtyp IS REF CURSOR;

END; -- Package spec
/


spool off

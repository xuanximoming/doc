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

  --������޸���ϱ�����
  PROCEDURE usp_AddOrModDiaOther(v_id    varchar2,
                                 v_ICDID varchar2,
                                 v_NAME  varchar2,
                                 v_PY    varchar2,
                                 v_WB    varchar2,
                                 v_VALID varchar2);

  --������޸���ҽ��ϱ�����
  PROCEDURE usp_AddOrModDiaChiOther(v_id    varchar2,
                                    v_ICDID varchar2,
                                    v_NAME  varchar2,
                                    v_PY    varchar2,
                                    v_WB    varchar2,
                                    v_VALID varchar2);

  --������޸�����������
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
  -- global ��������
  /* ������ ������; */
  -- PROCEDURE����������
  /* PROCEDURE����(����...); */
  /* FUNCTION  ����(����...) RETURN ������; */
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
  * ����  ����������Ĳ���
  */
  PROCEDURE usp_AuditApplyRecord(

                                 v_AuditType varchar, --�������
                                 v_ManID     varchar, --�����ID
                                 v_ID        numeric --��¼ID
                                 );

  /*
  * ����˵��      ɾ��ѡ����λ
  */
  PROCEDURE usp_DeleteJob(v_ID VARCHAR);

  /*
  * ����˵��      ɾ��ѡ����λ
  */

  /*
  * ����˵��      ɾ��ѡ����λ
  */
  PROCEDURE usp_DeleteJobPermission(v_ID VARCHAR);

  /*
  *  ����˵��      ɾ��ĳ��Ա����Ϣ
  */
  PROCEDURE usp_DeleteUserInfo(v_ID VARCHAR);

  /*
  *  ����  ��ȡ����ģ��ѡ����������
  */
  PROCEDURE usp_DepTemManager(v_dept varchar, o_result OUT empcurtyp);

  /*
  *  ����  �༭LONG_ORDERģ��
  */
  PROCEDURE usp_EditEmrLONG_ORDER(v_EditType         varchar default '', --��������
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
  *  ����  �༭TEMP_ORDER��ʱҽ����
  */
  PROCEDURE usp_EditEmrTEMP_ORDER(v_EditType         VARCHAR2 default '', --��������
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
  *  ����  �༭����ʷ��Ϣ
  */
  PROCEDURE usp_EditAllergyHistoryInfo(v_EditType     varchar, --�༭��Ϣ���ͣ�1����ӡ�2���޸ġ�3��ɾ��
                                       v_ID           numeric, --Ψһ��
                                       v_NoOfInpat    numeric default '-1', --������ҳ���
                                       v_AllergyID    Int default -1, --��������
                                       v_AllergyLevel int default -1, --�����̶�
                                       v_Doctor       varchar default '', --����ҽ��
                                       v_AllergyPart  varchar default '', --������λ
                                       v_ReactionType varchar default '', --��Ӧ����
                                       v_Memo         varchar default '' --��ע
                                       );

  /*
  *  ����  �༭������Ϣ
  */
  PROCEDURE usp_EditFamilyHistoryInfo(v_EditType  varchar, --�༭��Ϣ���ͣ�1����ӡ�2���޸ġ�3��ɾ��
                                      v_ID        numeric, --��ϵ�˱�ţ��ǲ�����ϵ�˵�Ψһ��ʶ
                                      v_NoOfInpat numeric default '-1', --��ҳ���(סԺ��ˮ��)(Inpatient.NoOfInpat)
                                      v_Relation  varchar default '', --�����ϵ
                                      v_Birthday  varchar default '', --�������ڣ���ǰ̨��ʾ���䣩
                                      v_DiseaseID varchar default '', --���ִ���
                                      v_Breathing int default '', --�Ƿ���(1:�ǣ�0��)
                                      v_Cause     varchar default '', --����ԭ��
                                      v_Memo      varchar default '' --��ע
                                      );

  /*
  *  ����  �༭����ʷ��Ϣ
  */
  PROCEDURE usp_EditIllnessHistoryInfo(v_EditType     varchar, --�༭��Ϣ���ͣ�1����ӡ�2���޸ġ�3��ɾ��
                                       v_ID           numeric, --Ψһ��
                                       v_NoOfInpat    numeric default '-1', --������ҳ���
                                       v_DiagnosisICD varchar default '', --���ִ���
                                       v_Discuss      varchar default '', --��������
                                       v_DiseaseTime  varchar default '', --����ʱ��
                                       v_Cure         int default '', --�Ƿ�����
                                       v_Memo         varchar default '' --��ע
                                       );

  /*
  *  ����  ���滤����Ϣ����
  */
  PROCEDURE usp_EditNotesOnNursingInfoNew(v_NoOfInpat        numeric, --��ҳ���(סԺ��ˮ��)
                                          v_DateOfSurvey     varchar, --���������ڣ���ʽ2010-01-01��
                                          v_Indx             varchar, --���
                                          v_TimeSlot         varchar, --����ʱ���
                                          v_Temperature      varchar default '', --��������
                                          v_WayOfSurvey      int default 8800, --���²�����ʽ����
                                          v_Pulse            varchar default '', --����
                                          v_HeartRate        varchar default '', --����
                                          v_Breathe          varchar default '', --���ߺ���
                                          v_BloodPressure    varchar default '', --����Ѫѹ
                                          v_TimeOfShit       varchar default '', --����������ʽ��1*(3/2E ),'*'��ʾ���ʧ��
                                          v_CountIn          varchar default '', --����������
                                          v_CountOut         varchar default '', --�����ܳ���
                                          v_Drainage         varchar default '', --������
                                          v_Height           varchar default '', --�������
                                          v_Weight           varchar default '', --��������
                                          v_Allergy          varchar default '', --���߹�����
                                          v_DaysAfterSurgery varchar default '', --����������
                                          v_DayOfHospital    varchar default '', --סԺ����
                                          v_PhysicalCooling  varchar default '', --������
                                          v_DoctorOfRecord   varchar, --��¼ҽ��
                                          v_PhysicalHotting  varchar default '', --�������� edit by ywk
                                          v_PainInfo         varchar default '' --��ʹ
                                          );
  /*
  *  ����  ���滤����Ϣ����
  */
  PROCEDURE usp_EditNotesOnNursingInfo(v_NoOfInpat        numeric, --��ҳ���(סԺ��ˮ��)
                                       v_DateOfSurvey     varchar, --���������ڣ���ʽ2010-01-01��
                                       v_TimeSlot         varchar, --����ʱ���
                                       v_Temperature      varchar default '', --��������
                                       v_WayOfSurvey      int default 8800, --���²�����ʽ����
                                       v_Pulse            varchar default '', --����
                                       v_HeartRate        varchar default '', --����
                                       v_Breathe          varchar default '', --���ߺ���
                                       v_BloodPressure    varchar default '', --����Ѫѹ
                                       v_TimeOfShit       varchar default '', --����������ʽ��1*(3/2E ),'*'��ʾ���ʧ��
                                       v_CountIn          varchar default '', --����������
                                       v_CountOut         varchar default '', --�����ܳ���
                                       v_Drainage         varchar default '', --������
                                       v_Height           varchar default '', --�������
                                       v_Weight           varchar default '', --��������
                                       v_Allergy          varchar default '', --���߹�����
                                       v_DaysAfterSurgery varchar default '', --����������
                                       v_DayOfHospital    varchar default '', --סԺ����
                                       v_PhysicalCooling  varchar default '', --������
                                       v_DoctorOfRecord   varchar, --��¼ҽ��
                                       v_PhysicalHotting  varchar default '', --�������� edit by ywk
                                       v_PainInfo         varchar default '' --��ʹ
                                       );
  --��ʿ���ⵥ��Ϣά���С�����״̬��Ϣ��ά�� add by ywk 2012��4��23��14:05:18

  PROCEDURE usp_Edit_PatStates(v_EditType  varchar default '', --��������
                               v_CCode     varchar default '',
                               V_ID        varchar default '',
                               v_NoofInPat varchar default '',
                               v_DoTime    varchar default '',
                               v_Patid     varchar default '',
                               o_result    OUT empcurtyp);

  /*
  * �༭��һ��ϵ����Ϣ
  */
  PROCEDURE usp_EditPatientContacts(v_EditType   varchar, --�༭��Ϣ���ͣ�1����ӡ�2���޸ġ�3��ɾ��
                                    v_ID         numeric default '0', --��ϵ�˱�ţ��ǲ�����ϵ�˵�Ψһ��ʶ
                                    v_NoOfInpat  numeric default '0', --��ҳ���(סԺ��ˮ��)(Inpatient.NoOfInpat)
                                    v_Name       varchar default '', --��ϵ����
                                    v_Sex        varchar default '', --�Ա�
                                    v_Relation   varchar default '', --��ϵ��ϵ(Dictionary_detail.DetailID, ID = '44')
                                    v_Address    varchar default '', --��ϵ��ַ
                                    v_WorkUnit   varchar default '', --��ϵ(��)��λ
                                    v_HomeTel    varchar default '', --��ϵ�˼�ͥ�绰
                                    v_WorkTel    varchar default '', --��ϵ�˹����绰
                                    v_PostalCode varchar default '', --��ϵ�ʱ�
                                    v_Tag        varchar default '' --��ϵ�˱�־
                                    );

  /*
  * �༭����ʷ��Ϣ
  */
  PROCEDURE usp_EditPersonalHistoryInfo(v_NoOfInpat    numeric, --������ҳ���
                                        v_Marital      varchar, --����״��
                                        v_NoOfChild    int, --��������
                                        v_JobHistory   varchar, --ְҵ����
                                        v_DrinkWine    int, --�Ƿ�����
                                        v_WineHistory  varchar, --����ʷ
                                        v_Smoke        int, --�Ƿ�����
                                        v_SmokeHistory varchar, --����ʷ
                                        v_BirthPlace   varchar, --�����أ�ʡ�У�
                                        v_PassPlace    varchar, --�����أ�ʡ�У�
                                        v_Memo         varchar default '' --��ע
                                        );

  /*
  * �༭����ʷ��Ϣ
  */
  PROCEDURE usp_EditSurgeryHistoryInfo(v_EditType    varchar, --�༭��Ϣ���ͣ�1����ӡ�2���޸ġ�3��ɾ��
                                       v_ID          numeric, --Ψһ��
                                       v_NoOfInpat   numeric default '-1', --������ҳ���
                                       v_SurgeryID   varchar default '', --��������(Surgery.ID)
                                       v_DiagnosisID varchar default '', --������Diagnosis.ICD��
                                       v_Discuss     varchar default '', --����
                                       v_Doctor      varchar default '', --����ҽ��
                                       v_Memo        varchar default '' --��ע
                                       );

  /*
  * ���� .NETģ��ѡ��
  */
  PROCEDURE usp_Emr_ModelSearcher(v_flag   int,
                                  v_type   varchar,
                                  o_result OUT empcurtyp);

  /*
  * ���� ���ݲ�����ҳ��Ż�ȡ������Ϣ
  */
  PROCEDURE USP_EMR_GETPATINFO(v_NoOfinpat varchar, o_result OUT empcurtyp);

  /*
  * ���� ��ѯ���õĳ���ҽ��
  */
  procedure usp_Emr_QueryOrderSuites(v_DeptID   varchar,
                                     v_WardID   varchar,
                                     v_DoctorID varchar,
                                     v_yzlr     int default 1,
                                     o_result   OUT empcurtyp,
                                     o_result1  OUT empcurtyp);

  /*
  * ���� ����ҽ���ķ������
  */
  procedure usp_Emr_SetOrderGroupSerialNo(v_NoOfInpat numeric,
                                          v_OrderType int,
                                          v_onlynew   int default 1);

  /*
  * ��ȡ������Ĳ���
  */
  PROCEDURE usp_GetApplyRecordNew(v_DateBegin varchar, --��ʼ����
                                  v_DateEnd   varchar, --��������
                                  --v_DateInBegin  varchar, --��Ժ��ʼ����
                                  --v_DateInEnd    varchar, --��Ժ��������
                                  v_PatientName varchar, --��������
                                  v_DocName     VARCHAR, --����ҽʦ����
                                  v_OutHosDept  varchar, --��Ժ���ҿ���
                                  o_result      OUT empcurtyp);
  /*
  * ��ȡ������Ĳ���
  */
  PROCEDURE usp_GetApplyRecord(v_DateBegin  varchar, --��ʼ����
                               v_DateEnd    varchar, --��������
                               v_OutHosDept varchar, --��Ժ���ҿ���
                               o_result     OUT empcurtyp);

  /*
  * ����  ��ȡϵͳ��ǰ����
  */
  PROCEDURE usp_GetCurrSystemParam(v_GetType int, --��������
                                   o_result  OUT empcurtyp);

  /*
  * ����  ��ȡ���Ҳ���ʧ�ֵ�
  */
  PROCEDURE usp_GetDeptDeductPoint(v_DeptCode      varchar default '',
                                   v_DateTimeBegin varchar,
                                   v_DateTimeEnd   varchar,
                                   v_PointID       varchar default '',
                                   v_QCStatType    int,
                                   o_result        OUT empcurtyp);

  /*
  * ����  ��ȡҽ��������Ϣ����
  */
  PROCEDURE usp_GetDoctorTaskInfo(v_Wardid  varchar, --����
                                  v_Deptids varchar, --����
                                  v_UserID  varchar, --�û�ID
                                  v_Time    varchar, --ʱ��
                                  o_result  OUT empcurtyp);

  /*
  * ����  ��ȡҽԺ��Ϣ
  */
  PROCEDURE usp_GetHospitalInfo(o_result OUT empcurtyp);

  /*
  * ����  ��ȡ��������
  */
  PROCEDURE usp_GetIemInfo(v_NoOfInpat int,
                           o_result    OUT empcurtyp,
                           o_result1   OUT empcurtyp,
                           o_result2   OUT empcurtyp,
                           o_result3   OUT empcurtyp);

  /*
  * ����  ��ȡ������������δ�鵵����
  */
  PROCEDURE usp_GetInpatientFiling(v_DeptCode      varchar default '',
                                   v_InpatName     varchar default '',
                                   v_DateTimeBegin varchar,
                                   v_DateTimeEnd   varchar,
                                   v_QCStatType    int,
                                   o_result        OUT empcurtyp);

  /*
  * ����  ���ݴ����ʱ����Լ�������ҳ���  ��ѯ����ҽ��������Ϣ
  */
  PROCEDURE usp_GetInpatientReport(v_NoOfInpat     varchar default '',
                                   v_DateTimeBegin varchar default '',
                                   v_DateTimeEnd   varchar default '',
                                   v_SubmitDocID   varchar default '',
                                   v_ReportID      varchar default '',
                                   v_QCStatType    varchar default '',
                                   o_result        OUT empcurtyp);

  /*
  * ����    ������и�λ��Ϣ
  */
  PROCEDURE usp_GetJobPermissionInfo(v_JobId  VARCHAR,
                                     o_result out empcurtyp);

  /*
  * ����    ������и�λ��Ϣ
  */
  PROCEDURE usp_GetKnowledgePublicInfo(v_OrderType numeric, --�������
                                       o_result    out empcurtyp);

  /*
  * ����    ȡ��Ҫ��lookupeditor����ʾ������,��ð���ID��Name,Py,Memo������������APP�����ʱ��ͳһ�ķ���
  */
  PROCEDURE usp_GetLookUpEditorData(v_QueryType numeric, --��ѯ������
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
                                         --Add wwj ����ģ����ѯ
                                         v_patid   VARCHAR DEFAULT '',
                                         v_indiag  VARCHAR DEFAULT '', --��Ժ���
                                         v_outdiag VARCHAR DEFAULT '', --��Ժ���
                                         v_curdiag VARCHAR DEFAULT '', --��ǰ���
                                         o_result  OUT empcurtyp);

  /*
  * ����    �����һ���Ҷ�Ӧ���˵Ĺ鵵��δ�鵵���Ӳ���
  */
  PROCEDURE usp_GetMedicalRrecordView(v_DeptCode      varchar default '',
                                      v_DateTimeBegin varchar,
                                      v_DateTimeEnd   varchar,
                                      v_PatientName   varchar default '',
                                      v_RecordID      varchar default '',
                                      v_ApplyDoctor   varchar default '',
                                      v_QCStatType    int,
                                      --Add wwj ����ģ����ѯ
                                      v_PatID   varchar default '',
                                      v_outdiag VARCHAR DEFAULT '', --add by cyq 2012-12-07
                                      o_result  out empcurtyp);

  /*
  * ����    ����������ĵ��Ӳ�����Ϣ
  */
  PROCEDURE usp_GetMedicalRrecordViewFrm(v_GetType varchar, --��ȡ�������ͣ�1�����ҡ�2���������Ŀ�ġ�3���������޵�λ
                                         o_result  out empcurtyp);

  /*
  * ����    ��ȡ������Ϣ����
  */
  PROCEDURE usp_GetNotesOnNursingInfo(v_NoOfInpat    numeric, --��ҳ���(סԺ��ˮ��)
                                      v_DateOfSurvey varchar, --���������ڣ���ʽ2010-01-01��
                                      o_result       out empcurtyp);

  /*
  * ����    ��ȡ������Ϣ����
  */
  PROCEDURE usp_GetNursingRecordByDate(v_NoOfInpat numeric default '0', --��ҳ���
                                       v_BeginDate varchar, --��ʼʱ��
                                       v_EndDate   varchar, --��ֹʱ��
                                       o_result    out empcurtyp);

  /*
  * ����    ��ȡ����������Ŀ�������
  */
  PROCEDURE usp_GetNursingRecordParam(v_FrmType varchar, --�����������
                                      o_result  out empcurtyp);

  /*
  * ����    ��ȡ����������Ŀ�������
  */
  PROCEDURE usp_GetPatientBedInfoByDate(v_NoOfInpat    numeric default '0', --��ҳ���
                                        v_AllocateDate varchar, --ָ����ʱ��
                                        o_result       out empcurtyp);

  /*
  * ����    usp_GetPatientInfoForThreeMeas
  */
  PROCEDURE usp_GetPatientInfoForThreeMeas(v_NoOfInpat numeric default '0', --��ҳ���
                                           o_result    out empcurtyp);

  --���ݲ���name���ز���ICD
  PROCEDURE usp_getdiagicdbyname(v_name   varchar, --��������
                                 o_result OUT empcurtyp);

  --���ݲ���ICD���ز�������
  /*********add by wyt 2012-08-15************************************************************************/
  PROCEDURE usp_getdiagnamebyicd(v_icd    varchar, --���ֱ��
                                 o_result OUT empcurtyp);

  --��ѯĳ���ҽʦ��������
  /*************add by wyt 2012-08-15****************************************************************/
  PROCEDURE usp_getdiagbyattendphysician(v_userid varchar, --�û����
                                         o_result OUT empcurtyp);

  /*
  * ����    ��ȡ����������ؼ���ʼ������
  */
  PROCEDURE usp_GetRecordManageFrm(v_FrmType    varchar, --�������ͣ�1n��������Ϣ����ά�����塢2n�����˲���ʷ��Ϣ����
                                   v_PatNoOfHis numeric default '0', --��ҳ���
                                   v_CategoryID varchar default '', --(�ֵ�)������ ���򸸽ڵ���� ����ҳ���
                                   o_result     out empcurtyp);

  /*
  *���� ��ȡ���ҽʦδ�鵵��������������ѯ��
  */
  PROCEDURE usp_getattendrecordnoonfile(v_dateOutHosBegin VARCHAR, --��Ժ��ʼ����
                                        v_dateOutHosEnd   VARCHAR, --��Ժ��������
                                        v_dateInHosBegin  VARCHAR, --��Ժ��ʼ����
                                        v_dateInHosEnd    VARCHAR, --��Ժ��ֹ����
                                        v_deptid          VARCHAR, --���Ҵ���
                                        v_status          VARCHAR, --����״̬
                                        v_patientname     VARCHAR DEFAULT '', --��������
                                        v_recordid        VARCHAR DEFAULT '', --������
                                        v_indiag          VARCHAR DEFAULT '', --��Ժ���
                                        v_outdiag         VARCHAR DEFAULT '', --��Ժ���
                                        v_curdiag         VARCHAR DEFAULT '', --��ǰ���
                                        v_diaGroupStatus  VARCHAR, --��Ϸ���״̬
                                        v_PatientStatus   VARCHAR, --����״̬
                                        v_ingroupid       VARCHAR, --����ID1
                                        v_outgroupid      VARCHAR, --����ID2
                                        o_result          OUT empcurtyp);

  /*
  *���� ��ȡδ�鵵��������������ѯ��
  */
  PROCEDURE usp_getrecordnoonfileWyt(v_dateOutHosBegin VARCHAR, --��Ժ��ʼ����
                                     v_dateOutHosEnd   VARCHAR, --��Ժ��������
                                     v_dateInHosBegin  VARCHAR, --��Ժ��ʼ����
                                     v_dateInHosEnd    VARCHAR, --��Ժ��ֹ����
                                     v_deptid          VARCHAR, --���Ҵ���
                                     v_indiag          VARCHAR, --��Ժ���
                                     v_outdiag         VARCHAR, --��Ժ���
                                     v_status          VARCHAR, --����״̬
                                     v_patientname     VARCHAR DEFAULT '', --��������
                                     v_patientid       VARCHAR DEFAULT '', --����ID
                                     v_recordid        VARCHAR DEFAULT '', --������
                                     v_physician       VARCHAR DEFAULT '', --סԺҽʦ��
                                     o_result          OUT empcurtyp);
  /*
  * ����    ��ȡδ�鵵����
  */
  PROCEDURE usp_GetRecordNoOnFile(v_DateBegin   varchar, --��ʼ����
                                  v_DateEnd     varchar, --��������
                                  v_DeptID      varchar, --���Ҵ���
                                  v_Status      varchar, --����״̬
                                  v_PatientName varchar default '', --��������
                                  v_RecordID    varchar default '', --������
                                  o_result      out empcurtyp);

  /*
  * ����    ��ȡδ�鵵����
  */
  PROCEDURE usp_GetRecordNoOnFileNew(v_DateBegin   varchar, --��ʼ����
                                     v_DateEnd     varchar, --��������
                                     v_DeptID      varchar, --���Ҵ���
                                     v_Status      varchar, --����״̬
                                     v_PatientName varchar default '', --��������
                                     v_RecordID    varchar default '', --������
                                     o_result      out empcurtyp);

  /*
  * ����    ��ȡ�ѹ鵵����
  */
  PROCEDURE usp_getrecordonfile(v_datebegin  VARCHAR, --��ʼ����
                                v_dateend    VARCHAR, --��������
                                v_patid      VARCHAR DEFAULT '', --סԺ����
                                v_name       VARCHAR DEFAULT '', --��������
                                v_sexid      VARCHAR DEFAULT '', --�����Ա�
                                v_agebegin   VARCHAR DEFAULT '', --��ʼ����
                                v_ageend     VARCHAR DEFAULT '', --��������
                                v_outhosdept VARCHAR DEFAULT '', --��Ժ���ҿ���
                                v_indiag     VARCHAR DEFAULT '', --��Ժ���
                                v_outdiag    VARCHAR DEFAULT '', --��Ժ���
                                v_surgeryid  VARCHAR DEFAULT '', --��������
                                v_physician  VARCHAR DEFAULT '', --סԺҽʦ����
                                o_result     OUT empcurtyp);

  /*
  * ����    ��ȡ��ǩ�չ黹����
  */
  PROCEDURE usp_GetSignInRecordNew(v_DateBegin   varchar, --��ʼ����
                                   v_DateEnd     varchar, --��������
                                   v_DateInBegin varchar, --��Ժ��ʼ����
                                   v_DateInEnd   varchar, --��Ժ��������
                                   v_PatientName varchar, --��������
                                   v_OutHosDept  varchar, --��Ժ���ҿ���
                                   o_result      out empcurtyp);

  /*
  * ����    ��ȡ��ǩ�չ黹����
  */
  PROCEDURE usp_GetSignInRecord(v_DateBegin  varchar, --��ʼ����
                                v_DateEnd    varchar, --��������
                                v_OutHosDept varchar, --��Ժ���ҿ���
                                o_result     out empcurtyp);
  /*
  * ����    ��ȡ��������
  */
  PROCEDURE usp_GetTemplatePersonGroup(v_UserID  varchar default '',
                                       o_result  OUT empcurtyp,
                                       o_result1 OUT empcurtyp);

  /*
  * ����    ������Ϣ�������̣�
  */
  PROCEDURE usp_Inpatient_Trigger(v_syxh varchar2 --������ҳ���
                                  );

  /*
  * ����    ����ͼƬ��Ϣ
  */
  PROCEDURE usp_InsertImage(v_Sort   int,
                            v_Name   varchar,
                            v_Memo   varchar default '',
                            v_ID     numeric default 0,
                            o_result OUT empcurtyp);

  /*
  * ����    �����λ��Ϣ
  */
  PROCEDURE usp_InsertJob(v_Id VARCHAR, v_Title VARCHAR, v_Memo VARCHAR);

  /*
  * ����    �����µ���Ȩ��Ϣ
  */
  PROCEDURE usp_InsertJobPermission(v_ID         VARCHAR,
                                    v_Moduleid   VARCHAR,
                                    v_Modulename VARCHAR);

  /*
  * ����    ��Ӳ��˻����ĵ�
  */
  procedure usp_InsertNursRecordTable(v_NoOfInpat  numeric, --��ҳ���(סԺ��ˮ��)
                                      v_name       varchar, --��¼�����ƣ�ģ������+����+ʱ�䣩
                                      v_Content    blob, --��������
                                      v_TemplateID numeric, --ģ��ID
                                      v_version    varchar, --ģ��汾(�Զ�������,Ĭ��Ϊ1.00.00,�������������1λ)
                                      v_Department varchar, --�����������Ҵ���
                                      v_SortID     numeric, --ģ��������
                                      v_Valid      int --��Ч��¼(CategoryDetail.ID CategoryID = 0)
                                      );

  /*
  * ����    ���������ĵ�ģ�壬������ID
  */
  procedure usp_InsertNursTableTemplate(v_Name     varchar, --ģ������
                                        v_Describe varchar, --ģ������
                                        v_Content  blob, --ģ������
                                        v_version  varchar, --ģ��汾(�Զ�������,Ĭ��Ϊ1.00.00,�������������1λ)
                                        v_SortID   varchar, --ģ��������
                                        v_Valid    int, --��Ч��¼(CategoryDetail.ID CategoryID = 0)
                                        o_result   OUT empcurtyp);
  /*
  * ����    ��ȡ��������
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
  * ����    �û���¼����޸�
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
  * ���빦������ҳ���TABLE
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
  * ���빦������ҳ����TABLE
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
  /*�������ĳ�����˵ĵ�ǰ�����Ϣ(wyt 2012-08-15)*/
  PROCEDURE usp_updatecurrentdiaginfo(v_patient_id   VARCHAR2,
                                      v_patient_name VARCHAR2,
                                      v_diag_code    VARCHAR2,
                                      v_diag_content varchar2);

  /*�������ĳ������ҽʦ���ֲ鿴Ȩ����Ϣ(wyt 2012-08-13)*/
  PROCEDURE usp_updateattendphysicianinfo(v_id            VARCHAR2,
                                          v_name          VARCHAR2,
                                          v_py            VARCHAR2,
                                          v_wb            VARCHAR2,
                                          v_deptid        VARCHAR2,
                                          v_relatedisease varchar2);

  /*�������ĳ��Ա����Ϣ*/
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

  /*�޸ĸ�λ��Ϣ*/
  PROCEDURE usp_updatejobinfo(v_id    VARCHAR2,
                              v_title VARCHAR2,
                              v_memo  VARCHAR2);

  /*���²��˻����ĵ�*/
  procedure usp_UpdateNursRecordTable(v_ID        numeric, --��¼ID
                                      v_NoOfInpat numeric, --��ҳ���(סԺ��ˮ��)
                                      v_Content   blob --������
                                      );

  /*���»����ĵ�ģ��*/
  procedure usp_UpdateNursTableTemplate(v_ID       numeric, --ģ�����
                                        v_Name     varchar, --ģ������
                                        v_Describe varchar, --ģ������
                                        v_Content  blob, --ģ������
                                        v_version  varchar, --ģ��汾(�Զ�������,Ĭ��Ϊ1.00.00,�������������1λ)
                                        v_SortID   varchar --ģ��������
                                        );

  /*���µ��ڵĽ��Ĳ���*/
  PROCEDURE usp_updatedueapplyrecord(v_applydoctor VARCHAR2 --����ҽʦ����
                                     );

  /*���¹�������ҳ����TABLE*/
  PROCEDURE usp_update_iem_mainpage_oper(v_iem_mainpage_no NUMERIC,
                                         v_cancel_user     VARCHAR);

  /*���²�����ҳ���TABLE,�ڲ���֮ǰ����*/
  PROCEDURE usp_update_iem_mainpage_diag(v_iem_mainpage_no NUMERIC,
                                         v_cancel_user     VARCHAR2);

  /*���¹�������ҳ������ϢTABLE*/
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

  /*���²��˾�����Ϣ*/
  PROCEDURE usp_updatadiacrisisinfo(v_noofinpat      NUMERIC, --��ҳ���(סԺ��ˮ��)(Inpatient.NoOfInpat)
                                    v_admitdiagnosis VARCHAR2 --��Ժ���
                                    );

  /*���²��˻�����Ϣ*/
  PROCEDURE usp_updatabasepatientinfo(v_noofinpat     NUMERIC, --��ҳ���(סԺ��ˮ��)
                                      v_birth         VARCHAR, --��������
                                      v_marital       VARCHAR, --����״��
                                      v_nationid      VARCHAR, --�������
                                      v_nationalityid VARCHAR, --��������
                                      v_sexid         VARCHAR, --�����Ա�
                                      v_edu           VARCHAR, --�Ļ��̶�
                                      v_provinceid    VARCHAR, --(������)ʡ�д���
                                      v_countyid      VARCHAR, --(������)���ش���
                                      v_nativeplace_p VARCHAR, --����ʡ�д���
                                      v_nativeplace_c VARCHAR, --�������ش���
                                      v_payid         VARCHAR, --��������
                                      v_age           INT, --��������
                                      v_religion      VARCHAR, --�ڽ�����
                                      v_educ          NUMERIC, --(��)��������(��λ:��)
                                      v_idno          VARCHAR, --���֤��
                                      v_jobid         VARCHAR, --ְҵ����
                                      v_organization  VARCHAR, --������λ(��ȱ)
                                      v_officeplace   VARCHAR, --��λ��ַ
                                      v_officepost    VARCHAR, --��λ�ʱ�
                                      v_officetel     VARCHAR, --��λ�绰
                                      v_nativeaddress VARCHAR, --���ڵ�ַ
                                      v_nativetel     VARCHAR, --���ڵ绰
                                      v_nativepost    VARCHAR, --�����ʱ�
                                      v_address       VARCHAR --��ǰ��ַ
                                      );

  procedure usp_SymbolManager(v_type               varchar,
                              v_SymbolCategroyID   int default 0, --�����ַ���������
                              v_SymbolCategoryName varchar default '', --�����ַ���������
                              v_SymbolCategoryMemo varchar default '', --�����ַ����ͱ�ע

                              --  v_SymbolRTF  varchar default '',--�����ַ�����ID(Inpatient.NoOfInpat)
                              --  v_SymbolCategroyID int  default 0,  --�����ַ�����
                              --  v_SymbolLength int  default  0,       --�����ַ�����
                              --  v_SymbolMemo varchar default  '' --�����ַ���ע
                              o_result OUT empcurtyp);

  /*���������Ա����Ϣ*/
  PROCEDURE usp_selectusers(v_DeptId   VARCHAR,
                            v_UserName VARCHAR,
                            o_result   OUT empcurtyp);

  /*�������Ա����Ϣ�������ʾ���Ӧ���ƣ�*/
  procedure usp_selectuserinfo(o_result out empcurtyp);

  /*������в�����Ϣ*/
  PROCEDURE usp_selectward(o_result OUT empcurtyp);

  /*������и�λ��Ϣ*/
  PROCEDURE usp_selectpermission(o_result OUT empcurtyp);

  /*���ĳ��Ա����Ϣ*/
  PROCEDURE usp_selectjob(v_id VARCHAR, o_result OUT empcurtyp);

  /*������в�����Ϣ*/
  PROCEDURE usp_selectdepartment(o_result OUT empcurtyp);

  /*�������Ա����Ϣ*/
  PROCEDURE usp_selectallusers2(o_result  OUT empcurtyp,
                                o_result1 OUT empcurtyp);

  /*�������Ա����Ϣ*/
  PROCEDURE usp_selectallusers(o_result OUT empcurtyp);

  /*������и�λ��Ϣ*/
  PROCEDURE usp_selectalljobs(o_result OUT empcurtyp);

  /*����������ĵ��Ӳ�����Ϣ*/
  PROCEDURE usp_saveapplyrecord(v_noofinpat   NUMERIC, --��ҳ���(סԺ��ˮ��)
                                v_applydoctor VARCHAR, --����ҽ������
                                v_deptid      VARCHAR, --���Ҵ���
                                v_applyaim    VARCHAR, --����Ŀ��
                                v_duetime     NUMERIC, --��������
                                v_unit        VARCHAR --���޵�λ
                                );

  /*��ȡ������Ϣά������ؼ���ʼ������*/
  PROCEDURE usp_redactpatientinfofrm(v_frmtype VARCHAR,
                                     --�������ͣ�1n��������Ϣ����ά�����塢2n�����˲���ʷ��Ϣ����
                                     v_noofinpat  NUMERIC DEFAULT '0', --��ҳ���
                                     v_categoryid VARCHAR DEFAULT '',
                                     --(�ֵ�)������ ���򸸽ڵ���� ����ҳ���
                                     o_result OUT empcurtyp);

  /*��ȡ��������ͳ������(�в�ѯ����)*/
  PROCEDURE usp_queryqcstatinfo(v_datetimebegin VARCHAR, --��ʼʱ��
                                v_datetimeend   VARCHAR, --����ʱ��
                                o_result        OUT empcurtyp);

  /*��ȡ��������ͳ������*/
  PROCEDURE usp_queryqcstatdetailinfo(v_datetimebegin VARCHAR, --��ʼʱ��
                                      v_datetimeend   VARCHAR, --����ʱ��
                                      v_qcstattype    INT, --ͳ����������
                                      o_result        OUT empcurtyp);

  /*��ȡ����Ǽ�����*/
  PROCEDURE usp_queryqcprobleminfo(v_noofinpat INT, o_result OUT empcurtyp);

  /*��ȡ�������Ʋ�������*/
  PROCEDURE usp_queryqcpatientinfo(v_datetimefrom VARCHAR,
                                   v_datetimeto   VARCHAR,
                                   v_deptid       VARCHAR,
                                   v_wardid       VARCHAR,
                                   v_bedid        VARCHAR,
                                   v_name         VARCHAR,
                                   v_archives     VARCHAR,
                                   o_result       OUT empcurtyp);

  /*������ҳ��Ż�ȡ���˶�Ӧ��Ϣ*/
  PROCEDURE usp_querypatientinfobynoofinp(v_noofinpat INT,
                                          o_result    OUT empcurtyp);

  /*��ȡ������ȡ���没���б�*/
  PROCEDURE usp_queryownmanagerpat2(v_querytype INT,
                                    v_userid    VARCHAR,
                                    v_deptid    VARCHAR,
                                    v_wardid    VARCHAR,
                                    o_result    OUT empcurtyp);

  /*��ȡ��Ӧ�����Ĵ�λ��Ϣ*/
  PROCEDURE usp_querynonarchivepatients(v_wardid  VARCHAR,
                                        v_deptids VARCHAR,
                                        o_result  OUT empcurtyp);

  /*�ʿ�TypeScore����*/
  PROCEDURE usp_qctypescore(v_typename        VARCHAR default '',
                            v_typeinstruction VARCHAR default '',
                            v_typecategory    INT default 0,
                            v_typeorder       INT default 0,
                            v_typememo        VARCHAR default '',
                            v_typestatus      INT,
                            v_typecode        VARCHAR);

  /*��ȡ������������*/
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

  /*��ȡ��������ͳ������*/
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

  /*��ȡ����ģ��ѡ����������*/
  PROCEDURE usp_msquerytemplate(v_id         VARCHAR,
                                v_user       VARCHAR,
                                v_type       INT,
                                v_department VARCHAR DEFAULT '',
                                o_result     OUT empcurtyp);

  /*
  * �����û�����
  */
  PROCEDURE usp_updateuserpassword(v_id      IN users.ID%TYPE,
                                   v_passwd  IN users.passwd%TYPE,
                                   v_regdate IN users.regdate%TYPE);

  /*
  * �õ��û��ʻ���Ϣ
  */
  PROCEDURE usp_getuseraccount(v_id     IN users.ID%TYPE,
                               o_result OUT empcurtyp);

  /*
  * ȡְ�����Ҷ�Ӧ����, ��δָ����������ͨ��ָ���Ŀ��ҹ��������еĲ���
  */
  PROCEDURE usp_getuserdeptandward(v_userid IN users.ID%TYPE,
                                   o_result OUT empcurtyp);

  /*
  *
  */
  PROCEDURE usp_getuseroutdeptandward(o_result OUT empcurtyp);

  /**ʹ�õ���ʱ��Ĵ洢����**/

  /*
  *��ȡְ�������Ϣ
  */
  PROCEDURE usp_GetUserInfo(v_userid  varchar,
                            o_result  OUT empcurtyp,
                            o_result1 OUT empcurtyp);

  /*
  *��ȡְ�������Ϣ
  */
  procedure usp_NursRecordOperate(v_ID        numeric default 0, --��¼ID
                                  v_NoOfInpat numeric default 0, --��ҳ���(סԺ��ˮ��)
                                  v_SortID    numeric default 0, --ģ��������
                                  v_Type      int, --��������
                                  o_result    OUT empcurtyp);
  /*
  *ҽ������ͳ�Ʒ���
  */
  PROCEDURE usp_MedQCAnalysis(v_DateTimeBegin varchar, --��ѯ��ʼ����
                              v_DateTimeEnd   varchar, --��ѯ��������
                              o_result        OUT empcurtyp);

  /*
  *��ȡ��Ӧ�����Ĵ�λ��Ϣ(����һ��ʱ���ã�
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
  *��ȡ��Ӧ�����Ĵ�λ��Ϣ
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
  *��ȡ��Ӧ�����Ĵ�λ��Ϣ
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
    ��ȡ��Ӧ�����Ĵ�λ��Ϣ
  bwj 20121108 ���usp_QueryInwardPatients_old��ҽ������վ������ʱ�����Դ����������
  ͨ����ͼ
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
  xuliangliang2012-12-17�������Ͽ⵼��
  �������ɽ���Ҳ����������� ��like���
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
  *��ȡ��Ӧ�����Ĵ�λ��Ϣ
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
  *��ȡ������ȡ���没���б�
  */
  PROCEDURE usp_QueryOwnManagerPat(v_QueryType int,
                                   v_UserID    varchar,
                                   v_DeptID    varchar,
                                   v_WardId    varchar,
                                   o_result    OUT empcurtyp);
  /*
  *��ȡ��������
  */
  PROCEDURE usp_QueryQCGrade(v_NoOfInpat int,
                             v_OperUser  varchar,
                             o_result    OUT empcurtyp);

  /*
  *��ȡ��Ӧ�����ĳ�Ժ����
  */
  PROCEDURE usp_QueryQuitPatientNoDoctor(v_wardid    varchar,
                                         v_Deptids   varchar,
                                         v_TimeFrom  varchar,
                                         v_TimeTo    varchar,
                                         v_PatientSN varchar default '', --������
                                         v_Name      varchar default '', --��������
                                         v_QueryType int default 0,
                                         o_result    OUT empcurtyp);

  /***************************************************************************/

  /*
  *���㲡������
  */
  PROCEDURE usp_Emr_CalcAge(v_csrq varchar,
                            v_dqrq varchar,
                            v_sjnl out int,
                            v_xsnl out varchar);
  /*
  *���㲡������
  */
  procedure usp_EMR_GetAge(v_csrq varchar,
                           v_dqrq varchar,
                           v_sjnl out int,
                           v_xsnl out varchar);

  --ҽʦ����վ�õ���Ժ����
  PROCEDURE usp_queryinwardpatientsout(v_wardid    VARCHAR,
                                       v_deptids   VARCHAR,
                                       v_id        VARCHAR DEFAULT '',
                                       v_querytype INT DEFAULT 0,
                                       o_result    OUT empcurtyp);

  ----ҽ������վ�л�û�����Ϣ��ȫ�����������ģ�
  PROCEDURE usp_GetMyConsultion(v_Deptids varchar, --���ű��
                                V_userid  varchar, --��¼�˱��
                                o_result  OUT empcurtyp);

  -----------------------------Ϊ�����趨Ӥ���Ĵ洢����  -add by ywk 2012��6��7�� 09:47:34------------------------------
  /*���¹�������ҳ������ϢTABLE*/
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
  ----�ʿس�Ժδ�鵵������ѯ
  -----Add by xlb 2013-06-04
  PROCEDURE usp_GetOutHosButNotLocks(v_deptId    VARCHAR2, ---���Ҵ���
                                     v_sex       VARCHAR2, --�Ա�
                                     v_dateBegin VARCHAR2, --��Ժ��ʼʱ��
                                     v_dateEnd   VARCHAR2, --��Ժ����ʱ��
                                     v_patName   VARCHAR2, ----��������
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

  /*�������ĳ��Ա����Ϣ*/
  PROCEDURE usp_updateuserinfo(v_id     VARCHAR2,
                               v_name   VARCHAR2,
                               v_deptid VARCHAR2,
                               v_wardid VARCHAR2,
                               v_jobid  VARCHAR2);

  /*�޸ĸ�λ��Ϣ*/
  PROCEDURE usp_updatejobinfo(v_id    VARCHAR2,
                              v_title VARCHAR2,
                              v_memo  VARCHAR2);

  /*���µ��ڵĽ��Ĳ���*/
  PROCEDURE usp_updatedueapplyrecord(v_applydoctor VARCHAR2 --����ҽʦ����
                                     );

  /*������˸���״̬*/
  PROCEDURE usp_updateconsultationdata(v_consultapplysn INT DEFAULT 0, --�����
                                       v_typeid         INT DEFAULT 0, --����
                                       v_stateid        INT DEFAULT 0, --״̬
                                       v_rejectreason   VARCHAR DEFAULT '' --������
                                       );

  /*���¹�������ҳ����TABLE*/
  PROCEDURE usp_update_iem_mainpage_oper(v_iem_mainpage_no NUMERIC,
                                         v_cancel_user     VARCHAR);

  /*���²�����ҳ���TABLE,�ڲ���֮ǰ����*/
  PROCEDURE usp_update_iem_mainpage_diag(v_iem_mainpage_no NUMERIC,
                                         v_cancel_user     VARCHAR2);

  /*���¹�������ҳ������ϢTABLE*/
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

  /*���²��˾�����Ϣ*/
  PROCEDURE usp_updatadiacrisisinfo(v_noofinpat      NUMERIC, --��ҳ���(סԺ��ˮ��)(Inpatient.NoOfInpat)
                                    v_admitdiagnosis VARCHAR2 --��Ժ���
                                    );

  /*���²��˻�����Ϣ*/
  PROCEDURE usp_updatabasepatientinfo(v_noofinpat     NUMERIC, --��ҳ���(סԺ��ˮ��)
                                      v_birth         VARCHAR, --��������
                                      v_marital       VARCHAR, --����״��
                                      v_nationid      VARCHAR, --�������
                                      v_nationalityid VARCHAR, --��������
                                      v_sexid         VARCHAR, --�����Ա�
                                      v_edu           VARCHAR, --�Ļ��̶�
                                      v_provinceid    VARCHAR, --(������)ʡ�д���
                                      v_countyid      VARCHAR, --(������)���ش���
                                      v_nativeplace_p VARCHAR, --����ʡ�д���
                                      v_nativeplace_c VARCHAR, --�������ش���
                                      v_payid         VARCHAR, --��������
                                      v_age           INT, --��������
                                      v_religion      VARCHAR, --�ڽ�����
                                      v_educ          NUMERIC, --(��)��������(��λ:��)
                                      v_idno          VARCHAR, --���֤��
                                      v_jobid         VARCHAR, --ְҵ����
                                      v_organization  VARCHAR, --������λ(��ȱ)
                                      v_officeplace   VARCHAR, --��λ��ַ
                                      v_officepost    VARCHAR, --��λ�ʱ�
                                      v_officetel     VARCHAR, --��λ�绰
                                      v_nativeaddress VARCHAR, --���ڵ�ַ
                                      v_nativetel     VARCHAR, --���ڵ绰
                                      v_nativepost    VARCHAR, --�����ʱ�
                                      v_address       VARCHAR --��ǰ��ַ
                                      );

  /*������в�����Ϣ*/
  PROCEDURE usp_selectward(o_result OUT empcurtyp);

  /*������и�λ��Ϣ*/
  PROCEDURE usp_selectpermission(o_result OUT empcurtyp);

  /*���ĳ��Ա����Ϣ*/
  PROCEDURE usp_selectjob(v_id VARCHAR, o_result OUT empcurtyp);

  /*������в�����Ϣ*/
  PROCEDURE usp_selectdepartment(o_result OUT empcurtyp);

  /*�������Ա����Ϣ*/
  PROCEDURE usp_selectallusers2(o_result OUT empcurtyp);

  /*�������Ա����Ϣ*/
  PROCEDURE usp_selectallusers(o_result OUT empcurtyp);

  /*������и�λ��Ϣ*/
  PROCEDURE usp_selectalljobs(o_result OUT empcurtyp);

  /*����������ĵ��Ӳ�����Ϣ*/
  PROCEDURE usp_saveapplyrecord(v_noofinpat   NUMERIC, --��ҳ���(סԺ��ˮ��)
                                v_applydoctor VARCHAR, --����ҽ������
                                v_deptid      VARCHAR, --���Ҵ���
                                v_applyaim    VARCHAR, --����Ŀ��
                                v_duetime     NUMERIC, --��������
                                v_unit        VARCHAR --���޵�λ
                                );

  /*��ȡ������Ϣά������ؼ���ʼ������*/
  PROCEDURE usp_redactpatientinfofrm(v_frmtype VARCHAR,
                                     --�������ͣ�1n��������Ϣ����ά�����塢2n�����˲���ʷ��Ϣ����
                                     v_noofinpat  NUMERIC DEFAULT '0', --��ҳ���
                                     v_categoryid VARCHAR DEFAULT '',
                                     --(�ֵ�)������ ���򸸽ڵ���� ����ҳ���
                                     o_result OUT empcurtyp);

  /*��ȡ��������ͳ������(�в�ѯ����)*/
  PROCEDURE usp_queryqcstatinfo(v_datetimebegin VARCHAR, --��ʼʱ��
                                v_datetimeend   VARCHAR, --����ʱ��
                                o_result        OUT empcurtyp);

  /*��ȡ��������ͳ������*/
  PROCEDURE usp_queryqcstatdetailinfo(v_datetimebegin VARCHAR, --��ʼʱ��
                                      v_datetimeend   VARCHAR, --����ʱ��
                                      v_qcstattype    INT, --ͳ����������
                                      o_result        OUT empcurtyp);

  /*��ȡ����Ǽ�����*/
  PROCEDURE usp_queryqcprobleminfo(v_noofinpat INT, o_result OUT empcurtyp);

  /*��ȡ�������Ʋ�������*/
  PROCEDURE usp_queryqcpatientinfo(v_datetimefrom VARCHAR,
                                   v_datetimeto   VARCHAR,
                                   v_deptid       VARCHAR,
                                   v_wardid       VARCHAR,
                                   v_bedid        VARCHAR,
                                   v_name         VARCHAR,
                                   v_archives     VARCHAR,
                                   o_result       OUT empcurtyp);

  /*������ҳ��Ż�ȡ���˶�Ӧ��Ϣ*/
  PROCEDURE usp_querypatientinfobynoofinp(v_noofinpat INT,
                                          o_result    OUT empcurtyp);

  /*��ȡ������ȡ���没���б�*/
  PROCEDURE usp_queryownmanagerpat2(v_querytype INT,
                                    v_userid    VARCHAR,
                                    v_deptid    VARCHAR,
                                    v_wardid    VARCHAR,
                                    o_result    OUT empcurtyp);

  /*��ȡ��Ӧ�����Ĵ�λ��Ϣ*/
  PROCEDURE usp_querynonarchivepatients(v_wardid_in VARCHAR,
                                        v_deptids   VARCHAR,
                                        o_result    OUT empcurtyp);

  /*�ʿ�TypeScore����*/
  PROCEDURE usp_qctypescore(v_typename        VARCHAR,
                            v_typeinstruction VARCHAR,
                            v_typecategory    INT,
                            v_typeorder       INT,
                            v_typememo        VARCHAR,
                            v_typestatus      INT,
                            v_typecode        VARCHAR);

  /*��ȡ������������*/
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

  /*��ȡ��������ͳ������*/
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

  /*��ȡ����ģ��ѡ����������*/
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

  --�õ������б�
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


  --�õ�����ͳ����Ϣ
  procedure usp_GetAllDepartmentStatInfo(v_deptid         varchar2,
                                         v_patid          varchar2,
                                         v_name           varchar2,
                                         v_status         varchar2,
                                         v_admitbegindate varchar2,
                                         v_admitenddate   varchar2,
                                         o_result         OUT empcurtype);

  --ͳ�ƿ��ҵĲ���������Ϣ add by wyt 2012-12-12
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

  ---��ÿ����ڲ��ˣ��������ֱ��д��ڼ�¼�Ĳ��ˣ�
  PROCEDURE usp_getdepartmentpatstatinfo(v_deptid         VARCHAR2,
                                         v_patid          VARCHAR2,
                                         v_name           VARCHAR2,
                                         v_status         VARCHAR2,
                                         v_admitbegindate VARCHAR2,
                                         v_admitenddate   VARCHAR2,
                                         v_sortid         VARCHAR2,
                                         v_sumpoint       int, --�������ܷ� ywk 2012��6��12�� 14:51:41
                                         V_type           varchar2, --�����İ����Ͳ�ѯ ywk 2012��11��6��10:55:58
                                         o_result         OUT empcurtype);

  --�ʺ� ��ȡ����ͳ����Ϣ ͨ������״̬��ȡ
  PROCEDURE usp_RHgetalldepstatinfo(v_deptid         VARCHAR2,
                                    v_patid          VARCHAR2,
                                    v_name           VARCHAR2,
                                    v_status         VARCHAR2,
                                    v_admitbegindate VARCHAR2,
                                    v_admitenddate   VARCHAR2,
                                    o_result         OUT empcurtype);

  --�ʺ� ��ȡ����ͳ����Ϣ סԺ�ͳ�Ժ���˻���
  PROCEDURE usp_RHgetDepstatinfoAll(v_deptid         VARCHAR2,
                                    v_patid          VARCHAR2,
                                    v_name           VARCHAR2,
                                    v_admitbegindate VARCHAR2,
                                    v_admitenddate   VARCHAR2,
                                    o_result         OUT empcurtype);

  ---�ʺ� ��ÿ����ڲ��ˣ��������ֱ��д��ڼ�¼�Ĳ��� ���Ҽ�¼״̬��8701 �������Σ�
  PROCEDURE usp_GetRHGetDeptinfo(v_deptid         VARCHAR2,
                                 v_patid          VARCHAR2,
                                 v_name           VARCHAR2,
                                 v_status         VARCHAR2,
                                 v_admitbegindate VARCHAR2,
                                 v_admitenddate   VARCHAR2,
                                 o_result         OUT empcurtype);

  --�õ����˵�ͳ����Ϣ(�ʺͰ汾�ģ����������ֱ�edit by ywk 2012��7��13�� 08:58:34)
  procedure usp_GetrhDepartmentPatStatInfo(v_deptid         varchar2,
                                           v_patid          varchar2,
                                           v_name           varchar2,
                                           v_status         varchar2,
                                           v_admitbegindate varchar2,
                                           v_admitenddate   varchar2,
                                           o_result         OUT empcurtype);

  --�õ����˵�ͳ����Ϣ �ʿؿ���Ա ��Ժ��Ժ (�ʺͰ汾�ģ����������ֱ�edit by ywk 2012��8��2�� 08:58:34)
  procedure usp_GetrhDepPatStatInfoAll(v_deptid         varchar2,
                                       v_patid          varchar2,
                                       v_name           varchar2,
                                       v_admitbegindate varchar2,
                                       v_admitenddate   varchar2,
                                       o_result         OUT empcurtype);

  --�õ����˵�ͳ����Ϣ ����ָ��Ա (�ʺͰ汾�ģ����������ֱ�edit by ywk 2012��8��2�� 08:58:34)
  procedure usp_GetrhDepPatStatInfoCY(v_deptid         varchar2,
                                      v_patid          varchar2,
                                      v_name           varchar2,
                                      v_admitbegindate varchar2,
                                      v_admitenddate   varchar2,
                                      o_result         OUT empcurtype);

  --�õ����˵����в���
  procedure usp_GetAllEmrDocByNoofinpat(v_noofinpat varchar2,
                                        o_result    OUT empcurtype);

  --�õ���������ҽ��
  procedure usp_GetAllDoctorByUserNO(v_userid varchar2,
                                     o_result OUT empcurtype);

  --�õ���������ҽ��
  procedure usp_GetAllDoctorByNoofinpat(v_noofinpat varchar2,
                                        o_result    OUT empcurtype);

  --�õ��������ֱ����Ϣ //edit by wyt 2012-12-06 ������������¼ID����
  procedure usp_GetEmrPointByNoofinpat(v_noofinpat varchar2,
                                       v_chiefid   varchar2,
                                       o_result    OUT empcurtype);

  -- �ʺ� �õ��������ֱ����ϸ��Ϣ
  procedure usp_GetRHPoint(v_rhqc_tableId varchar2,
                           o_result       OUT empcurtype);

  procedure usp_insertEmrPoint(v_doctorid       varchar2,
                               v_doctorname     varchar2,
                               v_create_user    varchar2,
                               v_createusername varchar2,
                               v_problem_desc   varchar2,
                               v_reducepoint    varchar2,
                               v_num            varchar2,
                               --v_grade varchar2,  ���� 2012 11 30
                               v_recorddetailid   varchar2,
                               v_noofinpat        varchar2,
                               v_recorddetailname varchar2,
                               v_sortid           varchar2, --����������
                               -- v_emrpointid INT DEFAULT 0,---�����ֶ�
                               v_emrpointid varchar2, ---�����ֶ� --edit by wyt 2012-12-11
                               v_chiefid    varchar2, ---�����ֶ�,
                               v_emrpointchildid varchar2
                               );

  --ɾ���ʺ����ֱ����
  procedure usp_cancelRHEmrPoint(v_id              varchar2,
                                 v_cancel_user     varchar2,
                                 v_cancel_userName varchar2);

  procedure usp_cancelEmrPoint(v_id varchar2, v_cancel_user varchar2);

  procedure usp_GetPatientInfo(v_noofinpat varchar2,
                               o_result    OUT empcurtype);

  procedure usp_GetPointByDoctorID(v_doctorID varchar2,
                                   o_result   OUT empcurtype);

  ------���������������
  PROCEDURE usp_Edit_ConfigPoint(v_EditType   varchar default '', --��������
                                 V_ID         varchar default '',
                                 v_CCode      varchar default '',
                                 v_CChildCode varchar default '',
                                 v_CChildName varchar default '',
                                 v_Valid      varchar default '1',
                                 o_result     OUT empcurtype);

  ------�������֣��۷����ɣ�����       ywk 2012��5��28�� 09:22:10
  PROCEDURE usp_Edit_ConfigReduction(v_EditType        varchar default '', --��������
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

  --����������Ҫ��ʾ�ĸ��ڵ�
  procedure usp_GetPointClass(o_result OUT empcurtype);

  ------�����ʿ�Ա�����ò��� 2012��7��10��13:45:29 ywk
  PROCEDURE usp_Edit_ConfigPointManager(v_EditType      varchar default '', --��������
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

  ------�������֣��۷����ɣ����� �ʺ��ʿ�       ywk 2012��8��7�� 09:22:10
  PROCEDURE usp_Edit_RHConfigReduction(v_EditType    varchar default '', --��������
                                       V_REDUCEPOINT varchar default '',
                                       v_PROBLEMDESC varchar default '',
                                       v_CREATEUSER  varchar default '',
                                       v_CREATETIME  varchar default '',
                                       v_ID          varchar default '',
                                       v_Valid       varchar default '1',
                                       v_UserType    varchar default '',
                                       o_result      OUT empcurtype);
  ------�ʿ�ͳ������   wj 2013 3 21
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
  -- ά���������ݱ�
  TYPE empcurtyp IS REF CURSOR;

  /*
  Diagnosis  ��Ͽ�
  */
  PROCEDURE usp_Edit_Diagnosis(v_EditType      varchar default '', --��������
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
  Diagnosis  ���ҳ�����Ͽ�
  */
  PROCEDURE usp_Edit_DeptDiagnosis(v_EditType varchar default '', --��������
                                   v_DeptID   varchar default '',
                                   v_MarkID   varchar default '',
                                   o_result   OUT empcurtyp);

  /*
  DiagnosisOfChinese     ��ҽ��Ͽ�
  */
  PROCEDURE usp_Edit_DiagnosisOfChinese(v_EditType varchar default '', --��������
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
  DiseaseCFG  �������ÿ�
  */
  PROCEDURE usp_Edit_DiseaseCFG(v_EditType  varchar default '', --��������
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
  Surgery  ���������
  */
  PROCEDURE usp_Edit_Surgery(v_EditType     varchar default '', --��������
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
  Toxicosis  �����ж���
  */
  PROCEDURE usp_Edit_Toxicosis(v_EditType     varchar default '', --��������
                               v_ID           varchar default '',
                               v_MapID        varchar default '',
                               v_StandardCode varchar default '',
                               v_Name         varchar default '',
                               v_Py           varchar default '',
                               v_Wb           varchar default '',
                               v_Valid        int default 1,
                               v_Memo         varchar default '',
                               o_result       OUT empcurtyp);

   ------------������Ϣ��ά��
  PROCEDURE usp_Edit_OperInfo(v_EditType     varchar default '', --��������
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
  Tumor  ������
  */
  PROCEDURE usp_Edit_Tumor(v_EditType     varchar default '', --��������
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
  Tumor  ģ�幤����
*/

PROCEDURE usp_Edit_ModelEmr(v_EditType      varchar default '', --��������
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
  -- ģ�幤��ģ��ʹ�õ��洢����

  TYPE empcurtyp IS REF CURSOR;

  /*
  *  ����  �༭EMRTEMPLETģ��
  */
  PROCEDURE usp_EditEmrTemplet(v_EditType        varchar default '', --��������
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
  *  ����  �༭EMRTEMPLET_Item��ģ��
  */
  PROCEDURE usp_EditEmrTemplet_Item(v_EditType         varchar default '', --��������
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
  *  ����  �༭EditEmrTempletHeader��  ģ��ҳü
  */
  PROCEDURE usp_EditEmrTempletHeader(v_EditType        varchar default '', --��������
                                     v_HEADER_ID       VARCHAR2 default '',
                                     v_NAME            VARCHAR2 default '',
                                     v_CREATOR_ID      VARCHAR2 default '',
                                     v_CREATE_DATETIME VARCHAR2 default '',
                                     v_LAST_TIME       VARCHAR2 default '',
                                     v_HOSPITAL_CODE   VARCHAR2 default '',
                                     v_CONTENT         CLOB default '',
                                     o_result          OUT empcurtyp);


                                       /*
  *  ����  �༭EditEmrTempletHeader��  ģ��ҳ��
  */
  PROCEDURE usp_EditEmrTemplet_Foot(v_EditType        varchar default '', --��������
                                     v_FOOT_ID       VARCHAR2 default '',
                                     v_NAME            VARCHAR2 default '',
                                     v_CREATOR_ID      VARCHAR2 default '',
                                     v_CREATE_DATETIME VARCHAR2 default '',
                                     v_LAST_TIME       VARCHAR2 default '',
                                     v_HOSPITAL_CODE   VARCHAR2 default '',
                                     v_CONTENT         CLOB default '',
                                     o_result          OUT empcurtyp);

  --������ϰ�ť
  PROCEDURE usp_SaveDiagButton(v_diagname   varchar);

  --����ģ��ά��
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

  --ͨ������������ȡ����Ԫ
  PROCEDURE usp_GetDateElement(v_ElementId    VARCHAR2,
                               v_ElementName  VARCHAR2,
                               v_ElementClass VARCHAR2,
                               v_ElementPYM   VARCHAR2,
                               o_result       OUT empcurtype);

  --ͨ������������ȡ����Ԫ
  PROCEDURE usp_GetDateElementOne(v_ElementFlow VARCHAR2,
                                  o_result      OUT empcurtype);

  --ͨ������ԪID�����ǹ����ڸ�����Ԫ
  PROCEDURE usp_ValiDateElement(v_ElementId VARCHAR2,
                                o_result    OUT empcurtype);

  --��������Ԫ
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
  --�޸�����Ԫ
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

  --��ȡ�򵥰�ͨ�õ�
  PROCEDURE usp_GetSimpleCommonNote(v_CommonNoteName VARCHAR2,
                                    o_result         OUT empcurtype);

  --��ȡͨ�õ���Ӧ���ҺͲ���
  PROCEDURE usp_GetCommonNoteSite(v_CommonNoteFlow VARCHAR2,
                                  o_result         OUT empcurtype,
                                  o_result1        OUT empcurtype);

  --��ȡ��ϸͨ�õ�
  PROCEDURE usp_GetDetailCommonNote(v_CommonNoteFlow VARCHAR2,
                                    o_result         OUT empcurtype,
                                    o_result1        OUT empcurtype,
                                    o_result2        OUT empcurtype);

  --������޸�ͨ�õ�
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

  --������޸�ͨ�õ���ǩ
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

  --������޸�ͨ�õ���Ŀ
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

  --������޸�ͨ�õ�����
  PROCEDURE usp_AddOrModCommonNote_Site(v_Site_Flow      VARCHAR2,
                                        v_CommonNoteFlow VARCHAR2,
                                        v_RelationType   VARCHAR2,
                                        v_Site_ID        VARCHAR2,
                                        v_Valide         VARCHAR2);

  --ɾ����ͨ�õ������ÿ���
  PROCEDURE usp_DelCommonNote_Site(v_CommonNoteFlow VARCHAR2);

  --��ȡ���п��ҺͲ���
  PROCEDURE usp_GetAllDepartAndAreas(o_result  OUT empcurtype,
                                     o_result1 OUT empcurtype);

  --��ȡ��ǰ���һ����µ��������õ��� v_type 01���� 02����
  PROCEDURE usp_GetCommonNoteForDeptWard(v_SiteCode varchar2,
                                         v_Type     varchar2,
                                         o_result   out empcurtype);

  --ͨ�����õ���ˮ�Ż�ȡ���˵���
  PROCEDURE usp_GetSimInCommonNote(v_noofInpant varchar2,
                                   o_result     out empcurtype);

  PROCEDURE usp_GetSimInCommonNoteByFlow(v_noofInpant     varchar2,
                                         v_commonnoteflow varchar2,
                                         o_result         out empcurtype);

  --�������õ���ˮ�Ż�ȡͨ�õ���ϸ��Ϣ
  PROCEDURE usp_GetDetailInCommonNoteByDay(v_InCommonNoteFlow     varchar2,
                                           v_incommonnote_tabflow varchar2,
                                           v_StartDate            varchar2,
                                           v_EndDate              varchar2,
                                           o_result               out empcurtype,
                                           o_result1              out empcurtype,
                                           o_result2              out empcurtype);

  --�������õ���ˮ�Ż�ȡͨ�õ���ϸ��Ϣ
  PROCEDURE usp_GetDetailInCommonNote(v_InCommonNoteFlow varchar2,
                                      o_result           out empcurtype,
                                      o_result1          out empcurtype,
                                      o_result2          out empcurtype);

  --��ӻ��޸Ĳ������õ�
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

  --��ӻ��޸Ĳ������õ�tab
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

  --��ӻ��޸Ĳ������õ���Ŀ
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

  --��ӻ��޸�ʹ�õ����� xll 20130325
  PROCEDURE usp_AddInCommonType(v_CommonNote_Item_Flow  varchar2,
                                v_InCommonNote_Tab_Flow varchar2,
                                v_DataElementFlow       varchar2,
                                v_OtherName             varchar2);

  --��ȡ������Ϣ ����������Ϣ�����ڿ�����Ϣ
  PROCEDURE usp_GetInpatient(v_noofInpat varchar2, o_result out empcurtype);

  --��ȡһ��ĵ�������
  PROCEDURE usp_GetInCommomItemDay(v_commonNoteFlow varchar2,
                                   v_date           varchar2,
                                   v_dept           varchar2,
                                   v_ward           varchar2,
                                   o_result         out empcurtype);

  --������Ŀ��ȡ������Ϣ
  PROCEDURE usp_GetInpatientSim(v_incommonnoteitemflow varchar2,
                                o_result               out empcurtype);

  --��ȡ���˵�����һ������
  PROCEDURE usp_GetIncommonNew(v_noofinpat      varchar2,
                               v_commonnoteflow varchar2,
                               o_result         out empcurtype);

  --��ȡĳ������д��ڶ�����
  PROCEDURE usp_GetIncommonTabCount(v_incommonnote_tab_flow varchar2,
                                    o_result                out empcurtype);

  --��ȡ��ǰ������ǰ���ҵ����в���
  --xlb 2013-01-18
  PROCEDURE usp_GetDeptAndWardInpatient(

                                        v_outhosdept varchar,
                                        v_outhosward varchar,
                                        o_result     out empcurtype);

  --����ͬ��ʱ������Ӥ��״̬��ĸ��һ�� ��ͨ�õ����޹�  xll 20130307
  PROCEDURE usp_ChangeBabyStatus;

  PROCEDURE usp_AddOrModCommonNoteCount(v_CommonNoteCountFlow VARCHAR2,
                                        v_CommonNoteFlow      VARCHAR2,
                                        v_ItemCount           VARCHAR2,
                                        v_Hour12Name          VARCHAR2,
                                        v_Hour12Time          VARCHAR2,
                                        v_Hour24Name          VARCHAR2,
                                        v_Hour24Time          VARCHAR2,
                                        v_Valide              VARCHAR2);

  --������ʷ��¼
  PROCEDURE usp_AddPrintHistory(v_phflow          VARCHAR2,
                                v_printrecordflow VARCHAR2,
                                v_startpage       integer,
                                v_endpage         integer,
                                v_printpages      integer,
                                v_printdocid      VARCHAR2,
                                v_printdatetime   VARCHAR2,
                                v_printtype       VARCHAR2);

  --���뻤���ݵ���ʷ��¼
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

  --���뻤���ݵ���ʷ��¼ ��
  PROCEDURE usp_AddInCommColHistory(v_incommonnote_item_flow varchar2,
                                    v_hisrowflow             varchar2,
                                    v_valuexml               varchar2,
                                    v_commonnote_item_flow   varchar2,
                                    v_incommonnote_tab_flow  varchar2,
                                    v_incommonnoteflow       varchar2);

                                    --���˻����ݴӵڼ�ҳ��ʼ��ӡ
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
  * ��ȡ������Ĳ���
  */
  PROCEDURE usp_GetConsultationData(v_NoOfInpat        numeric default '0', --��ҳ���
                                    v_ConsultApplySn   int default 0, --�������
                                    v_TypeID           numeric default 0, --���
                                    v_Param1           varchar default '', --����1
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
  * ����    (�����������)��������
  */
  PROCEDURE usp_InsertConsultationApply(
                                        -- Add the parameters for the stored procedure here
                                        v_typeid            INT DEFAULT 0,
                                        v_consultapplysn    INT DEFAULT 0,
                                        v_noofinpat         NUMERIC DEFAULT '0', --��ҳ���
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
  * ����    ����ConsultApplyDepartment����
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
  * ����    ����ConsultRecordDepartment����
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
  /*������˸���״̬*/
  PROCEDURE usp_updateconsultationdata(v_consultapplysn INT DEFAULT 0, --�����
                                       v_typeid         INT DEFAULT 0, --����
                                       v_stateid        INT DEFAULT 0, --״̬
                                       v_rejectreason   VARCHAR DEFAULT '' --������
                                       );

  /*�����ṩ�Ļ������뵥��Ż�ȡ������Ϣ*/
  PROCEDURE usp_GetConsultationBySN(v_consultapplysn INT DEFAULT 0, --�����
                                    o_result         OUT empcurtyp);

  ---����ǩ������
  PROCEDURE usp_GetConsultUseSign(v_consultapplysn INT DEFAULT 0, --�����
                                  o_result         OUT empcurtyp);

  PROCEDURE usp_GetMessageInfo(v_userid VARCHAR DEFAULT '',
                               o_result OUT empcurtyp);

  ----ҽ������վ�л�û�����Ϣ��ȫ�����������ģ�
  PROCEDURE usp_GetMyConsultion(v_Deptids varchar, --���ű��
                                v_userid  varchar, --��¼�˱��
                                --v_seetype   varchar,--���Ӳ��������ѯ������Ϣ��ʱ����������ڵĻ��ǲ�ѯ���еĻ�����Ϣ  add by ywk 2012��7��24�� 14:59:14
                                o_result OUT empcurtyp);

  ----ҽ������վ�л�û�����Ϣ��ȫ�����������ģ�
  PROCEDURE usp_GetAllMyConsultion(v_Deptids varchar, --���ű��
                                   v_userid  varchar, --��¼�˱��
                                   v_seetype varchar, --���Ӳ��������ѯ������Ϣ��ʱ����������ڵĻ��ǲ�ѯ���еĻ�����Ϣ  add by ywk 2012��7��24�� 14:59:14
                                   o_result  OUT empcurtyp);
  ---����������ȡ���л�����Ϣ���ʿذ�ҽ����Աר�ã�
  PROCEDURE usp_GetAllConsultion(v_ApplyDeptid    varchar, --���ű��
                                 v_EmployeeDeptid varchar, --���ű��
                                 v_DateTimeBegin  varchar, --��ʼʱ��
                                 v_DateTimeEnd    varchar, --����ʱ��
                                 o_result         OUT empcurtyp);

  -------------------------------------------------����������ȡ ������  2012-11-07  add by tj -------------
  ----��ʿ����վ�л�û�����Ϣ tj
  PROCEDURE usp_GetConsultionNurse(v_Deptids varchar, --���ű��
                                   o_result  OUT empcurtyp);

  ----ҽ������վ�л�û�����Ϣ��ȫ�����������ģ�  by tj
  PROCEDURE usp_GetConsultionDoctor(v_Deptids varchar, --���ű��
                                    v_userid  varchar, --��¼��ID
                                    v_levelid varchar, ---��¼�˼���
                                    o_result  OUT empcurtyp);

  ----����������Ϣ   by tj
  PROCEDURE usp_GetConsultionMessage(v_Deptids varchar, --���ű��
                                     v_levelid varchar, ---��¼�˼���
                                     o_result  OUT empcurtyp);

  --Add by wwj 2013-02-18 ��ʿ����վ�Ļ���������ȡ
  PROCEDURE usp_GetConsultionForNurse(v_Deptids varchar,      --���ű��
                                       v_ConsultDateFrom date, --��������
                                       v_ConsultDateTo date,   --��������
                                       v_ConsultState varchar, --����״̬
                                       o_result OUT empcurtyp);


  --����ѻ���δ�ɷѵļ�¼ Add by wwj 2013-02-19
  PROCEDURE usp_GetAlreadyConsultNotFee(v_Deptids varchar, --���ű��
                                        o_result  OUT empcurtyp);

  --��ȡ����˵Ļ����¼ Add by wwj 2013-02-27
  PROCEDURE usp_GetUnAuditConsult(v_timefrom date, --������ʼʱ��
                                  v_timeto date,   --������ֹʱ��
                                  v_inpatientname varchar, --��������
                                  v_patid  varchar, --������
                                  v_urgencyTypeID varchar, --������
                                  v_currentuserid varchar, --��ǰϵͳ��¼��
                                  v_currentuserlevel varchar, --��ǰ�û�����
                                  o_result OUT empcurtyp);

  --��ȡ��ϵͳ��¼����صĴ���������¼����ļ�¼ Add by wwj 2013-02-27
  PROCEDURE usp_GetWaitConsult(v_timefrom date, --������ʼʱ��
                               v_timeto date,   --������ֹʱ��
                               v_inpatientname varchar, --��������
                               v_patid  varchar, --������
                               v_urgencyTypeID varchar, --������
                               v_bedCode varchar, --��λ��
                               v_currentuserid varchar, --��ǰϵͳ��¼��
                               v_currentuserlevel varchar, --��ǰ�û�����
                               o_result OUT empcurtyp);

  --������ò���
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
-----------------ҽ������վ�漰�����߼�--------------------
-----------------------------------------------------------
IS
   TYPE empcurtyp IS REF CURSOR;

   --�õ�������������б�
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

  --ͨ������ID����ԱID��ȡ������Ϣ
  PROCEDURE usp_GetNurseRecord(v_NoOfInpatient  IN varchar2,
                               v_FatherRecordId IN varchar2,
                               o_result         OUT empcurtype);

  --��ӻ��޸ļ�¼����¼
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

  --ɾ����¼��
  PROCEDURE usp_DelNurseRecord(v_NurseId IN varchar2);

  --��ѯĳ���������еĲ������� add by tj 2012-10-30
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

    --�õ��û�����������¼
   PROCEDURE usp_getoperrecordlog (
      v_user_id      VARCHAR,
      v_patient_id   VARCHAR,
      v_startDate  VARCHAR,
      v_endDate    VARCHAR,
      o_result     OUT empcurtyp
   );

      --���벡��������¼
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

   --�õ���ʷ���˼�¼
   PROCEDURE usp_getHistoryInpatient (
      v_noofinpat      VARCHAR,
      v_admitbegindate VARCHAR,--add by xlb 2013-01-14
      v_admitenddate   VARCHAR,--add by xlb 2013-01-14
      o_result     OUT empcurtyp
   );

   --�õ���ʷ�����ļ���
   PROCEDURE usp_getHistoryInpatientFolder (
      v_noofinpat      VARCHAR,

      o_result     OUT empcurtyp
   );

   --�õ�סԺ������******�������ǵ��Ӳ���ϵͳ�Ĵ���������ʵ�ʵ���Ժ����**********��
   PROCEDURE usp_getHistoryInCount (
     v_noofinpat       VARCHAR,
     o_result      OUT empcurtyp
   );

   --�õ����˵Ļ�����Ϣ
   PROCEDURE usp_getPatinetInfo(
     v_noofinpat       VARCHAR,
     o_result      OUT empcurtyp
   );

   --�õ�������ʷ������������ʷ��������
   PROCEDURE usp_getHistoryEMR(
     v_noofinpat        VARCHAR,
     v_sortid           VARCHAR,
     o_result      OUT empcurtyp
   );

   --�õ���������
   PROCEDURE usp_EmrContentByID(
     v_recorddetailid   VARCHAR,
     o_result      OUT empcurtyp
   );

   /*����ת�Ƽ�¼ add by cyq 2013-03-26*/
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

   /*--����ʷ��������
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

  --**********************************���γ�Ժ��������**************************************
  --��ȡ���˻�����Ϣ
  PROCEDURE usp_inpatient_info(v_patnoofhis VARCHAR2,
                               o_result     OUT empcurtype);

  --��ȡ��ʷ����
  PROCEDURE usp_history_inpatient(v_patnoofhis VARCHAR2,
                                  o_result     OUT empcurtype);

  --��ȡ���˲���
  PROCEDURE usp_inpatient_emr(v_noofinpat VARCHAR2,
                              o_result    OUT empcurtype);

  --��ȡ���˲���
  PROCEDURE usp_inpatient_emr2(v_id VARCHAR2, o_result OUT empcurtype);

  --**********************************�ż�����ʷ��������**************************************

  --��ȡ���˻�����Ϣ�����
  PROCEDURE usp_inpatient_info_clinic(v_patnoofhis VARCHAR2,
                                      o_result     OUT empcurtype);

  --��ȡ��ʷ���ˡ����
  PROCEDURE usp_history_inpatient_clinic(v_patnoofhis VARCHAR2,
                                         o_result     OUT empcurtype);

  --��ȡ���˲��������
  PROCEDURE usp_inpatient_emr_clinic(v_noofinpat VARCHAR2,
                                     o_result    OUT empcurtype);

  --��ȡ���˲��������
  PROCEDURE usp_inpatient_emr2_clinic(v_id     VARCHAR2,
                                      o_result OUT empcurtype);

  --��ȡ������Ӳ����ĺ�Ԫ�ص�ֵ
  PROCEDURE usp_macro_inpatient_clinic(v_noofinpat VARCHAR2,
                                       o_result    OUT empcurtype);

  --********************************������Ϣά��******************************************
  --��ȡ������Ӳ����ĺ�Ԫ�ص�ֵ
  PROCEDURE usp_get_inpatient_list(v_deptID         VARCHAR2,
                                   v_visitTypeID    VARCHAR2,
                                   v_name           VARCHAR2,
                                   v_patID          VARCHAR2,
                                   v_visitTimeBegin date,
                                   v_visitTimeEnd   date,
                                   o_result         OUT empcurtype);

  --ͨ�������Ż�������ץȡ����
  PROCEDURE usp_get_inpatient_list2(v_patID  VARCHAR2,
                                    v_name   VARCHAR2,
                                    o_result OUT empcurtype);

  --��ȡ��������б�                                   
  PROCEDURE usp_get_dept_list(o_result OUT empcurtype);

  --********************************���ԣ����ڽ���XML*************************************
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
  * ���봫Ⱦ�����濨����
  */
  PROCEDURE usp_EditZymosis_Report(v_EditType         varchar,
                                   v_Report_ID        NUMERIC DEFAULT 0,
                                   v_Report_NO        varchar DEFAULT '', --���濨����
                                   v_Report_Type      varchar default '', --���濨����   1�����α���  2����������
                                   v_Noofinpat        varchar default '', --��ҳ���
                                   v_PatID            varchar default '', --סԺ��
                                   v_Name             varchar default '', --��������
                                   v_ParentName       varchar default '', --�ҳ�����
                                   v_IDNO             varchar default '', --���֤����
                                   v_Sex              varchar default '', --�����Ա�
                                   v_Birth            varchar default '', --��������
                                   v_Age              varchar default '', --ʵ������
                                   v_AgeUnit          varchar default '', --ʵ�����䵥λ
                                   v_Organization     varchar default '', --������λ
                                   v_OfficePlace      varchar default '', --��λ��ַ
                                   v_OfficeTEL        varchar default '', --��λ�绰
                                   v_AddressType      varchar default '', --�������ڵ���  1�������� 2����������������  3����ʡ��������  4����ʡ  5���۰�̨  6���⼮
                                   v_HomeTown         varchar default '', --����
                                   v_Address          varchar default '', --��ϸ��ַ[�� �ֵ� ���ƺ�]
                                   v_JobID            varchar default '', --ְҵ���루��ҳ��˳���¼��ţ�
                                   v_RecordType1      varchar default '', --��������  1�����Ʋ���  2���ٴ���ϲ���  3��ʵ����ȷ�ﲡ��  4��ԭЯ����
                                   v_RecordType2      varchar default '', --�������ࣨ���͸��ס�Ѫ���没��д��  1������  2������
                                   v_AttackDate       varchar default '', --�������ڣ���ԭЯ������������ڻ�������ڣ�
                                   v_DiagDate         varchar default '', --�������
                                   v_DieDate          varchar default '', --��������
                                   v_DiagICD10        varchar default '', --��Ⱦ������(��Ӧ��Ⱦ����Ͽ�)
                                   v_DiagName         varchar default '', --��Ⱦ����������
                                   v_INFECTOTHER_FLAG varchar default '', --���޸�Ⱦ������[0�� 1��]
                                   v_Memo             varchar default '', --��ע
                                   v_Correct_flag     varchar default '', --������־��0��δ���� 1���Ѷ�����
                                   v_Correct_Name     varchar default '', --��������
                                   v_Cancel_Reason    varchar default '', --�˿�ԭ��
                                   v_ReportDeptCode   varchar default '', --������ұ��
                                   v_ReportDeptName   varchar default '', --�����������
                                   v_ReportDocCode    varchar default '', --����ҽ�����
                                   v_ReportDocName    varchar default '', --����ҽ������
                                   v_DoctorTEL        varchar default '', --����ҽ����ϵ�绰
                                   v_Report_Date      varchar default '', --�ʱ��
                                   v_State            varchar default '', --����״̬�� 1���������� 2���ύ 3������ 4�����ͨ�� 5�����δͨ������ 6���ϱ�  7�����ϡ�
                                   v_StateName        varchar default '', --����״̬�������¼������ˮ��
                                   v_create_date      varchar default '', --����ʱ��
                                   v_create_UserCode  varchar default '', --������
                                   v_create_UserName  varchar default '', --������
                                   v_create_deptCode  varchar default '', --�����˿���
                                   v_create_deptName  varchar default '', --�����˿���
                                   v_Modify_date      varchar default '', --�޸�ʱ��
                                   v_Modify_UserCode  varchar default '', --�޸���
                                   v_Modify_UserName  varchar default '', --�޸���
                                   v_Modify_deptCode  varchar default '', --�޸��˿���
                                   v_Modify_deptName  varchar default '', --�޸��˿���
                                   v_Audit_date       varchar default '', --���ʱ��
                                   v_Audit_UserCode   varchar default '', --�����
                                   v_Audit_UserName   varchar default '', --�����
                                   v_Audit_deptCode   varchar default '', --����˿���
                                   v_Audit_deptName   varchar default '', --����˿���
                                   v_OtherDiag        varchar default '',
                                   o_result           OUT empcurtyp);

  PROCEDURE usp_GetInpatientByNofinpat(v_Noofinpat varchar default '', --��ҳ���
                                       o_result    OUT empcurtyp);

  PROCEDURE usp_geteditzymosisreport(v_report_type1    varchar default '',
                                     v_report_type2    varchar default '',
                                     v_name            varchar default '',
                                     v_patid           varchar default '',
                                     v_deptid          varchar default '',
                                     v_applicant       varchar default '',
                                     v_status          varchar default '',
                                     v_createdatestart varchar default '', --�������ϱ����ڿ�ʼ
                                     v_createdateend   varchar default '', --�������ϱ����ڽ���
                                     v_querytype       varchar default '', --��ѯ����
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

  --��ְҵͳ�ƴ�Ⱦ����Ϣ
  PROCEDURE usp_GetJobDisease(v_beginDate varchar default '',
                              v_EndDate   varchar default '',
                              v_DiagCode  varchar default '',
                              o_result    OUT empcurtyp);

  --�õ�������Ч�����
  PROCEDURE usp_GetDiagnosis(o_result OUT empcurtyp);

  --�õ���Ⱦ��������Ϣ
  PROCEDURE usp_GetDisease2(o_result OUT empcurtyp);

  --�õ�������Ч�����
  PROCEDURE usp_GetDiagnosisTo(v_categoryid varchar default '',
                               o_result     OUT empcurtyp);

  --�õ�������Ч�����
  PROCEDURE usp_GetDiagnosisTo_ZY(v_categoryid varchar default '',
                                  o_result     OUT empcurtyp);

  --�õ���Ⱦ��������Ϣ
  PROCEDURE usp_GetDisease2To(v_categoryid varchar default '',
                              o_result     OUT empcurtyp);

  --���没�ּ�¼
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
  --���没�ּ�¼
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
                                    v_REPORT_DISTRICTID     varchar DEFAULT '', --��Ⱦ���ϱ�������(��)����
                                    v_REPORT_DISTRICTNAME   varchar default '', --��Ⱦ���ϱ�������(��)����
                                    v_REPORT_ICD10          varchar default '', --��Ⱦ�����濨ICD-10����
                                    v_REPORT_ICD0           varchar default '', --��Ⱦ�����濨ICD-0����
                                    v_REPORT_CLINICID       varchar default '', --�����
                                    v_REPORT_PATID          varchar default '', --סԺ��
                                    v_REPORT_INDO           varchar default '', --���֤����
                                    v_REPORT_INPATNAME      varchar default '', --��������
                                    v_SEXID                 varchar default '', --�����Ա�
                                    v_REALAGE               varchar default '', --����ʵ������
                                    v_BIRTHDATE             varchar default '', --��������
                                    v_NATIONID              varchar default '', --����������
                                    v_NATIONNAME            varchar default '', --��������ȫ��
                                    v_CONTACTTEL            varchar default '', --��ͥ�绰
                                    v_MARTIAL               varchar default '', --����״��
                                    v_OCCUPATION            varchar default '', --����ְҵ
                                    v_OFFICEADDRESS         varchar default '', --������λ��ַ
                                    v_ORGPROVINCEID         varchar default '', --���ڵ�ַʡ�ݱ���
                                    v_ORGCITYID             varchar default '', --���ڵ�ַ�����б���
                                    v_ORGDISTRICTID         varchar default '', --�������ڵ����ر���
                                    v_ORGTOWNID             varchar default '', --�������ڵ���(�ֵ�)����
                                    v_ORGVILLIAGE           varchar default '', --�������ڵؾ�ί���Ӧ����
                                    v_ORGPROVINCENAME       varchar default '', --�������ڵ�ʡ��ȫ��
                                    v_ORGCITYNAME           varchar default '', --�������ڵ���ȫ����
                                    v_ORGDISTRICTNAME       varchar default '', --�������ڵ���(��)ȫ��
                                    v_ORGTOWN               varchar default '', --�������ڵ���ȫ��
                                    v_ORGVILLAGENAME        varchar default '', --�������ڵش�ȫ��
                                    v_XZZPROVINCEID         varchar default '', --��סַ����ʡ�ݱ���
                                    v_XZZCITYID             varchar default '', --��סַ�����б���
                                    v_XZZDISTRICTID         varchar default '', --��סַ������(��)����
                                    v_XZZTOWNID             varchar default '', --��סַ���������
                                    v_XZZVILLIAGEID         varchar default '', --����סַ���ڴ����
                                    v_XZZPROVINCE           varchar default '', --��סַ����ʡ��ȫ��
                                    v_XZZCITY               varchar default '', --��סַ������ȫ��
                                    v_XZZDISTRICT           varchar default '', --��סַ������ȫ��
                                    v_XZZTOWN               varchar default '', --��סַ������ȫ��
                                    v_XZZVILLIAGE           varchar default '', --��סַ���ڴ�ȫ��
                                    v_REPORT_DIAGNOSIS      varchar default '', --���
                                    v_PATHOLOGICALTYPE      varchar default '', --��������
                                    v_PATHOLOGICALID        varchar default '', --������ϲ����
                                    v_QZDIAGTIME_T          varchar default '', --ȷ��ʱ��_T��
                                    v_QZDIAGTIME_N          varchar default '', --ȷ��ʱ��_N��
                                    v_QZDIAGTIME_M          varchar default '', --ȷ��ʱ��_M��
                                    v_FIRSTDIADATE          varchar default '', --�״�ȷ��ʱ��
                                    v_REPORTINFUNIT         varchar default '', --���浥λ
                                    v_REPORTDOCTOR          varchar default '', --����ҽ��
                                    v_REPORTDATE            varchar default '', --����ʱ��
                                    v_DEATHDATE             varchar default '', --����ʱ��
                                    v_DEATHREASON           varchar default '', --����ԭ��
                                    v_REJEST                varchar default '', --����ժҪ
                                    v_REPORT_YDIAGNOSIS     varchar default '', --ԭ���
                                    v_REPORT_YDIAGNOSISDATA varchar default '', --ԭ�������
                                    v_REPORT_DIAGNOSISBASED varchar default '', --�������
                                    v_REPORT_NO             varchar default '', --��Ⱦ���ϱ�������
                                    v_REPORT_NOOFINPAT      varchar default '', --����ID
                                    v_STATE                 varchar default '', --����״̬�� 1���������� 2���ύ 3������ 4�����ͨ�� 5�����δͨ������ 6���ϱ�  7�����ϡ�
                                    v_CREATE_DATE           varchar default '', --����������  
                                    v_CREATE_USERCODE       varchar default '', --������
                                    v_CREATE_USERNAME       varchar default '', --������
                                    v_CREATE_DEPTCODE       varchar default '', --�����˿���
                                    v_CREATE_DEPTNAME       varchar default '', --�����˿���
                                    v_MODIFY_DATE           varchar default '', --�޸�ʱ��
                                    v_MODIFY_USERCODE       varchar default '', --�޸���
                                    v_MODIFY_USERNAME       varchar default '', --�޸���
                                    v_MODIFY_DEPTCODE       varchar default '', --�޸��˿���
                                    v_MODIFY_DEPTNAME       varchar default '', --�޸��˿���
                                    v_AUDIT_DATE            varchar default '', --���ʱ��
                                    v_AUDIT_USERCODE        varchar default '', --�����
                                    v_AUDIT_USERNAME        varchar default '', --�����
                                    v_AUDIT_DEPTCODE        varchar default '', --����˿���
                                    v_AUDIT_DEPTNAME        varchar default '', --����˿���
                                    v_VAILD                 varchar default '', --״̬�Ƿ���Ч  1����Ч   0����Ч
                                    v_DIAGICD10             varchar default '', --��Ⱦ������(��Ӧ��Ⱦ����Ͽ�)
                                    v_CANCELREASON          varchar default '', --���ԭ��   
                                    V_CARDTYPE              varchar default '', --��Ƭ�����������߷���                     
                                    V_clinicalstages        varchar default '',
                                    V_ReportDiagfunit       varchar default '',
                                    o_result                OUT empcurtyp);

  --�����б��濨  add  by  ywk 2013��8��21�� 15:47:00
  PROCEDURE usp_EditCardiovacular_Report(v_EditType      varchar, --��������
                                         v_REPORT_NO     varchar DEFAULT '', --���濨����                                 
                                         v_NOOFCLINIC    varchar DEFAULT '', --����� 
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

  --������ȱ�ݱ��濨  add  by  jxh  2013-08-16   ��ʱ����
  PROCEDURE usp_EditTbirthdefects_Report(v_EditType         varchar,
                                         v_ID               NUMERIC DEFAULT 0,
                                         v_REPORT_NOOFINPAT varchar DEFAULT '', --���˱��
                                         v_REPORT_ID        varchar default '', --���濨���
                                         v_DIAG_CODE        varchar default '', --���濨��ϱ���
                                         v_STRING3          varchar default '', --Ԥ��
                                         v_STRING4          varchar default '', --Ԥ��
                                         v_STRING5          varchar default '', --Ԥ��
                                         v_REPORT_PROVINCE  varchar DEFAULT '', --�ϱ��濨ʡ��
                                         v_REPORT_CITY      varchar default '', --���濨�У��أ�
                                         v_REPORT_TOWN      varchar default '', --���濨����
                                         v_REPORT_VILLAGE   varchar default '', --���濨��
                                         v_REPORT_HOSPITAL  varchar default '', --���濨ҽԺ
                                         v_REPORT_NO        varchar default '', --���濨���
                                         v_MOTHER_PATID     varchar default '', --����סԺ��
                                         v_MOTHER_NAME      varchar default '', --����
                                         v_MOTHER_AGE       varchar default '', --����
                                         v_NATIONAL         varchar default '', --����
                                         v_ADDRESS_POST     varchar default '', --��ַand�ʱ�
                                         v_PREGNANTNO       varchar default '', --�д�
                                         v_PRODUCTIONNO     varchar default '', --����
                                         v_LOCALADD         varchar default '', --��ס��
                                         
                                         v_PERCAPITAINCOME         varchar default '', --���˾�����     
                                         v_EDUCATIONLEVEL          varchar default '', --�Ļ��̶�     
                                         v_CHILD_PATID             varchar default '', --����סԺ��     
                                         v_CHILD_NAME              varchar default '', --��������     
                                         v_ISBORNHERE              varchar default '', --�Ƿ�Ժ����     
                                         v_CHILD_SEX               varchar default '', --�����Ա�      
                                         v_BORN_YEAR               varchar default '', --������     
                                         v_BORN_MONTH              varchar default '', --  ������     
                                         v_BORN_DAY                varchar default '', --������      
                                         v_GESTATIONALAGE          varchar default '', --̥��     
                                         v_WEIGHT                  varchar default '', --����     
                                         v_BIRTHS                  varchar default '', --̥��     
                                         v_ISIDENTICAL             varchar default '', --�Ƿ�ͬ��      
                                         v_OUTCOME                 varchar default '', --ת��      
                                         v_INDUCEDLABOR            varchar default '', --�Ƿ�����     
                                         v_DIAGNOSTICBASIS         varchar default '', --������ݡ����ٴ�      
                                         v_DIAGNOSTICBASIS1        varchar default '', --������ݡ���������      
                                         v_DIAGNOSTICBASIS2        varchar default '', --������ݡ���ʬ��     
                                         v_DIAGNOSTICBASIS3        varchar default '', --������ݡ����������     
                                         v_DIAGNOSTICBASIS4        varchar default '', --������ݡ���������顪������     
                                         v_DIAGNOSTICBASIS5        varchar default '', --������ݡ���Ⱦɫ��      
                                         v_DIAGNOSTICBASIS6        varchar default '', --������ݡ�������     
                                         v_DIAGNOSTICBASIS7        varchar default '', --������ݡ���������������     
                                         v_DIAG_ANENCEPHALY        varchar default '', --����ȱ����ϡ������Ի���     
                                         v_DIAG_SPINA              varchar default '', --����ȱ����ϡ���������      
                                         v_DIAG_PENGOUT            varchar default '', --����ȱ����ϡ��������      
                                         v_DIAG_HYDROCEPHALUS      varchar default '', --����ȱ����ϡ����������Ի�ˮ     
                                         v_DIAG_CLEFTPALATE        varchar default '', --����ȱ����ϡ�������     
                                         v_DIAG_CLEFTLIP           varchar default '', --����ȱ����ϡ�������      
                                         v_DIAG_CLEFTMERGER        varchar default '', --����ȱ����ϡ������Ѻϲ�����     
                                         v_DIAG_SMALLEARS          varchar default '', --����ȱ����ϡ���С���������޶���     
                                         v_DIAG_OUTEREAR           varchar default '', --����ȱ����ϡ�������������Σ�С�����޶����⣩     
                                         v_DIAG_ESOPHAGEAL         varchar default '', --����ȱ����ϡ���ʳ����������խ     
                                         v_DIAG_RECTUM             varchar default '', --����ȱ����ϡ���ֱ�����ű�������խ�������޸أ�     
                                         v_DIAG_HYPOSPADIAS        varchar default '', --����ȱ����ϡ����������     
                                         v_DIAG_BLADDER            varchar default '', --����ȱ����ϡ��������ⷭ     
                                         v_DIAG_HORSESHOEFOOTLEFT  varchar default '', --����ȱ����ϡ��������ڷ���_��      
                                         v_DIAG_HORSESHOEFOOTRIGHT varchar default '', --����ȱ����ϡ��������ڷ���_��     
                                         v_DIAG_MANYPOINTLEFT      varchar default '', --����ȱ����ϡ�����ָ��ֺ��_��      
                                         v_DIAG_MANYPOINTRIGHT     varchar default '', --����ȱ����ϡ�����ָ��ֺ��_��     
                                         v_DIAG_LIMBSUPPERLEFT     varchar default '', --����ȱ����ϡ���֫�����_��֫ _��      
                                         v_DIAG_LIMBSUPPERRIGHT    varchar default '', --����ȱ����ϡ���֫�����_��֫ _��     
                                         v_DIAG_LIMBSLOWERLEFT     varchar default '', --����ȱ����ϡ���֫�����_��֫ _��      
                                         v_DIAG_LIMBSLOWERRIGHT    varchar default '', --����ȱ����ϡ���֫�����_��֫ _��     
                                         v_DIAG_HERNIA             varchar default '', --����ȱ����ϡ�������������     
                                         v_DIAG_BULGINGBELLY       varchar default '', --����ȱ����ϡ��������     
                                         v_DIAG_GASTROSCHISIS      varchar default '', --����ȱ����ϡ�������     
                                         v_DIAG_TWINS              varchar default '', --����ȱ����ϡ�������˫̥     
                                         v_DIAG_TSSYNDROME         varchar default '', --����ȱ����ϡ��������ۺ�����21-�����ۺ�����     
                                         v_DIAG_HEARTDISEASE       varchar default '', --����ȱ����ϡ������������ಡ�����ͣ�      
                                         v_DIAG_OTHER              varchar default '', --����ȱ����ϡ���������д����������ϸ������      
                                         v_DIAG_OTHERCONTENT       varchar default '', --����ȱ����ϡ�����������      
                                         v_FEVER                   varchar default '', --���գ���38�棩      
                                         v_VIRUSINFECTION          varchar default '', --������Ⱦ     
                                         v_ILLOTHER                varchar default '', --��������     
                                         v_SULFA                   varchar default '', --�ǰ���     
                                         v_ANTIBIOTICS             varchar default '', --������     
                                         v_BIRTHCONTROLPILL        varchar default '', --����ҩ      
                                         v_SEDATIVES               varchar default '', --��ҩ     
                                         v_MEDICINEOTHER           varchar default '', --��ҩ����      
                                         v_DRINKING                varchar default '', --����     
                                         v_PESTICIDE               varchar default '', --ũҩ      
                                         v_RAY                     varchar default '', --����      
                                         v_CHEMICALAGENTS          varchar default '', --��ѧ�Ƽ�     
                                         v_FACTOROTHER             varchar default '', --�����к�����      
                                         v_STILLBIRTHNO            varchar default '', --��̥����     
                                         v_ABORTIONNO              varchar default '', --��Ȼ��������     
                                         v_DEFECTSNO               varchar default '', --ȱ�ݶ�����     
                                         v_DEFECTSOF1              varchar default '', --ȱ����1     
                                         v_DEFECTSOF2              varchar default '', --ȱ����2     
                                         v_DEFECTSOF3              varchar default '', --ȱ����3     
                                         v_YCDEFECTSOF1            varchar default '', --�Ŵ�ȱ����1     
                                         v_YCDEFECTSOF2            varchar default '', --�Ŵ�ȱ����2     
                                         v_YCDEFECTSOF3            varchar default '', --�Ŵ�ȱ����3     
                                         v_KINSHIPDEFECTS1         varchar default '', --��ȱ�ݶ���Ե��ϵ1     
                                         v_KINSHIPDEFECTS2         varchar default '', --��ȱ�ݶ���Ե��ϵ2     
                                         v_KINSHIPDEFECTS3         varchar default '', --��ȱ�ݶ���Ե��ϵ3     
                                         v_COUSINMARRIAGE          varchar default '', --���׻���ʷ      
                                         v_COUSINMARRIAGEBETWEEN   varchar default '', --���׻���ʷ��ϵ     
                                         v_PREPARER                varchar default '', --�����      
                                         v_THETITLE1               varchar default '', --�����ְ��     
                                         v_FILLDATEYEAR            varchar default '', --���������      
                                         v_FILLDATEMONTH           varchar default '', --���������     
                                         v_FILLDATEDAY             varchar default '', --���������     
                                         v_HOSPITALREVIEW          varchar default '', --ҽԺ�����      
                                         v_THETITLE2               varchar default '', --ҽԺ�����ְ��     
                                         v_HOSPITALAUDITDATEYEAR   varchar default '', --ҽԺ���������     
                                         v_HOSPITALAUDITDATEMONTH  varchar default '', --ҽԺ���������      
                                         v_HOSPITALAUDITDATEDAY    varchar default '', --ҽԺ���������      
                                         v_PROVINCIALVIEW          varchar default '', --ʡ�������      
                                         v_THETITLE3               varchar default '', --ʡ�������ְ��     
                                         v_PROVINCIALVIEWDATEYEAR  varchar default '', --ʡ�����������      
                                         v_PROVINCIALVIEWDATEMONTH varchar default '', --ʡ�����������     
                                         v_PROVINCIALVIEWDATEDAY   varchar default '', --ʡ�����������     
                                         v_FEVERNO                 varchar default '', --���ն���      
                                         v_ISVIRUSINFECTION        varchar default '', --�Ƿ񲡶���Ⱦ     
                                         v_ISDIABETES              varchar default '', --�Ƿ�����      
                                         v_ISILLOTHER              varchar default '', --�Ƿ񻼲�����     
                                         v_ISSULFA                 varchar default '', --�Ƿ�ǰ���     
                                         v_ISANTIBIOTICS           varchar default '', --�Ƿ�����     
                                         v_ISBIRTHCONTROLPILL      varchar default '', --�Ƿ����ҩ      
                                         v_ISSEDATIVES             varchar default '', --�Ƿ���ҩ     
                                         v_ISMEDICINEOTHER         varchar default '', --�Ƿ��ҩ����      
                                         v_ISDRINKING              varchar default '', --�Ƿ�����     
                                         v_ISPESTICIDE             varchar default '', --�Ƿ�ũҩ      
                                         v_ISRAY                   varchar default '', --�Ƿ�����      
                                         v_ISCHEMICALAGENTS        varchar default '', --�Ƿ�ѧ�Ƽ�     
                                         v_ISFACTOROTHER           varchar default '', --�Ƿ������к�����      
                                         v_STATE                   varchar default '', -- "����״̬�� 1���������� 2���ύ 3������ 4��?to open this dialog next """     
                                         v_CREATE_DATE             varchar default '', --����ʱ��      
                                         v_CREATE_USERCODE         varchar default '', --������     
                                         v_CREATE_USERNAME         varchar default '', ---������      
                                         v_CREATE_DEPTCODE         varchar default '', --�����˿���     
                                         v_CREATE_DEPTNAME         varchar default '', --�����˿���     
                                         v_MODIFY_DATE             varchar default '', --�޸�ʱ��      
                                         v_MODIFY_USERCODE         varchar default '', --�޸���     
                                         v_MODIFY_USERNAME         varchar default '', --�޸���     
                                         v_MODIFY_DEPTCODE         varchar default '', --�޸��˿���     
                                         v_MODIFY_DEPTNAME         varchar default '', --�޸��˿���     
                                         v_AUDIT_DATE              varchar default '', --���ʱ��     
                                         v_AUDIT_USERCODE          varchar default '', --�����      
                                         v_AUDIT_USERNAME          varchar default '', --�����      
                                         v_AUDIT_DEPTCODE          varchar default '', --����˿���      
                                         v_AUDIT_DEPTNAME          varchar default '', --����˿���      
                                         v_VAILD                   varchar default '', --״̬�Ƿ���Ч  1����Ч   0����Ч     
                                         v_CANCELREASON            varchar default '', --���ԭ��     
                                         v_PRENATAL                varchar default '', --��ǰ     
                                         v_PRENATALNO              varchar default '', --��ǰ����     
                                         v_POSTPARTUM              varchar default '', --����     
                                         v_ANDTOSHOWLEFT           varchar default '', --��ָ��     
                                         v_ANDTOSHOWRIGHT          varchar default '', --��ָ��
                                         o_result                  OUT empcurtyp);

  --������---�����Ǽ��±��� add by ywk 2013��7��31�� 14:59:19
  PROCEDURE usp_GetTheriomaReportBYMonth( --v_searchtype varchar default '',--���Ӵ��ֶ���Ҫ����Ϊi��������ҽԺ�������Ĳ�ѯ
                                         v_year          varchar default '', --��
                                         v_month         varchar default '', --��
                                         v_deptcode      varchar default '', --���ұ���
                                         v_diagstartdate varchar default '', --��Ͽ�ʼʱ��
                                         v_diagenddate   varchar default '', --��Ͻ���ʱ��
                                         o_result        OUT empcurtyp);

  --������---���������·������Ǽǲ� add by ywk 2013��8��2�� 11:29:02
  PROCEDURE usp_GetTheriomaReportBYNew( --v_searchtype varchar default '',--���Ӵ��ֶ���Ҫ����Ϊi��������ҽԺ�������Ĳ�ѯ
                                       v_year   varchar default '', --��
                                       v_month  varchar default '', --��
                                       o_result OUT empcurtyp);

  --������---�����������������Ǽǲ� add by ywk 2013��8��2�� 11:29:02
  PROCEDURE usp_GetTheriomaReportBYDead( --v_searchtype varchar default '',--���Ӵ��ֶ���Ҫ����Ϊi��������ҽԺ�������Ĳ�ѯ
                                        v_year   varchar default '', --��
                                        v_month  varchar default '', --��
                                        o_result OUT empcurtyp);

  --������---�����Ǽ��±��� add by ywk 2013��8��5�� 11:32:52����ҽԺ
  PROCEDURE usp_GetTheriomaReportBYMonthZX( --v_searchtype varchar default '',--���Ӵ��ֶ���Ҫ����Ϊi��������ҽԺ�������Ĳ�ѯ
                                           v_year          varchar default '', --��
                                           v_month         varchar default '', --��
                                           v_deptcode      varchar default '', --���ұ���
                                           v_diagstartdate varchar default '', --��Ͽ�ʼʱ��
                                           v_diagenddate   varchar default '', --��Ͻ���ʱ��
                                           o_result        OUT empcurtyp);
                                           
   --������---�����Ǽ��±��� add by jxh 2013��9��12�� 14:05:52����ҽԺ
  PROCEDURE usp_CardiovascularReport( --v_searchtype varchar default '',--���Ӵ��ֶ���Ҫ����Ϊi��������ҽԺ�������Ĳ�ѯ
                                           v_year          varchar default '', --��
                                           v_month         varchar default '', --��
                                           v_deptcode      varchar default '', --���ұ���
                                           v_diagstartdate varchar default '', --��Ͽ�ʼʱ��
                                           v_diagenddate   varchar default '', --��Ͻ���ʱ��
                                           o_result        OUT empcurtyp);

  --������޸İ��̲�����
  --������޸İ��̲�����
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

  --������޸�ɳ����ԭ���Ⱦ
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

  --������޸��Ҹα����
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

  -- -������޸ļ���ʪ����Ŀ
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
  --������޸ļ���H1N1���б���
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

  --������޸�����ڲ������
  PROCEDURE usp_AddOrModHFMDReport(v_HFMDID     varchar2,
                                   v_REPORTID   integer,
                                   v_LABRESULT  varchar2,
                                   v_ISSEVERE   varchar2,
                                   v_VAILD      varchar2,
                                   v_CREATOR    varchar2,
                                   v_CREATEDATE varchar2,
                                   v_MENDER     varchar2,
                                   v_ALTERDATE  varchar2);

  --������޸�AFP�����
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

  /*���벡����ҳ��Ϣ*/
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

  /*�޸Ĳ�����ҳ��Ϣ*/
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
  * ���빦������ҳ���TABLE
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
  * ���빦������ҳ����TABLE
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
  * ���빦������ҳ ����Ӥ����Ϣ
  */
  PROCEDURE usp_insert_iem_main_ObsBaby(v_iem_mainpage_no NUMERIC,
                                        v_IBSBABYID       VARCHAR, --���
                                        v_TC              VARCHAR, --̥��
                                        v_CC              VARCHAR, -- ����
                                        v_TB              VARCHAR, -- ̥��
                                        v_CFHYPLD         VARCHAR, --�����������Ѷ�
                                        v_MIDWIFERY       VARCHAR, --�Ӳ���
                                        v_SEX             VARCHAR, --�Ա�
                                        v_APJ             VARCHAR, -- ����������
                                        v_HEIGH           VARCHAR, --��
                                        v_WEIGHT          VARCHAR, --����
                                        v_CCQK            VARCHAR, --�������
                                        v_BITHDAY         VARCHAR, --����ʱ��
                                        v_FMFS            VARCHAR, --     ���䷽ʽ
                                        v_CYQK            VARCHAR,
                                        v_create_user     VARCHAR);

  /*
  * ����һ��������Ϣ
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
  * �̳����е����ݹ������������ӡ
  */
  PROCEDURE usp_get_iem_mainpage_all(
                                     --      v_noofinpat             VARCHAR,
                                     o_result  OUT empcurtyp,
                                     o_result1 OUT empcurtyp,
                                     o_result2 OUT empcurtyp);

  /*
  * ��ȡ������ҳ��Ϣ
  */
  PROCEDURE usp_GetIemInfo_new(v_NoOfInpat int,
                               o_result    OUT empcurtyp,
                               o_result1   OUT empcurtyp,
                               o_result2   OUT empcurtyp,
                               o_result3   OUT empcurtyp);

  /*
  * ά��������ҳ��Ϣ
  */
  PROCEDURE usp_Edit_Iem_BasicInfo_2012(v_edittype        varchar2 default '',
                                        v_IEM_MAINPAGE_NO varchar2 default '', ---- '������ҳ��ʶ';
                                        v_PATNOOFHIS      varchar2 default '', ---- '������';
                                        v_NOOFINPAT       varchar2 default '', ---- '������ҳ���';
                                        v_PAYID           varchar2 default '', ---- 'ҽ�Ƹ��ʽID';
                                        v_SOCIALCARE      varchar2 default '', ---- '�籣����';
                                        
                                        v_INCOUNT varchar2 default '', ---- '��Ժ����';
                                        v_NAME    varchar2 default '', ---- '��������';
                                        v_SEXID   varchar2 default '', ---- '�Ա�';
                                        v_BIRTH   varchar2 default '', ---- '����';
                                        v_MARITAL varchar2 default '', ---- '����״�� 1.δ�� 2.�ѻ� 3.ɥż4.��� 9.����';
                                        
                                        v_JOBID         varchar2 default '', ---- 'ְҵ';
                                        v_NATIONALITYID varchar2 default '', ---- '����ID';
                                        v_NATIONID      varchar2 default '', --����
                                        v_IDNO          varchar2 default '', ---- '���֤����';
                                        v_ORGANIZATION  varchar2 default '', ---- '������λ';
                                        v_OFFICEPLACE   varchar2 default '', ---- '������λ��ַ';
                                        
                                        v_OFFICETEL      varchar2 default '', ---- '������λ�绰';
                                        v_OFFICEPOST     varchar2 default '', ---- '������λ�ʱ�';
                                        v_CONTACTPERSON  varchar2 default '', ---- '��ϵ������';
                                        v_RELATIONSHIP   varchar2 default '', ---- '����ϵ�˹�ϵ';
                                        v_CONTACTADDRESS varchar2 default '', ---- '��ϵ�˵�ַ';
                                        
                                        v_CONTACTTEL varchar2 default '', ---- '��ϵ�˵绰';
                                        v_ADMITDATE  varchar2 default '', ---- '��Ժʱ��';
                                        v_ADMITDEPT  varchar2 default '', ---- '��Ժ����';
                                        v_ADMITWARD  varchar2 default '', ---- '��Ժ����';
                                        v_TRANS_DATE varchar2 default '', ---- 'תԺʱ��';
                                        
                                        v_TRANS_ADMITDEPT varchar2 default '', ---- 'תԺ�Ʊ�';
                                        v_TRANS_ADMITWARD varchar2 default '', ---- 'תԺ����';
                                        v_OUTWARDDATE     varchar2 default '', ---- '��Ժʱ��';
                                        v_OUTHOSDEPT      varchar2 default '', ---- '��Ժ����';
                                        v_OUTHOSWARD      varchar2 default '', ---- '��Ժ����';
                                        
                                        v_ACTUALDAYS               varchar2 default '', ---- 'ʵ��סԺ����';
                                        v_PATHOLOGY_DIAGNOSIS_NAME varchar2 default '', ---- '�����������';
                                        v_PATHOLOGY_OBSERVATION_SN varchar2 default '', ---- '������� ';
                                        v_ALLERGIC_DRUG            varchar2 default '', ---- '����ҩ��';
                                        v_SECTION_DIRECTOR         varchar2 default '', ---- '������';
                                        
                                        v_DIRECTOR               varchar2 default '', ---- '������������ҽʦ';
                                        v_VS_EMPLOYEE_CODE       varchar2 default '', ---- '����ҽʦ';
                                        v_RESIDENT_EMPLOYEE_CODE varchar2 default '', ---- 'סԺҽʦ';
                                        v_REFRESH_EMPLOYEE_CODE  varchar2 default '', ---- '����ҽʦ';
                                        v_DUTY_NURSE             varchar2 default '', ---- '���λ�ʿ';
                                        
                                        v_INTERNE                varchar2 default '', ---- 'ʵϰҽʦ';
                                        v_CODING_USER            varchar2 default '', ---- '����Ա';
                                        v_MEDICAL_QUALITY_ID     varchar2 default '', ---- '��������';
                                        v_QUALITY_CONTROL_DOCTOR varchar2 default '', ---- '�ʿ�ҽʦ';
                                        v_QUALITY_CONTROL_NURSE  varchar2 default '', ---- '�ʿػ�ʿ';
                                        
                                        v_QUALITY_CONTROL_DATE varchar2 default '', ---- '�ʿ�ʱ��';
                                        v_XAY_SN               varchar2 default '', ---- 'x�߼���';
                                        v_CT_SN                varchar2 default '', ---- 'CT����';
                                        v_MRI_SN               varchar2 default '', ---- 'mri����';
                                        v_DSA_SN               varchar2 default '', ---- 'Dsa����';
                                        
                                        v_BLOODTYPE      varchar2 default '', ---- 'Ѫ��';
                                        v_RH             varchar2 default '', ---- 'Rh';
                                        v_IS_COMPLETED   varchar2 default '', ---- '��ɷ� y/n ';
                                        v_COMPLETED_TIME varchar2 default '', ---- '���ʱ��';
                                        v_VALIDE         varchar2 default '1', ---- '���Ϸ� 1/0';
                                        
                                        v_CREATE_USER   varchar2 default '', ---- '�����˼�¼��';
                                        v_CREATE_TIME   varchar2 default '', ---- '����ʱ��';
                                        v_MODIFIED_USER varchar2 default '', ---- '�޸Ĵ˼�¼��';
                                        v_MODIFIED_TIME varchar2 default '', ---- '�޸�ʱ��';
                                        v_ZYMOSIS       varchar2 default '', ---- 'ҽԺ��Ⱦ��';
                                        
                                        v_HURT_TOXICOSIS_ELE_ID   varchar2 default '', ---- '���ˡ��ж����ⲿ����';
                                        v_HURT_TOXICOSIS_ELE_Name varchar2 default '', ---- '���ˡ��ж����ⲿ����';
                                        v_ZYMOSISSTATE            varchar2 default '', ---- 'ҽԺ��Ⱦ��״̬';
                                        v_PATHOLOGY_DIAGNOSIS_ID  varchar2 default '', ---- '������ϱ��';
                                        v_MONTHAGE                varchar2 default '', ---- '�����䲻��1����ģ� ����(��)';
                                        v_WEIGHT                  varchar2 default '', ---- '��������������(��)';
                                        
                                        v_INWEIGHT         varchar2 default '', ---- '��������Ժ����(��)';
                                        v_INHOSTYPE        varchar2 default '', ---- '��Ժ;��:1.����  2.����  3.����ҽ�ƻ���ת��  9.����';
                                        v_OUTHOSTYPE       varchar2 default '', ---- '��Ժ��ʽ �� 1.ҽ����Ժ  2.ҽ��תԺ 3.ҽ��ת���������������/��������Ժ 4.��ҽ����Ժ5.����9.����';
                                        v_RECEIVEHOSPITAL  varchar2 default '', ---- '2.ҽ��תԺ�������ҽ�ƻ������ƣ�';
                                        v_RECEIVEHOSPITAL2 varchar2 default '', ---- '3.ҽ��ת���������������/��������Ժ�������ҽ�ƻ�����;
                                        
                                        v_AGAININHOSPITAL       varchar2 default '', ---- '�Ƿ��г�Ժ31������סԺ�ƻ� �� 1.��  2.��';
                                        v_AGAININHOSPITALREASON varchar2 default '', ---- '��Ժ31������סԺ�ƻ� Ŀ��:            ';
                                        v_BEFOREHOSCOMADAY      varchar2 default '', ---- '­�����˻��߻���ʱ�䣺 ��Ժǰ    ��';
                                        v_BEFOREHOSCOMAHOUR     varchar2 default '', ---- '­�����˻��߻���ʱ�䣺 ��Ժǰ     Сʱ';
                                        v_BEFOREHOSCOMAMINUTE   varchar2 default '', ---- '­�����˻��߻���ʱ�䣺 ��Ժǰ    ����';
                                        
                                        v_LATERHOSCOMADAY    varchar2 default '', ---- '­�����˻��߻���ʱ�䣺 ��Ժ��    ��';
                                        v_LATERHOSCOMAHOUR   varchar2 default '', ---- '­�����˻��߻���ʱ�䣺 ��Ժ��    Сʱ';
                                        v_LATERHOSCOMAMINUTE varchar2 default '', ---- '­�����˻��߻���ʱ�䣺 ��Ժ��    ����';
                                        v_CARDNUMBER         varchar2 default '', ---- '��������';
                                        v_ALLERGIC_FLAG      varchar2 default '', ---- 'ҩ�����1.�� 2.��';
                                        
                                        v_AUTOPSY_FLAG     varchar2 default '', ---- '��������ʬ�� �� 1.��  2.��';
                                        v_CSD_PROVINCEID   varchar2 default '', ---- '������ ʡ';
                                        v_CSD_CITYID       varchar2 default '', ---- '������ ��';
                                        v_CSD_DISTRICTID   varchar2 default '', ---- '������ ��';
                                        v_CSD_PROVINCENAME varchar2 default '', ---- '������ ʡ����';
                                        
                                        v_CSD_CITYNAME     varchar2 default '', ---- '������ ������';
                                        v_CSD_DISTRICTNAME varchar2 default '', ---- '������ ������';
                                        v_XZZ_PROVINCEID   varchar2 default '', ---- '��סַ ʡ';
                                        v_XZZ_CITYID       varchar2 default '', ---- '��סַ ��';
                                        v_XZZ_DISTRICTID   varchar2 default '', ---- '��סַ ��';
                                        
                                        v_XZZ_PROVINCENAME varchar2 default '', ---- '��סַ ʡ����';
                                        v_XZZ_CITYNAME     varchar2 default '', ---- '��סַ ������';
                                        v_XZZ_DISTRICTNAME varchar2 default '', ---- '��סַ ������';
                                        v_XZZ_TEL          varchar2 default '', ---- '��סַ �绰';
                                        v_XZZ_POST         varchar2 default '', ---- '��סַ �ʱ�';
                                        
                                        v_HKDZ_PROVINCEID   varchar2 default '', ---- '���ڵ�ַ ʡ';
                                        v_HKDZ_CITYID       varchar2 default '', ---- '���ڵ�ַ ��';
                                        v_HKDZ_DISTRICTID   varchar2 default '', ---- '���ڵ�ַ ��';
                                        v_HKDZ_PROVINCENAME varchar2 default '', ---- '���ڵ�ַ ʡ����';
                                        v_HKDZ_CITYNAME     varchar2 default '', ---- '���ڵ�ַ ������';
                                        
                                        v_HKDZ_DISTRICTNAME     varchar2 default '', ---- '���ڵ�ַ ������';
                                        v_HKDZ_POST             varchar2 default '', ---- '�������ڵ��ʱ�';
                                        v_JG_PROVINCEID         varchar2 default '', ---- '���� ʡ����';
                                        v_JG_CITYID             varchar2 default '', ---- '���� ������';
                                        v_JG_PROVINCENAME       varchar2 default '', ---- '���� ʡ����';
                                        v_JG_CITYNAME           varchar2 default '', ---- '���� ������'
                                        v_Age                   varchar2 default '',
                                        v_zg_flag               varchar2 default '', -----ת�飺�� 1.���� 2.��ת 3.δ�� 4.���� 5.����
                                        v_admitinfo             varchar2 default '', --  v��Ժ����� 1.Σ 2.�� 3.һ�� 4.�� add ����һ�������¶�ʮ���� 10:14:09
                                        v_CSDADDRESS            varchar2 default '', --�����ؾ����ַ add by ywk 2012��7��11�� 10:13:49
                                        v_JGADDRESS             varchar2 default '', --�����ַ�����ַ add by ywk 2012��7��11�� 10:13:49
                                        v_XZZADDRESS            varchar2 default '', --��סַ�����ַ add by ywk 2012��7��11�� 10:13:49
                                        v_HKDZADDRESS           varchar2 default '', --���ڵ�ַ�����ַ add by ywk 2012��7��11�� 10:13:49
                                        v_MenAndInHop           varchar, --�����סԺ
                                        v_InHopAndOutHop        varchar, --��Ժ�ͳ�Ժ
                                        v_BeforeOpeAndAfterOper varchar, --��ǰ������
                                        v_LinAndBingLi          varchar, --�ٴ��벡��
                                        v_InHopThree            varchar, --��Ժ������
                                        v_FangAndBingLi         varchar, --����Ͳ���
                                        o_result                OUT empcurtyp);

  /*
  *��ѯ������ҳ��Ϣ
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
                                           v_IsChooseDate    varchar, --��������ֶ�
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
                                           v_MenAndInHop           varchar, --�����סԺ
                                           v_InHopAndOutHop        varchar, --��Ժ�ͳ�Ժ
                                           v_BeforeOpeAndAfterOper varchar, --��ǰ������
                                           v_LinAndBingLi          varchar, --�ٴ��벡��
                                           v_InHopThree            varchar, --��Ժ������
                                           v_FangAndBingLi         varchar, --����Ͳ���
                                           v_AdmitInfo             varchar --����Ժ����
                                           --v_Create_Time varchar(19) ,
                                           --v_Cancel_User varchar(10) ,
                                           --v_Cancel_Time varchar(19)
                                           );
                                           
 ------------------------������ҳר�ô洢���� add jxh-----------------------------------------------------------------------------------------------
  PROCEDURE usp_edif_iem_mainpage_diag_hb(v_iem_mainpage_no   VARCHAR,
                                           v_diagnosis_type_id VARCHAR,
                                           v_diagnosis_code    VARCHAR,
                                           v_diagnosis_name    VARCHAR,
                                           v_status_id         VARCHAR,
                                           v_order_value       VARCHAR,
                                           v_morphologyicd     VARCHAR,--��̬ѧ��ϱ���
                                           v_morphologyname    VARCHAR,--��̬ѧ�������                                 
                                           --v_Valide numeric ,
                                           v_create_user           VARCHAR,
                                           v_MenAndInHop           varchar, --�����סԺ
                                           v_InHopAndOutHop        varchar, --��Ժ�ͳ�Ժ
                                           v_BeforeOpeAndAfterOper varchar, --��ǰ������
                                           v_LinAndBingLi          varchar, --�ٴ��벡��
                                           v_InHopThree            varchar, --��Ժ������
                                           v_FangAndBingLi         varchar, --����Ͳ���
                                           v_AdmitInfo             varchar --����Ժ���� 
                                           --v_Create_Time varchar(19) ,
                                           --v_Cancel_User varchar(10) ,
                                           --v_Cancel_Time varchar(19)
                                           );                                         

  --���²�����ҳ��Ϣ�󣬶Բ�����Ϣ���������ͬ�� add by ywk ����һ������������ 15:20:27
  PROCEDURE usp_Edit_Iem_PaientInfo(v_NOOFINPAT      varchar2 default '', ---- '������ҳ���';
                                    v_NAME           varchar2 default '', ---- '��������';
                                    v_SEXID          varchar2 default '', ---- '�Ա�';
                                    v_BIRTH          varchar2 default '', ---- '����';
                                    v_Age            INTEGER default '', --����
                                    v_IDNO           varchar2 default '', ---- '���֤����';
                                    v_MARITAL        varchar2 default '', ---- '����״�� 1.δ�� 2.�ѻ� 3.ɥż4.��� 9.����';
                                    v_JOBID          varchar2 default '', ---- 'ְҵ';
                                    v_CSD_PROVINCEID varchar2 default '', ---- '������ ʡ';
                                    v_CSD_CITYID     varchar2 default '', ---- '������ ��';
                                    v_NATIONID       varchar2 default '', --����
                                    v_NATIONALITYID  varchar2 default '', ---- '����ID';
                                    v_JG_PROVINCEID  varchar2 default '', ---- '���� ʡ';
                                    v_JG_CITYID      varchar2 default '', ---- '���� ��';
                                    v_OFFICEPLACE    varchar2 default '', ---- '������λ��ַ';
                                    v_OFFICETEL      varchar2 default '', ---- '������λ�绰';
                                    v_OFFICEPOST     varchar2 default '', ---- '������λ�ʱ�';
                                    v_HKDZ_POST      varchar2 default '', ---- '�������ڵ��ʱ�';
                                    v_CONTACTPERSON  varchar2 default '', ---- '��ϵ������';
                                    v_RELATIONSHIP   varchar2 default '', ---- '����ϵ�˹�ϵ';
                                    v_CONTACTADDRESS varchar2 default '', ---- '��ϵ�˵�ַ';
                                    v_CONTACTTEL     varchar2 default '', ---- '��ϵ�˵绰';
                                    v_ADMITDEPT      varchar2 default '', ---- '��Ժ����';
                                    v_ADMITWARD      varchar2 default '', ---- '��Ժ����';
                                    v_ADMITDATE      varchar2 default '', ---- '��Ժʱ��';
                                    v_OUTWARDDATE    varchar2 default '', ---- '��Ժʱ��';
                                    v_OUTHOSDEPT     varchar2 default '', ---- '��Ժ����';
                                    v_OUTHOSWARD     varchar2 default '', ---- '��Ժ����';
                                    v_ACTUALDAYS     varchar2 default '', ---- 'ʵ��סԺ����';
                                    v_AgeStr         varchar2 default '', ---- '���� ��ȷ������;2012��5��9��9:31:03 ����ά�� �����޸ģ�
                                    v_PatId          varchar2 default '', --�����ĸ��ʽ add by ywk 2012��5��14�� 16:02:13
                                    v_CardNo         varchar2 default '', --��������
                                    
                                    -----add by ywk  2012��5��16��9:45:27 Inpatient��l�����Ӳ�����ҳ����Ӧ���ֶ�
                                    v_Districtid     varchar2 default '', --�����ء��ء�
                                    v_xzzproviceid   varchar2 default '', --����סַʡ
                                    v_xzzcityid      varchar2 default '', --����סַ��
                                    v_xzzdistrictid  varchar2 default '', --����סַ��
                                    v_xzztel         varchar2 default '', --����סַ�绰
                                    v_hkdzproviceid  varchar2 default '', --����סַʡ
                                    v_hkzdcityid     varchar2 default '', --����סַ��
                                    v_hkzddistrictid varchar2 default '', --����סַ��
                                    v_xzzpost        varchar2 default '', --��סַ�ʱ�
                                    v_isupdate       varchar2 default '', ---2012��5��24�� 17:19:10 ywk �Ƿ�������֤���ֶ�
                                    /*  v_csdprovicename   varchar2 default '',      --������ʡ����
                                                                                                                                                                                               v_csdcityname   varchar2 default '',      --������������
                                                                                                                                                                                               v_csddistrictname  varchar2 default '',---������������
                                                                                                                                                                                                 v_jgprovicename  varchar2 default '',---����ʡ����
                                                                                                                                                                                                 v_jgcityname  varchar2 default '',---����������
                                                                                                                                                                                                 v_xzzprovicename  varchar2 default '',---��סַʡ����
                                                                                                                                                                                                   v_xzzcityname  varchar2 default '',---��סַ������
                                                                                                                                                                                                    v_xzzdistrictname  varchar2 default '',---��סַ������
                                                                                                                                                                                                    v_hkzzprovicename    varchar2 default '',---����סַʡ����
                                                                                                                                                                                               v_hkzzcityname      varchar2 default '',---����סַ������
                                                                                                                                                                                               v_hkzzdistrictname    varchar2 default ''---����סַ������*/
                                    v_CSDADDRESS  varchar2 default '', --�����ؾ����ַ add by ywk 2012��7��11�� 10:13:49
                                    v_JGADDRESS   varchar2 default '', --�����ַ�����ַ add by ywk 2012��7��11�� 10:13:49
                                    v_XZZADDRESS  varchar2 default '', --��סַ�����ַ add by ywk 2012��7��11�� 10:13:49
                                    v_HKDZADDRESS varchar2 default '' --���ڵ�ַ�����ַ add by ywk 2012��7��11�� 10:13:49
                                    ,v_XZZDetailAddr varchar2 default '', --��סַ��ϸ��ַ(�ؼ�����) add by cyq 2012-12-27
                                    v_HKDZDetailAddr varchar2 default '' --���ڵ�ַ��ϸ��ַ(�ؼ�����) add by cyq 2012-12-27
                                    );

  --�����ҳĬ�ϱ��������
  --add by ywk 2012��5��17�� 09:36:46

  PROCEDURE usp_GetDefaultInpatient(o_result OUT empcurtyp);
  --���ݲ�����ҳ��š�ȡ�ò��˵���Ϣ ������䲡����ҳ
  PROCEDURE usp_GetInpatientByNo(v_noofinpat varchar2 default '',
                                 o_result    OUT empcurtyp);

  /*
  * ά��������ҳ�ķ�����Ϣ
  add by ywk 2012��10��16�� 19:29:53
  */
  PROCEDURE usp_editiem_mainpage_feeinfo(v_edittype        varchar2 default '',
                                         v_IEM_MAINPAGE_NO varchar2 default '', ---- '������ҳ��ʶ';
                                         v_TotalFee        varchar2 default '', ---- �ܷ���;
                                         v_OwnerFee        varchar2 default '', ---- '�Ը����
                                         v_YbMedServFee    varchar2 default '', ---- һ��ҽ�Ʒ����
                                         v_YbMedOperFee    varchar2 default '', ---- һ�����Ʋ�����
                                         v_NurseFee        varchar2 default '', ----�����
                                         v_OtherInfo       varchar2 default '', ---- �ۺ��� ��������
                                         v_BLZDFee         varchar2 default '', ---- ����� ������Ϸ�
                                         v_SYSZDFee        varchar2 default '', ---- ʵ������Ϸ�
                                         v_YXXZDFee        varchar2 default '', ----  ����� Ӱ��ѧ��Ϸ�
                                         v_LCZDItemFee     varchar2 default '', ----  ����� �ٴ������Ŀ��
                                         v_FSSZLItemFee    varchar2 default '', ----  ������������Ŀ��
                                         v_LCWLZLFee       varchar2 default '', ---- ������ �ٴ��������Ʒ�
                                         v_OperMedFee      varchar2 default '', ----������ �������Ʒ�
                                         v_KFFee           varchar2 default '', ----������ ������
                                         v_ZYZLFee         varchar2 default '', ----��ҽ�� ��ҽ���Ʒ�
                                         v_XYMedFee        varchar2 default '', ---��ҩ�� ��ҩ��
                                         v_KJYWFee         varchar2 default '', ---��ҩ�� ����ҩ�����
                                         v_ZCYFFee         varchar2 default '', ---��ҩ�� �г�ҩ��
                                         v_ZCaoYFFee       varchar2 default '', ---��ҩ�� �в�ҩ��
                                         v_BloodFee        varchar2 default '', ---ѪҺ��ѪҺ��Ʒ�� Ѫ��
                                         v_BDBLZPFFee      varchar2 default '', ---ѪҺ��ѪҺ��Ʒ�� �׵�������Ʒ��
                                         v_QDBLZPFFee      varchar2 default '', ---�򵰰�����Ʒ��
                                         v_NXYZLZPFFee     varchar2 default '', ---ѪҺ��ѪҺ��Ʒ�� ��Ѫ��������Ʒ��
                                         v_XBYZLZPFFee     varchar2 default '', ---ϸ����������Ʒ��
                                         v_JCYYCXYYCLFFee  varchar2 default '', -- �����һ����ҽ�ò��Ϸ�
                                         v_ZLYYCXYYCLFFee  varchar2 default '', -- /�Ĳ��� ������һ����ҽ�ò��Ϸ�
                                         v_SSYYCXYYCLFFee  varchar2 default '', -- ���� ������һ����ҽ�ò��Ϸ�
                                         v_QTFee           varchar2 default '', -- �����ࣺ��24��������        
                                         v_Memo1           varchar2 default '', -- Ԥ���ֶ�   1    
                                         v_Memo2           varchar2 default '', -- Ԥ���ֶ�    2  
                                          v_Memo3           varchar2 default '', -- Ԥ���ֶ�     3 
                                          v_MaZuiFee           varchar2 default '', -- �����
                                         v_ShouShuFee           varchar2 default ''-- ������ 
                                             
                                                                            );
                                                                            
  
  ----����������ҳ�Զ��������ñ�                                                              
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
  * ���빦������ҳ ����Ӥ����Ϣ
  */
  PROCEDURE usp_insert_iem_main_ObsBaby(v_iem_mainpage_no NUMERIC,
                                        v_TC              VARCHAR, --̥��
                                        v_CC              VARCHAR, -- ����
                                        v_TB              VARCHAR, -- ̥��
                                        v_CFHYPLD         VARCHAR, --�����������Ѷ�
                                        v_MIDWIFERY       VARCHAR, --�Ӳ���
                                        v_SEX             VARCHAR, --�Ա�
                                        v_APJ             VARCHAR, -- ����������
                                        v_HEIGH           VARCHAR, --��
                                        v_WEIGHT          VARCHAR, --����
                                        v_CCQK            VARCHAR, --�������
                                        v_BITHDAY         VARCHAR, --����ʱ��
                                        v_FMFS            VARCHAR, --     ���䷽ʽ
                                        v_CYQK            VARCHAR,
                                        v_create_user     VARCHAR);

  /*
  * ά��������ҳ��Ϣ MOdify by xlb 2013-07-03 ��������Ž����� �����ֶ�
  */
  PROCEDURE usp_Edit_Iem_BasicInfo_sx(v_edittype        varchar2 default '',
                                      v_IEM_MAINPAGE_NO varchar2 default '', ---- '������ҳ��ʶ';
                                      v_PATNOOFHIS      varchar2 default '', ---- '������';
                                      v_NOOFINPAT       varchar2 default '', ---- '������ҳ���';
                                      v_PAYID           varchar2 default '', ---- 'ҽ�Ƹ��ʽID';
                                      v_SOCIALCARE      varchar2 default '', ---- '�籣����';
                                      
                                      v_INCOUNT varchar2 default '', ---- '��Ժ����';
                                      v_NAME    varchar2 default '', ---- '��������';
                                      v_SEXID   varchar2 default '', ---- '�Ա�';
                                      v_BIRTH   varchar2 default '', ---- '����';
                                      v_MARITAL varchar2 default '', ---- '����״�� 1.δ�� 2.�ѻ� 3.ɥż4.��� 9.����';
                                      
                                      v_JOBID         varchar2 default '', ---- 'ְҵ';
                                      v_NATIONALITYID varchar2 default '', ---- '����ID';
                                      v_NATIONID      varchar2 default '', --����
                                      v_IDNO          varchar2 default '', ---- '���֤����';
                                      v_ORGANIZATION  varchar2 default '', ---- '������λ';
                                      v_OFFICEPLACE   varchar2 default '', ---- '������λ��ַ';
                                      
                                      v_OFFICETEL      varchar2 default '', ---- '������λ�绰';
                                      v_OFFICEPOST     varchar2 default '', ---- '������λ�ʱ�';
                                      v_CONTACTPERSON  varchar2 default '', ---- '��ϵ������';
                                      v_RELATIONSHIP   varchar2 default '', ---- '����ϵ�˹�ϵ';
                                      v_CONTACTADDRESS varchar2 default '', ---- '��ϵ�˵�ַ';
                                      
                                      v_CONTACTTEL varchar2 default '', ---- '��ϵ�˵绰';
                                      v_ADMITDATE  varchar2 default '', ---- '��Ժʱ��';
                                      v_ADMITDEPT  varchar2 default '', ---- '��Ժ����';
                                      v_ADMITWARD  varchar2 default '', ---- '��Ժ����';
                                      v_TRANS_DATE varchar2 default '', ---- 'תԺʱ��';
                                      
                                      v_TRANS_ADMITDEPT varchar2 default '', ---- 'תԺ�Ʊ�';
                                      v_TRANS_ADMITWARD varchar2 default '', ---- 'תԺ����';
                                      v_OUTWARDDATE     varchar2 default '', ---- '��Ժʱ��';
                                      v_OUTHOSDEPT      varchar2 default '', ---- '��Ժ����';
                                      v_OUTHOSWARD      varchar2 default '', ---- '��Ժ����';
                                      
                                      v_ACTUALDAYS               varchar2 default '', ---- 'ʵ��סԺ����';
                                      v_PATHOLOGY_DIAGNOSIS_NAME varchar2 default '', ---- '�����������';
                                      v_PATHOLOGY_OBSERVATION_SN varchar2 default '', ---- '������� ';
                                      v_ALLERGIC_DRUG            varchar2 default '', ---- '����ҩ��';
                                      v_SECTION_DIRECTOR         varchar2 default '', ---- '������';
                                      
                                      v_DIRECTOR               varchar2 default '', ---- '������������ҽʦ';
                                      v_VS_EMPLOYEE_CODE       varchar2 default '', ---- '����ҽʦ';
                                      v_RESIDENT_EMPLOYEE_CODE varchar2 default '', ---- 'סԺҽʦ';
                                      v_REFRESH_EMPLOYEE_CODE  varchar2 default '', ---- '����ҽʦ';
                                      v_DUTY_NURSE             varchar2 default '', ---- '���λ�ʿ';
                                      
                                      v_INTERNE                varchar2 default '', ---- 'ʵϰҽʦ';
                                      v_CODING_USER            varchar2 default '', ---- '����Ա';
                                      v_MEDICAL_QUALITY_ID     varchar2 default '', ---- '��������';
                                      v_QUALITY_CONTROL_DOCTOR varchar2 default '', ---- '�ʿ�ҽʦ';
                                      v_QUALITY_CONTROL_NURSE  varchar2 default '', ---- '�ʿػ�ʿ';
                                      
                                      v_QUALITY_CONTROL_DATE varchar2 default '', ---- '�ʿ�ʱ��';
                                      v_XAY_SN               varchar2 default '', ---- 'x�߼���';
                                      v_CT_SN                varchar2 default '', ---- 'CT����';
                                      v_MRI_SN               varchar2 default '', ---- 'mri����';
                                      v_DSA_SN               varchar2 default '', ---- 'Dsa����';
                                      
                                      v_BLOODTYPE      varchar2 default '', ---- 'Ѫ��';
                                      v_RH             varchar2 default '', ---- 'Rh';
                                      v_IS_COMPLETED   varchar2 default '', ---- '��ɷ� y/n ';
                                      v_COMPLETED_TIME varchar2 default '', ---- '���ʱ��';
                                      v_VALIDE         varchar2 default '1', ---- '���Ϸ� 1/0';
                                      
                                      v_CREATE_USER   varchar2 default '', ---- '�����˼�¼��';
                                      v_CREATE_TIME   varchar2 default '', ---- '����ʱ��';
                                      v_MODIFIED_USER varchar2 default '', ---- '�޸Ĵ˼�¼��';
                                      v_MODIFIED_TIME varchar2 default '', ---- '�޸�ʱ��';
                                      v_ZYMOSIS       varchar2 default '', ---- 'ҽԺ��Ⱦ��';
                                      
                                      v_HURT_TOXICOSIS_ELE_ID   varchar2 default '', ---- '���ˡ��ж����ⲿ����';
                                      v_HURT_TOXICOSIS_ELE_Name varchar2 default '', ---- '���ˡ��ж����ⲿ����';
                                      v_ZYMOSISSTATE            varchar2 default '', ---- 'ҽԺ��Ⱦ��״̬';
                                      v_PATHOLOGY_DIAGNOSIS_ID  varchar2 default '', ---- '������ϱ��';
                                      v_MONTHAGE                varchar2 default '', ---- '�����䲻��1����ģ� ����(��)';
                                      v_WEIGHT                  varchar2 default '', ---- '��������������(��)';
                                      
                                      v_INWEIGHT         varchar2 default '', ---- '��������Ժ����(��)';
                                      v_INHOSTYPE        varchar2 default '', ---- '��Ժ;��:1.����  2.����  3.����ҽ�ƻ���ת��  9.����';
                                      v_OUTHOSTYPE       varchar2 default '', ---- '��Ժ��ʽ �� 1.ҽ����Ժ  2.ҽ��תԺ 3.ҽ��ת���������������/��������Ժ 4.��ҽ����Ժ5.����9.����';
                                      v_RECEIVEHOSPITAL  varchar2 default '', ---- '2.ҽ��תԺ�������ҽ�ƻ������ƣ�';
                                      v_RECEIVEHOSPITAL2 varchar2 default '', ---- '3.ҽ��ת���������������/��������Ժ�������ҽ�ƻ�����;
                                      
                                      v_AGAININHOSPITAL       varchar2 default '', ---- '�Ƿ��г�Ժ31������סԺ�ƻ� �� 1.��  2.��';
                                      v_AGAININHOSPITALREASON varchar2 default '', ---- '��Ժ31������סԺ�ƻ� Ŀ��:            ';
                                      v_BEFOREHOSCOMADAY      varchar2 default '', ---- '­�����˻��߻���ʱ�䣺 ��Ժǰ    ��';
                                      v_BEFOREHOSCOMAHOUR     varchar2 default '', ---- '­�����˻��߻���ʱ�䣺 ��Ժǰ     Сʱ';
                                      v_BEFOREHOSCOMAMINUTE   varchar2 default '', ---- '­�����˻��߻���ʱ�䣺 ��Ժǰ    ����';
                                      
                                      v_LATERHOSCOMADAY    varchar2 default '', ---- '­�����˻��߻���ʱ�䣺 ��Ժ��    ��';
                                      v_LATERHOSCOMAHOUR   varchar2 default '', ---- '­�����˻��߻���ʱ�䣺 ��Ժ��    Сʱ';
                                      v_LATERHOSCOMAMINUTE varchar2 default '', ---- '­�����˻��߻���ʱ�䣺 ��Ժ��    ����';
                                      v_CARDNUMBER         varchar2 default '', ---- '��������';
                                      v_ALLERGIC_FLAG      varchar2 default '', ---- 'ҩ�����1.�� 2.��';
                                      
                                      v_AUTOPSY_FLAG     varchar2 default '', ---- '��������ʬ�� �� 1.��  2.��';
                                      v_CSD_PROVINCEID   varchar2 default '', ---- '������ ʡ';
                                      v_CSD_CITYID       varchar2 default '', ---- '������ ��';
                                      v_CSD_DISTRICTID   varchar2 default '', ---- '������ ��';
                                      v_CSD_PROVINCENAME varchar2 default '', ---- '������ ʡ����';
                                      
                                      v_CSD_CITYNAME     varchar2 default '', ---- '������ ������';
                                      v_CSD_DISTRICTNAME varchar2 default '', ---- '������ ������';
                                      v_XZZ_PROVINCEID   varchar2 default '', ---- '��סַ ʡ';
                                      v_XZZ_CITYID       varchar2 default '', ---- '��סַ ��';
                                      v_XZZ_DISTRICTID   varchar2 default '', ---- '��סַ ��';
                                      
                                      v_XZZ_PROVINCENAME varchar2 default '', ---- '��סַ ʡ����';
                                      v_XZZ_CITYNAME     varchar2 default '', ---- '��סַ ������';
                                      v_XZZ_DISTRICTNAME varchar2 default '', ---- '��סַ ������';
                                      v_XZZ_TEL          varchar2 default '', ---- '��סַ �绰';
                                      v_XZZ_POST         varchar2 default '', ---- '��סַ �ʱ�';
                                      
                                      v_HKDZ_PROVINCEID   varchar2 default '', ---- '���ڵ�ַ ʡ';
                                      v_HKDZ_CITYID       varchar2 default '', ---- '���ڵ�ַ ��';
                                      v_HKDZ_DISTRICTID   varchar2 default '', ---- '���ڵ�ַ ��';
                                      v_HKDZ_PROVINCENAME varchar2 default '', ---- '���ڵ�ַ ʡ����';
                                      v_HKDZ_CITYNAME     varchar2 default '', ---- '���ڵ�ַ ������';
                                      
                                      v_HKDZ_DISTRICTNAME varchar2 default '', ---- '���ڵ�ַ ������';
                                      v_HKDZ_POST         varchar2 default '', ---- '�������ڵ��ʱ�';
                                      v_JG_PROVINCEID     varchar2 default '', ---- '���� ʡ����';
                                      v_JG_CITYID         varchar2 default '', ---- '���� ������';
                                      v_JG_PROVINCENAME   varchar2 default '', ---- '���� ʡ����';
                                      v_JG_CITYNAME       varchar2 default '', ---- '���� ������'
                                      v_Age               varchar2 default '',
                                      
                                      v_CURE_TYPE   VARCHAR2 default '', ----  Y    ������� �� 1.��ҽ�� 1.1 ��ҽ   1.2����ҽ��    2.����ҽ     3.��ҽ
                                      v_MZZYZD_NAME VARCHAR2 default '', ---- Y   �ţ���������ϣ���ҽ��ϣ�
                                      v_MZZYZD_CODE VARCHAR2 default '', ---- Y   �ţ���������ϣ���ҽ��ϣ� ����
                                      v_MZXYZD_NAME VARCHAR2 default '', ---- Y   �ţ���������ϣ���ҽ��ϣ�
                                      v_MZXYZD_CODE VARCHAR2 default '', ---- Y   �ţ���������ϣ���ҽ��ϣ� ����
                                      v_SSLCLJ      VARCHAR2 default '', ---- Y   ʵʩ�ٴ�·������ 1. ��ҽ  2. ��ҽ  3 ��
                                      v_ZYZJ        VARCHAR2 default '', ---- Y   ʹ��ҽ�ƻ�����ҩ�Ƽ����� 1.��  2. ��
                                      
                                      v_ZYZLSB       VARCHAR2 default '', ---- Y   ʹ����ҽ�����豸����  1.�� 2. ��
                                      v_ZYZLJS       VARCHAR2 default '', ---- Y   ʹ����ҽ���Ƽ������� 1. ��  2. ��
                                      v_BZSH         VARCHAR2 default '', ---- Y   ��֤ʩ������ 1.��  2. ��
                                      v_outHosStatus VARCHAR2 default '', ---��Ժ״��
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
  *��ѯ������ҳ��Ϣ
  **********/
  ---Modify by xlb 2013-07-02 �����ֶ�
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

  --���²�����ҳ��Ϣ�󣬶Բ�����Ϣ���������ͬ�� add by ywk ����һ������������ 15:20:27
  PROCEDURE usp_Edit_Iem_PaientInfo_sx(v_NOOFINPAT      varchar2 default '', ---- '������ҳ���';
                                       v_NAME           varchar2 default '', ---- '��������';
                                       v_SEXID          varchar2 default '', ---- '�Ա�';
                                       v_BIRTH          varchar2 default '', ---- '����';
                                       v_Age            INTEGER default 1, --����
                                       v_IDNO           varchar2 default '', ---- '���֤����';
                                       v_MARITAL        varchar2 default '', ---- '����״�� 1.δ�� 2.�ѻ� 3.ɥż4.��� 9.����';
                                       v_JOBID          varchar2 default '', ---- 'ְҵ';
                                       v_CSD_PROVINCEID varchar2 default '', ---- '������ ʡ';
                                       v_CSD_CITYID     varchar2 default '', ---- '������ ��';
                                       v_NATIONID       varchar2 default '', --����
                                       v_NATIONALITYID  varchar2 default '', ---- '����ID';
                                       v_JG_PROVINCEID  varchar2 default '', ---- '���� ʡ';
                                       v_JG_CITYID      varchar2 default '', ---- '���� ��';
                                       v_OFFICEPLACE    varchar2 default '', ---- '������λ��ַ';
                                       v_OFFICETEL      varchar2 default '', ---- '������λ�绰';
                                       v_OFFICEPOST     varchar2 default '', ---- '������λ�ʱ�';
                                       v_HKDZ_POST      varchar2 default '', ---- '�������ڵ��ʱ�';
                                       v_CONTACTPERSON  varchar2 default '', ---- '��ϵ������';
                                       v_RELATIONSHIP   varchar2 default '', ---- '����ϵ�˹�ϵ';
                                       v_CONTACTADDRESS varchar2 default '', ---- '��ϵ�˵�ַ';
                                       v_CONTACTTEL     varchar2 default '', ---- '��ϵ�˵绰';
                                       v_ADMITDEPT      varchar2 default '', ---- '��Ժ����';
                                       v_ADMITWARD      varchar2 default '', ---- '��Ժ����';
                                       v_ADMITDATE      varchar2 default '', ---- '��Ժʱ��';
                                       v_OUTWARDDATE    varchar2 default '', ---- '��Ժʱ��';
                                       v_OUTHOSDEPT     varchar2 default '', ---- '��Ժ����';
                                       v_OUTHOSWARD     varchar2 default '', ---- '��Ժ����';
                                       v_ACTUALDAYS     varchar2 default '', ---- 'ʵ��סԺ����';
                                       v_AgeStr         varchar2 default '', ---- '���� ��ȷ������;2012��5��9��9:31:03 ����ά�� �����޸ģ�
                                       v_PatId          varchar2 default '', --�����ĸ��ʽ add by ywk 2012��5��14�� 16:02:13
                                       v_CardNo         varchar2 default '', --��������
                                       -----add by ywk  2012��5��16��9:45:27 Inpatient��l�����Ӳ�����ҳ����Ӧ���ֶ�
                                       v_Districtid     varchar2 default '', --�����ء��ء�
                                       v_xzzproviceid   varchar2 default '', --����סַʡ
                                       v_xzzcityid      varchar2 default '', --����סַ��
                                       v_xzzdistrictid  varchar2 default '', --����סַ��
                                       v_xzztel         varchar2 default '', --����סַ�绰
                                       v_hkdzproviceid  varchar2 default '', --����סַʡ
                                       v_hkzdcityid     varchar2 default '', --����סַ��
                                       v_hkzddistrictid varchar2 default '', --����סַ��
                                       v_xzzpost        varchar2 default '', --��סַ�ʱ�
                                       v_isupdate       varchar2 default '' ---2012��5��24�� 17:19:10 ywk �Ƿ�������֤���ֶ�
                                       
                                       );

  --�����ҳĬ�ϱ��������
  --add by ywk 2012��5��17�� 09:36:46

  PROCEDURE usp_GetDefaultInpatient(o_result OUT empcurtyp);

  --���ݲ�����ҳ��š�ȡ�ò��˵���Ϣ ������䲡����ҳ
  PROCEDURE usp_GetInpatientByNo(v_noofinpat varchar2 default '',
                                 o_result    OUT empcurtyp);

  /*
  * ά��������ҳ�ķ�����Ϣ
  add by ywk 2012��10��16�� 19:29:53
  */
  PROCEDURE usp_editiem_mainpage_feeinfo(v_edittype        varchar2 default '',
                                         v_IEM_MAINPAGE_NO varchar2 default '', ---- '������ҳ��ʶ';
                                         v_TotalFee        varchar2 default '', ---- �ܷ���;
                                         v_OwnerFee        varchar2 default '', ---- '�Ը����
                                         v_YbMedServFee    varchar2 default '', ---- һ��ҽ�Ʒ����
                                         v_YbMedOperFee    varchar2 default '', ---- һ�����Ʋ�����
                                         v_NurseFee        varchar2 default '', ----�����
                                         v_OtherInfo       varchar2 default '', ---- �ۺ��� ��������
                                         v_BLZDFee         varchar2 default '', ---- ����� ������Ϸ�
                                         v_SYSZDFee        varchar2 default '', ---- ʵ������Ϸ�
                                         v_YXXZDFee        varchar2 default '', ----  ����� Ӱ��ѧ��Ϸ�
                                         v_LCZDItemFee     varchar2 default '', ----  ����� �ٴ������Ŀ��
                                         v_FSSZLItemFee    varchar2 default '', ----  ������������Ŀ��
                                         v_LCWLZLFee       varchar2 default '', ---- ������ �ٴ��������Ʒ�
                                         v_OperMedFee      varchar2 default '', ----������ �������Ʒ�
                                         v_KFFee           varchar2 default '', ----������ ������
                                         v_ZYZLFee         varchar2 default '', ----��ҽ�� ��ҽ���Ʒ�
                                         v_XYMedFee        varchar2 default '', ---��ҩ�� ��ҩ��
                                         v_KJYWFee         varchar2 default '', ---��ҩ�� ����ҩ�����
                                         v_ZCYFFee         varchar2 default '', ---��ҩ�� �г�ҩ��
                                         v_ZCaoYFFee       varchar2 default '', ---��ҩ�� �в�ҩ��
                                         v_BloodFee        varchar2 default '', ---ѪҺ��ѪҺ��Ʒ�� Ѫ��
                                         v_BDBLZPFFee      varchar2 default '', ---ѪҺ��ѪҺ��Ʒ�� �׵�������Ʒ��
                                         v_QDBLZPFFee      varchar2 default '', ---�򵰰�����Ʒ��
                                         v_NXYZLZPFFee     varchar2 default '', ---ѪҺ��ѪҺ��Ʒ�� ��Ѫ��������Ʒ��
                                         v_XBYZLZPFFee     varchar2 default '', ---ϸ����������Ʒ��
                                         v_JCYYCXYYCLFFee  varchar2 default '', -- �����һ����ҽ�ò��Ϸ�
                                         v_ZLYYCXYYCLFFee  varchar2 default '', -- /�Ĳ��� ������һ����ҽ�ò��Ϸ�
                                         v_SSYYCXYYCLFFee  varchar2 default '', -- ���� ������һ����ҽ�ò��Ϸ�
                                         v_QTFee           varchar2 default '', -- �����ࣺ��24��������        
                                         v_Memo1           varchar2 default '', -- Ԥ���ֶ�   1    
                                         v_Memo2           varchar2 default '', -- Ԥ���ֶ�    2  
                                         v_Memo3           varchar2 default '', -- Ԥ���ֶ�     3 
                                         v_MaZuiFee        varchar2 default '', -- �����
                                         v_ShouShuFee      varchar2 default '' -- ������ 
                                         
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
  -- Purpose : ������ҳ��չ���ܰ�
  TYPE empcurtype IS REF CURSOR;

-------ץȡ��չά����¼---------------------------------------------------------------------------------------
-------------Add by xlb 2013-04-10----------------------------------------------------------------------------
PROCEDURE GETIEMEXCEPT(
                       o_result out empcurtype
                      );

----�������޸�ά����¼  Add by xlb 2013-04-11
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
 ---------------------------------�������޸Ĳ�����չά�����ܱ༭���没��ʹ�ü�¼Add by xlb 2013-04-16--------
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
  -- ����ֵ
  TYPE empcurtyp IS REF CURSOR;

  --TYPE empcurtyp IS REF CURSOR;
  /*BedInfoά��*/
  PROCEDURE usp_EditEmrBedInfo(v_EditType     VARCHAR2 default '', --��������
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
  /*Bedά��*/
  PROCEDURE usp_EditEmrBed(v_EditType     VARCHAR2 default '', --��������
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
  /*InPatientά��*/
  PROCEDURE usp_EditEmrInPatient(v_EditType        VARCHAR2 default '', --��������
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
    -- global ��������
  /* ������ ������; */
    -- PROCEDURE����������
  /* PROCEDURE����(����...); */
  /* FUNCTION  ����(����...) RETURN ������; */

  
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
    -- global ��������
  /* ������ ������; */
    -- PROCEDURE����������
  /* PROCEDURE����(����...); */
  /* FUNCTION  ����(����...) RETURN ������; */

  
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

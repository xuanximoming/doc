-------------------------------------------
-- Export file for user EMR@YC           --
-- Created by key on 2018/5/27, 13:40:39 --
-------------------------------------------

set define off
spool SEQ.log

prompt
prompt Creating sequence NURSERECORDID_SEQ
prompt ===================================
prompt
create sequence EMR.NURSERECORDID_SEQ
minvalue 0
maxvalue 9999999
start with 260
increment by 1
cache 20;

prompt
prompt Creating sequence PLSQL_PROFILER_RUNNUMBER
prompt ==========================================
prompt
create sequence EMR.PLSQL_PROFILER_RUNNUMBER
minvalue 1
maxvalue 999999999999999999999999999
start with 4
increment by 1
nocache;

prompt
prompt Creating sequence QLL_ID_SEQ
prompt ============================
prompt
create sequence EMR.QLL_ID_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 6801
increment by 2
cache 20;

prompt
prompt Creating sequence QUEST_SOO_AT_SEQUENCE
prompt =======================================
prompt
create sequence EMR.QUEST_SOO_AT_SEQUENCE
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence REPLENISHPATREC_ID
prompt ====================================
prompt
create sequence EMR.REPLENISHPATREC_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQEMR_CONFIGCHECKPOINTUSER_ID
prompt ================================================
prompt
create sequence EMR.SEQEMR_CONFIGCHECKPOINTUSER_ID
minvalue 1
maxvalue 999999999999
start with 61
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_ADVICEGROUPDETAIL_ID
prompt ==========================================
prompt
create sequence EMR.SEQ_ADVICEGROUPDETAIL_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_ADVICEGROUP_ID
prompt ====================================
prompt
create sequence EMR.SEQ_ADVICEGROUP_ID
minvalue 1
maxvalue 999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_ALLERGYHISTORY_ID
prompt =======================================
prompt
create sequence EMR.SEQ_ALLERGYHISTORY_ID
minvalue 1
maxvalue 999999999999
start with 61
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_ANALYSIS_PROJECT_ID
prompt =========================================
prompt
create sequence EMR.SEQ_ANALYSIS_PROJECT_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_APPLYRECORD_ID
prompt ====================================
prompt
create sequence EMR.SEQ_APPLYRECORD_ID
minvalue 1
maxvalue 999999999999
start with 961
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_ATTACHEDCARD_HEPATITISB_ID
prompt ================================================
prompt
create sequence EMR.SEQ_ATTACHEDCARD_HEPATITISB_ID
minvalue 1
maxvalue 999999999999
start with 481
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BEDINFO_ID
prompt ================================
prompt
create sequence EMR.SEQ_BEDINFO_ID
minvalue 1
maxvalue 999999999999
start with 2191
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_BIRTHDEFECTS
prompt ==================================
prompt
create sequence EMR.SEQ_BIRTHDEFECTS
minvalue 1
maxvalue 99999999999999
start with 341
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_CARDIOVASCULARCARD_ID
prompt ===========================================
prompt
create sequence EMR.SEQ_CARDIOVASCULARCARD_ID
minvalue 1
maxvalue 999999999999
start with 161
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_CONSULTAPPLYDEPARTMENT_ID
prompt ===============================================
prompt
create sequence EMR.SEQ_CONSULTAPPLYDEPARTMENT_ID
minvalue 1
maxvalue 999999999999
start with 20303
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_CONSULTAPPLY_ID
prompt =====================================
prompt
create sequence EMR.SEQ_CONSULTAPPLY_ID
minvalue 1
maxvalue 999999999999
start with 18263
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_CONSULTRECORDDEPARTMENT_ID
prompt ================================================
prompt
create sequence EMR.SEQ_CONSULTRECORDDEPARTMENT_ID
minvalue 1
maxvalue 999999999999
start with 20067
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_CONSULT_DEPTAUTIO_ID
prompt ==========================================
prompt
create sequence EMR.SEQ_CONSULT_DEPTAUTIO_ID
minvalue 1
maxvalue 999999999999
start with 122
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_CONSULT_DOCTORPARENT_ID
prompt =============================================
prompt
create sequence EMR.SEQ_CONSULT_DOCTORPARENT_ID
minvalue 1
maxvalue 999999999999
start with 222
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_DEPT_DEDUCTPOINTDETAIL_ID
prompt ===============================================
prompt
create sequence EMR.SEQ_DEPT_DEDUCTPOINTDETAIL_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_DEPT_DEDUCTPOINT_ID
prompt =========================================
prompt
create sequence EMR.SEQ_DEPT_DEDUCTPOINT_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_DGRSDEPT_ID
prompt =================================
prompt
create sequence EMR.SEQ_DGRSDEPT_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_DISEASEFEE_ID
prompt ===================================
prompt
create sequence EMR.SEQ_DISEASEFEE_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_DISEASESGROUP_ID
prompt ======================================
prompt
create sequence EMR.SEQ_DISEASESGROUP_ID
minvalue 1
maxvalue 999999999999
start with 41
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_EMRTEMPLETHEADER_ID
prompt =========================================
prompt
create sequence EMR.SEQ_EMRTEMPLETHEADER_ID
minvalue 1
maxvalue 999999999999
start with 1284
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_EMRTEMPLET_FOOT_ID
prompt ========================================
prompt
create sequence EMR.SEQ_EMRTEMPLET_FOOT_ID
minvalue 1
maxvalue 999999999999
start with 161
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_EMR_AUTOMARK_RECORD
prompt =========================================
prompt
create sequence EMR.SEQ_EMR_AUTOMARK_RECORD
minvalue 1
maxvalue 999999999999999999999999999
start with 6989
increment by 1
cache 10;

prompt
prompt Creating sequence SEQ_EMR_CONFIGPOINT
prompt =====================================
prompt
create sequence EMR.SEQ_EMR_CONFIGPOINT
minvalue 1
maxvalue 999999999999999999999999999
start with 121
increment by 1
cache 10;

prompt
prompt Creating sequence SEQ_EMR_CONFIGPOINT_ID
prompt ========================================
prompt
create sequence EMR.SEQ_EMR_CONFIGPOINT_ID
minvalue 1
maxvalue 999999999999
start with 351554
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_EMR_CONFIGREDUCTION_ID
prompt ============================================
prompt
create sequence EMR.SEQ_EMR_CONFIGREDUCTION_ID
minvalue 1
maxvalue 999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_EMR_POINT_ID
prompt ==================================
prompt
create sequence EMR.SEQ_EMR_POINT_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 884
increment by 1
cache 10;

prompt
prompt Creating sequence SEQ_FAMILYHISTORY_ID
prompt ======================================
prompt
create sequence EMR.SEQ_FAMILYHISTORY_ID
minvalue 1
maxvalue 999999999999
start with 41
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IEM_MAINPAGE_BASICINFO_ID
prompt ===============================================
prompt
create sequence EMR.SEQ_IEM_MAINPAGE_BASICINFO_ID
minvalue 1
maxvalue 999999999999
start with 51486
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IEM_MAINPAGE_DEFAULT_ID
prompt =============================================
prompt
create sequence EMR.SEQ_IEM_MAINPAGE_DEFAULT_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IEM_MAINPAGE_DIAGNOSIS_ID
prompt ===============================================
prompt
create sequence EMR.SEQ_IEM_MAINPAGE_DIAGNOSIS_ID
minvalue 1
maxvalue 999999999999
start with 537275
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IEM_MAINPAGE_FEEINFO_ID
prompt =============================================
prompt
create sequence EMR.SEQ_IEM_MAINPAGE_FEEINFO_ID
minvalue 1
maxvalue 999999999999
start with 8581
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IEM_MAINPAGE_OBSBABY_ID
prompt =============================================
prompt
create sequence EMR.SEQ_IEM_MAINPAGE_OBSBABY_ID
minvalue 1
maxvalue 999999999999
start with 6801
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IEM_MAINPAGE_OPERATION_ID
prompt ===============================================
prompt
create sequence EMR.SEQ_IEM_MAINPAGE_OPERATION_ID
minvalue 1
maxvalue 999999999999
start with 42181
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IEM_MAINPAGE_OTHERS
prompt =========================================
prompt
create sequence EMR.SEQ_IEM_MAINPAGE_OTHERS
minvalue 1
maxvalue 999999999999999999999999999
start with 22561
increment by 1
cache 10;

prompt
prompt Creating sequence SEQ_ILLNESSHISTORY_ID
prompt =======================================
prompt
create sequence EMR.SEQ_ILLNESSHISTORY_ID
minvalue 1
maxvalue 999999999999
start with 101
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IMAGELIBRARY_ID
prompt =====================================
prompt
create sequence EMR.SEQ_IMAGELIBRARY_ID
minvalue 1
maxvalue 999999999999
start with 306
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_INPATIENTCHANGEINFO_ID
prompt ============================================
prompt
create sequence EMR.SEQ_INPATIENTCHANGEINFO_ID
minvalue 1
maxvalue 999999999999
start with 180531
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_INPATIENTREPORT_ID
prompt ========================================
prompt
create sequence EMR.SEQ_INPATIENTREPORT_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_INPATIENT_CLINIC_ID
prompt =========================================
prompt
create sequence EMR.SEQ_INPATIENT_CLINIC_ID
minvalue 1
maxvalue 999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_INPATIENT_ID
prompt ==================================
prompt
create sequence EMR.SEQ_INPATIENT_ID
minvalue 1
maxvalue 999999999999
start with 45952508
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_JOBMANAGERLOG_ID
prompt ======================================
prompt
create sequence EMR.SEQ_JOBMANAGERLOG_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_KNOWLEDGEPUBLIC_ID
prompt ========================================
prompt
create sequence EMR.SEQ_KNOWLEDGEPUBLIC_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_LONG_ORDER_ID
prompt ===================================
prompt
create sequence EMR.SEQ_LONG_ORDER_ID
minvalue 1
maxvalue 999999999999
start with 101
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_MEASURE_ID
prompt ================================
prompt
create sequence EMR.SEQ_MEASURE_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_MEDICALRECORD_ID
prompt ======================================
prompt
create sequence EMR.SEQ_MEDICALRECORD_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_MODEL_DOCMENT_SEARCH_ID
prompt =============================================
prompt
create sequence EMR.SEQ_MODEL_DOCMENT_SEARCH_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_NEWSARTICLE_CLASS_ID
prompt ==========================================
prompt
create sequence EMR.SEQ_NEWSARTICLE_CLASS_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_NEWSARTICLE_ID
prompt ====================================
prompt
create sequence EMR.SEQ_NEWSARTICLE_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_NOTESONNURSING_ID
prompt =======================================
prompt
create sequence EMR.SEQ_NOTESONNURSING_ID
minvalue 1
maxvalue 999999999999
start with 6361689
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_NURSE_WITHINFORMATION_ID
prompt ==============================================
prompt
create sequence EMR.SEQ_NURSE_WITHINFORMATION_ID
minvalue 1
maxvalue 999999999999
start with 6348
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_NURSRECORDTABLE_ID
prompt ========================================
prompt
create sequence EMR.SEQ_NURSRECORDTABLE_ID
minvalue 1
maxvalue 999999999999
start with 1000
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_OPERATESTEP_ID
prompt ====================================
prompt
create sequence EMR.SEQ_OPERATESTEP_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_OPERATIONRECORDDETAIL_ID
prompt ==============================================
prompt
create sequence EMR.SEQ_OPERATIONRECORDDETAIL_ID
minvalue 1
maxvalue 999999999999
start with 3771448
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_OUTDIAGNOSISCONDITION_ID
prompt ==============================================
prompt
create sequence EMR.SEQ_OUTDIAGNOSISCONDITION_ID
minvalue 1
maxvalue 999999999999
start with 177312
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_PATIENTCONTACTS_ID
prompt ========================================
prompt
create sequence EMR.SEQ_PATIENTCONTACTS_ID
minvalue 1
maxvalue 999999999999
start with 81
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_PATIENTRECORDLOG_ID
prompt =========================================
prompt
create sequence EMR.SEQ_PATIENTRECORDLOG_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_PATIENTSTATUS_ID
prompt ======================================
prompt
create sequence EMR.SEQ_PATIENTSTATUS_ID
minvalue 1
maxvalue 999999999999
start with 196666
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_PERSONALHISTORY_ID
prompt ========================================
prompt
create sequence EMR.SEQ_PERSONALHISTORY_ID
minvalue 1
maxvalue 999999999999
start with 41
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_PRINTHISTORY_ID
prompt =====================================
prompt
create sequence EMR.SEQ_PRINTHISTORY_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_PRINTSETDETAIL_ID
prompt =======================================
prompt
create sequence EMR.SEQ_PRINTSETDETAIL_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_PRINTTEMPLATE_ID
prompt ======================================
prompt
create sequence EMR.SEQ_PRINTTEMPLATE_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_QCPROBLEMDESCRIPTION_ID
prompt =============================================
prompt
create sequence EMR.SEQ_QCPROBLEMDESCRIPTION_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_QCPROBLEM_ID
prompt ==================================
prompt
create sequence EMR.SEQ_QCPROBLEM_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_QCRECORD_ID
prompt =================================
prompt
create sequence EMR.SEQ_QCRECORD_ID
minvalue 1
maxvalue 999999999999
start with 292401
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_QCRULECODE
prompt ================================
prompt
create sequence EMR.SEQ_QCRULECODE
minvalue 1
maxvalue 999999999999
start with 20
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RECORDDETAILCLINIC_ID
prompt ===========================================
prompt
create sequence EMR.SEQ_RECORDDETAILCLINIC_ID
minvalue 0
maxvalue 9999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RECORDDETAIL_ERROR2013_ID
prompt ===============================================
prompt
create sequence EMR.SEQ_RECORDDETAIL_ERROR2013_ID
minvalue 1
maxvalue 999999999999
start with 41
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RECORDDETAIL_ID
prompt =====================================
prompt
create sequence EMR.SEQ_RECORDDETAIL_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1090628
increment by 1
cache 10;

prompt
prompt Creating sequence SEQ_RECORDTRIGGER_ID
prompt ======================================
prompt
create sequence EMR.SEQ_RECORDTRIGGER_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_REPORTLISRESLUT_ID
prompt ========================================
prompt
create sequence EMR.SEQ_REPORTLISRESLUT_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_REPORTRISRESLUT_ID
prompt ========================================
prompt
create sequence EMR.SEQ_REPORTRISRESLUT_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SEQ_TOTABLECOLUMN_ID
prompt ==========================================
prompt
create sequence EMR.SEQ_SEQ_TOTABLECOLUMN_ID
minvalue 1
maxvalue 999999999999
start with 81
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SRTD_ID
prompt =============================
prompt
create sequence EMR.SEQ_SRTD_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SURGERYHISTORY_ID
prompt =======================================
prompt
create sequence EMR.SEQ_SURGERYHISTORY_ID
minvalue 1
maxvalue 999999999999
start with 81
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SYMBOLCATEGORY_ID
prompt =======================================
prompt
create sequence EMR.SEQ_SYMBOLCATEGORY_ID
minvalue 1
maxvalue 999999999999
start with 47
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SYS_SIGN_ITEM_ID
prompt ======================================
prompt
create sequence EMR.SEQ_SYS_SIGN_ITEM_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SYS_SIGN_SEAL_ID
prompt ======================================
prompt
create sequence EMR.SEQ_SYS_SIGN_SEAL_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SYS_SIGN_USER_SEAL_ID
prompt ===========================================
prompt
create sequence EMR.SEQ_SYS_SIGN_USER_SEAL_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TEMPLATEPERSONGROUP_ID
prompt ============================================
prompt
create sequence EMR.SEQ_TEMPLATEPERSONGROUP_ID
minvalue 1
maxvalue 999999999999
start with 13
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TEMPLATETABLESORT_ID
prompt ==========================================
prompt
create sequence EMR.SEQ_TEMPLATETABLESORT_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TEMPLATE_COLLECT_ID
prompt =========================================
prompt
create sequence EMR.SEQ_TEMPLATE_COLLECT_ID
minvalue 1
maxvalue 999999999999999999
start with 91590
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TEMPLATE_PERSON_ID
prompt ========================================
prompt
create sequence EMR.SEQ_TEMPLATE_PERSON_ID
minvalue 1
maxvalue 999999999999
start with 12497
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TEMPLATE_RECENT_ID
prompt ========================================
prompt
create sequence EMR.SEQ_TEMPLATE_RECENT_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TEMPLATE_TABLE_ID
prompt =======================================
prompt
create sequence EMR.SEQ_TEMPLATE_TABLE_ID
minvalue 1
maxvalue 999999999999
start with 61
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TEMP_ORDER_ID
prompt ===================================
prompt
create sequence EMR.SEQ_TEMP_ORDER_ID
minvalue 1
maxvalue 999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TEST_PERSON_INFO_ID
prompt =========================================
prompt
create sequence EMR.SEQ_TEST_PERSON_INFO_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_THERIOMAID
prompt ================================
prompt
create sequence EMR.SEQ_THERIOMAID
minvalue 1
maxvalue 999999
start with 641
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TRACKRECORD_ID
prompt ====================================
prompt
create sequence EMR.SEQ_TRACKRECORD_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_USERCFG_ID
prompt ================================
prompt
create sequence EMR.SEQ_USERCFG_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_USERMATCHDISEASESGROUP_ID
prompt ===============================================
prompt
create sequence EMR.SEQ_USERMATCHDISEASESGROUP_ID
minvalue 1
maxvalue 999999999999
start with 101
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_ZYMOSIS_REPORT_ID
prompt =======================================
prompt
create sequence EMR.SEQ_ZYMOSIS_REPORT_ID
minvalue 1
maxvalue 999999999999
start with 13969
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_ZYMOSIS_REPORT_SN_ID
prompt ==========================================
prompt
create sequence EMR.SEQ_ZYMOSIS_REPORT_SN_ID
minvalue 1
maxvalue 999999999999
start with 10001
increment by 1
cache 20;

prompt
prompt Creating sequence SQLN_PROF_NUMBER
prompt ==================================
prompt
create sequence EMR.SQLN_PROF_NUMBER
minvalue 1
maxvalue 999999999999999999999999999
start with 41
increment by 1
cache 20;


spool off

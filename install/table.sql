-----------------------------------------------------
-- Export file for user EMR@ORCL                   --
-- Created by Administrator on 2018/5/27, 13:34:51 --
-----------------------------------------------------

set define off
spool table.log

prompt
prompt Creating table ABOUTPRODUCT
prompt ===========================
prompt
create table EMR.ABOUTPRODUCT
(
  productname    NVARCHAR2(20),
  productversion NVARCHAR2(20),
  companyname    NVARCHAR2(20),
  companyaddress NVARCHAR2(20),
  companyurl     NVARCHAR2(40),
  memo           NVARCHAR2(300),
  productcode    NVARCHAR2(20) not null
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.ABOUTPRODUCT
  is '���ڲ�Ʒ';
comment on column EMR.ABOUTPRODUCT.productname
  is '��Ʒ����';
comment on column EMR.ABOUTPRODUCT.productversion
  is '��Ʒ�汾';
comment on column EMR.ABOUTPRODUCT.companyname
  is '��˾����';
comment on column EMR.ABOUTPRODUCT.companyaddress
  is '��˾��ַ';
comment on column EMR.ABOUTPRODUCT.companyurl
  is '��˾��ҳ';
comment on column EMR.ABOUTPRODUCT.memo
  is '��ע˵��';
comment on column EMR.ABOUTPRODUCT.productcode
  is '��Ʒ����';
alter table EMR.ABOUTPRODUCT
  add constraint PK_ABOUTPRODUCT primary key (PRODUCTCODE)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ADVICEFREQUENCY
prompt ==============================
prompt
create table EMR.ADVICEFREQUENCY
(
  id           VARCHAR2(2) not null,
  name         VARCHAR2(16) not null,
  py           VARCHAR2(8),
  wb           VARCHAR2(8),
  executions   INTEGER not null,
  executecycle INTEGER default (1) not null,
  cycleunit    INTEGER not null,
  zid          CHAR(7) default ('') not null,
  executedate  VARCHAR2(64),
  selfid       INTEGER,
  mark         INTEGER,
  valid        INTEGER not null,
  memo         VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.ADVICEFREQUENCY
  add constraint PK_ADVICEFREQUENCY primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ADVICEGROUP
prompt ==========================
prompt
create table EMR.ADVICEGROUP
(
  id       NUMBER(9) not null,
  name     VARCHAR2(32) not null,
  py       VARCHAR2(8),
  wb       VARCHAR2(8),
  deptid   VARCHAR2(12),
  wardid   VARCHAR2(12),
  doctorid VARCHAR2(6),
  userange INTEGER,
  memo     VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.ADVICEGROUP
  add constraint PK_ADVICEGROUP primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table ADVICEGROUPDETAIL
prompt ================================
prompt
create table EMR.ADVICEGROUPDETAIL
(
  detailid        NUMBER(9) not null,
  groupid         NUMBER(9) not null,
  mark            INTEGER,
  sortmark        INTEGER,
  placeofdrug     NUMBER(9) not null,
  standardofdrug  NUMBER(9) not null,
  clinicidofdrug  NUMBER(9) not null,
  drugid          VARCHAR2(12) not null,
  drugname        VARCHAR2(64),
  itemcategory    INTEGER not null,
  minunit         VARCHAR2(10),
  dose            NUMBER(14,3),
  doseunit        VARCHAR2(8),
  measurementunit NUMBER(12,4),
  unitcategory    INTEGER,
  useageid        VARCHAR2(2),
  frequency       VARCHAR2(2) default (''),
  executions      INTEGER default (1),
  executecycle    INTEGER default (1),
  cycleunit       INTEGER default (-1),
  zid             CHAR(7) default (''),
  executedate     VARCHAR2(64),
  executedays     INTEGER,
  druggross       NUMBER(14,3),
  advicecontent   VARCHAR2(64),
  advicecategory  INTEGER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.ADVICEGROUPDETAIL
  add constraint PK_ADVICEGROUPDETAIL primary key (DETAILID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table ALLERGYHISTORY
prompt =============================
prompt
create table EMR.ALLERGYHISTORY
(
  id           NUMBER(9) not null,
  noofinpat    NUMBER(9) not null,
  allergyid    INTEGER not null,
  allergylevel INTEGER not null,
  doctor       VARCHAR2(255),
  allergypart  VARCHAR2(255),
  reactiontype VARCHAR2(255),
  memo         VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_ALLERGYHISTORYPATNOOFHIS on EMR.ALLERGYHISTORY (NOOFINPAT)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.ALLERGYHISTORY
  add constraint PK_ALLERGYHISTORYID primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table ANALYSIS_EMBED
prompt =============================
prompt
create table EMR.ANALYSIS_EMBED
(
  id       VARCHAR2(64) not null,
  name     VARCHAR2(64) not null,
  describe VARCHAR2(255),
  valid    INTEGER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.ANALYSIS_EMBED
  add constraint PK_ANALYSIS_EMBED primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ANALYSIS_PROJECT
prompt ===============================
prompt
create table EMR.ANALYSIS_PROJECT
(
  id        NUMBER(12) not null,
  serialnum VARCHAR2(50) not null,
  name      VARCHAR2(64) not null,
  doctorid  VARCHAR2(6) not null,
  valid     INTEGER,
  memo      VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.ANALYSIS_PROJECT
  add constraint PK_ANALYSIS_PROJECT_ID primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table ANESTHESIA
prompt =========================
prompt
create table EMR.ANESTHESIA
(
  id    VARCHAR2(12) not null,
  mapid VARCHAR2(16),
  name  VARCHAR2(64) not null,
  py    VARCHAR2(8),
  wb    VARCHAR2(8),
  valid INTEGER not null,
  memo  VARCHAR2(16)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.ANESTHESIA
  is '��������';
comment on column EMR.ANESTHESIA.id
  is '���';
comment on column EMR.ANESTHESIA.mapid
  is 'ӳ����';
comment on column EMR.ANESTHESIA.name
  is '��������';
comment on column EMR.ANESTHESIA.py
  is 'ƴ��';
comment on column EMR.ANESTHESIA.wb
  is '���';
comment on column EMR.ANESTHESIA.valid
  is '�Ƿ���Ч';
comment on column EMR.ANESTHESIA.memo
  is '��ע';

prompt
prompt Creating table ANESTHESIA0517BAK
prompt ================================
prompt
create table EMR.ANESTHESIA0517BAK
(
  id    VARCHAR2(12) not null,
  mapid VARCHAR2(16),
  name  VARCHAR2(64) not null,
  py    VARCHAR2(8),
  wb    VARCHAR2(8),
  valid INTEGER not null,
  memo  VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.ANESTHESIA0517BAK
  is '��������';
comment on column EMR.ANESTHESIA0517BAK.id
  is '���';
comment on column EMR.ANESTHESIA0517BAK.mapid
  is 'ӳ����';
comment on column EMR.ANESTHESIA0517BAK.name
  is '��������';
comment on column EMR.ANESTHESIA0517BAK.py
  is 'ƴ��';
comment on column EMR.ANESTHESIA0517BAK.wb
  is '���';
comment on column EMR.ANESTHESIA0517BAK.valid
  is '�Ƿ���Ч';
comment on column EMR.ANESTHESIA0517BAK.memo
  is '��ע';
create index EMR.IDX_ANESTHESIA_PY on EMR.ANESTHESIA0517BAK (PY)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_ANESTHESIA_WB on EMR.ANESTHESIA0517BAK (WB)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_YSDM on EMR.ANESTHESIA0517BAK (MAPID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.ANESTHESIA0517BAK
  add constraint PK_ANESTHESIA primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table APPCFG
prompt =====================
prompt
create table EMR.APPCFG
(
  configkey  VARCHAR2(32) not null,
  name       VARCHAR2(64) not null,
  value      CLOB,
  descript   VARCHAR2(2000) not null,
  paramtype  INTEGER not null,
  cfgkeyset  VARCHAR2(1024),
  design     VARCHAR2(255),
  clientflag INTEGER not null,
  hide       INTEGER not null,
  valid      INTEGER not null,
  createdate DATE,
  sortid     VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 320K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column EMR.APPCFG.configkey
  is '���ô���';
comment on column EMR.APPCFG.name
  is '��������';
comment on column EMR.APPCFG.value
  is 'ֵ';
comment on column EMR.APPCFG.descript
  is '˵��';
comment on column EMR.APPCFG.paramtype
  is '����';
comment on column EMR.APPCFG.createdate
  is '����ʱ��';
comment on column EMR.APPCFG.sortid
  is '������';
alter table EMR.APPCFG
  add constraint PK_APPCFG primary key (CONFIGKEY)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table APPLYRECORD
prompt ==========================
prompt
create table EMR.APPLYRECORD
(
  id          NUMBER(9) not null,
  noofinpat   NUMBER(9) not null,
  applydoctor VARCHAR2(6) not null,
  deptid      VARCHAR2(12) not null,
  applyaim    VARCHAR2(4) not null,
  duetime     NUMBER(9) not null,
  unit        VARCHAR2(4) not null,
  applydate   CHAR(19) not null,
  auditdate   CHAR(19),
  auditman    VARCHAR2(6),
  auditmemo   VARCHAR2(255),
  singindate  CHAR(19),
  singinman   VARCHAR2(6),
  singinmemo  VARCHAR2(255),
  status      VARCHAR2(6) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
  );
alter table EMR.APPLYRECORD
  add constraint PK_APPLYRECORD primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table AREAS
prompt ====================
prompt
create table EMR.AREAS
(
  id         VARCHAR2(6) not null,
  name       VARCHAR2(64) not null,
  py         VARCHAR2(8),
  wb         VARCHAR2(8),
  category   INTEGER not null,
  parentid   VARCHAR2(6),
  parentname VARCHAR2(32),
  memo       VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.AREAS
  add constraint PK_AREAS primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ATTACHEDCARD_HEPATITISB
prompt ======================================
prompt
create table EMR.ATTACHEDCARD_HEPATITISB
(
  id                NUMBER not null,
  report_id         NUMBER not null,
  diagicd10         VARCHAR2(32) not null,
  diagname          VARCHAR2(64),
  hbsagtimetype     NUMBER not null,
  firstattackyear   VARCHAR2(12),
  firstattackmonth  VARCHAR2(12),
  issymptomatic     NUMBER,
  currentalt        VARCHAR2(32) not null,
  hbcigmresult      NUMBER,
  heparresult       NUMBER,
  hbsagandhbschange NUMBER,
  valid             NUMBER,
  createuser        VARCHAR2(6),
  createtime        DATE,
  updateuser        VARCHAR2(6),
  updatetime        DATE,
  memo1             VARCHAR2(50),
  memo2             VARCHAR2(50),
  memo3             VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.ATTACHEDCARD_HEPATITISB
  add constraint PK_ATTACHEDCARD_HEPATITISB primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ATTENDINGPHYSICIAN
prompt =================================
prompt
create table EMR.ATTENDINGPHYSICIAN
(
  id            VARCHAR2(6),
  name          VARCHAR2(16),
  py            VARCHAR2(8),
  wb            VARCHAR2(8),
  deptid        VARCHAR2(12),
  relatedisease CLOB
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BED
prompt ==================
prompt
create table EMR.BED
(
  id           VARCHAR2(12) not null,
  wardid       VARCHAR2(12) not null,
  deptid       VARCHAR2(12) not null,
  roomid       VARCHAR2(12) default '��' not null,
  resident     VARCHAR2(6),
  attend       VARCHAR2(6),
  chief        VARCHAR2(6),
  sexinfo      INTEGER not null,
  style        INTEGER not null,
  inbed        INTEGER not null,
  icu          INTEGER,
  noofinpat    NUMBER(9),
  patnoofhis   VARCHAR2(14),
  formerward   VARCHAR2(12),
  formerbedid  VARCHAR2(12),
  formerdeptid VARCHAR2(12),
  borrow       INTEGER,
  valid        INTEGER not null,
  memo         VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 448K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table EMR.BED
  add constraint PK_BED primary key (ID, WARDID, DEPTID, ROOMID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BED20161023
prompt ==========================
prompt
create table EMR.BED20161023
(
  id           VARCHAR2(12) not null,
  wardid       VARCHAR2(12) not null,
  deptid       VARCHAR2(12),
  roomid       VARCHAR2(12),
  resident     VARCHAR2(6),
  attend       VARCHAR2(6),
  chief        VARCHAR2(6),
  sexinfo      INTEGER not null,
  style        INTEGER not null,
  inbed        INTEGER not null,
  icu          INTEGER,
  noofinpat    NUMBER(9),
  patnoofhis   VARCHAR2(14),
  formerward   VARCHAR2(12),
  formerbedid  VARCHAR2(12),
  formerdeptid VARCHAR2(12),
  borrow       INTEGER,
  valid        INTEGER not null,
  memo         VARCHAR2(16)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 320K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BEDINFO
prompt ======================
prompt
create table EMR.BEDINFO
(
  id           NUMBER(12) not null,
  noofinpat    NUMBER(9) not null,
  formerward   VARCHAR2(12),
  formerbedid  VARCHAR2(12),
  formerdeptid VARCHAR2(12),
  startdate    CHAR(19) not null,
  enddate      CHAR(19),
  newdept      VARCHAR2(12),
  newward      VARCHAR2(12),
  newbed       VARCHAR2(12),
  mark         INTEGER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 256K
  );
create index EMR.IDX_BEDINFO_NOOFINPAT on EMR.BEDINFO (NOOFINPAT)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
  );
alter table EMR.BEDINFO
  add constraint PK_BEDINFO primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
  );

prompt
prompt Creating table BIRTHDEFECTSCARD
prompt ===============================
prompt
create table EMR.BIRTHDEFECTSCARD
(
  id                      VARCHAR2(10) not null,
  report_noofinpat        VARCHAR2(10),
  report_id               VARCHAR2(20),
  diag_code               VARCHAR2(50),
  string3                 VARCHAR2(10),
  string4                 VARCHAR2(10),
  string5                 VARCHAR2(10),
  report_province         VARCHAR2(12),
  report_city             VARCHAR2(12),
  report_town             VARCHAR2(12),
  report_village          VARCHAR2(12),
  report_hospital         VARCHAR2(20),
  report_no               VARCHAR2(20),
  mother_patid            VARCHAR2(30),
  mother_name             VARCHAR2(12),
  mother_age              VARCHAR2(4),
  national                VARCHAR2(8),
  address_post            VARCHAR2(100),
  pregnantno              VARCHAR2(2),
  productionno            VARCHAR2(2),
  localadd                VARCHAR2(2),
  percapitaincome         VARCHAR2(2),
  educationlevel          VARCHAR2(2),
  child_patid             VARCHAR2(30),
  child_name              VARCHAR2(8),
  isbornhere              VARCHAR2(2),
  child_sex               VARCHAR2(2),
  born_year               VARCHAR2(4),
  born_month              VARCHAR2(2),
  born_day                VARCHAR2(2),
  gestationalage          VARCHAR2(2),
  weight                  VARCHAR2(5),
  births                  VARCHAR2(2),
  isidentical             VARCHAR2(2),
  outcome                 VARCHAR2(2),
  inducedlabor            VARCHAR2(2),
  diagnosticbasis         VARCHAR2(2),
  diagnosticbasis1        VARCHAR2(2),
  diagnosticbasis2        VARCHAR2(2),
  diagnosticbasis3        VARCHAR2(2),
  diagnosticbasis4        VARCHAR2(12),
  diagnosticbasis5        VARCHAR2(2),
  diagnosticbasis6        VARCHAR2(2),
  diagnosticbasis7        VARCHAR2(12),
  diag_anencephaly        VARCHAR2(2),
  diag_spina              VARCHAR2(2),
  diag_pengout            VARCHAR2(2),
  diag_hydrocephalus      VARCHAR2(2),
  diag_cleftpalate        VARCHAR2(2),
  diag_cleftlip           VARCHAR2(2),
  diag_cleftmerger        VARCHAR2(2),
  diag_smallears          VARCHAR2(2),
  diag_outerear           VARCHAR2(2),
  diag_esophageal         VARCHAR2(2),
  diag_rectum             VARCHAR2(2),
  diag_hypospadias        VARCHAR2(2),
  diag_bladder            VARCHAR2(2),
  diag_horseshoefootleft  VARCHAR2(2),
  diag_horseshoefootright VARCHAR2(2),
  diag_manypointleft      VARCHAR2(2),
  diag_manypointright     VARCHAR2(2),
  diag_limbsupperleft     VARCHAR2(2),
  diag_limbsupperright    VARCHAR2(2),
  diag_limbslowerleft     VARCHAR2(2),
  diag_limbslowerright    VARCHAR2(2),
  diag_hernia             VARCHAR2(2),
  diag_bulgingbelly       VARCHAR2(2),
  diag_gastroschisis      VARCHAR2(2),
  diag_twins              VARCHAR2(2),
  diag_tssyndrome         VARCHAR2(2),
  diag_heartdisease       VARCHAR2(2),
  diag_other              VARCHAR2(2),
  diag_othercontent       VARCHAR2(100),
  fever                   VARCHAR2(2),
  virusinfection          VARCHAR2(50),
  illother                VARCHAR2(50),
  sulfa                   VARCHAR2(50),
  antibiotics             VARCHAR2(50),
  birthcontrolpill        VARCHAR2(50),
  sedatives               VARCHAR2(50),
  medicineother           VARCHAR2(50),
  drinking                VARCHAR2(50),
  pesticide               VARCHAR2(50),
  ray                     VARCHAR2(50),
  chemicalagents          VARCHAR2(50),
  factorother             VARCHAR2(50),
  stillbirthno            VARCHAR2(2),
  abortionno              VARCHAR2(2),
  defectsno               VARCHAR2(2),
  defectsof1              VARCHAR2(20),
  defectsof2              VARCHAR2(20),
  defectsof3              VARCHAR2(20),
  ycdefectsof1            VARCHAR2(20),
  ycdefectsof2            VARCHAR2(20),
  ycdefectsof3            VARCHAR2(20),
  kinshipdefects1         VARCHAR2(20),
  kinshipdefects2         VARCHAR2(20),
  kinshipdefects3         VARCHAR2(20),
  cousinmarriage          VARCHAR2(2),
  cousinmarriagebetween   VARCHAR2(20),
  preparer                VARCHAR2(20),
  thetitle1               VARCHAR2(20),
  filldateyear            VARCHAR2(10),
  filldatemonth           VARCHAR2(10),
  filldateday             VARCHAR2(10),
  hospitalreview          VARCHAR2(20),
  thetitle2               VARCHAR2(20),
  hospitalauditdateyear   VARCHAR2(10),
  hospitalauditdatemonth  VARCHAR2(10),
  hospitalauditdateday    VARCHAR2(10),
  provincialview          VARCHAR2(20),
  thetitle3               VARCHAR2(20),
  provincialviewdateyear  VARCHAR2(10),
  provincialviewdatemonth VARCHAR2(10),
  provincialviewdateday   VARCHAR2(10),
  feverno                 VARCHAR2(2),
  isvirusinfection        VARCHAR2(2),
  isdiabetes              VARCHAR2(2),
  isillother              VARCHAR2(2),
  issulfa                 VARCHAR2(2),
  isantibiotics           VARCHAR2(2),
  isbirthcontrolpill      VARCHAR2(2),
  issedatives             VARCHAR2(2),
  ismedicineother         VARCHAR2(2),
  isdrinking              VARCHAR2(2),
  ispesticide             VARCHAR2(2),
  isray                   VARCHAR2(2),
  ischemicalagents        VARCHAR2(2),
  isfactorother           VARCHAR2(2),
  state                   VARCHAR2(1),
  create_date             VARCHAR2(19),
  create_usercode         VARCHAR2(6),
  create_username         VARCHAR2(32),
  create_deptcode         VARCHAR2(12),
  create_deptname         VARCHAR2(32),
  modify_date             VARCHAR2(19),
  modify_usercode         VARCHAR2(6),
  modify_username         VARCHAR2(32),
  modify_deptcode         VARCHAR2(12),
  modify_deptname         VARCHAR2(32),
  audit_date              VARCHAR2(19),
  audit_usercode          VARCHAR2(6),
  audit_username          VARCHAR2(32),
  audit_deptcode          VARCHAR2(12),
  audit_deptname          VARCHAR2(32),
  vaild                   VARCHAR2(2) default 1,
  cancelreason            VARCHAR2(200),
  prenatal                VARCHAR2(2),
  prenatalno              VARCHAR2(2),
  postpartum              VARCHAR2(2),
  andtoshowleft           VARCHAR2(2),
  andtoshowright          VARCHAR2(2)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on column EMR.BIRTHDEFECTSCARD.id
  is '���';
comment on column EMR.BIRTHDEFECTSCARD.report_noofinpat
  is '������ҳ���';
comment on column EMR.BIRTHDEFECTSCARD.report_id
  is '���濨���';
comment on column EMR.BIRTHDEFECTSCARD.diag_code
  is '���ֱ��';
comment on column EMR.BIRTHDEFECTSCARD.string3
  is 'Ԥ��4';
comment on column EMR.BIRTHDEFECTSCARD.string4
  is 'Ԥ��5';
comment on column EMR.BIRTHDEFECTSCARD.string5
  is 'Ԥ��6';
comment on column EMR.BIRTHDEFECTSCARD.report_province
  is '���濨ʡ��';
comment on column EMR.BIRTHDEFECTSCARD.report_city
  is '���濨�У��أ�';
comment on column EMR.BIRTHDEFECTSCARD.report_town
  is '���濨����';
comment on column EMR.BIRTHDEFECTSCARD.report_village
  is '���濨��';
comment on column EMR.BIRTHDEFECTSCARD.report_hospital
  is '���濨ҽԺ';
comment on column EMR.BIRTHDEFECTSCARD.report_no
  is '���Ϸ��������';
comment on column EMR.BIRTHDEFECTSCARD.mother_patid
  is '����סԺ��';
comment on column EMR.BIRTHDEFECTSCARD.mother_name
  is '����';
comment on column EMR.BIRTHDEFECTSCARD.mother_age
  is '����';
comment on column EMR.BIRTHDEFECTSCARD.national
  is '����';
comment on column EMR.BIRTHDEFECTSCARD.address_post
  is '��ַand�ʱ�';
comment on column EMR.BIRTHDEFECTSCARD.pregnantno
  is '�д�';
comment on column EMR.BIRTHDEFECTSCARD.productionno
  is '����';
comment on column EMR.BIRTHDEFECTSCARD.localadd
  is '��ס��';
comment on column EMR.BIRTHDEFECTSCARD.percapitaincome
  is '���˾�����';
comment on column EMR.BIRTHDEFECTSCARD.educationlevel
  is '�Ļ��̶�';
comment on column EMR.BIRTHDEFECTSCARD.child_patid
  is '����סԺ��';
comment on column EMR.BIRTHDEFECTSCARD.child_name
  is '��������';
comment on column EMR.BIRTHDEFECTSCARD.isbornhere
  is '�Ƿ�Ժ����';
comment on column EMR.BIRTHDEFECTSCARD.child_sex
  is '�����Ա�';
comment on column EMR.BIRTHDEFECTSCARD.born_year
  is '������';
comment on column EMR.BIRTHDEFECTSCARD.born_month
  is '������';
comment on column EMR.BIRTHDEFECTSCARD.born_day
  is '������';
comment on column EMR.BIRTHDEFECTSCARD.gestationalage
  is '̥��';
comment on column EMR.BIRTHDEFECTSCARD.weight
  is '����';
comment on column EMR.BIRTHDEFECTSCARD.births
  is '̥��';
comment on column EMR.BIRTHDEFECTSCARD.isidentical
  is '�Ƿ�ͬ��';
comment on column EMR.BIRTHDEFECTSCARD.outcome
  is 'ת��';
comment on column EMR.BIRTHDEFECTSCARD.inducedlabor
  is '�Ƿ�����';
comment on column EMR.BIRTHDEFECTSCARD.diagnosticbasis
  is '������ݡ����ٴ�';
comment on column EMR.BIRTHDEFECTSCARD.diagnosticbasis1
  is '������ݡ���������';
comment on column EMR.BIRTHDEFECTSCARD.diagnosticbasis2
  is '������ݡ���ʬ��';
comment on column EMR.BIRTHDEFECTSCARD.diagnosticbasis3
  is '������ݡ����������';
comment on column EMR.BIRTHDEFECTSCARD.diagnosticbasis4
  is '������ݡ���������顪������';
comment on column EMR.BIRTHDEFECTSCARD.diagnosticbasis5
  is '������ݡ���Ⱦɫ��';
comment on column EMR.BIRTHDEFECTSCARD.diagnosticbasis6
  is '������ݡ�������';
comment on column EMR.BIRTHDEFECTSCARD.diagnosticbasis7
  is '������ݡ���������������';
comment on column EMR.BIRTHDEFECTSCARD.diag_anencephaly
  is '����ȱ����ϡ������Ի���';
comment on column EMR.BIRTHDEFECTSCARD.diag_spina
  is '����ȱ����ϡ���������';
comment on column EMR.BIRTHDEFECTSCARD.diag_pengout
  is '����ȱ����ϡ��������';
comment on column EMR.BIRTHDEFECTSCARD.diag_hydrocephalus
  is '����ȱ����ϡ����������Ի�ˮ';
comment on column EMR.BIRTHDEFECTSCARD.diag_cleftpalate
  is '����ȱ����ϡ�������';
comment on column EMR.BIRTHDEFECTSCARD.diag_cleftlip
  is '����ȱ����ϡ�������';
comment on column EMR.BIRTHDEFECTSCARD.diag_cleftmerger
  is '����ȱ����ϡ������Ѻϲ�����';
comment on column EMR.BIRTHDEFECTSCARD.diag_smallears
  is '����ȱ����ϡ���С���������޶���';
comment on column EMR.BIRTHDEFECTSCARD.diag_outerear
  is '����ȱ����ϡ�������������Σ�С�����޶����⣩';
comment on column EMR.BIRTHDEFECTSCARD.diag_esophageal
  is '����ȱ����ϡ���ʳ����������խ';
comment on column EMR.BIRTHDEFECTSCARD.diag_rectum
  is '����ȱ����ϡ���ֱ�����ű�������խ�������޸أ�';
comment on column EMR.BIRTHDEFECTSCARD.diag_hypospadias
  is '����ȱ����ϡ����������';
comment on column EMR.BIRTHDEFECTSCARD.diag_bladder
  is '����ȱ����ϡ��������ⷭ';
comment on column EMR.BIRTHDEFECTSCARD.diag_horseshoefootleft
  is '����ȱ����ϡ��������ڷ���_�� ';
comment on column EMR.BIRTHDEFECTSCARD.diag_horseshoefootright
  is '����ȱ����ϡ��������ڷ���_��';
comment on column EMR.BIRTHDEFECTSCARD.diag_manypointleft
  is '����ȱ����ϡ�����ָ��ֺ��_��';
comment on column EMR.BIRTHDEFECTSCARD.diag_manypointright
  is '����ȱ����ϡ�����ָ��ֺ��_��';
comment on column EMR.BIRTHDEFECTSCARD.diag_limbsupperleft
  is '����ȱ����ϡ���֫�����_��֫ _��';
comment on column EMR.BIRTHDEFECTSCARD.diag_limbsupperright
  is '����ȱ����ϡ���֫�����_��֫ _��';
comment on column EMR.BIRTHDEFECTSCARD.diag_limbslowerleft
  is '����ȱ����ϡ���֫�����_��֫ _��';
comment on column EMR.BIRTHDEFECTSCARD.diag_limbslowerright
  is '����ȱ����ϡ���֫�����_��֫ _��';
comment on column EMR.BIRTHDEFECTSCARD.diag_hernia
  is '����ȱ����ϡ�������������';
comment on column EMR.BIRTHDEFECTSCARD.diag_bulgingbelly
  is '����ȱ����ϡ��������';
comment on column EMR.BIRTHDEFECTSCARD.diag_gastroschisis
  is '����ȱ����ϡ�������';
comment on column EMR.BIRTHDEFECTSCARD.diag_twins
  is '����ȱ����ϡ�������˫̥';
comment on column EMR.BIRTHDEFECTSCARD.diag_tssyndrome
  is '����ȱ����ϡ��������ۺ�����21-�����ۺ�����';
comment on column EMR.BIRTHDEFECTSCARD.diag_heartdisease
  is '����ȱ����ϡ������������ಡ�����ͣ�';
comment on column EMR.BIRTHDEFECTSCARD.diag_other
  is '����ȱ����ϡ���������д����������ϸ������';
comment on column EMR.BIRTHDEFECTSCARD.diag_othercontent
  is '����ȱ����ϡ�����������';
comment on column EMR.BIRTHDEFECTSCARD.fever
  is '���գ���38�棩';
comment on column EMR.BIRTHDEFECTSCARD.virusinfection
  is '������Ⱦ';
comment on column EMR.BIRTHDEFECTSCARD.illother
  is '��������';
comment on column EMR.BIRTHDEFECTSCARD.sulfa
  is '�ǰ���';
comment on column EMR.BIRTHDEFECTSCARD.antibiotics
  is '������';
comment on column EMR.BIRTHDEFECTSCARD.birthcontrolpill
  is '����ҩ';
comment on column EMR.BIRTHDEFECTSCARD.sedatives
  is '��ҩ';
comment on column EMR.BIRTHDEFECTSCARD.medicineother
  is '��ҩ����';
comment on column EMR.BIRTHDEFECTSCARD.drinking
  is '����';
comment on column EMR.BIRTHDEFECTSCARD.pesticide
  is 'ũҩ';
comment on column EMR.BIRTHDEFECTSCARD.ray
  is '����';
comment on column EMR.BIRTHDEFECTSCARD.chemicalagents
  is '��ѧ�Ƽ�';
comment on column EMR.BIRTHDEFECTSCARD.factorother
  is '�����к�����';
comment on column EMR.BIRTHDEFECTSCARD.stillbirthno
  is '��̥����';
comment on column EMR.BIRTHDEFECTSCARD.abortionno
  is '��Ȼ��������';
comment on column EMR.BIRTHDEFECTSCARD.defectsno
  is 'ȱ�ݶ�����';
comment on column EMR.BIRTHDEFECTSCARD.defectsof1
  is 'ȱ����1';
comment on column EMR.BIRTHDEFECTSCARD.defectsof2
  is 'ȱ����2';
comment on column EMR.BIRTHDEFECTSCARD.defectsof3
  is 'ȱ����3';
comment on column EMR.BIRTHDEFECTSCARD.ycdefectsof1
  is '�Ŵ�ȱ����1';
comment on column EMR.BIRTHDEFECTSCARD.ycdefectsof2
  is '�Ŵ�ȱ����2';
comment on column EMR.BIRTHDEFECTSCARD.ycdefectsof3
  is '�Ŵ�ȱ����3';
comment on column EMR.BIRTHDEFECTSCARD.kinshipdefects1
  is '��ȱ�ݶ���Ե��ϵ1';
comment on column EMR.BIRTHDEFECTSCARD.kinshipdefects2
  is '��ȱ�ݶ���Ե��ϵ2';
comment on column EMR.BIRTHDEFECTSCARD.kinshipdefects3
  is '��ȱ�ݶ���Ե��ϵ3';
comment on column EMR.BIRTHDEFECTSCARD.cousinmarriage
  is '���׻���ʷ';
comment on column EMR.BIRTHDEFECTSCARD.cousinmarriagebetween
  is '���׻���ʷ��ϵ';
comment on column EMR.BIRTHDEFECTSCARD.preparer
  is '�����';
comment on column EMR.BIRTHDEFECTSCARD.thetitle1
  is '�����ְ��';
comment on column EMR.BIRTHDEFECTSCARD.filldateyear
  is '���������';
comment on column EMR.BIRTHDEFECTSCARD.filldatemonth
  is '���������';
comment on column EMR.BIRTHDEFECTSCARD.filldateday
  is '���������';
comment on column EMR.BIRTHDEFECTSCARD.hospitalreview
  is 'ҽԺ�����';
comment on column EMR.BIRTHDEFECTSCARD.thetitle2
  is 'ҽԺ�����ְ��';
comment on column EMR.BIRTHDEFECTSCARD.hospitalauditdateyear
  is 'ҽԺ���������';
comment on column EMR.BIRTHDEFECTSCARD.hospitalauditdatemonth
  is 'ҽԺ���������';
comment on column EMR.BIRTHDEFECTSCARD.hospitalauditdateday
  is 'ҽԺ���������';
comment on column EMR.BIRTHDEFECTSCARD.provincialview
  is 'ʡ�������';
comment on column EMR.BIRTHDEFECTSCARD.thetitle3
  is 'ʡ�������ְ��';
comment on column EMR.BIRTHDEFECTSCARD.provincialviewdateyear
  is 'ʡ�����������';
comment on column EMR.BIRTHDEFECTSCARD.provincialviewdatemonth
  is 'ʡ�����������';
comment on column EMR.BIRTHDEFECTSCARD.provincialviewdateday
  is 'ʡ�����������';
comment on column EMR.BIRTHDEFECTSCARD.feverno
  is '���ն���';
comment on column EMR.BIRTHDEFECTSCARD.isvirusinfection
  is '�Ƿ񲡶���Ⱦ';
comment on column EMR.BIRTHDEFECTSCARD.isdiabetes
  is '�Ƿ�����';
comment on column EMR.BIRTHDEFECTSCARD.isillother
  is '�Ƿ񻼲�����';
comment on column EMR.BIRTHDEFECTSCARD.issulfa
  is '�Ƿ�ǰ���';
comment on column EMR.BIRTHDEFECTSCARD.isantibiotics
  is '�Ƿ�����';
comment on column EMR.BIRTHDEFECTSCARD.isbirthcontrolpill
  is '�Ƿ����ҩ';
comment on column EMR.BIRTHDEFECTSCARD.issedatives
  is '�Ƿ���ҩ';
comment on column EMR.BIRTHDEFECTSCARD.ismedicineother
  is '�Ƿ��ҩ����';
comment on column EMR.BIRTHDEFECTSCARD.isdrinking
  is '�Ƿ�����';
comment on column EMR.BIRTHDEFECTSCARD.ispesticide
  is '�Ƿ�ũҩ';
comment on column EMR.BIRTHDEFECTSCARD.isray
  is '�Ƿ�����';
comment on column EMR.BIRTHDEFECTSCARD.ischemicalagents
  is '�Ƿ�ѧ�Ƽ�';
comment on column EMR.BIRTHDEFECTSCARD.isfactorother
  is '�Ƿ������к�����';
comment on column EMR.BIRTHDEFECTSCARD.state
  is '""""����״̬�� 1���������� 2���ύ 3������ 4��?to open this dialog next """';
comment on column EMR.BIRTHDEFECTSCARD.create_date
  is '����ʱ��';
comment on column EMR.BIRTHDEFECTSCARD.create_usercode
  is '������';
comment on column EMR.BIRTHDEFECTSCARD.create_username
  is '������';
comment on column EMR.BIRTHDEFECTSCARD.create_deptcode
  is '�����˿���';
comment on column EMR.BIRTHDEFECTSCARD.create_deptname
  is '�����˿���';
comment on column EMR.BIRTHDEFECTSCARD.modify_date
  is '�޸�ʱ��';
comment on column EMR.BIRTHDEFECTSCARD.modify_usercode
  is '�޸���';
comment on column EMR.BIRTHDEFECTSCARD.modify_username
  is '�޸���';
comment on column EMR.BIRTHDEFECTSCARD.modify_deptcode
  is '�޸��˿���';
comment on column EMR.BIRTHDEFECTSCARD.modify_deptname
  is '�޸��˿���';
comment on column EMR.BIRTHDEFECTSCARD.audit_date
  is '���ʱ��';
comment on column EMR.BIRTHDEFECTSCARD.audit_usercode
  is '�����';
comment on column EMR.BIRTHDEFECTSCARD.audit_username
  is '�����';
comment on column EMR.BIRTHDEFECTSCARD.audit_deptcode
  is '����˿���';
comment on column EMR.BIRTHDEFECTSCARD.audit_deptname
  is '����˿���';
comment on column EMR.BIRTHDEFECTSCARD.vaild
  is '״̬�Ƿ���Ч  1����Ч   0����Ч';
comment on column EMR.BIRTHDEFECTSCARD.cancelreason
  is '���ԭ��';
comment on column EMR.BIRTHDEFECTSCARD.prenatal
  is '��ǰ';
comment on column EMR.BIRTHDEFECTSCARD.prenatalno
  is '��ǰ����';
comment on column EMR.BIRTHDEFECTSCARD.postpartum
  is '����';
comment on column EMR.BIRTHDEFECTSCARD.andtoshowleft
  is '��ָ��';
comment on column EMR.BIRTHDEFECTSCARD.andtoshowright
  is '��ָ��';

prompt
prompt Creating table CARDIOVASCULARCARD
prompt =================================
prompt
create table EMR.CARDIOVASCULARCARD
(
  id              NUMBER,
  report_no       VARCHAR2(32),
  noofclinic      VARCHAR2(32),
  patid           VARCHAR2(32),
  name            VARCHAR2(32),
  idno            VARCHAR2(32),
  sexid           VARCHAR2(4),
  birth           CHAR(19),
  age             VARCHAR2(32),
  nationid        VARCHAR2(4),
  jobid           VARCHAR2(20),
  officeplace     VARCHAR2(500),
  contacttel      VARCHAR2(50),
  hkprovice       VARCHAR2(50),
  hkcity          VARCHAR2(50),
  hkstreet        VARCHAR2(100),
  hkaddressid     VARCHAR2(50),
  xzzprovice      VARCHAR2(50),
  xzzcity         VARCHAR2(50),
  xzzstreet       VARCHAR2(100),
  xzzaddressid    VARCHAR2(50),
  xzzcommittees   VARCHAR2(100),
  xzzparm         VARCHAR2(100),
  icd             VARCHAR2(32),
  diagzwmxqcx     VARCHAR2(32),
  diagncx         VARCHAR2(32),
  diagngs         VARCHAR2(32),
  diagwflnzz      VARCHAR2(32),
  diagjxxjgs      VARCHAR2(32),
  diagxxcs        VARCHAR2(32),
  diagnosisbased  VARCHAR2(100),
  diagnosedate    VARCHAR2(19),
  isfirstsick     VARCHAR2(4),
  diaghospital    VARCHAR2(4),
  outflag         VARCHAR2(4),
  diedate         VARCHAR2(19),
  reportdept      VARCHAR2(32),
  reportusercode  VARCHAR2(32),
  reportusername  VARCHAR2(32),
  reportdate      VARCHAR2(19),
  create_date     VARCHAR2(19),
  create_usercode VARCHAR2(6),
  create_username VARCHAR2(32),
  create_deptcode VARCHAR2(12),
  create_deptname VARCHAR2(32),
  modify_date     VARCHAR2(19),
  modify_usercode VARCHAR2(6),
  modify_username VARCHAR2(32),
  modify_deptcode VARCHAR2(12),
  modify_deptname VARCHAR2(32),
  audit_date      VARCHAR2(19),
  audit_usercode  VARCHAR2(6),
  audit_username  VARCHAR2(32),
  audit_deptcode  VARCHAR2(12),
  audit_deptname  VARCHAR2(32),
  vaild           VARCHAR2(2) default 1,
  cancelreason    VARCHAR2(200),
  state           VARCHAR2(1),
  cardparam1      VARCHAR2(32),
  cardparam2      VARCHAR2(32),
  cardparam3      VARCHAR2(32),
  cardparam4      VARCHAR2(32),
  cardparam5      VARCHAR2(32),
  noofinpat       VARCHAR2(32) not null
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.CARDIOVASCULARCARD.id
  is '������';
comment on column EMR.CARDIOVASCULARCARD.report_no
  is '���濨����';
comment on column EMR.CARDIOVASCULARCARD.noofclinic
  is '�����';
comment on column EMR.CARDIOVASCULARCARD.patid
  is 'סԺ��';
comment on column EMR.CARDIOVASCULARCARD.name
  is '����';
comment on column EMR.CARDIOVASCULARCARD.idno
  is '���֤����';
comment on column EMR.CARDIOVASCULARCARD.sexid
  is '�Ա�';
comment on column EMR.CARDIOVASCULARCARD.birth
  is '��������';
comment on column EMR.CARDIOVASCULARCARD.age
  is '����';
comment on column EMR.CARDIOVASCULARCARD.nationid
  is '����';
comment on column EMR.CARDIOVASCULARCARD.jobid
  is 'ְҵ';
comment on column EMR.CARDIOVASCULARCARD.officeplace
  is '������λ';
comment on column EMR.CARDIOVASCULARCARD.contacttel
  is '��ϵ�绰';
comment on column EMR.CARDIOVASCULARCARD.hkprovice
  is '������ַʡ';
comment on column EMR.CARDIOVASCULARCARD.hkcity
  is '������ַ�У��أ�';
comment on column EMR.CARDIOVASCULARCARD.hkstreet
  is '������ַ�ֵ�';
comment on column EMR.CARDIOVASCULARCARD.hkaddressid
  is '������ַ����';
comment on column EMR.CARDIOVASCULARCARD.xzzprovice
  is '��סַʡ';
comment on column EMR.CARDIOVASCULARCARD.xzzcity
  is '��סַ�У��أ�';
comment on column EMR.CARDIOVASCULARCARD.xzzstreet
  is '��סַ�ֵ�';
comment on column EMR.CARDIOVASCULARCARD.xzzaddressid
  is '��סַ����';
comment on column EMR.CARDIOVASCULARCARD.xzzcommittees
  is '��סַ��ί��';
comment on column EMR.CARDIOVASCULARCARD.xzzparm
  is '��סַ��ί�������λ';
comment on column EMR.CARDIOVASCULARCARD.icd
  is 'ICD����';
comment on column EMR.CARDIOVASCULARCARD.diagzwmxqcx
  is '����������Ĥ��ǻ��Ѫ';
comment on column EMR.CARDIOVASCULARCARD.diagncx
  is '�������Գ�Ѫ';
comment on column EMR.CARDIOVASCULARCARD.diagngs
  is '�������Թ���';
comment on column EMR.CARDIOVASCULARCARD.diagwflnzz
  is '������δ����������';
comment on column EMR.CARDIOVASCULARCARD.diagjxxjgs
  is '���Ĳ������ļ�����';
comment on column EMR.CARDIOVASCULARCARD.diagxxcs
  is '���Ĳ��������';
comment on column EMR.CARDIOVASCULARCARD.diagnosisbased
  is '������ݿɶ�ѡ�ٴ�֢״��  �ĵ�ͼ��  Ѫ����Ӱ��  CT��  �Ź����  ������
��������  ʵ���Ҽ��� ������������
';
comment on column EMR.CARDIOVASCULARCARD.diagnosedate
  is 'ȷ������';
comment on column EMR.CARDIOVASCULARCARD.isfirstsick
  is '�Ƿ��״η���';
comment on column EMR.CARDIOVASCULARCARD.diaghospital
  is 'ȷ�ﵥλ1��ʡ��ҽԺ 2���м�ҽԺ  3���ؼ�ҽԺ 4������ҽԺ 5������ 9������';
comment on column EMR.CARDIOVASCULARCARD.outflag
  is 'ת�� 1������  2����ת  3��δ��   4������  5������';
comment on column EMR.CARDIOVASCULARCARD.diedate
  is '����ʱ�����ת��Ϊ4ʱ��д��';
comment on column EMR.CARDIOVASCULARCARD.reportdept
  is '���浥λ';
comment on column EMR.CARDIOVASCULARCARD.reportusercode
  is '����ҽ������';
comment on column EMR.CARDIOVASCULARCARD.reportusername
  is '����ҽ������';
comment on column EMR.CARDIOVASCULARCARD.reportdate
  is '��������';
comment on column EMR.CARDIOVASCULARCARD.create_date
  is '����ʱ��';
comment on column EMR.CARDIOVASCULARCARD.create_usercode
  is '������';
comment on column EMR.CARDIOVASCULARCARD.create_username
  is '������';
comment on column EMR.CARDIOVASCULARCARD.create_deptcode
  is '�����˿���';
comment on column EMR.CARDIOVASCULARCARD.create_deptname
  is '�����˿���';
comment on column EMR.CARDIOVASCULARCARD.modify_date
  is '�޸�ʱ��';
comment on column EMR.CARDIOVASCULARCARD.modify_usercode
  is '�޸���';
comment on column EMR.CARDIOVASCULARCARD.modify_username
  is '�޸���';
comment on column EMR.CARDIOVASCULARCARD.modify_deptcode
  is '�޸��˿���';
comment on column EMR.CARDIOVASCULARCARD.modify_deptname
  is '�޸��˿���';
comment on column EMR.CARDIOVASCULARCARD.audit_date
  is '���ʱ��';
comment on column EMR.CARDIOVASCULARCARD.audit_usercode
  is '�����';
comment on column EMR.CARDIOVASCULARCARD.audit_username
  is '�����';
comment on column EMR.CARDIOVASCULARCARD.audit_deptcode
  is '����˿���';
comment on column EMR.CARDIOVASCULARCARD.audit_deptname
  is '����˿���';
comment on column EMR.CARDIOVASCULARCARD.vaild
  is '״̬�Ƿ���Ч  1����Ч   0����Ч';
comment on column EMR.CARDIOVASCULARCARD.cancelreason
  is '���ԭ��';
comment on column EMR.CARDIOVASCULARCARD.state
  is '����״̬�� 1���������� 2���ύ 3������ 4�����ͨ�� 5�����δͨ������ 6���ϱ�  7�����ϡ�';
comment on column EMR.CARDIOVASCULARCARD.cardparam1
  is 'Ԥ���ֶ�';
comment on column EMR.CARDIOVASCULARCARD.cardparam2
  is 'Ԥ���ֶ�';
comment on column EMR.CARDIOVASCULARCARD.cardparam3
  is 'Ԥ���ֶ�';
comment on column EMR.CARDIOVASCULARCARD.cardparam4
  is 'Ԥ���ֶ�';
comment on column EMR.CARDIOVASCULARCARD.cardparam5
  is 'Ԥ���ֶ�';
comment on column EMR.CARDIOVASCULARCARD.noofinpat
  is '������ҳ���';

prompt
prompt Creating table CATEGORYDETAIL
prompt =============================
prompt
create table EMR.CATEGORYDETAIL
(
  id         INTEGER not null,
  name       VARCHAR2(16) not null,
  categoryid INTEGER not null,
  py         VARCHAR2(8),
  wb         VARCHAR2(8),
  memo       VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.CATEGORYDETAIL
  add constraint PK_CATEGORYDETAIL primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CCLIB
prompt ====================
prompt
create table EMR.CCLIB
(
  chinese CHAR(2) not null,
  py      CHAR(1) not null,
  wb      CHAR(1) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CHARGINGBIGITEM
prompt ==============================
prompt
create table EMR.CHARGINGBIGITEM
(
  itemid       VARCHAR2(12) not null,
  name         VARCHAR2(16) not null,
  py           VARCHAR2(8),
  wb           VARCHAR2(8),
  mark         INTEGER not null,
  itemcategroy INTEGER not null,
  memo         VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_CHARGINGBIGITEM_PY on EMR.CHARGINGBIGITEM (PY)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_CHARGINGBIGITEM_WB on EMR.CHARGINGBIGITEM (WB)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.CHARGINGBIGITEM
  add constraint PK_CHARGINGBIGITEM primary key (ITEMID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CHARGINGMINITEM
prompt ==============================
prompt
create table EMR.CHARGINGMINITEM
(
  itemid       VARCHAR2(12) not null,
  name         VARCHAR2(64) not null,
  py           VARCHAR2(8),
  wb           VARCHAR2(8),
  bigitem      VARCHAR2(12) not null,
  unit         VARCHAR2(12),
  format       VARCHAR2(32),
  price        NUMBER(10,4) not null,
  mzbxmark     INTEGER not null,
  zybxmark     INTEGER not null,
  itemcategroy INTEGER not null,
  mark         INTEGER not null,
  itemnature   INTEGER not null,
  showmark     INTEGER not null,
  extra        VARCHAR2(16),
  usagescope   INTEGER,
  advicemark   INTEGER,
  valid        INTEGER not null,
  memo         VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 896K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_CHARGINGMINITEM_PY on EMR.CHARGINGMINITEM (PY)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 320K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_CHARGINGMINITEM_WB on EMR.CHARGINGMINITEM (WB)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 256K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.CHARGINGMINITEM
  add constraint PK_CHARGINGMINITEM primary key (ITEMID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CLIENT_LOG
prompt =========================
prompt
create table EMR.CLIENT_LOG
(
  ip      VARCHAR2(20) not null,
  ip_code VARCHAR2(64)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 320K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column EMR.CLIENT_LOG.ip
  is 'IP��ַ';
comment on column EMR.CLIENT_LOG.ip_code
  is '���ܺ�IP��ַ';
alter table EMR.CLIENT_LOG
  add constraint PK_CLIENT_LOG primary key (IP)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CLINICOFDRUG
prompt ===========================
prompt
create table EMR.CLINICOFDRUG
(
  id           NUMBER(9) not null,
  name         VARCHAR2(64) not null,
  enname       VARCHAR2(32),
  py           VARCHAR2(8),
  wb           VARCHAR2(8),
  dosageid     VARCHAR2(12),
  formatid     VARCHAR2(12),
  pharmacology VARCHAR2(16),
  valid        INTEGER not null,
  memo         VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 384K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_CLINICOFDRUG_PY on EMR.CLINICOFDRUG (PY)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_CLINICOFDRUG_WB on EMR.CLINICOFDRUG (WB)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.CLINICOFDRUG
  add constraint PK_DRUGPLACE primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMMONNOTE
prompt =========================
prompt
create table EMR.COMMONNOTE
(
  commonnoteflow   VARCHAR2(50) not null,
  commonnotename   VARCHAR2(50),
  printemodelname  VARCHAR2(50),
  showtype         VARCHAR2(50),
  createdoctorid   VARCHAR2(50),
  createdoctorname VARCHAR2(50),
  createdatetime   VARCHAR2(14),
  usingflag        VARCHAR2(1),
  valide           VARCHAR2(1),
  pym              VARCHAR2(50),
  wbm              VARCHAR2(50),
  usingpicsign     VARCHAR2(1),
  usingcheckdoc    VARCHAR2(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.COMMONNOTE.commonnoteflow
  is 'ͨ�õ���Ψһ��ˮ��';
comment on column EMR.COMMONNOTE.commonnotename
  is 'ͨ�õ�����';
comment on column EMR.COMMONNOTE.printemodelname
  is 'ģ������';
comment on column EMR.COMMONNOTE.showtype
  is 'չʾ��ʽ ���ڵ� �ļ���';
comment on column EMR.COMMONNOTE.createdoctorid
  is '������ID';
comment on column EMR.COMMONNOTE.createdoctorname
  is '����������';
comment on column EMR.COMMONNOTE.createdatetime
  is '����ʱ��';
comment on column EMR.COMMONNOTE.usingflag
  is '1���� 0 ������';
comment on column EMR.COMMONNOTE.valide
  is '1ʹ�� 0��ʹ��';
comment on column EMR.COMMONNOTE.pym
  is 'ƴ����';
comment on column EMR.COMMONNOTE.wbm
  is '�����';
alter table EMR.COMMONNOTE
  add constraint PK_COMMONNOTEFLOW primary key (COMMONNOTEFLOW)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMMONNOTECOUNT
prompt ==============================
prompt
create table EMR.COMMONNOTECOUNT
(
  commonnotecountflow VARCHAR2(50) not null,
  commonnoteflow      VARCHAR2(50),
  itemcount           VARCHAR2(50),
  hour12name          VARCHAR2(50),
  hour12time          VARCHAR2(19),
  hour24name          VARCHAR2(50),
  hour24time          VARCHAR2(19),
  valide              VARCHAR2(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.COMMONNOTECOUNT.commonnotecountflow
  is '��ˮ��';
comment on column EMR.COMMONNOTECOUNT.commonnoteflow
  is '���䵥����ˮ��';
comment on column EMR.COMMONNOTECOUNT.itemcount
  is '������Ŀ';
comment on column EMR.COMMONNOTECOUNT.hour12name
  is '12Сʱ��ʾ����';
comment on column EMR.COMMONNOTECOUNT.hour12time
  is '12Сʱͳ��ʱ���';
comment on column EMR.COMMONNOTECOUNT.hour24name
  is '24Сʱͳ������';
comment on column EMR.COMMONNOTECOUNT.hour24time
  is '24Сʱͳ��ʱ���';
comment on column EMR.COMMONNOTECOUNT.valide
  is '�Ƿ�����';
alter table EMR.COMMONNOTECOUNT
  add constraint PK_COMMONNOTECOUNTFLOW primary key (COMMONNOTECOUNTFLOW)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMMONNOTEPRINTTEMP
prompt ==================================
prompt
create table EMR.COMMONNOTEPRINTTEMP
(
  tempflow       VARCHAR2(50) not null,
  tempname       VARCHAR2(50),
  tempcontent    CLOB,
  tempdesc       VARCHAR2(4000),
  createdatetime VARCHAR2(20),
  createuserid   VARCHAR2(20),
  createusername VARCHAR2(20),
  valide         VARCHAR2(1),
  modifydatetime VARCHAR2(20)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.COMMONNOTEPRINTTEMP
  is 'ͨ�õ��ݴ�ӡģ���';
comment on column EMR.COMMONNOTEPRINTTEMP.tempflow
  is '���� ��Guid';
comment on column EMR.COMMONNOTEPRINTTEMP.tempname
  is '�ļ����ƣ�������.xrp�� Ӣ��';
comment on column EMR.COMMONNOTEPRINTTEMP.tempcontent
  is '�ļ����ݴ洢';
comment on column EMR.COMMONNOTEPRINTTEMP.tempdesc
  is '�ļ�����';
comment on column EMR.COMMONNOTEPRINTTEMP.createdatetime
  is '����ʱ��';
comment on column EMR.COMMONNOTEPRINTTEMP.createuserid
  is '������Id';
comment on column EMR.COMMONNOTEPRINTTEMP.createusername
  is '����������';
comment on column EMR.COMMONNOTEPRINTTEMP.valide
  is '�Ƿ���Ч 1:ʹ��  0:ɾ��';
alter table EMR.COMMONNOTEPRINTTEMP
  add constraint PK_TEMPFLOW primary key (TEMPFLOW)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMMONNOTE_ITEM
prompt ==============================
prompt
create table EMR.COMMONNOTE_ITEM
(
  commonnote_item_flow VARCHAR2(50) not null,
  commonnote_tab_flow  VARCHAR2(50),
  commonnoteflow       VARCHAR2(50),
  dataelementflow      VARCHAR2(50),
  dataelementid        VARCHAR2(50),
  dataelementname      VARCHAR2(50),
  ordercode            VARCHAR2(50),
  isvalidate           VARCHAR2(50),
  createdoctorid       VARCHAR2(50),
  createdoctorname     VARCHAR2(50),
  createdatetime       VARCHAR2(14),
  valide               VARCHAR2(1),
  othername            VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 384K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.COMMONNOTE_ITEM.commonnote_item_flow
  is 'ͨ�õ���Ŀ��ˮ��';
comment on column EMR.COMMONNOTE_ITEM.commonnote_tab_flow
  is 'ͨ�õ���ǩ��ˮ�ţ������';
comment on column EMR.COMMONNOTE_ITEM.commonnoteflow
  is 'ͨ�õ���ˮ��';
comment on column EMR.COMMONNOTE_ITEM.dataelementflow
  is '����Ԫ��ˮ��';
comment on column EMR.COMMONNOTE_ITEM.dataelementid
  is '����ԪID';
comment on column EMR.COMMONNOTE_ITEM.dataelementname
  is '����Ԫ����';
comment on column EMR.COMMONNOTE_ITEM.ordercode
  is '������';
comment on column EMR.COMMONNOTE_ITEM.isvalidate
  is '�Ƿ��������У��';
comment on column EMR.COMMONNOTE_ITEM.createdoctorid
  is '������ID';
comment on column EMR.COMMONNOTE_ITEM.createdoctorname
  is '����������';
comment on column EMR.COMMONNOTE_ITEM.createdatetime
  is '����ʱ��';
comment on column EMR.COMMONNOTE_ITEM.valide
  is '1ʹ�� 0��ʹ��';
comment on column EMR.COMMONNOTE_ITEM.othername
  is '����';
alter table EMR.COMMONNOTE_ITEM
  add constraint PK_COMMONNOTE_ITEM_FLOW primary key (COMMONNOTE_ITEM_FLOW)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMMONNOTE_SITE_REF
prompt ==================================
prompt
create table EMR.COMMONNOTE_SITE_REF
(
  site_flow      VARCHAR2(50) not null,
  commonnoteflow VARCHAR2(50),
  relationtype   VARCHAR2(50),
  site_id        VARCHAR2(50),
  valide         VARCHAR2(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 256K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.COMMONNOTE_SITE_REF
  add constraint PK_SITE_FLOW primary key (SITE_FLOW)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 256K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMMONNOTE_TAB
prompt =============================
prompt
create table EMR.COMMONNOTE_TAB
(
  commonnote_tab_flow VARCHAR2(50) not null,
  commonnoteflow      VARCHAR2(50),
  commonnotetabname   VARCHAR2(50),
  usingrole           VARCHAR2(50),
  showtype            VARCHAR2(50),
  ordercode           VARCHAR2(50),
  createdoctorid      VARCHAR2(50),
  createdoctorname    VARCHAR2(50),
  createdatetime      VARCHAR2(14),
  valide              VARCHAR2(1),
  maxrows             VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.COMMONNOTE_TAB.commonnote_tab_flow
  is 'ͨ�õ���ǩ��ˮ��';
comment on column EMR.COMMONNOTE_TAB.commonnoteflow
  is 'ͨ�õ���ˮ�ţ������';
comment on column EMR.COMMONNOTE_TAB.commonnotetabname
  is 'ͨ�õ���ǩ����';
comment on column EMR.COMMONNOTE_TAB.usingrole
  is 'ʹ�ý�ɫ ҽ�� ��ʿ ҽ��ͨ��';
comment on column EMR.COMMONNOTE_TAB.showtype
  is '��ʾ��ʽ ��� ����';
comment on column EMR.COMMONNOTE_TAB.ordercode
  is '������';
comment on column EMR.COMMONNOTE_TAB.createdoctorid
  is '������ID';
comment on column EMR.COMMONNOTE_TAB.createdoctorname
  is '����������';
comment on column EMR.COMMONNOTE_TAB.createdatetime
  is '����ʱ��';
comment on column EMR.COMMONNOTE_TAB.valide
  is '1ʹ�� 0��ʹ��';
alter table EMR.COMMONNOTE_TAB
  add constraint PK_COMMONNOTE_TAB_FLOW primary key (COMMONNOTE_TAB_FLOW)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPLICATIONS
prompt ============================
prompt
create table EMR.COMPLICATIONS
(
  id        CHAR(36) not null,
  icd_code  VARCHAR2(20) not null,
  name      VARCHAR2(50) not null,
  py        VARCHAR2(8),
  wb        VARCHAR2(8),
  sortindex NUMBER,
  valid     NUMBER not null,
  memo      VARCHAR2(300)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.COMPLICATIONS
  add constraint ID primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CONSULTAPPLY
prompt ===========================
prompt
create table EMR.CONSULTAPPLY
(
  consultapplysn    INTEGER not null,
  noofinpat         NUMBER(9) not null,
  urgencytypeid     INTEGER not null,
  consulttypeid     INTEGER not null,
  abstract          VARCHAR2(3000),
  purpose           VARCHAR2(3000),
  applyuser         VARCHAR2(10),
  applytime         VARCHAR2(19) not null,
  director          VARCHAR2(10),
  consulttime       CHAR(19) not null,
  consultlocation   VARCHAR2(255),
  stateid           INTEGER not null,
  consultsuggestion VARCHAR2(3000),
  finishtime        CHAR(19),
  rejectreason      VARCHAR2(255),
  createuser        VARCHAR2(10) not null,
  createtime        CHAR(19) not null,
  modifieduser      VARCHAR2(10),
  modifiedtime      CHAR(19),
  valid             INTEGER not null,
  canceluser        VARCHAR2(10),
  canceltime        CHAR(19),
  applydept         VARCHAR2(12),
  ward              VARCHAR2(12),
  bed               VARCHAR2(12),
  ispay             NUMBER(2),
  audituserid       VARCHAR2(12),
  printconsulttime  CHAR(19),
  paytime           CHAR(19),
  auditlevel        VARCHAR2(4),
  payuser           VARCHAR2(10),
  ispassed          CHAR(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 9M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.CONSULTAPPLY.applydept
  is '�������';
comment on column EMR.CONSULTAPPLY.ward
  is '���߲���';
comment on column EMR.CONSULTAPPLY.bed
  is '���ߴ�λ';
comment on column EMR.CONSULTAPPLY.paytime
  is '�ɷ�ʱ��';
comment on column EMR.CONSULTAPPLY.auditlevel
  is '����˼���';
comment on column EMR.CONSULTAPPLY.payuser
  is '�շ���';
comment on column EMR.CONSULTAPPLY.ispassed
  is '�Ƿ����ͨ�� 1��ͨ�� 0����ͨ��';

prompt
prompt Creating table CONSULTAPPLYDEPARTMENT
prompt =====================================
prompt
create table EMR.CONSULTAPPLYDEPARTMENT
(
  id              INTEGER not null,
  consultapplysn  INTEGER not null,
  ordervalue      INTEGER not null,
  hospitalcode    VARCHAR2(12) not null,
  departmentcode  VARCHAR2(12) not null,
  departmentname  VARCHAR2(32),
  employeecode    VARCHAR2(10),
  employeename    VARCHAR2(16),
  employeelevelid VARCHAR2(10),
  createuser      VARCHAR2(10) not null,
  createtime      CHAR(19) not null,
  valid           INTEGER not null,
  canceluser      VARCHAR2(10),
  canceltime      CHAR(19)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CONSULTFEEINTERFACEMAIN
prompt ======================================
prompt
create table EMR.CONSULTFEEINTERFACEMAIN
(
  procedurename NVARCHAR2(60),
  memo          NVARCHAR2(100),
  datasourcesql NVARCHAR2(2000),
  valid         CHAR(1),
  modifyuser    NVARCHAR2(10),
  modifytime    DATE,
  id            NVARCHAR2(100),
  isopen        CHAR(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CONSULTFEEINTERFACEPARA
prompt ======================================
prompt
create table EMR.CONSULTFEEINTERFACEPARA
(
  parametername      NVARCHAR2(20),
  parametermemo      NVARCHAR2(100),
  parametertype      NVARCHAR2(20),
  parameterdirection NVARCHAR2(10),
  parameterfield     NVARCHAR2(100),
  valid              CHAR(1),
  modifyuser         NVARCHAR2(10),
  modifytime         DATE,
  guid               NVARCHAR2(100),
  orderid            NUMBER,
  mainid             NVARCHAR2(100)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CONSULTRECORDDEPARTMENT
prompt ======================================
prompt
create table EMR.CONSULTRECORDDEPARTMENT
(
  id                INTEGER not null,
  consultapplysn    INTEGER not null,
  ordervalue        INTEGER not null,
  hospitalcode      VARCHAR2(12) not null,
  departmentcode    VARCHAR2(12) not null,
  departmentname    VARCHAR2(32),
  employeecode      VARCHAR2(10),
  employeename      VARCHAR2(16),
  employeelevelid   VARCHAR2(10),
  createuser        VARCHAR2(10) not null,
  createtime        CHAR(19) not null,
  valid             INTEGER not null,
  canceluser        VARCHAR2(10),
  canceltime        CHAR(19),
  issignin          VARCHAR2(5),
  reachtime         CHAR(19),
  consultsuggestion VARCHAR2(3000),
  modifyuser        VARCHAR2(10),
  modifytime        CHAR(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.CONSULTRECORDDEPARTMENT.consultsuggestion
  is '�������  Ԥ������ʱ����';
comment on column EMR.CONSULTRECORDDEPARTMENT.modifyuser
  is '�޸���';
comment on column EMR.CONSULTRECORDDEPARTMENT.modifytime
  is '�޸�ʱ��';

prompt
prompt Creating table CONSULTSUGGESTION
prompt ================================
prompt
create table EMR.CONSULTSUGGESTION
(
  consultapplysn    INTEGER not null,
  createuser        VARCHAR2(12) not null,
  createtime        CHAR(20),
  consultsuggestion VARCHAR2(3000),
  valid             INTEGER,
  state             VARCHAR2(2)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CONSULT_DEPTAUTIO
prompt ================================
prompt
create table EMR.CONSULT_DEPTAUTIO
(
  id         NUMBER(12) not null,
  deptid     VARCHAR2(64) not null,
  userid     VARCHAR2(64) not null,
  valid      NUMBER(2) not null,
  createuser VARCHAR2(64),
  createtime CHAR(19)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.CONSULT_DEPTAUTIO
  add constraint PK_CONSULT_DEPTAUTIO primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CONSULT_DOCTORPARENT
prompt ===================================
prompt
create table EMR.CONSULT_DOCTORPARENT
(
  id           NUMBER(12) not null,
  userid       VARCHAR2(64) not null,
  parentuserid VARCHAR2(64) not null,
  valid        NUMBER(2) not null,
  deptid       VARCHAR2(64),
  createuser   VARCHAR2(64),
  createtime   CHAR(19)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.CONSULT_DOCTORPARENT.deptid
  is '���ű��';
alter table EMR.CONSULT_DOCTORPARENT
  add constraint PK_CONSULT_DOCTORPARENT primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CURRENTDIAG
prompt ==========================
prompt
create table EMR.CURRENTDIAG
(
  patient_id   VARCHAR2(16),
  patient_name VARCHAR2(16),
  diag_code    VARCHAR2(50),
  diag_content VARCHAR2(200)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DATACATEGORY
prompt ===========================
prompt
create table EMR.DATACATEGORY
(
  categoryid  INTEGER not null,
  categoryame VARCHAR2(16) not null,
  py          VARCHAR2(8),
  wb          VARCHAR2(8),
  memo        VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.DATACATEGORY
  add constraint PK_DATACATEGORY primary key (CATEGORYID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DATA_DICTIONARY
prompt ==============================
prompt
create table EMR.DATA_DICTIONARY
(
  id   VARCHAR2(2) not null,
  name VARCHAR2(32) not null,
  py   VARCHAR2(8),
  wb   VARCHAR2(8),
  memo VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.DATA_DICTIONARY
  add constraint PK_DATA_DICTIONARY primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DATEELEMENT
prompt ==========================
prompt
create table EMR.DATEELEMENT
(
  elementflow     VARCHAR2(50) not null,
  elementid       VARCHAR2(50),
  elementname     VARCHAR2(50),
  elementtype     VARCHAR2(50),
  elementform     VARCHAR2(50),
  elementrange    VARCHAR2(4000),
  elementdescribe VARCHAR2(4000),
  elementclass    VARCHAR2(50),
  isdataelemet    VARCHAR2(1),
  elementpym      VARCHAR2(50),
  valid           VARCHAR2(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 320K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.DATEELEMENT.elementflow
  is 'Ψһ��ˮ��';
comment on column EMR.DATEELEMENT.elementid
  is '����Ԫ��ʶ��';
comment on column EMR.DATEELEMENT.elementname
  is '����Ԫ����';
comment on column EMR.DATEELEMENT.elementtype
  is '����Ԫֵ����������';
comment on column EMR.DATEELEMENT.elementform
  is '��ʾ��ʽ';
comment on column EMR.DATEELEMENT.elementrange
  is '�������Դֵ��XML';
comment on column EMR.DATEELEMENT.elementdescribe
  is '����Ԫ����';
comment on column EMR.DATEELEMENT.elementclass
  is '����Ԫ�������';
comment on column EMR.DATEELEMENT.isdataelemet
  is '�Ƿ�Ϊ����������Ԫ 1��  0����';
comment on column EMR.DATEELEMENT.elementpym
  is 'ƴ����';
comment on column EMR.DATEELEMENT.valid
  is '���ñ�־ 1��  0�� ';
alter table EMR.DATEELEMENT
  add constraint PK_DATAELEMENT_FLOW primary key (ELEMENTFLOW)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DEPARTMENT
prompt =========================
prompt
create table EMR.DEPARTMENT
(
  id            VARCHAR2(12) not null,
  name          VARCHAR2(32) not null,
  py            VARCHAR2(16),
  wb            VARCHAR2(12),
  hosno         VARCHAR2(12) default '01',
  adept         VARCHAR2(12),
  bdept         VARCHAR2(12),
  sort          INTEGER not null,
  mark          INTEGER not null,
  totalchief    INTEGER,
  totalresident INTEGER,
  totalattend   INTEGER,
  totalnurse    INTEGER,
  totalbed      INTEGER,
  totalextra    INTEGER,
  valid         INTEGER not null,
  memo          VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.DEPARTMENT
  add constraint PK_DEPARTMENT primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DEPARTMENT_A
prompt ===========================
prompt
create table EMR.DEPARTMENT_A
(
  id   VARCHAR2(6) not null,
  name VARCHAR2(32) not null,
  py   VARCHAR2(8),
  wb   VARCHAR2(8),
  memo VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.DEPARTMENT_A
  add constraint PK_DEPARTMENT_A primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table DEPARTMENT_B
prompt ===========================
prompt
create table EMR.DEPARTMENT_B
(
  id        VARCHAR2(6) not null,
  name      VARCHAR2(32) not null,
  py        VARCHAR2(8),
  wb        VARCHAR2(8),
  memo      VARCHAR2(16),
  deptaid   VARCHAR2(6) not null,
  deptaname VARCHAR2(32) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_DEPARTMENT_B_PY on EMR.DEPARTMENT_B (PY)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_DEPARTMENT_B_WB on EMR.DEPARTMENT_B (WB)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.DEPARTMENT_B
  add constraint PK_DEPARTMENT_B primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table DEPT2DGRS
prompt ========================
prompt
create table EMR.DEPT2DGRS
(
  deptid VARCHAR2(12) not null,
  dgrsid VARCHAR2(12) not null,
  valid  INTEGER not null,
  memo   VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.DEPT2DGRS
  add constraint PK_YY_BZKSDYK primary key (DEPTID, DGRSID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table DEPT2DISEASE
prompt ===========================
prompt
create table EMR.DEPT2DISEASE
(
  deptid    VARCHAR2(12) not null,
  diseaseid LONG not null,
  memo      VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.DEPT2DISEASE
  add constraint PK_DEPT2DISEASE primary key (DEPTID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table DEPT2WARD
prompt ========================
prompt
create table EMR.DEPT2WARD
(
  deptid   VARCHAR2(12) not null,
  wardid   VARCHAR2(12) not null,
  totalbed INTEGER default (0)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.DEPT2WARD
  add constraint PK_YY_KSBQDYK primary key (DEPTID, WARDID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DEPTREP
prompt ======================
prompt
create table EMR.DEPTREP
(
  id          VARCHAR2(30) not null,
  node        INTEGER not null,
  parent_node INTEGER,
  title       VARCHAR2(200) not null,
  content     VARCHAR2(4000),
  indexid     INTEGER,
  valid       VARCHAR2(2)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 832K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.DEPTREP
  is '����֪ʶ���ֵ�';
comment on column EMR.DEPTREP.id
  is '������  ��ӦDEPTREPCLASS��ID';
comment on column EMR.DEPTREP.title
  is '����';
comment on column EMR.DEPTREP.content
  is '����';

prompt
prompt Creating table DEPTREPCLASS
prompt ===========================
prompt
create table EMR.DEPTREPCLASS
(
  id       INTEGER not null,
  name     VARCHAR2(40),
  dept     VARCHAR2(20),
  describe VARCHAR2(200),
  valid    VARCHAR2(1)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.DEPTREPCLASS
  is '����֪ʶ������ֵ�';
comment on column EMR.DEPTREPCLASS.id
  is '������';
comment on column EMR.DEPTREPCLASS.name
  is '�������';
comment on column EMR.DEPTREPCLASS.dept
  is '����';
comment on column EMR.DEPTREPCLASS.describe
  is '˵��';
comment on column EMR.DEPTREPCLASS.valid
  is '��Ч';

prompt
prompt Creating table DEPT_DEDUCTPOINT
prompt ===============================
prompt
create table EMR.DEPT_DEDUCTPOINT
(
  id                NUMBER(12) not null,
  deptcode          INTEGER not null,
  deductpointresult VARCHAR2(1024) not null,
  deductpointcnt    INTEGER,
  creattime         CHAR(19)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.DEPT_DEDUCTPOINT
  add constraint PK_DEPT_DEDUCTPOINT primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table DEPT_DEDUCTPOINTDETAIL
prompt =====================================
prompt
create table EMR.DEPT_DEDUCTPOINTDETAIL
(
  id                NUMBER(12) not null,
  faid              NUMBER(12) not null,
  noofinpat         NUMBER(9) not null,
  deductpointresult VARCHAR2(1024) not null,
  deductpointcnt    INTEGER,
  creattime         CHAR(19)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.DEPT_DEDUCTPOINTDETAIL
  add constraint PK_DEPT_DEDUCTPOINTDETAIL primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table DGRSDEPT
prompt =======================
prompt
create table EMR.DGRSDEPT
(
  id    INTEGER not null,
  name  VARCHAR2(32) not null,
  dgrs  VARCHAR2(12),
  valid INTEGER not null,
  memo  VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.DGRSDEPT
  add constraint PK_YY_BZKSK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table DIAGNOSIS
prompt ========================
prompt
create table EMR.DIAGNOSIS
(
  markid        VARCHAR2(20) not null,
  icd           VARCHAR2(20) not null,
  mapid         VARCHAR2(16),
  standardcode  VARCHAR2(12),
  name          VARCHAR2(100) not null,
  py            VARCHAR2(50),
  wb            VARCHAR2(50),
  tumorid       VARCHAR2(12) default (''),
  statist       VARCHAR2(4),
  innercategory VARCHAR2(4) default (''),
  category      VARCHAR2(4) default (''),
  othercategroy VARCHAR2(4),
  valid         INTEGER not null,
  memo          VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_DIAGNOSIS_ICD on EMR.DIAGNOSIS (ICD)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_DIAGNOSIS_MAPID on EMR.DIAGNOSIS (MAPID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 384K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.DIAGNOSIS
  add constraint PK_YY_YYZDK primary key (MARKID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 960K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DIAGNOSIS2
prompt =========================
prompt
create table EMR.DIAGNOSIS2
(
  markid        VARCHAR2(20) not null,
  icd           VARCHAR2(20) not null,
  mapid         VARCHAR2(16),
  standardcode  VARCHAR2(12),
  name          VARCHAR2(100) not null,
  py            VARCHAR2(50),
  wb            VARCHAR2(50),
  tumorid       VARCHAR2(12),
  statist       VARCHAR2(4),
  innercategory VARCHAR2(4),
  category      VARCHAR2(4),
  othercategroy VARCHAR2(4),
  valid         INTEGER not null,
  memo          VARCHAR2(16)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DIAGNOSISCHIOTHERNAME
prompt ====================================
prompt
create table EMR.DIAGNOSISCHIOTHERNAME
(
  id    VARCHAR2(50) not null,
  icdid VARCHAR2(50),
  name  VARCHAR2(50),
  py    VARCHAR2(50),
  wb    VARCHAR2(50),
  valid VARCHAR2(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.DIAGNOSISCHIOTHERNAME.id
  is '����';
comment on column EMR.DIAGNOSISCHIOTHERNAME.icdid
  is '������Ӧ��Ҫ���ID';
comment on column EMR.DIAGNOSISCHIOTHERNAME.name
  is '����';
alter table EMR.DIAGNOSISCHIOTHERNAME
  add constraint PK_DIAGXCHIOTHERNAMEID primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DIAGNOSISOFCHINESE
prompt =================================
prompt
create table EMR.DIAGNOSISOFCHINESE
(
  id       VARCHAR2(12) not null,
  mapid    VARCHAR2(16),
  name     VARCHAR2(64) not null,
  py       VARCHAR2(8),
  wb       VARCHAR2(8),
  valid    INTEGER not null,
  memo     VARCHAR2(16),
  memo1    VARCHAR2(16),
  category VARCHAR2(4)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.DIAGNOSISOFCHINESE
  is '��ҽ���';
create index EMR.IDX_DIAGNOSISOFCHINESE_MAPID on EMR.DIAGNOSISOFCHINESE (MAPID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_DIAGNOSISOFCHINESE_PY on EMR.DIAGNOSISOFCHINESE (PY)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_DIAGNOSISOFCHINESE_WB on EMR.DIAGNOSISOFCHINESE (WB)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.DIAGNOSISOFCHINESE
  add constraint PK_DIAGNOSISOFCHINESE primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DIAGNOSISOTHERNAME
prompt =================================
prompt
create table EMR.DIAGNOSISOTHERNAME
(
  id    VARCHAR2(50) not null,
  icdid VARCHAR2(50),
  name  VARCHAR2(50),
  py    VARCHAR2(50),
  wb    VARCHAR2(50),
  valid VARCHAR2(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.DIAGNOSISOTHERNAME.id
  is '����';
comment on column EMR.DIAGNOSISOTHERNAME.icdid
  is '������Ӧ��Ҫ���ID';
comment on column EMR.DIAGNOSISOTHERNAME.name
  is '����';
alter table EMR.DIAGNOSISOTHERNAME
  add constraint PK_DIAGOTHERNAMEID primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DIAGNOSISTODEPT
prompt ==============================
prompt
create table EMR.DIAGNOSISTODEPT
(
  markid        VARCHAR2(32) not null,
  icd           VARCHAR2(12) not null,
  mapid         VARCHAR2(16),
  standardcode  VARCHAR2(12),
  name          VARCHAR2(64) not null,
  py            VARCHAR2(8),
  wb            VARCHAR2(8),
  tumorid       VARCHAR2(12),
  statist       VARCHAR2(4),
  innercategory VARCHAR2(4),
  category      VARCHAR2(4),
  othercategroy INTEGER,
  valid         INTEGER not null,
  memo          VARCHAR2(16),
  deptid        VARCHAR2(12)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.DIAGNOSISTODEPT
  is '���ҳ�����Ͽ�';
comment on column EMR.DIAGNOSISTODEPT.deptid
  is '���ұ��';

prompt
prompt Creating table DIAGNOSIS_XT
prompt ===========================
prompt
create table EMR.DIAGNOSIS_XT
(
  icd   VARCHAR2(20) not null,
  name  VARCHAR2(100) not null,
  py    VARCHAR2(50),
  wb    VARCHAR2(50),
  valid INTEGER,
  memo  VARCHAR2(16)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DIAGNOSIS_XT_BJ
prompt ==============================
prompt
create table EMR.DIAGNOSIS_XT_BJ
(
  markid        VARCHAR2(20) not null,
  icd           VARCHAR2(20) not null,
  mapid         VARCHAR2(16),
  standardcode  VARCHAR2(12),
  name          VARCHAR2(100) not null,
  py            VARCHAR2(50),
  wb            VARCHAR2(50),
  tumorid       VARCHAR2(12),
  statist       VARCHAR2(4),
  innercategory VARCHAR2(4),
  category      VARCHAR2(4),
  othercategroy VARCHAR2(4),
  valid         INTEGER,
  memo          VARCHAR2(16)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.DIAGNOSIS_XT_BJ
  add constraint PK_ICD primary key (ICD)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DICTCURE
prompt =======================
prompt
create table EMR.DICTCURE
(
  rep_id    NUMBER(6) not null,
  rep_name  VARCHAR2(80),
  parent_id NUMBER(6),
  son_node  NUMBER(1),
  sno       VARCHAR2(3),
  content   VARCHAR2(4000)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DICTDRUG
prompt =======================
prompt
create table EMR.DICTDRUG
(
  rep_id    NUMBER(6) not null,
  rep_name  VARCHAR2(60),
  ename     VARCHAR2(60),
  parent_id NUMBER(6),
  son_node  NUMBER(1),
  drug_code VARCHAR2(20),
  sno       VARCHAR2(3),
  content   CLOB
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 7M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DICTIONARY_DETAIL
prompt ================================
prompt
create table EMR.DICTIONARY_DETAIL
(
  detailid   VARCHAR2(4) not null,
  mapid      VARCHAR2(16),
  name       VARCHAR2(32) not null,
  py         VARCHAR2(24),
  wb         VARCHAR2(8),
  categoryid VARCHAR2(2) not null,
  valid      INTEGER,
  memo       VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.DICTIONARY_DETAIL
  add constraint PK_DICTIONARY_DETAIL primary key (DETAILID, CATEGORYID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DICTOPERATION
prompt ============================
prompt
create table EMR.DICTOPERATION
(
  rep_id    NUMBER(6) not null,
  rep_name  VARCHAR2(40),
  parent_id NUMBER(6),
  son_node  NUMBER(1),
  sno       VARCHAR2(3),
  content   CLOB
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DICTPERATION
prompt ===========================
prompt
create table EMR.DICTPERATION
(
  rep_id    NUMBER(6) not null,
  rep_name  VARCHAR2(40),
  parent_id NUMBER(6),
  son_node  NUMBER(1),
  sno       VARCHAR2(3),
  content   CLOB
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DICTSTANDARD
prompt ===========================
prompt
create table EMR.DICTSTANDARD
(
  rep_id    NUMBER(6) not null,
  rep_name  VARCHAR2(80),
  parent_id NUMBER(6),
  son_node  NUMBER(1),
  sno       VARCHAR2(3),
  content   CLOB
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DICT_CATALOG
prompt ===========================
prompt
create table EMR.DICT_CATALOG
(
  ccode        VARCHAR2(3) not null,
  cname        VARCHAR2(50) not null,
  ctype        CHAR(1),
  image_index  NUMBER(2),
  simage_index NUMBER(2),
  open_flag    NUMBER(1),
  utype        VARCHAR2(1),
  mtype        VARCHAR2(1),
  mname        VARCHAR2(100),
  args         VARCHAR2(100),
  isused       VARCHAR2(1)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column EMR.DICT_CATALOG.isused
  is 'ģ�����Ƿ�����';

prompt
prompt Creating table DICT_CATALOG_MODULE
prompt ==================================
prompt
create table EMR.DICT_CATALOG_MODULE
(
  app      VARCHAR2(16) not null,
  ccode    VARCHAR2(3) not null,
  pcode    VARCHAR2(2),
  sno      NUMBER(2),
  writable NUMBER(1)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DICT_CONFIG
prompt ==========================
prompt
create table EMR.DICT_CONFIG
(
  key     VARCHAR2(50) not null,
  value   VARCHAR2(50),
  explain VARCHAR2(100)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DICT_DICT
prompt ========================
prompt
create table EMR.DICT_DICT
(
  c_code VARCHAR2(16) not null,
  d_code VARCHAR2(16) not null,
  d_name VARCHAR2(100),
  input  VARCHAR2(30),
  sno    NUMBER,
  ime    VARCHAR2(4),
  memo   VARCHAR2(256)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 768K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DICT_EDITOR_INPUT
prompt ================================
prompt
create table EMR.DICT_EDITOR_INPUT
(
  sno      NUMBER,
  d_name   VARCHAR2(40),
  path     VARCHAR2(40),
  mr_class VARCHAR2(2),
  mr_code  VARCHAR2(12),
  mr_name  VARCHAR2(80),
  mr_attr  VARCHAR2(1)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DICT_GALLERY
prompt ===========================
prompt
create table EMR.DICT_GALLERY
(
  id        VARCHAR2(4) not null,
  file_name VARCHAR2(40),
  path      VARCHAR2(40),
  g_name    VARCHAR2(20),
  dept_id   VARCHAR2(8),
  sno       NUMBER(3),
  img       BLOB
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DICT_MONITOR_ITEM
prompt ================================
prompt
create table EMR.DICT_MONITOR_ITEM
(
  c_code            VARCHAR2(10),
  c_name            VARCHAR2(40),
  i_code            VARCHAR2(10) not null,
  i_name            VARCHAR2(40),
  limit             NUMBER(5),
  start_point       VARCHAR2(20),
  end_point         VARCHAR2(20),
  enabled           NUMBER(1),
  score_level       VARCHAR2(8),
  clinic_item_class VARCHAR2(1),
  clinic_item_code  VARCHAR2(10),
  clinic_item_name  VARCHAR2(40),
  supper_code       VARCHAR2(10),
  e_code            VARCHAR2(10),
  equit_code        VARCHAR2(10),
  process_qc        NUMBER(1)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DICT_POINT
prompt =========================
prompt
create table EMR.DICT_POINT
(
  code        VARCHAR2(10) not null,
  p_name      VARCHAR2(40),
  his_code    VARCHAR2(30),
  his_name    VARCHAR2(40),
  column_code VARCHAR2(30),
  column_name VARCHAR2(40)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DICT_STD
prompt =======================
prompt
create table EMR.DICT_STD
(
  sno          NUMBER not null,
  icd          VARCHAR2(16),
  s_name       VARCHAR2(40),
  cure_rate    NUMBER(5,2),
  avg_day      NUMBER(6,2),
  diag_rate    NUMBER(5,2),
  avg_diag_day NUMBER(5,2),
  avg_fee      NUMBER(8,2),
  name_for_icd VARCHAR2(40)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DICT_SYMBOL
prompt ==========================
prompt
create table EMR.DICT_SYMBOL
(
  symbol  VARCHAR2(20) not null,
  dept_id VARCHAR2(8) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DICT_TEMPLET_REGISTER_ITEM
prompt =========================================
prompt
create table EMR.DICT_TEMPLET_REGISTER_ITEM
(
  d_type    VARCHAR2(4) not null,
  d_name    VARCHAR2(40) not null,
  example   VARCHAR2(40),
  reference VARCHAR2(50)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DISEASECFG
prompt =========================
prompt
create table EMR.DISEASECFG
(
  id        VARCHAR2(4) not null,
  mapid     VARCHAR2(16),
  name      VARCHAR2(64) not null,
  py        VARCHAR2(8),
  wb        VARCHAR2(8),
  diseaseid VARCHAR2(64) default (''),
  surgeryid VARCHAR2(64) default (''),
  category  INTEGER not null,
  mark      VARCHAR2(64),
  parentid  VARCHAR2(4) default (''),
  valid     INTEGER not null,
  memo      VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_DISEASECFG_MAPID on EMR.DISEASECFG (MAPID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.DISEASECFG
  add constraint PK_DISEASECFG primary key (ID, CATEGORY)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DISEASEDIRECTORY
prompt ===============================
prompt
create table EMR.DISEASEDIRECTORY
(
  id     VARCHAR2(12) not null,
  name   VARCHAR2(64) not null,
  py     VARCHAR2(8),
  wb     VARCHAR2(8),
  previd VARCHAR2(12),
  valid  INTEGER not null,
  memo   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.DISEASEDIRECTORY
  add constraint PK_DISEASEDIRECTORY primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table DISEASEFEE
prompt =========================
prompt
create table EMR.DISEASEFEE
(
  id       NUMBER(12) not null,
  sortcode VARCHAR2(4) not null,
  range    INTEGER not null,
  deptid   VARCHAR2(12),
  allcost  NUMBER(10,4),
  days     INTEGER,
  perday   NUMBER(10,4),
  drugrate NUMBER(7,2)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.DISEASEFEE
  add constraint PK_COSTCONTROL primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table DISEASEGROUP
prompt ===========================
prompt
create table EMR.DISEASEGROUP
(
  id           VARCHAR2(6),
  diseasegroup CLOB,
  name         VARCHAR2(32) default ''
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DISEASESGROUP
prompt ============================
prompt
create table EMR.DISEASESGROUP
(
  id          NUMBER(12) not null,
  name        VARCHAR2(32) not null,
  py          VARCHAR2(16),
  wb          VARCHAR2(16),
  diseaseids  VARCHAR2(300),
  deptid      VARCHAR2(12),
  valid       NUMBER(1) not null,
  create_user VARCHAR2(10),
  create_time VARCHAR2(19),
  updateuser  VARCHAR2(10),
  updatetime  VARCHAR2(19),
  memo        VARCHAR2(300),
  memospare   VARCHAR2(300)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.DISEASESGROUP.id
  is '�Զ�������ˮ��';
comment on column EMR.DISEASESGROUP.name
  is '�������';
comment on column EMR.DISEASESGROUP.py
  is 'ƴ��';
comment on column EMR.DISEASESGROUP.wb
  is '���';
comment on column EMR.DISEASESGROUP.diseaseids
  is '����ID����(��$���ŷָ�)';
comment on column EMR.DISEASESGROUP.deptid
  is '���ұ���(�����������ң�Ϊ���Ȩ��Ԥ��)';
comment on column EMR.DISEASESGROUP.valid
  is '�Ƿ���Ч(0-��Ч��1-��Ч)';
comment on column EMR.DISEASESGROUP.create_user
  is '������';
comment on column EMR.DISEASESGROUP.create_time
  is '����ʱ��';
comment on column EMR.DISEASESGROUP.updateuser
  is '������';
comment on column EMR.DISEASESGROUP.updatetime
  is '����ʱ��';
comment on column EMR.DISEASESGROUP.memo
  is '��ע';
comment on column EMR.DISEASESGROUP.memospare
  is '�����ֶ�';
alter table EMR.DISEASESGROUP
  add primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DOCTORCUSTOM
prompt ===========================
prompt
create table EMR.DOCTORCUSTOM
(
  userid   VARCHAR2(16) not null,
  typename VARCHAR2(16) not null,
  icd      VARCHAR2(16) not null,
  icdname  VARCHAR2(80) not null,
  input    VARCHAR2(8),
  deptid   VARCHAR2(8)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.DOCTORCUSTOM.userid
  is 'ҽ���ʺ�';
comment on column EMR.DOCTORCUSTOM.typename
  is '�ֵ����� ����ϡ�����';
comment on column EMR.DOCTORCUSTOM.icd
  is '����';
comment on column EMR.DOCTORCUSTOM.icdname
  is '����';
comment on column EMR.DOCTORCUSTOM.input
  is '������';
comment on column EMR.DOCTORCUSTOM.deptid
  is '���Ҵ��룬Ҫ��ȫ��ͨ�õ����Ͽ��Ҵ��룬����Ϊ��';

prompt
prompt Creating table DOCTOREMRTEMPLET
prompt ===============================
prompt
create table EMR.DOCTOREMRTEMPLET
(
  code             VARCHAR2(36) not null,
  name             VARCHAR2(80),
  emrtemletcontent CLOB,
  mr_class         VARCHAR2(10),
  createuser       VARCHAR2(24) not null,
  createdate       VARCHAR2(36)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.DOCTOREMRTEMPLET.code
  is '����';
comment on column EMR.DOCTOREMRTEMPLET.name
  is 'ģ������';
comment on column EMR.DOCTOREMRTEMPLET.emrtemletcontent
  is 'ģ������';
comment on column EMR.DOCTOREMRTEMPLET.mr_class
  is 'ģ�����';
comment on column EMR.DOCTOREMRTEMPLET.createuser
  is '������';
comment on column EMR.DOCTOREMRTEMPLET.createdate
  is '����ʱ��';
alter table EMR.DOCTOREMRTEMPLET
  add constraint PK_TEMPLETID primary key (CODE, CREATEUSER)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DOCTOR_ASSIGNPATIENT
prompt ===================================
prompt
create table EMR.DOCTOR_ASSIGNPATIENT
(
  id          VARCHAR2(6) not null,
  noofinpat   NUMBER(9) not null,
  valid       INTEGER default '1' not null,
  create_time VARCHAR2(24) default sysdate not null,
  create_user VARCHAR2(6) not null,
  pattye      VARCHAR2(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DOSAGE2USEAGE
prompt ============================
prompt
create table EMR.DOSAGE2USEAGE
(
  dosageid VARCHAR2(12) not null,
  useageid VARCHAR2(255) not null,
  memo     VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.DOSAGE2USEAGE
  add constraint PK_DOSAGE2USEAGE primary key (DOSAGEID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table DOSAGEFORM
prompt =========================
prompt
create table EMR.DOSAGEFORM
(
  id   VARCHAR2(12) not null,
  name VARCHAR2(32) not null,
  py   VARCHAR2(8),
  wb   VARCHAR2(8),
  memo VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.DOSAGEFORM
  add constraint PK_DOSAGEFORM primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DRUGALLERGY
prompt ==========================
prompt
create table EMR.DRUGALLERGY
(
  noofinpat NUMBER(9) not null,
  normno    NUMBER(9) not null,
  tester    VARCHAR2(6) not null,
  testdate  CHAR(19) not null,
  startdate CHAR(10) not null,
  enddate   CHAR(10),
  masculine INTEGER not null,
  valid     INTEGER not null,
  memo      VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.DRUGALLERGY
  add constraint PK_DRUGALLERGY primary key (NOOFINPAT, NORMNO, STARTDATE)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table DRUGCLASSDETAIL
prompt ==============================
prompt
create table EMR.DRUGCLASSDETAIL
(
  detailid VARCHAR2(12) not null,
  name     VARCHAR2(32) not null,
  py       VARCHAR2(8),
  wb       VARCHAR2(8),
  masterid VARCHAR2(12) not null,
  memo     VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_DRUGCLASSDETAIL_PY on EMR.DRUGCLASSDETAIL (PY)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_DRUGCLASSDETAIL_WB on EMR.DRUGCLASSDETAIL (WB)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.DRUGCLASSDETAIL
  add constraint PK_DRUGCLASSDETAIL primary key (DETAILID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DRUGCLASSIFY
prompt ===========================
prompt
create table EMR.DRUGCLASSIFY
(
  id   VARCHAR2(12) not null,
  name VARCHAR2(32) not null,
  py   VARCHAR2(8),
  wb   VARCHAR2(8),
  memo VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.DRUGCLASSIFY
  add constraint PK_DRUGCLASSIFY primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DRUGCORRESPOND
prompt =============================
prompt
create table EMR.DRUGCORRESPOND
(
  code          VARCHAR2(32) not null,
  drugmark      INTEGER not null,
  sortcode      VARCHAR2(12) not null,
  rangecategory VARCHAR2(2) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.DRUGCORRESPOND
  add constraint PK_DRUGPRESCRIPTION primary key (CODE, DRUGMARK, SORTCODE, RANGECATEGORY)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table DRUGDOSELIMIT
prompt ============================
prompt
create table EMR.DRUGDOSELIMIT
(
  limitid      VARCHAR2(12) not null,
  prooftype    VARCHAR2(2) not null,
  placeid      NUMBER(9) not null,
  drugid       VARCHAR2(12) not null,
  clinicalcode VARCHAR2(12),
  drugname     VARCHAR2(64),
  defaultdose  NUMBER(10),
  unitcategory INTEGER not null,
  warndose     NUMBER(10),
  controldose  NUMBER(10),
  defaultno    NUMBER(10) not null,
  warnno       NUMBER(10) not null,
  controlno    NUMBER(10) not null,
  memo         VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.DRUGDOSELIMIT
  add constraint PK_DRUGDOSELIMIT primary key (LIMITID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table DRUGNICKNAME
prompt ===========================
prompt
create table EMR.DRUGNICKNAME
(
  placeid  NUMBER(9) not null,
  nickname VARCHAR2(64) not null,
  nickid   VARCHAR2(12) not null,
  py       VARCHAR2(8),
  wb       VARCHAR2(8),
  memo     VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_DRUGNICKNAME_PY on EMR.DRUGNICKNAME (PY)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_DRUGNICKNAME_WB on EMR.DRUGNICKNAME (WB)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_DRUGNICKNAME_YPDM on EMR.DRUGNICKNAME (NICKID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.DRUGNICKNAME
  add constraint PK_DRUGNICKNAME primary key (PLACEID, NICKNAME)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DRUGORIGIN
prompt =========================
prompt
create table EMR.DRUGORIGIN
(
  id   VARCHAR2(12) not null,
  name VARCHAR2(32) not null,
  py   VARCHAR2(8),
  wb   VARCHAR2(8),
  memo VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.DRUGORIGIN
  add constraint PK_DRUGORIGIN primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DRUGUSEAGE
prompt =========================
prompt
create table EMR.DRUGUSEAGE
(
  id             VARCHAR2(2) not null,
  name           VARCHAR2(16) not null,
  py             VARCHAR2(8),
  wb             VARCHAR2(8),
  groupmark      INTEGER not null,
  autosort       INTEGER not null,
  useagecategory INTEGER not null,
  valid          INTEGER not null,
  memo           VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.DRUGUSEAGE
  add constraint PK_DRUGUSEAGE primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EMRCONVERTPY
prompt ===========================
prompt
create table EMR.EMRCONVERTPY
(
  id        NUMBER,
  py        VARCHAR2(50),
  wordarray CLOB,
  valid     CHAR(5)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EMRDEPT
prompt ======================
prompt
create table EMR.EMRDEPT
(
  dept_id   VARCHAR2(12) not null,
  dept_name VARCHAR2(40),
  py        VARCHAR2(12),
  wb        VARCHAR2(12)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EMRDEPT2HIS
prompt ==========================
prompt
create table EMR.EMRDEPT2HIS
(
  emr_dept_id VARCHAR2(12) not null,
  his_dept_id VARCHAR2(8) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EMRQCITEM
prompt ========================
prompt
create table EMR.EMRQCITEM
(
  code   VARCHAR2(10),
  name   VARCHAR2(40),
  i_code VARCHAR2(10) not null,
  i_name VARCHAR2(40)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EMRREPORTS
prompt =========================
prompt
create table EMR.EMRREPORTS
(
  file_index INTEGER not null,
  filename   VARCHAR2(100) not null,
  templeteid INTEGER not null,
  createtime VARCHAR2(20),
  createuser VARCHAR2(50)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on column EMR.EMRREPORTS.file_index
  is '���';
comment on column EMR.EMRREPORTS.filename
  is '��������';
comment on column EMR.EMRREPORTS.templeteid
  is '����ģ��';
comment on column EMR.EMRREPORTS.createtime
  is '��������';
comment on column EMR.EMRREPORTS.createuser
  is '������';
alter table EMR.EMRREPORTS
  add constraint PK_EMRREPORT_ID primary key (FILE_INDEX)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table EMRTEMPLET
prompt =========================
prompt
create table EMR.EMRTEMPLET
(
  templet_id       VARCHAR2(6) not null,
  file_name        VARCHAR2(40),
  dept_id          VARCHAR2(8),
  creator_id       VARCHAR2(16),
  create_datetime  VARCHAR2(19),
  last_time        VARCHAR2(19),
  permission       VARCHAR2(1),
  mr_class         VARCHAR2(3),
  mr_code          VARCHAR2(12),
  mr_name          VARCHAR2(160),
  mr_attr          VARCHAR2(1),
  qc_code          VARCHAR2(10),
  new_page_flag    NUMBER(1),
  file_flag        NUMBER(1),
  write_times      NUMBER(1),
  code             VARCHAR2(40),
  hospital_code    VARCHAR2(11),
  xml_doc          BLOB,
  xml_doc_new      CLOB,
  py               VARCHAR2(50),
  wb               VARCHAR2(50),
  isfirstdaily     VARCHAR2(1),
  isshowfilename   VARCHAR2(1),
  isyihuangoutong  VARCHAR2(1),
  new_page_end     NUMBER(1) default 0,
  valid            VARCHAR2(1) default '1',
  state            VARCHAR2(1),
  auditor          VARCHAR2(16),
  auditdate        VARCHAR2(19),
  isconfigpagesize VARCHAR2(1)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 7M
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on table EMR.EMRTEMPLET
  is 'ģ������
MR_TEMPLET_INDEX';
comment on column EMR.EMRTEMPLET.templet_id
  is 'ģ��ID';
comment on column EMR.EMRTEMPLET.file_name
  is '�ļ�����';
comment on column EMR.EMRTEMPLET.dept_id
  is '����ID';
comment on column EMR.EMRTEMPLET.creator_id
  is '������ID';
comment on column EMR.EMRTEMPLET.create_datetime
  is '��������';
comment on column EMR.EMRTEMPLET.last_time
  is '����޸�ʱ��';
comment on column EMR.EMRTEMPLET.permission
  is '����Ȩ��';
comment on column EMR.EMRTEMPLET.mr_class
  is '���';
comment on column EMR.EMRTEMPLET.mr_code
  is '����';
comment on column EMR.EMRTEMPLET.mr_name
  is '����';
comment on column EMR.EMRTEMPLET.mr_attr
  is '����';
comment on column EMR.EMRTEMPLET.qc_code
  is '�ʿش���';
comment on column EMR.EMRTEMPLET.new_page_flag
  is '��ҳ���';
comment on column EMR.EMRTEMPLET.file_flag
  is '�ļ����:0-�½���1-����ҽ����ǩ��2-����������ǩ��3-ҽ�����ǩ��ģ����Ч��';
comment on column EMR.EMRTEMPLET.write_times
  is '��д����:0 �����ƴ���������0������д����';
comment on column EMR.EMRTEMPLET.code
  is '����';
comment on column EMR.EMRTEMPLET.hospital_code
  is 'ҽԺ����';
comment on column EMR.EMRTEMPLET.xml_doc
  is 'ģ���ļ�';
comment on column EMR.EMRTEMPLET.xml_doc_new
  is 'ģ���ļ�';
comment on column EMR.EMRTEMPLET.py
  is 'ƴ��';
comment on column EMR.EMRTEMPLET.wb
  is '���';
comment on column EMR.EMRTEMPLET.isfirstdaily
  is '�״β��̷�    0:�� 1:��';
comment on column EMR.EMRTEMPLET.isshowfilename
  is 'FileName�Ƿ���ʾ    0:�� 1:��';
comment on column EMR.EMRTEMPLET.isyihuangoutong
  is '�Ƿ�ҽ����ͨ 0:�� 1:��';
comment on column EMR.EMRTEMPLET.new_page_end
  is '�Ƿ���ҳ����';
comment on column EMR.EMRTEMPLET.state
  is '״̬  �Ƿ���ˣ�0������δ�ύ   1���ύ  2�����ͨ��  3�����δͨ��';
comment on column EMR.EMRTEMPLET.auditor
  is '�����';
comment on column EMR.EMRTEMPLET.auditdate
  is '���ʱ��';
alter table EMR.EMRTEMPLET
  add constraint PK_MR_TEMPLET_INDEX1 primary key (TEMPLET_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EMRTEMPLETHEADER
prompt ===============================
prompt
create table EMR.EMRTEMPLETHEADER
(
  header_id       VARCHAR2(6) not null,
  creator_id      VARCHAR2(16),
  create_datetime VARCHAR2(19),
  last_time       VARCHAR2(19),
  hospital_code   VARCHAR2(11),
  content         CLOB,
  name            VARCHAR2(40)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.EMRTEMPLETHEADER.header_id
  is 'ҳüID';
comment on column EMR.EMRTEMPLETHEADER.creator_id
  is '������ID';
comment on column EMR.EMRTEMPLETHEADER.create_datetime
  is '����ʱ��';
comment on column EMR.EMRTEMPLETHEADER.last_time
  is '����޸�ʱ��';
comment on column EMR.EMRTEMPLETHEADER.hospital_code
  is 'ʹ��ҽԺ���';
comment on column EMR.EMRTEMPLETHEADER.content
  is 'ҳü����';
comment on column EMR.EMRTEMPLETHEADER.name
  is 'ҳü����';

prompt
prompt Creating table EMRTEMPLET_FOOT
prompt ==============================
prompt
create table EMR.EMRTEMPLET_FOOT
(
  foot_id         VARCHAR2(6) not null,
  creator_id      VARCHAR2(16),
  create_datetime VARCHAR2(19),
  last_time       VARCHAR2(19),
  hospital_code   VARCHAR2(11),
  content         CLOB,
  name            VARCHAR2(40)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EMRTEMPLET_ITEM
prompt ==============================
prompt
create table EMR.EMRTEMPLET_ITEM
(
  mr_class         VARCHAR2(2),
  mr_code          VARCHAR2(12) not null,
  mr_name          VARCHAR2(80),
  mr_attr          VARCHAR2(1),
  qc_code          VARCHAR2(10),
  dept_id          VARCHAR2(8),
  creator_id       VARCHAR2(16),
  create_date_time VARCHAR2(19),
  last_time        VARCHAR2(19),
  content_code     VARCHAR2(10),
  permission       NUMBER(1),
  visibled         NUMBER(1),
  input            VARCHAR2(10),
  hospital_code    VARCHAR2(11) not null,
  item_doc         BLOB,
  item_doc_new     CLOB
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EMRTEMPLET_ITEM_PERSON
prompt =====================================
prompt
create table EMR.EMRTEMPLET_ITEM_PERSON
(
  code         VARCHAR2(36) not null,
  name         VARCHAR2(80),
  item_content CLOB,
  deptshare    INTEGER,
  parentid     VARCHAR2(36),
  container    VARCHAR2(10),
  deptid       VARCHAR2(16),
  isperson     VARCHAR2(1) default 0,
  createusers  VARCHAR2(24)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 10M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.EMRTEMPLET_ITEM_PERSON.code
  is '����';
comment on column EMR.EMRTEMPLET_ITEM_PERSON.name
  is 'ģ������';
comment on column EMR.EMRTEMPLET_ITEM_PERSON.item_content
  is 'ģ������';
comment on column EMR.EMRTEMPLET_ITEM_PERSON.deptshare
  is '���ҹ���';
comment on column EMR.EMRTEMPLET_ITEM_PERSON.parentid
  is '���׽ڵ�';
comment on column EMR.EMRTEMPLET_ITEM_PERSON.container
  is '��Ӧ�ļ���';
comment on column EMR.EMRTEMPLET_ITEM_PERSON.deptid
  is '����ģ��';
comment on column EMR.EMRTEMPLET_ITEM_PERSON.isperson
  is '�Ƿ�Ϊ����ģ��  1����   0����';
comment on column EMR.EMRTEMPLET_ITEM_PERSON.createusers
  is '������';

prompt
prompt Creating table EMRTEMPLET_ITEM_PERSON_CATALOG
prompt =============================================
prompt
create table EMR.EMRTEMPLET_ITEM_PERSON_CATALOG
(
  id          VARCHAR2(36) not null,
  name        VARCHAR2(64) not null,
  py          VARCHAR2(8),
  wb          VARCHAR2(8),
  previd      VARCHAR2(36) default (''),
  valid       INTEGER not null,
  memo        VARCHAR2(255),
  deptid      VARCHAR2(16),
  container   VARCHAR2(10),
  isperson    VARCHAR2(1) default 0,
  createusers VARCHAR2(24)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 448K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.EMRTEMPLET_ITEM_PERSON_CATALOG.isperson
  is '�Ƿ�Ϊ����ģ��  1����   0����';
comment on column EMR.EMRTEMPLET_ITEM_PERSON_CATALOG.createusers
  is '������';
create index EMR.INDEX_USERID on EMR.EMRTEMPLET_ITEM_PERSON_CATALOG (DEPTID)
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.EMRTEMPLET_ITEM_PERSON_CATALOG
  add constraint PK__ITEM_PERSON_CATALOG primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 320K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EMR_AUTOMARK_RECORD
prompt ==================================
prompt
create table EMR.EMR_AUTOMARK_RECORD
(
  id             NVARCHAR2(20) not null,
  create_time    DATE not null,
  name           NVARCHAR2(100),
  create_user    NVARCHAR2(20),
  recorddetailid NVARCHAR2(20),
  noofinpat      NVARCHAR2(20) not null,
  note           NVARCHAR2(500),
  isauto         NVARCHAR2(1),
  score          NVARCHAR2(4),
  isvalid        NVARCHAR2(1),
  isused         NVARCHAR2(1),
  checkstate     VARCHAR2(2),
  qctype         VARCHAR2(2)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 448K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.EMR_AUTOMARK_RECORD.id
  is '���';
comment on column EMR.EMR_AUTOMARK_RECORD.create_time
  is '����ʱ��';
comment on column EMR.EMR_AUTOMARK_RECORD.name
  is '����';
comment on column EMR.EMR_AUTOMARK_RECORD.create_user
  is '������';
comment on column EMR.EMR_AUTOMARK_RECORD.recorddetailid
  is '���ֶ�Ӧ������ҳ���';
comment on column EMR.EMR_AUTOMARK_RECORD.noofinpat
  is '��Ӧ���˲�����ҳ���';
comment on column EMR.EMR_AUTOMARK_RECORD.note
  is '��ע';
comment on column EMR.EMR_AUTOMARK_RECORD.isauto
  is '�Ƿ��Զ�����';
comment on column EMR.EMR_AUTOMARK_RECORD.score
  is '�÷�';
comment on column EMR.EMR_AUTOMARK_RECORD.isvalid
  is '��ɾ��';
comment on column EMR.EMR_AUTOMARK_RECORD.isused
  is '�Ƿ�������';

prompt
prompt Creating table EMR_AUTOMARK_RECORD_DETAIL
prompt =========================================
prompt
create table EMR.EMR_AUTOMARK_RECORD_DETAIL
(
  id                  NUMBER(12) not null,
  configreductionid   NUMBER(12),
  point               NVARCHAR2(4),
  automarkrecordid    NVARCHAR2(20),
  noofinpat           NVARCHAR2(20),
  pname               NVARCHAR2(20),
  configreductionname NVARCHAR2(500),
  errordoctor         VARCHAR2(20)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 512K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.EMR_AUTOMARK_RECORD_DETAIL.id
  is 'ID����';
comment on column EMR.EMR_AUTOMARK_RECORD_DETAIL.configreductionid
  is '�۷���ĿID';
comment on column EMR.EMR_AUTOMARK_RECORD_DETAIL.point
  is '�۷�';
comment on column EMR.EMR_AUTOMARK_RECORD_DETAIL.automarkrecordid
  is '�����¼ID';
comment on column EMR.EMR_AUTOMARK_RECORD_DETAIL.noofinpat
  is '������ҳ���';
comment on column EMR.EMR_AUTOMARK_RECORD_DETAIL.pname
  is '��������';
comment on column EMR.EMR_AUTOMARK_RECORD_DETAIL.configreductionname
  is '�۷���Ŀ';

prompt
prompt Creating table EMR_CONFIGCHECKPOINTUSER
prompt =======================================
prompt
create table EMR.EMR_CONFIGCHECKPOINTUSER
(
  id            NUMBER(12) not null,
  deptid        VARCHAR2(12) not null,
  qcmanagerid   VARCHAR2(12) not null,
  chiefdoctorid VARCHAR2(64) not null,
  valid         VARCHAR2(2) not null
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table EMR_CONFIGPOINT
prompt ==============================
prompt
create table EMR.EMR_CONFIGPOINT
(
  id        NUMBER(12) not null,
  ccode     VARCHAR2(100) not null,
  childname VARCHAR2(64) not null,
  valid     VARCHAR2(2) not null,
  childcode VARCHAR2(40)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.EMR_CONFIGPOINT
  add constraint PK_EMR_CONFIGPOINT primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EMR_CONFIGREDUCTION
prompt ==================================
prompt
create table EMR.EMR_CONFIGREDUCTION
(
  id           NUMBER(12) not null,
  reducepoint  NUMBER,
  problem_desc VARCHAR2(500),
  create_user  VARCHAR2(8),
  create_time  DATE,
  valid        VARCHAR2(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.EMR_CONFIGREDUCTION
  add constraint PK_EMR_CONFIGREDUCTION primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table EMR_CONFIGREDUCTION2
prompt ===================================
prompt
create table EMR.EMR_CONFIGREDUCTION2
(
  id              NUMBER(12) not null,
  reducepoint     NUMBER,
  problem_desc    VARCHAR2(500),
  create_user     VARCHAR2(8),
  create_time     DATE,
  valid           VARCHAR2(1),
  parents         VARCHAR2(8),
  children        VARCHAR2(16),
  isauto          VARCHAR2(1),
  selectcondition VARCHAR2(100),
  selecttable     VARCHAR2(50),
  classid         VARCHAR2(12)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.EMR_CONFIGREDUCTION2.id
  is '���';
comment on column EMR.EMR_CONFIGREDUCTION2.reducepoint
  is '�۷ֱ�׼';
comment on column EMR.EMR_CONFIGREDUCTION2.problem_desc
  is '�۷�����';
comment on column EMR.EMR_CONFIGREDUCTION2.create_user
  is '������';
comment on column EMR.EMR_CONFIGREDUCTION2.create_time
  is '����ʱ��';
comment on column EMR.EMR_CONFIGREDUCTION2.valid
  is '�Ƿ���Ч';
comment on column EMR.EMR_CONFIGREDUCTION2.parents
  is '������Ŀ���';
comment on column EMR.EMR_CONFIGREDUCTION2.children
  is '������Ŀ';
alter table EMR.EMR_CONFIGREDUCTION2
  add constraint PK_EMR_CONFIGREDUCTION2 primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EMR_DATA_VERSION
prompt ===============================
prompt
create table EMR.EMR_DATA_VERSION
(
  versionid          VARCHAR2(50) not null,
  versiondescription VARCHAR2(4000),
  createdatetime     DATE
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EMR_DICTIONARY
prompt =============================
prompt
create table EMR.EMR_DICTIONARY
(
  id     NUMBER not null,
  name   VARCHAR2(20) not null,
  type   VARCHAR2(1) not null,
  cancel VARCHAR2(1) not null,
  py     VARCHAR2(20),
  wb     VARCHAR2(20)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EMR_DICTIONARY_DETAIL
prompt ====================================
prompt
create table EMR.EMR_DICTIONARY_DETAIL
(
  dictionary_id NUMBER not null,
  name          VARCHAR2(100) not null,
  cancel        VARCHAR2(1) not null,
  py            VARCHAR2(100),
  wb            VARCHAR2(100),
  id            NUMBER,
  code          VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 896K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EMR_ITEM
prompt =======================
prompt
create table EMR.EMR_ITEM
(
  mr_class VARCHAR2(2),
  mr_code  VARCHAR2(12) not null,
  mr_name  VARCHAR2(80),
  dept_id  VARCHAR2(8),
  visibled NUMBER(1)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table EMR_ITEM_INDEX
prompt =============================
prompt
create table EMR.EMR_ITEM_INDEX
(
  mr_class         VARCHAR2(2),
  mr_code          VARCHAR2(12) not null,
  mr_name          VARCHAR2(80),
  mr_attr          VARCHAR2(1),
  file_name        VARCHAR2(40),
  path             VARCHAR2(40),
  qc_code          VARCHAR2(10),
  dept_id          VARCHAR2(8),
  creator_id       VARCHAR2(16),
  create_date_time DATE,
  last_time        DATE,
  content_code     VARCHAR2(10),
  permission       NUMBER(1),
  visibled         NUMBER(1),
  input            VARCHAR2(10),
  hospital_code    VARCHAR2(11) not null,
  item_doc         BLOB
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 384K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EMR_MEDICINE_NODE
prompt ================================
prompt
create table EMR.EMR_MEDICINE_NODE
(
  id              INTEGER,
  source_emrname  VARCHAR2(20),
  source_itemname VARCHAR2(20),
  valid           VARCHAR2(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.EMR_MEDICINE_NODE
  is '���ôӲ�������ȡ�����ڵ���Ϣ����';
comment on column EMR.EMR_MEDICINE_NODE.id
  is '���';
comment on column EMR.EMR_MEDICINE_NODE.source_emrname
  is 'Դ����';
comment on column EMR.EMR_MEDICINE_NODE.source_itemname
  is '�����ڵ�����Ŀ';
comment on column EMR.EMR_MEDICINE_NODE.valid
  is '�Ƿ���Ч   0����Ч   1����Ч';

prompt
prompt Creating table EMR_PAT_DIAG
prompt ===========================
prompt
create table EMR.EMR_PAT_DIAG
(
  patient_id       VARCHAR2(16) not null,
  nad              NUMBER(2) not null,
  diag_type        VARCHAR2(1) not null,
  diag_type_name   VARCHAR2(20) not null,
  diag_no          NUMBER(2) not null,
  diag_sub_no      NUMBER(2) not null,
  diag_class       VARCHAR2(2),
  diag_code        VARCHAR2(16),
  diag_content     VARCHAR2(80),
  diag_date        DATE,
  diag_doctor_id   VARCHAR2(16),
  modify_doctor_id VARCHAR2(16),
  last_time        DATE,
  parent_id        NUMBER(2),
  super_id         VARCHAR2(16),
  super_sign_date  DATE,
  flag             VARCHAR2(1),
  houseman         VARCHAR2(8),
  confirmed_flag   NUMBER(1),
  id               NUMBER(2),
  uncertain_diag   NUMBER(1),
  back_diag        NUMBER(1),
  remark           VARCHAR2(20),
  diag_doctor_name VARCHAR2(20)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 3M
  );
comment on table EMR.EMR_PAT_DIAG
  is '�����Ϣ
pat_diagnosis';
comment on column EMR.EMR_PAT_DIAG.patient_id
  is '���˺�';
comment on column EMR.EMR_PAT_DIAG.nad
  is 'סԺ��';
comment on column EMR.EMR_PAT_DIAG.diag_type
  is '�������';
comment on column EMR.EMR_PAT_DIAG.diag_type_name
  is '����������';
comment on column EMR.EMR_PAT_DIAG.diag_no
  is '��ϱ��';
comment on column EMR.EMR_PAT_DIAG.diag_sub_no
  is '����ϱ��';
comment on column EMR.EMR_PAT_DIAG.diag_class
  is '������';
comment on column EMR.EMR_PAT_DIAG.diag_code
  is '��ϴ���';
comment on column EMR.EMR_PAT_DIAG.diag_content
  is '�������';
comment on column EMR.EMR_PAT_DIAG.diag_date
  is '�������';
comment on column EMR.EMR_PAT_DIAG.diag_doctor_id
  is '�����ҽʦID';
comment on column EMR.EMR_PAT_DIAG.modify_doctor_id
  is '����ҽʦID';
comment on column EMR.EMR_PAT_DIAG.last_time
  is '������ʱ��';
comment on column EMR.EMR_PAT_DIAG.parent_id
  is '�ϼ�ҽ��ID';
comment on column EMR.EMR_PAT_DIAG.super_id
  is '����ҽʦID';
comment on column EMR.EMR_PAT_DIAG.super_sign_date
  is '������ǩ����';
comment on column EMR.EMR_PAT_DIAG.flag
  is '���';
comment on column EMR.EMR_PAT_DIAG.houseman
  is 'ʵϰҽ��';
comment on column EMR.EMR_PAT_DIAG.confirmed_flag
  is 'ȷ����:1 ȷ����� 0 �������';
comment on column EMR.EMR_PAT_DIAG.id
  is '���';
comment on column EMR.EMR_PAT_DIAG.uncertain_diag
  is '1Ϊ�������';
comment on column EMR.EMR_PAT_DIAG.back_diag
  is '1��ʾ��ע׷�ӵ����֮�󣬷���׷�ӵ�ǰ';
comment on column EMR.EMR_PAT_DIAG.remark
  is '��ע����';
comment on column EMR.EMR_PAT_DIAG.diag_doctor_name
  is '�����ҽʦID';

prompt
prompt Creating table EMR_POINT
prompt ========================
prompt
create table EMR.EMR_POINT
(
  id                 NUMBER(10),
  noofinpat          NUMBER,
  recorddetailid     NUMBER,
  doctorid           VARCHAR2(8),
  create_user        VARCHAR2(8),
  create_time        DATE,
  problem_desc       VARCHAR2(500),
  reducepoint        NUMBER,
  grade              VARCHAR2(5),
  num                NUMBER,
  valid              VARCHAR2(1),
  cancel_user        VARCHAR2(8),
  cancel_time        DATE,
  doctorname         VARCHAR2(10),
  createusername     VARCHAR2(10),
  cancelusername     VARCHAR2(10),
  recorddetailname   VARCHAR2(100),
  sortid             VARCHAR2(12),
  emr_mark_record_id NVARCHAR2(20),
  emrpointid         VARCHAR2(50),
  emrpointchildid    VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.EMR_POINT
  is '�������ֱ�';
comment on column EMR.EMR_POINT.id
  is 'ID';
comment on column EMR.EMR_POINT.noofinpat
  is '��ҳ���';
comment on column EMR.EMR_POINT.recorddetailid
  is '��Ӧ������ID';
comment on column EMR.EMR_POINT.doctorid
  is '����ҽʦ';
comment on column EMR.EMR_POINT.create_user
  is '�Ǽ���';
comment on column EMR.EMR_POINT.create_time
  is '�Ǽ�ʱ��';
comment on column EMR.EMR_POINT.problem_desc
  is '��������';
comment on column EMR.EMR_POINT.reducepoint
  is '�۷�';
comment on column EMR.EMR_POINT.grade
  is '�ȼ�';
comment on column EMR.EMR_POINT.num
  is '����';
comment on column EMR.EMR_POINT.valid
  is '1:��Ч 0:��Ч';
comment on column EMR.EMR_POINT.cancel_user
  is '������';
comment on column EMR.EMR_POINT.cancel_time
  is '����ʱ��';
comment on column EMR.EMR_POINT.doctorname
  is '����ҽʦ����';
comment on column EMR.EMR_POINT.createusername
  is '�Ǽ�������';
comment on column EMR.EMR_POINT.cancelusername
  is '����������';
comment on column EMR.EMR_POINT.recorddetailname
  is '��Ӧ�Ĳ�������';

prompt
prompt Creating table EMR_RECORDBORROW
prompt ===============================
prompt
create table EMR.EMR_RECORDBORROW
(
  id             VARCHAR2(50) default SYS_GUID() not null,
  noofinpat      VARCHAR2(50),
  applydate      DATE default SysDate,
  applydocid     VARCHAR2(50),
  applycontent   VARCHAR2(4000),
  applytimes     INTEGER default 0,
  approvedocid   VARCHAR2(50),
  approvedate    DATE,
  approvecontent VARCHAR2(4000),
  status         INTEGER default 0,
  yanqiflag      VARCHAR2(50),
  applytabeid    VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.EMR_RECORDBORROW.id
  is 'Id,Id';
comment on column EMR.EMR_RECORDBORROW.noofinpat
  is '��������';
comment on column EMR.EMR_RECORDBORROW.applydate
  is '����ʱ��';
comment on column EMR.EMR_RECORDBORROW.applydocid
  is '����ҽ��Id';
comment on column EMR.EMR_RECORDBORROW.applycontent
  is '��������';
comment on column EMR.EMR_RECORDBORROW.applytimes
  is '��������';
comment on column EMR.EMR_RECORDBORROW.approvedocid
  is '�����';
comment on column EMR.EMR_RECORDBORROW.approvedate
  is '���ʱ��';
comment on column EMR.EMR_RECORDBORROW.approvecontent
  is '��˲�ͨ������';
comment on column EMR.EMR_RECORDBORROW.status
  is '״̬';
comment on column EMR.EMR_RECORDBORROW.yanqiflag
  is '���ڱ�ʶ';
comment on column EMR.EMR_RECORDBORROW.applytabeid
  is '��������ID';
alter table EMR.EMR_RECORDBORROW
  add constraint PK_EMR_RECORDBORROW primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EMR_RECORDWRITEUP
prompt ================================
prompt
create table EMR.EMR_RECORDWRITEUP
(
  id             VARCHAR2(50) default SYS_GUID() not null,
  noofinpat      VARCHAR2(50),
  applydate      DATE default SysDate,
  applydocid     VARCHAR2(50),
  applycontent   VARCHAR2(4000),
  applytimes     INTEGER default 0,
  approvedocid   VARCHAR2(50),
  approvedate    DATE,
  approvecontent VARCHAR2(4000),
  status         INTEGER default 0,
  yanqiflag      VARCHAR2(50),
  applytabeid    VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.EMR_RECORDWRITEUP.id
  is 'Id,Id';
comment on column EMR.EMR_RECORDWRITEUP.noofinpat
  is '��������';
comment on column EMR.EMR_RECORDWRITEUP.applydate
  is '����ʱ��';
comment on column EMR.EMR_RECORDWRITEUP.applydocid
  is '����ҽ��Id';
comment on column EMR.EMR_RECORDWRITEUP.applycontent
  is '��������';
comment on column EMR.EMR_RECORDWRITEUP.applytimes
  is '��������';
comment on column EMR.EMR_RECORDWRITEUP.approvedocid
  is '�����';
comment on column EMR.EMR_RECORDWRITEUP.approvedate
  is '���ʱ��';
comment on column EMR.EMR_RECORDWRITEUP.approvecontent
  is '��˲�ͨ������';
comment on column EMR.EMR_RECORDWRITEUP.status
  is '״̬';
comment on column EMR.EMR_RECORDWRITEUP.yanqiflag
  is '���ڱ�ʶ';
comment on column EMR.EMR_RECORDWRITEUP.applytabeid
  is '��������ID';

prompt
prompt Creating table EMR_REPLACE_ITEM
prompt ===============================
prompt
create table EMR.EMR_REPLACE_ITEM
(
  id              INTEGER,
  dest_emrname    VARCHAR2(20),
  source_emrname  VARCHAR2(20),
  dest_itemname   VARCHAR2(50),
  source_itemname VARCHAR2(50),
  valid           VARCHAR2(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.EMR_REPLACE_ITEM.id
  is 'Ψһ���';
comment on column EMR.EMR_REPLACE_ITEM.dest_emrname
  is 'Ŀ�겡��';
comment on column EMR.EMR_REPLACE_ITEM.source_emrname
  is 'Դ����';
comment on column EMR.EMR_REPLACE_ITEM.dest_itemname
  is 'Ŀ�겡������Ҫ�滻����Ŀ';
comment on column EMR.EMR_REPLACE_ITEM.source_itemname
  is '��ӦԴ�����е���Ŀ';
comment on column EMR.EMR_REPLACE_ITEM.valid
  is '0����Ч 1����Ч';

prompt
prompt Creating table EMR_RHCONFIGREDUCTION
prompt ====================================
prompt
create table EMR.EMR_RHCONFIGREDUCTION
(
  id           NUMBER(12) not null,
  reducepoint  NUMBER,
  problem_desc VARCHAR2(500),
  create_user  VARCHAR2(8),
  create_time  DATE,
  valid        VARCHAR2(1),
  user_type    VARCHAR2(10)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table EMR_RHPOINT
prompt ==========================
prompt
create table EMR.EMR_RHPOINT
(
  id               VARCHAR2(50) not null,
  noofinpat        VARCHAR2(10),
  recorddetailid   NVARCHAR2(10),
  doctorid         VARCHAR2(8),
  create_user      VARCHAR2(8),
  create_time      VARCHAR2(19),
  problem_desc     VARCHAR2(500),
  reducepoint      NUMBER,
  grade            VARCHAR2(5),
  num              NUMBER,
  valid            VARCHAR2(1),
  cancel_user      VARCHAR2(8),
  cancel_time      VARCHAR2(19),
  doctorname       VARCHAR2(10),
  createusername   VARCHAR2(10),
  cancelusername   VARCHAR2(10),
  recorddetailname VARCHAR2(100),
  emrpointid       NVARCHAR2(10),
  sortid           VARCHAR2(12),
  rhqc_table_id    VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table EMR_RHQC_TABLE
prompt =============================
prompt
create table EMR.EMR_RHQC_TABLE
(
  id             VARCHAR2(50) not null,
  noofinpat      VARCHAR2(10),
  create_user    VARCHAR2(8),
  create_time    VARCHAR2(19),
  createusername VARCHAR2(10),
  valid          VARCHAR2(1),
  stateid        VARCHAR2(8),
  doctorstate    NVARCHAR2(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table EMR_TEMPLET_INDEX
prompt ================================
prompt
create table EMR.EMR_TEMPLET_INDEX
(
  templet_id             VARCHAR2(6) not null,
  file_name              VARCHAR2(40),
  path                   VARCHAR2(40),
  topic                  VARCHAR2(40),
  dept_id                VARCHAR2(8),
  creator_id             VARCHAR2(16),
  create_datetime        DATE,
  last_time              DATE,
  permission             VARCHAR2(1),
  mr_class               VARCHAR2(2),
  mr_code                VARCHAR2(12),
  mr_name                VARCHAR2(80),
  mr_attr                VARCHAR2(1),
  qc_code                VARCHAR2(10),
  content_code           VARCHAR2(10),
  visibled               NUMBER(1),
  new_page_flag          NUMBER(1),
  sno                    NUMBER(3),
  change_topic_flag      NUMBER(1),
  parent_id              VARCHAR2(16),
  parent_modify_datetime DATE,
  supper_id              VARCHAR2(16),
  supeer_modify_datetime DATE,
  file_flag              NUMBER(1),
  write_times            NUMBER(1),
  parent_sign_flag       NUMBER(1),
  code_system            VARCHAR2(10),
  code                   VARCHAR2(40),
  apply_level            NUMBER(1),
  apply_time_limit       DATE,
  hospital_code          VARCHAR2(11) not null,
  xml_doc                BLOB
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 704K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EMR_ZHENLIAOFANGAN
prompt =================================
prompt
create table EMR.EMR_ZHENLIAOFANGAN
(
  unitmid         VARCHAR2(20),
  jibingmingcheng VARCHAR2(100),
  content         BLOB,
  id              VARCHAR2(20)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EMR_ZHENLIAOFANGANUNIT
prompt =====================================
prompt
create table EMR.EMR_ZHENLIAOFANGANUNIT
(
  unitmname VARCHAR2(100),
  unitclass VARCHAR2(20),
  unitmid   VARCHAR2(20)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table FAMILYHISTORY
prompt ============================
prompt
create table EMR.FAMILYHISTORY
(
  id        NUMBER(9) not null,
  noofinpat NUMBER(9) not null,
  relation  VARCHAR2(4) not null,
  birthday  VARCHAR2(10) not null,
  diseaseid VARCHAR2(32) not null,
  breathing INTEGER not null,
  cause     VARCHAR2(255),
  memo      VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_FAMILYHISTORYPATNOOFHIS on EMR.FAMILYHISTORY (NOOFINPAT)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.FAMILYHISTORY
  add constraint PK_FAMILYHISTORYID primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table FORMATOFDRUG
prompt ===========================
prompt
create table EMR.FORMATOFDRUG
(
  id           NUMBER(9) not null,
  clinicalid   NUMBER(9) not null,
  name         VARCHAR2(64) not null,
  drugid       VARCHAR2(12),
  py           VARCHAR2(8),
  wb           VARCHAR2(8),
  format       VARCHAR2(64) not null,
  dosageid     VARCHAR2(12),
  classdetail  VARCHAR2(12) not null,
  minunit      VARCHAR2(12) not null,
  formatunit   VARCHAR2(12) not null,
  ratio        NUMBER(12,4) not null,
  drugcategroy INTEGER not null,
  usernotes    LONG,
  storagenotes VARCHAR2(4000),
  pharmacology VARCHAR2(16),
  valid        INTEGER not null,
  memo         VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 704K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_FORMATOFDRUG_LCXH on EMR.FORMATOFDRUG (CLINICALID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 256K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_FORMATOFDRUG_PY on EMR.FORMATOFDRUG (PY)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 256K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_FORMATOFDRUG_WB on EMR.FORMATOFDRUG (WB)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.FORMATOFDRUG
  add constraint PK_FORMATOFDRUG primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table HOSPITALINFO
prompt ===========================
prompt
create table EMR.HOSPITALINFO
(
  id                 VARCHAR2(12) not null,
  name               VARCHAR2(64) not null,
  subname            VARCHAR2(64),
  sn                 VARCHAR2(12),
  medicalid          VARCHAR2(12),
  address            VARCHAR2(200),
  yzbm               VARCHAR2(12),
  tel                VARCHAR2(16),
  bzcws              INTEGER,
  memo               VARCHAR2(64),
  hospunitorgcode    VARCHAR2(36),
  hospunitorgnm      VARCHAR2(50),
  aearcode           VARCHAR2(10),
  relatlegalagttnm   VARCHAR2(50),
  contactpersonphone VARCHAR2(20),
  fax                VARCHAR2(20),
  pareorgcode        VARCHAR2(36),
  pareorgnm          VARCHAR2(50),
  orgtype            VARCHAR2(50),
  postcode           VARCHAR2(20),
  registerdt         DATE
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.HOSPITALINFO.address
  is '��ַ';
comment on column EMR.HOSPITALINFO.hospunitorgcode
  is '��֯��������';
comment on column EMR.HOSPITALINFO.hospunitorgnm
  is '��������';
comment on column EMR.HOSPITALINFO.aearcode
  is '������������ ȡֵ���л����񹲺͹������������� GBT22602007';
comment on column EMR.HOSPITALINFO.relatlegalagttnm
  is '��ϵ������';
comment on column EMR.HOSPITALINFO.contactpersonphone
  is '��ϵ�绰-����';
comment on column EMR.HOSPITALINFO.fax
  is '����';
comment on column EMR.HOSPITALINFO.pareorgcode
  is '�ϼ���������';
comment on column EMR.HOSPITALINFO.pareorgnm
  is '�ϼ���������';
comment on column EMR.HOSPITALINFO.orgtype
  is '��������';
comment on column EMR.HOSPITALINFO.postcode
  is '��������';
comment on column EMR.HOSPITALINFO.registerdt
  is 'ע��ʱ��';
alter table EMR.HOSPITALINFO
  add constraint PK_HOSPITALINFO primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table HQMS_FIELDCHECK
prompt ==============================
prompt
create table EMR.HQMS_FIELDCHECK
(
  id                VARCHAR2(50) not null,
  tranfieldedname   VARCHAR2(1000) not null,
  conditionsfielded VARCHAR2(1000),
  conditionsvalue   VARCHAR2(1000),
  valuerange        VARCHAR2(2000) not null
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 448K
    next 1M
    minextents 1
    maxextents unlimited
  );
create unique index EMR.HQMS_FIELDCHECK_KEY on EMR.HQMS_FIELDCHECK (ID)
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table HQMS_GB2260_2007
prompt ===============================
prompt
create table EMR.HQMS_GB2260_2007
(
  code        VARCHAR2(6),
  name        VARCHAR2(50),
  latiandlong VARCHAR2(100)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.HQMS_GB2260_2007.code
  is '--GB����
';
comment on column EMR.HQMS_GB2260_2007.name
  is '--GB����';
comment on column EMR.HQMS_GB2260_2007.latiandlong
  is '--�������ľ�γ��';

prompt
prompt Creating table HQMS_GETEDLOG
prompt ============================
prompt
create table EMR.HQMS_GETEDLOG
(
  patnoofhis  VARCHAR2(20) not null,
  outwarddate VARCHAR2(19) not null,
  geteddate   DATE not null,
  zipname     VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.HQMS_GETEDLOG.patnoofhis
  is '������';
comment on column EMR.HQMS_GETEDLOG.outwarddate
  is '��Ժ����';
comment on column EMR.HQMS_GETEDLOG.geteddate
  is 'ץȡʱ��';
comment on column EMR.HQMS_GETEDLOG.zipname
  is '���ɰ���';

prompt
prompt Creating table HQMS_RCMAPPING
prompt =============================
prompt
create table EMR.HQMS_RCMAPPING
(
  id            VARCHAR2(50) not null,
  rctablename   VARCHAR2(100) not null,
  rcvalue       VARCHAR2(10) not null,
  rcdescription VARCHAR2(100),
  sysrealvalue  VARCHAR2(10) not null,
  rcremark      VARCHAR2(100)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.HQMS_RCMAPPING.id
  is 'GUID�� ����';
comment on column EMR.HQMS_RCMAPPING.rctablename
  is 'HQMS�ṩRC����';
comment on column EMR.HQMS_RCMAPPING.rcvalue
  is 'HQMS�ṩRC�������ֵ';
comment on column EMR.HQMS_RCMAPPING.rcdescription
  is 'HQMS�ṩRC������غ���';
comment on column EMR.HQMS_RCMAPPING.sysrealvalue
  is 'ϵͳ��ǰֵ';
comment on column EMR.HQMS_RCMAPPING.rcremark
  is '˵��';
alter table EMR.HQMS_RCMAPPING
  add constraint HQMS_RCMAPPING_KEY primary key (RCTABLENAME, RCVALUE, SYSREALVALUE)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table HQMS_SQLFROMANDWHERE
prompt ===================================
prompt
create table EMR.HQMS_SQLFROMANDWHERE
(
  id          VARCHAR2(50) not null,
  selectfrom  VARCHAR2(2000) not null,
  selectwhere VARCHAR2(2000) not null
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on column EMR.HQMS_SQLFROMANDWHERE.id
  is 'GUID ����';
comment on column EMR.HQMS_SQLFROMANDWHERE.selectfrom
  is '��̬����ץȡ����FROM����';
comment on column EMR.HQMS_SQLFROMANDWHERE.selectwhere
  is '��̬����ץȡ����WHERE����';
alter table EMR.HQMS_SQLFROMANDWHERE
  add constraint HQMS_SQLFROMANDWHERE_KEY primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table HQMS_TRANFIELD
prompt =============================
prompt
create table EMR.HQMS_TRANFIELD
(
  id               VARCHAR2(50) not null,
  tranfieldname    VARCHAR2(100) not null,
  tranchfieldname  VARCHAR2(500),
  srctable         VARCHAR2(2000) not null,
  srcfieldname     VARCHAR2(50) not null,
  isselectgettable INTEGER,
  rctablename      VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.HQMS_TRANFIELD.id
  is 'GUID�� ����';
comment on column EMR.HQMS_TRANFIELD.tranfieldname
  is 'HQMS���ϴ�������';
comment on column EMR.HQMS_TRANFIELD.tranchfieldname
  is 'HQMS�Ϲ涨���ı���';
comment on column EMR.HQMS_TRANFIELD.srctable
  is 'ϵͳ������Դ����(������Ƕselect������ɵı�)';
comment on column EMR.HQMS_TRANFIELD.srcfieldname
  is 'ϵͳ������Դ����(������Ƕselect������ɵı���ȡ�еı���)';
comment on column EMR.HQMS_TRANFIELD.isselectgettable
  is '0-��ͨ��1-��ͨ����ǶSELECT���������';
comment on column EMR.HQMS_TRANFIELD.rctablename
  is 'ץȡ����ʱ����ǰ��ȡ�е�ֵ��[ֵ��ӳ���]��RCVALUE�ж�Ӧ�����ɷ���HQMS�й涨��ֵ��';
alter table EMR.HQMS_TRANFIELD
  add constraint HQMS_TRANFIELD_KEY primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table IEMCONTROLDEFAULT
prompt ================================
prompt
create table EMR.IEMCONTROLDEFAULT
(
  id           INTEGER not null,
  controlsrc   VARCHAR2(500),
  controlstyle VARCHAR2(100),
  property     VARCHAR2(100),
  controlvalue VARCHAR2(500),
  valid        CHAR(2),
  controlname  VARCHAR2(100)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.IEMCONTROLDEFAULT
  is '������ҳ�༭������ؼ�Ĭ��ֵ��';
comment on column EMR.IEMCONTROLDEFAULT.id
  is '�ؼ����';
comment on column EMR.IEMCONTROLDEFAULT.controlsrc
  is '�ؼ�·��(��������)';
comment on column EMR.IEMCONTROLDEFAULT.controlstyle
  is '�ؼ�����';
comment on column EMR.IEMCONTROLDEFAULT.property
  is '�ؼ�ָ������';
comment on column EMR.IEMCONTROLDEFAULT.controlvalue
  is 'ָ������ֵ';
comment on column EMR.IEMCONTROLDEFAULT.valid
  is '�Ƿ���Ч';
comment on column EMR.IEMCONTROLDEFAULT.controlname
  is '�ؼ�����';
alter table EMR.IEMCONTROLDEFAULT
  add primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table IEM_MAINPAGE_BASICINFO
prompt =====================================
prompt
create table EMR.IEM_MAINPAGE_BASICINFO
(
  iem_mainpage_no          NUMBER(12) not null,
  patnoofhis               VARCHAR2(14) not null,
  noofinpat                NUMBER(9) not null,
  payid                    VARCHAR2(4),
  socialcare               VARCHAR2(32),
  incount                  INTEGER,
  name                     VARCHAR2(60),
  sexid                    VARCHAR2(4),
  birth                    CHAR(10),
  marital                  VARCHAR2(4),
  jobid                    VARCHAR2(4),
  provinceid               VARCHAR2(10),
  countyid                 VARCHAR2(10),
  nationid                 VARCHAR2(4),
  nationalityid            VARCHAR2(4),
  idno                     VARCHAR2(18),
  organization             VARCHAR2(64),
  officeplace              VARCHAR2(64),
  officetel                VARCHAR2(16),
  officepost               VARCHAR2(16),
  nativeaddress            VARCHAR2(64),
  nativetel                VARCHAR2(16),
  nativepost               VARCHAR2(16),
  contactperson            VARCHAR2(32),
  relationship             VARCHAR2(4),
  contactaddress           VARCHAR2(255),
  contacttel               VARCHAR2(16),
  admitdate                VARCHAR2(19),
  admitdept                VARCHAR2(12),
  admitward                VARCHAR2(12),
  days_before              NUMBER(4),
  trans_date               VARCHAR2(19),
  trans_admitdept          VARCHAR2(12),
  trans_admitward          VARCHAR2(12),
  trans_admitdept_again    VARCHAR2(12),
  outwarddate              VARCHAR2(19),
  outhosdept               VARCHAR2(12),
  outhosward               VARCHAR2(12),
  actual_days              NUMBER(4),
  death_time               VARCHAR2(19),
  death_reason             VARCHAR2(300),
  admitinfo                VARCHAR2(4),
  in_check_date            VARCHAR2(19),
  pathology_diagnosis_name VARCHAR2(300),
  pathology_observation_sn VARCHAR2(60),
  ashes_diagnosis_name     VARCHAR2(300),
  ashes_anatomise_sn       VARCHAR2(60),
  allergic_drug            VARCHAR2(300),
  hbsag                    NUMBER(1),
  hcv_ab                   NUMBER(1),
  hiv_ab                   NUMBER(1),
  opd_ipd_id               NUMBER(1),
  in_out_inpatinet_id      NUMBER(1),
  before_after_or_id       NUMBER(1),
  clinical_pathology_id    NUMBER(1),
  pacs_pathology_id        NUMBER(1),
  save_times               NUMBER(4),
  success_times            NUMBER(4),
  section_director         VARCHAR2(20),
  director                 VARCHAR2(20),
  vs_employee_code         VARCHAR2(20),
  resident_employee_code   VARCHAR2(20),
  refresh_employee_code    VARCHAR2(20),
  master_interne           VARCHAR2(20),
  interne                  VARCHAR2(20),
  coding_user              VARCHAR2(20),
  medical_quality_id       NUMBER(1),
  quality_control_doctor   VARCHAR2(20),
  quality_control_nurse    VARCHAR2(20),
  quality_control_date     VARCHAR2(19),
  xay_sn                   VARCHAR2(300),
  ct_sn                    VARCHAR2(300),
  mri_sn                   VARCHAR2(300),
  dsa_sn                   VARCHAR2(300),
  is_first_case            NUMBER(1),
  is_following             NUMBER(1),
  following_ending_date    VARCHAR2(19),
  is_teaching_case         NUMBER(1),
  blood_type_id            NUMBER(3),
  rh                       NUMBER(1),
  blood_reaction_id        NUMBER(1),
  blood_rbc                NUMBER(4),
  blood_plt                NUMBER(4),
  blood_plasma             NUMBER(4),
  blood_wb                 NUMBER(4),
  blood_others             VARCHAR2(60),
  is_completed             VARCHAR2(1),
  completed_time           VARCHAR2(19),
  valide                   NUMBER(1) not null,
  create_user              VARCHAR2(10) not null,
  create_time              VARCHAR2(19) default to_char(sysdate,'yyyy-mm-dd HH24:MI:SS') not null,
  modified_user            VARCHAR2(10),
  modified_time            VARCHAR2(19),
  zymosis                  VARCHAR2(300),
  hurt_toxicosis_ele       VARCHAR2(300),
  zymosisstate             VARCHAR2(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on column EMR.IEM_MAINPAGE_BASICINFO.zymosis
  is 'ҽԺ��Ⱦ������';
comment on column EMR.IEM_MAINPAGE_BASICINFO.hurt_toxicosis_ele
  is '�����ж�����';
comment on column EMR.IEM_MAINPAGE_BASICINFO.zymosisstate
  is 'ҽԺ��Ⱦ������״̬';
create index EMR.IDX_IEM_BAS_NOOFINPAT on EMR.IEM_MAINPAGE_BASICINFO (NOOFINPAT)
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.IEM_MAINPAGE_BASICINFO
  add constraint PK_IEM_MAINPAGE_BASICINFO primary key (IEM_MAINPAGE_NO)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table IEM_MAINPAGE_BASICINFO_2012
prompt ==========================================
prompt
create table EMR.IEM_MAINPAGE_BASICINFO_2012
(
  iem_mainpage_no          NUMBER(12) not null,
  patnoofhis               VARCHAR2(14) not null,
  noofinpat                NUMBER(9) not null,
  payid                    VARCHAR2(4),
  socialcare               VARCHAR2(32),
  incount                  INTEGER,
  name                     VARCHAR2(60),
  sexid                    VARCHAR2(4),
  birth                    CHAR(80),
  marital                  VARCHAR2(4),
  jobid                    VARCHAR2(4),
  nationid                 VARCHAR2(4),
  nationalityid            VARCHAR2(4),
  idno                     VARCHAR2(18),
  organization             VARCHAR2(64),
  officeplace              VARCHAR2(64),
  officetel                VARCHAR2(16),
  officepost               VARCHAR2(16),
  contactperson            VARCHAR2(32),
  relationship             VARCHAR2(4),
  contactaddress           VARCHAR2(255),
  contacttel               VARCHAR2(16),
  admitdate                VARCHAR2(19),
  admitdept                VARCHAR2(12),
  admitward                VARCHAR2(12),
  trans_date               VARCHAR2(19),
  trans_admitdept          VARCHAR2(12),
  trans_admitward          VARCHAR2(12),
  outwarddate              VARCHAR2(19),
  outhosdept               VARCHAR2(12),
  outhosward               VARCHAR2(12),
  actualdays               NUMBER(12),
  pathology_diagnosis_name VARCHAR2(300),
  pathology_observation_sn VARCHAR2(60),
  allergic_drug            VARCHAR2(300),
  section_director         VARCHAR2(20),
  director                 VARCHAR2(20),
  vs_employee_code         VARCHAR2(20),
  resident_employee_code   VARCHAR2(20),
  refresh_employee_code    VARCHAR2(20),
  duty_nurse               VARCHAR2(20),
  interne                  VARCHAR2(20),
  coding_user              VARCHAR2(20),
  medical_quality_id       NUMBER(1),
  quality_control_doctor   VARCHAR2(20),
  quality_control_nurse    VARCHAR2(20),
  quality_control_date     VARCHAR2(19),
  xay_sn                   VARCHAR2(300),
  ct_sn                    VARCHAR2(300),
  mri_sn                   VARCHAR2(300),
  dsa_sn                   VARCHAR2(300),
  bloodtype                NUMBER(3),
  rh                       NUMBER(1),
  is_completed             VARCHAR2(1),
  completed_time           VARCHAR2(19),
  valide                   NUMBER(1) not null,
  create_user              VARCHAR2(10) not null,
  create_time              VARCHAR2(19) not null,
  modified_user            VARCHAR2(10),
  modified_time            VARCHAR2(19),
  zymosis                  VARCHAR2(300),
  hurt_toxicosis_ele_id    VARCHAR2(30),
  hurt_toxicosis_ele_name  VARCHAR2(100),
  zymosisstate             VARCHAR2(1),
  pathology_diagnosis_id   VARCHAR2(16),
  monthage                 VARCHAR2(10),
  weight                   VARCHAR2(10),
  inweight                 VARCHAR2(10),
  inhostype                VARCHAR2(1),
  outhostype               VARCHAR2(1),
  receivehospital          VARCHAR2(300),
  receivehospital2         VARCHAR2(300),
  againinhospital          VARCHAR2(1),
  againinhospitalreason    VARCHAR2(300),
  beforehoscomaday         VARCHAR2(4),
  beforehoscomahour        VARCHAR2(4),
  beforehoscomaminute      VARCHAR2(4),
  laterhoscomaday          VARCHAR2(4),
  laterhoscomahour         VARCHAR2(4),
  laterhoscomaminute       VARCHAR2(4),
  cardnumber               VARCHAR2(12),
  allergic_flag            VARCHAR2(1),
  autopsy_flag             VARCHAR2(1),
  csd_provinceid           VARCHAR2(10),
  csd_cityid               VARCHAR2(10),
  csd_districtid           VARCHAR2(10),
  csd_provincename         VARCHAR2(300),
  csd_cityname             VARCHAR2(300),
  csd_districtname         VARCHAR2(300),
  xzz_provinceid           VARCHAR2(10),
  xzz_cityid               VARCHAR2(10),
  xzz_districtid           VARCHAR2(10),
  xzz_provincename         VARCHAR2(300),
  xzz_cityname             VARCHAR2(300),
  xzz_districtname         VARCHAR2(300),
  xzz_tel                  VARCHAR2(20),
  xzz_post                 VARCHAR2(10),
  hkdz_provinceid          VARCHAR2(10),
  hkdz_cityid              VARCHAR2(10),
  hkdz_districtid          VARCHAR2(10),
  hkdz_provincename        VARCHAR2(300),
  hkdz_cityname            VARCHAR2(300),
  hkdz_districtname        VARCHAR2(300),
  hkdz_post                VARCHAR2(10),
  jg_provinceid            VARCHAR2(10),
  jg_cityid                VARCHAR2(10),
  jg_provincename          VARCHAR2(300),
  jg_cityname              VARCHAR2(300),
  age                      VARCHAR2(10),
  zg_flag                  VARCHAR2(1),
  admitinfo                VARCHAR2(4),
  csdaddress               VARCHAR2(500),
  jgaddress                VARCHAR2(500),
  xzzaddress               VARCHAR2(500),
  hkaddress                VARCHAR2(500),
  menandinhop              VARCHAR2(5),
  inhopandouthop           VARCHAR2(5),
  beforeopeandafteroper    VARCHAR2(5),
  linandbingli             VARCHAR2(5),
  inhopthree               VARCHAR2(5),
  fangandbingli            VARCHAR2(5),
  patflag                  VARCHAR2(5)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 27M
  );
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.iem_mainpage_no
  is '������ҳ��ʶ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.patnoofhis
  is '������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.noofinpat
  is '������ҳ���';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.payid
  is 'ҽ�Ƹ��ʽID';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.socialcare
  is '�籣����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.incount
  is '��Ժ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.name
  is '��������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.sexid
  is '�Ա�';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.birth
  is '����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.marital
  is '����״�� 1.δ�� 2.�ѻ� 3.ɥż4.��� 9.����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.jobid
  is 'ְҵ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.nationid
  is '����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.nationalityid
  is '����ID';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.idno
  is '���֤����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.organization
  is '������λ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.officeplace
  is '������λ��ַ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.officetel
  is '������λ�绰';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.officepost
  is '������λ�ʱ�';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.contactperson
  is '��ϵ������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.relationship
  is '����ϵ�˹�ϵ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.contactaddress
  is '��ϵ�˵�ַ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.contacttel
  is '��ϵ�˵绰';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.admitdate
  is '��Ժʱ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.admitdept
  is '��Ժ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.admitward
  is '��Ժ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.trans_date
  is 'תԺʱ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.trans_admitdept
  is 'תԺ�Ʊ�';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.trans_admitward
  is 'תԺ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.outwarddate
  is '��Ժʱ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.outhosdept
  is '��Ժ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.outhosward
  is '��Ժ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.actualdays
  is 'ʵ��סԺ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.pathology_diagnosis_name
  is '�����������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.pathology_observation_sn
  is '������� ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.allergic_drug
  is '����ҩ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.section_director
  is '������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.director
  is '������������ҽʦ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.vs_employee_code
  is '����ҽʦ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.resident_employee_code
  is 'סԺҽʦ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.refresh_employee_code
  is '����ҽʦ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.duty_nurse
  is '���λ�ʿ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.interne
  is 'ʵϰҽʦ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.coding_user
  is '����Ա';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.medical_quality_id
  is '��������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.quality_control_doctor
  is '�ʿ�ҽʦ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.quality_control_nurse
  is '�ʿػ�ʿ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.quality_control_date
  is '�ʿ�ʱ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.xay_sn
  is 'x�߼���';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.ct_sn
  is 'CT����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.mri_sn
  is 'mri����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.dsa_sn
  is 'Dsa����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.bloodtype
  is 'Ѫ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.rh
  is 'Rh';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.is_completed
  is '��ɷ� y/n ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.completed_time
  is '���ʱ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.valide
  is '���Ϸ� 1/0';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.create_user
  is '�����˼�¼��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.create_time
  is '����ʱ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.modified_user
  is '�޸Ĵ˼�¼��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.modified_time
  is '�޸�ʱ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.zymosis
  is 'ҽԺ��Ⱦ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.hurt_toxicosis_ele_id
  is '���ˡ��ж����ⲿ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.hurt_toxicosis_ele_name
  is '���ˡ��ж����ⲿ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.zymosisstate
  is 'ҽԺ��Ⱦ��״̬';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.pathology_diagnosis_id
  is '������ϱ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.monthage
  is '�����䲻��1����ģ� ����(��)';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.weight
  is '��������������(��)';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.inweight
  is '��������Ժ����(��)';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.inhostype
  is '��Ժ;��:1.����  2.����  3.����ҽ�ƻ���ת��  9.����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.outhostype
  is '��Ժ��ʽ �� 1.ҽ����Ժ  2.ҽ��תԺ 3.ҽ��ת���������������/��������Ժ 4.��ҽ����Ժ5.����9.����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.receivehospital
  is '2.ҽ��תԺ�������ҽ�ƻ������ƣ�';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.receivehospital2
  is '3.ҽ��ת���������������/��������Ժ�������ҽ�ƻ������ƣ�';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.againinhospital
  is '�Ƿ��г�Ժ31������סԺ�ƻ� �� 1.��  2.��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.againinhospitalreason
  is '��Ժ31������סԺ�ƻ� Ŀ��:                                               ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.beforehoscomaday
  is '­�����˻��߻���ʱ�䣺 ��Ժǰ    ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.beforehoscomahour
  is '­�����˻��߻���ʱ�䣺 ��Ժǰ     Сʱ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.beforehoscomaminute
  is '­�����˻��߻���ʱ�䣺 ��Ժǰ    ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.laterhoscomaday
  is '­�����˻��߻���ʱ�䣺 ��Ժ��    ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.laterhoscomahour
  is '­�����˻��߻���ʱ�䣺 ��Ժ��    Сʱ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.laterhoscomaminute
  is '­�����˻��߻���ʱ�䣺 ��Ժ��    ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.cardnumber
  is '��������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.allergic_flag
  is 'ҩ�����1.�� 2.��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.autopsy_flag
  is '��������ʬ�� �� 1.��  2.��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.csd_provinceid
  is '������ ʡ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.csd_cityid
  is '������ ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.csd_districtid
  is '������ ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.csd_provincename
  is '������ ʡ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.csd_cityname
  is '������ ������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.csd_districtname
  is '������ ������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.xzz_provinceid
  is '��סַ ʡ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.xzz_cityid
  is '��סַ ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.xzz_districtid
  is '��סַ ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.xzz_provincename
  is '��סַ ʡ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.xzz_cityname
  is '��סַ ������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.xzz_districtname
  is '��סַ ������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.xzz_tel
  is '��סַ �绰';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.xzz_post
  is '��סַ �ʱ�';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.hkdz_provinceid
  is '���ڵ�ַ ʡ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.hkdz_cityid
  is '���ڵ�ַ ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.hkdz_districtid
  is '���ڵ�ַ ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.hkdz_provincename
  is '���ڵ�ַ ʡ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.hkdz_cityname
  is '���ڵ�ַ ������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.hkdz_districtname
  is '���ڵ�ַ ������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.hkdz_post
  is '�������ڵ��ʱ�';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.jg_provinceid
  is '���� ʡ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.jg_cityid
  is '���� ������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.jg_provincename
  is '���� ʡ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.jg_cityname
  is '���� ������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_2012.age
  is '��������';

prompt
prompt Creating table IEM_MAINPAGE_BASICINFO_SX
prompt ========================================
prompt
create table EMR.IEM_MAINPAGE_BASICINFO_SX
(
  iem_mainpage_no          NUMBER(12) not null,
  patnoofhis               VARCHAR2(14) not null,
  noofinpat                NUMBER(9) not null,
  payid                    VARCHAR2(4),
  socialcare               VARCHAR2(32),
  incount                  INTEGER,
  name                     VARCHAR2(60),
  sexid                    VARCHAR2(4),
  birth                    CHAR(10),
  marital                  VARCHAR2(4),
  jobid                    VARCHAR2(4),
  nationid                 VARCHAR2(4),
  nationalityid            VARCHAR2(4),
  idno                     VARCHAR2(18),
  organization             VARCHAR2(64),
  officeplace              VARCHAR2(64),
  officetel                VARCHAR2(16),
  officepost               VARCHAR2(16),
  contactperson            VARCHAR2(32),
  relationship             VARCHAR2(4),
  contactaddress           VARCHAR2(255),
  contacttel               VARCHAR2(16),
  admitdate                VARCHAR2(19),
  admitdept                VARCHAR2(12),
  admitward                VARCHAR2(12),
  trans_date               VARCHAR2(19),
  trans_admitdept          VARCHAR2(12),
  trans_admitward          VARCHAR2(12),
  outwarddate              VARCHAR2(19),
  outhosdept               VARCHAR2(12),
  outhosward               VARCHAR2(12),
  actualdays               NUMBER(12),
  pathology_diagnosis_name VARCHAR2(300),
  pathology_observation_sn VARCHAR2(60),
  allergic_drug            VARCHAR2(300),
  section_director         VARCHAR2(20),
  director                 VARCHAR2(20),
  vs_employee_code         VARCHAR2(20),
  resident_employee_code   VARCHAR2(20),
  refresh_employee_code    VARCHAR2(20),
  duty_nurse               VARCHAR2(20),
  interne                  VARCHAR2(20),
  coding_user              VARCHAR2(20),
  medical_quality_id       NUMBER(1),
  quality_control_doctor   VARCHAR2(20),
  quality_control_nurse    VARCHAR2(20),
  quality_control_date     VARCHAR2(19),
  xay_sn                   VARCHAR2(300),
  ct_sn                    VARCHAR2(300),
  mri_sn                   VARCHAR2(300),
  dsa_sn                   VARCHAR2(300),
  bloodtype                NUMBER(3),
  rh                       NUMBER(1),
  is_completed             VARCHAR2(1),
  completed_time           VARCHAR2(19),
  valide                   NUMBER(1) not null,
  create_user              VARCHAR2(10) not null,
  create_time              VARCHAR2(19) not null,
  modified_user            VARCHAR2(10),
  modified_time            VARCHAR2(19),
  zymosis                  VARCHAR2(300),
  hurt_toxicosis_ele_id    VARCHAR2(30),
  hurt_toxicosis_ele_name  VARCHAR2(100),
  zymosisstate             VARCHAR2(1),
  pathology_diagnosis_id   VARCHAR2(16),
  monthage                 VARCHAR2(10),
  weight                   VARCHAR2(10),
  inweight                 VARCHAR2(10),
  inhostype                VARCHAR2(1),
  outhostype               VARCHAR2(1),
  receivehospital          VARCHAR2(300),
  receivehospital2         VARCHAR2(300),
  againinhospital          VARCHAR2(1),
  againinhospitalreason    VARCHAR2(300),
  beforehoscomaday         VARCHAR2(4),
  beforehoscomahour        VARCHAR2(4),
  beforehoscomaminute      VARCHAR2(4),
  laterhoscomaday          VARCHAR2(4),
  laterhoscomahour         VARCHAR2(4),
  laterhoscomaminute       VARCHAR2(4),
  cardnumber               VARCHAR2(40),
  allergic_flag            VARCHAR2(1),
  autopsy_flag             VARCHAR2(1),
  csd_provinceid           VARCHAR2(100),
  csd_cityid               VARCHAR2(10),
  csd_districtid           VARCHAR2(10),
  csd_provincename         VARCHAR2(300),
  csd_cityname             VARCHAR2(300),
  csd_districtname         VARCHAR2(300),
  xzz_provinceid           VARCHAR2(100),
  xzz_cityid               VARCHAR2(10),
  xzz_districtid           VARCHAR2(10),
  xzz_provincename         VARCHAR2(300),
  xzz_cityname             VARCHAR2(300),
  xzz_districtname         VARCHAR2(300),
  xzz_tel                  VARCHAR2(20),
  xzz_post                 VARCHAR2(10),
  hkdz_provinceid          VARCHAR2(100),
  hkdz_cityid              VARCHAR2(10),
  hkdz_districtid          VARCHAR2(10),
  hkdz_provincename        VARCHAR2(300),
  hkdz_cityname            VARCHAR2(300),
  hkdz_districtname        VARCHAR2(300),
  hkdz_post                VARCHAR2(10),
  jg_provinceid            VARCHAR2(100),
  jg_cityid                VARCHAR2(10),
  jg_provincename          VARCHAR2(300),
  jg_cityname              VARCHAR2(300),
  age                      VARCHAR2(10),
  cure_type                VARCHAR2(4),
  mzzyzd_name              VARCHAR2(300),
  mzzyzd_code              VARCHAR2(60),
  mzxyzd_name              VARCHAR2(300),
  mzxyzd_code              VARCHAR2(60),
  sslclj                   VARCHAR2(4),
  zyzj                     VARCHAR2(4),
  zyzlsb                   VARCHAR2(4),
  zyzljs                   VARCHAR2(4),
  bzsh                     VARCHAR2(4),
  outhosstatus             VARCHAR2(4),
  jbynzz                   VARCHAR2(4),
  mzycy                    VARCHAR2(4),
  inandouthos              VARCHAR2(4),
  lcybl                    VARCHAR2(4),
  fsybl                    VARCHAR2(4),
  qjcount                  VARCHAR2(10),
  successcount             VARCHAR2(10),
  inpatly                  VARCHAR2(4),
  asascore                 VARCHAR2(10)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 3M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.iem_mainpage_no
  is '������ҳ��ʶ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.patnoofhis
  is '������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.noofinpat
  is '������ҳ���';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.payid
  is 'ҽ�Ƹ��ʽID';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.socialcare
  is '�籣����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.incount
  is '��Ժ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.name
  is '��������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.sexid
  is '�Ա�';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.birth
  is '����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.marital
  is '����״�� 0.δ�� 1.�ѻ� 3.ɥż2.��� 9.����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.jobid
  is 'ְҵ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.nationid
  is '����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.nationalityid
  is '����ID';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.idno
  is '���֤����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.organization
  is '������λ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.officeplace
  is '������λ��ַ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.officetel
  is '������λ�绰';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.officepost
  is '������λ�ʱ�';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.contactperson
  is '��ϵ������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.relationship
  is '����ϵ�˹�ϵ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.contactaddress
  is '��ϵ�˵�ַ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.contacttel
  is '��ϵ�˵绰';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.admitdate
  is '��Ժʱ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.admitdept
  is '��Ժ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.admitward
  is '��Ժ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.trans_date
  is 'תԺʱ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.trans_admitdept
  is 'תԺ�Ʊ�';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.trans_admitward
  is 'תԺ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.outwarddate
  is '��Ժʱ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.outhosdept
  is '��Ժ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.outhosward
  is '��Ժ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.actualdays
  is 'ʵ��סԺ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.pathology_diagnosis_name
  is '�����������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.pathology_observation_sn
  is '������� ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.allergic_drug
  is '����ҩ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.section_director
  is '������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.director
  is '������������ҽʦ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.vs_employee_code
  is '����ҽʦ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.resident_employee_code
  is 'סԺҽʦ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.refresh_employee_code
  is '����ҽʦ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.duty_nurse
  is '���λ�ʿ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.interne
  is 'ʵϰҽʦ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.coding_user
  is '����Ա';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.medical_quality_id
  is '��������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.quality_control_doctor
  is '�ʿ�ҽʦ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.quality_control_nurse
  is '�ʿػ�ʿ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.quality_control_date
  is '�ʿ�ʱ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.xay_sn
  is 'x�߼���';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.ct_sn
  is 'CT����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.mri_sn
  is 'mri����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.dsa_sn
  is 'Dsa����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.bloodtype
  is 'Ѫ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.rh
  is 'Rh';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.is_completed
  is '��ɷ� y/n ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.completed_time
  is '���ʱ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.valide
  is '���Ϸ� 1/0';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.create_user
  is '�����˼�¼��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.create_time
  is '����ʱ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.modified_user
  is '�޸Ĵ˼�¼��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.modified_time
  is '�޸�ʱ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.zymosis
  is 'ҽԺ��Ⱦ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.hurt_toxicosis_ele_id
  is '���ˡ��ж����ⲿ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.hurt_toxicosis_ele_name
  is '���ˡ��ж����ⲿ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.zymosisstate
  is 'ҽԺ��Ⱦ��״̬';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.pathology_diagnosis_id
  is '������ϱ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.monthage
  is '�����䲻��1����ģ� ����(��)';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.weight
  is '��������������(��)';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.inweight
  is '��������Ժ����(��)';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.inhostype
  is '��Ժ;��:1.����  2.����  3.����ҽ�ƻ���ת��  9.����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.outhostype
  is '��Ժ��ʽ �� 1.ҽ����Ժ  2.ҽ��תԺ 3.ҽ��ת���������������/��������Ժ 4.��ҽ����Ժ5.����9.����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.receivehospital
  is '2.ҽ��תԺ�������ҽ�ƻ������ƣ�';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.receivehospital2
  is '3.ҽ��ת���������������/��������Ժ�������ҽ�ƻ������ƣ�';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.againinhospital
  is '�Ƿ��г�Ժ31������סԺ�ƻ� �� 1.��  2.��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.againinhospitalreason
  is '��Ժ31������סԺ�ƻ� Ŀ��:                                               ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.beforehoscomaday
  is '­�����˻��߻���ʱ�䣺 ��Ժǰ    ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.beforehoscomahour
  is '­�����˻��߻���ʱ�䣺 ��Ժǰ     Сʱ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.beforehoscomaminute
  is '­�����˻��߻���ʱ�䣺 ��Ժǰ    ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.laterhoscomaday
  is '­�����˻��߻���ʱ�䣺 ��Ժ��    ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.laterhoscomahour
  is '­�����˻��߻���ʱ�䣺 ��Ժ��    Сʱ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.laterhoscomaminute
  is '­�����˻��߻���ʱ�䣺 ��Ժ��    ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.cardnumber
  is '��������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.allergic_flag
  is 'ҩ�����1.�� 2.��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.autopsy_flag
  is '��������ʬ�� �� 1.��  2.��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.csd_provinceid
  is '������ ʡ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.csd_cityid
  is '������ ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.csd_districtid
  is '������ ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.csd_provincename
  is '������ ʡ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.csd_cityname
  is '������ ������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.csd_districtname
  is '������ ������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.xzz_provinceid
  is '��סַ ʡ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.xzz_cityid
  is '��סַ ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.xzz_districtid
  is '��סַ ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.xzz_provincename
  is '��סַ ʡ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.xzz_cityname
  is '��סַ ������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.xzz_districtname
  is '��סַ ������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.xzz_tel
  is '��סַ �绰';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.xzz_post
  is '��סַ �ʱ�';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.hkdz_provinceid
  is '���ڵ�ַ ʡ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.hkdz_cityid
  is '���ڵ�ַ ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.hkdz_districtid
  is '���ڵ�ַ ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.hkdz_provincename
  is '���ڵ�ַ ʡ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.hkdz_cityname
  is '���ڵ�ַ ������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.hkdz_districtname
  is '���ڵ�ַ ������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.hkdz_post
  is '�������ڵ��ʱ�';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.jg_provinceid
  is '���� ʡ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.jg_cityid
  is '���� ������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.jg_provincename
  is '���� ʡ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.jg_cityname
  is '���� ������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.age
  is '��������';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.cure_type
  is '������� �� 1.��ҽ�� 1.1 ��ҽ   1.2����ҽ��    2.����ҽ     3.��ҽ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.mzzyzd_name
  is '�ţ���������ϣ���ҽ��ϣ�';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.mzzyzd_code
  is '�ţ���������ϣ���ҽ��ϣ� ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.mzxyzd_name
  is '�ţ���������ϣ���ҽ��ϣ�';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.mzxyzd_code
  is '�ţ���������ϣ���ҽ��ϣ� ����';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.sslclj
  is 'ʵʩ�ٴ�·������ 1. ��ҽ  2. ��ҽ  3 �� ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.zyzj
  is 'ʹ��ҽ�ƻ�����ҩ�Ƽ����� 1.��  2. �� ';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.zyzlsb
  is 'ʹ����ҽ�����豸����  1.�� 2. ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.zyzljs
  is 'ʹ����ҽ���Ƽ������� 1. ��  2. ��';
comment on column EMR.IEM_MAINPAGE_BASICINFO_SX.bzsh
  is '��֤ʩ������ 1.��  2. ��';

prompt
prompt Creating table IEM_MAINPAGE_DEFAULT
prompt ===================================
prompt
create table EMR.IEM_MAINPAGE_DEFAULT
(
  id      NUMBER(12) not null,
  typenum VARCHAR2(64) not null,
  tname   VARCHAR2(64) not null,
  tvalue  VARCHAR2(64) not null
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.IEM_MAINPAGE_DEFAULT
  add constraint PK_IEM_MAINPAGE_DEFAULT primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table IEM_MAINPAGE_DIAGNOSIS
prompt =====================================
prompt
create table EMR.IEM_MAINPAGE_DIAGNOSIS
(
  iem_mainpage_diagnosis_no NUMBER(12) not null,
  iem_mainpage_no           NUMBER(12) not null,
  diagnosis_type_id         NUMBER(3) not null,
  diagnosis_code            VARCHAR2(60),
  diagnosis_name            VARCHAR2(300) not null,
  status_id                 NUMBER(3),
  order_value               NUMBER(3) default 0 not null,
  valide                    NUMBER(1) not null,
  create_user               VARCHAR2(10) not null,
  create_time               VARCHAR2(19) default to_char(sysdate,'yyyy-mm-dd HH24:MI:SS') not null,
  cancel_user               VARCHAR2(10),
  cancel_time               VARCHAR2(19)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.IEM_MAINPAGE_DIAGNOSIS
  add constraint PK_IEM_MAINPAGE_DIAGNOSIS primary key (IEM_MAINPAGE_DIAGNOSIS_NO)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table IEM_MAINPAGE_DIAGNOSIS_2012
prompt ==========================================
prompt
create table EMR.IEM_MAINPAGE_DIAGNOSIS_2012
(
  iem_mainpage_diagnosis_no NUMBER(12) not null,
  iem_mainpage_no           NUMBER(12) not null,
  diagnosis_type_id         NUMBER(3) not null,
  diagnosis_code            VARCHAR2(60),
  diagnosis_name            VARCHAR2(300) not null,
  status_id                 NUMBER(3),
  order_value               NUMBER(3) not null,
  valide                    NUMBER(1) not null,
  create_user               VARCHAR2(10) not null,
  create_time               VARCHAR2(19) not null,
  cancel_user               VARCHAR2(10),
  cancel_time               VARCHAR2(19),
  menandinhop               VARCHAR2(5),
  inhopandouthop            VARCHAR2(5),
  beforeopeandafteroper     VARCHAR2(5),
  linandbingli              VARCHAR2(5),
  inhopthree                VARCHAR2(5),
  fangandbingli             VARCHAR2(5),
  admitinfo                 VARCHAR2(4),
  morphologyicd             VARCHAR2(60),
  morphologyname            VARCHAR2(100)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 36M
  );

prompt
prompt Creating table IEM_MAINPAGE_DIAGNOSIS_SX
prompt ========================================
prompt
create table EMR.IEM_MAINPAGE_DIAGNOSIS_SX
(
  iem_mainpage_diagnosis_no NUMBER(12) not null,
  iem_mainpage_no           NUMBER(12) not null,
  diagnosis_type_id         NUMBER(3) not null,
  diagnosis_code            VARCHAR2(60),
  diagnosis_name            VARCHAR2(300) not null,
  status_id                 NUMBER(3),
  order_value               NUMBER(3) not null,
  valide                    NUMBER(1) not null,
  create_user               VARCHAR2(10) not null,
  create_time               VARCHAR2(19) not null,
  cancel_user               VARCHAR2(10),
  cancel_time               VARCHAR2(19),
  type                      VARCHAR2(1),
  typename                  VARCHAR2(12)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 9M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.IEM_MAINPAGE_DIAGNOSIS_SX.type
  is '������� 1����ҽ  2����ҽ';
comment on column EMR.IEM_MAINPAGE_DIAGNOSIS_SX.typename
  is '������� ';

prompt
prompt Creating table IEM_MAINPAGE_EXCEPT
prompt ==================================
prompt
create table EMR.IEM_MAINPAGE_EXCEPT
(
  iemexid         VARCHAR2(50) not null,
  iemexname       VARCHAR2(50),
  dateelementflow VARCHAR2(50),
  iemcontrol      VARCHAR2(100),
  iemothername    VARCHAR2(100),
  ordercode       VARCHAR2(50),
  isotherline     VARCHAR2(10),
  valide          VARCHAR2(2),
  createdocid     VARCHAR2(50),
  createdatetime  CHAR(19),
  modifydocid     VARCHAR2(50),
  modifydatetime  CHAR(19)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.IEM_MAINPAGE_EXCEPT
  is '������ҳ����ά����';
comment on column EMR.IEM_MAINPAGE_EXCEPT.iemexid
  is 'GUID����';
comment on column EMR.IEM_MAINPAGE_EXCEPT.iemexname
  is '����Ԫ����';
comment on column EMR.IEM_MAINPAGE_EXCEPT.dateelementflow
  is '����ԪID';
comment on column EMR.IEM_MAINPAGE_EXCEPT.iemcontrol
  is '�ؼ�����';
comment on column EMR.IEM_MAINPAGE_EXCEPT.iemothername
  is '����';
comment on column EMR.IEM_MAINPAGE_EXCEPT.ordercode
  is '������';
comment on column EMR.IEM_MAINPAGE_EXCEPT.isotherline
  is '�Ƿ���';
comment on column EMR.IEM_MAINPAGE_EXCEPT.valide
  is '�Ƿ���Ч 1-��Ч 0-��Ч';
comment on column EMR.IEM_MAINPAGE_EXCEPT.createdocid
  is '����ҽʦ���';
comment on column EMR.IEM_MAINPAGE_EXCEPT.createdatetime
  is '����ʱ��';
comment on column EMR.IEM_MAINPAGE_EXCEPT.modifydocid
  is '�޸�ҽʦ���(��¼��ز�����Ϣ)';
comment on column EMR.IEM_MAINPAGE_EXCEPT.modifydatetime
  is '�޸�ʱ��';
alter table EMR.IEM_MAINPAGE_EXCEPT
  add constraint PK_IEM_EXCEPT primary key (IEMEXID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table IEM_MAINPAGE_EXCEPT_USE
prompt ======================================
prompt
create table EMR.IEM_MAINPAGE_EXCEPT_USE
(
  iemexuseid     VARCHAR2(50) not null,
  iemexid        VARCHAR2(50),
  noofinpat      VARCHAR2(50),
  value          VARCHAR2(4000),
  createdocid    VARCHAR2(50),
  createdatetime CHAR(19),
  modifydocid    VARCHAR2(50),
  modifydatetime CHAR(19)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.IEM_MAINPAGE_EXCEPT_USE
  is '������ҳ����ά��Ԫ�û�ʹ�ñ�';
comment on column EMR.IEM_MAINPAGE_EXCEPT_USE.iemexuseid
  is 'GUID����';
comment on column EMR.IEM_MAINPAGE_EXCEPT_USE.iemexid
  is '�������ñ������';
comment on column EMR.IEM_MAINPAGE_EXCEPT_USE.noofinpat
  is '���˲�����';
comment on column EMR.IEM_MAINPAGE_EXCEPT_USE.value
  is 'ֵ';
comment on column EMR.IEM_MAINPAGE_EXCEPT_USE.createdocid
  is '����ҽʦ���';
comment on column EMR.IEM_MAINPAGE_EXCEPT_USE.createdatetime
  is '����ʱ��';
comment on column EMR.IEM_MAINPAGE_EXCEPT_USE.modifydocid
  is '�޸�ҽʦ���';
comment on column EMR.IEM_MAINPAGE_EXCEPT_USE.modifydatetime
  is '�޸�ʱ��';
alter table EMR.IEM_MAINPAGE_EXCEPT_USE
  add constraint PK_IEM_USER primary key (IEMEXUSEID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table IEM_MAINPAGE_FEEINFO
prompt ===================================
prompt
create table EMR.IEM_MAINPAGE_FEEINFO
(
  id              NUMBER(12) not null,
  iem_mainpage_no NUMBER(12) not null,
  totalfee        VARCHAR2(50),
  ownerfee        VARCHAR2(50),
  ybmedservfee    VARCHAR2(50),
  ybmedoperfee    VARCHAR2(50),
  nursefee        VARCHAR2(50),
  otherinfo       VARCHAR2(50),
  blzdfee         VARCHAR2(50),
  syszdfee        VARCHAR2(50),
  yxxzdfee        VARCHAR2(50),
  lczditemfee     VARCHAR2(50),
  fsszlitemfee    VARCHAR2(50),
  lcwlzlfee       VARCHAR2(50),
  opermedfee      VARCHAR2(50),
  mazuifee        VARCHAR2(50),
  shoushufee      VARCHAR2(50),
  kffee           VARCHAR2(50),
  zyzlfee         VARCHAR2(50),
  xymedfee        VARCHAR2(50),
  kjywfee         VARCHAR2(50),
  zcyffee         VARCHAR2(50),
  zcaoyffee       VARCHAR2(50),
  bloodfee        VARCHAR2(50),
  bdblzpffee      VARCHAR2(50),
  qdblzpffee      VARCHAR2(50),
  nxyzlzpffee     VARCHAR2(50),
  xbyzlzpffee     VARCHAR2(50),
  jcyycxyyclffee  VARCHAR2(50),
  zlyycxyyclffee  VARCHAR2(50),
  ssyycxyyclffee  VARCHAR2(50),
  qtfee           VARCHAR2(50),
  memofee1        VARCHAR2(50),
  memofee2        VARCHAR2(50),
  memofee3        VARCHAR2(50),
  valid           NUMBER(2) not null
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 3M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.IEM_MAINPAGE_FEEINFO.totalfee
  is '�ܷ���';
comment on column EMR.IEM_MAINPAGE_FEEINFO.ownerfee
  is '�Ը����';
comment on column EMR.IEM_MAINPAGE_FEEINFO.ybmedservfee
  is 'һ��ҽ�Ʒ����';
comment on column EMR.IEM_MAINPAGE_FEEINFO.ybmedoperfee
  is 'һ�����Ʋ�����';
comment on column EMR.IEM_MAINPAGE_FEEINFO.nursefee
  is '�����';
comment on column EMR.IEM_MAINPAGE_FEEINFO.otherinfo
  is '��������';
comment on column EMR.IEM_MAINPAGE_FEEINFO.blzdfee
  is '������Ϸ�';
comment on column EMR.IEM_MAINPAGE_FEEINFO.syszdfee
  is 'ʵ������Ϸ�';
comment on column EMR.IEM_MAINPAGE_FEEINFO.yxxzdfee
  is 'Ӱ��ѧ��Ϸ�';
comment on column EMR.IEM_MAINPAGE_FEEINFO.lczditemfee
  is '�ٴ������Ŀ��';
comment on column EMR.IEM_MAINPAGE_FEEINFO.fsszlitemfee
  is '������������Ŀ��';
comment on column EMR.IEM_MAINPAGE_FEEINFO.lcwlzlfee
  is '�ٴ��������Ʒ�';
comment on column EMR.IEM_MAINPAGE_FEEINFO.opermedfee
  is '�������Ʒ�';
comment on column EMR.IEM_MAINPAGE_FEEINFO.mazuifee
  is '�����';
comment on column EMR.IEM_MAINPAGE_FEEINFO.shoushufee
  is '������';
comment on column EMR.IEM_MAINPAGE_FEEINFO.kffee
  is '������';
comment on column EMR.IEM_MAINPAGE_FEEINFO.zyzlfee
  is '��ҽ���Ʒ�';
comment on column EMR.IEM_MAINPAGE_FEEINFO.xymedfee
  is '��ҩ��';
comment on column EMR.IEM_MAINPAGE_FEEINFO.kjywfee
  is '����ҩ�����';
comment on column EMR.IEM_MAINPAGE_FEEINFO.zcyffee
  is '�г�ҩ��';
comment on column EMR.IEM_MAINPAGE_FEEINFO.zcaoyffee
  is '�в�ҩ��';
comment on column EMR.IEM_MAINPAGE_FEEINFO.bloodfee
  is 'Ѫ��';
comment on column EMR.IEM_MAINPAGE_FEEINFO.bdblzpffee
  is '�׵�������Ʒ��';
comment on column EMR.IEM_MAINPAGE_FEEINFO.qdblzpffee
  is '�򵰰�����Ʒ��';
comment on column EMR.IEM_MAINPAGE_FEEINFO.nxyzlzpffee
  is '��Ѫ��������Ʒ��';
comment on column EMR.IEM_MAINPAGE_FEEINFO.xbyzlzpffee
  is 'ϸ����������Ʒ��';
comment on column EMR.IEM_MAINPAGE_FEEINFO.jcyycxyyclffee
  is '�����һ����ҽ�ò��Ϸ�';
comment on column EMR.IEM_MAINPAGE_FEEINFO.zlyycxyyclffee
  is '������һ����ҽ�ò��Ϸ�';
comment on column EMR.IEM_MAINPAGE_FEEINFO.ssyycxyyclffee
  is '������һ����ҽ�ò��Ϸ�';
comment on column EMR.IEM_MAINPAGE_FEEINFO.qtfee
  is '������';
alter table EMR.IEM_MAINPAGE_FEEINFO
  add constraint PK_IEM_MAINPAGE_FEEINFO primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 640K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table IEM_MAINPAGE_FEEINFOZY
prompt =====================================
prompt
create table EMR.IEM_MAINPAGE_FEEINFOZY
(
  id        VARCHAR2(50) not null,
  noofinpat VARCHAR2(50),
  total     VARCHAR2(50),
  ownfee    VARCHAR2(50),
  ybylfy    VARCHAR2(50),
  zybzlzf   VARCHAR2(50),
  zybzlzhzf VARCHAR2(50),
  ybzlfy    VARCHAR2(50),
  care      VARCHAR2(50),
  zhqtfy    VARCHAR2(50),
  blzdf     VARCHAR2(50),
  syszdf    VARCHAR2(50),
  yxxzdf    VARCHAR2(50),
  lczdf     VARCHAR2(50),
  fsszlf    VARCHAR2(50),
  lcwlzlf   VARCHAR2(50),
  sszlf     VARCHAR2(50),
  mzf       VARCHAR2(50),
  ssf       VARCHAR2(50),
  kff       VARCHAR2(50),
  zyzdf     VARCHAR2(50),
  zyzlf     VARCHAR2(50),
  zywz      VARCHAR2(50),
  zygs      VARCHAR2(50),
  zcyjf     VARCHAR2(50),
  zytnzl    VARCHAR2(50),
  zygczl    VARCHAR2(50),
  zytszl    VARCHAR2(50),
  zyqt      VARCHAR2(50),
  zytstpjg  VARCHAR2(50),
  bzss      VARCHAR2(50),
  xyf       VARCHAR2(50),
  kjywf     VARCHAR2(50),
  cpmedical VARCHAR2(50),
  yljgzyzjf VARCHAR2(50),
  cmedical  VARCHAR2(50),
  bloodfee  VARCHAR2(50),
  xdblzpf   VARCHAR2(50),
  qdblzpf   VARCHAR2(50),
  nxyzlzpf  VARCHAR2(50),
  xbyzlzpf  VARCHAR2(50),
  jcyycxclf VARCHAR2(50),
  zlyycxclf VARCHAR2(50),
  ssyycxclf VARCHAR2(50),
  otherfee  VARCHAR2(50),
  valid     VARCHAR2(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.id
  is '����';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.noofinpat
  is '��������';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.total
  is '�ܷ���';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.ownfee
  is '�Ը����';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.ybylfy
  is 'һ��ҽ�Ʒ����';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.zybzlzf
  is '��ҽ��֤���η�';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.zybzlzhzf
  is '��ҽ��֤���λ����';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.ybzlfy
  is 'һ�����Ʋ�����';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.care
  is '�����';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.zhqtfy
  is ' �ۺ��� ��������';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.blzdf
  is '����� ������Ϸ�';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.syszdf
  is '����� ʵ������Ϸ�';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.yxxzdf
  is '����� Ӱ��ѧ��Ϸ�';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.lczdf
  is ' ����� �ٴ������Ŀ��';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.fsszlf
  is '������ ������������Ŀ��';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.lcwlzlf
  is '������ �ٴ��������Ʒ�';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.sszlf
  is ' ������ �������Ʒ�';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.mzf
  is '������ �����';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.ssf
  is ' ������ ������';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.kff
  is '������ ������';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.zyzdf
  is '��ҽ�� ��ҽ���';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.zyzlf
  is '��ҽ�� ��ҽ���Ʒ�';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.zywz
  is '��ҽ����';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.zygs
  is '��ҽ����';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.zcyjf
  is '�����ķ�';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.zytnzl
  is '��ҽ��������';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.zygczl
  is '��ҽ�س�����';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.zytszl
  is '��ҽ��������';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.zyqt
  is ' ��ҽ����';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.zytstpjg
  is '��ҩ�������ӹ�';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.bzss
  is '��֤ʩ��';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.xyf
  is '��ҩ�� ��ҩ��';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.kjywf
  is '��ҩ�� ����ҩ�����';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.cpmedical
  is '��ҩ�� �г�ҩ��';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.yljgzyzjf
  is 'ҽ�ƻ�����ҩ�Ƽ���';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.cmedical
  is '��ҩ�� �в�ҩ��';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.bloodfee
  is 'ѪҺ��ѪҺ��Ʒ�� Ѫ��';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.xdblzpf
  is 'ѪҺ��ѪҺ��Ʒ�� �׵�������Ʒ��';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.qdblzpf
  is 'ѪҺ��ѪҺ��Ʒ�� �򵰰�����Ʒ��';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.nxyzlzpf
  is 'ѪҺ��ѪҺ��Ʒ�� ��Ѫ��������Ʒ��';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.xbyzlzpf
  is 'ѪҺ��ѪҺ��Ʒ�� ϸ����������Ʒ��';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.jcyycxclf
  is '�Ĳ��� �����һ����ҽ�ò��Ϸ�';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.zlyycxclf
  is '�Ĳ��� ������һ����ҽ�ò��Ϸ�';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.ssyycxclf
  is '�Ĳ��� ������һ����ҽ�ò��Ϸ�';
comment on column EMR.IEM_MAINPAGE_FEEINFOZY.otherfee
  is '�����ࣺ������';
alter table EMR.IEM_MAINPAGE_FEEINFOZY
  add constraint PK_IEMFEEID primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table IEM_MAINPAGE_OBSTETRICSBABY
prompt ==========================================
prompt
create table EMR.IEM_MAINPAGE_OBSTETRICSBABY
(
  iem_mainpage_obsbabyid NUMBER(12),
  iem_mainpage_no        NUMBER(12),
  tc                     VARCHAR2(1),
  cc                     VARCHAR2(1),
  tb                     VARCHAR2(1),
  cfhypld                VARCHAR2(1),
  midwifery              VARCHAR2(20),
  sex                    VARCHAR2(1),
  apj                    VARCHAR2(10),
  heigh                  VARCHAR2(10),
  weight                 VARCHAR2(10),
  ccqk                   VARCHAR2(1),
  bithday                VARCHAR2(19),
  fmfs                   VARCHAR2(1),
  cyqk                   VARCHAR2(1),
  create_user            VARCHAR2(10),
  create_time            VARCHAR2(19),
  valide                 VARCHAR2(1) default 1,
  ibsbabyid              VARCHAR2(10)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 256K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.IEM_MAINPAGE_OBSTETRICSBABY
  is '������ҳ--����Ӥ�����';
comment on column EMR.IEM_MAINPAGE_OBSTETRICSBABY.tc
  is '̥��';
comment on column EMR.IEM_MAINPAGE_OBSTETRICSBABY.cc
  is '����';
comment on column EMR.IEM_MAINPAGE_OBSTETRICSBABY.tb
  is '̥��';
comment on column EMR.IEM_MAINPAGE_OBSTETRICSBABY.cfhypld
  is '�����������Ѷ�';
comment on column EMR.IEM_MAINPAGE_OBSTETRICSBABY.midwifery
  is '�Ӳ���';
comment on column EMR.IEM_MAINPAGE_OBSTETRICSBABY.sex
  is '�Ա�';
comment on column EMR.IEM_MAINPAGE_OBSTETRICSBABY.apj
  is '����������';
comment on column EMR.IEM_MAINPAGE_OBSTETRICSBABY.heigh
  is '��';
comment on column EMR.IEM_MAINPAGE_OBSTETRICSBABY.weight
  is '����';
comment on column EMR.IEM_MAINPAGE_OBSTETRICSBABY.ccqk
  is '�������';
comment on column EMR.IEM_MAINPAGE_OBSTETRICSBABY.bithday
  is '����ʱ��';
comment on column EMR.IEM_MAINPAGE_OBSTETRICSBABY.fmfs
  is '���䷽ʽ';
comment on column EMR.IEM_MAINPAGE_OBSTETRICSBABY.cyqk
  is '��Ժ���';

prompt
prompt Creating table IEM_MAINPAGE_OPERATION
prompt =====================================
prompt
create table EMR.IEM_MAINPAGE_OPERATION
(
  iem_mainpage_operation_no NUMBER(12) not null,
  iem_mainpage_no           NUMBER(12) not null,
  operation_code            VARCHAR2(60) not null,
  operation_date            VARCHAR2(19),
  operation_name            VARCHAR2(300),
  execute_user1             VARCHAR2(20),
  execute_user2             VARCHAR2(20),
  execute_user3             VARCHAR2(20),
  anaesthesia_type_id       NUMBER(3),
  close_level               NUMBER(3),
  anaesthesia_user          VARCHAR2(20),
  valide                    NUMBER(1) not null,
  create_user               VARCHAR2(10) not null,
  create_time               VARCHAR2(19) default to_char(sysdate,'yyyy-mm-dd HH24:MI:SS') not null,
  cancel_user               VARCHAR2(10),
  cancel_time               VARCHAR2(19)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.IEM_MAINPAGE_OPERATION
  add constraint PK_IEM_MAINPAGE_OPERATION primary key (IEM_MAINPAGE_OPERATION_NO)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table IEM_MAINPAGE_OPERATION_2012
prompt ==========================================
prompt
create table EMR.IEM_MAINPAGE_OPERATION_2012
(
  iem_mainpage_operation_no NUMBER(12) not null,
  iem_mainpage_no           NUMBER(12) not null,
  operation_code            VARCHAR2(60) not null,
  operation_date            VARCHAR2(19),
  operation_name            VARCHAR2(300),
  execute_user1             VARCHAR2(20),
  execute_user2             VARCHAR2(20),
  execute_user3             VARCHAR2(20),
  anaesthesia_type_id       VARCHAR2(4),
  close_level               VARCHAR2(4),
  anaesthesia_user          VARCHAR2(20),
  valide                    NUMBER(1) not null,
  create_user               VARCHAR2(10) not null,
  create_time               VARCHAR2(19) not null,
  cancel_user               VARCHAR2(10),
  cancel_time               VARCHAR2(19),
  operation_level           VARCHAR2(1),
  ischoosedate              VARCHAR2(5),
  isclearope                VARCHAR2(5),
  isganran                  VARCHAR2(5),
  anesthesia_level          NVARCHAR2(10),
  opercomplication_code     NVARCHAR2(20)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 6M
  );
comment on column EMR.IEM_MAINPAGE_OPERATION_2012.operation_level
  is '�����ȼ�    ������Ϊ�ļ�';
comment on column EMR.IEM_MAINPAGE_OPERATION_2012.anesthesia_level
  is '����ּ�';
comment on column EMR.IEM_MAINPAGE_OPERATION_2012.opercomplication_code
  is '��������֢ICD����';

prompt
prompt Creating table IEM_MAINPAGE_OPERATION_SX
prompt ========================================
prompt
create table EMR.IEM_MAINPAGE_OPERATION_SX
(
  iem_mainpage_operation_no NUMBER(12) not null,
  iem_mainpage_no           NUMBER(12) not null,
  operation_code            VARCHAR2(60) not null,
  operation_date            VARCHAR2(19),
  operation_name            VARCHAR2(300),
  execute_user1             VARCHAR2(20),
  execute_user2             VARCHAR2(20),
  execute_user3             VARCHAR2(20),
  anaesthesia_type_id       VARCHAR2(4),
  close_level               VARCHAR2(4),
  anaesthesia_user          VARCHAR2(20),
  valide                    NUMBER(1) not null,
  create_user               VARCHAR2(10) not null,
  create_time               VARCHAR2(19) not null,
  cancel_user               VARCHAR2(10),
  cancel_time               VARCHAR2(19),
  operation_level           VARCHAR2(1),
  operintimes               VARCHAR2(20)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 384K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table IEM_MAINPAGE_OTHER_2012
prompt ======================================
prompt
create table EMR.IEM_MAINPAGE_OTHER_2012
(
  iem_mainpage_other_no        NUMBER(12) not null,
  iem_mainpage_no              NUMBER(12) not null,
  main_diagnosis_curecondition VARCHAR2(2),
  diagnosis_conditions1        VARCHAR2(2),
  diagnosis_conditions2        VARCHAR2(2),
  diagnosis_conditions3        VARCHAR2(2),
  diagnosis_conditions4        VARCHAR2(2),
  diagnosis_conditions5        VARCHAR2(2),
  emergency_times              VARCHAR2(2),
  emergency_successful_times   VARCHAR2(2),
  cp_status                    VARCHAR2(2),
  creat_user                   VARCHAR2(10),
  create_time                  VARCHAR2(19),
  modify_user                  VARCHAR2(10),
  modify_time                  VARCHAR2(19),
  valid                        NUMBER(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 2M
  );

prompt
prompt Creating table IEM_MAINPAGE_QC
prompt ==============================
prompt
create table EMR.IEM_MAINPAGE_QC
(
  id                   VARCHAR2(16),
  fields               VARCHAR2(64),
  tabletype            VARCHAR2(32),
  reductreason         VARCHAR2(256),
  fieldsvalue          VARCHAR2(64),
  conditionfields      VARCHAR2(64),
  conditionfieldsvalue VARCHAR2(64),
  reductscore          VARCHAR2(24),
  valide               VARCHAR2(2),
  conditiontabletype   VARCHAR2(32)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.IEM_MAINPAGE_QC.id
  is '��ţ������ظ�';
comment on column EMR.IEM_MAINPAGE_QC.fields
  is '�ж��ֶΣ�����ö��Ÿ�������Ϊ��';
comment on column EMR.IEM_MAINPAGE_QC.tabletype
  is '�жϱ�0-4����ʾ������ҳ�����ű�';
comment on column EMR.IEM_MAINPAGE_QC.reductreason
  is '�۷�ԭ��';
comment on column EMR.IEM_MAINPAGE_QC.fieldsvalue
  is '�ж��ֶ��Ƿ������ֵ��Ϊ����Ϊ�ǿ��ж�';
alter table EMR.IEM_MAINPAGE_QC
  add unique (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.IEM_MAINPAGE_QC
  add check (tabletype in('0','1','2','3','4'));

prompt
prompt Creating table ILLNESSHISTORY
prompt =============================
prompt
create table EMR.ILLNESSHISTORY
(
  id           NUMBER(9) not null,
  noofinpat    NUMBER(9) not null,
  diagnosisicd VARCHAR2(12) not null,
  discuss      VARCHAR2(255),
  diseasetime  VARCHAR2(24) not null,
  cure         INTEGER not null,
  memo         VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_ILLNESSHISTORYPATNOOFHIS on EMR.ILLNESSHISTORY (NOOFINPAT)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.ILLNESSHISTORY
  add constraint PK_ILLNESSHISTORYID primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table IMAGELIBRARY
prompt ===========================
prompt
create table EMR.IMAGELIBRARY
(
  id      NUMBER(12) not null,
  name    VARCHAR2(64) not null,
  content CLOB,
  memo    VARCHAR2(255),
  valid   INTEGER,
  image   BLOB default empty_blob()
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.IMAGELIBRARY
  add constraint PK_IMAGELIBRARY primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INCOMMONNOTE
prompt ===========================
prompt
create table EMR.INCOMMONNOTE
(
  incommonnoteflow VARCHAR2(50) not null,
  commonnoteflow   VARCHAR2(50),
  incommonnotename VARCHAR2(50),
  printemodelname  VARCHAR2(50),
  noofinpatient    VARCHAR2(50),
  inpatientname    VARCHAR2(50),
  currdepartid     VARCHAR2(50),
  currdepartname   VARCHAR2(50),
  currwardid       VARCHAR2(50),
  currwardname     VARCHAR2(50),
  createdoctorid   VARCHAR2(50),
  createdoctorname VARCHAR2(50),
  createdatetime   VARCHAR2(14),
  valide           VARCHAR2(1),
  checkdocid       VARCHAR2(20),
  checkdocname     VARCHAR2(20)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 4M
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.INCOMMONNOTE
  add constraint PK_INCOMMONNOTEFLOW primary key (INCOMMONNOTEFLOW)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 3M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INCOMMONNOTE_COLUMN
prompt ==================================
prompt
create table EMR.INCOMMONNOTE_COLUMN
(
  incommonnote_item_flow VARCHAR2(50) not null,
  rowflow                VARCHAR2(50),
  valuexml               CLOB,
  commonnote_item_flow   VARCHAR2(50),
  incommonnote_tab_flow  VARCHAR2(50),
  incommonnoteflow       VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1856M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.INCOMMONNOTE_COLUMN.incommonnote_item_flow
  is '����ͨ�õ���Ŀ��ˮ��(����)';
comment on column EMR.INCOMMONNOTE_COLUMN.rowflow
  is '����ˮ�� ͳһ����ˮ�� ˵����һ�м�¼';
comment on column EMR.INCOMMONNOTE_COLUMN.valuexml
  is 'ֵ��xml
<Value>
<Item id=����>aa</Item>
<Item id=����>aa</Item>
</Value>
';
create index EMR.PK_INCOMMNOTEFLOW on EMR.INCOMMONNOTE_COLUMN (INCOMMONNOTEFLOW)
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 328M
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.INCOMMONNOTE_COLUMN
  add constraint PK_INCOMMONNOTE_ITEM_FLOW primary key (INCOMMONNOTE_ITEM_FLOW)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 320M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INCOMMONNOTE_COLUMNHIS
prompt =====================================
prompt
create table EMR.INCOMMONNOTE_COLUMNHIS
(
  incommonnote_item_flow VARCHAR2(50) not null,
  hisrowflow             VARCHAR2(50),
  valuexml               CLOB,
  commonnote_item_flow   VARCHAR2(50),
  incommonnote_tab_flow  VARCHAR2(50),
  incommonnoteflow       VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.COLUMNHIS_HISROWFLOW on EMR.INCOMMONNOTE_COLUMNHIS (HISROWFLOW)
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 320K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INCOMMONNOTE_COLUMN_TYPE
prompt =======================================
prompt
create table EMR.INCOMMONNOTE_COLUMN_TYPE
(
  commonnote_item_flow  VARCHAR2(50) not null,
  incommonnote_tab_flow VARCHAR2(50) not null,
  dataelementflow       VARCHAR2(50),
  othername             VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 49M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.INCOMMONNOTE_COLUMN_TYPE.commonnote_item_flow
  is '����ʱ������ˮ�� ���ں��������ݹ���';
comment on column EMR.INCOMMONNOTE_COLUMN_TYPE.incommonnote_tab_flow
  is '����ͨ�õ���ǩ��ˮ��';
comment on column EMR.INCOMMONNOTE_COLUMN_TYPE.dataelementflow
  is '����Ԫ��ˮ��';
comment on column EMR.INCOMMONNOTE_COLUMN_TYPE.othername
  is '����';
alter table EMR.INCOMMONNOTE_COLUMN_TYPE
  add constraint PK_CITEMTABFLOW primary key (COMMONNOTE_ITEM_FLOW, INCOMMONNOTE_TAB_FLOW)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 34M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INCOMMONNOTE_ITEM
prompt ================================
prompt
create table EMR.INCOMMONNOTE_ITEM
(
  incommonnote_item_flow VARCHAR2(50) not null,
  incommonnote_tab_flow  VARCHAR2(50),
  incommonnoteflow       VARCHAR2(50),
  commonnote_item_flow   VARCHAR2(50),
  commonnote_tab_flow    VARCHAR2(50),
  commonnoteflow         VARCHAR2(50),
  dataelementflow        VARCHAR2(50),
  dataelementid          VARCHAR2(50),
  dataelementname        VARCHAR2(50),
  othername              VARCHAR2(50),
  ordercode              VARCHAR2(50),
  isvalidate             VARCHAR2(50),
  createdoctorid         VARCHAR2(50),
  createdoctorname       VARCHAR2(50),
  createdatetime         VARCHAR2(14),
  valide                 VARCHAR2(1),
  valuexml               CLOB,
  recorddate             VARCHAR2(10),
  recordtime             VARCHAR2(8),
  recorddoctorid         VARCHAR2(50),
  recorddoctorname       VARCHAR2(50),
  groupflow              VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 3445M
  );
create index EMR.IDX_INCOMMONNOTEFLOW on EMR.INCOMMONNOTE_ITEM (INCOMMONNOTEFLOW)
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 448M
  );
alter table EMR.INCOMMONNOTE_ITEM
  add constraint PK_INCOMMONITEM_FLOW primary key (INCOMMONNOTE_ITEM_FLOW)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 440M
  );

prompt
prompt Creating table INCOMMONNOTE_ROW
prompt ===============================
prompt
create table EMR.INCOMMONNOTE_ROW
(
  rowflow               VARCHAR2(50) not null,
  incommonnote_tab_flow VARCHAR2(50),
  incommonnoteflow      VARCHAR2(50),
  commonnote_tab_flow   VARCHAR2(50),
  commonnoteflow        VARCHAR2(50),
  createdoctorid        VARCHAR2(50),
  createdoctorname      VARCHAR2(50),
  createdatetime        VARCHAR2(14),
  valide                VARCHAR2(1),
  recorddate            VARCHAR2(10),
  recordtime            VARCHAR2(8),
  recorddoctorid        VARCHAR2(50),
  recorddoctorname      VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 80M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.INCOMMONNOTE_ROW.rowflow
  is '����ˮ�� ͳһ����ˮ�� ˵����һ�м�¼';
comment on column EMR.INCOMMONNOTE_ROW.incommonnote_tab_flow
  is '����ͨ�õ���ǩ��ˮ�� �ȱ�';
comment on column EMR.INCOMMONNOTE_ROW.incommonnoteflow
  is '����ͨ�õ���ˮ�ţ������';
comment on column EMR.INCOMMONNOTE_ROW.commonnote_tab_flow
  is 'ͨ�õ���ǩ��ˮ�ţ������';
comment on column EMR.INCOMMONNOTE_ROW.commonnoteflow
  is 'ͨ�õ���ˮ��';
comment on column EMR.INCOMMONNOTE_ROW.createdoctorid
  is '������ID';
comment on column EMR.INCOMMONNOTE_ROW.createdoctorname
  is '����������';
comment on column EMR.INCOMMONNOTE_ROW.createdatetime
  is '����ʱ��';
comment on column EMR.INCOMMONNOTE_ROW.valide
  is '1ʹ�� 0��ʹ��';
comment on column EMR.INCOMMONNOTE_ROW.recorddate
  is '��¼����';
comment on column EMR.INCOMMONNOTE_ROW.recordtime
  is '��¼ʱ��';
comment on column EMR.INCOMMONNOTE_ROW.recorddoctorid
  is '��¼��ID';
comment on column EMR.INCOMMONNOTE_ROW.recorddoctorname
  is '��¼������';
create index EMR.INDEX_INCOMMONNOTEFLOW on EMR.INCOMMONNOTE_ROW (INCOMMONNOTEFLOW)
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 15M
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.INCOMMONNOTE_ROW
  add constraint PK_ROWFLOW primary key (ROWFLOW)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 14M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INCOMMONNOTE_ROWHIS
prompt ==================================
prompt
create table EMR.INCOMMONNOTE_ROWHIS
(
  historyflow      VARCHAR2(50) not null,
  rowflow          VARCHAR2(50),
  createdoctorid   VARCHAR2(50),
  createdoctorname VARCHAR2(50),
  createdatetime   VARCHAR2(14),
  recorddate       VARCHAR2(10),
  recordtime       VARCHAR2(8),
  recorddoctorid   VARCHAR2(50),
  recorddoctorname VARCHAR2(50),
  valide           VARCHAR2(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.PK_ROWHIS_ROWFLOW on EMR.INCOMMONNOTE_ROWHIS (ROWFLOW)
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.INCOMMONNOTE_ROWHIS
  add constraint PK_ROWHIS_FLOW primary key (HISTORYFLOW)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INCOMMONNOTE_TAB
prompt ===============================
prompt
create table EMR.INCOMMONNOTE_TAB
(
  incommonnote_tab_flow VARCHAR2(50) not null,
  commonnote_tab_flow   VARCHAR2(50),
  incommonnoteflow      VARCHAR2(50),
  commonnotetabname     VARCHAR2(50),
  usingrole             VARCHAR2(50),
  showtype              VARCHAR2(50),
  ordercode             VARCHAR2(50),
  createdoctorid        VARCHAR2(50),
  createdoctorname      VARCHAR2(50),
  createdatetime        VARCHAR2(14),
  valide                VARCHAR2(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 4M
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.INCOMMONNOTE_TAB
  add constraint PK_INCOMMTAB_FLOW primary key (INCOMMONNOTE_TAB_FLOW)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INCOMMONPRINTFROMPAGE
prompt ====================================
prompt
create table EMR.INCOMMONPRINTFROMPAGE
(
  incommonnoteflow VARCHAR2(50) not null,
  pagefrom         VARCHAR2(50) not null
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.INCOMMONPRINTFROMPAGE
  add constraint PK_PAGEFROMINCOMMFLOW primary key (INCOMMONNOTEFLOW)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INFECTNPCC
prompt =========================
prompt
create table EMR.INFECTNPCC
(
  npccid   VARCHAR2(50) not null,
  npccname VARCHAR2(50),
  py       VARCHAR2(50),
  wb       VARCHAR2(50),
  vaild    VARCHAR2(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 3M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.INFECTNPCC.npccid
  is 'ʡ���ش���';
comment on column EMR.INFECTNPCC.npccname
  is '����';
comment on column EMR.INFECTNPCC.py
  is 'ƴ��';
comment on column EMR.INFECTNPCC.wb
  is '���';
comment on column EMR.INFECTNPCC.vaild
  is '��Ч��ʶ 1 ��Ч 0��Ч';
alter table EMR.INFECTNPCC
  add constraint PK_NPCCID primary key (NPCCID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INPATIENT
prompt ========================
prompt
create table EMR.INPATIENT
(
  noofinpat          NUMBER(9) not null,
  patnoofhis         VARCHAR2(32) not null,
  noofclinic         VARCHAR2(32),
  noofrecord         VARCHAR2(32) not null,
  patid              VARCHAR2(32) not null,
  innerpix           VARCHAR2(32),
  outpix             VARCHAR2(32),
  name               VARCHAR2(32) not null,
  py                 VARCHAR2(8),
  wb                 VARCHAR2(8),
  payid              VARCHAR2(4),
  origin             VARCHAR2(4),
  incount            INTEGER,
  sexid              VARCHAR2(4),
  birth              CHAR(19),
  age                INTEGER,
  agestr             VARCHAR2(16),
  idno               VARCHAR2(18),
  marital            VARCHAR2(12),
  jobid              VARCHAR2(20),
  provinceid         VARCHAR2(64),
  countyid           VARCHAR2(10),
  nationid           VARCHAR2(4),
  nationalityid      VARCHAR2(4),
  nativeplace_p      VARCHAR2(64),
  nativeplace_c      VARCHAR2(10),
  organization       VARCHAR2(64),
  officeplace        VARCHAR2(64),
  officetel          VARCHAR2(64),
  officepost         VARCHAR2(64),
  nativeaddress      VARCHAR2(64),
  nativetel          VARCHAR2(64),
  nativepost         VARCHAR2(32),
  address            VARCHAR2(255),
  contactperson      VARCHAR2(32),
  relationship       VARCHAR2(4),
  contactaddress     VARCHAR2(255),
  contactoffice      VARCHAR2(64),
  contacttel         VARCHAR2(100),
  contactpost        VARCHAR2(16),
  offerer            VARCHAR2(64),
  socialcare         VARCHAR2(64),
  insurance          VARCHAR2(64),
  cardno             VARCHAR2(64),
  admitinfo          VARCHAR2(4),
  admitdept          VARCHAR2(12),
  admitward          VARCHAR2(12),
  admitbed           VARCHAR2(12),
  admitdate          CHAR(19) not null,
  inwarddate         CHAR(19),
  admitdiagnosis     VARCHAR2(100),
  outhosdept         VARCHAR2(12),
  outhosward         VARCHAR2(12),
  outbed             VARCHAR2(12),
  outwarddate        CHAR(19),
  outhosdate         CHAR(19),
  outdiagnosis       VARCHAR2(100),
  totaldays          NUMBER(6,1),
  clinicdiagnosis    VARCHAR2(100),
  solarterms         VARCHAR2(16),
  admitway           VARCHAR2(4),
  outway             VARCHAR2(4),
  clinicdoctor       VARCHAR2(20),
  resident           VARCHAR2(6),
  attend             VARCHAR2(6),
  chief              VARCHAR2(6),
  edu                VARCHAR2(4),
  educ               NUMBER(10,2),
  religion           VARCHAR2(32),
  status             INTEGER not null,
  criticallevel      VARCHAR2(2),
  attendlevel        VARCHAR2(12),
  emphasis           INTEGER,
  isbaby             INTEGER,
  mother             NUMBER(9),
  medicareid         VARCHAR2(12),
  medicarequota      NUMBER(10,4),
  voucherscode       VARCHAR2(12),
  style              VARCHAR2(2),
  operator           VARCHAR2(6),
  memo               VARCHAR2(64),
  cpstatus           INTEGER,
  outwardbed         INTEGER,
  districtid         VARCHAR2(10),
  xzzproviceid       VARCHAR2(10),
  xzzcityid          VARCHAR2(10),
  xzzdistrictid      VARCHAR2(10),
  xzztel             VARCHAR2(50),
  xzzpost            VARCHAR2(16),
  hkdzproviceid      VARCHAR2(10),
  hkzdcityid         VARCHAR2(10),
  hkzddistrictid     VARCHAR2(10),
  babycount          INTEGER,
  csdaddress         VARCHAR2(500),
  jgaddress          VARCHAR2(500),
  xzzaddress         VARCHAR2(500),
  hkaddress          VARCHAR2(500),
  xzzdetailaddress   VARCHAR2(300),
  hkdzdetailaddress  VARCHAR2(300),
  changedeptdatetime CHAR(19),
  deathdatetime      CHAR(19),
  islock             INTEGER default 4700,
  emrouthos          CHAR(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 60M
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column EMR.INPATIENT.noofinpat
  is '��ҳ���';
comment on column EMR.INPATIENT.patnoofhis
  is 'HIS��ҳ���(HIS�в���ÿ��סԺ��Ψһ��ʶ,��ӦHIS�е�syxh)';
comment on column EMR.INPATIENT.noofclinic
  is '�������';
comment on column EMR.INPATIENT.noofrecord
  is '��������';
comment on column EMR.INPATIENT.patid
  is 'סԺ����';
comment on column EMR.INPATIENT.innerpix
  is '�ڲ�����ֵ(������ʶͬһ���˶����Ժ��סԺ�Ų�һ�������,Ŀǰ�Ǹ����籣���ù���)';
comment on column EMR.INPATIENT.outpix
  is '�ⲿ����ֵ(������ʶͬһ���˶����Ժ��סԺ�Ų�һ�������,Ŀǰ�Ǹ����籣���ù���)';
comment on column EMR.INPATIENT.name
  is '��������';
comment on column EMR.INPATIENT.py
  is 'ƴ��(����������д)';
comment on column EMR.INPATIENT.wb
  is '���(����������д)';
comment on column EMR.INPATIENT.payid
  is '��������(�� ҽ�Ƹ��ʽ)';
comment on column EMR.INPATIENT.origin
  is '������Դ';
comment on column EMR.INPATIENT.incount
  is '��Ժ����';
comment on column EMR.INPATIENT.sexid
  is '�����Ա�';
comment on column EMR.INPATIENT.birth
  is '��������';
comment on column EMR.INPATIENT.age
  is '��������';
comment on column EMR.INPATIENT.agestr
  is '��ʾ����';
comment on column EMR.INPATIENT.idno
  is '���֤��';
comment on column EMR.INPATIENT.marital
  is '����״��';
comment on column EMR.INPATIENT.jobid
  is 'ְҵ����';
comment on column EMR.INPATIENT.provinceid
  is '(������)ʡ�д���';
comment on column EMR.INPATIENT.countyid
  is '(������)���ش���';
comment on column EMR.INPATIENT.nationid
  is '�������';
comment on column EMR.INPATIENT.nationalityid
  is '��������';
comment on column EMR.INPATIENT.nativeplace_p
  is '����ʡ�д���';
comment on column EMR.INPATIENT.nativeplace_c
  is '�������ش���';
comment on column EMR.INPATIENT.organization
  is '������λ(��ȱ)';
comment on column EMR.INPATIENT.officeplace
  is '��λ��ַ';
comment on column EMR.INPATIENT.officetel
  is '��λ�绰';
comment on column EMR.INPATIENT.officepost
  is '��λ�ʱ�';
comment on column EMR.INPATIENT.nativeaddress
  is '���ڵ�ַ';
comment on column EMR.INPATIENT.nativetel
  is '���ڵ绰';
comment on column EMR.INPATIENT.nativepost
  is '�����ʱ�';
comment on column EMR.INPATIENT.address
  is '��ǰ��ַ';
comment on column EMR.INPATIENT.contactperson
  is '��ϵ����';
comment on column EMR.INPATIENT.relationship
  is '��ϵ��ϵ';
comment on column EMR.INPATIENT.contactaddress
  is '��ϵ��ַ';
comment on column EMR.INPATIENT.contactoffice
  is '��ϵ(��)��λ';
comment on column EMR.INPATIENT.contacttel
  is '��ϵ�绰';
comment on column EMR.INPATIENT.contactpost
  is '��ϵ�ʱ�';
comment on column EMR.INPATIENT.offerer
  is '��ʷ������';
comment on column EMR.INPATIENT.socialcare
  is '�籣����';
comment on column EMR.INPATIENT.insurance
  is '���տ���';
comment on column EMR.INPATIENT.cardno
  is '��������(��ſ���)';
comment on column EMR.INPATIENT.admitinfo
  is '��Ժ���(��Ժʱ����)';
comment on column EMR.INPATIENT.admitdept
  is '��Ժ����';
comment on column EMR.INPATIENT.admitward
  is '��Ժ����';
comment on column EMR.INPATIENT.admitbed
  is '��Ժ��λ';
comment on column EMR.INPATIENT.admitdate
  is '��Ժ����';
comment on column EMR.INPATIENT.inwarddate
  is '��������';
comment on column EMR.INPATIENT.admitdiagnosis
  is '��Ժ���';
comment on column EMR.INPATIENT.outhosdept
  is '��Ժ����';
comment on column EMR.INPATIENT.outhosward
  is '��Ժ����';
comment on column EMR.INPATIENT.outbed
  is '��Ժ��λ';
comment on column EMR.INPATIENT.outwarddate
  is '��������';
comment on column EMR.INPATIENT.outhosdate
  is '��Ժ����';
comment on column EMR.INPATIENT.outdiagnosis
  is '��Ժ���';
comment on column EMR.INPATIENT.totaldays
  is 'סԺ����';
comment on column EMR.INPATIENT.clinicdiagnosis
  is '�������';
comment on column EMR.INPATIENT.solarterms
  is '��������';
comment on column EMR.INPATIENT.admitway
  is '��Ժ;��';
comment on column EMR.INPATIENT.outway
  is '��Ժ��ʽ';
comment on column EMR.INPATIENT.clinicdoctor
  is '����ҽ��';
comment on column EMR.INPATIENT.resident
  is 'סԺҽʦ����';
comment on column EMR.INPATIENT.attend
  is '����ҽʦ����';
comment on column EMR.INPATIENT.chief
  is '����ҽʦ����';
comment on column EMR.INPATIENT.edu
  is '�Ļ��̶�';
comment on column EMR.INPATIENT.educ
  is '(��)��������(��λ:��)';
comment on column EMR.INPATIENT.religion
  is '�ڽ�����';
comment on column EMR.INPATIENT.status
  is '����״̬';
comment on column EMR.INPATIENT.criticallevel
  is 'Σ�ؼ���';
comment on column EMR.INPATIENT.attendlevel
  is '������';
comment on column EMR.INPATIENT.emphasis
  is '�ص㲡��';
comment on column EMR.INPATIENT.isbaby
  is 'Ӥ�����(��1��ʼ��0��ʾ����Ӥ��)';
comment on column EMR.INPATIENT.mother
  is 'ĸ����ҳ���';
comment on column EMR.INPATIENT.medicareid
  is 'ҽ������';
comment on column EMR.INPATIENT.medicarequota
  is 'ҽ������';
comment on column EMR.INPATIENT.voucherscode
  is 'ƾ֤����(����)';
comment on column EMR.INPATIENT.style
  is '��������';
comment on column EMR.INPATIENT.operator
  is '����Ա';
comment on column EMR.INPATIENT.memo
  is '��ע';
comment on column EMR.INPATIENT.cpstatus
  is '�ٴ�·����״̬';
comment on column EMR.INPATIENT.outwardbed
  is '��ȥ��λ';
comment on column EMR.INPATIENT.districtid
  is '(������)���ֶ�';
comment on column EMR.INPATIENT.xzzproviceid
  is '��סַʡ';
comment on column EMR.INPATIENT.xzzcityid
  is '��סַ��';
comment on column EMR.INPATIENT.xzzdistrictid
  is '��סַ��';
comment on column EMR.INPATIENT.xzztel
  is '��סַ�绰';
comment on column EMR.INPATIENT.xzzpost
  is '��סַ�ʱ�';
comment on column EMR.INPATIENT.hkdzproviceid
  is '����סַʡ';
comment on column EMR.INPATIENT.hkzdcityid
  is '����סַ��';
comment on column EMR.INPATIENT.hkzddistrictid
  is '����סַ��';
create index EMR.IDX_INPATIENT_PATID on EMR.INPATIENT (PATID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 5M
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_INPATIENT_SOCIALCARE on EMR.INPATIENT (SOCIALCARE)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.INPATIENT
  add constraint PK_INPATIENT primary key (NOOFINPAT)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 5M
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.INPATIENT
  add constraint IDX_PATNOOFHIS unique (PATNOOFHIS)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 4M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INPATIENTCHANGEINFO
prompt ==================================
prompt
create table EMR.INPATIENTCHANGEINFO
(
  id          NUMBER(12) not null,
  noofinpat   NUMBER(9) not null,
  newdeptid   VARCHAR2(12),
  newwardid   VARCHAR2(12),
  newbedid    VARCHAR2(12),
  olddeptid   VARCHAR2(12),
  oldwardid   VARCHAR2(12),
  oldbedid    VARCHAR2(12),
  changestyle CHAR(1),
  createuser  VARCHAR2(6),
  createtime  CHAR(19),
  modifyuser  VARCHAR2(6),
  modifytime  CHAR(19),
  valid       NUMBER(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 25M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.INPATIENTCHANGEINFO.id
  is 'Ψһ��ʶ(����)';
comment on column EMR.INPATIENTCHANGEINFO.noofinpat
  is '��ҳ���';
comment on column EMR.INPATIENTCHANGEINFO.newdeptid
  is 'ת�ƺ�Ŀ��ұ��';
comment on column EMR.INPATIENTCHANGEINFO.newwardid
  is 'ת������Ĳ������';
comment on column EMR.INPATIENTCHANGEINFO.newbedid
  is 'ת����Ĵ�λ���';
comment on column EMR.INPATIENTCHANGEINFO.olddeptid
  is 'ת��ǰ�Ŀ��ұ��';
comment on column EMR.INPATIENTCHANGEINFO.oldwardid
  is 'ת����ǰ�Ĳ������';
comment on column EMR.INPATIENTCHANGEINFO.oldbedid
  is 'ת��ǰ�Ĵ�λ���';
comment on column EMR.INPATIENTCHANGEINFO.changestyle
  is '����   0�����  1��ת��  2��ת����  3��ת��';
comment on column EMR.INPATIENTCHANGEINFO.createuser
  is '��¼������';
comment on column EMR.INPATIENTCHANGEINFO.createtime
  is '��¼����ʱ��';
comment on column EMR.INPATIENTCHANGEINFO.modifyuser
  is '��¼�޸���';
comment on column EMR.INPATIENTCHANGEINFO.modifytime
  is '��¼�޸�ʱ��';
comment on column EMR.INPATIENTCHANGEINFO.valid
  is '��Ч��־ 0:��Ч 1:��Ч';
alter table EMR.INPATIENTCHANGEINFO
  add constraint PK_INPATIENTCHANGEINFO primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 4M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INPATIENTREPORT
prompt ==============================
prompt
create table EMR.INPATIENTREPORT
(
  id            NUMBER(12) not null,
  hospitalno    NUMBER(12) not null,
  noofinpat     NUMBER(12) not null,
  reportcatalog VARCHAR2(3) not null,
  reporttype    VARCHAR2(10) not null,
  reportno      NUMBER(12) not null,
  reportname    VARCHAR2(64) not null,
  submitdate    VARCHAR2(24),
  releasedate   VARCHAR2(24),
  hadread       INTEGER,
  submitdocid   NUMBER(12) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.INPATIENTREPORT
  add constraint PK_INPATIENTREPORT primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table INPATIENTREPORTLISRESLUT
prompt =======================================
prompt
create table EMR.INPATIENTREPORTLISRESLUT
(
  id          NUMBER(12) not null,
  reportid    NUMBER(12) not null,
  line        INTEGER not null,
  itemcode    NUMBER(12) not null,
  itemname    VARCHAR2(64) not null,
  result      VARCHAR2(200),
  refervalue  VARCHAR2(50),
  unit        VARCHAR2(20),
  highflag    VARCHAR2(10),
  resultcolor VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.INPATIENTREPORTLISRESLUT
  add constraint PK_INPATIENTREPORTLISRESLUT primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table INPATIENTREPORTRISRESLUT
prompt =======================================
prompt
create table EMR.INPATIENTREPORTRISRESLUT
(
  id       NUMBER(12) not null,
  reportid NUMBER(12) not null,
  line     VARCHAR2(64) not null,
  itemname VARCHAR2(64) not null,
  result   VARCHAR2(4000)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.INPATIENTREPORTRISRESLUT
  add constraint PK_INPATIENTREPORTRISRESLUT primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table INPATIENT_CLINIC
prompt ===============================
prompt
create table EMR.INPATIENT_CLINIC
(
  noofinpatclinic NUMBER(9) not null,
  patnoofhis      NVARCHAR2(14) not null,
  patid           NVARCHAR2(32) not null,
  visittype       NVARCHAR2(4) not null,
  name            NVARCHAR2(32) not null,
  sexid           NVARCHAR2(4),
  birth           DATE,
  age             NVARCHAR2(16),
  maritalid       NVARCHAR2(4),
  visitno         NVARCHAR2(16),
  visittime       DATE,
  roomcode        NVARCHAR2(16),
  roomname        NVARCHAR2(32),
  deptid          NVARCHAR2(12) not null,
  createtime      DATE not null,
  createuserid    NVARCHAR2(6) not null,
  valid           NVARCHAR2(1) not null,
  nationality     NVARCHAR2(32),
  country         NVARCHAR2(32),
  healthcardid    NVARCHAR2(32),
  contactaddress  NVARCHAR2(32),
  visitdoctorid   NVARCHAR2(6),
  jobid           NVARCHAR2(6),
  jobname         NVARCHAR2(32),
  bedcode         NVARCHAR2(6)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.INPATIENT_CLINIC
  is '���ﲡ�˵ǼǱ�';
comment on column EMR.INPATIENT_CLINIC.noofinpatclinic
  is '������������Ӳ����е�Ψһ���';
comment on column EMR.INPATIENT_CLINIC.patnoofhis
  is '������HIS�е�Ψһ��ţ�Ψһ�ı�ʾ���ξ��HIS�в��˵�Ψһ��š�';
comment on column EMR.INPATIENT_CLINIC.patid
  is '�����ţ��˲��˶�ξ���ʹ����ͬ��š�HIS�в��˵ı�ţ����ڶ�ξ�����жϡ�';
comment on column EMR.INPATIENT_CLINIC.visittype
  is '��ǰ��������  dictionary_detail.categoryid = 13  1301:����  1302:����';
comment on column EMR.INPATIENT_CLINIC.name
  is '��������';
comment on column EMR.INPATIENT_CLINIC.sexid
  is '�����Ա�      dictionary_detail.categoryid = 3  1:��  2:Ů 3:δ֪';
comment on column EMR.INPATIENT_CLINIC.birth
  is '���˳�������';
comment on column EMR.INPATIENT_CLINIC.age
  is '�������� ���ַ������͡�';
comment on column EMR.INPATIENT_CLINIC.maritalid
  is '���˻���״��     dictionary_detail.categoryid = 4  1:δ�� 2:�ѻ� 3:ɥż 4:���� 9:����';
comment on column EMR.INPATIENT_CLINIC.visitno
  is '���˾����';
comment on column EMR.INPATIENT_CLINIC.visittime
  is '����ʱ��';
comment on column EMR.INPATIENT_CLINIC.roomcode
  is '�����';
comment on column EMR.INPATIENT_CLINIC.roomname
  is '�������';
comment on column EMR.INPATIENT_CLINIC.deptid
  is '������ұ�� ';
comment on column EMR.INPATIENT_CLINIC.createtime
  is '����ʱ�� ��ǰϵͳʱ��';
comment on column EMR.INPATIENT_CLINIC.createuserid
  is '�����˴˼�¼��Ա�Ĺ���';
comment on column EMR.INPATIENT_CLINIC.valid
  is '�Ƿ���Ч 1����Ч 0����Ч';
comment on column EMR.INPATIENT_CLINIC.nationality
  is '�������ı�ʾ';
comment on column EMR.INPATIENT_CLINIC.country
  is '�������ı�ʾ';
comment on column EMR.INPATIENT_CLINIC.healthcardid
  is 'ҽ������';
comment on column EMR.INPATIENT_CLINIC.contactaddress
  is 'ͨѶ��ַ';
comment on column EMR.INPATIENT_CLINIC.visitdoctorid
  is '����ҽʦ����';
comment on column EMR.INPATIENT_CLINIC.jobid
  is 'ְҵ��� ��HIS�еı�š�';
comment on column EMR.INPATIENT_CLINIC.jobname
  is 'ְҵ���� ��HIS�е����ơ�';
comment on column EMR.INPATIENT_CLINIC.bedcode
  is '���˴��� ����������';
create index EMR.INK_INP_CLINIC_PATID on EMR.INPATIENT_CLINIC (PATID)
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.INPATIENT_CLINIC
  add constraint PK_INPATIENT_CLINIC primary key (NOOFINPATCLINIC)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.INPATIENT_CLINIC
  add constraint UQ_INP_CLINIC_HISID unique (PATNOOFHIS, VISITTYPE)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INPATIENT_DEFAULT
prompt ================================
prompt
create table EMR.INPATIENT_DEFAULT
(
  noofinpat       NUMBER(9),
  patnoofhis      VARCHAR2(14),
  noofclinic      VARCHAR2(32),
  noofrecord      VARCHAR2(32),
  patid           VARCHAR2(32),
  innerpix        VARCHAR2(32),
  outpix          VARCHAR2(32),
  name            VARCHAR2(32),
  py              VARCHAR2(8),
  wb              VARCHAR2(8),
  payid           VARCHAR2(4),
  origin          VARCHAR2(4),
  incount         INTEGER,
  sexid           VARCHAR2(4),
  birth           CHAR(19),
  age             INTEGER,
  agestr          VARCHAR2(16),
  idno            VARCHAR2(18),
  marital         VARCHAR2(12),
  jobid           VARCHAR2(4),
  provinceid      VARCHAR2(10),
  countyid        VARCHAR2(10),
  nationid        VARCHAR2(4),
  nationalityid   VARCHAR2(4),
  nativeplace_p   VARCHAR2(10),
  nativeplace_c   VARCHAR2(10),
  organization    VARCHAR2(64),
  officeplace     VARCHAR2(64),
  officetel       VARCHAR2(16),
  officepost      VARCHAR2(16),
  nativeaddress   VARCHAR2(64),
  nativetel       VARCHAR2(16),
  nativepost      VARCHAR2(16),
  address         VARCHAR2(255),
  contactperson   VARCHAR2(32),
  relationship    VARCHAR2(4),
  contactaddress  VARCHAR2(255),
  contactoffice   VARCHAR2(64),
  contacttel      VARCHAR2(16),
  contactpost     VARCHAR2(16),
  offerer         VARCHAR2(64),
  socialcare      VARCHAR2(32),
  insurance       VARCHAR2(32),
  cardno          VARCHAR2(32),
  admitinfo       VARCHAR2(4),
  admitdept       VARCHAR2(12),
  admitward       VARCHAR2(12),
  admitbed        VARCHAR2(12),
  admitdate       CHAR(19),
  inwarddate      CHAR(19),
  admitdiagnosis  VARCHAR2(12),
  outhosdept      VARCHAR2(12),
  outhosward      VARCHAR2(12),
  outbed          VARCHAR2(12),
  outwarddate     CHAR(19),
  outhosdate      CHAR(19),
  outdiagnosis    VARCHAR2(12),
  totaldays       NUMBER(6,1),
  clinicdiagnosis VARCHAR2(12),
  solarterms      VARCHAR2(16),
  admitway        VARCHAR2(4),
  outway          VARCHAR2(4),
  clinicdoctor    VARCHAR2(6),
  resident        VARCHAR2(6),
  attend          VARCHAR2(6),
  chief           VARCHAR2(6),
  edu             VARCHAR2(4),
  educ            NUMBER(10,2),
  religion        VARCHAR2(32),
  status          INTEGER,
  criticallevel   VARCHAR2(2),
  attendlevel     VARCHAR2(12),
  emphasis        INTEGER,
  isbaby          INTEGER,
  mother          NUMBER(9),
  medicareid      VARCHAR2(12),
  medicarequota   NUMBER(10,4),
  voucherscode    VARCHAR2(12),
  style           VARCHAR2(2),
  operator        VARCHAR2(6),
  memo            VARCHAR2(64),
  cpstatus        INTEGER,
  outwardbed      INTEGER,
  districtid      VARCHAR2(10),
  xzzproviceid    VARCHAR2(10),
  xzzcityid       VARCHAR2(10),
  xzzdistrictid   VARCHAR2(10),
  xzztel          VARCHAR2(16),
  hkdzproviceid   VARCHAR2(10),
  hkzdcityid      VARCHAR2(10),
  hkzddistrictid  VARCHAR2(10),
  xzzpost         VARCHAR2(16),
  csdaddress      VARCHAR2(500),
  jgaddress       VARCHAR2(500),
  xzzaddress      VARCHAR2(500),
  hkaddress       VARCHAR2(500)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.INPATIENT_DEFAULT.noofinpat
  is '��ҳ���(סԺ��ˮ��)';
comment on column EMR.INPATIENT_DEFAULT.patnoofhis
  is 'HIS��ҳ���(HIS�в���ÿ��סԺ��Ψһ��ʶ,��ӦHIS�е�syxh)';
comment on column EMR.INPATIENT_DEFAULT.noofclinic
  is '�������';
comment on column EMR.INPATIENT_DEFAULT.noofrecord
  is '��������';
comment on column EMR.INPATIENT_DEFAULT.patid
  is 'סԺ����';
comment on column EMR.INPATIENT_DEFAULT.innerpix
  is '�ڲ�����ֵ(������ʶͬһ���˶����Ժ��סԺ�Ų�һ�������,Ŀǰ�Ǹ����籣���ù���)';
comment on column EMR.INPATIENT_DEFAULT.outpix
  is '�ⲿ����ֵ(������ʶͬһ���˶����Ժ��סԺ�Ų�һ�������,Ŀǰ�Ǹ����籣���ù���)';
comment on column EMR.INPATIENT_DEFAULT.name
  is '��������';
comment on column EMR.INPATIENT_DEFAULT.py
  is 'ƴ��(����������д)';
comment on column EMR.INPATIENT_DEFAULT.wb
  is '���(����������д)';
comment on column EMR.INPATIENT_DEFAULT.payid
  is '��������(�� ҽ�Ƹ��ʽ)(Dictionary_detail,CategoryID= ''1'')';
comment on column EMR.INPATIENT_DEFAULT.origin
  is '������Դ(Dictionary_detail,CategoryID= ''2'')';
comment on column EMR.INPATIENT_DEFAULT.incount
  is '��Ժ����';
comment on column EMR.INPATIENT_DEFAULT.sexid
  is '�����Ա�(Dictionary_detail.Name,CategoryID ''3'')';
comment on column EMR.INPATIENT_DEFAULT.birth
  is '��������';
comment on column EMR.INPATIENT_DEFAULT.age
  is '��������';
comment on column EMR.INPATIENT_DEFAULT.agestr
  is '��ʾ����';
comment on column EMR.INPATIENT_DEFAULT.idno
  is '���֤��';
comment on column EMR.INPATIENT_DEFAULT.marital
  is '����״��(Dictionary_detail,CategoryID= ''4'')';
comment on column EMR.INPATIENT_DEFAULT.jobid
  is 'ְҵ����(Dictionary_detail,CategoryID= ''41'')';
comment on column EMR.INPATIENT_DEFAULT.provinceid
  is '(������)ʡ�д���(Areas.ID,Category=1000)';
comment on column EMR.INPATIENT_DEFAULT.countyid
  is '(������)���ش���(Areas.ID,Category=1001)';
comment on column EMR.INPATIENT_DEFAULT.nationid
  is '�������(Dictionary_detail,CategoryID= ''42'')';
comment on column EMR.INPATIENT_DEFAULT.nationalityid
  is '��������(Dictionary_detail,CategoryID= ''43'')';
comment on column EMR.INPATIENT_DEFAULT.nativeplace_p
  is '����ʡ�д���(Areas.ID,Category=1000)';
comment on column EMR.INPATIENT_DEFAULT.nativeplace_c
  is '�������ش���(Areas.ID,Category=1001)';
comment on column EMR.INPATIENT_DEFAULT.organization
  is '������λ(��ȱ)';
comment on column EMR.INPATIENT_DEFAULT.officeplace
  is '��λ��ַ';
comment on column EMR.INPATIENT_DEFAULT.officetel
  is '��λ�绰';
comment on column EMR.INPATIENT_DEFAULT.officepost
  is '��λ�ʱ�';
comment on column EMR.INPATIENT_DEFAULT.nativeaddress
  is '���ڵ�ַ';
comment on column EMR.INPATIENT_DEFAULT.nativetel
  is '���ڵ绰';
comment on column EMR.INPATIENT_DEFAULT.nativepost
  is '�����ʱ�';
comment on column EMR.INPATIENT_DEFAULT.address
  is '��ǰ��ַ';
comment on column EMR.INPATIENT_DEFAULT.contactperson
  is '��ϵ����';
comment on column EMR.INPATIENT_DEFAULT.relationship
  is '��ϵ��ϵ(Dictionary_detail,CategoryID= ''44'')';
comment on column EMR.INPATIENT_DEFAULT.contactaddress
  is '��ϵ��ַ';
comment on column EMR.INPATIENT_DEFAULT.contactoffice
  is '��ϵ(��)��λ';
comment on column EMR.INPATIENT_DEFAULT.contacttel
  is '��ϵ�绰';
comment on column EMR.INPATIENT_DEFAULT.contactpost
  is '��ϵ�ʱ�';
comment on column EMR.INPATIENT_DEFAULT.offerer
  is '��ʷ������';
comment on column EMR.INPATIENT_DEFAULT.socialcare
  is '�籣����';
comment on column EMR.INPATIENT_DEFAULT.insurance
  is '���տ���';
comment on column EMR.INPATIENT_DEFAULT.cardno
  is '��������(��ſ���)';
comment on column EMR.INPATIENT_DEFAULT.admitinfo
  is '��Ժ���(��Ժʱ����, Dictionary_detail,CategoryID= ''5'')';
comment on column EMR.INPATIENT_DEFAULT.admitdept
  is '��Ժ����(Department.ID)';
comment on column EMR.INPATIENT_DEFAULT.admitward
  is '��Ժ����(Ward.IDm)';
comment on column EMR.INPATIENT_DEFAULT.admitbed
  is '��Ժ��λ(Bed.cwdm)';
comment on column EMR.INPATIENT_DEFAULT.admitdate
  is '��Ժ����';
comment on column EMR.INPATIENT_DEFAULT.inwarddate
  is '��������';
comment on column EMR.INPATIENT_DEFAULT.admitdiagnosis
  is '��Ժ���(Diagnosis.zddm)';
comment on column EMR.INPATIENT_DEFAULT.outhosdept
  is '��Ժ����(Department.ID)';
comment on column EMR.INPATIENT_DEFAULT.outhosward
  is '��Ժ����(Ward.IDm)';
comment on column EMR.INPATIENT_DEFAULT.outbed
  is '��Ժ��λ(Bed.cwdm)';
comment on column EMR.INPATIENT_DEFAULT.outwarddate
  is '��������';
comment on column EMR.INPATIENT_DEFAULT.outhosdate
  is '��Ժ����';
comment on column EMR.INPATIENT_DEFAULT.outdiagnosis
  is '��Ժ���';
comment on column EMR.INPATIENT_DEFAULT.totaldays
  is 'סԺ����';
comment on column EMR.INPATIENT_DEFAULT.clinicdiagnosis
  is '�������';
comment on column EMR.INPATIENT_DEFAULT.solarterms
  is '��������';
comment on column EMR.INPATIENT_DEFAULT.admitway
  is '��Ժ;��(Dictionary_detail,CategoryID= ''6'')';
comment on column EMR.INPATIENT_DEFAULT.outway
  is '��Ժ��ʽ(Dictionary_detail,CategoryID= ''15'')  ';
comment on column EMR.INPATIENT_DEFAULT.clinicdoctor
  is '����ҽ��(Users.ID)';
comment on column EMR.INPATIENT_DEFAULT.resident
  is 'סԺҽʦ����(Users.ID)';
comment on column EMR.INPATIENT_DEFAULT.attend
  is '����ҽʦ����(Users.ID)';
comment on column EMR.INPATIENT_DEFAULT.chief
  is '����ҽʦ����(Users.ID)';
comment on column EMR.INPATIENT_DEFAULT.edu
  is '�Ļ��̶�(Dictionary_detail,CategoryID= ''25'')';
comment on column EMR.INPATIENT_DEFAULT.educ
  is '(��)��������(��λ:��)';
comment on column EMR.INPATIENT_DEFAULT.religion
  is '�ڽ�����';
comment on column EMR.INPATIENT_DEFAULT.status
  is '����״̬(CategoryDetail.ID,CategoryID = 15)';
comment on column EMR.INPATIENT_DEFAULT.criticallevel
  is 'Σ�ؼ���(Dictionary_detail,CategoryID= ''53'')';
comment on column EMR.INPATIENT_DEFAULT.attendlevel
  is '������(ChargingMinItem.sfxmdm, xmlb = 2409)';
comment on column EMR.INPATIENT_DEFAULT.emphasis
  is '�ص㲡��(CategoryDetail.ID,CategoryID = 0)';
comment on column EMR.INPATIENT_DEFAULT.isbaby
  is 'Ӥ�����(��1��ʼ��0��ʾ����Ӥ��)';
comment on column EMR.INPATIENT_DEFAULT.mother
  is 'ĸ����ҳ���(InPatient.NoOfInpat, yexh = 0)';
comment on column EMR.INPATIENT_DEFAULT.medicareid
  is 'ҽ������';
comment on column EMR.INPATIENT_DEFAULT.medicarequota
  is 'ҽ������';
comment on column EMR.INPATIENT_DEFAULT.voucherscode
  is 'ƾ֤����(����)';
comment on column EMR.INPATIENT_DEFAULT.style
  is '��������(Dictionary_detail,CategoryID= ''45'')';
comment on column EMR.INPATIENT_DEFAULT.operator
  is '����Ա(Users.ID)';
comment on column EMR.INPATIENT_DEFAULT.memo
  is '��ע';
comment on column EMR.INPATIENT_DEFAULT.cpstatus
  is '�ٴ�·����״̬';
comment on column EMR.INPATIENT_DEFAULT.outwardbed
  is '��ȥ��λ';
comment on column EMR.INPATIENT_DEFAULT.districtid
  is '(������)���ֶ�';
comment on column EMR.INPATIENT_DEFAULT.xzzproviceid
  is '��סַʡ';
comment on column EMR.INPATIENT_DEFAULT.xzzcityid
  is '��סַ��';
comment on column EMR.INPATIENT_DEFAULT.xzzdistrictid
  is '��סַ��';
comment on column EMR.INPATIENT_DEFAULT.xzztel
  is '��סַ�绰';
comment on column EMR.INPATIENT_DEFAULT.hkdzproviceid
  is '����סַʡ';
comment on column EMR.INPATIENT_DEFAULT.hkzdcityid
  is '����סַ��';
comment on column EMR.INPATIENT_DEFAULT.hkzddistrictid
  is '����סַ��';
comment on column EMR.INPATIENT_DEFAULT.xzzpost
  is '��סַ�ʱ�';

prompt
prompt Creating table JOB2PERMISSION
prompt =============================
prompt
create table EMR.JOB2PERMISSION
(
  id           VARCHAR2(12) not null,
  moduleid     VARCHAR2(255) not null,
  modulename   VARCHAR2(255) not null,
  functionid   VARCHAR2(255),
  functionname VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_JOB2PERMISSION_FUNCTIONID on EMR.JOB2PERMISSION (FUNCTIONID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_JOB2PERMISSION_ID on EMR.JOB2PERMISSION (ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_JOB2PERMISSION_MODULEID on EMR.JOB2PERMISSION (MODULEID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table JOBMANAGERLOG
prompt ============================
prompt
create table EMR.JOBMANAGERLOG
(
  id      INTEGER not null,
  jobname VARCHAR2(50) not null,
  content VARCHAR2(2000) not null,
  logtime VARCHAR2(19) not null,
  logtype INTEGER not null,
  memo    VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.JOBMANAGERLOG
  add constraint PK_JOBMANAGERLOG_ID primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table JOBS
prompt ===================
prompt
create table EMR.JOBS
(
  id    VARCHAR2(12) not null,
  title VARCHAR2(32) not null,
  py    VARCHAR2(8),
  wb    VARCHAR2(8),
  memo  VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_JOBS_PY on EMR.JOBS (PY)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_JOBS_WB on EMR.JOBS (WB)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.JOBS
  add constraint PK_JOBS primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table KNOWLEDGEPUBLIC
prompt ==============================
prompt
create table EMR.KNOWLEDGEPUBLIC
(
  node       NUMBER(12) not null,
  title      VARCHAR2(400),
  parentnode NUMBER(12),
  context    VARCHAR2(4000),
  ordervalue INTEGER,
  ordertype  INTEGER,
  valid      VARCHAR2(1) default '1' not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_ORDERTYPE on EMR.KNOWLEDGEPUBLIC (ORDERTYPE)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_PARENTNODE on EMR.KNOWLEDGEPUBLIC (PARENTNODE)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.KNOWLEDGEPUBLIC
  add constraint PK_KNOWLEDGEPUBLIC primary key (NODE)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table LCCHARGINGITEM
prompt =============================
prompt
create table EMR.LCCHARGINGITEM
(
  id       VARCHAR2(12) not null,
  name     VARCHAR2(64) not null,
  hotkeys  VARCHAR2(12),
  py       VARCHAR2(8),
  wb       VARCHAR2(8),
  price    NUMBER(10,4),
  masterid VARCHAR2(12),
  valid    INTEGER not null,
  category INTEGER,
  superid  VARCHAR2(12),
  prolevel INTEGER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_LCCHARGINGITEM_PY on EMR.LCCHARGINGITEM (PY)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_LCCHARGINGITEM_WB on EMR.LCCHARGINGITEM (WB)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.LCCHARGINGITEM
  add constraint PK_LCCHARGINGITEM primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table LCCHARGINGITEMMAP
prompt ================================
prompt
create table EMR.LCCHARGINGITEMMAP
(
  lcitemid    VARCHAR2(12) not null,
  chargitemid VARCHAR2(12) not null,
  amount      VARCHAR2(16) not null,
  dxdm        VARCHAR2(12),
  jlwz        INTEGER,
  memo        VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.LCCHARGINGITEMMAP
  add constraint PK_LCCHARGINGITEMMAP primary key (LCITEMID, CHARGITEMID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table LONG_ORDER
prompt =========================
prompt
create table EMR.LONG_ORDER
(
  longid           NUMBER(12) not null,
  noofinpat        NUMBER(9) not null,
  groupid          NUMBER(12) not null,
  groupflag        INTEGER not null,
  wardid           VARCHAR2(12) not null,
  deptid           VARCHAR2(12) not null,
  typedoctor       VARCHAR2(6) not null,
  typedate         CHAR(19) not null,
  auditor          VARCHAR2(16),
  dateofaudit      CHAR(19),
  executor         VARCHAR2(16),
  executedate      CHAR(19),
  canceldoctor     VARCHAR2(6),
  canceldate       CHAR(19),
  ceasedcoctor     VARCHAR2(6),
  ceasedate        CHAR(19),
  ceasenurse       VARCHAR2(6),
  ceaseaduditdate  CHAR(19),
  startdate        CHAR(19),
  tomorrow         INTEGER default (0),
  productno        NUMBER(9) not null,
  normno           NUMBER(9) not null,
  medicineno       NUMBER(9) not null,
  drugno           VARCHAR2(12) not null,
  drugname         VARCHAR2(64),
  drugnorm         VARCHAR2(32),
  itemtype         INTEGER not null,
  minunit          VARCHAR2(8),
  drugdose         NUMBER(14,3),
  doseunit         VARCHAR2(8),
  unitrate         NUMBER(12,4),
  unittype         INTEGER,
  druguse          VARCHAR2(2),
  batchno          VARCHAR2(2) default (''),
  executecount     INTEGER default (1),
  executecycle     INTEGER default (1),
  cycleunit        INTEGER default (-1),
  dateofweek       CHAR(7) default (''),
  innerexecutetime VARCHAR2(64),
  executedept      VARCHAR2(12),
  entrust          VARCHAR2(64),
  ordertype        INTEGER not null,
  orderstatus      INTEGER not null,
  specialmark      INTEGER not null,
  ceasereason      INTEGER,
  curgeryid        NUMBER(12),
  content          VARCHAR2(255),
  synch            INTEGER,
  memo             VARCHAR2(64),
  djfl             VARCHAR2(4)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_LONG_ORDER_GROUPID on EMR.LONG_ORDER (GROUPID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_LONG_ORDER_NOOFINPAT on EMR.LONG_ORDER (NOOFINPAT)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.LONG_ORDER
  add constraint PK_LONG_ORDER primary key (LONGID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table MEASURE
prompt ======================
prompt
create table EMR.MEASURE
(
  id         NUMBER(12) not null,
  name       VARCHAR2(32) not null,
  py         VARCHAR2(8),
  wb         VARCHAR2(8),
  length     NUMBER(14,4) not null,
  width      NUMBER(14,4) not null,
  height     NUMBER(14,4) not null,
  unitid     VARCHAR2(32) not null,
  catagoryid INTEGER not null,
  valid      INTEGER not null,
  memo       VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.MEASURE
  add constraint PK_MEASURE primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.MEASURE
  add constraint UC_MEASURE unique (NAME)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table MEDICALRECORD
prompt ============================
prompt
create table EMR.MEDICALRECORD
(
  id            NUMBER(12) not null,
  noofinpat     INTEGER not null,
  templateid    VARCHAR2(64) not null,
  recordname    VARCHAR2(64) not null,
  recorddesc    VARCHAR2(255) not null,
  content       LONG not null,
  disease       VARCHAR2(255),
  lockdate      CHAR(10),
  unlock        CHAR(10),
  operationdate CHAR(19),
  operator      VARCHAR2(6),
  lockinfo      INTEGER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.MEDICALRECORD
  add constraint PK_MEDICALRECORD primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table MEDICAREINFO
prompt ===========================
prompt
create table EMR.MEDICAREINFO
(
  id     VARCHAR2(4) not null,
  note   VARCHAR2(32) not null,
  py     VARCHAR2(8),
  wb     VARCHAR2(8),
  rqfl   VARCHAR2(2) not null,
  ztqk   VARCHAR2(2) not null,
  bjqk   VARCHAR2(2) not null,
  tsry   VARCHAR2(2) not null,
  hzlb   VARCHAR2(2) not null,
  ybbl   NUMBER(7,2) default 1 not null,
  xtbz   INTEGER not null,
  zfbz   INTEGER not null,
  zhbz   INTEGER not null,
  qfje   NUMBER(10,2),
  jsfs   INTEGER not null,
  yztyx  NUMBER(10,4),
  pzlx   VARCHAR2(2),
  pzlxmc VARCHAR2(16),
  yxjl   INTEGER not null,
  memo   VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_MEDICAREINFO_PY on EMR.MEDICAREINFO (PY)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_MEDICAREINFO_WB on EMR.MEDICAREINFO (WB)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.MEDICAREINFO
  add constraint PK_MEDICAREINFO primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table MEDICINE
prompt =======================
prompt
create table EMR.MEDICINE
(
  id             INTEGER,
  name           VARCHAR2(400),
  specification  VARCHAR2(400),
  applyto        VARCHAR2(400),
  referenceusage VARCHAR2(500),
  meno           VARCHAR2(400),
  categorythree  VARCHAR2(400),
  categorytwo    VARCHAR2(400),
  categoryone    VARCHAR2(400),
  pinyin         VARCHAR2(400)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 384K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MEDICINEDIRECT
prompt =============================
prompt
create table EMR.MEDICINEDIRECT
(
  id            NUMBER(18) not null,
  productid     NUMBER(18),
  doseform      VARCHAR2(100),
  directtitle   VARCHAR2(400),
  directcontent CLOB,
  createdate    DATE,
  createperson  VARCHAR2(20),
  changedate    DATE,
  changeman     VARCHAR2(20),
  directtitle2  VARCHAR2(400),
  pinyin        VARCHAR2(150),
  pagenum       VARCHAR2(400),
  id1           VARCHAR2(400),
  url           VARCHAR2(400),
  iserror       VARCHAR2(10),
  type          VARCHAR2(50)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 80M
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.INDEX_PY on EMR.MEDICINEDIRECT (PINYIN)
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 768K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MEDICINEDIRECT12
prompt ===============================
prompt
create table EMR.MEDICINEDIRECT12
(
  id            INTEGER,
  productid     INTEGER,
  doseform      NVARCHAR2(255),
  directtitle   NVARCHAR2(255),
  directcontent LONG,
  createdate    DATE,
  createperson  NVARCHAR2(100),
  changedate    DATE,
  changeman     NVARCHAR2(100),
  directtitle2  NVARCHAR2(255),
  pinyin        NVARCHAR2(255),
  pagenum       NVARCHAR2(255),
  id1           NVARCHAR2(255),
  url           NVARCHAR2(255),
  iserror       CHAR(10),
  type          NVARCHAR2(10)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 512K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MINITEMNICK
prompt ==========================
prompt
create table EMR.MINITEMNICK
(
  itemid VARCHAR2(12) not null,
  nick   VARCHAR2(64) not null,
  py     VARCHAR2(8),
  wb     VARCHAR2(8),
  memo   VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_MINITEMNICK_PY on EMR.MINITEMNICK (PY)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_MINITEMNICK_WB on EMR.MINITEMNICK (WB)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.MINITEMNICK
  add constraint PK_MINITEMNICK primary key (ITEMID, NICK)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table MODELDIRECTORY
prompt =============================
prompt
create table EMR.MODELDIRECTORY
(
  id         VARCHAR2(12) not null,
  name       VARCHAR2(64) not null,
  py         VARCHAR2(8),
  wb         VARCHAR2(8),
  previd     VARCHAR2(12) default (''),
  modellevel INTEGER,
  valid      INTEGER not null,
  memo       VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.MODELDIRECTORY
  add constraint PK_MODELDIRECTORY primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table NEWSARTICLE
prompt ==========================
prompt
create table EMR.NEWSARTICLE
(
  id           VARCHAR2(64) not null,
  title        VARCHAR2(100) not null,
  author       VARCHAR2(4),
  addtime      VARCHAR2(24) not null,
  departmentid VARCHAR2(12),
  classid      VARCHAR2(64) not null,
  defaultimage VARCHAR2(200),
  content      VARCHAR2(2000) not null,
  valid        INTEGER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.NEWSARTICLE
  add constraint PK_NEWSARTICLE primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table NEWSARTICLE_CLASS
prompt ================================
prompt
create table EMR.NEWSARTICLE_CLASS
(
  id        VARCHAR2(64) not null,
  classname VARCHAR2(100) not null,
  summary   VARCHAR2(200)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.NEWSARTICLE_CLASS
  add constraint PK_NEWSARTICLE_CLASS primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table NOTESONNURSING
prompt =============================
prompt
create table EMR.NOTESONNURSING
(
  id               NUMBER(9) not null,
  noofinpat        NUMBER(9) not null,
  dateofsurvey     VARCHAR2(10) not null,
  timeslot         VARCHAR2(2) not null,
  temperature      VARCHAR2(20),
  wayofsurvey      INTEGER,
  pulse            VARCHAR2(20),
  heartrate        VARCHAR2(20),
  breathe          VARCHAR2(20),
  bloodpressure    VARCHAR2(20),
  timeofshit       VARCHAR2(50),
  countin          VARCHAR2(20),
  countout         VARCHAR2(20),
  drainage         VARCHAR2(20),
  height           VARCHAR2(20),
  weight           VARCHAR2(20),
  allergy          VARCHAR2(100),
  daysaftersurgery VARCHAR2(20),
  dayofhospital    VARCHAR2(20),
  physicalcooling  VARCHAR2(20),
  dateofrecord     VARCHAR2(19) default to_char(sysdate,'yyyy-mm-dd HH24:MI:SS') not null,
  doctorofrecord   VARCHAR2(6) not null,
  physicalhotting  VARCHAR2(20),
  paininfo         VARCHAR2(100),
  param1           VARCHAR2(20),
  param2           VARCHAR2(20),
  indx             VARCHAR2(4),
  param3           VARCHAR2(100),
  param4           VARCHAR2(100),
  param5           VARCHAR2(100),
  param6           VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 269M
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_NOTESONNURSING_NOOFINPAT on EMR.NOTESONNURSING (NOOFINPAT)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 72M
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.NOTESONNURSING
  add constraint PK_NOTESONNURSING primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 61M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table NURSE_RECORDOPER
prompt ===============================
prompt
create table EMR.NURSE_RECORDOPER
(
  id              VARCHAR2(50) not null,
  noofinpatent    VARCHAR2(50),
  father_recordid VARCHAR2(50),
  record_datetime VARCHAR2(19),
  tiwen           VARCHAR2(50),
  maibo           VARCHAR2(50),
  huxi            VARCHAR2(50),
  xueya           VARCHAR2(50),
  yishi           VARCHAR2(50),
  xybhd           VARCHAR2(50),
  qkfl            VARCHAR2(50),
  sypf            VARCHAR2(50),
  other_one       VARCHAR2(50),
  other_two       VARCHAR2(50),
  other_three     VARCHAR2(50),
  other_four      VARCHAR2(50),
  ztkdx           VARCHAR2(50),
  ytkdx           VARCHAR2(50),
  tkdgfs          VARCHAR2(50),
  wowei           VARCHAR2(50),
  jmzg            VARCHAR2(50),
  dgjylg_one      VARCHAR2(50),
  dgjylg_two      VARCHAR2(50),
  dgjylg_three    VARCHAR2(50),
  in_item         VARCHAR2(50),
  in_value        VARCHAR2(50),
  out_item        VARCHAR2(50),
  out_value       VARCHAR2(50),
  out_color       VARCHAR2(50),
  out_statue      VARCHAR2(50),
  other           VARCHAR2(50),
  hxms            VARCHAR2(50),
  fcimiao         VARCHAR2(50),
  xrynd           VARCHAR2(50),
  cgsd            VARCHAR2(50),
  lxxzytq         VARCHAR2(50),
  bdg             VARCHAR2(50),
  singe_doctor    VARCHAR2(50),
  singe_doctorid  VARCHAR2(50),
  create_doctorid VARCHAR2(50),
  create_time     VARCHAR2(19),
  valid           VARCHAR2(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table NURSE_WITHINFORMATION
prompt ====================================
prompt
create table EMR.NURSE_WITHINFORMATION
(
  id         NUMBER(12) not null,
  typeid     VARCHAR2(4) not null,
  userid     VARCHAR2(6) not null,
  username   VARCHAR2(16) not null,
  tcontent   VARCHAR2(250),
  painetid   VARCHAR2(9) not null,
  valid      VARCHAR2(1) not null,
  painetname VARCHAR2(16)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 384K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.NURSE_WITHINFORMATION
  add constraint PK_NURSE_WITHINFORMATION primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table NURSRECORDTABLE
prompt ==============================
prompt
create table EMR.NURSRECORDTABLE
(
  id         NUMBER(9) not null,
  noofinpat  NUMBER(9) not null,
  name       VARCHAR2(200) not null,
  content    BLOB not null,
  templateid NUMBER(9) not null,
  version    VARCHAR2(32),
  department VARCHAR2(12) not null,
  sortid     NUMBER(9),
  valid      INTEGER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.NURSRECORDTABLE
  add constraint PK_NURSRECORDTABLE primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table OPERATEHISTORY
prompt =============================
prompt
create table EMR.OPERATEHISTORY
(
  noofinpat   NUMBER(9) not null,
  recordid    NUMBER(12) not null,
  detailid    NUMBER(12) not null,
  operatorid  INTEGER not null,
  operatedate CHAR(19) not null,
  operator    VARCHAR2(12) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_OPERATEHISTORY_DETAILID on EMR.OPERATEHISTORY (DETAILID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_OPERATEHISTORY_NOOFINPAT on EMR.OPERATEHISTORY (NOOFINPAT)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_OPERATEHISTORY_OPERATOR on EMR.OPERATEHISTORY (OPERATOR)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table OPERATESTEP
prompt ==========================
prompt
create table EMR.OPERATESTEP
(
  id          NUMBER(12) not null,
  recordid    NUMBER(12) not null,
  genre       INTEGER not null,
  detailid    NUMBER(12) not null,
  recordname  VARCHAR2(64) not null,
  npath       VARCHAR2(32) not null,
  bostr       CLOB not null,
  aostr       CLOB not null,
  opidx       INTEGER not null,
  opcnt       INTEGER not null,
  opnidx      INTEGER not null,
  optidx      INTEGER not null,
  nodes       LONG,
  bvalue      VARCHAR2(255),
  avalue      VARCHAR2(255),
  operatedate CHAR(19) not null,
  operator    VARCHAR2(6) not null,
  counter     INTEGER not null,
  valid       INTEGER not null,
  memo        VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_OPERATESTEP_DETAILID on EMR.OPERATESTEP (DETAILID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_OPERATESTEP_OPERATEDATE on EMR.OPERATESTEP (OPERATEDATE)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_OPERATESTEP_OPERATOR on EMR.OPERATESTEP (OPERATOR)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_OPERATESTEP_RECORDID on EMR.OPERATESTEP (RECORDID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.OPERATESTEP
  add constraint PK_OPERATESTEP primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table OPERATION
prompt ========================
prompt
create table EMR.OPERATION
(
  id    VARCHAR2(12) not null,
  mapid VARCHAR2(16),
  name  VARCHAR2(64) not null,
  py    VARCHAR2(40),
  wb    VARCHAR2(40),
  sslb  INTEGER,
  valid INTEGER not null,
  memo  VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 320K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.OPERATION
  add constraint PK_OPERATION primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table OPERATION2
prompt =========================
prompt
create table EMR.OPERATION2
(
  id    VARCHAR2(12) not null,
  mapid VARCHAR2(16),
  name  VARCHAR2(64) not null,
  py    VARCHAR2(8),
  wb    VARCHAR2(8),
  sslb  INTEGER,
  valid INTEGER not null,
  memo  VARCHAR2(16)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table OPERATIONRECORDDETAIL
prompt ====================================
prompt
create table EMR.OPERATIONRECORDDETAIL
(
  id              NUMBER(12) not null,
  noofinpat       INTEGER not null,
  templateid      VARCHAR2(64) not null,
  name            VARCHAR2(300) not null,
  content         CLOB,
  sortid          VARCHAR2(12),
  owner           VARCHAR2(6) not null,
  auditor         VARCHAR2(6),
  createtime      CHAR(19),
  audittime       CHAR(19),
  valid           INTEGER,
  hassubmit       INTEGER,
  hasprint        INTEGER,
  captiondatetime CHAR(19),
  islock          INTEGER,
  firstdailyflag  CHAR(1) default 0,
  isyihuangoutong VARCHAR2(1),
  ip              VARCHAR2(64),
  departcode      VARCHAR2(50),
  wardcode        VARCHAR2(50),
  opertype        VARCHAR2(50),
  optime          DATE default sysdate
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 456M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table OPEROTHERNAME
prompt ============================
prompt
create table EMR.OPEROTHERNAME
(
  id    VARCHAR2(50) not null,
  icdid VARCHAR2(50),
  name  VARCHAR2(50),
  py    VARCHAR2(50),
  wb    VARCHAR2(50),
  valid VARCHAR2(1)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.OPEROTHERNAME.id
  is '����';
comment on column EMR.OPEROTHERNAME.icdid
  is '������Ӧ��Ҫ���ID';
comment on column EMR.OPEROTHERNAME.name
  is '����';
alter table EMR.OPEROTHERNAME
  add constraint PK_OPEROTHERNAME_ID primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table OPERRECORDLOG
prompt ============================
prompt
create table EMR.OPERRECORDLOG
(
  user_id      VARCHAR2(12),
  user_name    VARCHAR2(16),
  patient_id   VARCHAR2(12),
  patient_name VARCHAR2(16),
  user_dept_id VARCHAR2(12),
  record_id    VARCHAR2(12),
  record_type  VARCHAR2(12),
  record_title VARCHAR2(80),
  oper_id      VARCHAR2(4),
  oper_time    VARCHAR2(26),
  oper_content CLOB
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table OUTDIAGNOSISCONDITION
prompt ====================================
prompt
create table EMR.OUTDIAGNOSISCONDITION
(
  id                        NUMBER(12) not null,
  iem_mainpage_diagnosis_no NUMBER(12) not null,
  iem_mainpage_no           NUMBER(12),
  diagnosis_code            VARCHAR2(60),
  diagnosis_name            VARCHAR2(300),
  status_id                 NUMBER(3),
  status_name               VARCHAR2(50),
  valid                     NUMBER(1) not null,
  create_user               VARCHAR2(10),
  create_time               VARCHAR2(19),
  cancel_user               VARCHAR2(10),
  cancel_time               VARCHAR2(19),
  memo1                     VARCHAR2(300),
  memo2                     VARCHAR2(300),
  memo3                     VARCHAR2(300)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 20M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.OUTDIAGNOSISCONDITION.id
  is '�Զ�������ˮ��';
comment on column EMR.OUTDIAGNOSISCONDITION.iem_mainpage_diagnosis_no
  is '���ID(Ψһ��ʶ)';
comment on column EMR.OUTDIAGNOSISCONDITION.iem_mainpage_no
  is '��ҳID(Ψһ��ʶ)';
comment on column EMR.OUTDIAGNOSISCONDITION.diagnosis_code
  is '��ϱ���';
comment on column EMR.OUTDIAGNOSISCONDITION.diagnosis_name
  is '�������';
comment on column EMR.OUTDIAGNOSISCONDITION.status_id
  is '��Ժ���ID';
comment on column EMR.OUTDIAGNOSISCONDITION.status_name
  is '��Ժ�������';
comment on column EMR.OUTDIAGNOSISCONDITION.valid
  is '�Ƿ���Ч(0-��Ч��1-��Ч)';
comment on column EMR.OUTDIAGNOSISCONDITION.create_user
  is '������';
comment on column EMR.OUTDIAGNOSISCONDITION.create_time
  is '����ʱ��';
comment on column EMR.OUTDIAGNOSISCONDITION.cancel_user
  is 'ȡ����';
comment on column EMR.OUTDIAGNOSISCONDITION.cancel_time
  is 'ȡ��ʱ��';
comment on column EMR.OUTDIAGNOSISCONDITION.memo1
  is '�����ֶ�1';
comment on column EMR.OUTDIAGNOSISCONDITION.memo2
  is '�����ֶ�2';
comment on column EMR.OUTDIAGNOSISCONDITION.memo3
  is '�����ֶ�3';

prompt
prompt Creating table PATDIAG
prompt ======================
prompt
create table EMR.PATDIAG
(
  patient_id       VARCHAR2(16) not null,
  nad              NUMBER(2) not null,
  diag_type        VARCHAR2(50) not null,
  diag_type_name   VARCHAR2(20) not null,
  diag_no          NUMBER(2) not null,
  diag_sub_no      NUMBER(2) not null,
  diag_class       VARCHAR2(2),
  diag_code        VARCHAR2(16),
  diag_content     VARCHAR2(80),
  diag_date        DATE,
  diag_doctor_id   VARCHAR2(16),
  modify_doctor_id VARCHAR2(16),
  last_time        DATE,
  parent_id        NUMBER(2),
  super_id         VARCHAR2(16),
  super_sign_date  DATE,
  flag             VARCHAR2(1),
  houseman         VARCHAR2(8),
  confirmed_flag   NUMBER(1),
  id               NUMBER(2),
  uncertain_diag   NUMBER(1),
  back_diag        NUMBER(1),
  remark           VARCHAR2(20),
  diagothername    VARCHAR2(500)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 3M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.PATDIAG
  is '�����Ϣ
pat_diagnosis';
comment on column EMR.PATDIAG.patient_id
  is '���˺�';
comment on column EMR.PATDIAG.nad
  is 'סԺ��';
comment on column EMR.PATDIAG.diag_type
  is '�������';
comment on column EMR.PATDIAG.diag_type_name
  is '����������';
comment on column EMR.PATDIAG.diag_no
  is '��ϱ��';
comment on column EMR.PATDIAG.diag_sub_no
  is '����ϱ��';
comment on column EMR.PATDIAG.diag_class
  is '������';
comment on column EMR.PATDIAG.diag_code
  is '��ϴ���';
comment on column EMR.PATDIAG.diag_content
  is '�������';
comment on column EMR.PATDIAG.diag_date
  is '�������';
comment on column EMR.PATDIAG.diag_doctor_id
  is '�����ҽʦID';
comment on column EMR.PATDIAG.modify_doctor_id
  is '����ҽʦID';
comment on column EMR.PATDIAG.last_time
  is '������ʱ��';
comment on column EMR.PATDIAG.parent_id
  is '�ϼ�ҽ��ID';
comment on column EMR.PATDIAG.super_id
  is '����ҽʦID';
comment on column EMR.PATDIAG.super_sign_date
  is '������ǩ����';
comment on column EMR.PATDIAG.flag
  is '���';
comment on column EMR.PATDIAG.houseman
  is 'ʵϰҽ��';
comment on column EMR.PATDIAG.confirmed_flag
  is 'ȷ����:1 ȷ����� 0 �������';
comment on column EMR.PATDIAG.id
  is '���';
comment on column EMR.PATDIAG.uncertain_diag
  is '1Ϊ�������';
comment on column EMR.PATDIAG.back_diag
  is '1��ʾ��ע׷�ӵ����֮�󣬷���׷�ӵ�ǰ';
comment on column EMR.PATDIAG.remark
  is '��ע����';
alter table EMR.PATDIAG
  add constraint PK_PAT_DIAGNOSIS primary key (PATIENT_ID, NAD, DIAG_TYPE, DIAG_NO, DIAG_SUB_NO, DIAG_TYPE_NAME)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 4M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table PATDIAGCLINIC
prompt ============================
prompt
create table EMR.PATDIAGCLINIC
(
  noofinpatclinic INTEGER not null,
  id              INTEGER not null,
  parentid        INTEGER,
  diag_type       VARCHAR2(4),
  diag_type_name  VARCHAR2(32),
  diag_code       VARCHAR2(32),
  diag_content    VARCHAR2(100),
  createuserid    VARCHAR2(6),
  createtime      DATE,
  valid           VARCHAR2(1),
  canceluserid    VARCHAR2(6),
  canceltime      DATE
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on table EMR.PATDIAGCLINIC
  is '������ϼ�¼���ڱ༭������ϰ�ťԪ�ز�������';
comment on column EMR.PATDIAGCLINIC.noofinpatclinic
  is '������������Ӳ����е�Ψһ���';
comment on column EMR.PATDIAGCLINIC.id
  is '��ϱ��';
comment on column EMR.PATDIAGCLINIC.parentid
  is '���ڵ���';
comment on column EMR.PATDIAGCLINIC.diag_type
  is '�������';
comment on column EMR.PATDIAGCLINIC.diag_type_name
  is '�������';
comment on column EMR.PATDIAGCLINIC.diag_code
  is '��ϱ���';
comment on column EMR.PATDIAGCLINIC.diag_content
  is '������ƣ����ڱ����򱣴������';
comment on column EMR.PATDIAGCLINIC.createuserid
  is '������';
comment on column EMR.PATDIAGCLINIC.createtime
  is '����ʱ��';
comment on column EMR.PATDIAGCLINIC.valid
  is '�Ƿ���Ч 1�� ��Ч 0����Ч';
comment on column EMR.PATDIAGCLINIC.canceluserid
  is '������';
comment on column EMR.PATDIAGCLINIC.canceltime
  is '����ʱ��';

prompt
prompt Creating table PATDIAGTYPE
prompt ==========================
prompt
create table EMR.PATDIAGTYPE
(
  sno      NUMBER(2),
  code     VARCHAR2(2) not null,
  diagname VARCHAR2(20) not null,
  typeid   VARCHAR2(2) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.PATDIAGTYPE
  is '������� ��������������ϣ�������ϣ�������ϣ���ҽ��ϣ���Ժ��ϡ� �ڲ����༭����PadForm������DiagForm������ʹ��';
comment on column EMR.PATDIAGTYPE.sno
  is '˳���';
comment on column EMR.PATDIAGTYPE.code
  is '����';
comment on column EMR.PATDIAGTYPE.diagname
  is '�������';
comment on column EMR.PATDIAGTYPE.typeid
  is '�������';

prompt
prompt Creating table PATHOLOGICREPORT
prompt ===============================
prompt
create table EMR.PATHOLOGICREPORT
(
  f_blh     VARCHAR2(20),
  f_xm      VARCHAR2(20),
  f_zyh     VARCHAR2(30),
  f_brbh    VARCHAR2(30),
  f_yzid    VARCHAR2(30),
  f_rysj    VARCHAR2(2000),
  f_jxsj    VARCHAR2(2000),
  f_blzd    VARCHAR2(4000),
  f_bgys    VARCHAR2(30),
  f_bgrq    VARCHAR2(20),
  f_bczd    VARCHAR2(2000),
  f_bc_bgrq VARCHAR2(20),
  f_bc_bgys VARCHAR2(20),
  pdflj1    VARCHAR2(200),
  pdflj2    VARCHAR2(200)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table PATIENTCONTACTS
prompt ==============================
prompt
create table EMR.PATIENTCONTACTS
(
  id         NUMBER(9) not null,
  noofinpat  NUMBER(9) not null,
  name       VARCHAR2(32),
  sex        VARCHAR2(4),
  relation   VARCHAR2(4),
  address    VARCHAR2(255),
  workunit   VARCHAR2(64),
  hometel    VARCHAR2(16),
  worktel    VARCHAR2(16),
  postalcode VARCHAR2(16),
  birthday   VARCHAR2(10),
  tag        VARCHAR2(4)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.PATIENTCONTACTS
  add constraint PK_PATIENTCONTACTS primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table PATIENTRECORDLOG
prompt ===============================
prompt
create table EMR.PATIENTRECORDLOG
(
  id         NUMBER(12) not null,
  userid     VARCHAR2(6) not null,
  noofinpat  NUMBER(9) not null,
  recordid   VARCHAR2(64) not null,
  recordname VARCHAR2(64) not null,
  operation  INTEGER,
  trackiime  CHAR(19) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.PATIENTRECORDLOG
  add constraint PK_PATIENTRECORDLOG primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table PATIENTSTATUS
prompt ============================
prompt
create table EMR.PATIENTSTATUS
(
  id        NUMBER(12) not null,
  noofinpat VARCHAR2(32) not null,
  ccode     VARCHAR2(4) not null,
  dotime    CHAR(18),
  patid     VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 12M
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.PATIENTSTATUS
  add constraint PK_PATIENTSTATUS primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 4M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table PATIENTSTATUS1
prompt =============================
prompt
create table EMR.PATIENTSTATUS1
(
  id        NUMBER(12) not null,
  noofinpat VARCHAR2(32) not null,
  ccode     VARCHAR2(4) not null,
  dotime    CHAR(18)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 5M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table PBCATCOL
prompt =======================
prompt
create table EMR.PBCATCOL
(
  pbc_tnam VARCHAR2(30) not null,
  pbc_tid  INTEGER,
  pbc_ownr VARCHAR2(30) not null,
  pbc_cnam VARCHAR2(30) not null,
  pbc_cid  INTEGER,
  pbc_labl VARCHAR2(254),
  pbc_lpos INTEGER,
  pbc_hdr  VARCHAR2(254),
  pbc_hpos INTEGER,
  pbc_jtfy INTEGER,
  pbc_mask VARCHAR2(31),
  pbc_case INTEGER,
  pbc_hght INTEGER,
  pbc_wdth INTEGER,
  pbc_ptrn VARCHAR2(31),
  pbc_bmap CHAR(1),
  pbc_init VARCHAR2(254),
  pbc_cmnt VARCHAR2(254),
  pbc_edit VARCHAR2(31),
  pbc_tag  VARCHAR2(254)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255;
create unique index EMR.PBSYSCATCOLDICT_IDX on EMR.PBCATCOL (PBC_TNAM, PBC_OWNR, PBC_CNAM)
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255;
grant select, insert, update, delete on EMR.PBCATCOL to PUBLIC;

prompt
prompt Creating table PBCATEDT
prompt =======================
prompt
create table EMR.PBCATEDT
(
  pbe_name VARCHAR2(30),
  pbe_edit VARCHAR2(254),
  pbe_type INTEGER,
  pbe_cntr INTEGER,
  pbe_seqn INTEGER,
  pbe_flag INTEGER,
  pbe_work VARCHAR2(32)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create unique index EMR.PBSYSPBE_IDX on EMR.PBCATEDT (PBE_NAME, PBE_SEQN)
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
grant select, insert, update, delete on EMR.PBCATEDT to PUBLIC;

prompt
prompt Creating table PBCATFMT
prompt =======================
prompt
create table EMR.PBCATFMT
(
  pbf_name VARCHAR2(30),
  pbf_frmt VARCHAR2(254),
  pbf_type INTEGER not null,
  pbf_cntr INTEGER
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create unique index EMR.PBSYSCATFRMTS_IDX on EMR.PBCATFMT (PBF_NAME)
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
grant select, insert, update, delete on EMR.PBCATFMT to PUBLIC;

prompt
prompt Creating table PBCATTBL
prompt =======================
prompt
create table EMR.PBCATTBL
(
  pbt_tnam VARCHAR2(30) not null,
  pbt_tid  INTEGER,
  pbt_ownr VARCHAR2(30) not null,
  pbd_fhgt INTEGER,
  pbd_fwgt INTEGER,
  pbd_fitl CHAR(1),
  pbd_funl CHAR(1),
  pbd_fchr INTEGER,
  pbd_fptc INTEGER,
  pbd_ffce VARCHAR2(18),
  pbh_fhgt INTEGER,
  pbh_fwgt INTEGER,
  pbh_fitl CHAR(1),
  pbh_funl CHAR(1),
  pbh_fchr INTEGER,
  pbh_fptc INTEGER,
  pbh_ffce VARCHAR2(18),
  pbl_fhgt INTEGER,
  pbl_fwgt INTEGER,
  pbl_fitl CHAR(1),
  pbl_funl CHAR(1),
  pbl_fchr INTEGER,
  pbl_fptc INTEGER,
  pbl_ffce VARCHAR2(18),
  pbt_cmnt VARCHAR2(254)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255;
create unique index EMR.PBSYSCATPBT_IDX on EMR.PBCATTBL (PBT_TNAM, PBT_OWNR)
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255;
grant select, insert, update, delete on EMR.PBCATTBL to PUBLIC;

prompt
prompt Creating table PBCATVLD
prompt =======================
prompt
create table EMR.PBCATVLD
(
  pbv_name VARCHAR2(30),
  pbv_vald VARCHAR2(254),
  pbv_type INTEGER,
  pbv_cntr INTEGER,
  pbv_msg  VARCHAR2(254)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255;
create unique index EMR.PBSYSCATVLDS_IDX on EMR.PBCATVLD (PBV_NAME)
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255;
grant select, insert, update, delete on EMR.PBCATVLD to PUBLIC;

prompt
prompt Creating table PERSONALHISTORY
prompt ==============================
prompt
create table EMR.PERSONALHISTORY
(
  id           NUMBER(9) not null,
  noofinpat    NUMBER(9) not null,
  marital      VARCHAR2(4) not null,
  noofchild    INTEGER default 0 not null,
  jobhistory   VARCHAR2(255) not null,
  drinkwine    INTEGER not null,
  winehistory  VARCHAR2(255),
  smoke        INTEGER not null,
  smokehistory VARCHAR2(255),
  birthplace   VARCHAR2(10) not null,
  passplace    VARCHAR2(10) not null,
  memo         VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_PERSONALHISTORYPATNOOFHIS on EMR.PERSONALHISTORY (NOOFINPAT)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.PERSONALHISTORY
  add constraint PK_PERSONALHISTORYID primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table PLACEOFDRUG
prompt ==========================
prompt
create table EMR.PLACEOFDRUG
(
  id           NUMBER(9) not null,
  formatid     NUMBER(9) not null,
  clinicalid   NUMBER(9) not null,
  dugname      VARCHAR2(64) not null,
  drugid       VARCHAR2(12),
  hotkeys      VARCHAR2(12),
  py           VARCHAR2(8),
  wb           VARCHAR2(8),
  format       VARCHAR2(32) not null,
  dosage       VARCHAR2(12),
  classdetail  VARCHAR2(12) not null,
  minunit      VARCHAR2(12) not null,
  formatunit   VARCHAR2(12) not null,
  ratio        NUMBER(12,4) not null,
  ykunit       VARCHAR2(12) not null,
  ykratio      NUMBER(12,4) not null,
  mzunit       VARCHAR2(12) not null,
  mzratio      NUMBER(12,4) not null,
  zyunit       VARCHAR2(12) not null,
  zyratio      NUMBER(12,4) not null,
  ekunit       VARCHAR2(12),
  ekratio      NUMBER(12,4),
  retailprice  NUMBER(10,4) not null,
  mzbxmark     INTEGER not null,
  zybxmark     INTEGER not null,
  drugnature   INTEGER not null,
  specialty    INTEGER not null,
  originid     VARCHAR2(4),
  producer     VARCHAR2(64),
  advicemark   INTEGER,
  usagescope   INTEGER,
  drugcategory INTEGER not null,
  valid        INTEGER not null,
  memo         VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_PLACEOFDRUG_ID on EMR.PLACEOFDRUG (DRUGID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 256K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_PLACEOFDRUG_PY on EMR.PLACEOFDRUG (PY)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 256K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_PLACEOFDRUG_WB on EMR.PLACEOFDRUG (WB)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.PLACEOFDRUG
  add constraint PK_PLACEOFDRUG primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table PLATFORM_DC0012
prompt ==============================
prompt
create table EMR.PLATFORM_DC0012
(
  recordno                 VARCHAR2(50) not null,
  hospunitorgcode          VARCHAR2(22),
  hospunitdeptinternalno   VARCHAR2(20),
  hospunitdeptno           VARCHAR2(20),
  hospunitdeptnm           VARCHAR2(100),
  healthbureaucode         VARCHAR2(32),
  socialsecuritybureaucode VARCHAR2(32),
  illustrate               VARCHAR2(500),
  res1                     VARCHAR2(100),
  res2                     VARCHAR2(100),
  res3                     VARCHAR2(100),
  uploaddt                 DATE,
  lastmodifydt             DATE
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.PLATFORM_DC0012
  is '�ֳ��ӿ�ƽ̨--������Ϣ';
alter table EMR.PLATFORM_DC0012
  add primary key (RECORDNO)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table PLSQL_PROFILER_RUNS
prompt ==================================
prompt
create table EMR.PLSQL_PROFILER_RUNS
(
  runid           NUMBER not null,
  related_run     NUMBER,
  run_owner       VARCHAR2(32),
  run_date        DATE,
  run_comment     VARCHAR2(2047),
  run_total_time  NUMBER,
  run_system_info VARCHAR2(2047),
  run_comment1    VARCHAR2(2047),
  spare1          VARCHAR2(256)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on table EMR.PLSQL_PROFILER_RUNS
  is 'Run-specific information for the PL/SQL profiler';
create unique index EMR.PK_PLSQL_PROFILER_RUNS on EMR.PLSQL_PROFILER_RUNS (RUNID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.PLSQL_PROFILER_RUNS
  add primary key (RUNID);

prompt
prompt Creating table PLSQL_PROFILER_UNITS
prompt ===================================
prompt
create table EMR.PLSQL_PROFILER_UNITS
(
  runid          NUMBER not null,
  unit_number    NUMBER not null,
  unit_type      VARCHAR2(32),
  unit_owner     VARCHAR2(32),
  unit_name      VARCHAR2(32),
  unit_timestamp DATE,
  total_time     NUMBER default 0 not null,
  spare1         NUMBER,
  spare2         NUMBER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on table EMR.PLSQL_PROFILER_UNITS
  is 'Information about each library unit in a run';
create unique index EMR.PK_PLSQL_PROFILER_UNITS on EMR.PLSQL_PROFILER_UNITS (RUNID, UNIT_NUMBER)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.PLSQL_PROFILER_UNITS
  add primary key (RUNID, UNIT_NUMBER);
alter table EMR.PLSQL_PROFILER_UNITS
  add foreign key (RUNID)
  references EMR.PLSQL_PROFILER_RUNS (RUNID);

prompt
prompt Creating table PLSQL_PROFILER_DATA
prompt ==================================
prompt
create table EMR.PLSQL_PROFILER_DATA
(
  runid       NUMBER not null,
  unit_number NUMBER not null,
  line#       NUMBER not null,
  total_occur NUMBER,
  total_time  NUMBER,
  min_time    NUMBER,
  max_time    NUMBER,
  spare1      NUMBER,
  spare2      NUMBER,
  spare3      NUMBER,
  spare4      NUMBER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on table EMR.PLSQL_PROFILER_DATA
  is 'Accumulated data from all profiler runs';
create unique index EMR.PK_PLSQL_PROFILER_DATA on EMR.PLSQL_PROFILER_DATA (RUNID, UNIT_NUMBER, LINE#)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.PLSQL_PROFILER_DINDEX on EMR.PLSQL_PROFILER_DATA (RUNID, UNIT_NUMBER)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.PLSQL_PROFILER_DATA
  add primary key (RUNID, UNIT_NUMBER, LINE#);
alter table EMR.PLSQL_PROFILER_DATA
  add foreign key (RUNID, UNIT_NUMBER)
  references EMR.PLSQL_PROFILER_UNITS (RUNID, UNIT_NUMBER);

prompt
prompt Creating table PRINTHISTORY
prompt ===========================
prompt
create table EMR.PRINTHISTORY
(
  id             NUMBER(12) not null,
  noofoperator   VARCHAR2(6) not null,
  noofrecord     NUMBER(12) not null,
  exampleid      INTEGER not null,
  version        INTEGER not null,
  printsetid     NUMBER(12) not null,
  printversion   INTEGER not null,
  preprintreason INTEGER not null,
  printreason    VARCHAR2(255),
  printtime      CHAR(19) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.PRINTHISTORY
  add constraint PK_PRINTHISTORY primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table PRINTHISTORYNURSE
prompt ================================
prompt
create table EMR.PRINTHISTORYNURSE
(
  phflow          VARCHAR2(50) not null,
  printrecordflow VARCHAR2(50),
  startpage       INTEGER,
  endpage         INTEGER,
  printpages      INTEGER,
  printdocid      VARCHAR2(50),
  printdatetime   VARCHAR2(19),
  printtype       VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 704K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.PRINTHISTORYNURSE.printrecordflow
  is '�����ݵ���ˮ�����ᵥ�Ĳ�����ˮ��';
comment on column EMR.PRINTHISTORYNURSE.startpage
  is '��ʼҳ';
comment on column EMR.PRINTHISTORYNURSE.endpage
  is '����ҳ';
comment on column EMR.PRINTHISTORYNURSE.printpages
  is '��ӡҳ��';
comment on column EMR.PRINTHISTORYNURSE.printdocid
  is '��ӡ��';
comment on column EMR.PRINTHISTORYNURSE.printdatetime
  is '��ӡʱ��';
comment on column EMR.PRINTHISTORYNURSE.printtype
  is '1 ������ 2 ���ᵥ';
alter table EMR.PRINTHISTORYNURSE
  add constraint PK_PHFLOW primary key (PHFLOW)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 576K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table PRINTSETDETAIL
prompt =============================
prompt
create table EMR.PRINTSETDETAIL
(
  id              NUMBER(12) not null,
  parentid        NUMBER(12) not null,
  category        INTEGER not null,
  displaytype     INTEGER,
  dynamicvalue    VARCHAR2(255),
  pageleft        INTEGER,
  pagetop         INTEGER,
  pagewidth       INTEGER,
  pagehigh        INTEGER,
  foreground      INTEGER,
  backgroundcolor INTEGER,
  formatstring    VARCHAR2(255),
  fontname        VARCHAR2(32),
  fontsize        NUMBER(6,1),
  fontstyle       INTEGER,
  homepagemark    INTEGER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.PRINTSETDETAIL
  add constraint PK_PRINTSETDETAIL primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table PRINTTEMPLATE
prompt ============================
prompt
create table EMR.PRINTTEMPLATE
(
  printsetid      NUMBER(12) not null,
  name            VARCHAR2(32) not null,
  papername       VARCHAR2(32) not null,
  paperwidth      INTEGER not null,
  paperhigh       INTEGER not null,
  leftanchor      INTEGER not null,
  aboveanchor     INTEGER not null,
  rightanchor     INTEGER not null,
  belowanchor     INTEGER not null,
  ver             INTEGER not null,
  modifytime      CHAR(19) not null,
  containhomepage INTEGER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.PRINTTEMPLATE
  add constraint PK_PRINTTEMPLATE primary key (PRINTSETID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.PRINTTEMPLATE
  add constraint UC_PRINTTEMPLATE_NAME unique (NAME)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table PROFESSION
prompt =========================
prompt
create table EMR.PROFESSION
(
  prof_code    VARCHAR2(2) not null,
  prof         VARCHAR2(30),
  oper_date    DATE,
  oper_code    VARCHAR2(6),
  spell_code   VARCHAR2(10),
  tj_prof_code VARCHAR2(3)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table QCCONDITION
prompt ==========================
prompt
create table EMR.QCCONDITION
(
  code            VARCHAR2(64) not null,
  category        INTEGER,
  description     VARCHAR2(64) not null,
  condition       VARCHAR2(1024),
  timeinstall     VARCHAR2(1024),
  valid           INTEGER not null,
  memo            VARCHAR2(64),
  tablename       VARCHAR2(32),
  columnname      VARCHAR2(32),
  columnvalue     VARCHAR2(32),
  timecolumnname  VARCHAR2(32),
  timerange       VARCHAR2(32),
  patnocolumnname VARCHAR2(32),
  dblink          VARCHAR2(32)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_CATEGORY on EMR.QCCONDITION (CATEGORY)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.QCCONDITION
  add constraint PK_QCCONDITION primary key (CODE)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table QCGRADE
prompt ======================
prompt
create table EMR.QCGRADE
(
  id          INTEGER not null,
  noofinpat   INTEGER not null,
  category    INTEGER default 0 not null,
  doctor_id   VARCHAR2(6),
  typecode    VARCHAR2(4) not null,
  itemcode    VARCHAR2(5) not null,
  grade       NUMBER(3,1),
  status      INTEGER default 0 not null,
  grade_time  VARCHAR2(24) default sysdate,
  grade_user  VARCHAR2(6),
  create_time VARCHAR2(24) default sysdate not null,
  create_user VARCHAR2(6) not null,
  modify_time VARCHAR2(24),
  modify_user VARCHAR2(6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QCGRADE
  add constraint PK_QCGRADE primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table QCPROBLEM
prompt ========================
prompt
create table EMR.QCPROBLEM
(
  id               NUMBER(12) not null,
  description      VARCHAR2(255) not null,
  times            INTEGER not null,
  deductmark       NUMBER(14,4),
  qclevel          INTEGER,
  noofinpat        NUMBER(9) not null,
  noofrecord       NUMBER(12),
  docotorcode      VARCHAR2(6) not null,
  registeroperator VARCHAR2(6) not null,
  registertime     CHAR(19) not null,
  voidoperator     VARCHAR2(6),
  voidtime         CHAR(19),
  valid            INTEGER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_QCPROBLEM_DOCOTORCODE on EMR.QCPROBLEM (DOCOTORCODE)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_QCPROBLEM_NOOFINPAT on EMR.QCPROBLEM (NOOFINPAT)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_QCPROBLEM_NOOFRECORD on EMR.QCPROBLEM (NOOFRECORD)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_QCPROBLEM_REGISTERTIME on EMR.QCPROBLEM (REGISTERTIME)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QCPROBLEM
  add constraint PK_BL_ZLWTK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table QCPROBLEMDESCRIPTION
prompt ===================================
prompt
create table EMR.QCPROBLEMDESCRIPTION
(
  id             INTEGER not null,
  noofinpat      INTEGER not null,
  category       INTEGER not null,
  status         INTEGER default 0 not null,
  typecode       VARCHAR2(4) not null,
  itemcode       VARCHAR2(5),
  description    VARCHAR2(600),
  ansewercontent VARCHAR2(600),
  confirmcontent VARCHAR2(600),
  doctor_id      VARCHAR2(6),
  problemdate    VARCHAR2(24) default sysdate,
  registerdate   VARCHAR2(24) default sysdate,
  registeruser   VARCHAR2(6) not null,
  answerdate     VARCHAR2(24),
  answeruser     VARCHAR2(6),
  confirmdate    VARCHAR2(24),
  confirmuser    VARCHAR2(6),
  deldate        VARCHAR2(24),
  deluser        VARCHAR2(6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QCPROBLEMDESCRIPTION
  add constraint PK_QCPROBLEMDESCRIPTION primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table QCRECORD
prompt =======================
prompt
create table EMR.QCRECORD
(
  id                 NUMBER(12) not null,
  noofinpat          NUMBER(9) not null,
  noofrecord         VARCHAR2(64),
  rulecode           VARCHAR2(64) not null,
  conditioncode      VARCHAR2(64),
  conditiontime      CHAR(19),
  condition          INTEGER,
  resultcode         VARCHAR2(64),
  resulttime         CHAR(19),
  result             INTEGER,
  foulstate          INTEGER,
  reminder           VARCHAR2(255),
  foulmessage        VARCHAR2(255),
  operatetime        CHAR(19) not null,
  docotorid          VARCHAR2(6),
  crdocotorid        VARCHAR2(6),
  docotorlevel       INTEGER,
  cycletimes         INTEGER,
  valid              INTEGER not null,
  memo               VARCHAR2(64),
  iscycle            VARCHAR2(1),
  firstcyclerecordid VARCHAR2(64),
  timelimit          INTEGER,
  qccode             VARCHAR2(64),
  recorddetailid     VARCHAR2(64),
  score              NUMBER(14,4),
  realconditiontime  CHAR(19),
  isstopcycle        INTEGER,
  islock             INTEGER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 37M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.QCRECORD.islock
  is '1������״̬�� 0����Ǽ���״̬����ʱ�޿����������ж��Ƿ��ѽ������������ٴ�������ļ���';
create index EMR.IDX_QCRECORD_CONDITIONCODE on EMR.QCRECORD (CONDITIONCODE)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 4M
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_QCRECORD_DOCOTORID on EMR.QCRECORD (DOCOTORID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_QCRECORD_NOOFINPAT on EMR.QCRECORD (NOOFINPAT)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 4M
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_QCRECORD_RULECODE on EMR.QCRECORD (RULECODE)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 3M
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.QCRECORD
  add constraint PK_QCRECORD_ID primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 5M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table QCRESULT
prompt =======================
prompt
create table EMR.QCRESULT
(
  code        VARCHAR2(64) not null,
  category    INTEGER not null,
  description VARCHAR2(64) not null,
  result      VARCHAR2(1024),
  time        VARCHAR2(1024),
  valid       INTEGER not null,
  memo        VARCHAR2(64),
  qccode      VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_QCRESULT_CATEGORY on EMR.QCRESULT (CATEGORY)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.QCRESULT
  add constraint PK_CONTROLRESULT primary key (CODE)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table QCRULE
prompt =====================
prompt
create table EMR.QCRULE
(
  rulecode      VARCHAR2(64) not null,
  conditioncode VARCHAR2(64) not null,
  resultcode    VARCHAR2(64),
  description   VARCHAR2(64) not null,
  reminder      VARCHAR2(255),
  foulmessage   VARCHAR2(255),
  timelimit     NUMBER(14,4) not null,
  relatedrule   VARCHAR2(1024),
  relatedmark   INTEGER,
  mark          INTEGER not null,
  cycletimes    INTEGER,
  cycleinterval NUMBER(14,4),
  docotorlevel  INTEGER not null,
  sortcode      VARCHAR2(64),
  valid         INTEGER not null,
  memo          VARCHAR2(64),
  delaytime     INTEGER default 0,
  score         NUMBER(14,4) default 0,
  qccode        VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_CONDITIONCODE on EMR.QCRULE (CONDITIONCODE)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_RESULTCODE on EMR.QCRULE (RESULTCODE)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.QCRULE
  add constraint PK_QCRULE primary key (RULECODE)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table QCSCOREITEM
prompt ==========================
prompt
create table EMR.QCSCOREITEM
(
  itemcode           VARCHAR2(5) not null,
  itemname           VARCHAR2(40) not null,
  iteminstruction    VARCHAR2(60),
  itemdefaultscore   NUMBER(3,1),
  itemstandardscore  NUMBER(3,1),
  itemcategory       NUMBER(3,1) not null,
  itemdefaulttarget  NUMBER(3,1),
  itemtargetstandard NUMBER(3,1),
  itemscorestandard  NUMBER(3,1),
  itemorder          INTEGER,
  typecode           VARCHAR2(4) not null,
  itemmemo           VARCHAR2(60),
  valide             VARCHAR2(1) default '1' not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.QCSCOREITEM
  add constraint PK_QCSCOREITEM primary key (ITEMCODE)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table QCSCORETYPE
prompt ==========================
prompt
create table EMR.QCSCORETYPE
(
  typecode        VARCHAR2(4) not null,
  typename        VARCHAR2(40) not null,
  typeinstruction VARCHAR2(60),
  typecategory    INTEGER not null,
  typeorder       INTEGER,
  typememo        VARCHAR2(60),
  valide          VARCHAR2(1) default '1' not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.QCSCORETYPE
  add constraint PK_QCSCORETYPE primary key (TYPECODE)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table QC_DEPT
prompt ======================
prompt
create table EMR.QC_DEPT
(
  id                NUMBER,
  doc_id            VARCHAR2(6),
  doc_name          VARCHAR2(16),
  dept_id           VARCHAR2(12),
  dept_name         VARCHAR2(32),
  out_hospital      NUMBER,
  oper_count        NUMBER,
  cure_count        NUMBER,
  improve_count     NUMBER,
  die_count         NUMBER,
  other_count       NUMBER,
  before_oper_count NUMBER,
  inhos_count       NUMBER,
  fee               NUMBER,
  flaw_count        NUMBER,
  late_count        NUMBER,
  no_count          NUMBER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table QC_DOCTOR
prompt ========================
prompt
create table EMR.QC_DOCTOR
(
  id                NUMBER,
  doc_id            VARCHAR2(6),
  doc_name          VARCHAR2(16),
  dept_id           VARCHAR2(12),
  dept_name         VARCHAR2(32),
  out_hospital      NUMBER,
  oper_count        NUMBER,
  cure_count        NUMBER,
  improve_count     NUMBER,
  die_count         NUMBER,
  other_count       NUMBER,
  before_oper_count NUMBER,
  inhos_count       NUMBER,
  fee               NUMBER,
  flaw_count        NUMBER,
  late_count        NUMBER,
  no_count          NUMBER,
  nocure_cont       NUMBER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.QC_DOCTOR.out_hospital
  is '��Ժ��';
comment on column EMR.QC_DOCTOR.oper_count
  is '��������';
comment on column EMR.QC_DOCTOR.cure_count
  is '��������';
comment on column EMR.QC_DOCTOR.improve_count
  is '��ת';
comment on column EMR.QC_DOCTOR.die_count
  is '��������';
comment on column EMR.QC_DOCTOR.other_count
  is '����';
comment on column EMR.QC_DOCTOR.before_oper_count
  is '��ǰƽ��סԺ����';
comment on column EMR.QC_DOCTOR.inhos_count
  is 'ƽ��סԺ����';
comment on column EMR.QC_DOCTOR.fee
  is 'ƽ������';
comment on column EMR.QC_DOCTOR.flaw_count
  is 'ȱ����';
comment on column EMR.QC_DOCTOR.late_count
  is '��ز���';
comment on column EMR.QC_DOCTOR.no_count
  is 'δ����';
comment on column EMR.QC_DOCTOR.nocure_cont
  is 'δ��';

prompt
prompt Creating table QC_DOC_RECORD_RATE
prompt =================================
prompt
create table EMR.QC_DOC_RECORD_RATE
(
  id           NUMBER,
  user_id      VARCHAR2(12),
  name         VARCHAR2(40),
  dept_id      VARCHAR2(12),
  dept_name    VARCHAR2(32),
  out_hospital NUMBER,
  a_cnt        NUMBER,
  b_cnt        NUMBER,
  c_cnt        NUMBER,
  qc_rate      NUMBER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.QC_DOC_RECORD_RATE
  is 'ҽʦ�����ʿ���';
comment on column EMR.QC_DOC_RECORD_RATE.a_cnt
  is '���ಡ��';
comment on column EMR.QC_DOC_RECORD_RATE.qc_rate
  is '�ʿ���';

prompt
prompt Creating table QC_HOSPITAL_RATE
prompt ===============================
prompt
create table EMR.QC_HOSPITAL_RATE
(
  id           NUMBER,
  dept_id      VARCHAR2(12),
  dept_name    VARCHAR2(32),
  out_hospital NUMBER,
  a_cnt        NUMBER,
  b_cnt        NUMBER,
  c_cnt        NUMBER,
  qc_rate      NUMBER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.QC_HOSPITAL_RATE
  is 'ȫԺ�����ʿ���';
comment on column EMR.QC_HOSPITAL_RATE.a_cnt
  is '���ಡ��';
comment on column EMR.QC_HOSPITAL_RATE.qc_rate
  is '�ʿ���';

prompt
prompt Creating table QC_SINGLEDISEASE
prompt ===============================
prompt
create table EMR.QC_SINGLEDISEASE
(
  id                NUMBER,
  diag_id           VARCHAR2(16),
  diag_name         VARCHAR2(120),
  out_hospital      NUMBER,
  oper_count        NUMBER,
  cure_count        NUMBER,
  improve_count     NUMBER,
  die_count         NUMBER,
  other_count       NUMBER,
  before_oper_count NUMBER,
  inhos_count       NUMBER,
  fee               NUMBER,
  flaw_count        NUMBER,
  late_count        NUMBER,
  no_count          NUMBER,
  nocure_count      NUMBER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table QLL
prompt ==================
prompt
create table EMR.QLL
(
  id           VARCHAR2(6),
  name         VARCHAR2(16) not null,
  departmentid VARCHAR2(12),
  wardid       VARCHAR2(12),
  password     VARCHAR2(32),
  jobid        VARCHAR2(32),
  iid          VARCHAR2(500)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.QLL
  add primary key (ID)
  disable
  novalidate;

prompt
prompt Creating table QUEST_SOO_AT_TRACE_FILE
prompt ======================================
prompt
create table EMR.QUEST_SOO_AT_TRACE_FILE
(
  trace_file_id       INTEGER not null,
  inst_id             INTEGER not null,
  trace_file_name     VARCHAR2(1000) not null,
  oracle_version      VARCHAR2(1000),
  oracle_home         VARCHAR2(1000),
  os_name             VARCHAR2(1000),
  node_name           VARCHAR2(1000),
  os_version          VARCHAR2(1000),
  instance_name       VARCHAR2(1000),
  oracle_pid          NUMBER,
  os_pid              NUMBER,
  image_name          VARCHAR2(2000),
  last_modified_date  DATE,
  last_analyzed_date  DATE,
  comment_text        VARCHAR2(1000),
  sql_statement_count NUMBER,
  base_datetime_value DATE,
  base_tim_value      NUMBER,
  load_status         VARCHAR2(20),
  lines_loaded        NUMBER,
  process_waits       NUMBER,
  process_binds       NUMBER,
  load_recursive      NUMBER,
  load_elapsed_ms     NUMBER,
  last_debug_message  VARCHAR2(2000),
  error_line_no       NUMBER,
  error_text          VARCHAR2(4000),
  pga_limit           NUMBER
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_TRACE_FILE
  add constraint PK_QUEST_SOO_AT_TRACE_FILE primary key (TRACE_FILE_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_TRACE_FILE
  add constraint UK_QUEST_SOO_AT_TRACE_FILE1 unique (INST_ID, TRACE_FILE_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table QUEST_SOO_AT_SQL_STATEMENT
prompt =========================================
prompt
create table EMR.QUEST_SOO_AT_SQL_STATEMENT
(
  trace_file_id            INTEGER not null,
  sql_id                   NUMBER not null,
  hash_value               NUMBER,
  address                  RAW(4),
  sql_statement_first2000  VARCHAR2(2000),
  parse_count              NUMBER,
  parse_elapsed            NUMBER,
  parse_cpu                NUMBER,
  parse_physical_reads     NUMBER,
  parse_current_reads      NUMBER,
  parse_consistent_reads   NUMBER,
  parse_rows               NUMBER,
  execute_count            NUMBER,
  execute_elapsed          NUMBER,
  execute_cpu              NUMBER,
  execute_physical_reads   NUMBER,
  execute_current_reads    NUMBER,
  execute_consistent_reads NUMBER,
  execute_rows             NUMBER,
  fetch_count              NUMBER,
  fetch_elapsed            NUMBER,
  fetch_cpu                NUMBER,
  fetch_physical_reads     NUMBER,
  fetch_current_reads      NUMBER,
  fetch_consistent_reads   NUMBER,
  fetch_rows               NUMBER
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.QUEST_SOO_AT_HASH_IDX on EMR.QUEST_SOO_AT_SQL_STATEMENT (HASH_VALUE, ADDRESS, SQL_ID)
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_SQL_STATEMENT
  add constraint PK_QUEST_SOO_AT_SQL_STATEMENT primary key (TRACE_FILE_ID, SQL_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_SQL_STATEMENT
  add foreign key (TRACE_FILE_ID)
  references EMR.QUEST_SOO_AT_TRACE_FILE (TRACE_FILE_ID) on delete cascade;

prompt
prompt Creating table QUEST_SOO_AT_PARSE_CURSOR
prompt ========================================
prompt
create table EMR.QUEST_SOO_AT_PARSE_CURSOR
(
  trace_file_id    INTEGER not null,
  sql_id           NUMBER not null,
  parse_id         NUMBER not null,
  session_id       NUMBER,
  serial_number    NUMBER,
  cursor_no        NUMBER not null,
  len              NUMBER,
  dep              NUMBER,
  userid           NUMBER,
  oct              NUMBER,
  lid              NUMBER,
  tim              NUMBER,
  adjusted_time    DATE,
  err              NUMBER,
  cpu              NUMBER,
  elapsed          NUMBER,
  physical_reads   NUMBER,
  consistent_reads NUMBER,
  current_reads    NUMBER,
  libcache_misses  NUMBER,
  row_count        NUMBER,
  optimizer_goal   NUMBER
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_PARSE_CURSOR
  add constraint PK_QUEST_SOO_AT_PARSE_CURSOR primary key (TRACE_FILE_ID, SQL_ID, PARSE_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_PARSE_CURSOR
  add foreign key (TRACE_FILE_ID, SQL_ID)
  references EMR.QUEST_SOO_AT_SQL_STATEMENT (TRACE_FILE_ID, SQL_ID) on delete cascade;

prompt
prompt Creating table QUEST_SOO_AT_APPNAME
prompt ===================================
prompt
create table EMR.QUEST_SOO_AT_APPNAME
(
  mod           VARCHAR2(60) not null,
  mh            NUMBER,
  act           VARCHAR2(60),
  ah            NUMBER,
  trace_file_id INTEGER not null,
  sql_id        NUMBER not null,
  parse_id      NUMBER not null
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_APPNAME
  add constraint PK_QUEST_SOO_AT_APPNAME primary key (TRACE_FILE_ID, SQL_ID, PARSE_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_APPNAME
  add foreign key (TRACE_FILE_ID, SQL_ID, PARSE_ID)
  references EMR.QUEST_SOO_AT_PARSE_CURSOR (TRACE_FILE_ID, SQL_ID, PARSE_ID) on delete cascade;

prompt
prompt Creating table QUEST_SOO_AT_OPERATIONS
prompt ======================================
prompt
create table EMR.QUEST_SOO_AT_OPERATIONS
(
  operation_string VARCHAR2(2000),
  operation_id     INTEGER not null,
  trace_file_id    INTEGER not null
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_OPERATIONS
  add constraint QUEST_SOO_AT_OP_PK primary key (OPERATION_ID, TRACE_FILE_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_OPERATIONS
  add foreign key (TRACE_FILE_ID)
  references EMR.QUEST_SOO_AT_TRACE_FILE (TRACE_FILE_ID) on delete cascade;

prompt
prompt Creating table QUEST_SOO_AT_EXECUTION_PLAN
prompt ==========================================
prompt
create table EMR.QUEST_SOO_AT_EXECUTION_PLAN
(
  trace_file_id INTEGER not null,
  sql_id        NUMBER not null,
  parse_id      NUMBER not null,
  id            NUMBER not null,
  cnt           NUMBER,
  pid           NUMBER,
  pos           NUMBER,
  obj           NUMBER,
  cr            NUMBER,
  pr            NUMBER,
  pw            NUMBER,
  time_us       NUMBER,
  operation_id  INTEGER not null
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_EXECUTION_PLAN
  add constraint PK_QUEST_SOO_AT_EXECUTION_PLAN primary key (TRACE_FILE_ID, SQL_ID, PARSE_ID, ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_EXECUTION_PLAN
  add foreign key (TRACE_FILE_ID, SQL_ID, PARSE_ID)
  references EMR.QUEST_SOO_AT_PARSE_CURSOR (TRACE_FILE_ID, SQL_ID, PARSE_ID) on delete cascade;
alter table EMR.QUEST_SOO_AT_EXECUTION_PLAN
  add foreign key (OPERATION_ID, TRACE_FILE_ID)
  references EMR.QUEST_SOO_AT_OPERATIONS (OPERATION_ID, TRACE_FILE_ID);

prompt
prompt Creating table QUEST_SOO_AT_PARSE_ERROR
prompt =======================================
prompt
create table EMR.QUEST_SOO_AT_PARSE_ERROR
(
  trace_file_id INTEGER not null,
  sql_id        NUMBER not null,
  parse_id      NUMBER not null,
  error_id      NUMBER not null,
  err           NUMBER,
  tim           NUMBER,
  sqlerrm       VARCHAR2(1000)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_PARSE_ERROR
  add constraint PK_QUEST_SOO_AT_PARSE_ERROR primary key (TRACE_FILE_ID, SQL_ID, PARSE_ID, ERROR_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_PARSE_ERROR
  add foreign key (TRACE_FILE_ID, SQL_ID, PARSE_ID)
  references EMR.QUEST_SOO_AT_PARSE_CURSOR (TRACE_FILE_ID, SQL_ID, PARSE_ID) on delete cascade;

prompt
prompt Creating table QUEST_SOO_AT_PARSE_WAITS
prompt =======================================
prompt
create table EMR.QUEST_SOO_AT_PARSE_WAITS
(
  trace_file_id      INTEGER not null,
  sql_id             NUMBER not null,
  parse_id           NUMBER not null,
  wait_id            NUMBER not null,
  nam                VARCHAR2(1000) not null,
  obj#               NUMBER,
  wait_count         NUMBER not null,
  sum_elapsed        NUMBER not null,
  sumsquares_elapsed NUMBER not null
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_PARSE_WAITS
  add constraint KEY1 primary key (TRACE_FILE_ID, SQL_ID, PARSE_ID, WAIT_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_PARSE_WAITS
  add foreign key (TRACE_FILE_ID, SQL_ID, PARSE_ID)
  references EMR.QUEST_SOO_AT_PARSE_CURSOR (TRACE_FILE_ID, SQL_ID, PARSE_ID);

prompt
prompt Creating table QUEST_SOO_AT_SQL_EXECUTIONS
prompt ==========================================
prompt
create table EMR.QUEST_SOO_AT_SQL_EXECUTIONS
(
  trace_file_id    INTEGER not null,
  sql_id           NUMBER not null,
  parse_id         NUMBER not null,
  execution_id     NUMBER not null,
  cpu              NUMBER,
  elapsed          NUMBER,
  physical_reads   NUMBER,
  consistent_reads NUMBER,
  current_reads    NUMBER,
  libcache_misses  NUMBER,
  row_count        NUMBER,
  depth            NUMBER,
  optimizer_goal   NUMBER,
  tim              NUMBER,
  converted_tim    DATE,
  exebnd           NUMBER,
  last_tim         NUMBER,
  bind_vals        VARCHAR2(4000)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_SQL_EXECUTIONS
  add constraint PK_QUEST_SOO_AT_SQL_EXECUTIONS primary key (TRACE_FILE_ID, SQL_ID, PARSE_ID, EXECUTION_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_SQL_EXECUTIONS
  add foreign key (TRACE_FILE_ID, SQL_ID, PARSE_ID)
  references EMR.QUEST_SOO_AT_PARSE_CURSOR (TRACE_FILE_ID, SQL_ID, PARSE_ID) on delete cascade;

prompt
prompt Creating table QUEST_SOO_AT_SESSION_ID
prompt ======================================
prompt
create table EMR.QUEST_SOO_AT_SESSION_ID
(
  session_id    NUMBER not null,
  sid           NUMBER not null,
  serial        NUMBER not null,
  trace_file_id INTEGER not null,
  sql_id        NUMBER not null,
  parse_id      NUMBER not null,
  execution_id  NUMBER not null
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_SESSION_ID
  add constraint PK_QUEST_SOO_AT_SESSION_ID primary key (TRACE_FILE_ID, SQL_ID, PARSE_ID, EXECUTION_ID, SESSION_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_SESSION_ID
  add foreign key (TRACE_FILE_ID, SQL_ID, PARSE_ID, EXECUTION_ID)
  references EMR.QUEST_SOO_AT_SQL_EXECUTIONS (TRACE_FILE_ID, SQL_ID, PARSE_ID, EXECUTION_ID) on delete cascade;

prompt
prompt Creating table QUEST_SOO_AT_SQL_BINDS
prompt =====================================
prompt
create table EMR.QUEST_SOO_AT_SQL_BINDS
(
  trace_file_id INTEGER not null,
  sql_id        NUMBER not null,
  parse_id      NUMBER not null,
  execution_id  NUMBER not null,
  bind_var_id   NUMBER not null,
  value         VARCHAR2(1000),
  dty           NUMBER,
  mxl           VARCHAR2(30),
  mal           VARCHAR2(30),
  scl           VARCHAR2(30),
  pre           VARCHAR2(30),
  oacflg        NUMBER,
  oacfl2        NUMBER,
  bindsize      NUMBER,
  offset        NUMBER,
  bfp           NUMBER,
  bln           NUMBER,
  avl           NUMBER,
  flg           NUMBER,
  exebnd        NUMBER
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_SQL_BINDS
  add constraint PK_QUEST_SOO_AT_SQL_BINDS primary key (TRACE_FILE_ID, SQL_ID, PARSE_ID, EXECUTION_ID, BIND_VAR_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_SQL_BINDS
  add foreign key (TRACE_FILE_ID, SQL_ID, PARSE_ID, EXECUTION_ID)
  references EMR.QUEST_SOO_AT_SQL_EXECUTIONS (TRACE_FILE_ID, SQL_ID, PARSE_ID, EXECUTION_ID) on delete cascade;

prompt
prompt Creating table QUEST_SOO_AT_SQL_EXEC_ERROR
prompt ==========================================
prompt
create table EMR.QUEST_SOO_AT_SQL_EXEC_ERROR
(
  trace_file_id INTEGER not null,
  sql_id        NUMBER not null,
  parse_id      NUMBER not null,
  execution_id  NUMBER not null,
  error_id      CHAR(20) not null,
  tim           NUMBER,
  err           CHAR(20),
  sqlerrm       NVARCHAR2(1000)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_SQL_EXEC_ERROR
  add constraint QUEST_SOO_AT_SQL_EXEC_ERR_PK primary key (TRACE_FILE_ID, SQL_ID, PARSE_ID, EXECUTION_ID, ERROR_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_SQL_EXEC_ERROR
  add foreign key (TRACE_FILE_ID, SQL_ID, PARSE_ID, EXECUTION_ID)
  references EMR.QUEST_SOO_AT_SQL_EXECUTIONS (TRACE_FILE_ID, SQL_ID, PARSE_ID, EXECUTION_ID) on delete cascade;

prompt
prompt Creating table QUEST_SOO_AT_SQL_FETCH
prompt =====================================
prompt
create table EMR.QUEST_SOO_AT_SQL_FETCH
(
  trace_file_id    INTEGER not null,
  sql_id           NUMBER not null,
  parse_id         NUMBER not null,
  execution_id     NUMBER not null,
  fetch_id         NUMBER not null,
  fetch_count      NUMBER not null,
  cpu              NUMBER not null,
  elapsed          NUMBER not null,
  physical_reads   NUMBER,
  consistent_reads NUMBER,
  current_reads    NUMBER,
  libcache_misses  NUMBER,
  row_count        NUMBER,
  depth            NUMBER,
  optimizer_goal   NUMBER,
  tim              NUMBER,
  converted_tim    DATE,
  end_tim          NUMBER
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_SQL_FETCH
  add constraint PK_QUEST_SOO_AT_SQL_FETCH primary key (TRACE_FILE_ID, SQL_ID, PARSE_ID, EXECUTION_ID, FETCH_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_SQL_FETCH
  add foreign key (TRACE_FILE_ID, SQL_ID, PARSE_ID, EXECUTION_ID)
  references EMR.QUEST_SOO_AT_SQL_EXECUTIONS (TRACE_FILE_ID, SQL_ID, PARSE_ID, EXECUTION_ID) on delete cascade;

prompt
prompt Creating table QUEST_SOO_AT_SQL_STMT_PIECES
prompt ===========================================
prompt
create table EMR.QUEST_SOO_AT_SQL_STMT_PIECES
(
  trace_file_id INTEGER not null,
  sql_id        NUMBER not null,
  piece_no      NUMBER not null,
  sql_text      VARCHAR2(1000)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_SQL_STMT_PIECES
  add constraint PK_QUEST_SOO_AT_SQL_STMT_P primary key (TRACE_FILE_ID, SQL_ID, PIECE_NO)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_SQL_STMT_PIECES
  add foreign key (TRACE_FILE_ID, SQL_ID)
  references EMR.QUEST_SOO_AT_SQL_STATEMENT (TRACE_FILE_ID, SQL_ID) on delete cascade;

prompt
prompt Creating table QUEST_SOO_AT_WAIT_NAMES
prompt ======================================
prompt
create table EMR.QUEST_SOO_AT_WAIT_NAMES
(
  event_id NUMBER not null,
  nam      VARCHAR2(256)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_WAIT_NAMES
  add constraint QUEST_SOO_AT_WAIT_NAMES_PK primary key (EVENT_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_WAIT_NAMES
  add constraint QUEST_SOO_AT_WAIT_NAMES_UK unique (NAM)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table QUEST_SOO_AT_SQL_WAITS
prompt =====================================
prompt
create table EMR.QUEST_SOO_AT_SQL_WAITS
(
  trace_file_id      INTEGER not null,
  sql_id             NUMBER not null,
  parse_id           NUMBER not null,
  execution_id       NUMBER not null,
  wait_id            NUMBER not null,
  obj#               NUMBER,
  wait_count         NUMBER not null,
  sum_elapsed        NUMBER,
  sumsquares_elapsed NUMBER,
  event_id           NUMBER not null
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_SQL_WAITS
  add constraint PK_QUEST_SOO_AT_SQL_WAITS primary key (TRACE_FILE_ID, SQL_ID, PARSE_ID, EXECUTION_ID, WAIT_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.QUEST_SOO_AT_SQL_WAITS
  add foreign key (TRACE_FILE_ID, SQL_ID, PARSE_ID)
  references EMR.QUEST_SOO_AT_PARSE_CURSOR (TRACE_FILE_ID, SQL_ID, PARSE_ID) on delete cascade;
alter table EMR.QUEST_SOO_AT_SQL_WAITS
  add foreign key (EVENT_ID)
  references EMR.QUEST_SOO_AT_WAIT_NAMES (EVENT_ID);

prompt
prompt Creating table QUEST_SOO_BUFFER_BUSY
prompt ====================================
prompt
create table EMR.QUEST_SOO_BUFFER_BUSY
(
  timestamp DATE,
  p1        NUMBER,
  p2        NUMBER,
  p3        NUMBER
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table QUEST_SOO_EVENT_CATEGORIES
prompt =========================================
prompt
create table EMR.QUEST_SOO_EVENT_CATEGORIES
(
  name        VARCHAR2(64),
  topcategory VARCHAR2(20),
  subcategory VARCHAR2(30),
  category    VARCHAR2(30),
  seg_stat    VARCHAR2(30)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table QUEST_SOO_LOCK_TREE
prompt ==================================
prompt
create table EMR.QUEST_SOO_LOCK_TREE
(
  user_audsid  NUMBER,
  sequence_id  NUMBER,
  agent_id     VARCHAR2(100),
  tree_depth   NUMBER,
  sid          NUMBER,
  serial       NUMBER,
  username     VARCHAR2(30),
  pid          VARCHAR2(16),
  lock_type    VARCHAR2(90),
  request_mode VARCHAR2(30),
  object_name  VARCHAR2(61)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table QUEST_SOO_PARSE_TIME_TRACK
prompt =========================================
prompt
create table EMR.QUEST_SOO_PARSE_TIME_TRACK
(
  parse_time_elapsed NUMBER,
  time_stamp         DATE
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table QUEST_SOO_PLAN_TABLE
prompt ===================================
prompt
create table EMR.QUEST_SOO_PLAN_TABLE
(
  statement_id    VARCHAR2(60),
  timestamp       DATE,
  remarks         VARCHAR2(2000),
  operation       VARCHAR2(30),
  options         VARCHAR2(30),
  object_node     VARCHAR2(128),
  object_owner    VARCHAR2(30),
  object_name     VARCHAR2(30),
  object_instance NUMBER,
  object_type     VARCHAR2(30),
  search_columns  NUMBER,
  id              NUMBER,
  parent_id       NUMBER,
  position        NUMBER,
  other           LONG,
  collector       VARCHAR2(31),
  address         VARCHAR2(16),
  hash_value      NUMBER,
  optimizer       VARCHAR2(255),
  cost            NUMBER,
  cardinality     NUMBER,
  bytes           NUMBER,
  other_tag       VARCHAR2(255),
  partition_start VARCHAR2(255),
  partition_stop  VARCHAR2(255),
  partition_id    INTEGER,
  join_text       VARCHAR2(1000),
  filter_text     VARCHAR2(1000),
  view_text       VARCHAR2(1000)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table QUEST_SOO_SB_BUFFER_BUSY
prompt =======================================
prompt
create table EMR.QUEST_SOO_SB_BUFFER_BUSY
(
  class         VARCHAR2(18),
  waits         NUMBER,
  pct_of_count  NUMBER,
  pct_of_time   NUMBER,
  logical_reads NUMBER,
  ratio         NUMBER,
  note          VARCHAR2(64),
  time          NUMBER
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table QUEST_SOO_SB_EVENT
prompt =================================
prompt
create table EMR.QUEST_SOO_SB_EVENT
(
  event           VARCHAR2(64),
  total_waits     NUMBER,
  time_waited     NUMBER,
  average_wait    NUMBER,
  pct_time_waited NUMBER,
  pct_total_waits NUMBER,
  sum_waits       NUMBER,
  sum_times       NUMBER,
  note            VARCHAR2(10)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table QUEST_SOO_SB_IO_STAT
prompt ===================================
prompt
create table EMR.QUEST_SOO_SB_IO_STAT
(
  file_no         NUMBER,
  tablespace_name VARCHAR2(30),
  file_name       VARCHAR2(513),
  device_name     VARCHAR2(513),
  short_name      VARCHAR2(513),
  phywrts         NUMBER,
  phyrds          NUMBER,
  phyblkwrt       NUMBER,
  phyblkrd        NUMBER,
  blocks          NUMBER,
  tot_io          NUMBER,
  readtim         NUMBER,
  writetim        NUMBER
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table QUEST_SOO_SCHEMA_VERSIONS
prompt ========================================
prompt
create table EMR.QUEST_SOO_SCHEMA_VERSIONS
(
  schema_id VARCHAR2(256) not null,
  version   NUMBER not null
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.QUEST_SOO_SCHEMA_VERSIONS
  add primary key (SCHEMA_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table QUEST_SOO_VERSION
prompt ================================
prompt
create table EMR.QUEST_SOO_VERSION
(
  soo_full_version      VARCHAR2(16),
  soo_bin_version       VARCHAR2(16),
  soo_obj_version       VARCHAR2(16),
  qc_full_version       VARCHAR2(16),
  mdk_full_version      VARCHAR2(16),
  agent_full_version    VARCHAR2(16),
  oracle_version        VARCHAR2(16),
  oracle_banner         VARCHAR2(200),
  server_machine_name   VARCHAR2(100),
  agent_package_soo     VARCHAR2(100),
  agent_package_unix    VARCHAR2(100),
  agent_package_windows VARCHAR2(100),
  mdk_note              VARCHAR2(100),
  soo_note              VARCHAR2(100),
  agent_note            VARCHAR2(100),
  qc_note               VARCHAR2(100),
  note                  VARCHAR2(200)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table QUEST_TEMP_EXPLAIN
prompt =================================
prompt
create global temporary table EMR.QUEST_TEMP_EXPLAIN
(
  statement_id    VARCHAR2(30),
  timestamp       DATE,
  remarks         VARCHAR2(80),
  operation       VARCHAR2(30),
  options         VARCHAR2(30),
  object_node     VARCHAR2(128),
  object_owner    VARCHAR2(30),
  object_name     VARCHAR2(30),
  object_instance INTEGER,
  object_type     VARCHAR2(30),
  optimizer       VARCHAR2(255),
  search_columns  INTEGER,
  id              INTEGER,
  parent_id       INTEGER,
  position        INTEGER,
  cost            INTEGER,
  cardinality     INTEGER,
  bytes           INTEGER,
  other_tag       VARCHAR2(255),
  partition_start VARCHAR2(255),
  partition_stop  VARCHAR2(255),
  partition_id    INTEGER,
  other           LONG,
  distribution    VARCHAR2(30),
  cpu_cost        INTEGER,
  io_cost         INTEGER,
  temp_space      INTEGER
)
on commit preserve rows;

prompt
prompt Creating table RECORDDETAIL
prompt ===========================
prompt
create table EMR.RECORDDETAIL
(
  id                NUMBER(12) not null,
  noofinpat         INTEGER not null,
  templateid        VARCHAR2(64) not null,
  name              VARCHAR2(300) not null,
  recorddesc        VARCHAR2(255),
  content           CLOB,
  sortid            VARCHAR2(12),
  owner             VARCHAR2(6) not null,
  auditor           VARCHAR2(6),
  createtime        CHAR(19),
  audittime         CHAR(19),
  valid             INTEGER,
  hassubmit         INTEGER,
  hasprint          INTEGER,
  hassign           INTEGER,
  captiondatetime   CHAR(19),
  islock            INTEGER,
  firstdailyflag    CHAR(1) default 0,
  isyihuangoutong   VARCHAR2(1),
  ip                VARCHAR2(64),
  isconfigpagesize  VARCHAR2(1),
  departcode        VARCHAR2(50),
  wardcode          VARCHAR2(50),
  startupdateflag   CHAR(36),
  endupdateflag     CHAR(36),
  isemrcontentsplit NUMBER,
  changeid          NUMBER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 248M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.RECORDDETAIL.firstdailyflag
  is '�״β��̱�־λ';
comment on column EMR.RECORDDETAIL.isyihuangoutong
  is '�Ƿ�ҽ����ͨ';
comment on column EMR.RECORDDETAIL.isemrcontentsplit
  is '�����Ƿ��ֹ��ı�ʾ 1:�Ѳ��';
comment on column EMR.RECORDDETAIL.changeid
  is 'ת�Ƽ�¼ID INPATIENTCHANGEINFO.ID';
create index EMR.INK_RD_NOOFINPAT on EMR.RECORDDETAIL (NOOFINPAT)
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 19M
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.RECORDDETAIL
  add constraint PK_RECORDDETAIL primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 17M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table RECORDDETAIL_CLINIC
prompt ==================================
prompt
create table EMR.RECORDDETAIL_CLINIC
(
  id               NUMBER(12) not null,
  noofinpatclinic  INTEGER not null,
  templateid       VARCHAR2(64) not null,
  name             VARCHAR2(300) not null,
  content          CLOB,
  sortid           VARCHAR2(12),
  isopenedit       VARCHAR2(1),
  isconfigpagesize VARCHAR2(1),
  auditorid        VARCHAR2(6),
  audittime        DATE,
  createuserid     VARCHAR2(6),
  createtime       DATE,
  modifyuserid     VARCHAR2(6),
  modifytime       DATE,
  canceluserid     VARCHAR2(6),
  canceltime       DATE,
  valid            INTEGER
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table RECORDDETAIL_ERROR2013
prompt =====================================
prompt
create table EMR.RECORDDETAIL_ERROR2013
(
  id              NUMBER not null,
  recorddetail_id NUMBER not null,
  noofinpat       NUMBER,
  content         CLOB not null,
  reason          NVARCHAR2(300),
  errortime       DATE,
  ip              NVARCHAR2(32),
  valid           NUMBER,
  memo            NVARCHAR2(300)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.RECORDDETAIL_ERROR2013.id
  is 'Ψһ��ʶID';
comment on column EMR.RECORDDETAIL_ERROR2013.recorddetail_id
  is '������ID';
comment on column EMR.RECORDDETAIL_ERROR2013.noofinpat
  is '������';
comment on column EMR.RECORDDETAIL_ERROR2013.content
  is '��������';
comment on column EMR.RECORDDETAIL_ERROR2013.reason
  is '����ԭ��';
comment on column EMR.RECORDDETAIL_ERROR2013.errortime
  is '����ʱ��';
comment on column EMR.RECORDDETAIL_ERROR2013.ip
  is 'IP';
comment on column EMR.RECORDDETAIL_ERROR2013.valid
  is '�Ƿ���Ч';
comment on column EMR.RECORDDETAIL_ERROR2013.memo
  is '����';
alter table EMR.RECORDDETAIL_ERROR2013
  add constraint PK_RECORDDETAIL_ERRORID primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table RECORDTRIGGER
prompt ============================
prompt
create table EMR.RECORDTRIGGER
(
  id          NUMBER(12) not null,
  name        VARCHAR2(64),
  condition   VARCHAR2(4000),
  result      LONG,
  description VARCHAR2(255),
  range       INTEGER not null,
  model       VARCHAR2(255),
  type        INTEGER not null,
  valid       INTEGER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.RECORDTRIGGER
  add constraint PK_RECORDTRIGGER primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table REGISTER_ITEM
prompt ============================
prompt
create table EMR.REGISTER_ITEM
(
  d_type   VARCHAR2(4) not null,
  d_name   VARCHAR2(40) not null,
  example  VARCHAR2(40),
  d_column VARCHAR2(20),
  d_table  VARCHAR2(20),
  d_sql    VARCHAR2(250)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table REGULAR
prompt ======================
prompt
create table EMR.REGULAR
(
  id    INTEGER not null,
  name  VARCHAR2(16) not null,
  value VARCHAR2(64) not null,
  valid INTEGER not null,
  memo  VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.REGULAR
  add constraint PK_REGULAR primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table REPLENISHPATREC
prompt ==============================
prompt
create table EMR.REPLENISHPATREC
(
  id         NUMBER(9) not null,
  noofinpat  NUMBER(9) not null,
  createuser VARCHAR2(6) not null,
  createdate VARCHAR2(19) not null,
  reason     VARCHAR2(255),
  days       NUMBER(6,1) not null,
  valid      INTEGER not null
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 448K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table REPORTCATEGORY
prompt =============================
prompt
create table EMR.REPORTCATEGORY
(
  id         NUMBER(9) not null,
  name       VARCHAR2(100) not null,
  valid      INTEGER,
  orderid    NUMBER(9),
  tablename  VARCHAR2(100),
  printmodel VARCHAR2(100)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.REPORTCATEGORY.id
  is '����';
comment on column EMR.REPORTCATEGORY.name
  is '���濨����';
comment on column EMR.REPORTCATEGORY.valid
  is '�Ƿ���Ч 1����Ч;0����Ч';
comment on column EMR.REPORTCATEGORY.orderid
  is '����';
comment on column EMR.REPORTCATEGORY.tablename
  is '���濨������';
comment on column EMR.REPORTCATEGORY.printmodel
  is '��ӡģ������';
alter table EMR.REPORTCATEGORY
  add constraint PK_ID primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table REPORTTEMPLETE
prompt =============================
prompt
create table EMR.REPORTTEMPLETE
(
  reportid     INTEGER not null,
  reportname   VARCHAR2(25),
  templetepath VARCHAR2(500),
  createtime   VARCHAR2(20),
  valid        INTEGER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on column EMR.REPORTTEMPLETE.reportid
  is '�������';
comment on column EMR.REPORTTEMPLETE.reportname
  is '��������';
comment on column EMR.REPORTTEMPLETE.templetepath
  is '����·��';
comment on column EMR.REPORTTEMPLETE.createtime
  is '��������';
comment on column EMR.REPORTTEMPLETE.valid
  is '��Ч��־';
alter table EMR.REPORTTEMPLETE
  add constraint PK_REPORTTEMPLETE_ID primary key (REPORTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table RULECATEGORY
prompt ===========================
prompt
create table EMR.RULECATEGORY
(
  code        VARCHAR2(64) not null,
  description VARCHAR2(64) not null,
  py          VARCHAR2(8),
  wb          VARCHAR2(8),
  valid       INTEGER not null,
  memo        VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.RULECATEGORY
  add constraint PK_RULECATEGORY primary key (CODE)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SEQ_TOTABLECOLUMN
prompt ================================
prompt
create table EMR.SEQ_TOTABLECOLUMN
(
  id         NUMBER,
  seqname    VARCHAR2(50),
  tablename  VARCHAR2(50),
  columnname VARCHAR2(50)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SPDRUGPRESCRIPTION
prompt =================================
prompt
create table EMR.SPDRUGPRESCRIPTION
(
  id             NUMBER(12) not null,
  rangeccategory VARCHAR2(2) not null,
  rangevalue     VARCHAR2(16) not null,
  drugmark       INTEGER not null,
  sortcode       VARCHAR2(12) not null,
  clinicalcode   VARCHAR2(12),
  placeid        NUMBER(9) not null,
  drugid         VARCHAR2(12) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.SPDRUGPRESCRIPTION
  add constraint PK_SPDRUGPRESCRIPTION primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table SQLN_PROF_ANB
prompt ============================
prompt
create table EMR.SQLN_PROF_ANB
(
  runid       NUMBER not null,
  unit_number NUMBER not null,
  line#       NUMBER not null,
  text        VARCHAR2(2048)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on table EMR.SQLN_PROF_ANB
  is 'Annonymous block source';
comment on column EMR.SQLN_PROF_ANB.runid
  is 'PLSQL_PROFILER_RUNS';
comment on column EMR.SQLN_PROF_ANB.unit_number
  is 'PLSQL_PROFILER_UNITS';
alter table EMR.SQLN_PROF_ANB
  add constraint PK_SQLN_PROF_ANB primary key (RUNID, UNIT_NUMBER, LINE#)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.SQLN_PROF_ANB
  add constraint FK_SQLN_ANB foreign key (RUNID, UNIT_NUMBER)
  references EMR.PLSQL_PROFILER_UNITS (RUNID, UNIT_NUMBER);

prompt
prompt Creating table SQLN_PROF_PROFILES
prompt =================================
prompt
create table EMR.SQLN_PROF_PROFILES
(
  proj_id      NUMBER not null,
  proj_name    VARCHAR2(2047),
  proj_comment VARCHAR2(2047)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.SQLN_PROF_PROFILES
  add constraint PK_PROJ_ID primary key (PROJ_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table SQLN_PROF_RUNS
prompt =============================
prompt
create table EMR.SQLN_PROF_RUNS
(
  proj_id NUMBER not null,
  runid   NUMBER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.SQLN_PROF_RUNS
  add constraint PK_SQLN_PROF_RUNS primary key (PROJ_ID, RUNID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.SQLN_PROF_RUNS
  add constraint FK_PROJ_RUNID foreign key (RUNID)
  references EMR.PLSQL_PROFILER_RUNS (RUNID);
alter table EMR.SQLN_PROF_RUNS
  add constraint FK_PROJ_RUNS_PROJ_ID foreign key (PROJ_ID)
  references EMR.SQLN_PROF_PROFILES (PROJ_ID);

prompt
prompt Creating table SQLN_PROF_SESS
prompt =============================
prompt
create table EMR.SQLN_PROF_SESS
(
  runid   NUMBER not null,
  stat_id NUMBER not null,
  value   NUMBER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on table EMR.SQLN_PROF_SESS
  is 'Session Statistics Info For a Run';
comment on column EMR.SQLN_PROF_SESS.runid
  is 'PLSQL_PROFILER_RUNS';
comment on column EMR.SQLN_PROF_SESS.stat_id
  is 'STATISTIC# from V$STATNAME';
comment on column EMR.SQLN_PROF_SESS.value
  is 'VALUE from V$SESSTAT for a session SID and STATISTIC#';
alter table EMR.SQLN_PROF_SESS
  add constraint PK_SQLN_PROF_SESS primary key (RUNID, STAT_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.SQLN_PROF_SESS
  add foreign key (RUNID)
  references EMR.PLSQL_PROFILER_RUNS (RUNID);

prompt
prompt Creating table SQLN_PROF_UNITS
prompt ==============================
prompt
create table EMR.SQLN_PROF_UNITS
(
  proj_id   NUMBER not null,
  unit_name VARCHAR2(30) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.SQLN_PROF_UNITS
  add constraint PK_SQLN_PROF_UNITS primary key (PROJ_ID, UNIT_NAME)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.SQLN_PROF_UNITS
  add constraint FK_PROJ_ID foreign key (PROJ_ID)
  references EMR.SQLN_PROF_PROFILES (PROJ_ID);

prompt
prompt Creating table SQLN_PROF_UNIT_HASH
prompt ==================================
prompt
create table EMR.SQLN_PROF_UNIT_HASH
(
  runid       NUMBER not null,
  unit_number NUMBER not null,
  hash        VARCHAR2(32)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on table EMR.SQLN_PROF_UNIT_HASH
  is 'Hash of unit source code (1:1 with PLSQL_PROFILER_UNITS)';
alter table EMR.SQLN_PROF_UNIT_HASH
  add constraint PK_SQLN_PROF_HASH primary key (RUNID, UNIT_NUMBER)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.SQLN_PROF_UNIT_HASH
  add constraint FK_SQLN_UNIT_HASH foreign key (RUNID, UNIT_NUMBER)
  references EMR.PLSQL_PROFILER_UNITS (RUNID, UNIT_NUMBER);

prompt
prompt Creating table SRTC
prompt ===================
prompt
create table EMR.SRTC
(
  contentid VARCHAR2(18) not null,
  formalid  VARCHAR2(18),
  status    INTEGER not null,
  name      VARCHAR2(255) not null,
  enname    VARCHAR2(255) not null,
  py        VARCHAR2(8),
  wb        VARCHAR2(8),
  diseaseid VARCHAR2(12),
  refid     VARCHAR2(255),
  category  VARCHAR2(64),
  mark      INTEGER,
  extraid   VARCHAR2(12),
  style     VARCHAR2(2),
  levelid   VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.SRTC
  add constraint PK_SRTC primary key (CONTENTID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table SRTD
prompt ===================
prompt
create table EMR.SRTD
(
  id        NUMBER(12) not null,
  status    INTEGER not null,
  contentid VARCHAR2(18) not null,
  name      VARCHAR2(255),
  enname    VARCHAR2(255),
  py        VARCHAR2(8),
  wb        VARCHAR2(8),
  sensitive INTEGER,
  style     INTEGER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 13M
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.SRTD
  add constraint PK_SRTD primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 3M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SRTM
prompt ===================
prompt
create table EMR.SRTM
(
  catalid   VARCHAR2(18) not null,
  catalname VARCHAR2(64) not null,
  enname    VARCHAR2(255),
  preid     VARCHAR2(18) default (''),
  srtmlevel INTEGER,
  startid   VARCHAR2(18) not null,
  endid     VARCHAR2(18) not null,
  valid     INTEGER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.SRTM
  add constraint PK_SRTM primary key (CATALID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table STUDENT
prompt ======================
prompt
create table EMR.STUDENT
(
  stuname VARCHAR2(10),
  stuno   VARCHAR2(4),
  age     NUMBER,
  gender  VARCHAR2(2 CHAR)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table SURGERY
prompt ======================
prompt
create table EMR.SURGERY
(
  id           VARCHAR2(12) not null,
  mapid        VARCHAR2(16),
  standardcode VARCHAR2(12),
  name         VARCHAR2(64) not null,
  py           VARCHAR2(8),
  wb           VARCHAR2(8),
  valid        INTEGER not null,
  memo         VARCHAR2(16),
  bzlb         VARCHAR2(4) default (''),
  sslb         INTEGER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 384K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.IDX_SURGERY_MAPID on EMR.SURGERY (MAPID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.SURGERY
  add constraint PK_YY_BZSSDMK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SURGERYHISTORY
prompt =============================
prompt
create table EMR.SURGERYHISTORY
(
  id          NUMBER(9) not null,
  noofinpat   NUMBER(9) not null,
  surgeryid   VARCHAR2(12) not null,
  diagnosisid VARCHAR2(12) not null,
  discuss     VARCHAR2(255),
  doctor      VARCHAR2(255),
  memo        VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_SURGERYHISTORYPATNOOFHIS on EMR.SURGERYHISTORY (NOOFINPAT)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.SURGERYHISTORY
  add constraint PK_SURGERYHISTORYID primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table SYMBOLCATEGORY
prompt =============================
prompt
create table EMR.SYMBOLCATEGORY
(
  id   INTEGER not null,
  name VARCHAR2(64) not null,
  memo VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.SYMBOLCATEGORY
  add constraint PK_SYMBOLCATEGORY primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYMBOLS
prompt ======================
prompt
create table EMR.SYMBOLS
(
  id         INTEGER not null,
  rtf        LONG not null,
  categroyid INTEGER not null,
  length     INTEGER,
  memo       VARCHAR2(64),
  content    VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.SYMBOLS.id
  is 'seq_SymbolCategory_ID.Nextval';
alter table EMR.SYMBOLS
  add constraint PK_SYMBOLS primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYSPRINTMODEL
prompt ============================
prompt
create table EMR.SYSPRINTMODEL
(
  modelname     VARCHAR2(32) not null,
  description   VARCHAR2(64),
  modelcontent  CLOB not null,
  extensionset  LONG,
  modelcategory VARCHAR2(4) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.SYSPRINTMODEL
  add constraint PK_SYSPRINTMODEL primary key (MODELNAME)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table SYS_SIGN_ITEM
prompt ============================
prompt
create table EMR.SYS_SIGN_ITEM
(
  id       VARCHAR2(36) not null,
  userid   VARCHAR2(50),
  appid    VARCHAR2(50),
  signtype VARCHAR2(50),
  signdata LONG,
  summary  VARCHAR2(2000),
  signtime VARCHAR2(24)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_SIGN_SEAL
prompt ============================
prompt
create table EMR.SYS_SIGN_SEAL
(
  id   VARCHAR2(36) not null,
  name VARCHAR2(50),
  seal LONG
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table SYS_SIGN_USER
prompt ============================
prompt
create table EMR.SYS_SIGN_USER
(
  id   VARCHAR2(50) not null,
  name VARCHAR2(50)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table SYS_SIGN_USER_CERT
prompt =================================
prompt
create table EMR.SYS_SIGN_USER_CERT
(
  userid   VARCHAR2(50),
  certid   VARCHAR2(50),
  password VARCHAR2(50),
  cert     LONG
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table SYS_SIGN_USER_SEAL
prompt =================================
prompt
create table EMR.SYS_SIGN_USER_SEAL
(
  id     VARCHAR2(36) not null,
  userid VARCHAR2(50),
  sealid VARCHAR2(36)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table S_CITY
prompt =====================
prompt
create table EMR.S_CITY
(
  cityid      NUMBER(29) not null,
  cityname    VARCHAR2(500) not null,
  zipcode     NVARCHAR2(50),
  provinceid  NUMBER(29),
  datecreated DATE,
  dateupdated DATE,
  py          VARCHAR2(12),
  wb          VARCHAR2(12)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table S_DISTRICT
prompt =========================
prompt
create table EMR.S_DISTRICT
(
  districtid   NUMBER(29) not null,
  districtname NVARCHAR2(50),
  cityid       NUMBER(29),
  datecreated  DATE,
  dateupdated  DATE,
  py           VARCHAR2(12),
  wb           VARCHAR2(12)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table S_PROVINCE
prompt =========================
prompt
create table EMR.S_PROVINCE
(
  provinceid   NUMBER(29) not null,
  provincename VARCHAR2(500) not null,
  datecreated  DATE,
  dateupdated  DATE,
  py           VARCHAR2(12),
  wb           VARCHAR2(12)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TEMPLATEPERSONGROUP
prompt ==================================
prompt
create table EMR.TEMPLATEPERSONGROUP
(
  id               INTEGER not null,
  userid           VARCHAR2(6) not null,
  nodeid           INTEGER not null,
  parentnodeid     INTEGER not null,
  nodename         VARCHAR2(64) not null,
  templatepersonid INTEGER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.TEMPLATEPERSONGROUP
  add constraint PK_TEMPLATEPERSONGROUP primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TEMPLATESORT_PERSON
prompt ==================================
prompt
create table EMR.TEMPLATESORT_PERSON
(
  id     NUMBER(12) not null,
  name   VARCHAR2(64) not null,
  userid VARCHAR2(12) not null,
  mark   INTEGER not null,
  valid  INTEGER not null,
  memo   VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.TEMPLATESORT_PERSON
  add constraint PK_TEMPLATESORT_PERSON primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TEMPLATETABLESORT
prompt ================================
prompt
create table EMR.TEMPLATETABLESORT
(
  id    NUMBER(9) not null,
  name  VARCHAR2(50) not null,
  valid INTEGER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.TEMPLATETABLESORT
  add constraint PK_TEMPLATETABLESORT primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TEMPLATE_COLLECT
prompt ===============================
prompt
create table EMR.TEMPLATE_COLLECT
(
  id         INTEGER not null,
  noofinpat  NUMBER(9) not null,
  createuser VARCHAR2(6) not null,
  createtime DATE not null,
  valid      VARCHAR2(2) not null,
  content    CLOB not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 26M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.TEMPLATE_COLLECT
  is '������ȡ';
comment on column EMR.TEMPLATE_COLLECT.id
  is 'ID';
comment on column EMR.TEMPLATE_COLLECT.noofinpat
  is '������ҳ��';
comment on column EMR.TEMPLATE_COLLECT.createuser
  is '�����ˣ�����';
comment on column EMR.TEMPLATE_COLLECT.createtime
  is '����ʱ��';
comment on column EMR.TEMPLATE_COLLECT.valid
  is '��Ч�� 1 ��Ч 0 ��Ч';
comment on column EMR.TEMPLATE_COLLECT.content
  is '������ȡ������';

prompt
prompt Creating table TEMPLATE_DEPARTMENT
prompt ==================================
prompt
create table EMR.TEMPLATE_DEPARTMENT
(
  templateid VARCHAR2(64) not null,
  department VARCHAR2(12) not null,
  valid      INTEGER not null,
  memo       VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 256K
  );
alter table EMR.TEMPLATE_DEPARTMENT
  add constraint PK_TEMPLATE_DEPARTMENT primary key (TEMPLATEID, DEPARTMENT)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 256K
  );

prompt
prompt Creating table TEMPLATE_PERSON
prompt ==============================
prompt
create table EMR.TEMPLATE_PERSON
(
  id               NUMBER(12) not null,
  templateid       VARCHAR2(64),
  name             VARCHAR2(64),
  userid           VARCHAR2(12),
  valid            INTEGER,
  content          CLOB,
  sortid           VARCHAR2(12),
  sortmark         INTEGER,
  sharedid         INTEGER,
  memo             VARCHAR2(2000),
  py               VARCHAR2(20),
  wb               VARCHAR2(20),
  type             VARCHAR2(1),
  isconfigpagesize VARCHAR2(1),
  deptid           VARCHAR2(12)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 704K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.TEMPLATE_PERSON.type
  is '1:����ģ�� 2:����ģ��';
alter table EMR.TEMPLATE_PERSON
  add constraint PK_TEMPLATE_PERSON primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TEMPLATE_RECENT
prompt ==============================
prompt
create table EMR.TEMPLATE_RECENT
(
  id         NUMBER(12) not null,
  templateid VARCHAR2(64) not null,
  name       VARCHAR2(64) not null,
  userid     VARCHAR2(12) not null,
  valid      INTEGER not null,
  total      INTEGER not null,
  sortid     VARCHAR2(12) not null,
  memo       VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.TEMPLATE_RECENT
  add constraint PK_TEMPLATE_RECENT primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TEMPLATE_TABLE
prompt =============================
prompt
create table EMR.TEMPLATE_TABLE
(
  id       NUMBER(9) not null,
  name     VARCHAR2(64) not null,
  describe VARCHAR2(255),
  content  BLOB not null,
  version  VARCHAR2(32),
  sortid   VARCHAR2(12),
  valid    INTEGER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.TEMPLATE_TABLE
  add constraint PK_TEMPLATE_TABLE primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TEMPLET2HISDEPT
prompt ==============================
prompt
create table EMR.TEMPLET2HISDEPT
(
  templetid   VARCHAR2(6) not null,
  his_dept_id VARCHAR2(8) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 896K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TEMPUSERS
prompt ========================
prompt
create table EMR.TEMPUSERS
(
  userid    VARCHAR2(6) not null,
  masterid  VARCHAR2(6) not null,
  startdate CHAR(19) not null,
  enddate   CHAR(19) not null,
  memo      VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.TEMPUSERS
  add constraint PK_TEMPUSERS primary key (USERID, MASTERID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TEMP_ORDER
prompt =========================
prompt
create table EMR.TEMP_ORDER
(
  tempid           NUMBER(12) not null,
  noofinpat        NUMBER(9) not null,
  groupid          NUMBER(12) not null,
  groupflag        INTEGER not null,
  wardid           VARCHAR2(12) not null,
  deptid           VARCHAR2(12) not null,
  typedoctor       VARCHAR2(6) not null,
  typedate         CHAR(19) not null,
  auditor          VARCHAR2(16),
  dateofaudit      CHAR(19),
  executor         VARCHAR2(16),
  executedate      CHAR(19),
  canceldoctor     VARCHAR2(6),
  canceldate       CHAR(19),
  startdate        CHAR(19),
  productno        NUMBER(9) not null,
  normno           NUMBER(9) not null,
  medicineno       NUMBER(9) not null,
  drugno           VARCHAR2(12) not null,
  drugname         VARCHAR2(64),
  drugnorm         VARCHAR2(32),
  itemtype         INTEGER not null,
  minunit          VARCHAR2(8),
  drugdose         NUMBER(14,3),
  doseunit         VARCHAR2(8),
  unitrate         NUMBER(12,4),
  unittype         INTEGER,
  druguse          VARCHAR2(2),
  batchno          VARCHAR2(2) default (''),
  executecount     INTEGER default (1),
  executecycle     INTEGER default (1),
  cycleunit        INTEGER default (-1),
  dateofweek       CHAR(7) default (''),
  innerexecutetime VARCHAR2(64),
  zxts             INTEGER,
  totaldose        NUMBER(14,3),
  entrust          VARCHAR2(64),
  ordertype        INTEGER not null,
  orderstatus      INTEGER not null,
  specialmark      INTEGER not null,
  ceaseid          NUMBER(12),
  ceasedate        CHAR(19),
  content          VARCHAR2(255),
  synch            INTEGER,
  memo             VARCHAR2(64),
  formtype         VARCHAR2(4)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_TEMP_ORDER_GROUPID on EMR.TEMP_ORDER (GROUPID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_TEMP_ORDER_NOOFINPAT on EMR.TEMP_ORDER (NOOFINPAT)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.TEMP_ORDER
  add constraint PK_TEMP_ORDER primary key (TEMPID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TEST_PERSON_INFO
prompt ===============================
prompt
create table EMR.TEST_PERSON_INFO
(
  id   INTEGER not null,
  name VARCHAR2(50),
  sex  VARCHAR2(50),
  age  INTEGER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table THERE_CHECK_EVENT
prompt ================================
prompt
create table EMR.THERE_CHECK_EVENT
(
  id           VARCHAR2(4),
  name         VARCHAR2(10),
  isshowtime   VARCHAR2(1),
  valid        VARCHAR2(1),
  showlocation VARCHAR2(3) default 42
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.THERE_CHECK_EVENT
  is '���ⵥ�в����¼�';
comment on column EMR.THERE_CHECK_EVENT.id
  is '�¼����';
comment on column EMR.THERE_CHECK_EVENT.name
  is '�¼�����';
comment on column EMR.THERE_CHECK_EVENT.isshowtime
  is '�Ƿ���ʾʱ�� 1����ʾ  0������ʾ';
comment on column EMR.THERE_CHECK_EVENT.valid
  is '�Ƿ���Ч';
comment on column EMR.THERE_CHECK_EVENT.showlocation
  is '��ʾλ��   һ���¼���ʾ��42��һ�£�����ٵ��¼���ʾ��34��һ��';

prompt
prompt Creating table THERIOMAREPORTCARD
prompt =================================
prompt
create table EMR.THERIOMAREPORTCARD
(
  report_id             VARCHAR2(10) not null,
  report_districtid     VARCHAR2(10),
  report_districtname   VARCHAR2(300),
  report_icd10          VARCHAR2(64),
  report_icd0           VARCHAR2(64),
  report_clinicid       VARCHAR2(100),
  report_patid          VARCHAR2(20),
  report_indo           VARCHAR2(40),
  report_inpatname      NVARCHAR2(10),
  sexid                 VARCHAR2(2),
  realage               VARCHAR2(4),
  birthdate             VARCHAR2(19),
  nationid              VARCHAR2(10),
  nationname            VARCHAR2(20),
  contacttel            VARCHAR2(40),
  martial               VARCHAR2(4),
  occupation            VARCHAR2(10),
  officeaddress         VARCHAR2(100),
  orgprovinceid         VARCHAR2(10),
  orgcityid             VARCHAR2(10),
  orgdistrictid         VARCHAR2(10),
  orgtownid             VARCHAR2(10),
  orgvilliage           VARCHAR2(10),
  orgprovincename       VARCHAR2(100),
  orgcityname           VARCHAR2(100),
  orgdistrictname       VARCHAR2(100),
  orgtown               VARCHAR2(100),
  orgvillagename        VARCHAR2(100),
  xzzprovinceid         VARCHAR2(10),
  xzzcityid             VARCHAR2(10),
  xzzdistrictid         VARCHAR2(10),
  xzztownid             VARCHAR2(10),
  xzzvilliageid         VARCHAR2(10),
  xzzprovince           VARCHAR2(100),
  xzzcity               VARCHAR2(100),
  xzzdistrict           VARCHAR2(100),
  xzztown               VARCHAR2(100),
  xzzvilliage           VARCHAR2(100),
  report_diagnosis      VARCHAR2(64),
  pathologicaltype      VARCHAR2(64),
  pathologicalid        VARCHAR2(64),
  qzdiagtime_t          VARCHAR2(10),
  qzdiagtime_n          VARCHAR2(10),
  qzdiagtime_m          VARCHAR2(10),
  firstdiadate          VARCHAR2(19),
  reportinfunit         VARCHAR2(64),
  reportdoctor          VARCHAR2(10),
  reportdate            VARCHAR2(19),
  deathdate             VARCHAR2(19),
  deathreason           VARCHAR2(100),
  rejest                CLOB,
  report_ydiagnosis     VARCHAR2(100),
  report_ydiagnosisdata VARCHAR2(19),
  report_diagnosisbased VARCHAR2(100),
  report_no             VARCHAR2(64) not null,
  report_noofinpat      VARCHAR2(19),
  state                 VARCHAR2(1),
  create_date           VARCHAR2(19),
  create_usercode       VARCHAR2(6),
  create_username       VARCHAR2(32),
  create_deptcode       VARCHAR2(12),
  create_deptname       VARCHAR2(32),
  modify_date           VARCHAR2(19),
  modify_usercode       VARCHAR2(6),
  modify_username       VARCHAR2(32),
  modify_deptcode       VARCHAR2(12),
  modify_deptname       VARCHAR2(32),
  audit_date            VARCHAR2(19),
  audit_usercode        VARCHAR2(6),
  audit_username        VARCHAR2(32),
  audit_deptcode        VARCHAR2(12),
  audit_deptname        VARCHAR2(32),
  vaild                 VARCHAR2(2) default 1,
  diagicd10             VARCHAR2(32),
  cancelreason          VARCHAR2(200),
  cardtype              CHAR(2),
  clinicalstages        VARCHAR2(50),
  reportdiagfunit       VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table THREE_LEVEL_CHECK
prompt ================================
prompt
create table EMR.THREE_LEVEL_CHECK
(
  resident_id   VARCHAR2(6),
  attend_id     VARCHAR2(6),
  chief_id      VARCHAR2(6),
  create_time   DATE,
  create_user   VARCHAR2(6),
  valid         VARCHAR2(1),
  resident_name VARCHAR2(20),
  attend_name   VARCHAR2(20),
  chief_name    VARCHAR2(20),
  dept_id       VARCHAR2(12),
  dept_name     VARCHAR2(32)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TMP_DEPARTMENTLIST
prompt =================================
prompt
create table EMR.TMP_DEPARTMENTLIST
(
  deptcode       VARCHAR2(10),
  deptname       VARCHAR2(100),
  inhos          INTEGER,
  bedcnt         INTEGER,
  wrtdeficitcnt  INTEGER,
  timelimitedcnt INTEGER,
  haveselectcnt  INTEGER,
  selectave      INTEGER,
  norecords      INTEGER
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TMP_EMR_QUERYORDERSUITES
prompt =======================================
prompt
create table EMR.TMP_EMR_QUERYORDERSUITES
(
  groupid         NUMBER(9) not null,
  detailid        NUMBER(9),
  mark            INTEGER,
  sortmark        INTEGER,
  placeofdrug     NUMBER(9),
  standardofdrug  NUMBER(9),
  clinicidofdrug  NUMBER(9),
  drugid          VARCHAR2(12),
  drugname        VARCHAR2(64),
  itemcategory    INTEGER,
  minunit         VARCHAR2(10),
  dose            NUMBER(14,3),
  doseunit        VARCHAR2(8),
  measurementunit NUMBER(12,4),
  unitcategory    INTEGER,
  useageid        VARCHAR2(2),
  frequency       VARCHAR2(2),
  executions      INTEGER,
  executecycle    INTEGER,
  cycleunit       INTEGER,
  zid             CHAR(7),
  executedate     VARCHAR2(64),
  executedays     INTEGER,
  druggross       NUMBER(14,3),
  advicecontent   VARCHAR2(64),
  advicecategory  INTEGER,
  name            VARCHAR2(32) not null,
  deptid          VARCHAR2(12),
  wardid          VARCHAR2(12),
  doctorid        VARCHAR2(6),
  userange        INTEGER,
  memo            VARCHAR2(64),
  py              VARCHAR2(8),
  wb              VARCHAR2(8),
  yfmc            VARCHAR2(16),
  pcmc            VARCHAR2(16)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TMP_GETUSERINFO
prompt ==============================
prompt
create table EMR.TMP_GETUSERINFO
(
  userid   VARCHAR2(12),
  masterid VARCHAR2(12),
  status   INTEGER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TMP_JOBDISEASE
prompt =============================
prompt
create table EMR.TMP_JOBDISEASE
(
  jobid      VARCHAR2(4),
  jobname    VARCHAR2(14),
  diagid     VARCHAR2(12),
  diagname   VARCHAR2(64),
  diseasecnt INTEGER,
  diecnt     INTEGER
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 384K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TMP_MEDQCANALYSIS
prompt ================================
prompt
create table EMR.TMP_MEDQCANALYSIS
(
  deptcode    VARCHAR2(10),
  deptname    VARCHAR2(100),
  inhos       INTEGER,
  newinhos    INTEGER,
  newouthos   INTEGER,
  bedcnt      INTEGER,
  emptybedcnt INTEGER,
  addbedcnt   INTEGER,
  diecnt      INTEGER,
  surgerycnt  INTEGER,
  gravecnt    INTEGER,
  outhosfail  INTEGER,
  kssr        INTEGER,
  yzb         INTEGER
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.TMP_MEDQCANALYSIS.kssr
  is '��������';
comment on column EMR.TMP_MEDQCANALYSIS.yzb
  is 'ҩռ��';

prompt
prompt Creating table TMP_NEWFZXH
prompt ==========================
prompt
create table EMR.TMP_NEWFZXH
(
  cqlsbz    INTEGER not null,
  yzxh      INTEGER not null,
  groupid   INTEGER not null,
  groupflag INTEGER not null,
  ordertype INTEGER not null,
  memo      VARCHAR2(50)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.TMP_NEWFZXH
  add constraint PK_NEWFZXH primary key (YZXH, CQLSBZ)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TMP_QUERYBROWSERINWARD
prompt =====================================
prompt
create table EMR.TMP_QUERYBROWSERINWARD
(
  deptcode    VARCHAR2(10),
  deptname    VARCHAR2(100),
  inhos       INTEGER,
  newinhos    INTEGER,
  newouthos   INTEGER,
  bedcnt      INTEGER,
  emptybedcnt INTEGER,
  addbedcnt   INTEGER,
  diecnt      INTEGER,
  surgerycnt  INTEGER,
  gravecnt    INTEGER,
  outhosfail  INTEGER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TMP_QUERYBROWSERINWARDPAT
prompt ========================================
prompt
create table EMR.TMP_QUERYBROWSERINWARDPAT
(
  noofinpat  NUMBER(9),
  patnoofhis VARCHAR2(14),
  patid      VARCHAR2(24),
  patname    VARCHAR2(32),
  sex        VARCHAR2(4),
  sexname    VARCHAR2(4),
  agestr     VARCHAR2(16),
  py         VARCHAR2(8),
  wb         VARCHAR2(8),
  brzt       INTEGER,
  wzjb       VARCHAR2(2),
  wzjbmc     VARCHAR2(32),
  hljb       VARCHAR2(8),
  yebz       INTEGER,
  bqdm       VARCHAR2(12),
  ksdm       VARCHAR2(12),
  bedid      VARCHAR2(12),
  ybqdm      VARCHAR2(12),
  yksdm      VARCHAR2(12),
  ycwdm      VARCHAR2(12),
  inbed      INTEGER,
  jcbz       INTEGER,
  cwlx       INTEGER,
  admitdate  VARCHAR2(19),
  ryzd       VARCHAR2(64),
  zdmc       VARCHAR2(64),
  zyysdm     VARCHAR2(6),
  zyys       VARCHAR2(16),
  cwys       VARCHAR2(16),
  zzys       VARCHAR2(16),
  zrys       VARCHAR2(16),
  yxjl       INTEGER,
  pzlx       VARCHAR2(12),
  extra      VARCHAR2(20),
  memo       VARCHAR2(64),
  cpstatus   VARCHAR2(6),
  iswarn     VARCHAR2(2),
  ye         INTEGER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TMP_QUERYBROWSERINWARDPATEXIST
prompt =============================================
prompt
create table EMR.TMP_QUERYBROWSERINWARDPATEXIST
(
  noofinpat  NUMBER(9),
  patnoofhis VARCHAR2(14),
  patid      VARCHAR2(24),
  patname    VARCHAR2(32),
  sex        VARCHAR2(4),
  sexname    VARCHAR2(4),
  agestr     VARCHAR2(16),
  py         VARCHAR2(8),
  wb         VARCHAR2(8),
  brzt       INTEGER,
  wzjb       VARCHAR2(2),
  wzjbmc     VARCHAR2(32),
  hljb       VARCHAR2(8),
  yebz       INTEGER,
  bqdm       VARCHAR2(12),
  ksdm       VARCHAR2(12),
  bedid      VARCHAR2(12),
  ybqdm      VARCHAR2(12),
  yksdm      VARCHAR2(12),
  ycwdm      VARCHAR2(12),
  inbed      INTEGER,
  jcbz       INTEGER,
  cwlx       INTEGER,
  admitdate  VARCHAR2(19),
  ryzd       VARCHAR2(64),
  zdmc       VARCHAR2(64),
  zyysdm     VARCHAR2(6),
  zyys       VARCHAR2(16),
  cwys       VARCHAR2(16),
  zzys       VARCHAR2(16),
  zrys       VARCHAR2(16),
  yxjl       INTEGER,
  pzlx       VARCHAR2(12),
  extra      VARCHAR2(20),
  memo       VARCHAR2(64),
  ye         INTEGER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TMP_QUERYBROWSERINWARD_EXTRAOP
prompt =============================================
prompt
create table EMR.TMP_QUERYBROWSERINWARD_EXTRAOP
(
  noofinpat NUMBER(9),
  diff      NUMBER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TMP_QUERYHISTORY_PATS
prompt ====================================
prompt
create table EMR.TMP_QUERYHISTORY_PATS
(
  innerpix VARCHAR2(32)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TMP_QUERYHISTORY_RESULT
prompt ======================================
prompt
create table EMR.TMP_QUERYHISTORY_RESULT
(
  noofinpat      NUMBER(9),
  patnoofhis     VARCHAR2(14),
  patid          VARCHAR2(24),
  name           VARCHAR2(32),
  sexid          VARCHAR2(4),
  nativeaddress  VARCHAR2(64),
  admitdate      VARCHAR2(19),
  admitdept      VARCHAR2(32),
  admitward      VARCHAR2(32),
  admitdiagnosis VARCHAR2(64),
  outhosdate     VARCHAR2(19),
  outhosdept     VARCHAR2(32),
  outhosward     VARCHAR2(32),
  outdiagnosis   VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TMP_QUERYINWARDPATIENTS
prompt ======================================
prompt
create table EMR.TMP_QUERYINWARDPATIENTS
(
  noofinpat   NUMBER(9),
  patnoofhis  VARCHAR2(14),
  patid       VARCHAR2(24),
  patname     VARCHAR2(32),
  sex         VARCHAR2(4),
  sexname     VARCHAR2(4),
  agestr      VARCHAR2(16),
  py          VARCHAR2(8),
  wb          VARCHAR2(8),
  brzt        INTEGER,
  brztname    VARCHAR2(16),
  wzjb        VARCHAR2(2),
  wzjbmc      VARCHAR2(32),
  hljb        VARCHAR2(16),
  attendlevel INTEGER,
  yebz        INTEGER,
  yebzname    VARCHAR2(2),
  bqdm        VARCHAR2(12),
  ksdm        VARCHAR2(12),
  bedid       VARCHAR2(12),
  ksmc        VARCHAR2(32),
  bqmc        VARCHAR2(32),
  ybqdm       VARCHAR2(12),
  yksdm       VARCHAR2(12),
  ycwdm       VARCHAR2(12),
  inbed       INTEGER,
  jcbz        INTEGER,
  cwlx        INTEGER,
  admitdate   VARCHAR2(19),
  ryzd        VARCHAR2(64),
  zdmc        VARCHAR2(64),
  zyysdm      VARCHAR2(6),
  zyys        VARCHAR2(16),
  cwys        VARCHAR2(16),
  zzys        VARCHAR2(16),
  zrys        VARCHAR2(16),
  yxjl        INTEGER,
  pzlx        VARCHAR2(18),
  extra       VARCHAR2(60),
  memo        VARCHAR2(64),
  cpstatus    VARCHAR2(6),
  recordinfo  VARCHAR2(6),
  ye          INTEGER,
  iswarn      VARCHAR2(2),
  rycs        VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TMP_QUERYINWARDPATS_EXTRAOP
prompt ==========================================
prompt
create table EMR.TMP_QUERYINWARDPATS_EXTRAOP
(
  noofinpat NUMBER(9),
  diff      NUMBER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TMP_QUERYOWNMANAGERPAT
prompt =====================================
prompt
create table EMR.TMP_QUERYOWNMANAGERPAT
(
  noofinpat  NUMBER(9),
  patnoofhis VARCHAR2(14),
  patid      VARCHAR2(24),
  patname    VARCHAR2(32),
  sex        VARCHAR2(4),
  sexname    VARCHAR2(32),
  agestr     VARCHAR2(16),
  arzt       INTEGER,
  arztname   VARCHAR2(16),
  wzjbmc     VARCHAR2(32),
  wzjb       VARCHAR2(4),
  admitdate  VARCHAR2(19),
  ryzd       VARCHAR2(12),
  zdmc       VARCHAR2(64),
  pzlx       VARCHAR2(32),
  ksmc       VARCHAR2(32),
  bqmc       VARCHAR2(32),
  bedid      VARCHAR2(12),
  iswarn     VARCHAR2(2),
  recordinfo VARCHAR2(6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TMP_QUERYQCGRADE
prompt ===============================
prompt
create table EMR.TMP_QUERYQCGRADE
(
  typecode           VARCHAR2(4),
  typename           VARCHAR2(40),
  typeinstruction    VARCHAR2(60),
  typecategory       INTEGER,
  typeorder          INTEGER,
  typememo           VARCHAR2(60),
  itemcode           VARCHAR2(5),
  itemname           VARCHAR2(40),
  iteminstruction    VARCHAR2(60),
  itemdefaultscore   NUMBER(3,1),
  itemdefaulttarget  NUMBER(3,1),
  ower               VARCHAR2(2),
  owername           VARCHAR2(5),
  itemtargetstandard NUMBER(3,1),
  itemstandardscore  NUMBER(3,1),
  itemorder          INTEGER,
  itemmemo           VARCHAR2(60)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TMP_QUERYQUITPATIENTNODOCTOR
prompt ===========================================
prompt
create table EMR.TMP_QUERYQUITPATIENTNODOCTOR
(
  noofinpat  NUMBER(9),
  patnoofhis VARCHAR2(14),
  patid      VARCHAR2(24),
  patname    VARCHAR2(32),
  sex        VARCHAR2(4),
  sexname    VARCHAR2(4),
  agestr     VARCHAR2(16),
  py         VARCHAR2(8),
  wb         VARCHAR2(8),
  brzt       INTEGER,
  brztname   VARCHAR2(16),
  wzjb       VARCHAR2(2),
  wzjbmc     VARCHAR2(32),
  hljb       VARCHAR2(8),
  yebz       INTEGER,
  yebzname   VARCHAR2(2),
  bqdm       VARCHAR2(12),
  ksdm       VARCHAR2(12),
  bedid      VARCHAR2(12),
  ksmc       VARCHAR2(32),
  bqmc       VARCHAR2(32),
  ybqdm      VARCHAR2(12),
  yksdm      VARCHAR2(12),
  ycwdm      VARCHAR2(12),
  admitdate  VARCHAR2(19),
  ryzd       VARCHAR2(64),
  zdmc       VARCHAR2(64),
  zyysdm     VARCHAR2(6),
  zyys       VARCHAR2(16),
  cwys       VARCHAR2(16),
  zzys       VARCHAR2(16),
  zrys       VARCHAR2(16),
  pzlx       VARCHAR2(18),
  extra      VARCHAR2(20),
  memo       VARCHAR2(64),
  cpstatus   VARCHAR2(6),
  recordinfo VARCHAR2(6),
  ye         INTEGER,
  iswarn     VARCHAR2(2)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TMP_QUERYQUITPATIENTNO_EXTRAOP
prompt =============================================
prompt
create table EMR.TMP_QUERYQUITPATIENTNO_EXTRAOP
(
  noofinpat NUMBER(9),
  diff      NUMBER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TMP_TEMPLET
prompt ==========================
prompt
create table EMR.TMP_TEMPLET
(
  name        VARCHAR2(64),
  id          VARCHAR2(12),
  templetid   VARCHAR2(64) not null,
  templetname VARCHAR2(64),
  describe    VARCHAR2(255),
  previd      VARCHAR2(12),
  groupname   VARCHAR2(4000),
  groupname2  VARCHAR2(4000)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 704K
  );

prompt
prompt Creating table TMP_ZYMOSIS_ANALYSE
prompt ==================================
prompt
create table EMR.TMP_ZYMOSIS_ANALYSE
(
  level_id    VARCHAR2(2),
  level_name  VARCHAR2(20),
  icd_code    VARCHAR2(12),
  name        VARCHAR2(255),
  cnt         VARCHAR2(12),
  attack_rate NUMBER(8,4),
  die_cnt     VARCHAR2(8),
  die_rate    NUMBER(8,4)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TOXICOSIS
prompt ========================
prompt
create table EMR.TOXICOSIS
(
  id           VARCHAR2(12) not null,
  mapid        VARCHAR2(16),
  standardcode VARCHAR2(12) not null,
  name         VARCHAR2(64) not null,
  py           VARCHAR2(8),
  wb           VARCHAR2(8),
  valid        INTEGER not null,
  memo         VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.TOXICOSIS
  add constraint PK_TOXICOSIS primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TRACKRECORD
prompt ==========================
prompt
create table EMR.TRACKRECORD
(
  id         NUMBER(12) not null,
  menu       VARCHAR2(64) not null,
  module     VARCHAR2(64) not null,
  userid     VARCHAR2(6) not null,
  deptid     VARCHAR2(12) not null,
  wardid     VARCHAR2(12) not null,
  noofinpat  NUMBER(9) not null,
  recordid   VARCHAR2(64) not null,
  recordname VARCHAR2(64) not null,
  intime     CHAR(19),
  leavetime  CHAR(19),
  trackiime  CHAR(19) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_TRACKRECORD_DEPTID on EMR.TRACKRECORD (DEPTID, WARDID, USERID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_TRACKRECORD_NOOFINPAT on EMR.TRACKRECORD (NOOFINPAT)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
create index EMR.IDX_TRACKRECORD_TRACKIIME on EMR.TRACKRECORD (TRACKIIME)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.TRACKRECORD
  add constraint PK_TRACKRECORD primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table TUMOR
prompt ====================
prompt
create table EMR.TUMOR
(
  id           VARCHAR2(20) not null,
  mapid        VARCHAR2(20),
  name         VARCHAR2(100) not null,
  py           VARCHAR2(50),
  wb           VARCHAR2(50),
  valid        INTEGER not null,
  memo         VARCHAR2(16),
  standardcode VARCHAR2(12)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.TUMOR
  add constraint PK_TUMOR primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table T_PARSE
prompt ======================
prompt
create table EMR.T_PARSE
(
  id    VARCHAR2(50),
  name  CLOB,
  value CLOB
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table UNITS
prompt ====================
prompt
create table EMR.UNITS
(
  id           VARCHAR2(12) not null,
  name         VARCHAR2(16) not null,
  py           VARCHAR2(8),
  wb           VARCHAR2(8),
  display      VARCHAR2(64),
  unitcategory INTEGER not null,
  basicunit    INTEGER not null,
  rate         FLOAT not null,
  valid        INTEGER not null,
  memo         VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.UNITS
  add constraint PK_UNITS primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table UNITSORT
prompt =======================
prompt
create table EMR.UNITSORT
(
  id       INTEGER not null,
  name     VARCHAR2(16) not null,
  defautid VARCHAR2(12),
  regular  VARCHAR2(64) not null,
  valid    INTEGER not null,
  memo     VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.UNITSORT
  add constraint PK_UNITSORT primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table USAGEMAPPING
prompt ===========================
prompt
create table EMR.USAGEMAPPING
(
  placeid     NUMBER(9) not null,
  usageid     VARCHAR2(2) not null,
  frequencyid VARCHAR2(2) not null,
  dosage      NUMBER(14,3),
  minunit     VARCHAR2(12),
  days        INTEGER default (1),
  mark        INTEGER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.USAGEMAPPING
  add constraint PK_USAGEMAPPING primary key (PLACEID, MARK)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table USER2DEPT
prompt ========================
prompt
create table EMR.USER2DEPT
(
  userid VARCHAR2(6) not null,
  deptid VARCHAR2(12) not null,
  wardid VARCHAR2(12) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.USER2DEPT
  add constraint PK_USER2DEPT primary key (USERID, DEPTID, WARDID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table USERCFG
prompt ======================
prompt
create table EMR.USERCFG
(
  id        INTEGER not null,
  configkey VARCHAR2(32) not null,
  cfgvalue  LONG not null,
  userid    VARCHAR2(12)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
alter table EMR.USERCFG
  add constraint PK_USERCFG primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table USERMATCHDISEASESGROUP
prompt =====================================
prompt
create table EMR.USERMATCHDISEASESGROUP
(
  id          NUMBER(12) not null,
  userid      VARCHAR2(10) not null,
  username    VARCHAR2(32),
  groupids    VARCHAR2(300),
  valid       NUMBER(1) not null,
  create_user VARCHAR2(10),
  create_time VARCHAR2(19),
  updateuser  VARCHAR2(10),
  updatetime  VARCHAR2(19),
  memo        VARCHAR2(300)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.USERMATCHDISEASESGROUP.id
  is '�Զ�������ˮ��';
comment on column EMR.USERMATCHDISEASESGROUP.userid
  is 'Ա������';
comment on column EMR.USERMATCHDISEASESGROUP.username
  is 'Ա������';
comment on column EMR.USERMATCHDISEASESGROUP.groupids
  is '�������ID����(��$���ŷָ�)';
comment on column EMR.USERMATCHDISEASESGROUP.valid
  is '�Ƿ���Ч(0-��Ч��1-��Ч)';
comment on column EMR.USERMATCHDISEASESGROUP.create_user
  is '������';
comment on column EMR.USERMATCHDISEASESGROUP.create_time
  is '����ʱ��';
comment on column EMR.USERMATCHDISEASESGROUP.updateuser
  is '������';
comment on column EMR.USERMATCHDISEASESGROUP.updatetime
  is '����ʱ��';
comment on column EMR.USERMATCHDISEASESGROUP.memo
  is '��ע';
alter table EMR.USERMATCHDISEASESGROUP
  add primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table USERPICSIGN
prompt ==========================
prompt
create table EMR.USERPICSIGN
(
  userpicflow    VARCHAR2(50) not null,
  userid         VARCHAR2(20) not null,
  createdatetime VARCHAR2(20),
  createuserid   VARCHAR2(20),
  createusername VARCHAR2(20),
  valide         VARCHAR2(1),
  userpic        CLOB
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.USERPICSIGN
  is 'ͼƬǩ����';
comment on column EMR.USERPICSIGN.userpicflow
  is '����';
comment on column EMR.USERPICSIGN.userid
  is '�û�ID���';
comment on column EMR.USERPICSIGN.createdatetime
  is '	����ʱ��';
comment on column EMR.USERPICSIGN.createuserid
  is '������Id';
comment on column EMR.USERPICSIGN.createusername
  is '������';
comment on column EMR.USERPICSIGN.valide
  is '1Ϊʹ�� 0 Ϊɾ��';
alter table EMR.USERPICSIGN
  add constraint PK_USERPICSIGN primary key (USERPICFLOW)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table USERS
prompt ====================
prompt
create table EMR.USERS
(
  id           VARCHAR2(6) not null,
  name         VARCHAR2(16) not null,
  py           VARCHAR2(8),
  wb           VARCHAR2(8),
  sexy         VARCHAR2(4),
  birth        CHAR(10),
  marital      VARCHAR2(2),
  idno         VARCHAR2(18),
  deptid       VARCHAR2(12),
  wardid       VARCHAR2(12),
  category     VARCHAR2(12),
  jobtitle     VARCHAR2(12),
  recipeid     VARCHAR2(6),
  recipemark   INTEGER,
  narcosismark INTEGER,
  groupid      VARCHAR2(32),
  grade        VARCHAR2(4),
  passwd       VARCHAR2(32),
  jobid        VARCHAR2(255),
  regdate      VARCHAR2(19),
  operator     VARCHAR2(6),
  onlinestate  INTEGER default (0),
  status       INTEGER default (1),
  valid        INTEGER not null,
  memo         VARCHAR2(16),
  power        NUMBER(1),
  hisid        VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 512K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column EMR.USERS.power
  is '����Ȩ��';
comment on column EMR.USERS.hisid
  is '��Ӧ��HIS����';
alter table EMR.USERS
  add constraint PK_USERS primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table USER_DEPT
prompt ========================
prompt
create table EMR.USER_DEPT
(
  userid VARCHAR2(6) not null,
  deptid VARCHAR2(12) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table EMR.USER_DEPT
  add constraint PK_USER_DEPT primary key (USERID, DEPTID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table USER_LOGIN
prompt =========================
prompt
create table EMR.USER_LOGIN
(
  id          VARCHAR2(4) not null,
  module_id   VARCHAR2(255),
  hostname    VARCHAR2(255),
  macaddr     VARCHAR2(255) not null,
  client_ip   VARCHAR2(255) not null,
  reason_id   VARCHAR2(1),
  create_time VARCHAR2(24) default sysdate not null,
  create_user VARCHAR2(4) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table WARD
prompt ===================
prompt
create table EMR.WARD
(
  id       VARCHAR2(12) not null,
  name     VARCHAR2(32) not null,
  py       VARCHAR2(16),
  wb       VARCHAR2(12),
  hosno    VARCHAR2(12),
  totalbed INTEGER,
  mark     INTEGER not null,
  valid    INTEGER not null,
  memo     VARCHAR2(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.WARD
  add constraint PK_WARD primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table WEBTREE
prompt ======================
prompt
create table EMR.WEBTREE
(
  id         INTEGER not null,
  name       VARCHAR2(20),
  url        VARCHAR2(400),
  parentid   INTEGER,
  ordervalue INTEGER,
  valid      VARCHAR2(1) default '1' not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.WEBTREE
  add constraint PK_WEBTREE primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ZX_DIAGSABOUTBABY
prompt ================================
prompt
create table EMR.ZX_DIAGSABOUTBABY
(
  id       NUMBER(12) not null,
  icd      VARCHAR2(50),
  diagname VARCHAR2(50) not null,
  valid    NUMBER(2) not null
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.ZX_DIAGSABOUTBABY
  add constraint PK_ZX_DIAGSABOUTBABY primary key (ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ZYMOSIS_AFP
prompt ==========================
prompt
create table EMR.ZYMOSIS_AFP
(
  afpid            VARCHAR2(50) not null,
  reportid         INTEGER not null,
  householdscope   VARCHAR2(50),
  householdaddress VARCHAR2(50),
  address          VARCHAR2(50),
  palsydate        VARCHAR2(50),
  palsysymptom     VARCHAR2(500),
  vaild            VARCHAR2(1) default 1,
  creator          VARCHAR2(50),
  createdate       VARCHAR2(50),
  mender           VARCHAR2(50),
  alterdate        VARCHAR2(50),
  diagnosisdate    VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on table EMR.ZYMOSIS_AFP
  is 'AFP�����';
comment on column EMR.ZYMOSIS_AFP.afpid
  is 'AFP ID��';
comment on column EMR.ZYMOSIS_AFP.reportid
  is '����ID��';
comment on column EMR.ZYMOSIS_AFP.householdscope
  is '�������ڵط�Χ';
comment on column EMR.ZYMOSIS_AFP.householdaddress
  is '������ַ';
comment on column EMR.ZYMOSIS_AFP.address
  is '��ϸ��ַ';
comment on column EMR.ZYMOSIS_AFP.palsydate
  is '�������';
comment on column EMR.ZYMOSIS_AFP.palsysymptom
  is '���֢״';
comment on column EMR.ZYMOSIS_AFP.vaild
  is '״̬�Ƿ���Ч  1����Ч   0����Ч';
comment on column EMR.ZYMOSIS_AFP.creator
  is '������';
comment on column EMR.ZYMOSIS_AFP.createdate
  is '����ʱ��';
comment on column EMR.ZYMOSIS_AFP.mender
  is '�޸���';
comment on column EMR.ZYMOSIS_AFP.alterdate
  is '�޸�ʱ��';
comment on column EMR.ZYMOSIS_AFP.diagnosisdate
  is '���־��������';
alter table EMR.ZYMOSIS_AFP
  add constraint ZYMOSIS_AFP_PK primary key (AFPID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table ZYMOSIS_DIAGNOSIS
prompt ================================
prompt
create table EMR.ZYMOSIS_DIAGNOSIS
(
  markid        VARCHAR2(32) not null,
  icd           VARCHAR2(50),
  mapid         VARCHAR2(16),
  standardcode  VARCHAR2(12),
  name          VARCHAR2(64) not null,
  py            VARCHAR2(8),
  wb            VARCHAR2(8),
  tumorid       VARCHAR2(12) default (''),
  statist       VARCHAR2(4),
  innercategory VARCHAR2(4) default (''),
  category      VARCHAR2(4) default (''),
  othercategroy INTEGER,
  valid         INTEGER not null,
  level_id      VARCHAR2(8),
  memo          VARCHAR2(16),
  namestr       VARCHAR2(64),
  upcount       INTEGER default 1 not null,
  categoryid    INTEGER default 1 not null,
  fukatype      VARCHAR2(2)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column EMR.ZYMOSIS_DIAGNOSIS.namestr
  is '��Ⱦ���ϱ�����';
alter table EMR.ZYMOSIS_DIAGNOSIS
  add constraint PK_ZYMOSIS_DIAGNOSIS primary key (MARKID, CATEGORYID, VALID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ZYMOSIS_H1N1
prompt ===========================
prompt
create table EMR.ZYMOSIS_H1N1
(
  h1n1id         VARCHAR2(50) not null,
  reportid       INTEGER not null,
  casetype       VARCHAR2(50),
  hospitalstatus VARCHAR2(50),
  iscure         VARCHAR2(50),
  isoverseas     VARCHAR2(50),
  vaild          VARCHAR2(1) default 1,
  creator        VARCHAR2(50),
  createdate     VARCHAR2(50),
  mender         VARCHAR2(50),
  alterdate      VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on table EMR.ZYMOSIS_H1N1
  is '����H1N1���б����';
comment on column EMR.ZYMOSIS_H1N1.h1n1id
  is '����H1N1����ID��';
comment on column EMR.ZYMOSIS_H1N1.reportid
  is '����ID��';
comment on column EMR.ZYMOSIS_H1N1.casetype
  is '��������(���ݲ���)';
comment on column EMR.ZYMOSIS_H1N1.hospitalstatus
  is '�Ƿ�סԺ';
comment on column EMR.ZYMOSIS_H1N1.iscure
  is '�Ƿ�����';
comment on column EMR.ZYMOSIS_H1N1.isoverseas
  is '�Ƿ�������';
comment on column EMR.ZYMOSIS_H1N1.vaild
  is '״̬�Ƿ���Ч  1����Ч   0����Ч';
comment on column EMR.ZYMOSIS_H1N1.creator
  is '������';
comment on column EMR.ZYMOSIS_H1N1.createdate
  is '����ʱ��';
comment on column EMR.ZYMOSIS_H1N1.mender
  is '�޸���';
comment on column EMR.ZYMOSIS_H1N1.alterdate
  is '�޸�ʱ��';
alter table EMR.ZYMOSIS_H1N1
  add constraint ZYMOSIS_H1N1_PK primary key (H1N1ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table ZYMOSIS_HBV
prompt ==========================
prompt
create table EMR.ZYMOSIS_HBV
(
  hbvid         VARCHAR2(50) not null,
  reportid      INTEGER not null,
  hbsagdate     VARCHAR2(50),
  fristdate     VARCHAR2(50),
  alt           VARCHAR2(50),
  antihbc       VARCHAR2(50),
  liverbiopsy   VARCHAR2(50),
  recoveryhbsag VARCHAR2(50),
  vaild         VARCHAR2(1) default 1,
  creator       VARCHAR2(50),
  createdate    VARCHAR2(50),
  mender        VARCHAR2(50),
  alterdate     VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on table EMR.ZYMOSIS_HBV
  is '�Ҹα����';
comment on column EMR.ZYMOSIS_HBV.hbvid
  is '�Ҹ�ID��';
comment on column EMR.ZYMOSIS_HBV.reportid
  is '����ID��';
comment on column EMR.ZYMOSIS_HBV.hbsagdate
  is 'HBsAg����ʱ��';
comment on column EMR.ZYMOSIS_HBV.fristdate
  is '�״γ����Ҹ�֢״������ʱ��';
comment on column EMR.ZYMOSIS_HBV.alt
  is '����ALT';
comment on column EMR.ZYMOSIS_HBV.antihbc
  is '��-HBc IgM 1:1000�����';
comment on column EMR.ZYMOSIS_HBV.liverbiopsy
  is '�δ������';
comment on column EMR.ZYMOSIS_HBV.recoveryhbsag
  is '�ָ���Ѫ��HBsAg��ת,��HBs��ת';
comment on column EMR.ZYMOSIS_HBV.vaild
  is '״̬�Ƿ���Ч  1����Ч   0����Ч';
comment on column EMR.ZYMOSIS_HBV.creator
  is '������';
comment on column EMR.ZYMOSIS_HBV.createdate
  is '����ʱ��';
comment on column EMR.ZYMOSIS_HBV.mender
  is '�޸���';
comment on column EMR.ZYMOSIS_HBV.alterdate
  is '�޸�ʱ��';
alter table EMR.ZYMOSIS_HBV
  add constraint ZYMOSIS_HBV_PK primary key (HBVID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table ZYMOSIS_HFMD
prompt ===========================
prompt
create table EMR.ZYMOSIS_HFMD
(
  hfmdid     VARCHAR2(50) not null,
  reportid   INTEGER not null,
  labresult  VARCHAR2(50),
  issevere   VARCHAR2(50),
  vaild      VARCHAR2(1) default 1,
  creator    VARCHAR2(50),
  createdate VARCHAR2(50),
  mender     VARCHAR2(50),
  alterdate  VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on table EMR.ZYMOSIS_HFMD
  is '����ڲ������';
comment on column EMR.ZYMOSIS_HFMD.hfmdid
  is '����ڲ�ID��';
comment on column EMR.ZYMOSIS_HFMD.reportid
  is '����ID��';
comment on column EMR.ZYMOSIS_HFMD.labresult
  is 'ʵ���ҽ��';
comment on column EMR.ZYMOSIS_HFMD.issevere
  is '��֢����';
comment on column EMR.ZYMOSIS_HFMD.vaild
  is '״̬�Ƿ���Ч  1����Ч   0����Ч';
comment on column EMR.ZYMOSIS_HFMD.creator
  is '������';
comment on column EMR.ZYMOSIS_HFMD.createdate
  is '����ʱ��';
comment on column EMR.ZYMOSIS_HFMD.mender
  is '�޸���';
comment on column EMR.ZYMOSIS_HFMD.alterdate
  is '�޸�ʱ��';
alter table EMR.ZYMOSIS_HFMD
  add constraint ZYMOSIS_HFMD_PK primary key (HFMDID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table ZYMOSIS_HIV
prompt ==========================
prompt
create table EMR.ZYMOSIS_HIV
(
  hiv_id              VARCHAR2(50) not null,
  report_id           INTEGER not null,
  report_no           VARCHAR2(32),
  maritalstatus       VARCHAR2(50),
  nation              VARCHAR2(50),
  culturestate        VARCHAR2(50),
  householdscope      VARCHAR2(50),
  householdaddress    VARCHAR2(50),
  address             VARCHAR2(50),
  contacthistory      VARCHAR2(500),
  venerismhistory     VARCHAR2(50),
  infactway           VARCHAR2(50),
  samplesource        VARCHAR2(50),
  detectionconclusion VARCHAR2(50),
  affirmdate          VARCHAR2(50),
  affirmlocal         VARCHAR2(50),
  diagnosedate        VARCHAR2(50),
  doctor              VARCHAR2(50),
  writedate           VARCHAR2(50),
  alikesymbol         VARCHAR2(50),
  remark              VARCHAR2(500),
  vaild               VARCHAR2(1) default 1,
  creator             VARCHAR2(50),
  createdate          VARCHAR2(50),
  mender              VARCHAR2(50),
  alterdate           VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on table EMR.ZYMOSIS_HIV
  is '���̲������';
comment on column EMR.ZYMOSIS_HIV.hiv_id
  is '���̲�ID��';
comment on column EMR.ZYMOSIS_HIV.report_no
  is '���濨����';
comment on column EMR.ZYMOSIS_HIV.maritalstatus
  is '����״��';
comment on column EMR.ZYMOSIS_HIV.nation
  is '����';
comment on column EMR.ZYMOSIS_HIV.culturestate
  is '�Ļ��̶�';
comment on column EMR.ZYMOSIS_HIV.householdscope
  is '�������ڵط�Χ';
comment on column EMR.ZYMOSIS_HIV.householdaddress
  is '������ַ';
comment on column EMR.ZYMOSIS_HIV.address
  is '��ϸ��ַ';
comment on column EMR.ZYMOSIS_HIV.contacthistory
  is '�Ӵ�ʷ';
comment on column EMR.ZYMOSIS_HIV.venerismhistory
  is '�Բ�ʷ';
comment on column EMR.ZYMOSIS_HIV.infactway
  is '���ܸ�Ⱦ;��';
comment on column EMR.ZYMOSIS_HIV.samplesource
  is '������Դ';
comment on column EMR.ZYMOSIS_HIV.detectionconclusion
  is 'ʵ���Ҽ�����';
comment on column EMR.ZYMOSIS_HIV.affirmdate
  is 'ȷ�ϣ�������ԣ������������';
comment on column EMR.ZYMOSIS_HIV.affirmlocal
  is 'ȷ�ϣ�������ԣ���ⵥλ';
comment on column EMR.ZYMOSIS_HIV.diagnosedate
  is '���̲�ȷ������';
comment on column EMR.ZYMOSIS_HIV.doctor
  is '������
���ҽ����';
comment on column EMR.ZYMOSIS_HIV.writedate
  is '�����';
comment on column EMR.ZYMOSIS_HIV.alikesymbol
  is '���нӴ���������֢ͬ״';
comment on column EMR.ZYMOSIS_HIV.remark
  is '��ע';
comment on column EMR.ZYMOSIS_HIV.vaild
  is '״̬�Ƿ���Ч  1����Ч   0����Ч';
comment on column EMR.ZYMOSIS_HIV.creator
  is '������';
comment on column EMR.ZYMOSIS_HIV.createdate
  is '����ʱ��';
comment on column EMR.ZYMOSIS_HIV.mender
  is '�޸���';
comment on column EMR.ZYMOSIS_HIV.alterdate
  is '�޸�ʱ��';
alter table EMR.ZYMOSIS_HIV
  add constraint ZYMOSIS_HIV_PK primary key (HIV_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table ZYMOSIS_JOB
prompt ==========================
prompt
create table EMR.ZYMOSIS_JOB
(
  jobid   VARCHAR2(4) not null,
  jobname VARCHAR2(14) not null
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index EMR.ZYMOSIS_JOB_ID on EMR.ZYMOSIS_JOB (JOBID)
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMR.ZYMOSIS_JOB
  add constraint ZYMOSIS_JOB primary key (JOBID, JOBNAME)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ZYMOSIS_JRSY
prompt ===========================
prompt
create table EMR.ZYMOSIS_JRSY
(
  jrsy_id             VARCHAR2(50) not null,
  report_id           INTEGER not null,
  report_no           VARCHAR2(32),
  maritalstatus       VARCHAR2(50),
  nation              VARCHAR2(50),
  culturestate        VARCHAR2(50),
  householdscope      VARCHAR2(50),
  householdaddress    VARCHAR2(50),
  address             VARCHAR2(50),
  contacthistory      VARCHAR2(500),
  venerismhistory     VARCHAR2(50),
  infactway           VARCHAR2(50),
  samplesource        VARCHAR2(50),
  detectionconclusion VARCHAR2(50),
  affirmdate          VARCHAR2(50),
  affirmlocal         VARCHAR2(50),
  vaild               VARCHAR2(1) default 1,
  creator             VARCHAR2(50),
  createdate          VARCHAR2(50),
  mender              VARCHAR2(50),
  alterdate           VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on table EMR.ZYMOSIS_JRSY
  is '��ֳ��ɳ����ԭ���Ⱦ��';
comment on column EMR.ZYMOSIS_JRSY.jrsy_id
  is '��ֳ��ɳ����ԭ��ID��';
comment on column EMR.ZYMOSIS_JRSY.report_no
  is '���濨����';
comment on column EMR.ZYMOSIS_JRSY.maritalstatus
  is '����״��';
comment on column EMR.ZYMOSIS_JRSY.nation
  is '����';
comment on column EMR.ZYMOSIS_JRSY.culturestate
  is '�Ļ��̶�';
comment on column EMR.ZYMOSIS_JRSY.householdscope
  is '�������ڵط�Χ';
comment on column EMR.ZYMOSIS_JRSY.householdaddress
  is '������ַ';
comment on column EMR.ZYMOSIS_JRSY.address
  is '��ϸ��ַ';
comment on column EMR.ZYMOSIS_JRSY.contacthistory
  is '�Ӵ�ʷ';
comment on column EMR.ZYMOSIS_JRSY.venerismhistory
  is '�Բ�ʷ';
comment on column EMR.ZYMOSIS_JRSY.infactway
  is '���ܸ�Ⱦ;��';
comment on column EMR.ZYMOSIS_JRSY.samplesource
  is '������Դ';
comment on column EMR.ZYMOSIS_JRSY.detectionconclusion
  is 'ʵ���Ҽ�����';
comment on column EMR.ZYMOSIS_JRSY.affirmdate
  is 'ȷ�ϣ�������ԣ������������';
comment on column EMR.ZYMOSIS_JRSY.affirmlocal
  is 'ȷ�ϣ�������ԣ���ⵥλ';
comment on column EMR.ZYMOSIS_JRSY.vaild
  is '״̬�Ƿ���Ч  1����Ч   0����Ч';
comment on column EMR.ZYMOSIS_JRSY.creator
  is '������';
comment on column EMR.ZYMOSIS_JRSY.createdate
  is '����ʱ��';
comment on column EMR.ZYMOSIS_JRSY.mender
  is '�޸���';
comment on column EMR.ZYMOSIS_JRSY.alterdate
  is '�޸�ʱ��';
alter table EMR.ZYMOSIS_JRSY
  add constraint PK_ZYMOSIS_JRSYID primary key (JRSY_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table ZYMOSIS_REPORT
prompt =============================
prompt
create table EMR.ZYMOSIS_REPORT
(
  report_id        INTEGER not null,
  report_no        VARCHAR2(12),
  report_type      VARCHAR2(1) not null,
  noofinpat        VARCHAR2(32) not null,
  patid            VARCHAR2(32) not null,
  name             VARCHAR2(32) not null,
  parentname       VARCHAR2(32),
  idno             VARCHAR2(18),
  sex              VARCHAR2(1) not null,
  birth            VARCHAR2(10),
  age              VARCHAR2(10),
  age_unit         VARCHAR2(1),
  organization     VARCHAR2(64),
  officeplace      VARCHAR2(64),
  officetel        VARCHAR2(16),
  addresstype      VARCHAR2(1),
  hometown         VARCHAR2(128),
  address          VARCHAR2(128),
  jobid            VARCHAR2(4),
  recordtype1      VARCHAR2(1),
  recordtype2      VARCHAR2(1),
  attackdate       VARCHAR2(10),
  diagdate         VARCHAR2(19),
  diedate          VARCHAR2(10),
  diagicd10        VARCHAR2(32),
  diagname         VARCHAR2(64),
  infectother_flag VARCHAR2(1),
  memo             VARCHAR2(255),
  correct_flag     VARCHAR2(1),
  correct_name     VARCHAR2(64),
  cancel_reason    VARCHAR2(64),
  reportdeptcode   VARCHAR2(12),
  reportdeptname   VARCHAR2(32),
  reportdoccode    VARCHAR2(6),
  reportdocname    VARCHAR2(32),
  doctortel        VARCHAR2(30),
  report_date      VARCHAR2(10),
  state            VARCHAR2(1),
  create_date      VARCHAR2(19),
  create_usercode  VARCHAR2(6),
  create_username  VARCHAR2(32),
  create_deptcode  VARCHAR2(12),
  create_deptname  VARCHAR2(32),
  modify_date      VARCHAR2(19),
  modify_usercode  VARCHAR2(6),
  modify_username  VARCHAR2(32),
  modify_deptcode  VARCHAR2(12),
  modify_deptname  VARCHAR2(32),
  audit_date       VARCHAR2(19),
  audit_usercode   VARCHAR2(6),
  audit_username   VARCHAR2(32),
  audit_deptcode   VARCHAR2(12),
  audit_deptname   VARCHAR2(32),
  vaild            VARCHAR2(1) default 1,
  otherdiag        VARCHAR2(255)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 832K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.ZYMOSIS_REPORT
  is '��Ⱦ�����濨��';
comment on column EMR.ZYMOSIS_REPORT.report_no
  is '���濨����';
comment on column EMR.ZYMOSIS_REPORT.report_type
  is '���濨����   1�����α���  2����������';
comment on column EMR.ZYMOSIS_REPORT.noofinpat
  is '��ҳ���';
comment on column EMR.ZYMOSIS_REPORT.patid
  is 'סԺ��';
comment on column EMR.ZYMOSIS_REPORT.name
  is '��������';
comment on column EMR.ZYMOSIS_REPORT.parentname
  is '�ҳ�����';
comment on column EMR.ZYMOSIS_REPORT.idno
  is '���֤����';
comment on column EMR.ZYMOSIS_REPORT.sex
  is '�����Ա�';
comment on column EMR.ZYMOSIS_REPORT.birth
  is '��������';
comment on column EMR.ZYMOSIS_REPORT.age
  is 'ʵ������';
comment on column EMR.ZYMOSIS_REPORT.age_unit
  is 'ʵ�����䵥λ  1����  2����  3����';
comment on column EMR.ZYMOSIS_REPORT.organization
  is '������λ';
comment on column EMR.ZYMOSIS_REPORT.officeplace
  is '��λ��ַ';
comment on column EMR.ZYMOSIS_REPORT.officetel
  is '��λ�绰';
comment on column EMR.ZYMOSIS_REPORT.addresstype
  is '�������ڵ���	1�������� 2����������������	3����ʡ��������	4����ʡ	5���۰�̨	6���⼮';
comment on column EMR.ZYMOSIS_REPORT.hometown
  is '����';
comment on column EMR.ZYMOSIS_REPORT.address
  is '��ϸ��ַ[�� �ֵ� ���ƺ�]';
comment on column EMR.ZYMOSIS_REPORT.jobid
  is 'ְҵ���루��ҳ��˳���¼��ţ�';
comment on column EMR.ZYMOSIS_REPORT.recordtype1
  is '��������	1�����Ʋ���	2���ٴ���ϲ���	3��ʵ����ȷ�ﲡ��	4��ԭЯ����';
comment on column EMR.ZYMOSIS_REPORT.recordtype2
  is '�������ࣨ���͸��ס�Ѫ���没��д��	1������	2������';
comment on column EMR.ZYMOSIS_REPORT.attackdate
  is '�������ڣ���ԭЯ������������ڻ�������ڣ�';
comment on column EMR.ZYMOSIS_REPORT.diagdate
  is '�������';
comment on column EMR.ZYMOSIS_REPORT.diedate
  is '��������';
comment on column EMR.ZYMOSIS_REPORT.diagicd10
  is '��Ⱦ������(��Ӧ��Ⱦ����Ͽ�)';
comment on column EMR.ZYMOSIS_REPORT.diagname
  is '��Ⱦ����������';
comment on column EMR.ZYMOSIS_REPORT.infectother_flag
  is '���޸�Ⱦ������[0�� 1��]';
comment on column EMR.ZYMOSIS_REPORT.memo
  is '��ע';
comment on column EMR.ZYMOSIS_REPORT.correct_flag
  is '������־��0��δ���� 1���Ѷ�����	';
comment on column EMR.ZYMOSIS_REPORT.correct_name
  is '��������';
comment on column EMR.ZYMOSIS_REPORT.cancel_reason
  is '�˿�ԭ��';
comment on column EMR.ZYMOSIS_REPORT.reportdeptcode
  is '������ұ��';
comment on column EMR.ZYMOSIS_REPORT.reportdeptname
  is '�����������';
comment on column EMR.ZYMOSIS_REPORT.reportdoccode
  is '����ҽ�����';
comment on column EMR.ZYMOSIS_REPORT.reportdocname
  is '����ҽ������';
comment on column EMR.ZYMOSIS_REPORT.doctortel
  is '����ҽ����ϵ�绰';
comment on column EMR.ZYMOSIS_REPORT.report_date
  is '�ʱ��';
comment on column EMR.ZYMOSIS_REPORT.state
  is '����״̬�� 1���������� 2���ύ 3������ 4�����ͨ�� 5�����δͨ������ 6���ϱ�	7�����ϡ�';
comment on column EMR.ZYMOSIS_REPORT.create_date
  is '����ʱ��';
comment on column EMR.ZYMOSIS_REPORT.create_usercode
  is '������';
comment on column EMR.ZYMOSIS_REPORT.create_username
  is '������';
comment on column EMR.ZYMOSIS_REPORT.create_deptcode
  is '�����˿���';
comment on column EMR.ZYMOSIS_REPORT.create_deptname
  is '�����˿���';
comment on column EMR.ZYMOSIS_REPORT.modify_date
  is '�޸�ʱ��';
comment on column EMR.ZYMOSIS_REPORT.modify_usercode
  is '�޸���';
comment on column EMR.ZYMOSIS_REPORT.modify_username
  is '�޸���';
comment on column EMR.ZYMOSIS_REPORT.modify_deptcode
  is '�޸��˿���';
comment on column EMR.ZYMOSIS_REPORT.modify_deptname
  is '�޸��˿���';
comment on column EMR.ZYMOSIS_REPORT.audit_date
  is '���ʱ��';
comment on column EMR.ZYMOSIS_REPORT.audit_usercode
  is '�����';
comment on column EMR.ZYMOSIS_REPORT.audit_username
  is '�����';
comment on column EMR.ZYMOSIS_REPORT.audit_deptcode
  is '����˿���';
comment on column EMR.ZYMOSIS_REPORT.audit_deptname
  is '����˿���';
comment on column EMR.ZYMOSIS_REPORT.vaild
  is '״̬�Ƿ���Ч  1����Ч   0����Ч';
comment on column EMR.ZYMOSIS_REPORT.otherdiag
  is '�������������Լ��ص��⴫Ⱦ��';
alter table EMR.ZYMOSIS_REPORT
  add constraint ZYMOSIS_REPORT_PK primary key (REPORT_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ZYMOSIS_REPORT_SN
prompt ================================
prompt
create table EMR.ZYMOSIS_REPORT_SN
(
  report_sn_id    INTEGER not null,
  report_id       INTEGER not null,
  create_date     VARCHAR2(19),
  create_usercode VARCHAR2(6),
  create_username VARCHAR2(32),
  create_deptcode VARCHAR2(12),
  create_deptname VARCHAR2(32),
  state           VARCHAR2(32),
  memo            VARCHAR2(255)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 704K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table EMR.ZYMOSIS_REPORT_SN
  is '��Ⱦ�����濨�������ˮ';
comment on column EMR.ZYMOSIS_REPORT_SN.report_sn_id
  is '����ˮ��';
comment on column EMR.ZYMOSIS_REPORT_SN.report_id
  is '��Ⱦ�����濨���';
comment on column EMR.ZYMOSIS_REPORT_SN.create_date
  is '����ʱ��';
comment on column EMR.ZYMOSIS_REPORT_SN.create_usercode
  is '������';
comment on column EMR.ZYMOSIS_REPORT_SN.create_username
  is '������';
comment on column EMR.ZYMOSIS_REPORT_SN.create_deptcode
  is '�����˿���';
comment on column EMR.ZYMOSIS_REPORT_SN.create_deptname
  is '�����˿���';
comment on column EMR.ZYMOSIS_REPORT_SN.state
  is '�޸�����';
comment on column EMR.ZYMOSIS_REPORT_SN.memo
  is '��ע';

prompt
prompt Creating table ZYMOSIS_SZDYYT
prompt =============================
prompt
create table EMR.ZYMOSIS_SZDYYT
(
  szdyyt_id           VARCHAR2(50) not null,
  report_id           INTEGER not null,
  report_no           VARCHAR2(32),
  maritalstatus       VARCHAR2(50),
  nation              VARCHAR2(50),
  culturestate        VARCHAR2(50),
  householdscope      VARCHAR2(50),
  householdaddress    VARCHAR2(50),
  address             VARCHAR2(50),
  syyytgr             VARCHAR2(50),
  contacthistory      VARCHAR2(500),
  venerismhistory     VARCHAR2(50),
  infactway           VARCHAR2(50),
  samplesource        VARCHAR2(50),
  detectionconclusion VARCHAR2(50),
  affirmdate          VARCHAR2(50),
  affirmlocal         VARCHAR2(50),
  vaild               VARCHAR2(1) default 1,
  creator             VARCHAR2(50),
  createdate          VARCHAR2(50),
  mender              VARCHAR2(50),
  alterdate           VARCHAR2(50)
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
  );
comment on table EMR.ZYMOSIS_SZDYYT
  is '��ֳ��ɳ����ԭ���Ⱦ��';
comment on column EMR.ZYMOSIS_SZDYYT.szdyyt_id
  is '��ֳ��ɳ����ԭ��ID��';
comment on column EMR.ZYMOSIS_SZDYYT.report_no
  is '���濨����';
comment on column EMR.ZYMOSIS_SZDYYT.maritalstatus
  is '����״��';
comment on column EMR.ZYMOSIS_SZDYYT.nation
  is '����';
comment on column EMR.ZYMOSIS_SZDYYT.culturestate
  is '�Ļ��̶�';
comment on column EMR.ZYMOSIS_SZDYYT.householdscope
  is '�������ڵط�Χ';
comment on column EMR.ZYMOSIS_SZDYYT.householdaddress
  is '������ַ';
comment on column EMR.ZYMOSIS_SZDYYT.address
  is '��ϸ��ַ';
comment on column EMR.ZYMOSIS_SZDYYT.syyytgr
  is '��ֳ��ɳ����ԭ���Ⱦ';
comment on column EMR.ZYMOSIS_SZDYYT.contacthistory
  is '�Ӵ�ʷ';
comment on column EMR.ZYMOSIS_SZDYYT.venerismhistory
  is '�Բ�ʷ';
comment on column EMR.ZYMOSIS_SZDYYT.infactway
  is '���ܸ�Ⱦ;��';
comment on column EMR.ZYMOSIS_SZDYYT.samplesource
  is '������Դ';
comment on column EMR.ZYMOSIS_SZDYYT.detectionconclusion
  is 'ʵ���Ҽ�����';
comment on column EMR.ZYMOSIS_SZDYYT.affirmdate
  is 'ȷ�ϣ�������ԣ������������';
comment on column EMR.ZYMOSIS_SZDYYT.affirmlocal
  is 'ȷ�ϣ�������ԣ���ⵥλ';
comment on column EMR.ZYMOSIS_SZDYYT.vaild
  is '״̬�Ƿ���Ч  1����Ч   0����Ч';
comment on column EMR.ZYMOSIS_SZDYYT.creator
  is '������';
comment on column EMR.ZYMOSIS_SZDYYT.createdate
  is '����ʱ��';
comment on column EMR.ZYMOSIS_SZDYYT.mender
  is '�޸���';
comment on column EMR.ZYMOSIS_SZDYYT.alterdate
  is '�޸�ʱ��';
alter table EMR.ZYMOSIS_SZDYYT
  add constraint PK_ZYMOSIS_SZDYYTID primary key (SZDYYT_ID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
  );

prompt
prompt Creating table yaopin
prompt =====================
prompt
create table EMR.yaopin
(
  "id"      VARCHAR2(20),
  "Title"   VARCHAR2(255),
  "Content" CLOB
)
tablespace TSP_YDEMR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 13M
    next 1M
    minextents 1
    maxextents unlimited
  );


spool off

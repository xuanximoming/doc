  �����б�����
  
  CP_InPatient  ��Wzjb �ֶ� 
    ����Ϊvarchar2  ֵ��Ϊ0
 
 ���󲿷��ֶε�ֵ  ǰ�пո� ��Ҫtrim     	    

/*���߷�����Ϣ*/

create global temporary table temp_Grfy
(
SyxhID VARCHAR(100)  NOT NULL,--��ҳ���
      Hzxm VARCHAR(100) NULL,--��������
      Ljmc VARCHAR(100) NULL,--·������
      Bzts VARCHAR(30) NULL,--��׼����
      Zyts VARCHAR(30) NULL,--סԺ����
      Rjsj VARCHAR(30) NULL,--�뾶ʱ��
      Tcsj VARCHAR(30) NULL,--�˳�ʱ��
      Wcsj VARCHAR(30) NULL,--���ʱ��
      Bzfy VARCHAR(100) NULL,--��׼����
      Ljzt VARCHAR(100) NULL,--·��״̬
      Qita VARCHAR(12) NULL,--����
      XyFei VARCHAR(12) NULL,--��ҩ��
      ZhiliaoFei VARCHAR(12) NULL,--���Ʒ�
      JcFei VARCHAR(12) NULL,--����
      JyFei VARCHAR(12) NULL,--�����
      ZlFei VARCHAR(12) NULL,--���Ʒ�
      CwFei VARCHAR(12) NULL,--��λ��
      HshlFei VARCHAR(12) NULL,--��ʿ�����
      Zj VARCHAR(12) NULL,--�ܼ�
			Yjlj VARCHAR(12) NULL--Ѻ���ۼ�
) on commit preserve rows;

/*
����ά��
*/

CREATE global temporary TABLE temp_Necd
(
		Mxxh VARCHAR(100)  NOT NULL,--������
		MxxhName VARCHAR(100),--��������
		Lbxh VARCHAR(100),--������
		LbxhName VARCHAR(20),--�������
		Yxjl VARCHAR(20),--��Ч��¼
		Sfsy VARCHAR(20),--�Ƿ�ʹ��
		JgName VARCHAR(1000)--������
)on commit preserve rows;

/*
��������
*/

CREATE global temporary TABLE temp_MedicalTreatmentWarm
(
       Syxh varchar(100),
       Ljxh varchar(100),
       Ljdm varchar(100),
       Jddm varchar(100),
       Hzjddm varchar(100),
       Txlx varchar(100),
       Txzt varchar(100),
       dm varchar(100),
       mc varchar(100)
)on commit preserve rows;

CREATE  global temporary TABLE temp_t
(
      col VARCHAR(10)
)on commit preserve rows;

/*����
*/

CREATE global temporary TABLE temp_EnterpathStatistics
(
      LjdmID varchar(100)  NOT NULL, --·������
			KsdmID VARCHAR(100) NULL ,--���Ҵ��� 
			Ksmc varchar(100) null,--��������
			Ljmc varchar(100) null,--·������
			Bhzs int null,--��������
			Rjrs int null,--�뾶����
			Rjl int null,--�뾶��
			Wcrs int null,--�������
			Wcl int null,--�����
			Tcrs int null,--�˳�����
			Tcl int null,--�˳���
			Zjrs int null,--�ھ�����
			Zjl int null--�ھ���
)on commit preserve rows;


CREATE global temporary TABLE temp_PathExecuteInfo
(
		LjdmID		varchar(100)	 not null, --·������
		Ljcz		int					not null,--·��ִ��״̬
		Czsj		varchar(100)		null--�˳�ʱ��(·��ִ�б�,�������Ϊ��)
)on commit preserve rows;


create global temporary table temp_pathQuitMonthCompare
(
    Ljdm		varchar(100)		 not null, --·������
    Ljmc		varchar(100)		not null,--·������
    Syks		varchar(100)		null,--��Ӧ����(·����,�������Ϊ��)
    Jan			int					null,--һ��
    Feb			int					null,--����
    Mar			int					null,--����
    Apr			int					null,--����
    May			int					null,--����
    Jun			int					null,--����
    Jul			int					null,--����
    Aug			int					null,--����
    Sept		int					null,--����
    Oct			int					null,--ʮ��
    Nov			int					null,--ʮһ��
    Dec			int					null--ʮ����
)on commit preserve rows;

create global temporary table temp_PathVariation
(
  BydmSt		VARCHAR(100)		NULL, --һ���������
  BymcSt		VARCHAR(100)		NULL,--һ����������
  St			VARCHAR(100)		 NULL,--һ��������д�ֶ�
  BydmNd		VARCHAR(100)		 NULL, --�����������
  BymcNd		VARCHAR(100)		NULL,--������������
  Nd			VARCHAR(100)		 NULL,--����������д�ֶ�
  BydmRd		VARCHAR(100)		 NULL, --�����������
  BymcRd		VARCHAR(100)		NULL--������������
)on commit preserve rows;

create global temporary table temp_PathVariationNd
(
  BydmNd		VARCHAR(100)		null, --�����������
  BymcNd		VARCHAR(100)		NULL--������������
)on commit preserve rows;

create global temporary table temp_PathVariationSt
(
  BydmSt		VARCHAR(100)		 null, --һ���������
  BymcSt		VARCHAR(100)		NULL--һ����������
)
on commit preserve rows;

create global temporary table temp_VariantRecords
(
  BydmId	VARCHAR(100)	 NOT null, --�������
  Ljxh	VARCHAR(100)	NULL--·�����
)on commit preserve rows;

create global temporary table temp_PathVariationAnalyse           
(
  Bydm	VARCHAR(100)	 null, --�������
  BymcSt		VARCHAR(100)		NULL,--һ����������
  BymcNd		VARCHAR(100)		NULL,--������������
  BymcRd		VARCHAR(100)		NULL,--������������
  VariationCount	INT				NULL--��Ŀ
)on commit preserve rows;



create global temporary table temp_EnForce
(
		Ljdm	VARCHAR(100)	 NULL,--·������
		PathDetailId	VARCHAR(100)	NULL--·���ڵ�
)on commit preserve rows;

create global temporary table temp_PathVariantRecords             /*�����Ѹ�*/
(
		Ljdm	varchar(100)	 NULL,--·������
		PathDetailId	varchar(100)	NULL--·���ڵ�
)on commit preserve rows;

create global temporary table temp_PathVariationMonitor
(
		Ljmc			VARCHAR(100)		 NULL,--·���ڵ���
		PahtDetail		VARCHAR(100)		NULL,--·���ڵ�ID
		enForceCount	INT					NULL,--ִ����
		variationCount	INT					NULL,--������
		per				DECIMAL				NULL	--������
)on commit preserve rows;

/*�ܽᣬ��ӡ*/
create global temporary table temp_LongOrder
(
		Ksrq			        VARCHAR(100)	NULL,
		Ksyr		          VARCHAR(100)  NULL,
		Kssj	            VARCHAR(100)	NULL,
		DoctName	        VARCHAR(100)	NULL,
		EnFoceNurSj				VARCHAR(100)	NULL,
    NurName           VARCHAR(100)  NULL,
    Yznr              VARCHAR(100)  NULL,
    StopRy            VARCHAR(100)  NULL,
    StopSj            VARCHAR(100)  NULL,
    StopDoctName      VARCHAR(100)  NULL,
    StopNurSj         VARCHAR(100)  NULL,
    StopNurName       VARCHAR(100)  NULL
)on commit preserve rows;

/*�ܽᣬ��ӡ*/
create global temporary table temp_TempOrder
(
		Ksrq			        VARCHAR(100)	NULL,
		Ksy		            VARCHAR(100)  NULL,
		Ksr	              VARCHAR(100)	NULL,
    Kssj              VARCHAR(100)	NULL,
		DoctName	        VARCHAR(100)	NULL,
    NurName           VARCHAR(100)  NULL,
    Yznr              VARCHAR(100)  NULL,
    EnForceRq         VARCHAR(100)  NULL,
    EnForceSj         VARCHAR(100)  NULL,
    EnFoceNurName     VARCHAR(100)  NULL
)on commit preserve rows;

create global temporary table temp_Order                            /*�����Ѹ�*/
	(
		Yzbz	varchar(100)	NOT NULL,	--ҽ����𣨳���/��ʱ��
		Xmlb	varchar(100)	NULL,		--��Ŀ���
		Ypdm	VARCHAR(100)	NULL,		--��Ŀ����
		Ypmc	varchar(500)	NULL,		--��Ŀ����
		Yznr	varchar(500)	NULL,		--ҽ������
		ActivityId	varchar(500)	NULL,	--·���ڵ�
		ActivityChildID varchar(500)	NULL,	--·���ӽڵ�
		Yzzt	varchar(100) NULL --ҽ��״̬
	)on commit preserve rows;
  
  create global temporary table temp_Xmlb
	(
		Xmlb	VARCHAR(100)	NULL,		--��Ŀ���
		Ypdm	VARCHAR(100)	NULL		--��Ŀ����
	)on commit preserve rows;
  
  CREATE global temporary table temp_Variation
	(
		Xmlb	VARCHAR(100)	NULL,		--��Ŀ���		
		Ypdm	VARCHAR(100)	NULL,		--��Ŀ����
		Bynr	varchar(500)	NULL,		--��������
		PahtDetailID	varchar(500)	NULL,--·���ڵ�
		Mxdm VARCHAR(500) NULL --·���ӽڵ�
	)on commit preserve rows;
  
  	CREATE global temporary table temp_DisXmlb
	(
		Xmlb	VARCHAR(100)	NULL,		--��Ŀ���
		Ypdm	VARCHAR(100) NULL		--��Ŀ����
	)on commit preserve rows;
  
  	CREATE global temporary table temp_CategoryDetail
	(
		Mxbh VARCHAR(100) NULL,
		NAME VARCHAR(100) NULL,
		Cols VARCHAR(50) NULL,
		Lb VARCHAR(50) NULL
	)on commit preserve rows;
  
  
  /*�ü�*/
CREATE GLOBAL TEMPORARY TABLE temp_PathEnterJudgeCondition

on commit preserve rows

AS

SELECT * FROM CP_PathEnterJudgeCondition;



  /*�ü�*/
CREATE GLOBAL TEMPORARY TABLE temp_DetailNur

on commit preserve rows

AS

SELECT * FROM CP_NurExecToPath




  /*�ü�*/
CREATE GLOBAL TEMPORARY TABLE temp_DeatilVar

on commit preserve rows

AS

SELECT * FROM CP_VariationToPath


/*ҽ���ü�*/
create global temporary table temp_AdviceGroupEnForce
(

Ctmxxh  NUMERIC      NULL
	
)on commit preserve rows;


create global temporary table temp_OrderTemp
(
  Ctmxxh  NUMERIC      NULL,
  Ljdm  VARCHAR(400)  null,
  ActivityId  VARCHAR(400)  null,
  Yzbz  VARCHAR(400)  NULL,
  Fzxh  VARCHAR(400)  null,
  Fzbz  VARCHAR(400)  NULL,
  Cdxh  VARCHAR(400)  null,
  Ggxh  VARCHAR(400)  null,
  Lcxh  VARCHAR(400)  null,
  Ypdm  VARCHAR(400)  null,
  Ypmc  VARCHAR(400)  NULL,
  Xmlb  VARCHAR(400)  null,
  Zxdw  VARCHAR(400)  null,
  Ypjl  VARCHAR(400)  null,
  Jldw  VARCHAR(400)  null,
  Dwxs  VARCHAR(400)  null,
  Dwlb  VARCHAR(400)  null,
  Yfdm  VARCHAR(400)  NULL,
  Pcdm  VARCHAR(400)  NULL,
  Zxcs  VARCHAR(400)  null,
  Zxzq  VARCHAR(400)  null,
  Zxzqdw  VARCHAR(400)  null,
  Zdm    VARCHAR(400)  null,
  Zxsj  VARCHAR(400)  null,
  Ztnr  VARCHAR(400)  null,
  Yzlb  VARCHAR(400)  NULL,
  counts  INT        NULL 
)on commit preserve rows;

create global temporary table temp_NewLongEnForce
  (
    Ljdm  VARCHAR(400)  null,
    ActivityId  VARCHAR(400)  null,
    Yzbz  VARCHAR(400)  null,
    Fzxh  VARCHAR(400)  null,
    Fzbz  VARCHAR(400)  null,
    Cdxh  VARCHAR(400)  null,
    Ggxh  VARCHAR(400)  null,
    Lcxh  VARCHAR(400)  null,
    YpdmId  VARCHAR(400)  null,
    Ypmc  VARCHAR(400)  null,
    Xmlb  VARCHAR(400)  null,
    Zxdw  VARCHAR(400)  null,
    Ypjl  VARCHAR(400)  null,
    Jldw  VARCHAR(400)  null,
    Dwxs  VARCHAR(400)  null,
    Dwlb  VARCHAR(400)  null,
    Yfdm  VARCHAR(400)  null,
    Pcdm  VARCHAR(400)  null,
    Zxcs  VARCHAR(400)  null,
    Zxzq  VARCHAR(400)  null,
    Zxzqdw  VARCHAR(400)  null,
    Zdm    VARCHAR(400)  null,
    Zxsj  VARCHAR(400)  null,
    Ztnr  VARCHAR(400)  null,
    Yzlb  VARCHAR(400)  NULL
  )on commit preserve rows;


create global temporary table temp_NewTempEnForce
  (
    Ljdm  VARCHAR(400)  null,
    ActivityId  VARCHAR(400)  null,
    Yzbz  VARCHAR(400)  null,
    Fzxh  VARCHAR(400)  null,
    Fzbz  VARCHAR(400)  null,
    Cdxh  VARCHAR(400)  null,
    Ggxh  VARCHAR(400)  null,
    Lcxh  VARCHAR(400)  null,
    YpdmId  VARCHAR(400)  null,
    Ypmc  VARCHAR(400)  null,
    Xmlb  VARCHAR(400)  null,
    Zxdw  VARCHAR(400)  null,
    Ypjl  VARCHAR(400)  null,
    Jldw  VARCHAR(400)  null,
    Dwxs  VARCHAR(400)  null,
    Dwlb  VARCHAR(400)  null,
    Yfdm  VARCHAR(400)  null,
    Pcdm  VARCHAR(400)  null,
    Zxcs  VARCHAR(400)  null,
    Zxzq  VARCHAR(400)  null,
    Zxzqdw  VARCHAR(400)  null,
    Zdm    VARCHAR(400)  null,
    Zxsj  VARCHAR(400)  null,
    Ztnr  VARCHAR(400)  null,
    Yzlb  VARCHAR(400)  NULL
  )on commit preserve rows;
  
  
    create global temporary table temp_NewLongOrder
  (
    Ctmxxh  NUMERIC      NULL,
    Ljdm  VARCHAR(400)  null,
    ActivityId  VARCHAR(400)  null,
    Yzbz  VARCHAR(400)  null,
    Fzxh  VARCHAR(400)  null,
    Fzbz  VARCHAR(400)  null,
    Cdxh  VARCHAR(400)  null,
    Ggxh  VARCHAR(400)  null,
    Lcxh  VARCHAR(400)  null,
    Ypdm  VARCHAR(400)  null,
    Ypmc  VARCHAR(400)  null,
    Xmlb  VARCHAR(400)  null,
    Zxdw  VARCHAR(400)  null,
    Ypjl  VARCHAR(400)  null,
    Jldw  VARCHAR(400)  null,
    Dwxs  VARCHAR(400)  null,
    Dwlb  VARCHAR(400)  null,
    Yfdm  VARCHAR(400)  null,
    Pcdm  VARCHAR(400)  null,
    Zxcs  VARCHAR(400)  null,
    Zxzq  VARCHAR(400)  null,
    Zxzqdw  VARCHAR(400)  null,
    Zdm    VARCHAR(400)  null,
    Zxsj  VARCHAR(400)  null,
    Ztnr  VARCHAR(400)  null,
    Yzlb  VARCHAR(400)  NULL,
    counts  INT        NULL 
  )on commit preserve rows;
  
   create global temporary table temp_NewTempOrder
  (
    Ctmxxh  NUMERIC      NULL,
    Ljdm  VARCHAR(400)  null,
    ActivityId  VARCHAR(400)  null,
    Yzbz  VARCHAR(400)  null,
    Fzxh  VARCHAR(400)  null,
    Fzbz  VARCHAR(400)  null,
    Cdxh  VARCHAR(400)  null,
    Ggxh  VARCHAR(400)  null,
    Lcxh  VARCHAR(400)  null,
    Ypdm  VARCHAR(400)  null,
    Ypmc  VARCHAR(400)  null,
    Xmlb  VARCHAR(400)  null,
    Zxdw  VARCHAR(400)  null,
    Ypjl  VARCHAR(400)  null,
    Jldw  VARCHAR(400)  null,
    Dwxs  VARCHAR(400)  null,
    Dwlb  VARCHAR(400)  null,
    Yfdm  VARCHAR(400)  null,
    Pcdm  VARCHAR(400)  null,
    Zxcs  VARCHAR(400)  null,
    Zxzq  VARCHAR(400)  null,
    Zxzqdw  VARCHAR(400)  null,
    Zdm    VARCHAR(400)  null,
    Zxsj  VARCHAR(400)  null,
    Ztnr  VARCHAR(400)  null,
    Yzlb  VARCHAR(400)  NULL,
    counts  INT        NULL 
  )on commit preserve rows;

Create global temporary Table temp_Head					--��ͷ(���ڴ����ͷ)
(
	Bydm	varchar(100)	NULL,		--��ͷ��ʶ
	Bymc	varchar(100)	NULL		--��ͷ��
)on commit preserve rows;

Create global temporary Table temp_Content				--���ݣ����ڴ������ݣ�
(
	Ljmc	varchar(100) NULL,		--·������
	Bydm	varchar(100)	NULL,								--������루ƥ�䣩
	Ljdm	varchar(100)	 NULL		--·������
)on commit preserve rows;


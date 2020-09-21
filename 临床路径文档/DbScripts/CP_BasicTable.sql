/* ======================================================== */
/*   Table: CP_PathExecuteFlowActivityChildren ·��ִ�м�¼�ӽڵ�ڵ�˳����ϸ��	zm 8.9 */
/* ======================================================== */
 IF NOT EXISTS ( SELECT 1
                 FROM   sysobjects
                 WHERE  NAME = 'CP_PathExecuteFlowActivityChildren' ) 
    CREATE TABLE CP_PathExecuteFlowActivityChildren
        (
			ID numeric(9, 0) IDENTITY,		--����
			Activity_UniqueID varchar(50) NOT NULL,		--���ڵ����
			ActivityChildrenID	varchar(50) NOT NULL,	--�ӽڵ����
			Zxsx numeric(9,0) NOT NULL,		--ִ��˳��(����д�С����)
			Jrsj varchar(20)				--ִ��ʱ��
        )
GO
/* ======================================================== */
/*   Table: CP_PatientPathEnterJudgeConditionRecord ����·�����ڵ㣩�����������¼����¼����·����ʱ�������	*/
/* ======================================================== */
 IF NOT EXISTS ( SELECT 1
                 FROM   sysobjects
                 WHERE  NAME = 'CP_PatientPathEnterJudgeConditionRecord' ) 
    CREATE TABLE CP_PatientPathEnterJudgeConditionRecord
        (
          ID INT IDENTITY NOT NULL ,		--��������
          Lb INT NOT NULL ,					--���1��·����2���ڵ㣩
		  Ljxh VARCHAR(50) ,				--·�����(CP_InPathPatient.Id)
		  Syxh NUMERIC(9, 0) NOT NULL ,		--��ҳ���(CP_InPatient.Syxh)
          Ljdm VARCHAR(12) NOT NULL ,		--·�����루CP_PathCondition.Ljdm��
          Jddm VARCHAR(50) ,				--�ڵ��GUID
          Sjfl VARCHAR(50) ,				--�ϼ����ࣨCP_ExamDictionary.Jlxh��
          Jcxm VARCHAR(50) NOT NULL ,		--�����Ŀ��Xmlb=1��CP_ExamDictionaryDetail.Jcbm �� Xmlb=2��CP_Diagnosis.Zdbs��
          JcxmName VARCHAR(400)  ,			--���Xmlb=9��ô�ʹ洢����������ʱ�ı�ע
          Xmlb VARCHAR(50) NOT NULL ,		--��Ŀ���1�������Ŀ��2��ICD-10,9:��ʾ������������ʱ��������ݣ�
          Ksfw VARCHAR(50) ,				--��ʼ��Χ
          Jsfw VARCHAR(50) ,				--������Χ
		  Jcjg VARCHAR(50) ,				--���˼����
		  Pdjg VARCHAR(50) ,				--�жϽ����NoExist�����˲����ڸü���,NoMatch����������������,Match�����������������,��
          Dw VARCHAR(20) ,					--��λ��CP_ExamDictionaryDetail.Jldw��
          Bz VARCHAR(200) ,					--��ע
          CONSTRAINT PK_CP_PatientPathEnterJudgeConditionRecord_ID PRIMARY KEY ( ID )
        )
GO
/* ======================================================== */
/*   Table: CP_PatientExamItem ���˼����	*/
/* ======================================================== */
 IF NOT EXISTS ( SELECT 1
                 FROM   sysobjects
                 WHERE  NAME = 'CP_PatientExamItem' ) 
    CREATE TABLE CP_PatientExamItem
        (
          ID INT IDENTITY NOT NULL ,		--��������
          Syxh NUMERIC(9, 0) NOT NULL ,	--��ҳ���(CP_InPatient.Syxh)
          Sjfl VARCHAR(50) ,				--�ϼ����ࣨCP_ExamDictionary.Jlxh��
          Jcxm VARCHAR(50) NOT NULL ,		--�����Ŀ��Xmlb=1��CP_ExamDictionaryDetail.Jcbm �� Xmlb=2��CP_Diagnosis.Zdbs��
          Jcjg VARCHAR(50) ,				--�����
          Dw VARCHAR(20) ,					--��λ��CP_ExamDictionaryDetail.Jldw��
          Bz VARCHAR(200) ,					--��ע
          CONSTRAINT PK_CP_PatientExamItem_ID PRIMARY KEY ( ID )
        )
GO
/* ======================================================== */
/*   Table: BaseTable ������	*/
/* ======================================================== */
IF not EXISTS(SELECT 1 FROM sysobjects WHERE NAME='BaseTable')
CREATE TABLE BaseTable
(
	 ID int identity ,--�����ֶ�
	 Bm int NOT NULL,--����
	 Mc varchar(50),--����
	 Lb varchar(5),--���1����ʾ�Ա�
	 Sfqy bit,--�Ƿ����ã�1����ʾ���ã�0��ʾͣ�ã�
	 Bz varchar(200),--��ע
)

go
/* ======================================================== */
/*   Table: CP_PathEnterJudgeCondition ·�����ڵ㣩����������	*/
/* ======================================================== */
 IF NOT EXISTS ( SELECT 1
                 FROM   sysobjects
                 WHERE  NAME = 'CP_PathEnterJudgeCondition' ) 
    CREATE TABLE CP_PathEnterJudgeCondition
        (
          ID INT IDENTITY NOT NULL ,		--��������
          Lb INT NOT NULL ,					--���1��·����2���ڵ㣩
          Ljdm VARCHAR(12) NOT NULL ,		--·�����루CP_PathCondition.Ljdm��
          Jddm VARCHAR(50) ,				--�ڵ��GUID
          Sjfl VARCHAR(50) ,				--�ϼ����ࣨCP_ExamDictionary.Jlxh��
          Jcxm VARCHAR(400) NOT NULL ,		--�����Ŀ��Xmlb=1��CP_ExamDictionaryDetail.Jcbm �� Xmlb=2��CP_Diagnosis.Zdbs��
          Xmlb VARCHAR(50) NOT NULL ,		--��Ŀ���1�������Ŀ��2��ICD-10��
          Ksfw VARCHAR(50) ,				--��ʼ��Χ
          Jsfw VARCHAR(50) ,				--������Χ
          Dw VARCHAR(20) ,					--��λ��CP_ExamDictionaryDetail.Jldw��
          Syrq VARCHAR(50)  ,		--������Ⱥ��CP_ExamSyrq.Jlxh�ˣ����ˣ����ˣ�Ů�ˣ�Ӥ���ȣ�
          Bz VARCHAR(200) ,					--��ע
          CONSTRAINT PK_CP_PathEnterJudgeCondition_ID PRIMARY KEY ( ID )
        )
GO
/* ======================================================== */
/*   Table: CP_ExamSyrq ������Ⱥ��CP_PathEnterJudgeCondition��ʹ�ã�	*/
/* ======================================================== */
 IF ( NOT EXISTS ( SELECT   1
                   FROM     sysobjects
                   WHERE    NAME = 'CP_ExamSyrq' )
    ) 
    CREATE TABLE CP_ExamSyrq
        (
          ID INT IDENTITY
                 NOT NULL ,					--�����ֶ�
          Jlxh VARCHAR(50) NOT NULL ,		--��¼���
          MC VARCHAR(20) NOT NULL ,			--����
          Yxjb INT NOT NULL ,				--���ȼ�
          Xb VARCHAR(50) NOT NULL ,			--�Ա�(CP_DictionaryDetail.Bm),(��=1��Ů=2)
          Qsnl INT NOT NULL ,				--��ʼ����
          Jsnl INT NOT NULL,				--��������
          CONSTRAINT PK_CP_ExamSyrq_ID PRIMARY KEY(ID)
        )

/* ======================================================== */
/*   Table: CP_ExamDictionary �����Ŀ����	*/
/* ======================================================== */
if not exists ( select  1
				from    sysobjects
				where   name = 'CP_ExamDictionary' ) 
begin
	create table CP_ExamDictionary  
	( 
		Jlxh	    numeric(9,0) identity,    	                         --�Զ�����
		Jcbm        varchar(50)			             not null,           --�����Ŀ����
		Fjd         varchar(50)                      null,               --���ڵ����(Jcbm)
		Jcmc		varchar(200)	                 not null,	         --�����Ŀ��������
		Mcsx        varchar(50)				         null,               --������д����
		Py			varchar(50)			 	         null,	             --ƴ��
		Wb			varchar(50)			             null,	             --���
		Bz  		varchar(200)				     null,	             --��ע
		constraint PK_CP_ExamDictionary primary key(Jcbm)
	)
	create index idx_Jcbm on CP_ExamDictionary(Jcbm)
end

go


/* ==================================================================== */
/*   Table: CP_ExamDictionaryDetail  �����Ŀ��	*/
/* ==================================================================== */
if not exists ( select  1
				from    sysobjects
				where   name = 'CP_ExamDictionaryDetail' ) 
begin
	create table CP_ExamDictionaryDetail  
	( 
		Jlxh		numeric(9,0) identity,       	                     --�Զ�����
		Jcbm        varchar(50)                      not null,           --�����Ŀ����(����ʱӳ��)
		Flbm        varchar(50)                      null,               --�������(CP_ExamDictionary.Jcbm)
		Jcmc		varchar(200)	                 not null,	         --�����Ŀ����
		Mcsx        varchar(50)			             null,               --������д����
		Ksfw		varchar(100)					 null,				 --��ʼ��Χ��������Χ��
		Jsfw		varchar(100)					 null,				 --������Χ��������Χ��
		Syrq		varchar(50)						 null,				 --������Ⱥ��CP_PathEnterJudgeCondition.ID�ˣ����ˣ����ˣ�Ů�ˣ�Ӥ���ȣ�
		Jsdw        varchar(20) 		             null,               --��λ           
		Py			varchar(50) 		   			     null,	             --ƴ��
		Wb			varchar(50) 		                 null,	             --���
		Yxjl        bit default 1                    null,               --��Ч��¼
		Bz  		varchar(200) 		             null,	             --��ע
		constraint PK_CP_ExamDictionaryDetail primary key(Jcbm)
	)
	create index idx_Jcbm on CP_ExamDictionaryDetail(Jcbm)
end

go


/* ============================================================ */
/*   Table: CP_DataCategory    ��������                      */
/*          ���������������ƺ�˵��,�û�����ά��               */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DataCategory' ) 
	BEGIN
		CREATE TABLE CP_DataCategory
			(
			  Lbbh SMALLINT NOT NULL ,	--(����)�����
			  Name VARCHAR(16) NOT NULL ,	--(����)����
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���
			  Memo VARCHAR(64) NULL ,    	--��ע
			  CONSTRAINT PK_CP_DataCategory PRIMARY KEY ( Lbbh )
			)
	END
go

/* ============================================================ */
/*   Table: CP_DataCategoryDetail   ���������ϸ��                       */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DataCategoryDetail' ) 
	BEGIN
		CREATE TABLE CP_DataCategoryDetail
			(
			  Mxbh SMALLINT NOT NULL ,	--��ϸ���(��Ϊ���ݷ������,�����ʽΪ'������'+'2λ����ˮ��', ��: 101, 102, 201, 205, 1201)
			  Name VARCHAR(16) NOT NULL ,	--��������
			  Lbbh SMALLINT NOT NULL ,	--�����(CP_DataCategory.Lbbh)
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���
			  Memo VARCHAR(16) NULL ,    	--��ע
			  CONSTRAINT PK_CP_DataCategoryDetail PRIMARY KEY ( Mxbh )
			)
	END
go

/* ============================================================ */
/*   Table: CP_Hospital     �û�������Ϣ                           */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Hospital' ) 
	BEGIN
		CREATE TABLE CP_Hospital
			(
			  Yydm VARCHAR(12) NOT NULL ,	--ҽԺ����
			  Name VARCHAR(64) NOT NULL ,	--(ҽԺ)����
			  Fjmc VARCHAR(64) NULL ,	--��������(��������"XXX����ҽԺ"��)
			  Sqm VARCHAR(12) NULL ,	--��Ȩ��
			  Ybdm VARCHAR(12) NULL ,	--(ҽԺ��)ҽ������
			  Dqdm VARCHAR(10) NULL ,	--��������
			  Qxdm VARCHAR(10) NULL ,	--(ҽԺ)���ش���
			  Qndm VARCHAR(4) NULL ,	--ҽԺ���ڴ���
			  Khyh VARCHAR(64) NULL ,	--��������
			  Yhzh VARCHAR(16) NULL ,	--�����˺�
			  Yydz VARCHAR(64) NULL ,	--ҽԺ��ַ
			  Yzbm VARCHAR(12) NULL ,	--��������
			  Dhhm VARCHAR(16) NULL ,	--�绰����
			  Bzcws INT NULL ,	--���ƴ�λ��
			  Yydj SMALLINT NOT NULL ,	--ҽԺ�ȼ�(CP_DataCategory.Mxbh Lbbh = 5)
			  Yylb SMALLINT NOT NULL ,	--ҽԺ���(CP_DataCategory.Mxbh Lbbh = 6)
			  Memo VARCHAR(64) NULL ,	--��ע
			  CONSTRAINT PK_CP_Hospital PRIMARY KEY ( Yydm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_Department	���Ҵ����                      */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Department' ) 
	BEGIN
		CREATE TABLE CP_Department
			(
			  Ksdm VARCHAR(12) NOT NULL ,	--���Ҵ���
			  Name VARCHAR(32) NOT NULL ,	--��������
			  Py VARCHAR(8) NULL ,	--ƴ��
			  Wb VARCHAR(8) NULL ,	--���
			  Yydm VARCHAR(12) NULL ,	--ҽԺ����(CP_Hospital.Yydm)
			  Yjksdm VARCHAR(12) NOT NULL ,	--һ�����Ҵ���(CP_Department_A.ID)     
			  Ejksdm VARCHAR(12) NOT NULL ,	--�������Ҵ���(CP_Department_B.ID)    
			  Kslb SMALLINT NOT NULL ,	--�������(CP_DataCategory.Mxbh Lbbh = 1)
			  Ksbz SMALLINT NOT NULL ,	--���ұ�־(CP_DataCategory.Mxbh Lbbh = 2)
			  Zryss INT NULL ,	--����ҽʦ��
			  Zyyss INT NULL ,	--סԺҽʦ��
			  Zzyss INT NULL ,	--����ҽʦ��
			  Hss INT NULL ,	--��ʿ��
			  Cws INT NULL ,	--(����)��λ��
			  Hdcws INT NULL ,	--�˶��Ӵ���
			  Yxjl SMALLINT NOT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(64) NULL ,	--��ע
			  CONSTRAINT PK_CP_Department PRIMARY KEY ( Ksdm )
			)
		CREATE INDEX idx_py ON CP_Department(Py)
		CREATE INDEX idx_wb ON CP_Department(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_Department_A	һ�����ҿ�                              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   name = 'CP_Department_A' ) 
	BEGIN
		CREATE TABLE CP_Department_A
			(
			  ID VARCHAR(12) NOT NULL ,	--һ�����Ҵ���
			  Name VARCHAR(32) NOT NULL ,	--��������
			  Py VARCHAR(8) NULL ,	--ƴ��
			  Wb VARCHAR(8) NULL ,	--���
			  Memo VARCHAR(16) NULL ,	--��ע
			  CONSTRAINT PK_CP_Department_A PRIMARY KEY ( ID )
			)
	END
go

/* ============================================================ */
/*   Table: CP_Department_B	�������ҿ�                              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   name = 'CP_Department_B' ) 
	BEGIN
		CREATE TABLE CP_Department_B
			(
			  ID VARCHAR(12) NOT NULL ,	--һ�����Ҵ���
			  Name VARCHAR(32) NOT NULL ,	--��������
			  Py VARCHAR(8) NULL ,	--ƴ��
			  Wb VARCHAR(8) NULL ,	--���
			  DeptAID VARCHAR(12) NOT NULL ,	--(����)һ�����Ҵ���(CP_Department_A.id)
			  DeptAName VARCHAR(32) NOT NULL ,	--(����)һ����������(CP_Department_A.name)
			  Memo VARCHAR(16) NULL ,	--��ע
			  CONSTRAINT PK_CP_Department_B PRIMARY KEY ( ID )
			)
	END
go

/* ============================================================ */
/*   Table: CP_Ward     ���������                             */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Ward' ) 
	BEGIN
		CREATE TABLE CP_Ward
		  (
			  Bqdm VARCHAR(12) NOT NULL ,	--��������
			  Name VARCHAR(32) NOT NULL ,	--��������
			  Py VARCHAR(8) NULL ,	--ƴ��
			  Wb VARCHAR(8) NULL ,	--���
			  Yydm VARCHAR(12) NOT NULL ,	--ҽԺ����(CP_Hospital.Yydm)
			  Cws INT NULL ,	--��λ��
			  Bqbz SMALLINT NOT NULL ,	--������־(CP_DataCategory.Mxbh Lbbh = 3)
			  Yxjl SMALLINT NOT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--��ע
			  CONSTRAINT PK_CP_Ward PRIMARY KEY ( Bqdm )
			)
		CREATE INDEX idx_py ON CP_Ward(Py)
		CREATE INDEX idx_wb ON CP_Ward(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_Dept2Ward      ���Ҳ�����Ӧ��                      */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Dept2Ward' ) 
	BEGIN
		CREATE TABLE CP_Dept2Ward
			(
			  Ksdm VARCHAR(12) NOT NULL ,	--���Ҵ���(CP_Department.Ksdm)
			  Bqdm VARCHAR(12) NOT NULL ,	--��������(CP_Ward.Bqdm)
			  Cws INT DEFAULT ( 0 )
					  NULL ,	--��λ��
			  CONSTRAINT PK_CP_Dept2Ward PRIMARY KEY ( Ksdm, Bqdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_Employee      ְ������                              */
/*                        ����Ա���ְ����϶�Ϊһ              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Employee' ) 
	BEGIN
		CREATE TABLE CP_Employee
			(
			  Zgdm VARCHAR(6) NOT NULL ,	--ְ������
			  Name VARCHAR(32) NOT NULL ,	--ְ������
			  Py VARCHAR(8) NULL ,	--ƴ��
			  Wb VARCHAR(8) NULL ,	--���
			  Zgxb VARCHAR(4) NULL ,	--ְ���Ա�(CP_DictionaryDetail.Name, lbdm = '3')
			  Csrq CHAR(10) NULL ,	--��������
			  Hyzk VARCHAR(2) NULL ,	--����״��(CP_DictionaryDetail.Mxdm, lbdm = '4')
			  Sfzh VARCHAR(18) NULL ,	--���֤��
			  Ksdm VARCHAR(12) NULL ,	--���Ҵ���(��ǰѡ��Ŀ���)(YY_KSDMK.Ksdm)
			  Bqdm VARCHAR(12) NULL ,	--��������(��ǰѡ��Ĳ���)(YY_BQDMK.Bqdm)
			  Zglb SMALLINT NOT NULL ,	--ְ�����(CP_DataCategory.Mxbh Lbbh = 4)
			  Zcdm VARCHAR(4) NULL ,	--ְ�ƴ���(CP_DictionaryDetail.Mxdm, lbdm = '40')
			  Cfzh VARCHAR(6) NULL ,	--�����º�
			  Cfq SMALLINT NOT NULL ,	--(��)����Ȩ(CP_DataCategory.Mxbh Lbbh = 0)
			  Mzcfq SMALLINT NOT NULL ,	--(��)������Ȩ(CP_DataCategory.Mxbh Lbbh = 0)
			  Fzbm VARCHAR(32) NULL ,	--�������('/���δ���//���δ���//ҽ������/')
			  Ysjb SMALLINT NULL ,	--ҽ������(CP_DataCategory.Mxbh Lbbh = 20)
			  Passwd VARCHAR(32) NULL ,	--����
			  Gwdm VARCHAR(255) NULL ,	--��λ����
			  Djsj CHAR(19) NULL ,	--�Ǽ�ʱ��
			  Szry VARCHAR(6) NULL ,	--������Ա(YY_CZRYK.czydm)
			  Yxjl SMALLINT NOT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--��ע
			  CONSTRAINT PK_CP_Employee PRIMARY KEY ( Zgdm )
			)
		CREATE INDEX idx_py ON CP_Employee(Py)
		CREATE INDEX idx_wb ON CP_Employee(Wb)
	END
go
/* ============================================================ */
/*   Table: CP_MedicareInfo     ҽ�������                             */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_MedicareInfo' ) 
	BEGIN
		CREATE TABLE CP_MedicareInfo
			(
			  Ybdm VARCHAR(4) NOT NULL ,	--ҽ������
			  Ybsm VARCHAR(32) NOT NULL ,	--ҽ��˵��
			  Py VARCHAR(8) NULL ,	--ƴ��
			  Wb VARCHAR(8) NULL ,	--���
			  Rqfl VARCHAR(2) NOT NULL ,	--��Ⱥ����(CP_DictionaryDetail.Name, lbdm = '46')
			  Ztqk VARCHAR(2) NOT NULL ,	--ְ�����(CP_DictionaryDetail.Name, lbdm = '47')
			  Bjqk VARCHAR(2) NOT NULL ,	--�������(CP_DictionaryDetail.Name, lbdm = '48')
			  Tsry VARCHAR(2) NOT NULL ,	--������Ա(CP_DictionaryDetail.Name, lbdm = '49')
			  Hzlb VARCHAR(2) NOT NULL ,	--�������(CP_DictionaryDetail.Name, lbdm = '50')  
			  Ybbl NUMERIC(7, 2) DEFAULT 1
								 NOT NULL ,	--ҽ������
			  Xtbz SMALLINT NOT NULL ,	--ϵͳ��־(CP_DataCategory.Mxbh Lbbh = 16)
			  Zfbz SMALLINT NOT NULL ,	--(ҽ��)�Ը���־(CP_DataCategory.Mxbh Lbbh = 17)
			  Zhbz SMALLINT NOT NULL ,	--�ʻ���־(CP_DataCategory.Mxbh Lbbh = 18)
			  Qfje NUMERIC(10, 2) NULL ,	--(Ĭ��)�𸶽��
			  Jsfs SMALLINT NOT NULL ,	--���㷽ʽ(CP_DataCategory.Mxbh Lbbh = 19)
			  Yztyx MONEY NULL ,	--ҽ��ͣҩ��
			  Pzlx VARCHAR(2) NULL ,	--ƾ֤����(����)
			  Pzlxmc VARCHAR(16) NULL ,	--ƾ֤��������
			  Yxjl SMALLINT NOT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(64) NULL ,	--��ע
			  CONSTRAINT PK_CP_MedicareInfo PRIMARY KEY ( Ybdm )
			)
		CREATE INDEX idx_py ON CP_MedicareInfo(Py)
		CREATE INDEX idx_wb ON CP_MedicareInfo(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_DataDictionary     �ֵ�����                             */
/*          ��������ֵ��������ƺ�˵��,�û�����ά��           */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DataDictionary' ) 
	BEGIN
		CREATE TABLE CP_DataDictionary
			(
			  Lbdm VARCHAR(2) NOT NULL ,	--(�ֵ�)������
			  Name VARCHAR(32) NOT NULL ,	--(����)����
			  Py VARCHAR(8) NULL ,	--ƴ��
			  Wb VARCHAR(8) NULL ,	--���
			  Memo VARCHAR(16) NULL ,	--��ע
			  CONSTRAINT PK_CP_DataDictionary PRIMARY KEY ( Lbdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_DictionaryDetail       �ֵ������ϸ��               	*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DictionaryDetail' ) 
	BEGIN
		CREATE TABLE CP_DictionaryDetail
			(
			  Mxdm VARCHAR(4) NOT NULL ,	--��ϸ����
			  Ysdm VARCHAR(16) NULL ,	--ӳ�����
			  Name VARCHAR(32) NOT NULL ,	--����
			  Py VARCHAR(8) NULL ,	--ƴ��
			  Wb VARCHAR(8) NULL ,	--���
			  Lbdm VARCHAR(2) NOT NULL ,	--(�ֵ�)������(CP_DataDictionary.lbdm)
			  Yxjl SMALLINT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--��ע
			  CONSTRAINT PK_CP_DictionaryDetail PRIMARY KEY ( Lbdm, Mxdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_Diagnosis       ҽԺ��Ͽ�                           */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Diagnosis' ) 
	BEGIN
		CREATE TABLE CP_Diagnosis
			(
			  Zdbs VARCHAR(32) NOT NULL , 	--��ϱ�ʶ(zddm + zlbm������ʹ�ü����л򴥷����ķ�ʽ������������ǰ̨����ά�����ݣ����Ը��е�ֵ��ǰ̨��������)
			  Zddm VARCHAR(12) NOT NULL ,	--��ϴ���(ICD10)
			  Ysdm VARCHAR(16) NULL ,	--ӳ�����
			  Bzdm VARCHAR(12) NOT NULL ,	--(��Ӧ��)��׼����(�û��Զ�������б�׼����ʱ����д���ֶ�)
			  Name VARCHAR(64) NOT NULL ,	--��������
			  Py VARCHAR(8) NULL ,	--ƴ��
			  Wb VARCHAR(8) NULL ,	--���
			  Zldm VARCHAR(12) DEFAULT ( '' )
							   NOT NULL ,	--��������(YY_ZLK.zldm)
			  Tjm VARCHAR(4) NOT NULL ,	--����ͳ�Ʒ���(CP_DiseaseCFG.Bzdm, Bzlb = 700)
			  Nbfl VARCHAR(4) DEFAULT ( '' )
							  NULL ,	--�ڲ�����(ҽԺ�ڲ��Զ������,CP_DiseaseCFG.Bzdm, Bzlb = 702)
			  Bzlb VARCHAR(4) DEFAULT ( '' )
							  NULL ,	--�������(�����ִ���, CP_DiseaseCFG.Bzdm, Bzlb = 701)
			  Qtlb SMALLINT NULL ,	--(����)�������(CP_DataCategory.Mxbh Lbbh = 9)
			  Yxjl SMALLINT NOT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--��ע
			  CONSTRAINT PK_CP_Diagnosis PRIMARY KEY ( Zdbs )
			)
		CREATE INDEX idx_zddm ON CP_Diagnosis(Zddm)
		CREATE INDEX idx_py ON CP_Diagnosis(Py)
		CREATE INDEX idx_wb ON CP_Diagnosis(Wb)
		CREATE INDEX idx_ysdm ON CP_Diagnosis(Ysdm)
	END
go

/* ============================================================ */
/*   Table: CP_PathDiagnosis       ҽԺ·����Ͽ⣨���Խ���·���Ĳ���)                         */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_PathDiagnosis' ) 
	BEGIN
		CREATE TABLE CP_PathDiagnosis
			(
			  Zdbs VARCHAR(32) NOT NULL , 	--��ϱ�ʶ(zddm + zlbm������ʹ�ü����л򴥷����ķ�ʽ������������ǰ̨����ά�����ݣ����Ը��е�ֵ��ǰ̨��������)
			  Zddm VARCHAR(12) NOT NULL ,	--��ϴ���(ICD10)
			  Ysdm VARCHAR(16) NULL ,	--ӳ�����
			  Bzdm VARCHAR(12) NOT NULL ,	--(��Ӧ��)��׼����(�û��Զ�������б�׼����ʱ����д���ֶ�)
			  Name VARCHAR(64) NOT NULL ,	--��������
			  Py VARCHAR(8) NULL ,	--ƴ��
			  Wb VARCHAR(8) NULL ,	--���
			  Zldm VARCHAR(12) DEFAULT ( '' )
							   NOT NULL ,	--��������(YY_ZLK.zldm)
			  Tjm VARCHAR(4) NOT NULL ,	--����ͳ�Ʒ���(CP_DiseaseCFG.Bzdm, Bzlb = 700)
			  Nbfl VARCHAR(4) DEFAULT ( '' )
							  NULL ,	--�ڲ�����(ҽԺ�ڲ��Զ������,CP_DiseaseCFG.Bzdm, Bzlb = 702)
			  Bzlb VARCHAR(4) DEFAULT ( '' )
							  NULL ,	--�������(�����ִ���, CP_DiseaseCFG.Bzdm, Bzlb = 701)
			  Qtlb SMALLINT NULL ,	--(����)�������(CP_DataCategory.Mxbh Lbbh = 9)
			  Yxjl SMALLINT NOT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--��ע
			  CONSTRAINT PK_CP_PathDiagnosis PRIMARY KEY ( Zdbs )
			)
		CREATE INDEX idx_zddm ON CP_PathDiagnosis(Zddm)
		CREATE INDEX idx_py ON CP_PathDiagnosis(Py)
		CREATE INDEX idx_wb ON CP_PathDiagnosis(Wb)
		CREATE INDEX idx_ysdm ON CP_PathDiagnosis(Ysdm)
	END
go

/* ============================================================ */
/*   Table: CP_DiseaseCFG      �������ÿ�                           */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DiseaseCFG' ) 
	BEGIN
		CREATE TABLE CP_DiseaseCFG
			(
			  Bzdm VARCHAR(4) NOT NULL ,	--���ִ���(�����ֻ򼲲��������)
			  Ysdm VARCHAR(16) NULL ,	--ӳ�����
			  Name VARCHAR(64) NOT NULL ,	--����
			  Py VARCHAR(8) NULL ,	--ƴ������
			  Wb VARCHAR(8) NULL ,	--��ʴ���
			  Jbbm VARCHAR(64) DEFAULT ( '' )
							   NULL ,	--(������)������ϴ���(��ϴ����ǰ׺,��' ,'����)
			  Ssbm VARCHAR(64) DEFAULT ( '' )
							   NULL ,	--(������)��������(���������ǰ׺,��' ,'����)
			  Bzlb SMALLINT NOT NULL ,	--�������(CP_DataCategory.Mxbh Lbbh = 7)
			  Tssz VARCHAR(64) NULL ,	--��������ֵ(�������жϵ����е��ض����ҵ�)
			  Ssdm VARCHAR(4) DEFAULT ( '' )
							  NULL ,	--����(���ϼ�)���� (��ʾ��ι�ϵ,CP_DiseaseCFG.Bzdm)
			  Yxjl SMALLINT NOT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--��ע
			  CONSTRAINT PK_CP_DiseaseCFG PRIMARY KEY ( Bzlb, Bzdm )
			)
		CREATE INDEX idx_ysdm ON CP_DiseaseCFG(Bzlb, Ysdm)
	END
go

/* ============================================================ */
/*   Table: CP_Surgery       ���������                           */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Surgery' ) 
	BEGIN
		CREATE TABLE CP_Surgery
			(
			  Ssdm VARCHAR(12) NOT NULL ,	--��������(ICD9-CM3)
			  Ysdm VARCHAR(16) NULL ,	--ӳ�����
			  Bzdm VARCHAR(12) NOT NULL ,	--(����)��׼����(�û��Զ�������б�׼����ʱ����д���ֶ�)
			  Name VARCHAR(64) NOT NULL ,	--��������
			  Py VARCHAR(8) NULL ,	--ƴ��
			  Wb VARCHAR(8) NULL ,	--���
			  Bzlb VARCHAR(4) DEFAULT ( '' )
							  NULL ,	--�������(CP_DiseaseCFG.Bzdm, Bzlb = 701)
			  Sslb SMALLINT NULL ,	--�������(CP_DataCategory.Mxbh Lbbh = 8)
			  Yxjl SMALLINT NOT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--��ע
			  CONSTRAINT PK_CP_Surgery PRIMARY KEY ( Ssdm )
			)
		CREATE INDEX idx_py ON CP_Surgery(Py)
		CREATE INDEX idx_wb ON CP_Surgery(Wb)
		CREATE INDEX idx_ysdm ON CP_Surgery(Ysdm)
	END
go

/* ============================================================ */
/*   Table: CP_Operation       (Ժ��)����������                     */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Operation' ) 
	BEGIN
		CREATE TABLE CP_Operation
			(
			  Ssdm VARCHAR(12) NOT NULL ,	--��������(ICD9-CM3)
			  Ysdm VARCHAR(16) NULL ,	--ӳ�����
			  Name VARCHAR(64) NOT NULL ,	--��������
			  Py VARCHAR(8) NULL ,	--ƴ��
			  Wb VARCHAR(8) NULL ,	--���
			  Sslb SMALLINT NULL ,	--�������(CP_DataCategory.Mxbh Lbbh = 8)
			  Yxjl SMALLINT NOT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--��ע
			  CONSTRAINT PK_CP_Operation PRIMARY KEY ( Ssdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_Anesthesia ��������                                 */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Anesthesia' ) 
	BEGIN
		CREATE TABLE CP_Anesthesia
			(
			  Mzdm VARCHAR(12) NOT NULL ,	--�������
			  Ysdm VARCHAR(16) NULL ,	--ӳ�����
			  Name VARCHAR(64) NOT NULL ,	--��������
			  Py VARCHAR(8) NULL ,	--ƴ��
			  Wb VARCHAR(8) NULL ,	--���
			  Yxjl SMALLINT NOT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--��ע
			  CONSTRAINT PK_CP_Anesthesia PRIMARY KEY ( Mzdm )
			)
		CREATE INDEX idx_py ON CP_Anesthesia(Py)
		CREATE INDEX idx_wb ON CP_Anesthesia(Wb)
		CREATE INDEX idx_ysdm ON CP_Anesthesia(Ysdm)
	END
go

/* ============================================================ */
/*   Table: CP_DiagnosisOfChinese       ��ҽ��Ͽ�                           */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DiagnosisOfChinese' ) 
	BEGIN
		CREATE TABLE CP_DiagnosisOfChinese
			(
			  Zyzddm VARCHAR(12) NOT NULL ,	--��ҽ�����
			  Ysdm VARCHAR(16) NULL ,	--ӳ�����
			  Name VARCHAR(64) NOT NULL ,	--����
			  Py VARCHAR(8) NULL ,	--ƴ��
			  Wb VARCHAR(8) NULL ,	--���
			  Nbfl VARCHAR(4) NULL ,	--�ڲ�����(Ԥ���ֶ�)
			  Bzlb VARCHAR(4) NULL ,	--�������(����������, Ԥ���ֶ�)
			  Yxjl SMALLINT NOT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--��ע
			  CONSTRAINT PK_CP_DiagnosisOfChinese PRIMARY KEY ( Zyzddm )
			)
		CREATE INDEX idx_py ON CP_DiagnosisOfChinese(Py)
		CREATE INDEX idx_wb ON CP_DiagnosisOfChinese(Wb)
		CREATE INDEX idx_ysdm ON CP_DiagnosisOfChinese(Ysdm)
	END
go
/* ============================================================ */
/*   Table: CP_DrugClassify	ҩƷ�����                              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DrugClassify' ) 
	BEGIN
		CREATE TABLE CP_DrugClassify
			(
			  Fldm VARCHAR(12) NOT NULL ,	--(ҩƷ)�������
			  Name VARCHAR(32) NOT NULL ,	--(����)����
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���
			  Memo VARCHAR(16) NULL ,    	--��ע
			  CONSTRAINT PK_CP_DrugClassify PRIMARY KEY ( Fldm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_DrugClassDetail	ҩƷ������ϸ��                          */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DrugClassDetail' ) 
	BEGIN
		CREATE TABLE CP_DrugClassDetail
			(
			  Flmxdm VARCHAR(12) NOT NULL ,	--(ҩƷ)������ϸ����
			  Name VARCHAR(32) NOT NULL ,	--(������ϸ)����
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���
			  Fldm VARCHAR(12) NOT NULL ,	--(����)��������(CP_DrugClassify.Fldm)
			  Memo VARCHAR(16) NULL ,    	--��ע
			  CONSTRAINT PK_CP_DrugClassDetail PRIMARY KEY ( Flmxdm )
			)
		CREATE INDEX idx_py ON CP_DrugClassDetail(Py)
		CREATE INDEX idx_wb ON CP_DrugClassDetail(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_DosageForm	ҩƷ���Ϳ�                              */
/*   			EMR�в���Ҫ����ϸ�ļ�����Ϣ             */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DosageForm' ) 
	BEGIN
		CREATE TABLE CP_DosageForm
			(
			  Jxdm VARCHAR(12) NOT NULL ,	--���ʹ���
			  Name VARCHAR(16) NOT NULL ,	--(����)����
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���	
			  Memo VARCHAR(16) NULL ,    	--��ע
			  CONSTRAINT PK_CP_DosageForm PRIMARY KEY ( Jxdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_DrugOrigin	ҩƷ��Դ��                              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DrugOrigin' ) 
	BEGIN
		CREATE TABLE CP_DrugOrigin
			(
			  Yplydm VARCHAR(4) NOT NULL ,	--ҩƷ��Դ����
			  Name VARCHAR(16) NOT NULL ,	--(ҩƷ��Դ)����
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���	
			  Memo VARCHAR(16) NULL ,    	--��ע
			  CONSTRAINT PK_CP_DrugOrigin PRIMARY KEY ( Yplydm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_ClinicOfDrug	ҩƷ�ٴ�Ŀ¼��                          */
/*			(��HIS�е���,EMR�в���ά��)		*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_ClinicOfDrug' ) 
	BEGIN
		CREATE TABLE CP_ClinicOfDrug
			(
			  Lcxh NUMERIC(9, 0) NOT NULL ,	--�ٴ����
			  Ypmc VARCHAR(64) NOT NULL ,	--ҩƷ����
			  Ywmc VARCHAR(32) NULL ,	--Ӣ������
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���	
			  Jxdm VARCHAR(12) NULL ,	--���ʹ���(CP_DosageForm.Jxdm)
			  Ggdw VARCHAR(8) NULL ,	--���λ(����)
			  Ylm VARCHAR(16) NULL ,	--ҩ����
			  Yxjl SMALLINT NOT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(64) NULL ,	--��ע
			  CONSTRAINT PK_CP_ClinicOfDrug PRIMARY KEY ( Lcxh )
			)
		CREATE INDEX idx_py ON CP_ClinicOfDrug(Py)
		CREATE INDEX idx_wb ON CP_ClinicOfDrug(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_FormatOfDrug	ҩƷ���Ŀ¼��                          */
/*			(��HIS�е���,EMR�в���ά��)		*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_FormatOfDrug' ) 
	BEGIN
		CREATE TABLE CP_FormatOfDrug
			(
			  Ggxh NUMERIC(9, 0) NOT NULL ,	--������
			  Lcxh NUMERIC(9, 0) NOT NULL ,	--�ٴ����(CP_ClinicOfDrug.Lcxh)
			  Ypmc VARCHAR(64) NOT NULL ,	--ҩƷ����
			  Ypdm VARCHAR(12) NULL ,	--ҩƷ����
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���	
			  Ypgg VARCHAR(32) NOT NULL ,	--ҩƷ���
			  Jxdm VARCHAR(12) NULL ,	--���ʹ���(CP_DosageForm.Jxdm)
			  Flmxdm VARCHAR(12) NOT NULL ,	--(ҩƷ)������ϸ����(CP_DrugClassDetail.Flmxdm)
			  Zxdw VARCHAR(8) NOT NULL ,	--��С��λ(����)
			  Ggdw VARCHAR(8) NOT NULL ,	--���λ(����)
			  Ggxs NUMERIC(12, 4) NOT NULL ,	--���ϵ��
			  Yplb SMALLINT NOT NULL ,	--ҩƷ���(CP_DataCategory.Mxbh, Lbbh = 24)
			  Fysm VARCHAR(MAX) NULL ,	--����˵��
			  Cfsm VARCHAR(MAX) NULL ,	--���˵��
			  Ylm VARCHAR(16) NULL ,	--ҩ����
			  Yxjl SMALLINT NOT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(64) NULL ,	--��ע
			  CONSTRAINT PK_CP_FormatOfDrug PRIMARY KEY ( Ggxh )
			)
		CREATE INDEX idx_ypdm ON CP_FormatOfDrug(Ypdm)
		CREATE INDEX idx_py ON CP_FormatOfDrug(Py)
		CREATE INDEX idx_wb ON CP_FormatOfDrug(Wb)
		CREATE INDEX idx_lcxh ON CP_FormatOfDrug(Lcxh)
	END
go


/* ============================================================ */
/*   Table: CP_PlaceOfDrug	ҩƷ����Ŀ¼��                          */
/*			(��HIS�е���,EMR�в���ά��)		*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_PlaceOfDrug' ) 
	BEGIN
		CREATE TABLE CP_PlaceOfDrug
			(
			  Cdxh NUMERIC(9, 0) NOT NULL ,	--�������
			  Ggxh NUMERIC(9, 0) NOT NULL ,	--������(CP_FormatOfDrug.Ggxh)
			  Lcxh NUMERIC(9, 0) NOT NULL ,	--�ٴ����(CP_ClinicOfDrug.Lcxh)
			  Ypmc VARCHAR(64) NOT NULL ,	--ҩƷ����(��Ʒ��)
			  Ypdm VARCHAR(12) NULL ,	--ҩƷ����
			  Srm VARCHAR(12) NULL ,	--(ҩƷ)������
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���	
			  Ypgg VARCHAR(32) NOT NULL ,	--ҩƷ���
			  Jxdm VARCHAR(12) NULL ,	--���ʹ���(CP_DosageForm.Jxdm)
			  Flmxdm VARCHAR(12) NOT NULL ,	--(ҩƷ)������ϸ����(CP_DrugClassDetail.Flmxdm)
			  Zxdw VARCHAR(8) NOT NULL ,	--��С��λ(����)
			  Ggdw VARCHAR(8) NOT NULL ,	--���λ(����)
			  Ggxs NUMERIC(12, 4) NOT NULL ,	--���ϵ��
			  Ykdw VARCHAR(8) NOT NULL ,	--ҩ�ⵥλ(����)
			  Ykxs NUMERIC(12, 4) NOT NULL ,	--ҩ��ϵ��
			  Mzdw VARCHAR(8) NOT NULL ,	--���ﵥλ(����)
			  Mzxs NUMERIC(12, 4) NOT NULL ,	--����ϵ��
			  Zydw VARCHAR(8) NOT NULL ,	--סԺ��λ(����)
			  Zyxs NUMERIC(12, 4) NOT NULL ,	--סԺϵ��
			  Ekdw VARCHAR(8) NULL ,	--���Ƶ�λ(����)
			  Ekxs NUMERIC(12, 4) NULL ,	--����ϵ��
			  Lsj MONEY NOT NULL ,	--���ۼ�(ҩ�ⵥλ)
			  Mzbxbz SMALLINT NOT NULL ,	--���ﱨ����־(CP_DataCategory.Mxbh, Lbbh = 25)
			  Zybxbz SMALLINT NOT NULL ,	--סԺ������־(CP_DataCategory.Mxbh, Lbbh = 25)
			  Ypxz INT NOT NULL ,	--ҩƷ����(�Զ�����λ��ʾҩƷ����)
							--0x01(1)	Ƥ��(��ʱ������)
							--0x02(2)	Ƥ��(������Ч)
							--0x04(4)	����ҩƷ
							--0x08(8)	OTC��־
			  Tsypbz SMALLINT NOT NULL ,	--����ҩƷ��־(CP_DataCategory.Mxbh, Lbbh = 26)
			  Yplydm VARCHAR(4) NULL ,	--ҩƷ��Դ����(CP_DrugOrigin.Yplydm)
			  Cjmc VARCHAR(64) NULL ,	--��������
			  Yzglbz SMALLINT NULL ,	--ҽ�������־(CP_DataCategory.Mxbh, Lbbh = 27)
			  Syfw SMALLINT NULL ,	--ʹ�÷�Χ(CP_DataCategory.Mxbh, Lbbh = 28)
			  Yplb SMALLINT NOT NULL ,	--ҩƷ���(CP_DataCategory.Mxbh, Lbbh = 24, Mxbh = 2401/2402/2403)
			  Yxjl SMALLINT NOT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(255) NULL ,	--��ע
			  CONSTRAINT PK_CP_PlaceOfDrug PRIMARY KEY ( Cdxh )
			)
		CREATE INDEX idx_ypdm ON CP_PlaceOfDrug(Ypdm)
		CREATE INDEX idx_py ON CP_PlaceOfDrug(Py)
		CREATE INDEX idx_wb ON CP_PlaceOfDrug(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_UsageMapping	ҩƷ�÷���Ӧ��                          */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_UsageMapping' ) 
	BEGIN
		CREATE TABLE CP_UsageMapping
			(
			  Cdxh NUMERIC(9, 0) NOT NULL ,	--�������(CP_PlaceOfDrug.Cdxh)
			  Yfdm VARCHAR(2) NOT NULL ,	--(ҩƷ)�÷�����(CP_DrugUseage.Yfdm)
			  Pcdm VARCHAR(2) NOT NULL ,	--(ҩƷ)Ƶ�δ���(YY_YZPCK.Pcdm)	
			  Ypjl NUMERIC(14, 3) NULL ,	--ҩƷ����
			  Zxdw VARCHAR(8) NULL ,	--��С��λ(����)(ͳһ�������С��λ,������ʾ���ֵ�λ����ģ������)
			  Ts INT DEFAULT ( 1 )
					 NULL ,	--����
			  Xtbz SMALLINT NOT NULL ,	--ϵͳ��־(CP_DataCategory.Mxbh, Lbbh = 14)
			  CONSTRAINT PK_CP_UsageMapping PRIMARY KEY ( Cdxh, Xtbz )
			)
	END
go

/* ============================================================ */
/*   Table: CP_DrugNickName	ҩƷ������                              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DrugNickName' ) 
	BEGIN
		CREATE TABLE CP_DrugNickName
			(
			  Cdxh NUMERIC(9, 0) NOT NULL ,	--�������(CP_PlaceOfDrug.Cdxh)
			  ypbm VARCHAR(64) NOT NULL ,	--ҩƷ����
			  Ypdm VARCHAR(12) NOT NULL ,	--ҩƷ(����)����
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���
			  Memo VARCHAR(64) NULL ,    	--��ע
			  CONSTRAINT PK_CP_DrugNickName PRIMARY KEY ( Cdxh, ypbm )
			)
		CREATE INDEX idx_py ON CP_DrugNickName(Py)
		CREATE INDEX idx_wb ON CP_DrugNickName(Wb)
		CREATE INDEX idx_ypdm ON CP_DrugNickName(Ypdm)
	END
go

/* ============================================================ */
/*   Table: CP_ChargingBigItem     �շѴ���Ŀ��                            */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_ChargingBigItem' ) 
	BEGIN
		CREATE TABLE CP_ChargingBigItem
			(
			  Dxdm VARCHAR(12) NOT NULL ,	--�������
			  Name VARCHAR(16) NOT NULL ,	--��Ŀ����
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���
			  Xtbz SMALLINT NOT NULL ,	--ϵͳ��־(CP_DataCategory.Mxbh, Lbbh = 14)
			  Xmlb SMALLINT NOT NULL ,	--��Ŀ���(CP_DataCategory.Mxbh, Lbbh = 24)
			  Memo VARCHAR(16) NULL ,    	--��ע
			  CONSTRAINT PK_CP_ChargingBigItem PRIMARY KEY ( Dxdm )
			)
		CREATE INDEX idx_py ON CP_ChargingBigItem(Py)
		CREATE INDEX idx_wb ON CP_ChargingBigItem(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_ChargingMinItem     �շ�С��Ŀ��                          */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_ChargingMinItem' ) 
	BEGIN
		CREATE TABLE CP_ChargingMinItem
			(
			  Sfxmdm VARCHAR(12) NOT NULL ,	--�շ���Ŀ����
			  Name VARCHAR(64) NOT NULL ,	--��Ŀ����
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���
			  Dxdm VARCHAR(12) NOT NULL ,	--(����)�������(CP_ChargingBigItem.Dxdm)
			  Xmdw VARCHAR(8) NULL ,	--��Ŀ��λ(����)
			  Xmgg VARCHAR(32) NULL ,	--��Ŀ���
			  Xmdj MONEY NOT NULL ,	--��Ŀ����
			  Mzbxbz SMALLINT NOT NULL ,	--���ﱨ����־(CP_DataCategory.Mxbh, Lbbh = 25)
			  Zybxbz SMALLINT NOT NULL ,	--סԺ������־(CP_DataCategory.Mxbh, Lbbh = 25)
			  Xmlb SMALLINT NOT NULL ,	--��Ŀ���(CP_DataCategory.Mxbh, Lbbh = 24)
			  Xtbz SMALLINT NOT NULL ,	--ϵͳ��־(CP_DataCategory.Mxbh, Lbbh = 14)
			  Xmxz SMALLINT NOT NULL ,	--��Ŀ����(�ö�����λ��ʾ)
							--0x01(1)	����ҽ��
							--0x02(2)	��ҽ��(����ҽ��)
			  Xskz SMALLINT NOT NULL ,	--��ʾ����(�ö�����λ��ʾ)
							--0x01(1)	����ʾƵ��
							--0x02(2)	����ʾ����
							--0x04(4)	����ӡ
			  Fjxx VARCHAR(16) NULL ,	--������Ϣ(�ṩ����Ĵ�����Ϣ,�����Ӧ����������)
			  Syfw SMALLINT NULL ,	--ʹ�÷�Χ(CP_DataCategory.Mxbh, Lbbh = 28)
			  Yzglbz SMALLINT NULL ,	--ҽ�������־(CP_DataCategory.Mxbh, Lbbh = 27)
			  Yxjl SMALLINT NOT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(64) NULL ,    	--��ע
			  CONSTRAINT PK_CP_ChargingMinItem PRIMARY KEY ( Sfxmdm )
			)
		CREATE INDEX idx_py ON CP_ChargingMinItem(Py)
		CREATE INDEX idx_wb ON CP_ChargingMinItem(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_MinItemNick	�շ�С��Ŀ������                        */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_MinItemNick' ) 
	BEGIN
		CREATE TABLE CP_MinItemNick
			(
			  Sfxmdm VARCHAR(12) NOT NULL ,	--�շ���Ŀ����
			  Xmbm VARCHAR(64) NOT NULL ,	--��Ŀ����
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���
			  Memo VARCHAR(64) NULL ,    	--��ע
			  CONSTRAINT PK_CP_MinItemNick PRIMARY KEY ( Sfxmdm, Xmbm )
			)
		CREATE INDEX idx_py ON CP_MinItemNick(Py)
		CREATE INDEX idx_wb ON CP_MinItemNick(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_AdviceGroup	����ҽ����                          */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_AdviceGroup' ) 
	BEGIN
		CREATE TABLE CP_AdviceGroup
			(
			  Ctyzxh NUMERIC(9, 0) IDENTITY
								   NOT NULL ,	--����ҽ�����
			  PahtDetailID varchar(50) NOT NULL, --���ýڵ�ID
			  Name VARCHAR(32) NOT NULL ,	--(����ҽ��)����
			  Ljdm VARCHAR(12),--�ٴ�·������(CP_ClinicalPath.Ljdm)
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���
			  Ksdm VARCHAR(12) NULL ,	--(����)���Ҵ���(YY_KSDMK.Ksdm)
			  Bqdm VARCHAR(12) NULL ,	--(����)��������(YY_BQDMK.Bqdm)
			  Ysdm VARCHAR(6) NULL ,	--(����)ҽ������(CP_Employee.zgdm)
			  Syfw SMALLINT NULL ,	--ʹ�÷�Χ(CP_DataCategory.Mxbh, Lbbh = 29)
			  Memo VARCHAR(16) NULL ,    	--��ע
			  CONSTRAINT PK_CP_AdviceGroup PRIMARY KEY ( Ctyzxh )
			)
		CREATE INDEX idx_py ON CP_AdviceGroup(Py)
		CREATE INDEX idx_wb ON CP_AdviceGroup(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_AdviceGroupDetail	����ҽ����ϸ��              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_AdviceGroupDetail' ) 
	BEGIN
		CREATE TABLE CP_AdviceGroupDetail
			(
			  Ctmxxh NUMERIC(9, 0) IDENTITY
								   NOT NULL ,	--������ϸ���
			  Ctyzxh NUMERIC(9, 0) NOT NULL ,	--(����)����ҽ�����(CP_AdviceGroup.Ctyzxh)
			  Yzbz SMALLINT NULL ,	--ҽ����־(CP_DataCategory.Mxbh, Lbbh = 27)
			  Fzxh NUMERIC(12, 0)  null,	--�������(ÿ��ĵ�һ��ҽ�������)
			  Fzbz SMALLINT NULL ,	--�����־(CP_DataCategory.Mxbh, Lbbh = 35)
			  Cdxh NUMERIC(9, 0) NOT NULL ,	--�������(CP_PlaceOfDrug.Cdxh)
			  Ggxh NUMERIC(9, 0) NOT NULL ,	--������(CP_FormatOfDrug.Ggxh)
			  Lcxh NUMERIC(9, 0) NOT NULL ,	--�ٴ����(CP_ClinicOfDrug.Lcxh)
			  Ypdm VARCHAR(12) NOT NULL ,	--ҩƷ����(or�շ�С��Ŀ����or�ٴ���Ŀ����,���������ִ��������Ŀ������ж�)(CP_PlaceOfDrug.Ypdm/CP_ChargingMinItem.Sfxmdm/CP_LCChargingItem.Lcxmdm)
			  Ypmc VARCHAR(64) NULL ,	--ҩƷ(��Ŀ)����(CP_PlaceOfDrug.Name/CP_ChargingMinItem.Name)
			  Xmlb SMALLINT NOT NULL ,	--��Ŀ���(CP_DataCategory.Mxbh, Lbbh = 24)
			  Zxdw VARCHAR(8) NULL ,	--��С��λ(CP_PlaceOfDrug.Zxdw)
			  Ypjl NUMERIC(14, 3) NULL ,	--ҩƷ����
			  Jldw VARCHAR(8) NULL ,	--������λ(��ʾ��)(CP_PlaceOfDrug.Ggdw/CP_PlaceOfDrug.Zydw)
			  Dwxs NUMERIC(12, 4) NULL ,	--��λϵ��(���ϵ����סԺϵ��,ע����ϵ��Ҫ�����ķ���
			  Dwlb SMALLINT NULL ,	--��λ���(CP_DataCategory.Mxbh, Lbbh = 30)
			  Yfdm VARCHAR(2) NULL ,	--(ҩƷ)�÷�����(CP_DrugUseage.Yfdm)
			  Pcdm VARCHAR(2) DEFAULT ( '' )
							  NULL ,	--Ƶ�δ���(YY_YZPCK.Pcdm)
			  Zxcs INT DEFAULT ( 1 )
					   NULL ,	--ִ�д���
			  Zxzq INT DEFAULT ( 1 )
					   NULL ,	--ִ������
			  Zxzqdw SMALLINT DEFAULT ( -1 )
							  NULL ,	--ִ�����ڵ�λ(CP_DataCategory.Mxbh, Lbbh = 34)
			  Zdm CHAR(7) DEFAULT ( '' )
						  NULL ,	--�ܴ���
			  Zxsj VARCHAR(64) NULL ,	--(Ƶ�ε�)ִ��ʱ��
			  Zxts INT NULL ,	--ִ������(Ϊ��Ժ��ҩ����)
			  Ypzsl NUMERIC(14, 3) NULL ,	--ҩƷ������(Ϊ��Ժ��ҩ����,ʹ�ü�����λ)
			  Ztnr VARCHAR(64) NULL ,	--��������
			  Yzlb SMALLINT NOT NULL ,	--ҽ�����(CP_DataCategory.Mxbh, Lbbh = 31)
			  CONSTRAINT PK_CP_AdviceGroupDetail PRIMARY KEY ( Ctmxxh )
			)
	END
go

/* ============================================================ */
/*   Table: CP_LCChargingItem	�ٴ��շ���Ŀ��                          */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_LCChargingItem' ) 
	BEGIN
		CREATE TABLE CP_LCChargingItem
			(
			  Lcxmdm VARCHAR(12) NOT NULL ,	--�ٴ���Ŀ����
			  Name VARCHAR(64) NOT NULL ,	--(�ٴ���Ŀ)����
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���
			  Srm VARCHAR(12) NULL ,	--(��Ŀ)������
			  Xmdj MONEY NULL ,	--��Ŀ����
			  Zxmdm VARCHAR(12) NULL ,	--����Ŀ����
			  Yxjl SMALLINT NOT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Xmlb SMALLINT NULL ,	--��Ŀ���(CP_DataCategory.Mxbh, Lbbh = 24)
			  Sjdm VARCHAR(12) NULL ,	--(����)�ϼ�����
			  Xmjb SMALLINT NULL ,	--(�ٴ�)��Ŀ����(�Ӹߵ���1~4,����������ι�ϵ;ֻ��4��������ϸ��Ϣ)
			  CONSTRAINT PK_CP_LCChargingItem PRIMARY KEY ( Lcxmdm )
			)
		CREATE INDEX idx_py ON CP_LCChargingItem(Py)
		CREATE INDEX idx_wb ON CP_LCChargingItem(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_LCChargingItemMap	�ٴ��շ���Ŀ��Ӧ��              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_LCChargingItemMap' ) 
	BEGIN
		CREATE TABLE CP_LCChargingItemMap
			(
			  Lcxmdm VARCHAR(12) NOT NULL ,	--(����)�ٴ���Ŀ����(CP_LCChargingItem.Lcxmdm)
			  Sfxmdm VARCHAR(12) NOT NULL ,	--�շ���Ŀ����(CP_ChargingMinItem.Sfxmdm)
			  Xmsl NUMERIC(10, 2) NOT NULL ,	--��Ŀ����
			  Dxdm VARCHAR(12) NULL ,	--(����)�������(CP_ChargingBigItem.Dxdm)
			  Jlwz INT NULL ,	--��¼λ��(0:ֻ��һ��; 1:��ʼ; (1,1000):�м�; 1000:����)
			  Memo VARCHAR(16) NULL ,    	--��ע
			  CONSTRAINT PK_CP_LCChargingItemMap PRIMARY KEY
				( Lcxmdm, Sfxmdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_DrugUseage	ҩƷ�÷���                              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DrugUseage' ) 
	BEGIN
		CREATE TABLE CP_DrugUseage
			(
			  Yfdm VARCHAR(2) NOT NULL ,	--(ҩƷ)�÷�����
			  Name VARCHAR(16) NOT NULL ,	--(�÷�)����
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���
			  Ctsy SMALLINT NOT NULL ,	--����ʹ��(ֻ���ڳ���ҽ��)(CP_DataCategory.Mxbh Lbbh = 0)
			  Zdfz SMALLINT NOT NULL ,	--�Զ�����(CP_DataCategory.Mxbh Lbbh = 0)
			  Yflb SMALLINT NOT NULL ,	--�÷����(CP_DataCategory.Mxbh Lbbh = 45)
			  Yxjl SMALLINT NOT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,    	--��ע
			  CONSTRAINT PK_CP_DrugUseage PRIMARY KEY ( Yfdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_Dosage2Useage	�����÷���Ӧ��                          */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Dosage2Useage' ) 
	BEGIN
		CREATE TABLE CP_Dosage2Useage
			(
			  Jxdm VARCHAR(12) NOT NULL ,	--���ʹ���(CP_DosageForm.Jxdm)
			  Yfjh VARCHAR(255) NOT NULL ,	--(��Ӧ��)�÷�����(��'�÷�����1','�÷�����2'����ʽ���)
			  Memo VARCHAR(16) NULL ,    	--��ע
			  CONSTRAINT PK_CP_Dosage2Useage PRIMARY KEY ( Jxdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_AdviceFrequency	ҽ��Ƶ�ο�                              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_AdviceFrequency' ) 
	BEGIN
		CREATE TABLE CP_AdviceFrequency
			(
			  Pcdm VARCHAR(2) NOT NULL ,	--Ƶ�δ���
			  Name VARCHAR(16) NOT NULL ,	--(Ƶ��)����
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���	
			  Zxcs INT NOT NULL ,	--ִ�д���(ÿ������ִ�еĴ���)
			  Zxzq INT DEFAULT ( 1 )
					   NOT NULL ,	--ִ������
			  Zxzqdw SMALLINT NOT NULL ,	--ִ�����ڵ�λ(��λΪ��ʱ,ִ�����ڱ�ʾ1��������ִ�е�����)(CP_DataCategory.Mxbh, Lbbh = 34)
			  Zdm CHAR(7) DEFAULT ( '' )
						  NOT NULL ,	--�ܴ���(ָ����һ���е��ļ���ִ��,�Զ�Ӧ�������е�ĳ�������϶���,��1-7�ֱ��ʾ����һ����)
			  Zxsj VARCHAR(64) NULL ,	--ִ��ʱ��(ҽ��ÿ��ִ�е�ʱ���,24Сʱ��,��ȷ��Сʱ,��'0'����2λ,���ʱ��','����)
			  zbbz SMALLINT NULL ,	--�Ա���־(CP_DataCategory.Mxbh Lbbh = 0)
			  Yzglbz SMALLINT NULL ,	--ҽ�������־(CP_DataCategory.Mxbh, Lbbh = 27)
			  Yxjl SMALLINT NOT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,    	--��ע
			  CONSTRAINT PK_CP_AdviceFrequency PRIMARY KEY ( Pcdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_OperationDept	�������ҿ�                     	        */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_OperationDept' ) 
	BEGIN
		CREATE TABLE CP_OperationDept
			(
			  Ssksdm VARCHAR(12) NOT NULL ,	--�������Ҵ���
			  Name VARCHAR(32) NOT NULL ,	--(��������)����
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���
			  Memo VARCHAR(16) NULL ,    	--��ע
			  CONSTRAINT PK_CP_OperationDept PRIMARY KEY ( Ssksdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_AnesthesiaDept	������ҿ�                     	        */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_AnesthesiaDept' ) 
	BEGIN
		CREATE TABLE CP_AnesthesiaDept
			(
			  Mzksdm VARCHAR(12) NOT NULL ,	--������Ҵ���
			  Name VARCHAR(32) NOT NULL ,	--(�������)����
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���
			  Memo VARCHAR(16) NULL ,    	--��ע
			  CONSTRAINT PK_CP_AnesthesiaDept PRIMARY KEY ( Mzksdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_Oper2Anest	����������Ҷ�Ӧ��              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Oper2Anest' ) 
	BEGIN
		CREATE TABLE CP_Oper2Anest
			(
			  Ssksdm VARCHAR(12) NOT NULL ,	--�������Ҵ���(CP_OperationDept.Ssksdm)
			  Mzksdm VARCHAR(12) NOT NULL ,	--������Ҵ���(CP_AnesthesiaDept.Mzksdm)
			  CONSTRAINT PK_CP_Oper2Anest PRIMARY KEY ( Ssksdm, Mzksdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_OperRoom (����)��������                             */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_OperRoom' ) 
	BEGIN
		CREATE TABLE CP_OperRoom
			(
			  Ssfjdm VARCHAR(12) NOT NULL ,	--�����������
			  Name VARCHAR(16) NOT NULL ,	--(��������)����
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���
			  Ssksdm VARCHAR(12) NOT NULL ,	--(����)�������Ҵ���(CP_OperationDept.Ssksdm)
			  Memo VARCHAR(16) NULL ,    	--��ע
			  CONSTRAINT PK_CP_OperRoom PRIMARY KEY ( Ssfjdm, Ssksdm )
			)
	END
go


/* ============================================================ */
/*   Table: CP_Bed	��λ�����                               */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Bed' ) 
	BEGIN
		CREATE TABLE CP_Bed
			(
			  Cwdm VARCHAR(12) NOT NULL ,	--��λ����
			  Bqdm VARCHAR(12) NOT NULL ,	--��������(YY_BQDMK.Bqdm)
			  Ksdm VARCHAR(12) NOT NULL ,	--���Ҵ���(YY_KSDMK.Ksdm)
			  Fjh VARCHAR(16) NULL ,	--�����
			  Zyysdm VARCHAR(6) NULL ,	--סԺҽʦ����(CP_Employee.zgdm)
			  Zzysdm VARCHAR(6) NULL ,	--����ҽʦ����(CP_Employee.zgdm)
			  Zrysdm VARCHAR(6) NULL ,	--����ҽʦ����(CP_Employee.zgdm)
			  Cwlx SMALLINT NOT NULL ,	--��λ����(CP_DataCategory.Mxbh Lbbh = 11)
			  Bzlx SMALLINT NOT NULL ,	--��������(CP_DataCategory.Mxbh Lbbh = 12)
			  Zcbz SMALLINT NOT NULL ,	--ռ����־(CP_DataCategory.Mxbh Lbbh = 13)
			  Txbz SMALLINT NOT NULL ,	--�����־(CP_DataCategory.Mxbh Lbbh = 0)
			  Syxh NUMERIC(9, 0) NULL ,	--��ҳ���(סԺ��ˮ��)
			  Hissyxh NUMERIC(9, 0) NULL ,	--HIS��ҳ���
			  Ybqdm VARCHAR(12) NULL ,	--ԭ��������(YY_BQDMK.Bqdm)
			  Ycwdm VARCHAR(12) NULL ,	--ԭ��λ����(BL_BCDMK.Cwdm)
			  Yksdm VARCHAR(12) NULL ,	--ԭ���Ҵ���(YY_KSDMK.Ksdm)
			  Jcbz SMALLINT NULL ,	--�贲��־(CP_DataCategory.Mxbh Lbbh = 0)
			  Yxjl SMALLINT NOT NULL ,	--��Ч��¼(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--��ע
			  CONSTRAINT PK_CP_Bed PRIMARY KEY ( Cwdm, Bqdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_InPatient (סԺ)������ҳ��                             */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_InPatient' ) 
	BEGIN
		CREATE TABLE CP_InPatient
			(
			  Syxh NUMERIC(9, 0) IDENTITY
								 NOT NULL ,	--��ҳ���(סԺ��ˮ��)
			  Hissyxh NUMERIC(9, 0) NOT NULL ,	--HIS��ҳ���(HIS�в���ÿ��סԺ��Ψһ��ʶ,��ӦHIS�е�Syxh)
			  Mzhm VARCHAR(24) NULL ,	--�������
			  Bahm VARCHAR(32) NOT NULL ,	--��������
			  Zyhm VARCHAR(24) NOT NULL ,	--סԺ����
			  Glzyhm VARCHAR(24) NULL ,	--����סԺ����(������ʶͬһ���˶����Ժ��סԺ�Ų�һ�������,Ŀǰ�Ǹ����籣���ù���)
			  Hzxm VARCHAR(32) NOT NULL ,	--��������
			  Py VARCHAR(8) NULL ,	--ƴ��(����������д)
			  Wb VARCHAR(8) NULL ,	--���(����������д)
			  Brxz VARCHAR(4) NULL ,	--��������(�� ҽ�Ƹ��ʽ)(CP_DictionaryDetail.Mxdm, lbdm = '1')
			  Brly VARCHAR(4) NULL ,	--������Դ(CP_DictionaryDetail.Mxdm, lbdm = '2')
			  Rycs INT NOT NULL ,	--��Ժ����
			  Brxb VARCHAR(4) NOT NULL ,	--�����Ա�(CP_DictionaryDetail.Name, lbdm = '3')
			  Csrq CHAR(10) NOT NULL ,	--��������
			  Brnl INT NULL ,	--��������(ʵ�ʵ�����,��ʽΪYYYYMMDD,YYYY��ʾ�����ֵ,MM��ʾ�µ���ֵ,DD��ʾ�յ���ֵ)
			  Xsnl VARCHAR(16) NULL ,	--��ʾ����(����ʵ�������ʾ������,��XXX��,XX��XX��,XX��)
			  Sfzh VARCHAR(18) NULL ,	--���֤��
			  Hyzk VARCHAR(4) NULL ,	--����״��(CP_DictionaryDetail.Mxdm, lbdm = '4')
			  Zydm VARCHAR(4) NULL ,	--ְҵ����(CP_DictionaryDetail.Mxdm, lbdm = '41')
			  Ssdm VARCHAR(10) NULL ,	--(������)ʡ�д���(YY_DQDMK.dqdm, dqlb = 1000)
			  Qxdm VARCHAR(10) NULL ,	--(������)���ش���(YY_DQDMK.dqdm, dqlb = 1001)
			  Mzdm VARCHAR(4) NULL ,	--�������(CP_DictionaryDetail.Mxdm, lbdm = '42')
			  Gjdm VARCHAR(4) NULL ,	--��������(CP_DictionaryDetail.Mxdm, lbdm = '43')
			  Jgssdm VARCHAR(10) NULL ,	--����ʡ�д���(YY_DQDMK.dqdm, dqlb = 1000)
			  Jgqxdm VARCHAR(10) NULL ,	--�������ش���(YY_DQDMK.dqdm, dqlb = 1001)
			  Gzdw VARCHAR(64) NULL ,	--������λ(��ȱ)
			  Dwdz VARCHAR(64) NULL ,	--��λ��ַ
			  Dwdh VARCHAR(16) NULL ,	--��λ�绰
			  Dwyb VARCHAR(16) NULL ,	--��λ�ʱ�
			  Hkdz VARCHAR(64) NULL ,	--���ڵ�ַ
			  Hkdh VARCHAR(16) NULL ,	--���ڵ绰
			  Hkyb VARCHAR(16) NULL ,	--�����ʱ�
			  Dqdz VARCHAR(255) NULL ,	--��ǰ��ַ
			  Lxrm VARCHAR(32) NULL ,	--��ϵ����
			  Lxgx VARCHAR(4) NULL ,	--��ϵ��ϵ(CP_DictionaryDetail.Mxdm, lbdm = '44')
			  Lxdz VARCHAR(255) NULL ,	--��ϵ��ַ
			  Lxdw VARCHAR(64) NULL ,	--��ϵ(��)��λ
			  Lxdh VARCHAR(16) NULL ,	--��ϵ�绰
			  Lxyb VARCHAR(16) NULL ,	--��ϵ�ʱ�
			  Bscsz VARCHAR(64) NULL ,	--��ʷ������
			  Sbkh VARCHAR(32) NULL ,	--�籣����
			  Bxkh VARCHAR(32) NULL ,	--���տ���
			  Qtkh VARCHAR(32) NULL ,	--��������(��ſ���)
			  Ryqk VARCHAR(4) NULL ,	--��Ժ���(��Ժʱ����, CP_DictionaryDetail.Mxdm, lbdm = '5')
			  Ryks VARCHAR(12) NULL ,	--��Ժ����(YY_KSDMK.Ksdm)
			  Rybq VARCHAR(12) NULL ,	--��Ժ����(YY_BQDMK.Bqdm)
			  Rycw VARCHAR(12) NULL ,	--��Ժ��λ(CP_Bed.Cwdm)
			  Ryrq CHAR(19) NOT NULL ,	--��Ժ����
			  Rqrq CHAR(19) NULL ,	--��������
			  Ryzd VARCHAR(50) NULL ,	--��Ժ���(CP_Diagnosis.zddm)
			  Cyks VARCHAR(12) NULL ,	--��Ժ����(YY_KSDMK.Ksdm)
			  Cybq VARCHAR(12) NULL ,	--��Ժ����(YY_BQDMK.Bqdm)
			  Cycw VARCHAR(12) NULL ,	--��Ժ��λ(CP_Bed.Cwdm)
			  Cqrq CHAR(19) NULL ,	--��������
			  Cyrq CHAR(19) NULL ,	--��Ժ����
			  Cyzd VARCHAR(12) NULL ,	--��Ժ���(CP_Diagnosis.zddm)
			  Zyts NUMERIC(6, 1) NULL ,	--סԺ����
			  Mzzd VARCHAR(12) NULL ,	--�������(CP_Diagnosis.zddm)
			  Mzzdzy VARCHAR(12) NULL ,	--�������(��ҽ)(CP_DiagnosisOfChinese.Zyzddm)
			  Mzzhzy VARCHAR(12) NULL ,	--����֢��(��ҽ)(CP_DiagnosisOfChinese.Zyzddm)
			  Fbjq VARCHAR(16) NULL ,	--��������
			  Rytj VARCHAR(4) NULL ,	--��Ժ;��(CP_DictionaryDetail.Mxdm, lbdm = '6')
			  Cyfs VARCHAR(4) NULL ,	--��Ժ��ʽ(CP_DictionaryDetail.Mxdm, lbdm = '15')	
			  Mzys VARCHAR(6) NULL ,	--����ҽ��(CP_Employee.zgdm)
			  Zyys VARCHAR(6) NULL ,	--סԺҽ��(CP_Employee.zgdm)
			  Zzysdm VARCHAR(6) NULL ,	--����ҽʦ����(CP_Employee.zgdm)
			  Zrysdm VARCHAR(6) NULL ,	--����ҽʦ����(CP_Employee.zgdm)
			  Whcd VARCHAR(4) NULL ,	--�Ļ��̶�(CP_DictionaryDetail.Mxdm, lbdm = '25')
			  Jynx NUMERIC(10, 2) NULL ,	--(��)��������(��λ:��)
			  Zjxy VARCHAR(32) NULL ,	--�ڽ�����
			  Brzt SMALLINT NOT NULL ,	--����״̬(CP_DataCategory.Mxbh, Lbbh = 15)
			  Wzjb VARCHAR(2) NULL ,	--Σ�ؼ���(CP_DictionaryDetail.Mxdm, lbdm = '53')
			  Hljb VARCHAR(12) NULL ,	--������(CP_ChargingMinItem.Sfxmdm, Xmlb = 2409)
			  Zdbr SMALLINT NULL ,	--�ص㲡��(CP_DataCategory.Mxbh, Lbbh = 0)
			  Yexh SMALLINT NOT NULL ,	--Ӥ�����(��1��ʼ��0��ʾ����Ӥ��)
			  Mqsyxh NUMERIC(9, 0) NULL ,	--ĸ����ҳ���(CP_InPatient.Syxh, yexh = 0)
			  Ybdm VARCHAR(4)   NULL ,	--ҽ������(CP_MedicareInfo.ybdm)
			  Ybde MONEY NOT NULL ,	--ҽ������
			  Brlx VARCHAR(2) NULL ,	--��������(CP_DictionaryDetail.Mxdm, lbdm = '45')
			  Pzlx VARCHAR(12) NULL ,	--ƾ֤����(����)(CP_MedicareInfo.pzlx)
			  Pzlxmc VARCHAR(16) NULL ,	--ƾ֤��������(CP_MedicareInfo.pzlxmc)
			  Pzh VARCHAR(64) NULL ,	--ƾ֤��
			  Czyh VARCHAR(6) NULL ,	--����Ա(YY_CZRYK.czydm)
			  Xxh VARCHAR(64) NULL ,   --X�ߺ�
			  Gxrq CHAR(19) NULL ,	--��������
			  Memo VARCHAR(64) NULL ,	--��ע	
			  CONSTRAINT PK_CP_InPatient PRIMARY KEY ( Syxh )
			)
		ALTER TABLE CP_InPatient ADD CONSTRAINT idx_syxh UNIQUE (Hissyxh)
		CREATE INDEX idx_zyhm ON CP_InPatient(Zyhm)
		CREATE INDEX idx_sbkh ON CP_InPatient(Sbkh)
	END
go

/* ============================================================ */
/*   Table: CP_BedInfo	���˴�λ��Ϣ��                          */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_BedInfo' ) 
	BEGIN
		CREATE TABLE CP_BedInfo
			(
			  Cwxxxh NUMERIC(12, 0) IDENTITY
									NOT NULL ,	--��λ��Ϣ���
			  Syxh NUMERIC(9, 0) NOT NULL ,	--��ҳ���(CP_InPatient.Syxh)
			  Ksdm VARCHAR(12) NOT NULL ,	--(ԭ)���Ҵ���(YY_KSDMK.Ksdm)
			  Bqdm VARCHAR(12) NOT NULL ,	--(ԭ)��������(YY_BQDMK.Bqdm)
			  Cwdm VARCHAR(12) NOT NULL ,	--(ԭ)��λ����(CP_Bed.Cwdm)
			  Ksrq CHAR(19) NOT NULL ,	--��ʼ����(���䵽ԭ��λ��ʱ��)
			  Jsrq CHAR(19) NULL ,	--��������(�뿪ԭ��λ��ʱ��)
			  Xksdm VARCHAR(12) NULL ,	--�¿��Ҵ���(ת�ƻ�ת����Ŀ���, YY_KSDMK.Ksdm)
			  Xbqdm VARCHAR(12) NULL ,	--�²�������(ת�ƻ�ת����Ĳ���, YY_BQDMK.Bqdm)
			  Xcwdm VARCHAR(12) NULL ,	--�´�λ����(ת�ƻ�ת����Ĵ�λ, CP_Bed.Cwdm)
			  Isdqcw SMALLINT NOT NULL ,	--�ǵ�ǰ��λ(CP_DataCategory.Mxbh, Lbbh = 0)
			  CONSTRAINT PK_CP_BedInfo PRIMARY KEY NONCLUSTERED ( Cwxxxh )
			)
		CREATE CLUSTERED INDEX idx_syxh ON CP_BedInfo(Syxh)
	END
go

/* ============================================================ */
/*   Table: CP_TempOrder	��ʱҽ����                             */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_TempOrder' ) 
	BEGIN
		CREATE TABLE CP_TempOrder
			(
			  Lsyzxh NUMERIC(12, 0) IDENTITY
									NOT NULL ,	--��ʱҽ�����
			  Syxh NUMERIC(9, 0) NOT NULL ,	--��ҳ���(CP_InPatient.Syxh)
			  Fzxh NUMERIC(12, 0) NOT NULL ,	--�������(ÿ��ĵ�һ��ҽ�������)
			  Fzbz SMALLINT NOT NULL ,	--�����־(����������¼��ͬ���¼�е�λ��, CP_DataCategory.mxxh, Lbbh = 35)
			  Bqdm VARCHAR(12) NOT NULL ,	--��������(YY_BQDMK.Bqdm)
			  Ksdm VARCHAR(12) NOT NULL ,	--���Ҵ���(YY_KSDMK.Ksdm)
			  Lrysdm VARCHAR(6) NOT NULL ,	--¼��ҽ������(CP_Employee.zgdm, zglb = 400,401)
			  Lrrq CHAR(19) NOT NULL ,	--¼������
			  Shczy VARCHAR(16) NULL ,	--��˲���Ա(����)(��Ϊ���/ִ�ж���HIS�Ļ�ʿ,����EMR��ְ����Ҫ��HISһ��)
			  Shrq CHAR(19) NULL ,	--�������
			  Zxczy VARCHAR(16) NULL ,	--ִ�в���Ա(����)(ҽ�������ִ�л�ʿ)
			  Zxrq CHAR(19) NULL ,	--ִ������(ҽ�������ִ��ʱ��,����ҩ�޹�)
			  Qxysdm VARCHAR(6) NULL ,	--ȡ��ҽ������(CP_Employee.zgdm, zglb = 400,401)
			  Qxrq CHAR(19) NULL ,	--ȡ������
			  Ksrq CHAR(19) NULL ,	--(ҽ��)��ʼ����
			  Cdxh NUMERIC(9, 0) NOT NULL ,	--�������(CP_PlaceOfDrug.Cdxh)
			  Ggxh NUMERIC(9, 0) NOT NULL ,	--������(CP_FormatOfDrug.Ggxh)
			  Lcxh NUMERIC(9, 0) NOT NULL ,	--�ٴ����(CP_ClinicOfDrug.Lcxh)
			  Ypdm VARCHAR(12) NOT NULL ,	--ҩƷ����(or�շ�С��Ŀ����or�ٴ���Ŀ����,���������ִ��������Ŀ������ж�)(CP_PlaceOfDrug.Ypdm/CP_ChargingMinItem.Sfxmdm/CP_LCChargingItem.Lcxmdm)
			  Ypmc VARCHAR(64) NULL ,	--ҩƷ(��Ŀ)����(CP_PlaceOfDrug.Name/CP_ChargingMinItem.Name)
			  Ypgg VARCHAR(32) NULL ,	--ҩƷ���(CP_PlaceOfDrug.Ypgg)
			  Xmlb SMALLINT NOT NULL ,	--��Ŀ���(CP_DataCategory.Mxbh, Lbbh = 24)
			  Zxdw VARCHAR(8) NULL ,	--��С��λ(CP_PlaceOfDrug.Zxdw)
			  Ypjl NUMERIC(14, 3) NULL ,	--ҩƷ����
			  Jldw VARCHAR(8) NULL ,	--������λ(��ʾ��)(CP_PlaceOfDrug.Ggdw/CP_PlaceOfDrug.Zydw)
			  Dwxs NUMERIC(12, 4) NULL ,	--��λϵ��(���ϵ����סԺϵ��,ע����ϵ��Ҫ�����ķ���
			  Dwlb SMALLINT NULL ,	--��λ���(��ǰ����ʹ�õ��Ǻ��ֵ�λ,CP_DataCategory.Mxbh, Lbbh = 30)
			  Yfdm VARCHAR(2) NULL ,	--(ҩƷ)�÷�����(CP_DrugUseage.fydm)
			  Pcdm VARCHAR(2) DEFAULT ( '' )
							  NULL ,	--Ƶ�δ���(YY_YZPCK.Pcdm)
			  Zxcs INT DEFAULT ( 1 )
					   NULL ,	--ִ�д���
			  Zxzq INT DEFAULT ( 1 )
					   NULL ,	--ִ������
			  Zxzqdw SMALLINT DEFAULT ( -1 )
							  NULL ,	--ִ�����ڵ�λ(CP_DataCategory.Mxbh, Lbbh = 34)
			  Zdm CHAR(7) DEFAULT ( '' )
						  NULL ,	--�ܴ���
			  Zxsj VARCHAR(64) NULL ,	--(Ƶ�ε�)ִ��ʱ��
			  Zxts INT NULL ,	--ִ������(Ϊ��Ժ��ҩ����)
			  Ypzsl NUMERIC(14, 3) NULL ,	--ҩƷ������(Ϊ��Ժ��ҩ����,ʹ�ü�����λ)
			  Zxks VARCHAR(12) NULL ,	--��Ŀ��ִ�п���(Ŀǰֻ�Դ����뵥�������Ŀ��Ч)
			  Ztnr VARCHAR(64) NULL ,	--��������
			  Yzlb SMALLINT NOT NULL ,	--ҽ�����(CP_DataCategory.Mxbh, Lbbh = 31)
			  Yzzt SMALLINT NOT NULL ,	--ҽ��״̬(CP_DataCategory.Mxbh, Lbbh = 32)
			  Tsbj SMALLINT NOT NULL ,	--������(�Զ�����λ��ʾ)
							--0x01(1)	�Ա�ҩ
							--0x02(2)	��Һ
							--0x04(4)	��ӡ
							--0x08(8)	����ͣ����ҽ��
							--0x10(16)	��Ҫҽ������
			  Ybsptg SMALLINT NULL ,	--ҽ������ͨ��(CP_DataCategory.Mxbh Lbbh = 0)
			  Ybspbh VARCHAR(32) NULL ,	--ҽ���������
			  Tzxh NUMERIC(12, 0) NULL ,	--ֹͣ���(CP_LongOrder.Cqyzxh)
			  Tzrq CHAR(19) NULL ,	--ֹͣ����	
			  Sqdxh NUMERIC(12, 0) NULL ,	--(ҽ��)���뵥���(�ȴ���ҽ������ӿ�ʱ�ٴ���!!!)
			  Yznr VARCHAR(255) NULL ,	--ҽ������(��ʾ�ڽ����ϵ�ҽ������)
			  Tbbz SMALLINT NULL ,	--ͬ����־(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(64) NULL ,	--��ע
			  Djfl VARCHAR(4) NULL ,	--���ݷ���(���ݻ���) --wxg add, 2009-1-8
			  Bxbz INT NULL ,	--�����׼��1.��0.��
			  Ctmxxh NUMERIC(9, 0) ,	--������ϸ���
			  CONSTRAINT PK_CP_TempOrder PRIMARY KEY NONCLUSTERED ( Lsyzxh )
			)
		CREATE CLUSTERED INDEX idx_syxh ON CP_TempOrder(Syxh) WITH FILLFACTOR=90
		CREATE INDEX idx_fzxh ON CP_TempOrder(Fzxh)
	END
go

/* ============================================================ */
/*   Table: CP_LongOrder (����)����ҽ��                         */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_LongOrder' ) 
	BEGIN
		CREATE TABLE CP_LongOrder
			(
			  Cqyzxh NUMERIC(12, 0) IDENTITY
									NOT NULL ,	--����ҽ�����
			  Syxh NUMERIC(9, 0) NOT NULL ,	--��ҳ���(CP_InPatient.Syxh)
			  Fzxh NUMERIC(12, 0) NOT NULL ,	--�������(ÿ��ĵ�һ��ҽ�������)
			  Fzbz SMALLINT NOT NULL ,	--�����־(����������¼��ͬ���¼�е�λ��, CP_DataCategory.mxxh, Lbbh = 35)
			  Bqdm VARCHAR(12) NOT NULL ,	--��������(YY_BQDMK.Bqdm)
			  Ksdm VARCHAR(12) NOT NULL ,	--���Ҵ���(YY_KSDMK.Ksdm)
			  Lrysdm VARCHAR(6) NOT NULL ,	--¼��ҽ������(CP_Employee.zgdm, zglb = 400,401)
			  Lrrq CHAR(19) NOT NULL ,	--¼������
			  Shczy VARCHAR(16) NULL ,	--��˲���Ա(����)(CP_Employee.zgdm, zglb = 402)(��Ϊ���/ִ�ж���HIS�Ļ�ʿ,����EMR��ְ����Ҫ��HISһ��)
			  Shrq CHAR(19) NULL ,	--�������
			  Zxczy VARCHAR(16) NULL ,	--ִ�в���Ա(����)(ҽ�������ִ�л�ʿ)(CP_Employee.zgdm, zglb = 402)
			  Zxrq CHAR(19) NULL ,	--ִ������(ҽ�������ִ��ʱ��,����ҩ�޹�)
			  Qxysdm VARCHAR(6) NULL ,	--ȡ��ҽ������(CP_Employee.zgdm, zglb = 400,401)
			  Qxrq CHAR(19) NULL ,	--ȡ������
			  tzysdm VARCHAR(6) NULL ,	--ֹͣҽ������(CP_Employee.zgdm, zglb = 400,401)
			  Tzrq CHAR(19) NULL ,	--ֹͣ����
			  tzshhs VARCHAR(6) NULL ,	--ֹͣ��˻�ʿ(����)(CP_Employee.zgdm, zglb = 402)
			  tzshrq CHAR(19) NULL ,	--ֹͣ�������
			  Ksrq CHAR(19) NULL ,	--(ҽ��)��ʼ����                                   --��ʼʱ��
			  Mq SMALLINT DEFAULT ( 0 )
						  NULL ,	--����(�����쿪ʼִ��)
			  Cdxh NUMERIC(9, 0) NOT NULL ,	--�������(CP_PlaceOfDrug.Cdxh)
			  Ggxh NUMERIC(9, 0) NOT NULL ,	--������(CP_FormatOfDrug.Ggxh)
			  Lcxh NUMERIC(9, 0) NOT NULL ,	--�ٴ����(CP_ClinicOfDrug.Lcxh)
			  Ypdm VARCHAR(12) NOT NULL ,	--ҩƷ����(or�շ�С��Ŀ����or�ٴ���Ŀ����,���������ִ��������Ŀ������ж�)(CP_PlaceOfDrug.Ypdm/CP_ChargingMinItem.Sfxmdm/CP_LCChargingItem.Lcxmdm)
			  Ypmc VARCHAR(64) NULL ,	--ҩƷ(��Ŀ)����(CP_PlaceOfDrug.Name/CP_ChargingMinItem.Name)    ---��Ŀ����
			  Ypgg VARCHAR(32) NULL ,	--ҩƷ���(CP_PlaceOfDrug.Ypgg)
			  Xmlb SMALLINT NOT NULL ,	--��Ŀ���(CP_DataCategory.Mxbh, Lbbh = 24)              --����
			  Zxdw VARCHAR(8) NULL ,	--��С��λ(CP_PlaceOfDrug.Zxdw)
			  Ypjl NUMERIC(14, 3) NULL ,	--ҩƷ����                                          --����
			  Jldw VARCHAR(8) NULL ,	--������λ(��ʾ��)(CP_PlaceOfDrug.Ggdw/CP_PlaceOfDrug.Zydw) --��λ
			  Dwxs NUMERIC(12, 4) NULL ,	--��λϵ��(���ϵ����סԺϵ��,ע����ϵ��Ҫ�����ķ���
			  Dwlb SMALLINT NULL ,	--��λ���(CP_DataCategory.Mxbh, Lbbh = 30)
			  Yfdm VARCHAR(2) NULL ,	--(ҩƷ)�÷�����(CP_DrugUseage.Yfdm)                  --�÷�
			  Pcdm VARCHAR(2) DEFAULT ( '' )
							  NULL ,	--Ƶ�δ���(YY_YZPCK.Pcdm)                        --Ƶ��
			  Zxcs INT DEFAULT ( 1 )
					   NULL ,	--ִ�д���
			  Zxzq INT DEFAULT ( 1 )
					   NULL ,	--ִ������
			  Zxzqdw SMALLINT DEFAULT ( -1 )
							  NULL ,	--ִ�����ڵ�λ(CP_DataCategory.Mxbh, Lbbh = 34)
			  Zdm CHAR(7) DEFAULT ( '' )
						  NULL ,	--�ܴ���
			  Zxsj VARCHAR(64) NULL ,	--(Ƶ�ε�)ִ��ʱ��
			  Zxks VARCHAR(12) NULL ,	--��Ŀ��ִ�п���(�����ֶ�)
			  Ztnr VARCHAR(64) NULL ,	--��������
			  Yzlb SMALLINT NOT NULL ,	--ҽ�����(CP_DataCategory.Mxbh, Lbbh = 31)
			  Yzzt SMALLINT NOT NULL ,	--ҽ��״̬(CP_DataCategory.Mxbh, Lbbh = 32)
			  Tsbj SMALLINT NOT NULL ,	--������(�Զ�����λ��ʾ)
							--0x01(1)	�Ա�ҩ
							--0x02(2)	��Һ
							--0x04(4)	��ӡ
							--0x08(8)	����ͣ����ҽ��(¼������ҽ��ʱ���û�ѡ��ͣ�����ڸ�����ҽ�������м��ϡ�ͣ����ҽ����)
							--0x10(16)	��Ҫҽ������
			  Ybsptg SMALLINT NULL ,	--ҽ������ͨ��(CP_DataCategory.Mxbh Lbbh = 0)
			  Ybspbh VARCHAR(32) NULL ,	--ҽ���������
			  Yztzyy SMALLINT NULL ,	--ҽ��ֹͣ(��ȡ��)ԭ��(CP_DataCategory.Mxbh, Lbbh = 33)	
			  Ssyzxh NUMERIC(12, 0) NULL ,	--����ҽ�����(��ǰҽ������������ҽ��ʱ��Ч,��Ӧ�����е�����ҽ�����)
			  Yznr VARCHAR(255) NULL ,	--ҽ������(��ʾ�ڽ����ϵ�ҽ������)
			  Tbbz SMALLINT NULL ,	--ͬ����־(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(64) NULL ,	--��ע	
			  Bxbz INT NULL ,	--�����׼��1.��0.��
			  Djfl VARCHAR(4) NULL ,	--���ݷ���(���ݻ���) --wxg add, 2009-1-8
			  Ctmxxh NUMERIC(9, 0) ,	--������ϸ���
			  CONSTRAINT PK_CP_LongOrder PRIMARY KEY NONCLUSTERED ( Cqyzxh )
			)
		CREATE CLUSTERED INDEX idx_syxh ON CP_LongOrder(Syxh) WITH FILLFACTOR=90
		CREATE INDEX idx_fzxh ON CP_LongOrder(Fzxh)
	END
go


/* ============================================================ */
/*   Table: CP_ClinicalPath	�ٴ�·��				*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_ClinicalPath' ) 
	BEGIN
		CREATE TABLE CP_ClinicalPath
			(
			  Ljdm VARCHAR(12) NOT NULL ,	--�ٴ�·������
			  Name VARCHAR(64) NOT NULL ,	--(·��)����
			  Py VARCHAR(8) NULL ,	--ƴ��	  
			  Ljms VARCHAR(255) NOT NULL ,   --·������
			  Zgts	 NUMERIC(9,1)				not null, --�ܹ�����
			  Jcfy	money			  not null,--���η���
			  Vesion NUMERIC(5,1)				not null ,--�汾
			  Cjsj CHAR(19) NOT NULL ,	--����ʱ��
			  Syks varchar(12) not null,--��Ӧ����
			  Shsj CHAR(19) NULL ,	--���ʱ��
			  Shys VARCHAR(6) NULL ,--���ҽʦ
			  Yxjl INT NOT NULL , --�Ƿ���Ч(0����Ч1��Ч.2ֹͣ.3���)
			  WorkFlowXML VARCHAR(8000) --������XML
			  IsPathCut	NULL,			--�Ƿ�ü�����(0��1��)��Ĭ��ֵ0��	  
			  CONSTRAINT PK_CP_ClinicalPath PRIMARY KEY ( Ljdm )
			)
	END
GO


/* ============================================================ */
/*   Table: CP_PathDetail	�ٴ�·����ϸ					�޸ģ���ȫΰ  2011-4-21 �޸����ݣ�����ֶ�PrePahtDetailID��NextPahtDetailID��ActivityTypeɾ������							*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_PathDetail' ) 
	BEGIN
		CREATE TABLE CP_PathDetail
			(                    
			  PahtDetailID  varchar(50) NOT NULL ,	--��ϸID
			  PrePahtDetailID	  varchar(50) NOT NULL ,	--ǰ�ýڵ�
			  NextPahtDetailID	  varchar(50) NOT NULL ,	--���ýڵ�	  
			  ActivityType	  varchar(50) NOT NULL ,	--�ڵ�����	  
			  Ljdm VARCHAR(12) NOT NULL ,	--�ٴ�·������(CP_ClinicalPath.Ljdm)
			  Ts INT  NULL ,	--����
			  Ljmc VARCHAR(255) NOT NULL ,--�ڵ�����
			  LJs	varchar(255) null	,--��ʾ
			  Bqms VARCHAR(MAX) NULL ,	--��������
			  Zljh int NULL 	--���Ƽƻ�(CP_ClinicalEmrTemplate.ID)
			  --CONSTRAINT PK_CP_PathDetail PRIMARY KEY ( PahtDetailID )
			)
	END
go



/* ============================================================ */
/*   Table: CP_PathCondition	�ٴ�·����������         				*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_PathCondition' ) 
	BEGIN
		CREATE TABLE CP_PathCondition
			(
			  Tjdm VARCHAR(12) NOT NULL , --��������
			  Ljdm VARCHAR(12) NOT NULL ,--�ٴ�·������(CP_ClinicalPath.Ljdm)
			  Tjmc VARCHAR(255) NOT NULL , --��������
			  TJlb INT NOT NULL , --�������(1����������0 �˳�����)
			  Yxjl INT NOT NULL , --·���Ƿ���Ч
			  CONSTRAINT PK_CP_PathCondition PRIMARY KEY ( Tjdm )
			)
		CREATE INDEX idx_Ljdm ON CP_PathCondition(Ljdm)
		CREATE INDEX idx_TJlb ON CP_PathCondition(TJlb);
        CREATE INDEX idx_Tjdm ON CP_PathCondition(Tjdm);
	END
go


/* ============================================================ */
/*   Table: CP_InPathPatient	�����ٴ�·������         				*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_InPathPatient' ) 
	BEGIN
		CREATE TABLE CP_InPathPatient
			(
			  Id NUMERIC(9, 0) IDENTITY
							   NOT NULL ,	--���
			  Syxh NUMERIC(9, 0) NOT NULL ,	--�������(CP_InPatient.Syxh)
			  Ljdm VARCHAR(12) NOT NULL ,	--�ٴ�·������(CP_ClinicalPath.Ljdm)
			  Cwys VARCHAR(6) NOT NULL ,--��λҽʦ
			  Jrsj CHAR(19) NOT NULL ,	--����·��ʱ��
			  Tcsj CHAR(19) NULL ,--�˳�ʱ��
			  Wcsj CHAR(19) NULL ,--���ʱ��
			  Ljts int not null ,--��ǰ��������
			  Ljzt INT NOT NULL ,--·��״̬(1����,2.�˳�,3���)
			  CONSTRAINT PK_CP_InPathPatient PRIMARY KEY ( Id )
			)
	END
go

/* ============================================================ */
/*   Table: CP_InPathPatientCondition	��������������¼        */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_InPathPatientCondition' ) 
	BEGIN
		CREATE TABLE CP_InPathPatientCondition
			(
			  Id NUMERIC(9, 0) IDENTITY
							   NOT NULL ,	--���
			  Ljxh numeric(9,0) NOT NULL ,  --·�����(CP_InPathPatient.Id)
			  Syxh NUMERIC(9, 0) NOT NULL ,	--�������(CP_InPatient.Syxh)
			  Tjdm VARCHAR(255)  NULL , --��������(�ã��ֿ�)
			  Memo VARCHAR(MAX) NULL ,--��������
			  CONSTRAINT PK_CP_InPathPatientCondition PRIMARY KEY ( Id )
			)
			create index idx_CP_InPathPatientCondition_Ljxh on  CP_InPathPatientCondition(Ljxh)
	END
go
	


/* ============================================================ */
/*   Table: CP_PathExecuteInfo	�ٴ�·��ִ�м�¼��         		*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_PathExecuteInfo' ) 
	BEGIN
		CREATE TABLE CP_PathExecuteInfo
			(
			  Id numeric(9,0) IDENTITY
					 NOT NULL ,	--���
			  Ljxh numeric(9,0) NOT NULL ,  --·�����(CP_InPathPatient.Id)
			  Ljcz INT NOT NULL ,	--·������(1100����1104�˳�)
			  Czyy VARCHAR(MAX)  NULL ,--�˳�ԭ��
			  Czys VARCHAR(6) NOT NULL ,--��λҽʦ
			  Czsj CHAR(19) NULL ,--�˳�ʱ��
			  CONSTRAINT PK_CP_PathExecuteInfo PRIMARY KEY ( Id )
			)
	END
go



/* ============================================================ */
/*   Table: CP_PathVariation	�ٴ�·�������								*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_PathVariation' ) 
	BEGIN
		CREATE TABLE CP_PathVariation
			(
			  Bydm VARCHAR(12) NOT NULL ,--�������
			  Bymc VARCHAR(64) NOT NULL ,--��������
			  Byms VARCHAR(255) NOT NULL ,--��������
			  Yxjl INT NOT NULL ,--��Ч��¼
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  CONSTRAINT PK_CP_PathVariation PRIMARY KEY ( Bydm )
			)
	END
go


/* ============================================================ */
/*   Table: CP_VariationToPath	�ٴ�·��������·��������Ӧ    */
/* ============================================================ */
if not exists ( select  1
                from    sysobjects
                where   Name = 'CP_VariationToPath' ) 
    begin
        create table CP_VariationToPath
            (
              Id numeric(12, 0) identity
                                not null ,
              Ljdm varchar(12) not null ,--·������
              ActivityId varchar(50) not null ,--·�����ID
              Bydm varchar(12) not null ,--�������
              Yxjl int not null
                       default 1 ,--��Ч��¼
              Create_Time varchar(19)
                not null
                default convert(varchar(19), getdate(), 120) ,	--����ʱ��
              Create_User varchar(10) ,
              Cancel_Time varchar(19) ,
              Cancel_User varchar(10) ,
              constraint PK_CP_VariationToPath primary key ( Id )
            )
    end
go


/* ============================================================ */
/*   Table: CP_VariantRecords	�ٴ�·�������¼��				*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_VariantRecords' ) 
	BEGIN
		CREATE TABLE CP_VariantRecords
			(
			  Id numeric(12,0) IDENTITY
					 NOT NULL ,	--���
			  Ljxh NUMERIC(9, 0) NOT NULL ,	--·�����(CP_InPatient.Syxh)
			  Syxh NUMERIC(9, 0) NOT NULL,--��ҳ���
			  Ljdm VARCHAR(12) NOT NULL ,	--�ٴ�·������(CP_ClinicalPath.Ljdm)
			  
			  Mxdm VARCHAR(50) NOT NULL ,	--·����ϸ�ӽڵ�(PahtDetailID���ӽڵ�)
			  Ypdm VARCHAR(12) NOT NULL ,	--ҩƷ����(or�շ�С��Ŀ����or�ٴ���Ŀ����,���������ִ��������Ŀ������ж�)(CP_PlaceOfDrug.Ypdm/CP_ChargingMinItem.Sfxmdm/CP_LCChargingItem.Lcxmdm)
			  Bylb VARCHAR(12) NOT NULL ,	--�������(1200ҽ��1201����1203���Ƽƻ�,1204�˳�)
			  Bylx VARCHAR(12) NOT NULL ,   --�������ͣ�1300����ѡĩִ�У�1301��������1302����,1303,�˳���
			  Bynr VARCHAR(MAX),	--��������
			  Bydm VARCHAR(12) NOT NULL ,--�������
			  Byyy VARCHAR(MAX),	--����ԭ��
			  Bysj CHAR(19) NOT NULL ,--����ʱ��
			  PahtDetailID VARCHAR(50) NOT NULL ,	  --·����ϸ(CP_PathDetail.PahtDetailID)	  
			  CONSTRAINT PK_CP_VariantRecords PRIMARY KEY ( Id )
			)
			create index idx_CP_VariantRecords_Ljxh on  CP_VariantRecords(Ljxh)
	END
go


/* ============================================================ */
/*   Table: CP_ReportType	�ٴ�·��ҽ����Ϣ�����							*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_ReportType' ) 
	BEGIN
		CREATE TABLE CP_ReportType
			(
			  Lbbh INT NOT NULL ,	--(����)�����
			  Name VARCHAR(80) NOT NULL ,	--(����)����
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���
			  Memo VARCHAR(64) NULL ,    	--��ע
			  CONSTRAINT PK_CP_ReportType PRIMARY KEY ( Lbbh )
			)
	END
go

/* ============================================================ */
/*   Table: CP_ReportItem	�ٴ�·��ҽ����Ϣ��Ŀ��							*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_ReportItem' ) 
	BEGIN
		CREATE TABLE CP_ReportItem
			(
			  Mxbh INT NOT NULL ,	--��ϸ���(��Ϊ���ݷ������,�����ʽΪ'������'+'2λ����ˮ��', ��: 101, 102, 201, 205, 1201)
			  Name VARCHAR(80) NOT NULL ,	--��������
			  Lbbh SMALLINT NOT NULL ,	--�����(CP_ReportType.Lbbh)
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���
			  Memo VARCHAR(16) NULL ,    	--��ע
			  CONSTRAINT PK_CP_ReportItem PRIMARY KEY ( Mxbh )
			)
	END
go

/* ============================================================ */
/*   Table: CP_PatientReport	�ٴ�·��ҽ����Ϣ��							*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_PatientReport' ) 
	BEGIN
		CREATE TABLE CP_PatientReport
			(
			  Id INT IDENTITY
					 NOT NULL ,--
			  Syxh NUMERIC(9, 0) NOT NULL ,--�������(CP_InPatient.Syxh)
			  Name VARCHAR(12) NOT NULL ,--��������
			  PatNoOfHis NUMERIC(9, 0) NOT NULL ,--HIS NO
			  HospitalNo VARCHAR(12) NULL ,--ҽԺ����(CP_Hospital.Yydm)
			  ReportCatalog INT NOT NULL ,--�������(CP_ReportType.Lbbh)
			  ReportType INT NOT NULL ,--�������ʹ���(CP_ReportItem.Mxbh)
			  ReportName VARCHAR(80) NOT NULL ,--������������
			  ReportNo VARCHAR(80) NULL ,--������
			  SubmitDate DATETIME NOT NULL ,--ִ������
			  ReleaseDate DATETIME NULL ,--
			  HadRead VARCHAR(1) NULL ,--
			  Result VARCHAR(80) NULL ,--���
			  CONSTRAINT PK_CP_PatientReport PRIMARY KEY ( Id )
			)
	END
go

/* ============================================================ */
/*   Table: CP_AttendanceType	�ٴ�·��������Ϣ�����							*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_AttendanceType' ) 
	BEGIN
		CREATE TABLE CP_AttendanceType
			(
			  Lbbh INT NOT NULL ,	--(����)�����
			  Name VARCHAR(80) NOT NULL ,	--(����)����
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���
			  Memo VARCHAR(64) NULL ,    	--��ע
			  CONSTRAINT PK_CP_AttendanceTypee PRIMARY KEY ( Lbbh )
			)
	END
go

/* ============================================================ */
/*   Table: CP_AttendanceItem	�ٴ�·��������Ϣ��Ŀ��							*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_AttendanceItem' ) 
	BEGIN
		CREATE TABLE CP_AttendanceItem
			(
			  Mxbh INT NOT NULL ,	--��ϸ���(��Ϊ���ݷ������,�����ʽΪ'������'+'2λ����ˮ��', ��: 101, 102, 201, 205, 1201)
			  Name VARCHAR(80) NOT NULL ,	--��������
			  Lbbh SMALLINT NOT NULL ,	--�����(CP_CPathCareType.Lbbh)
			  Py VARCHAR(8) NULL ,    	--ƴ��
			  Wb VARCHAR(8) NULL ,    	--���
			  Memo VARCHAR(16) NULL ,    	--��ע
			  CONSTRAINT PK_CP_AttendanceItem PRIMARY KEY ( Mxbh )
			)
	END
go

/* ============================================================ */
/*   Table: CP_AttendanceInfo	�ٴ�·��������Ϣ��							*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_AttendanceInfo' ) 
	BEGIN
		CREATE TABLE CP_AttendanceInfo
			(
			  Id INT IDENTITY
					 NOT NULL ,--
			  CareCatalog INT NOT NULL ,--�������(CP_CPathCareType.Lbbh)
			  CareType INT NOT NULL ,--�������ʹ���(CP_CPathCareItem.Mxbh)
			  CareName VARCHAR(80) NOT NULL ,--������������
			  CareNo VARCHAR(12) NULL ,--������
			  Syxh NUMERIC(9, 0) NOT NULL ,--�������(CP_InPatient.Syxh)
			  PatNoOfHis NUMERIC(9, 0) NOT NULL ,--HIS NO
			  HospitalNo VARCHAR(12) NULL ,--ҽԺ����(CP_Hospital.Yydm)
			  NAME VARCHAR(12) NOT NULL ,--��������
			  SubmitDate DATETIME NOT NULL ,--ִ������
			  ReleaseDate DATETIME NULL ,--
			  Result VARCHAR(80) NULL ,--��������
			  CONSTRAINT PK_CP_AttendanceInfo PRIMARY KEY ( Id )
			)
	END
go

/* ============================================================ */
/*   Table: CP_ClinicalDiagnosis	�ٴ�·������			*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_ClinicalDiagnosis' ) 
	BEGIN
		CREATE TABLE CP_ClinicalDiagnosis
			(
			  Ljdm VARCHAR(12) NOT NULL ,	--�ٴ�·������
			  Bzdm VARCHAR(12) NOT NULL ,   --(��ϴ���CP_Diagnosis.zddm)
		  Bzmc VARCHAR(64) NOT NULL ,   --(�������CP_Diagnosis.Name)
			  CONSTRAINT PK_CP_ClinicalDiagnosis PRIMARY KEY ( Ljdm,Bzdm)
			)
	END
GO

/* ============================================================ */
/*   Table: CP_PhysicalSignInfo  (����)����������ϸ��                     */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_PhysicalSignInfo' ) 
   BEGIN
		create table CP_PhysicalSignInfo 
		(
			Syxh      numeric(9, 0)   NOT NULL, --��ҳ���
			Tzxh      numeric(12,0)		  not null, --�������
			Zlrq	  char(8)		  not null,	--��������
			Lrrq      char(16)         not null, --¼������
			Clsj      char(16)         not null, --����ʱ�� 
			Tw		  numeric(5,2)	  null,		--��������
			Mb		  integer		  null,		--��������
			Hx		  integer		  null,		--��������
			Xy		  varchar(16)		  null,		--Ѫѹ����
			Xl		  varchar(16)		  null,		--����
			Memo	  varchar(24)		  null,		--�������� 
			Memo2 	  varchar(24) 		  null,		--˵��2(������ʾ�°벿�ֵĲ�����Ϣ ��:����)  
			Wljw 	numeric(5,2) 		null,		--������ 
			Qbxl 	varchar(16) 		null,		--������
			Rghx 	varchar(16) 		null,		--�˹�����
			Kb 		varchar(16) 		null,		--�ڱ�
			Yb 		varchar(16) 		null,		--Ҹ��
			Gw 		varchar(16) 		null,		--����
			Cjsj	varchar(24) 		null,		--�ɼ�ʱ�䣬�±�ר��
			constraint PK_CP_PhysicalSignInfo primary key(Tzxh, Clsj)
		)
 END
GO

/* ============================================================ */
/*   Table: �ٴ�·������ģ��	CP_ClinicalEmrTemplate    */
/*   						                                */
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_ClinicalEmrTemplate')
begin
	
	create table CP_ClinicalEmrTemplate
	(
		ID			numeric(9, 0)	 identity not null,	--��¼���
		Name		varchar(64)		 not null,	--ģ������
		Valid		int				not null,	--��Ч��¼
		Content		Varchar(max)	not null,	--��������
		SortID		varchar(12)			 null,	--ģ��������(����)
		Memo		varchar(255)		null,		--��ע
		constraint PK_CP_ClinicalEmrTemplate primary key(ID)
	)
end
go

/* ============================================================ */
/*   Table: CP_InPatientPathEnForce	�ٴ�·��ִ�м�¼			*/
/* ============================================================ */
if not exists ( select  1
                from    sysobjects
                where   Name = 'CP_InPatientPathEnForce' ) 
    begin
        create table CP_InPatientPathEnForce
            (
              Syxh numeric(9, 0) not null ,	--��ҳ���(CP_InPatient.Syxh)
              Ljxh numeric(9, 0) not null ,  --·�����(CP_InPathPatient.Id)
              Ljdm varchar(12) not null ,	--�ٴ�·������
              EnFroceXml varchar(8000) not null ,--·��ִ�м�¼
              Content1 varchar(10) null ,
              Content2 varchar(10) null ,
              Content3 varchar(10) null ,
              constraint PK_CP_InPatientPathEnForce primary key ( Syxh )
            )
        create index idx_CP_InPatientPathEnForce_Ljxh on  CP_InPatientPathEnForce(Ljxh)
    end
go

/* ============================================================ */
/*   Table:CP_AppConfig	Ӧ������                       				*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   name = 'CP_AppConfig' ) 
	BEGIN
		CREATE TABLE CP_AppConfig
			(
			  Configkey VARCHAR(32) NOT NULL ,--���ü�,Ψһ(��Ҫʹ��','�ַ�)
			  Name VARCHAR(64) NOT NULL ,	--���õ�����
			  Value VARCHAR(MAX) NOT NULL ,	--����ֵ,
			  Descript VARCHAR(255) NOT NULL ,	--��������
			  ParamType INT NOT NULL ,	--��������(0 variant, 1 string, 2 int, 3 double, 4 bool, 5 xml, 6 color, 7 configset ���ü���)
			  Cfgkeyset VARCHAR(1024) NULL ,	--�������ü�ֵ����(��type=7ʱ������,���31��,�������ÿ�������һ��������
			  Design VARCHAR(255) NULL ,	--��̬������(����������ģ���ڲ�)
			  ClientFlag SMALLINT NOT NULL ,	--�������ü���(0 �޷������û��� 1���������û���)
			  Hide SMALLINT NOT NULL ,	--���ر�־,�޷�ʹ�ó�������(0 ��Ч, 1��Ч=����)
			  Valid SMALLINT NOT NULL ,	--0 ��Ч, 1 ��Ч
			  CONSTRAINT PK_CP_AppConfig PRIMARY KEY ( Configkey )
			)
	END
go

/* ============================================================ */
/*   Table: CP_LogException     �쳣��¼                        */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   name = 'CP_LogException' ) 
	BEGIN
		CREATE TABLE CP_LogException
			(
			  ID INT IDENTITY ,--ģ���¼��ID
			  Messages VARCHAR(8000) NOT NULL,--����
			  Module_Name VARCHAR(255) ,--ģ������
			  HostName VARCHAR(255) ,--HostName
			  MACADDR VARCHAR(255)  ,--MAC��ַ
			  Client_ip VARCHAR(255)  ,--����Ip��ַ
			  Create_time DATETIME NOT NULL
								   DEFAULT GETDATE() ,--����ʱ��
			  Create_user VARCHAR(6)  --��¼��ID
			)
	END
go

/* ============================================================ */
/*   Table: CP_ClinicalPath_Log	�ٴ�·���޸ļ�¼				*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_ClinicalPath_Log' ) 
	BEGIN
		CREATE TABLE CP_ClinicalPath_Log
			(
			  ID NUMERIC(9, 0) IDENTITY ,--
			  Ljdm VARCHAR(12) NOT NULL ,	--�ٴ�·������
			  Modify_User VARCHAR(6) NOT NULL ,--CP_Employee.Zgdm
			  Modify_Time VARCHAR(19)
				DEFAULT CONVERT(VARCHAR(19), GETDATE(), 120)
				NOT NULL ,
			  CONSTRAINT PK_CP_ClinicalPath_Log PRIMARY KEY ( ID )
			)
	END
GO


-------------------------------------------------------------------------------Ȩ�޹���
/* ============================================================ */
/*   Table: PE_Role    ��ɫ��                     */
/*                     */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'PE_Role' ) 
	BEGIN
		CREATE TABLE PE_Role
			(
				RoleCode varchar(10) NOT NULL,--��ɫ����
				RoleName varchar(100) NOT NULL,--��ɫ����
			  CONSTRAINT PK_PE_Role PRIMARY KEY ( [RoleCode] ASC)
			)
	END

/* ============================================================ */
/*   Table: PE_RoleFun    ��ɫ���ܱ�                     */
/*                  */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'PE_RoleFun' ) 
	BEGIN
		CREATE TABLE PE_RoleFun
			(
				RoleCode varchar(10) NOT NULL,--��ɫ����
				FunCode varchar(100) NOT NULL,--���ܴ���
			  CONSTRAINT PK_PE_RoleFun PRIMARY KEY ( RoleCode,FunCode)
			)
	END
/* ============================================================ */
/*   Table: PE_Fun    ���ܱ�										 */
/*                    */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'PE_Fun' ) 
	BEGIN
		CREATE TABLE PE_Fun
			(
				FunCode varchar(10) NOT NULL,--���ܴ���
				FunName varchar(100) NOT NULL,--��������
				FunCodeFather varchar(10)  NULL,--�������ܴ���
				FunURL varchar(100)  NULL,--·����ַ
			  CONSTRAINT PK_PE_Fun PRIMARY KEY ( FunCode )
			)
	END
/* ============================================================ */
/*   Table: PE_UserRole    �û���ɫ��                     */
/*                      */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'PE_UserRole' ) 
	BEGIN
		CREATE TABLE PE_UserRole
			(
				UserID varchar(6) NOT NULL,--�û�ID(CP_Employee.zgdm)
				RoleCode varchar(100) NOT NULL,--��ɫ����(PE_Role.RoleCode)
			  CONSTRAINT PK_PE_UserRole PRIMARY KEY ( UserID ,
				RoleCode )
			)
	END


-------------------------------------------------------------------------------
/* ============================================================ */
/*   Table: CP_QCProblem     ����Ǽ�					*/
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_QCProblem')--����Ǽ�
begin
	CREATE TABLE CP_QCProblem
	(
		Wtxh		int identity not null,	--�������
		Syxh		int			 not null, --��ҳ���
		Wtzt		int			 not null default 0,--0-�Ǽ�,1-��-2����-4�ر�����
		Ljdm		varchar(12)  not null,--·������
		Wtnr		varchar(600) null, --��������
		Dfnr		varchar(600) null,--�ظ�����
		Shnr		varchar(600) null,--�������
		Zrys	    varchar(6)   null,	--ҽ������(סԺҽ������)
		Djrq		datetime DEFAULT getdate(),--�Ǽ�����
		Djry		varchar(6)	 not null,--�Ǽ���Ա
		Dfrq	    datetime	 null,--�ظ�����
		Dfys		varchar(6)   null,--�ظ�ҽ��
		Shrq		datetime	 null,--�������
		Shry		varchar(6)   null,--�����Ա
		Zfrq		datetime null,--��������
		Zfry		varchar(6)  NULL--������Ա
		constraint PK_CP_QCProblem primary key (Wtxh)	
	)
end
go

/* ============================================================ */
/*   Table: CP_AdviceSuitCategory	ҽ���ײ����                              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
                FROM    sysobjects
                WHERE   Name = 'CP_AdviceSuitCategory' ) 
    BEGIN
        CREATE TABLE CP_AdviceSuitCategory
            (
              CategoryId		VARCHAR(50) 	NOT NULL ,	--�ײ�������
              NAME			    VARCHAR(32)		NOT NULL ,	--(ҽ���ײ����)����
              ParentID			VARCHAR(50)		NULL ,--���ڵ�
              Py			    VARCHAR(8)		NULL ,    	--ƴ��
              Wb				VARCHAR(8)		NULL ,    	--���
			  Zgdm				VARCHAR(6)		NULL ,	--ְ������(¼����Ա����)
              AddTime			VARCHAR(20)		NULL, --¼��ʱ��
              Yxjl				SMALLINT		NULL,--��Ч��¼
              Memo				VARCHAR(50)		NULL ,   --��ע
              constraint PK_CP_AdviceSuitCategory primary key (CategoryId)	
            )
    END
go

/* ============================================================ */
/*   Table: CP_AdviceSuit	ҽ���ײ�                              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
                FROM    sysobjects
                WHERE   Name = 'CP_AdviceSuit' ) 
    BEGIN
        CREATE TABLE CP_AdviceSuit
            (
              Ctyzxh NUMERIC(9, 0) IDENTITY
                                   NOT NULL ,	--�ײ����
			  --PahtDetailID varchar(50) NOT NULL, --���ýڵ�ID
              Name VARCHAR(32) NOT NULL ,	--(ҽ���ײ�)����
              CategoryId VARCHAR(50) NOT NULL, --�ײ�������(CP_AdviceSuitType.Typexh)
              Py VARCHAR(8) NULL ,    	--ƴ��
              Wb VARCHAR(8) NULL ,    	--���
			  Zgdm VARCHAR(6)  NULL ,	--ְ������(¼����Ա����)
              Ksdm VARCHAR(12) NULL ,	--(����)���Ҵ���(YY_KSDMK.Ksdm)
              Bqdm VARCHAR(12) NULL ,	--(����)��������(YY_BQDMK.Bqdm)
              Ysdm VARCHAR(6) NULL ,	--(����)ҽ������(CP_Employee.zgdm)
              Syfw SMALLINT NULL ,	--ʹ�÷�Χ(CP_DataCategory.Mxbh, Lbbh = 29)
              Memo VARCHAR(16) NULL ,    	--��ע
			  OrderNum INT NOT NULL ,--�����ֶ�
			  UserReason1 varchar(100),--ʹ��ԭ��һ
              UserReason2 varchar(100),--ʹ��ԭ���
              UserReason3 varchar(100),--ʹ��ԭ����
              CONSTRAINT PK_CP_AdviceSuit PRIMARY KEY ( Ctyzxh )
            )
        CREATE INDEX idx_py ON CP_AdviceSuit(Py)
        CREATE INDEX idx_wb ON CP_AdviceSuit(Wb)
    END
go

/* ============================================================ */
/*   Table: CP_AdviceSuitDetail	ҽ���ײ���ϸ��                          */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
                FROM    sysobjects
                WHERE   Name = 'CP_AdviceSuitDetail' ) 
    BEGIN
        CREATE TABLE CP_AdviceSuitDetail
            (
              Ctmxxh NUMERIC(9, 0) IDENTITY
                                   NOT NULL ,	--ҽ���ײ���ϸ���
              Ctyzxh NUMERIC(9, 0) NOT NULL ,	--(����)ҽ���ײ����(CP_AdviceSuit.Ctyzxh)
              Yzbz SMALLINT NULL ,	--ҽ����־(CP_DataCategory.Mxbh, Lbbh = 27)
			  Fzxh NUMERIC(12, 0)  null,	--�������(ÿ��ĵ�һ��ҽ�������)
              Fzbz SMALLINT NULL ,	--�����־(CP_DataCategory.Mxbh, Lbbh = 35)
              Cdxh NUMERIC(9, 0) NOT NULL ,	--�������(CP_PlaceOfDrug.Cdxh)
              Ggxh NUMERIC(9, 0) NOT NULL ,	--������(CP_FormatOfDrug.Ggxh)
              Lcxh NUMERIC(9, 0) NOT NULL ,	--�ٴ����(CP_ClinicOfDrug.Lcxh)
              Ypdm VARCHAR(12) NOT NULL ,	--ҩƷ����(or�շ�С��Ŀ����or�ٴ���Ŀ����,���������ִ��������Ŀ������ж�)(CP_PlaceOfDrug.Ypdm/CP_ChargingMinItem.Sfxmdm/CP_LCChargingItem.Lcxmdm)
              Ypmc VARCHAR(64) NULL ,	--ҩƷ(��Ŀ)����(CP_PlaceOfDrug.Name/CP_ChargingMinItem.Name)
              Xmlb SMALLINT NOT NULL ,	--��Ŀ���(CP_DataCategory.Mxbh, Lbbh = 24)
              Zxdw VARCHAR(8) NULL ,	--��С��λ(CP_PlaceOfDrug.Zxdw)
              Ypjl NUMERIC(14, 3) NULL ,	--ҩƷ����
              Jldw VARCHAR(8) NULL ,	--������λ(��ʾ��)(CP_PlaceOfDrug.Ggdw/CP_PlaceOfDrug.Zydw)
              Dwxs NUMERIC(12, 4) NULL ,	--��λϵ��(���ϵ����סԺϵ��,ע����ϵ��Ҫ�����ķ���
              Dwlb SMALLINT NULL ,	--��λ���(CP_DataCategory.Mxbh, Lbbh = 30)
              Yfdm VARCHAR(2) NULL ,	--(ҩƷ)�÷�����(CP_DrugUseage.Yfdm)
              Pcdm VARCHAR(2) DEFAULT ( '' )
                              NULL ,	--Ƶ�δ���(YY_YZPCK.Pcdm)
              Zxcs INT DEFAULT ( 1 )
                       NULL ,	--ִ�д���
              Zxzq INT DEFAULT ( 1 )
                       NULL ,	--ִ������
              Zxzqdw SMALLINT DEFAULT ( -1 )
                              NULL ,	--ִ�����ڵ�λ(CP_DataCategory.Mxbh, Lbbh = 34)
              Zdm CHAR(7) DEFAULT ( '' )
                          NULL ,	--�ܴ���
              Zxsj VARCHAR(64) NULL ,	--(Ƶ�ε�)ִ��ʱ��
              Zxts INT NULL ,	--ִ������(Ϊ��Ժ��ҩ����)
              Ypzsl NUMERIC(14, 3) NULL ,	--ҩƷ������(Ϊ��Ժ��ҩ����,ʹ�ü�����λ)
              Ztnr VARCHAR(64) NULL ,	--��������
              Yzlb SMALLINT NOT NULL ,	--ҽ�����(CP_DataCategory.Mxbh, Lbbh = 31)
			  Yznr VARCHAR(255) NULL ,	--ҽ������(��ʾ�ڽ����ϵ�ҽ������)
			 OrderNum INT NOT NULL ,--�����ֶ�
			 Mzdm VARCHAR(12) NOT NULL ,	--�������CP_Anesthesia.Mzdm
              CONSTRAINT PK_CP_AdviceSuitDetail PRIMARY KEY ( Ctmxxh )
            )
    END
go




/* ============================================================ */
/*   Table: CP_Areas	��������                               */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Areas' ) 
	BEGIN
		create table CP_Areas
		(
			Dqdm		varchar(10)		not null,	--��������
			Name		varchar(64)		not null,	--��������
			Py			varchar(8)		null    ,	--ƴ��
			Wb			varchar(8)		null    ,	--���
			Dqlb		smallint		not null,	--�������(YY_SJLBMXK.mxbh lbbh = 10)
			Ssdqdm		varchar(10)		null    ,	--�����ĵ�������(YY_DQDMK.dqdm)
			Ssdqmc		varchar(32)		null    ,	--�����ĵ�������
			Memo		varchar(32)	null    ,	--��ע
			constraint PK_CP_Areas primary key (Dqdm)
		)
	END

	create index idx_py on CP_Areas(Py)
	go
	create index idx_wb on CP_Areas(Wb)
	go



/* ============================================================ */
/*   Table: CP_Dictionary     �ֵ�����                         */
/*          ��������ֵ��������ƺ�˵��,�û�����ά��           */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Dictionary' ) 
Begin
	create table CP_Dictionary
	(
		Lbdm		varchar(2)		not null,	--(�ֵ�)������
		Name		varchar(32)		not null,	--(����)����
		Py			varchar(8)		null    ,	--ƴ��
		Wb			varchar(8)		null    ,	--���
		Memo		varchar(32)	null    ,	--��ע
		constraint PK_CP_Dictionary primary key(Lbdm)
	)
end
go

/* ============================================================ */
/*   Table: CP_Dictionary_detail       �ֵ������ϸ��            	*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Dictionary_detail' ) 
Begin
	create table CP_Dictionary_detail  
	(
		Mxdm		varchar(4)		not null,	--��ϸ����
		Name		varchar(32)		not null,	--����
		Py			varchar(8)		null	,	--ƴ��
		Wb			varchar(8)		null	,	--���
		Lbdm		varchar(2)		not null,	--(�ֵ�)������(CP_Dictionary.lbdm)
		Yxjl		smallint		null	,	--��Ч��¼(CP_DataCategoryDetail.mxbh lbbh = 0)
		Memo		varchar(32)	null	,	--��ע
		constraint PK_CP_Dictionary_detail primary key(Lbdm, Mxdm)
	)
end

go

/* ============================================================ */
/*   Table: CP_VitalSignsRecord	   ����������¼��               */
/* ============================================================ */
if not exists ( select  1
                from    sysobjects
                where   name = 'CP_VitalSignsRecord' ) 
    begin
        create table CP_VitalSignsRecord
            (
              Jlxh numeric(9, 0) identity ,                   --��¼��ţ��Զ����ɣ�
              Zyhm varchar(24) not null ,	                 --סԺ����(������)
              Ljxh numeric(9, 0) not null ,	--·�����(CP_InPatient.Syxh)
              Ljdm varchar(12) not null ,	--�ٴ�·�����루CP_ClinicalPath.Ljdm)
              ActivityId varchar(50) not null ,--·�����ID
              ActivityChildId varchar(50) not null ,--·���ӽڵ�ID(����ִ�н��KEYֵ)             
              Clrq varchar(10) not null ,                    --���������ڣ���ʽ2010-01-01��
              Clsj varchar(5) check ( len(Clsj) = 5 )
                              not null ,  --����ʱ�䣨��ʽ��01:02��
              Sjd char(2) not null ,                        --����ʱ���
              Hzztdm int not null ,                            --����״̬���룬(CP_DataCategoryDetail.lbbh=59)
              Hzzt varchar(50) ,                            --����״̬�����֣�
              Hztw varchar(20) ,--��������
              Clfsdm int ,  --���²�����ʽ����(CP_DataCategoryDetail.lbbh=48)4801-Һ�¡�4801-���¡�4802-����
              Clfs varchar(50) ,  --���²�����ʽ����
              Fzcsdm int default 0
                         not null ,  --���²���������ʩ���룬(CP_DataCategoryDetail.lbbh=49)  4900-��
              Fzcs varchar(200) ,  --���²���������ʩ
              Hzmb varchar(20) ,--���� 
              Hzxl varchar(20) ,--����	    
              Qbq bit default 0
                      not null ,--���� 0-�ޣ�1-ʹ��
              Hzhx varchar(20) ,--���ߺ���
              Hxq bit default 0
                      not null ,--������ 0-�ޣ�1-ʹ��
              Hzxy varchar(20) ,--����Ѫѹ
              Djrq varchar(19) default convert(varchar(19), getdate(), 121) ,--�Ǽ�����(��ʽ��2010-02-01 01:02:03) 
              Djysdm varchar(6) , --�Ǽ�ҽ��ID
              Djys varchar(30) ,--�Ǽ�ҽ��
              Zfrq varchar(19) ,--��������(��ʽ��2010-02-01 01:02:03) 
              Zfrydm varchar(6) , --������ԱID
              Zfry varchar(30) --������Ա							
						
            )
    end
go

/* ============================================================ */
/*   Table: CP_PatientInOutRecord ����������/�ų�����            */
/* ============================================================ */
if not exists ( select  1
                from    sysobjects
                where   name = 'CP_PatientInOutRecord' ) 
    begin
        create table CP_PatientInOutRecord
            (
              Jlxh numeric(9, 0) identity ,--��¼��ţ��Զ����ɣ�
              Zyhm varchar(24) not null ,	--סԺ����(������)
              Ljxh numeric(9, 0) not null ,	--·�����(CP_InPatient.Syxh)
              Ljdm varchar(12) not null ,	--�ٴ�·�����루CP_ClinicalPath.Ljdm)
              ActivityId varchar(50) not null ,--·�����ID
              ActivityChildId varchar(50) not null ,--·���ӽڵ�ID(����ִ�н��KEYֵ)  
              Jllx bit default 0
                       not null ,--��¼���ͣ�0-������1-����
              Clrq varchar(10) not null , --�������ڣ���ʽ2010-01-01��
              Clsj varchar(5) check ( len(Clsj) = 5 )
                              not null ,--����ʱ�䣨��ʽ��01:02��
							-----��������-----
              Ysl varchar(20) ,--��ʳ��
              Hsl varchar(20) ,--��ˮ��
              Syl varchar(20) ,--��Һ��
              Zsl varchar(20) ,--ע����
              Sxl varchar(20) ,--��Ѫ��
              Qtrllxdm1 int ,--��������1���ʹ��룬(CP_DataCategoryDetail.lbbh=50)
              Qtrllx1 varchar(50) ,--��������1��������,��ʽ:��������(��λ)
              Qtrl1 varchar(20) ,--��������1ֵ
              Qtrllxdm2 int ,--��������2���ʹ��� (CP_DataCategoryDetail.lbbh=50)
              Qtrllx2 varchar(50) ,--��������2��������,��ʽ:��������(��λ)
              Qtrl2 varchar(20) ,--��������2ֵ
							-----���˳���-----
              Hzxb varchar(20) ,--����С��
              Xbxzdm varchar(20) ,--С����״���룬(CP_DataCategoryDetail.lbbh=51)
              Xbxz varchar(50) ,--С����״����ʽ:��ɫ_��״���磺��ɫ_��״
              Xbcsdm int ,--��С���ʩ���� ��(CP_DataCategoryDetail.lbbh=52)��5200-��
              Xbcs varchar(100) ,--��С���ʩ�� 
							--Hzdb		float,--�����
              Dbcs varchar(50) ,--����������ʽ��1*(3/2E ),'*'��ʾ���ʧ�� 
              Dbxzdm int ,--�����״���룬(CP_DataCategoryDetail.lbbh=53)
              Dbxz varchar(50) ,--�����״,��ʽ:��ɫ_��״
              Pbcsdm int ,--�Ŵ���ʩ���룬(CP_DataCategoryDetail.lbbh=54)��5500-��
              Pbcs varchar(100) ,--�Ŵ���ʩ���磺�೦���˹����ŵ� 
              Hztl varchar(20) ,--����̵��
              Txzdm int ,--̵����״���룬(CP_DataCategoryDetail.lbbh=55)
              Txz varchar(50) ,--̵����״���ƣ���ʽ����ɫ_��״
              Yll varchar(20) ,--������
              Ylsm varchar(50) ,--����˵��
              Qtcllxdm1 int ,--��������1���ʹ��룬(CP_DataCategoryDetail.lbbh=56)
              Qtcllx1 varchar(50) ,--��������1��������,��ʽ:��������(��λ)
              Qtcl1 varchar(20) ,--��������1ֵ
              Qtcllxdm2 int ,--��������2���ʹ��룬(CP_DataCategoryDetail.lbbh=56)
              Qtcllx2 varchar(50) ,--��������2��������,��ʽ:��������(��λ)
              Qtcl2 varchar(20) ,--��������2ֵ
              Djrq varchar(19) default convert(varchar(19), getdate(), 121) ,--�Ǽ�����(��ʽ��2010-02-01 01:02:03) 
              Djysdm varchar(6) , --�Ǽ�ҽ��ID
              Djys varchar(30) ,--�Ǽ�ҽ��
              Zfrq varchar(19) ,--��������(��ʽ��2010-02-01 01:02:03) 
              Zfrydm varchar(6) , --������ԱID
              Zfry varchar(30) --������Ա	
						
            )
    end
go


/* ============================================================ */
/*   Table: CP_VitalSignSpecialRecord	  ���˻��������¼��    */
/* ============================================================ */
if not exists ( select  1
                from    sysobjects
                where   name = 'CP_VitalSignSpecialRecord' ) 
    begin
        create table CP_VitalSignSpecialRecord
            (
              Jlxh numeric(9, 0) identity ,--��¼��ţ��Զ����ɣ�
              Zyhm varchar(24) not null ,	--סԺ����(������)
              Ljxh numeric(9, 0) not null ,	--·�����(CP_InPatient.Syxh)
              Ljdm varchar(12) not null ,	--�ٴ�·�����루CP_ClinicalPath.Ljdm)
              ActivityId varchar(50) not null ,--·�����ID
              ActivityChildId varchar(50) not null ,--·���ӽڵ�ID(����ִ�н��KEYֵ)  
              Clrq varchar(10) not null , --���������ڣ���ʽ2010-01-01��
              Clsj varchar(5) check ( len(Clsj) = 5 )
                              not null ,--����ʱ�䣨��ʽ��01:02��
              Hzsg varchar(20) ,--�������
              Hztz varchar(20) ,--��������
              Hzfw varchar(20) ,--���߸�Χ
              Hzxxdm int ,--����Ѫ�ʹ��룬(CP_DataCategoryDetail.lbbh=57),5701-A�ͣ�5702-B�ͣ�5703-O�ͣ�5704-AB��
              Hzxx varchar(50) ,--����Ѫ��
              Xyxxdm int ,--ѪҺѪ�Դ���,(CP_DataCategoryDetail.lbbh=58),5801-HR���ԡ�5802-HR����
              Xyxx varchar(50) ,--ѪҺѪ�ԣ�HR���ԡ�HR����
              Hzsss varchar(200) ,--��������ʷ
              Hzsxs varchar(200) ,--������Ѫʷ
              Hzgms varchar(200) ,--���߹���ʷ
							--Hzst        varchar(200),--������̦
							--Hzmx        varchar(200),--��������
              Djrq varchar(19) default convert(varchar(19), getdate(), 121) ,--�Ǽ�����(��ʽ��2010-02-01 01:02:03) 
              Djysdm varchar(6) , --�Ǽ�ҽ��ID
              Djys varchar(30) ,--�Ǽ�ҽ��
              Zfrq varchar(19) ,--��������(��ʽ��2010-02-01 01:02:03) 
              Zfrydm varchar(6) , --������ԱID
              Zfry varchar(30) --������Ա	
						
            )
    end
go


/* ============================================================ */
/*   Table: CP_TreatmentFlow	  ������Ҫ�������̼�¼��        */
/* ============================================================ */
if not exists ( select  1
                from    sysobjects
                where   name = 'CP_TreatmentFlow' ) 
    begin
        create table CP_TreatmentFlow
            (
              Jlxh numeric(9, 0) identity ,--��¼��ţ��Զ����ɣ�
              Zyhm varchar(24) not null ,	--סԺ����(������)
              Ljxh numeric(9, 0) not null ,	--·�����(CP_InPatient.Syxh)
              Ljdm varchar(12) not null ,	--�ٴ�·�����루CP_ClinicalPath.Ljdm)
              ActivityId varchar(50) not null ,--·�����ID
              ActivityChildId varchar(50) not null ,--·���ӽڵ�ID(����ִ�н��KEYֵ)  
              Clrq varchar(10) not null , --���������ڣ���ʽ2010-01-01��
              Clsj varchar(5) check ( len(Clsj) = 5 )
                              not null ,--����ʱ�䣨��ʽ��01:02��
              Zllc varchar(255) not null ,--��Ҫ������������
              Lcsm varchar(500) not null ,--��������˵��
              Sfss bit default 0
                       not null ,--�Ƿ�����,0��������1������
              Djrq varchar(19) default convert(varchar(19), getdate(), 121) ,--�Ǽ�����(��ʽ��2010-02-01 01:02:03) 
              Djysdm varchar(6) , --�Ǽ�ҽ��ID
              Djys varchar(30) ,--�Ǽ�ҽ��
              Zfrq varchar(19) ,--��������(��ʽ��2010-02-01 01:02:03) 
              Zfrydm varchar(6) , --������ԱID
              Zfry varchar(30) --������Ա	
						
            )
    end
go

/* ============================================================ */
/*   Table: CP_DoctorTaskSet   ҽ��������ʾ����			    */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DoctorTaskSet' ) 
	BEGIN
		CREATE TABLE CP_DoctorTaskSet
			(
			  ID		NUMERIC(9, 0) identity(1,1)		NOT NULL ,--�������ñ��
			  Name		VARCHAR(40)						NOT NULL ,--����
			  Ljdm		varchar(12)						NULL	 ,--·�����루Ԥ���ֶΡ���ָ��·�����ã���ʱ���ã�
			  Yzlb		VARCHAR(8)						NULL	 ,--ҽ��������ö�Ӧҽ��������������CP_DataCategoryDetail Lbbh = 31
			  Mess		VARCHAR(400)					NULL	 ,--��ʾ��Ϣ
			  orderby	int								null	 ,--��Ϣ��ʾ˳���磺��������ʾ��Ӫ����ʳ֮ǰ��
			  Yxjl		INT			default 1			NOT NULL ,--��Ч��¼(1:��Ч 0����Ч)
			  Cjsj		datetime	default getdate()	not null ,--����ʱ��
			  Cjgh		varchar(9)						not null ,--�����˹���
			  Memo		VARCHAR(400)					null	 ,--��ע
			  
			  CONSTRAINT PK_CP_DoctorTaskSet PRIMARY KEY ( ID )
			)
	END
go



/* ============================================================ */
/*   Table: CP_DoctorTaskMessage   ҽ��������ʾ��Ϣ��		    */
/* ============================================================ */
if not exists ( select  1
				from    sysobjects
				where   Name = 'CP_DoctorTaskMessage' ) 
	begin
		create table CP_DoctorTaskMessage
			(
			  MsgID			numeric(9, 0)					not null ,	--��Ϣ���
			  SetID			numeric(9, 0)					not null ,	--���ñ��ţ���ӦCP_DoctorTaskSet��ID�ֶ�
			  Syxh			numeric(9, 0)					not null ,	--�������(CP_InPatient.Syxh)
			  Ljdm			varchar(12)						null	 ,	--·�����루��Ӧ·����ʾ���룩
			  PathDetailID  varchar(50)						null	 ,	--·�����ID 
			  Yxjl			int			default 1			not null ,	--��Ч��¼(1:��Ч0����Ч)
			  Cjsj			datetime	default getdate()	not null ,	--������ʾ��Ϣ����ʱ�䣨��̨����������ʾ��Ϣʱ�䣩Ĭ��Ϊ������ʱ��
			  Rwzt			int			default 0			not null ,	--����״̬��0������1����ɣ�
			  Yqsj			datetime						not null ,	--Ԥ�����ʱ�䣨ҳ���и��ݸ��ֶζ���Ϣ���е������У�
			  Wcsj			datetime						null	 ,	--ҽ���������ʱ�䣨ҽ�����·��������дʱ�䣩		
			  Ysbm			varchar(6)						null	 ,	--ҽ������
			  Ksdm			varchar(12)						null	 ,  --���Ҵ��루��ʱ������ΪԤ���ֶΣ�
			  Bqdm			varchar(12)						null	 ,	--�������루��ʱ������ΪԤ���ֶΣ�
			  Mess			varchar(400)					null	 ,	--��ʾ��Ϣ
			  Memo			varchar(400)					null	 ,  --��ע
			  
			  constraint PK_CP_DoctorTaskMessage primary key ( MsgID )
			)
	end
go

/* ============================================================ */
/*   Table: CP_PatientContacts  ������ϵ�˱�                   */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE	Name = 'CP_PatientContacts' )
	 BEGIN
CREATE TABLE CP_PatientContacts
(
	Lxbh NUMERIC(9, 0) IDENTITY not null,--��ϵ�˱�ţ��ǲ�����ϵ�˵�Ψһ��ʶ
	Syxh NUMERIC(9, 0)  NOT NULL ,	--��ҳ���(סԺ��ˮ��)(InPatient.Syxh)
	Lxrm VARCHAR(32) NULL ,	--��ϵ����
	Lxgx VARCHAR(4) NULL ,	--��ϵ��ϵ(CP_DictionaryDetail.Mxdm, lbdm = '44')
	Lxdz VARCHAR(255) NULL ,--��ϵ��ַ
	Lxdw VARCHAR(64) NULL ,	--��ϵ(��)��λ
	Lxjtdh VARCHAR(16) NULL ,--��ϵ�˼�ͥ�绰
	Lxgzdh VARCHAR(16) NULL,--��ϵ�˹����绰
	Lxyb VARCHAR(16) NULL ,	--��ϵ�ʱ�
    Lxcsrq CHAR(10)	NULL ,--��ϵ�˳�������
	CONSTRAINT PK_CP_PatientContacts PRIMARY KEY(Lxbh)
)
	 END
go

/* ============================================================ */



/* ============================================================ */
/*   Table: CP_FamilyHistory       ����ʷ		            	*/
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_FamilyHistory')
begin
create table CP_FamilyHistory
(--jack
	ID	NUMERIC(9, 0) identity(1,1)	NOT NULL,	--Ψһ��			
	Syxh			NUMERIC(9, 0)   not null,	--������ҳ���
	Jzgx			SMALLINT 		not null,	--�����ϵ(CP_DataCategoryDetail.Mxbh  Lbbh = 62)
	Csrq			char(10)   not null,	--�������ڣ���ǰ̨��ʾ���䣩
	Bzdm			varchar(32)		not null,	--���ִ���(��ӦCP_Diagnosis.Zddm)
	Sfjz			int				not null	,	--�Ƿ���(1:�ǣ���)
	Swyy			varchar(200)	null,	--����ԭ��
	Memo			varchar(255)	null	,	--��ע
	CONSTRAINT CP_FamilyHistoryID PRIMARY KEY ( ID )
)
create index idx_FamilyHistorySyxh ON CP_FamilyHistory (Syxh)
End
Go
  
/* ============================================================ */
/*   Table: CP_PersonalHistory       ����ʷ		            	*/
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_PersonalHistory')
begin
create table CP_PersonalHistory
(
	ID	NUMERIC(9, 0) identity(1,1)	NOT NULL,	--Ψһ��	
	Syxh			NUMERIC(9, 0)   not null,	--������ҳ���
	Hyzk			SMALLINT 		not null,	--����״��(CP_DataCategoryDetail.Lbbh = 63)
	Hzsl		int		default 0	not null,	--��������
	Zymc	 	    varchar(100)	null	,	--ְҵ����
	Sfyj			int				null	,	--�Ƿ����ƣ�1���� 0���ޣ�
	Yjs				varchar(255)	null	,	--����ʷ
	Sfxy			int				not null,	--�Ƿ����̣�1���� 0���ޣ�
	Csd             varchar(20)	null	,  	    --������
	Jld             varchar(20)	null	,	    --������
	Xys				varchar(255)	not null,	--����ʷ
	Memo			varchar(255)	null	,	--��ע
	CONSTRAINT CP_PersonalHistoryID PRIMARY KEY ( ID )
)
create index idx_PersonalHistorySyxh ON CP_PersonalHistory (Syxh)
End
Go
 
/* ============================================================ */
/*   Table: CP_AllergyHistory       ����ʷ		            	*/
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_AllergyHistory')
begin
create table CP_AllergyHistory
(
	ID	NUMERIC(9, 0) identity(1,1)	NOT NULL,	--Ψһ��
	Syxh			NUMERIC(9, 0)   not null,	--������ҳ���
	Gmlx			SMALLINT 		not null,	--��������(CP_DataCategoryDetail.Lbbh = 60)
	Gmcd			SMALLINT 		not null,	--�����̶ȣ�CP_DataCategoryDetail.Lbbh = 61��
	Dlys	 	    varchar(100)	null	,	--����ҽ��
	Gmbw			varchar(100)	null	,	--������λ
	Fylx			varchar(255)	null	,	--��Ӧ����
	Memo			varchar(255)	null	,	--��ע
	CONSTRAINT CP_AllergyHistoryID PRIMARY KEY ( ID )
)
create index idx_AllergyHistorySyxh ON CP_AllergyHistory (Syxh)
end
go
 
����
 
/* ============================================================ */
/*   Table: CP_SurgeryHistory       ����ʷ		            	*/
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_SurgeryHistory')
begin
create table CP_SurgeryHistory
(
	ID	NUMERIC(9, 0) identity(1,1)	NOT NULL,	--Ψһ��
	Syxh			NUMERIC(9, 0)   not null,	--������ҳ���
	Ssdm			varchar(12)		not null,	--��������(CP_Surgeryά��)
	Bzdm			varchar(32)		not null,	--��������ӦCP_Diagnosis.Zdbs��
	Sspl			varchar(200)	null	,	--����
	Ssys			varchar(100)	null	,	--����ҽ��
	Memo			varchar(255)	null	,	--��ע
	CONSTRAINT CP_SurgeryHistoryID PRIMARY KEY ( ID )
)
create index idx_SurgeryHistorySyxh ON CP_SurgeryHistory (Syxh)
end
go
 
/* ============================================================ */
/*   Table: CP_MedicalRecordsHistory       ���Ƽ�¼		    	*/
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_MedicalRecordsHistory')
begin
create table CP_MedicalRecordsHistory
(
	ID	NUMERIC(9, 0) identity(1,1)	NOT NULL,	--Ψһ��
	Syxh			NUMERIC(9, 0)   not null,	--������ҳ���
	Zlys			varchar(100)	not null,	--����ҽ��
	Zllb			varchar(100)	not null,	--���
	Zlyy		 	varchar(200)	null	,	--����ҽԺ
	Zlpl			varchar(200)	null	,	--��������
	Zlsj			datetime		not null,	--����ʱ��
	Memo			varchar(255)	null	,	--��ע
	CONSTRAINT CP_MedicalRecordsHistoryID PRIMARY KEY ( ID )
)
create index idx_MedicalRecordsHistorySyxh ON CP_MedicalRecordsHistory (Syxh)
end
go

 
/* ============================================================ */
/*   Table: CP_IllnessHistory       ����ʷ		    	*/
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_IllnessHistory')
begin
create table CP_IllnessHistory
(
	ID	NUMERIC(9, 0) identity(1,1)	NOT NULL,	--Ψһ��
	Syxh			NUMERIC(9, 0)   not null,	--������ҳ���
	Bzdm			varchar(32)		not null,	--���ִ��루��ӦCP_Diagnosis.Zdbs��
	Jbpl			varchar(200)	null	,	--��������
	Bfsj			datetime		not null,	--����ʱ��
	Sfzy			int				not	null,	--�Ƿ�������1����0����
	Memo			varchar(255)	null	,	--��ע
	CONSTRAINT CP_IllnessHistoryID PRIMARY KEY ( ID )
)
create index idx_IllnessHistorySyxh ON CP_IllnessHistory (Syxh)
end
go

/* ============================================================ */
/*   Table: CP_InpatientDiagnosisInfo���������ʾ��             */
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_InpatientDiagnosisInfo')
begin
	create table CP_InpatientDiagnosisInfo
	(
		ID	NUMERIC(9, 0) identity(1,1)		NOT NULL,	--Ψһ��
		Syxh			  NUMERIC(9, 0)		not null,	--������ҳ���
		Msg				  varchar(255)		not null,	--��������ʾ��Ϣ
		Djsj			  varchar(19)		not null,	--��ʾ��Ϣ�Ǽ�����
		Zxsj			  varchar(19)	    null,		--ע����ʾʱ��
		Zxys			  varchar(16)	    null,		--�޸����ҽ��
		Yxjl			  int				not null,	--�Ƿ���Ч
	   CONSTRAINT PK_CP_InpatientDiagnosisInfo PRIMARY KEY ( ID )
	 )
	create index idx_CP_InpatientDiagnosisInfoSyxh ON CP_InpatientDiagnosisInfo (Syxh)
end
go

/* ============================================================ */
/*   Table: CP_InpathEnterInfo   ���˽���·����ʾ��Ϣ		   */
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_InpathEnterInfo')
begin
create table CP_InpathEnterInfo
(
	ID	NUMERIC(9, 0) identity(1,1)		NOT NULL,	--Ψһ��
	Syxh			  NUMERIC(9, 0)		not null,	--������ҳ���
	Ljdm			  VARCHAR(12)		NOT NULL ,	--�ٴ�·������			
	Msg				  varchar(255)		not null,	--�����ʾ��Ϣ
	Djsj			  varchar(19)		not null,	--��ʾ��Ϣ�Ǽ�����
	Zxsj			  varchar(19)	    null,		--ע����ʾʱ��
	Zxys			  varchar(16)	    null,		--ע����ʾҽ��
	Zxly			  varchar(255)	    null,		--ע������
	Tslb			  int				not null,	--��ʾ��Ϣ���(1���������0:���������)
	Yxjl			  int				not null,	--�Ƿ���Ч
   CONSTRAINT PK_CP_InpathEnterInfo PRIMARY KEY ( ID )
 )

create index idx_CP_InpathEnterInfoSyxh ON CP_InpathEnterInfo (Syxh)
create index idx_CP_InpathEnterInfoLjdm ON CP_InpathEnterInfo (Ljdm)
end
go


/* ============================================================ */
/*   Table: CP_InpathExitInfo   �����˳�·����ʾ��Ϣ		   */
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_InpathExitInfo')
begin
create table CP_InpathExitInfo
(
	ID	NUMERIC(9, 0) identity(1,1)		NOT NULL,	--Ψһ��
	Syxh			  NUMERIC(9, 0)		not null,	--������ҳ���
	Ljdm			  VARCHAR(12)		NOT NULL ,	--�ٴ�·������			
	Msg				  varchar(255)		not null,	--�˳�·������
	Djsj			  varchar(19)		not null,	--��ʾ��Ϣ�Ǽ�����
	Zxsj			  varchar(19)	    null,		--ע����ʾʱ��
	Zxys			  varchar(16)	    null,		--ע����ʾҽ��
	Zxly			  varchar(255)	    null,		--ע������
	Yxjl			  int				not null,	--�Ƿ���Ч
   CONSTRAINT PK_CP_InpathExitInfo PRIMARY KEY ( ID )
 )

create index idx_CP_InpathExitInfoSyxh ON CP_InpathExitInfo (Syxh)
create index idx_CP_InpathExitInfoLjdm ON CP_InpathExitInfo (Ljdm)
end
go

/* ============================================================ */
/*   Table: CP_OrderToPath   ����/��ʱҽ����·����Ӧ��ϵ��      */
/* ============================================================ */
if not exists ( select  1
                from    sysobjects
                where   Name = 'CP_OrderToPath' ) 
    begin
        create table CP_OrderToPath
            (
              Id numeric(12, 0) identity
                                not null ,
              Yzxh numeric(12, 0) not null ,	--����(CP_LongOrder.Cqyzxh)/��ʱҽ�����(CP_TempOrder.Lsyzxh)
              Yzbz smallint null ,	--ҽ����־(ֻ���г��ڣ���ʱ��(CP_DataCategory.Mxbh, Lbbh = 27)
			  Ljxh NUMERIC(9, 0) NOT NULL ,	--·�����(CP_InPatient.Syxh)
              Ljdm varchar(12) not null ,	--�ٴ�·�����루CP_ClinicalPath.Ljdm)
              ActivityId varchar(50) not null ,--·�����ID
              ActivityChileId varchar(50) not null ,--·���ӽڵ�ID(����ִ�н��KEYֵ)             
              constraint PK_CP_OrderToPath primary key ( Id )
            )
        create index idx_Yzxh on CP_OrderToPath(Yzxh)
        create index idx_Yzbz on CP_OrderToPath(Yzbz)
        create index idx_Ljdm on CP_OrderToPath(Ljdm)
        create index idx_ActivityId on CP_OrderToPath(ActivityId)
        create index idx_ActivityChileId on CP_OrderToPath(ActivityChileId)
    end
GO


/* ============================================================ */
/*   Table: CP_PathLeadInRecord   ·�������¼                  */
/* ============================================================ */
if not exists ( select  1
                from    sysobjects
                where   Name = 'CP_PathLeadInRecord' ) 
    begin
        create table CP_PathLeadInRecord
            (
              Id numeric(12, 0) identity
                                not null ,
              Ljxh numeric(12, 0) not null ,--·�����CP_InPathPatient.Id
              Syxh numeric(9, 0) not null ,	--��ҳ���
              Ljdm varchar(12) not null ,--·������
              Yxjl smallint not null ,--1,��Ч��0����Ч 
              Create_Time varchar(19) not null ,
              Create_User varchar(6) not null ,
              constraint PK_CP_PathLeadInRecord primary key ( Id )
            )
        create index idx_Ljxh on CP_PathLeadInRecord(Ljxh)
        create index idx_Syxh on CP_PathLeadInRecord(Syxh)
    end
GO

/* ============================================================ */
/*   Table: CP_TriggerConditionDetail   ���񴥷��쳣������ϸ��	*/
/* ============================================================ */
if not exists ( select  1
				from    sysobjects
				where   name = 'CP_TriggerConditionDetail' ) 
begin
	create table CP_TriggerConditionDetail  
	(
		Jlxh   		numeric(9,0) identity,                          --�Զ�����
		Zbm         varchar(50)                      not null,      --������������Χ��ֵ����
		Jcbm        varchar(50)                      not null,      --�����Ŀ��������ֵ���ϸ����CP_ExamDictionaryDetail.Jcbm
		Tjbm		varchar(50)	                     not null,	    --��������CP_TriggerCondition.Tjbm
		Zmc         varchar(200)                     not null,      --������������Χ��ֵ��������
		Tjfw1       varchar(50)                      not null,      --����������Χֵ���պ��������ֵ�����պ�����ֵ.
		Ysf1        varchar(20)                      not null,      --�뷶Χֵ�Ƚ���������պ������������������պ����������.
		Tjfw2       varchar(50)                      null,          --����������Χֵ���պ������ұ�ֵ�����պ�������ֵ����������ֵ��.
		Ysf2        varchar(20)                      null,          --�뷶Χֵ�Ƚ���������պ������ұ�����������պ����������������������ֵ��.
		Zysf        varchar(20)                      null,          --�պ�������������֮�������:(&(��)��|(��)
		Syrq		varchar(50)						 null,		    --������Ⱥ
		Zlx         bit                              not null,      --����������Χֵ���ͣ�1������0�쳣
		Yxjl        bit default 1                    not null,      --��Ч��¼1��Ч��0��Ч
		Py			varchar(50)			 	         null,	        --ƴ��
		Wb			varchar(50)			             null,	        --���
		Bz   		varchar(200)                     null       	--��ע		
		constraint PK_CP_TriggerConditionDetail primary key(Zbm)
	)
	create index idx_Zbm on CP_TriggerConditionDetail(Zbm)
end

go
 
/* ============================================================ */
/*   Table: CP_TriggerConditionGroup ���񴥷��쳣��������ϸ��  	*/
/* ============================================================ */
if not exists ( select  1
				from    sysobjects
				where   name = 'CP_TriggerConditionGroup' ) 
begin
	create table CP_TriggerConditionGroup  
	(
		Jlxh   		numeric(9,0) identity,                          --�Զ�����
		Zbm         varchar(50)                      not null,      --������������Χ��ֵ����
		Tjbm		varchar(50)  	                 not null,	    --��������CP_TriggerCondition.Tjbm
		Zmc         varchar(200)                     not null,      --������������Χ��ֵ��������
		Tjzh        varchar(200)                     not null,      --������С������ϣ���'��'�ֿ�,CP_TriggerConditionDetail.Zbm���
		Ysf         varchar(20)                      not null,      --������С�������֮���ϵ���������'��'�ֿ�,�����ҵ�˳��ƥ��
		Syrq		varchar(50)						 null,			--������Ⱥ
		Zlx         bit                              not null,      --����������Χֵ���ͣ�1������0�쳣
		Yxjl        bit default 1                    not null,      --��Ч��¼1��Ч��0��Ч
		Py			varchar(50)			 	         null,	        --ƴ��
		Wb			varchar(50)			             null,	        --���
		Bz   		varchar(200)                     null       	--��ע		
		constraint PK_CP_TriggerConditionGroup primary key(Zbm)
	)
	create index idx_Zbm on CP_TriggerConditionGroup(Zbm)
end

go

/* ======================================================== */
/*   Table: CP_NurExecItem ����ִ����Ŀ��               	*/
/* ======================================================== */
if not exists ( select  1
                from    sysobjects
                where   NAME = 'CP_NurExecItem' ) 
    create table CP_NurExecItem
        (
          Xmxh varchar(12) not null ,		--��Ŀ����
          Name varchar(12) not null ,		--��Ŀ����
          OrderValue numeric(12, 0) not null
                                    default 0 ,	--�����ֶ�
          Yxjl smallint not null
                        default 1 ,				--�Ƿ���Ч
          Create_Time varchar(19) not null
                                  default convert(varchar(19), getdate(), 120) ,	--����ʱ��
          Create_User varchar(10) ,
          Cancel_Time varchar(19) ,
          Cancel_User varchar(10) ,
          constraint PK_CP_NurExecItem primary key ( Xmxh )
        )
go

/* ======================================================== */
/*   Table:  CP_NurExecCategory ����ִ������              */
/* ======================================================== */
if not exists ( select  1
                from    sysobjects
                where   NAME = ' CP_NurExecCategory' ) 
    create table CP_NurExecCategory
        (
          Lbxh varchar(12) not null ,		--������
          Name varchar(12) not null ,		--��Ŀ����
          Xmxh varchar(12) not null ,		--��Ŀ����,CP_NurExecItem. Xmxh
          InputType smallint not null
                             default 0 ,  --����ؼ����ͣ�0��,1�û��ؼ�����ʱ����
          OrderValue numeric(12, 0) not null
                                    default 0 ,	--�����ֶ�
          Yxjl smallint not null
                        default 1 ,				--�Ƿ���Ч
          Create_Time varchar(19) not null
                                  default convert(varchar(19), getdate(), 120) ,	--����ʱ��
          Create_User varchar(10) ,
          Cancel_Time varchar(19) ,
          Cancel_User varchar(10) ,
          constraint PK_CP_NurExecCategory primary key ( Lbxh )
        )
go

/* ======================================================== */
/*   Table:  CP_NurExecCategoryDetail ����ִ�������ϸ��        	*/
/* ======================================================== */
if not exists ( select  1
                from    sysobjects
                where   NAME = ' CP_NurExecCategoryDetail' ) 
    create table CP_NurExecCategoryDetail
        (
          Mxxh varchar(50) not null ,		--��ϸ����
          Name varchar(12) not null ,		--��Ŀ����
          Lbxh varchar(3000) not null ,		--������,CP_NurExecCategory.Lbxh
          InputType smallint not null
                             default 0 ,    --����ؼ����ͣ�0��,1TEXTBOX,2COMBBOX������ʱ����
          OrderValue numeric(12, 0) not null
                                    default 0 ,--�����ֶ�
          Yxjl smallint not null
                        default 1 ,			   --�Ƿ���Ч
          Create_Time varchar(19) not null
                                  default convert(varchar(19), getdate(), 120) ,	--����ʱ��
          Create_User varchar(10) ,
          Cancel_Time varchar(19) ,
          Cancel_User varchar(10) ,
		  Sfsy		int			
									NOT NULL,default 0 	--�Ƿ�ʹ����(0�� 1��)     (5.13	zm���)   
          constraint PK_CP_NurExecCategoryDetail primary key ( Mxxh )
        )
go

/* ======================================================== */
/*   Table:  CP_NurExecToPath ����ִ�������ϸ��        	*/
/* ======================================================== */
if not exists ( select  1
                from    sysobjects
                where   NAME = 'CP_NurExecToPath' ) 
    create table CP_NurExecToPath
        (
          Id numeric(12, 0) identity
                            not null ,
          Ljdm varchar(12) not null ,		--·������,CP_ClinicalPath.Ljdm
          PathDetailId varchar(50) not null ,--·�����
          Mxxh varchar(50) not null ,		--��ϸ����,CP_NurExecCategoryDetail.Mxxh
          Yxjl smallint not null
                        default 1 ,			   --�Ƿ���Ч
          Create_Time varchar(19) not null
                                  default convert(varchar(19), getdate(), 120) ,	--����ʱ��
          Create_User varchar(10) ,
          Cancel_Time varchar(19) ,
          Cancel_User varchar(10) ,
          constraint PK_CP_NurExecToPath primary key ( Id )
        )
go


/* ======================================================== */
/*   Table:  CP_NurExecRecord ����ִ�м�¼��        	*/
/* ======================================================== */
if not exists ( select  1
                from    sysobjects
                where   NAME = 'CP_NurExecRecord' ) 
    create table CP_NurExecRecord
        (
          Id numeric(12, 0) identity
                            not null ,
          Syxh numeric(9, 0) not null ,
          Ljxh numeric(9, 0) not null ,
          Ljdm varchar(12) not null ,		--·������,CP_ClinicalPath.Ljdm
          PathDetailId varchar(50) not null ,--·�����
          Mxxh varchar(12) not null ,		--��ϸ����,CP_NurExecCategoryDetail.Mxxh
          Bdmx varchar(12) , --����ϸ����CP_NurExecFormsDetail.Id��ʱ����
          Bdxh varchar(12) ,	--����ϸ����CP_ NurExecForms.Bdxh��ʱ����
          Yzxh numeric(12, 0) ,	--ҽ����ţ�Ϊҽ������,��ʱ����
          Value varchar(600) ,			--���ֵ��Ϊ�������͵ı�������ʱ����
          Yxjl smallint not null
                        default 1 ,			   --�Ƿ���Ч
          Create_Time varchar(19) not null
                                  default convert(varchar(19), getdate(), 120) ,	--����ʱ��
          Create_User varchar(10) ,
          Cancel_Time varchar(19) ,
          Cancel_User varchar(10) ,
          constraint PK_CP_NurExecRecord primary key ( Id )
        )
GO
/* ======================================================== */
/*   Table: CP_MedicalTreatmentWarm ·��ִ����ǰ���ѱ�		*/
/* ======================================================== */
IF NOT EXISTS(SELECT * FROM sysobjects WHERE name='CP_MedicalTreatmentWarm')
 DROP TABLE CP_MedicalTreatmentWarm
Create table CP_MedicalTreatmentWarm
(
	ID		NUMERIC(9, 0)	IDENTITY NOT NULL,  --�����ֶ�
	Syxh	NUMERIC(9, 0)  NOT NULL ,			--��ҳ���(סԺ��ˮ��)(InPatient.Syxh)
	Ljxh	NUMERIC(9, 0) NOT NULL ,			--·�����CP_InPathPatient.Id
	Ljdm	varchar(12) not null ,				--�ٴ�·�����루CP_ClinicalPath.Ljdm)
	Jddm	VARCHAR(50) ,						--�ڵ��GUID 
	Hzjddm  VARCHAR(50) ,						--ǰ�ýڵ�UniqueID
	Txlx	int  not null, 						--��������(1:������2����飬3��������Ϣ)
	Txzt	int not NULL,						--����״̬(0:δ�鿴��1���Ѳ鿴)
	dm		VARCHAR(12) NOT NULL ,				--���ѱ��루ҩƷ����||��������(or�շ�С��Ŀ����or�ٴ���Ŀ����,���������ִ��������Ŀ������ж�)(CP_PlaceOfDrug.Ypdm/CP_ChargingMinItem.Sfxmdm/CP_LCChargingItem.Lcxmdm)��
	mc		VARCHAR(64) NULL ,					--�������ݣ�ҩƷ(��Ŀ)����||��������||����(CP_PlaceOfDrug.Name/CP_ChargingMinItem.Name)��
	CONSTRAINT CP_MedicalTreatmentWarm_ID PRIMARY KEY(ID)
)
GO
/* ======================================================== */
/*   Table: CP_InpatientPathExedetail ·��ִ�м�¼�ڵ�˳����ϸ��	 zm 8.9 �޸� ����ڵ����ƣ��ڵ�����	*/
/* ======================================================== */
IF NOT EXISTS(SELECT * FROM sysobjects WHERE name='CP_InpatientPathExedetail')
 DROP TABLE CP_InpatientPathExedetail
CREATE TABLE CP_InpatientPathExedetail
(
	ID numeric(9, 0) IDENTITY,		--����
	Syxh numeric(9, 0) NOT NULL,	--��ҳ���
	Ljxh numeric(9, 0) NOT NULL,	--·�����
	Ljdm varchar(12) NOT NULL,		--·������
	Jddm varchar(50) NOT NULL,		--�ڵ����
	Zxsx numeric(9,0) NOT NULL,		--ִ��˳��(����д�С����)
	Jrsj varchar(20)				--ִ��ʱ��
	ActivityName varchar(50) -- �ڵ�����
	ActivityType varchar(50) -- �ڵ�����
)
GO

/* ======================================================== */
/*   Table:  CP_NurResult ������������              */
/* ======================================================== */
if not exists ( select  1
                from    sysobjects
                where   NAME = ' CP_NurResult' ) 
    create table CP_NurResult
        (
          Jgbh INT IDENTITY(1,1) not null ,		--������
          Name varchar(12) not null ,		--����������
          Yxjl smallint not null
                        default 1 ,				--�Ƿ���Ч
          Create_Time varchar(19) not null
                                  default convert(varchar(19), getdate(), 120) ,	--����ʱ��
          Create_User varchar(10) ,--������
          Update_Time varchar(19) ,--�޸�ʱ��
          Update_User varchar(10) ,--�޸���
          constraint PK_CP_NurResult primary key ( Jgbh )
        )
GO
/* ======================================================== */
/*   Table:  CP_NurExecuteResult ��������              */
/* ======================================================== */
if not exists ( select  1
                from    sysobjects
                where   NAME = ' CP_NurExecuteResult' ) 
    create table CP_NurExecuteResult
        (
          Id INT IDENTITY(1,1) NOT NULL ,		--�������
          Jgbh VARCHAR(50) NOT NULL ,		--������
          Mxxh VARCHAR(100) NOT NULL,       --������
          Yxjl smallint NOT NULL default 1 ,--�Ƿ���Ч
          Create_Time varchar(19) NOT NULL default convert(varchar(19), getdate(), 120) ,	--����ʱ��
          Create_User varchar(10) ,--������
          constraint CP_NurExecuteResult primary key ( Id )
        )
GO
/* ======================================================== */
/*   Table:  CP_NurExecRecordResult ����ִ�н����¼��        	*/
/* ======================================================== */
if not exists ( select  1
                from    sysobjects
                where   NAME = 'CP_NurExecRecordResult' ) 
    create table CP_NurExecRecordResult
        (
          Id  VARCHAR(50) NOT NULL ,--����ִ�н�����
          HlzxId varchar(50) NOT NULL ,		--����ִ�м�¼���,CP_NurExecRecord.Id
          JgId VARCHAR(50) NOT NULL,        --���������,CP_NurResult.Jgbh
          Yxjl smallint NOT NULL default 1 , --��Ч��¼
          Create_Time varchar(19) NOT NULL default convert(varchar(19), getdate(), 120) ,	--����ʱ��
          Create_User varchar(10) ,--������
          constraint PK_CP_NurExecRecordResult primary key ( Id )
        )
GO


/* ======================================================== */
/*   Table: CP_MasterDrugs  	�ؼ�ҩƷ��	*/
/* ======================================================== */
IF NOT EXISTS ( SELECT  1
                FROM    sysobjects
                WHERE   NAME = 'CP_MasterDrugs' ) 
    CREATE TABLE CP_MasterDrugs
        (
          Cdxh		VARCHAR(12) NOT NULL ,	--ҩƷ����	//CP_PlaceOfDrug. Cdxh
          Txfs		VARCHAR(1) NULL ,		--���ѷ�ʽ��1�����ѣ�2�������ʺ����룩
          ZgdmCj	VARCHAR(20) NULL ,		--�����߱���(CP_Employee.Zgdm)
          Cjsj		CHAR(19) NULL ,			--����ʱ��
          ZgdmXg	VARCHAR(20) NULL ,		--�޸��߱���(CP_Employee.Zgdm)
          Xgsj		CHAR(19) NULL ,			--�޸�ʱ��
          Bz		VARCHAR(300) NULL ,		--��ע
          CONSTRAINT PK_CP_MasterDrugs_Cdxh PRIMARY KEY ( Cdxh )
        )
GO
/* ======================================================== */
/*   Table: CP_MasterDrugRoles  	 	ҩƷ��ɫ��	*/
/* ======================================================== */
IF NOT EXISTS ( SELECT  1
                FROM    sysobjects
                WHERE   NAME = 'CP_MasterDrugRoles' ) 
    CREATE TABLE CP_MasterDrugRoles
        (
          Jsbm		VARCHAR(50) NOT NULL ,	--��ɫ����
          Jsmc		VARCHAR(50) NULL ,	--��ɫ����
          ZgdmCj	VARCHAR(20) NULL ,	--�����߱���(CP_Employee.Zgdm)
          Cjsj		CHAR(19) NULL ,		--����ʱ��
          ZgdmXg	VARCHAR(20) NULL ,	--�޸��߱���(CP_Employee.Zgdm)
          Xgsj		CHAR(19) NULL ,		--�޸�ʱ��
          Bz		VARCHAR(300) NULL ,
          CONSTRAINT PK_CP_MasterDrugRoles_Jsbm PRIMARY KEY ( Jsbm )
        )
GO
/* ======================================================== */
/*   Table: CP_MasterDrug2Role  	  	�ؼ�ҩƷ��Ӧ�ؼ�ҩƷ��ɫ��	*/
/* ======================================================== */
IF NOT EXISTS ( SELECT  1
                FROM    sysobjects
                WHERE   NAME = 'CP_MasterDrug2Role' ) 
    CREATE TABLE CP_MasterDrug2Role
        (
          Jsbm		VARCHAR(50) NOT NULL ,	--��ɫ���루DrugRoles. Jsbm��
          Cdxh		VARCHAR(12) NOT NULL ,	--ҩƷ����	//CP_PlaceOfDrug. Cdxh
          ZgdmCj	VARCHAR(20) NULL ,	--�����߱���(CP_Employee.Zgdm)
          Cjsj		CHAR(19) NULL ,		--����ʱ��
          ZgdmXg	VARCHAR(20) NULL ,	--�޸��߱���(CP_Employee.Zgdm)
          Xgsj		CHAR(19) NULL ,		--�޸�ʱ��
          Bz		VARCHAR(300) NULL ,
          CONSTRAINT PK_CP_MasterDrug2Role_JsbmCdxh PRIMARY KEY ( Jsbm, Cdxh)
        )
GO

/* ======================================================== */
/*   Table: CP_MasterDrug2User  	  	2.1.4.	�˻���ӦҩƷ��ɫ��	*/
/* ======================================================== */
IF NOT EXISTS ( SELECT  1
                FROM    sysobjects
                WHERE   NAME = 'CP_MasterDrug2User' ) 
    CREATE TABLE CP_MasterDrug2User
        (
          Zgdm		VARCHAR(6) NOT NULL ,	--ְ������(CP_Employee.Zgdm)
          Jsbm		VARCHAR(50) NOT NULL ,--��ɫ����(MasterDrugRoles. Jsbm)
          ZgdmCj	VARCHAR(20) NULL ,	--�����߱���(CP_Employee.Zgdm)
          Cjsj		CHAR(19) NULL ,		--����ʱ��
          ZgdmXg	VARCHAR(20) NULL ,	--�޸��߱���(CP_Employee.Zgdm)
          Xgsj		CHAR(19) NULL ,		--�޸�ʱ��
          Bz		VARCHAR(300) NULL ,
          CONSTRAINT PK_CP_MasterDrug2User_ZgdmJsbm PRIMARY KEY ( Zgdm,Jsbm )
        )
GO
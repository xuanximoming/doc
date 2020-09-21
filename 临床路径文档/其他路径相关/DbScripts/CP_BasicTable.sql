/* ======================================================== */
/*   Table: CP_PathExecuteFlowActivityChildren 路径执行记录子节点节点顺序明细表	zm 8.9 */
/* ======================================================== */
 IF NOT EXISTS ( SELECT 1
                 FROM   sysobjects
                 WHERE  NAME = 'CP_PathExecuteFlowActivityChildren' ) 
    CREATE TABLE CP_PathExecuteFlowActivityChildren
        (
			ID numeric(9, 0) IDENTITY,		--自增
			Activity_UniqueID varchar(50) NOT NULL,		--父节点代码
			ActivityChildrenID	varchar(50) NOT NULL,	--子节点代码
			Zxsx numeric(9,0) NOT NULL,		--执行顺序(编号有大到小排序)
			Jrsj varchar(20)				--执行时间
        )
GO
/* ======================================================== */
/*   Table: CP_PatientPathEnterJudgeConditionRecord 病人路径（节点）进入条件表记录（记录进入路径当时的情况）	*/
/* ======================================================== */
 IF NOT EXISTS ( SELECT 1
                 FROM   sysobjects
                 WHERE  NAME = 'CP_PatientPathEnterJudgeConditionRecord' ) 
    CREATE TABLE CP_PatientPathEnterJudgeConditionRecord
        (
          ID INT IDENTITY NOT NULL ,		--自增主键
          Lb INT NOT NULL ,					--类别（1：路径，2：节点）
		  Ljxh VARCHAR(50) ,				--路径序号(CP_InPathPatient.Id)
		  Syxh NUMERIC(9, 0) NOT NULL ,		--首页序号(CP_InPatient.Syxh)
          Ljdm VARCHAR(12) NOT NULL ,		--路径代码（CP_PathCondition.Ljdm）
          Jddm VARCHAR(50) ,				--节点的GUID
          Sjfl VARCHAR(50) ,				--上级分类（CP_ExamDictionary.Jlxh）
          Jcxm VARCHAR(50) NOT NULL ,		--检查项目（Xmlb=1：CP_ExamDictionaryDetail.Jcbm 或 Xmlb=2：CP_Diagnosis.Zdbs）
          JcxmName VARCHAR(400)  ,			--如果Xmlb=9那么就存储不满足条件时的备注
          Xmlb VARCHAR(50) NOT NULL ,		--项目类别（1：检查项目，2：ICD-10,9:表示当条件不满足时输入的内容）
          Ksfw VARCHAR(50) ,				--开始范围
          Jsfw VARCHAR(50) ,				--结束范围
		  Jcjg VARCHAR(50) ,				--病人检查结果
		  Pdjg VARCHAR(50) ,				--判断结果（NoExist（病人不存在该检查项）,NoMatch（检查项不满足条件）,Match（检查项满足条件）,）
          Dw VARCHAR(20) ,					--单位（CP_ExamDictionaryDetail.Jldw）
          Bz VARCHAR(200) ,					--备注
          CONSTRAINT PK_CP_PatientPathEnterJudgeConditionRecord_ID PRIMARY KEY ( ID )
        )
GO
/* ======================================================== */
/*   Table: CP_PatientExamItem 病人检查项	*/
/* ======================================================== */
 IF NOT EXISTS ( SELECT 1
                 FROM   sysobjects
                 WHERE  NAME = 'CP_PatientExamItem' ) 
    CREATE TABLE CP_PatientExamItem
        (
          ID INT IDENTITY NOT NULL ,		--自增主键
          Syxh NUMERIC(9, 0) NOT NULL ,	--首页序号(CP_InPatient.Syxh)
          Sjfl VARCHAR(50) ,				--上级分类（CP_ExamDictionary.Jlxh）
          Jcxm VARCHAR(50) NOT NULL ,		--检查项目（Xmlb=1：CP_ExamDictionaryDetail.Jcbm 或 Xmlb=2：CP_Diagnosis.Zdbs）
          Jcjg VARCHAR(50) ,				--检查结果
          Dw VARCHAR(20) ,					--单位（CP_ExamDictionaryDetail.Jldw）
          Bz VARCHAR(200) ,					--备注
          CONSTRAINT PK_CP_PatientExamItem_ID PRIMARY KEY ( ID )
        )
GO
/* ======================================================== */
/*   Table: BaseTable 基础表	*/
/* ======================================================== */
IF not EXISTS(SELECT 1 FROM sysobjects WHERE NAME='BaseTable')
CREATE TABLE BaseTable
(
	 ID int identity ,--自增字段
	 Bm int NOT NULL,--编码
	 Mc varchar(50),--名字
	 Lb varchar(5),--类别（1：表示性别）
	 Sfqy bit,--是否启用（1：表示启用，0表示停用）
	 Bz varchar(200),--备注
)

go
/* ======================================================== */
/*   Table: CP_PathEnterJudgeCondition 路径（节点）进入条件表	*/
/* ======================================================== */
 IF NOT EXISTS ( SELECT 1
                 FROM   sysobjects
                 WHERE  NAME = 'CP_PathEnterJudgeCondition' ) 
    CREATE TABLE CP_PathEnterJudgeCondition
        (
          ID INT IDENTITY NOT NULL ,		--自增主键
          Lb INT NOT NULL ,					--类别（1：路径，2：节点）
          Ljdm VARCHAR(12) NOT NULL ,		--路径代码（CP_PathCondition.Ljdm）
          Jddm VARCHAR(50) ,				--节点的GUID
          Sjfl VARCHAR(50) ,				--上级分类（CP_ExamDictionary.Jlxh）
          Jcxm VARCHAR(400) NOT NULL ,		--检查项目（Xmlb=1：CP_ExamDictionaryDetail.Jcbm 或 Xmlb=2：CP_Diagnosis.Zdbs）
          Xmlb VARCHAR(50) NOT NULL ,		--项目类别（1：检查项目，2：ICD-10）
          Ksfw VARCHAR(50) ,				--开始范围
          Jsfw VARCHAR(50) ,				--结束范围
          Dw VARCHAR(20) ,					--单位（CP_ExamDictionaryDetail.Jldw）
          Syrq VARCHAR(50)  ,		--适用人群（CP_ExamSyrq.Jlxh人，成人，男人，女人，婴儿等）
          Bz VARCHAR(200) ,					--备注
          CONSTRAINT PK_CP_PathEnterJudgeCondition_ID PRIMARY KEY ( ID )
        )
GO
/* ======================================================== */
/*   Table: CP_ExamSyrq 适用人群（CP_PathEnterJudgeCondition中使用）	*/
/* ======================================================== */
 IF ( NOT EXISTS ( SELECT   1
                   FROM     sysobjects
                   WHERE    NAME = 'CP_ExamSyrq' )
    ) 
    CREATE TABLE CP_ExamSyrq
        (
          ID INT IDENTITY
                 NOT NULL ,					--自增字段
          Jlxh VARCHAR(50) NOT NULL ,		--记录序号
          MC VARCHAR(20) NOT NULL ,			--名称
          Yxjb INT NOT NULL ,				--优先级
          Xb VARCHAR(50) NOT NULL ,			--性别(CP_DictionaryDetail.Bm),(男=1，女=2)
          Qsnl INT NOT NULL ,				--起始年龄
          Jsnl INT NOT NULL,				--结束年龄
          CONSTRAINT PK_CP_ExamSyrq_ID PRIMARY KEY(ID)
        )

/* ======================================================== */
/*   Table: CP_ExamDictionary 检查项目分类	*/
/* ======================================================== */
if not exists ( select  1
				from    sysobjects
				where   name = 'CP_ExamDictionary' ) 
begin
	create table CP_ExamDictionary  
	( 
		Jlxh	    numeric(9,0) identity,    	                         --自动生成
		Jcbm        varchar(50)			             not null,           --检查项目编码
		Fjd         varchar(50)                      null,               --父节点编码(Jcbm)
		Jcmc		varchar(200)	                 not null,	         --检查项目编码名称
		Mcsx        varchar(50)				         null,               --名称缩写符号
		Py			varchar(50)			 	         null,	             --拼音
		Wb			varchar(50)			             null,	             --五笔
		Bz  		varchar(200)				     null,	             --备注
		constraint PK_CP_ExamDictionary primary key(Jcbm)
	)
	create index idx_Jcbm on CP_ExamDictionary(Jcbm)
end

go


/* ==================================================================== */
/*   Table: CP_ExamDictionaryDetail  检查项目表	*/
/* ==================================================================== */
if not exists ( select  1
				from    sysobjects
				where   name = 'CP_ExamDictionaryDetail' ) 
begin
	create table CP_ExamDictionaryDetail  
	( 
		Jlxh		numeric(9,0) identity,       	                     --自动生成
		Jcbm        varchar(50)                      not null,           --检查项目编码(导入时映射)
		Flbm        varchar(50)                      null,               --分类编码(CP_ExamDictionary.Jcbm)
		Jcmc		varchar(200)	                 not null,	         --检查项目名称
		Mcsx        varchar(50)			             null,               --名称缩写符号
		Ksfw		varchar(100)					 null,				 --开始范围（正常范围）
		Jsfw		varchar(100)					 null,				 --结束范围（正常范围）
		Syrq		varchar(50)						 null,				 --适用人群（CP_PathEnterJudgeCondition.ID人，成人，男人，女人，婴儿等）
		Jsdw        varchar(20) 		             null,               --单位           
		Py			varchar(50) 		   			     null,	             --拼音
		Wb			varchar(50) 		                 null,	             --五笔
		Yxjl        bit default 1                    null,               --有效记录
		Bz  		varchar(200) 		             null,	             --备注
		constraint PK_CP_ExamDictionaryDetail primary key(Jcbm)
	)
	create index idx_Jcbm on CP_ExamDictionaryDetail(Jcbm)
end

go


/* ============================================================ */
/*   Table: CP_DataCategory    数据类别库                      */
/*          保存数据类别的名称和说明,用户不可维护               */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DataCategory' ) 
	BEGIN
		CREATE TABLE CP_DataCategory
			(
			  Lbbh SMALLINT NOT NULL ,	--(数据)类别编号
			  Name VARCHAR(16) NOT NULL ,	--(分类)名称
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔
			  Memo VARCHAR(64) NULL ,    	--备注
			  CONSTRAINT PK_CP_DataCategory PRIMARY KEY ( Lbbh )
			)
	END
go

/* ============================================================ */
/*   Table: CP_DataCategoryDetail   数据类别明细库                       */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DataCategoryDetail' ) 
	BEGIN
		CREATE TABLE CP_DataCategoryDetail
			(
			  Mxbh SMALLINT NOT NULL ,	--明细编号(作为数据分类代码,组成形式为'类别序号'+'2位的流水号', 例: 101, 102, 201, 205, 1201)
			  Name VARCHAR(16) NOT NULL ,	--分类名称
			  Lbbh SMALLINT NOT NULL ,	--类别编号(CP_DataCategory.Lbbh)
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔
			  Memo VARCHAR(16) NULL ,    	--备注
			  CONSTRAINT PK_CP_DataCategoryDetail PRIMARY KEY ( Mxbh )
			)
	END
go

/* ============================================================ */
/*   Table: CP_Hospital     用户基本信息                           */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Hospital' ) 
	BEGIN
		CREATE TABLE CP_Hospital
			(
			  Yydm VARCHAR(12) NOT NULL ,	--医院代码
			  Name VARCHAR(64) NOT NULL ,	--(医院)名称
			  Fjmc VARCHAR(64) NULL ,	--附加名称(用来保存"XXX附属医院"等)
			  Sqm VARCHAR(12) NULL ,	--授权码
			  Ybdm VARCHAR(12) NULL ,	--(医院的)医保代码
			  Dqdm VARCHAR(10) NULL ,	--地区代码
			  Qxdm VARCHAR(10) NULL ,	--(医院)区县代码
			  Qndm VARCHAR(4) NULL ,	--医院区内代码
			  Khyh VARCHAR(64) NULL ,	--开户银行
			  Yhzh VARCHAR(16) NULL ,	--银行账号
			  Yydz VARCHAR(64) NULL ,	--医院地址
			  Yzbm VARCHAR(12) NULL ,	--邮政编码
			  Dhhm VARCHAR(16) NULL ,	--电话号码
			  Bzcws INT NULL ,	--编制床位数
			  Yydj SMALLINT NOT NULL ,	--医院等级(CP_DataCategory.Mxbh Lbbh = 5)
			  Yylb SMALLINT NOT NULL ,	--医院类别(CP_DataCategory.Mxbh Lbbh = 6)
			  Memo VARCHAR(64) NULL ,	--备注
			  CONSTRAINT PK_CP_Hospital PRIMARY KEY ( Yydm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_Department	科室代码库                      */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Department' ) 
	BEGIN
		CREATE TABLE CP_Department
			(
			  Ksdm VARCHAR(12) NOT NULL ,	--科室代码
			  Name VARCHAR(32) NOT NULL ,	--科室名称
			  Py VARCHAR(8) NULL ,	--拼音
			  Wb VARCHAR(8) NULL ,	--五笔
			  Yydm VARCHAR(12) NULL ,	--医院代码(CP_Hospital.Yydm)
			  Yjksdm VARCHAR(12) NOT NULL ,	--一级科室代码(CP_Department_A.ID)     
			  Ejksdm VARCHAR(12) NOT NULL ,	--二级科室代码(CP_Department_B.ID)    
			  Kslb SMALLINT NOT NULL ,	--科室类别(CP_DataCategory.Mxbh Lbbh = 1)
			  Ksbz SMALLINT NOT NULL ,	--科室标志(CP_DataCategory.Mxbh Lbbh = 2)
			  Zryss INT NULL ,	--主任医师数
			  Zyyss INT NULL ,	--住院医师数
			  Zzyss INT NULL ,	--主治医师数
			  Hss INT NULL ,	--护士数
			  Cws INT NULL ,	--(考核)床位数
			  Hdcws INT NULL ,	--核定加床数
			  Yxjl SMALLINT NOT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(64) NULL ,	--备注
			  CONSTRAINT PK_CP_Department PRIMARY KEY ( Ksdm )
			)
		CREATE INDEX idx_py ON CP_Department(Py)
		CREATE INDEX idx_wb ON CP_Department(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_Department_A	一级科室库                              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   name = 'CP_Department_A' ) 
	BEGIN
		CREATE TABLE CP_Department_A
			(
			  ID VARCHAR(12) NOT NULL ,	--一级科室代码
			  Name VARCHAR(32) NOT NULL ,	--科室名称
			  Py VARCHAR(8) NULL ,	--拼音
			  Wb VARCHAR(8) NULL ,	--五笔
			  Memo VARCHAR(16) NULL ,	--备注
			  CONSTRAINT PK_CP_Department_A PRIMARY KEY ( ID )
			)
	END
go

/* ============================================================ */
/*   Table: CP_Department_B	二级科室库                              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   name = 'CP_Department_B' ) 
	BEGIN
		CREATE TABLE CP_Department_B
			(
			  ID VARCHAR(12) NOT NULL ,	--一级科室代码
			  Name VARCHAR(32) NOT NULL ,	--科室名称
			  Py VARCHAR(8) NULL ,	--拼音
			  Wb VARCHAR(8) NULL ,	--五笔
			  DeptAID VARCHAR(12) NOT NULL ,	--(所属)一级科室代码(CP_Department_A.id)
			  DeptAName VARCHAR(32) NOT NULL ,	--(所属)一级科室名称(CP_Department_A.name)
			  Memo VARCHAR(16) NULL ,	--备注
			  CONSTRAINT PK_CP_Department_B PRIMARY KEY ( ID )
			)
	END
go

/* ============================================================ */
/*   Table: CP_Ward     病区代码库                             */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Ward' ) 
	BEGIN
		CREATE TABLE CP_Ward
		  (
			  Bqdm VARCHAR(12) NOT NULL ,	--病区代码
			  Name VARCHAR(32) NOT NULL ,	--病区名称
			  Py VARCHAR(8) NULL ,	--拼音
			  Wb VARCHAR(8) NULL ,	--五笔
			  Yydm VARCHAR(12) NOT NULL ,	--医院代码(CP_Hospital.Yydm)
			  Cws INT NULL ,	--床位数
			  Bqbz SMALLINT NOT NULL ,	--病区标志(CP_DataCategory.Mxbh Lbbh = 3)
			  Yxjl SMALLINT NOT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--备注
			  CONSTRAINT PK_CP_Ward PRIMARY KEY ( Bqdm )
			)
		CREATE INDEX idx_py ON CP_Ward(Py)
		CREATE INDEX idx_wb ON CP_Ward(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_Dept2Ward      科室病区对应库                      */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Dept2Ward' ) 
	BEGIN
		CREATE TABLE CP_Dept2Ward
			(
			  Ksdm VARCHAR(12) NOT NULL ,	--科室代码(CP_Department.Ksdm)
			  Bqdm VARCHAR(12) NOT NULL ,	--病区代码(CP_Ward.Bqdm)
			  Cws INT DEFAULT ( 0 )
					  NULL ,	--床位数
			  CONSTRAINT PK_CP_Dept2Ward PRIMARY KEY ( Ksdm, Bqdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_Employee      职工代码                              */
/*                        操作员表和职工表合二为一              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Employee' ) 
	BEGIN
		CREATE TABLE CP_Employee
			(
			  Zgdm VARCHAR(6) NOT NULL ,	--职工代码
			  Name VARCHAR(32) NOT NULL ,	--职工姓名
			  Py VARCHAR(8) NULL ,	--拼音
			  Wb VARCHAR(8) NULL ,	--五笔
			  Zgxb VARCHAR(4) NULL ,	--职工性别(CP_DictionaryDetail.Name, lbdm = '3')
			  Csrq CHAR(10) NULL ,	--出生日期
			  Hyzk VARCHAR(2) NULL ,	--婚姻状况(CP_DictionaryDetail.Mxdm, lbdm = '4')
			  Sfzh VARCHAR(18) NULL ,	--身份证号
			  Ksdm VARCHAR(12) NULL ,	--科室代码(当前选择的科室)(YY_KSDMK.Ksdm)
			  Bqdm VARCHAR(12) NULL ,	--病区代码(当前选择的病区)(YY_BQDMK.Bqdm)
			  Zglb SMALLINT NOT NULL ,	--职工类别(CP_DataCategory.Mxbh Lbbh = 4)
			  Zcdm VARCHAR(4) NULL ,	--职称代码(CP_DictionaryDetail.Mxdm, lbdm = '40')
			  Cfzh VARCHAR(6) NULL ,	--处方章号
			  Cfq SMALLINT NOT NULL ,	--(有)处方权(CP_DataCategory.Mxbh Lbbh = 0)
			  Mzcfq SMALLINT NOT NULL ,	--(有)麻醉处方权(CP_DataCategory.Mxbh Lbbh = 0)
			  Fzbm VARCHAR(32) NULL ,	--分组编码('/主任代码//主治代码//医生代码/')
			  Ysjb SMALLINT NULL ,	--医生级别(CP_DataCategory.Mxbh Lbbh = 20)
			  Passwd VARCHAR(32) NULL ,	--密码
			  Gwdm VARCHAR(255) NULL ,	--岗位代码
			  Djsj CHAR(19) NULL ,	--登记时间
			  Szry VARCHAR(6) NULL ,	--设置人员(YY_CZRYK.czydm)
			  Yxjl SMALLINT NOT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--备注
			  CONSTRAINT PK_CP_Employee PRIMARY KEY ( Zgdm )
			)
		CREATE INDEX idx_py ON CP_Employee(Py)
		CREATE INDEX idx_wb ON CP_Employee(Wb)
	END
go
/* ============================================================ */
/*   Table: CP_MedicareInfo     医保分类库                             */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_MedicareInfo' ) 
	BEGIN
		CREATE TABLE CP_MedicareInfo
			(
			  Ybdm VARCHAR(4) NOT NULL ,	--医保代码
			  Ybsm VARCHAR(32) NOT NULL ,	--医保说明
			  Py VARCHAR(8) NULL ,	--拼音
			  Wb VARCHAR(8) NULL ,	--五笔
			  Rqfl VARCHAR(2) NOT NULL ,	--人群分类(CP_DictionaryDetail.Name, lbdm = '46')
			  Ztqk VARCHAR(2) NOT NULL ,	--职退情况(CP_DictionaryDetail.Name, lbdm = '47')
			  Bjqk VARCHAR(2) NOT NULL ,	--保健情况(CP_DictionaryDetail.Name, lbdm = '48')
			  Tsry VARCHAR(2) NOT NULL ,	--特殊人员(CP_DictionaryDetail.Name, lbdm = '49')
			  Hzlb VARCHAR(2) NOT NULL ,	--患者类别(CP_DictionaryDetail.Name, lbdm = '50')  
			  Ybbl NUMERIC(7, 2) DEFAULT 1
								 NOT NULL ,	--医保比例
			  Xtbz SMALLINT NOT NULL ,	--系统标志(CP_DataCategory.Mxbh Lbbh = 16)
			  Zfbz SMALLINT NOT NULL ,	--(医保)自负标志(CP_DataCategory.Mxbh Lbbh = 17)
			  Zhbz SMALLINT NOT NULL ,	--帐户标志(CP_DataCategory.Mxbh Lbbh = 18)
			  Qfje NUMERIC(10, 2) NULL ,	--(默认)起付金额
			  Jsfs SMALLINT NOT NULL ,	--计算方式(CP_DataCategory.Mxbh Lbbh = 19)
			  Yztyx MONEY NULL ,	--医嘱停药线
			  Pzlx VARCHAR(2) NULL ,	--凭证类型(代码)
			  Pzlxmc VARCHAR(16) NULL ,	--凭证类型名称
			  Yxjl SMALLINT NOT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(64) NULL ,	--备注
			  CONSTRAINT PK_CP_MedicareInfo PRIMARY KEY ( Ybdm )
			)
		CREATE INDEX idx_py ON CP_MedicareInfo(Py)
		CREATE INDEX idx_wb ON CP_MedicareInfo(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_DataDictionary     字典分类库                             */
/*          保存代码字典分类的名称和说明,用户不可维护           */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DataDictionary' ) 
	BEGIN
		CREATE TABLE CP_DataDictionary
			(
			  Lbdm VARCHAR(2) NOT NULL ,	--(字典)类别代码
			  Name VARCHAR(32) NOT NULL ,	--(分类)名称
			  Py VARCHAR(8) NULL ,	--拼音
			  Wb VARCHAR(8) NULL ,	--五笔
			  Memo VARCHAR(16) NULL ,	--备注
			  CONSTRAINT PK_CP_DataDictionary PRIMARY KEY ( Lbdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_DictionaryDetail       字典分类明细库               	*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DictionaryDetail' ) 
	BEGIN
		CREATE TABLE CP_DictionaryDetail
			(
			  Mxdm VARCHAR(4) NOT NULL ,	--明细代码
			  Ysdm VARCHAR(16) NULL ,	--映射代码
			  Name VARCHAR(32) NOT NULL ,	--名称
			  Py VARCHAR(8) NULL ,	--拼音
			  Wb VARCHAR(8) NULL ,	--五笔
			  Lbdm VARCHAR(2) NOT NULL ,	--(字典)类别代码(CP_DataDictionary.lbdm)
			  Yxjl SMALLINT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--备注
			  CONSTRAINT PK_CP_DictionaryDetail PRIMARY KEY ( Lbdm, Mxdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_Diagnosis       医院诊断库                           */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Diagnosis' ) 
	BEGIN
		CREATE TABLE CP_Diagnosis
			(
			  Zdbs VARCHAR(32) NOT NULL , 	--诊断标识(zddm + zlbm，由于使用计算列或触发器的方式，都不便于在前台程序维护数据，所以该列的值由前台程序生成)
			  Zddm VARCHAR(12) NOT NULL ,	--诊断代码(ICD10)
			  Ysdm VARCHAR(16) NULL ,	--映射代码
			  Bzdm VARCHAR(12) NOT NULL ,	--(对应的)标准代码(用户自定义代码有标准代码时，填写此字段)
			  Name VARCHAR(64) NOT NULL ,	--疾病名称
			  Py VARCHAR(8) NULL ,	--拼音
			  Wb VARCHAR(8) NULL ,	--五笔
			  Zldm VARCHAR(12) DEFAULT ( '' )
							   NOT NULL ,	--肿瘤编码(YY_ZLK.zldm)
			  Tjm VARCHAR(4) NOT NULL ,	--所属统计分类(CP_DiseaseCFG.Bzdm, Bzlb = 700)
			  Nbfl VARCHAR(4) DEFAULT ( '' )
							  NULL ,	--内部分类(医院内部自定义分类,CP_DiseaseCFG.Bzdm, Bzlb = 702)
			  Bzlb VARCHAR(4) DEFAULT ( '' )
							  NULL ,	--病种类别(单病种代码, CP_DiseaseCFG.Bzdm, Bzlb = 701)
			  Qtlb SMALLINT NULL ,	--(疾病)其他类别(CP_DataCategory.Mxbh Lbbh = 9)
			  Yxjl SMALLINT NOT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--备注
			  CONSTRAINT PK_CP_Diagnosis PRIMARY KEY ( Zdbs )
			)
		CREATE INDEX idx_zddm ON CP_Diagnosis(Zddm)
		CREATE INDEX idx_py ON CP_Diagnosis(Py)
		CREATE INDEX idx_wb ON CP_Diagnosis(Wb)
		CREATE INDEX idx_ysdm ON CP_Diagnosis(Ysdm)
	END
go

/* ============================================================ */
/*   Table: CP_PathDiagnosis       医院路径诊断库（可以进入路径的病种)                         */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_PathDiagnosis' ) 
	BEGIN
		CREATE TABLE CP_PathDiagnosis
			(
			  Zdbs VARCHAR(32) NOT NULL , 	--诊断标识(zddm + zlbm，由于使用计算列或触发器的方式，都不便于在前台程序维护数据，所以该列的值由前台程序生成)
			  Zddm VARCHAR(12) NOT NULL ,	--诊断代码(ICD10)
			  Ysdm VARCHAR(16) NULL ,	--映射代码
			  Bzdm VARCHAR(12) NOT NULL ,	--(对应的)标准代码(用户自定义代码有标准代码时，填写此字段)
			  Name VARCHAR(64) NOT NULL ,	--疾病名称
			  Py VARCHAR(8) NULL ,	--拼音
			  Wb VARCHAR(8) NULL ,	--五笔
			  Zldm VARCHAR(12) DEFAULT ( '' )
							   NOT NULL ,	--肿瘤编码(YY_ZLK.zldm)
			  Tjm VARCHAR(4) NOT NULL ,	--所属统计分类(CP_DiseaseCFG.Bzdm, Bzlb = 700)
			  Nbfl VARCHAR(4) DEFAULT ( '' )
							  NULL ,	--内部分类(医院内部自定义分类,CP_DiseaseCFG.Bzdm, Bzlb = 702)
			  Bzlb VARCHAR(4) DEFAULT ( '' )
							  NULL ,	--病种类别(单病种代码, CP_DiseaseCFG.Bzdm, Bzlb = 701)
			  Qtlb SMALLINT NULL ,	--(疾病)其他类别(CP_DataCategory.Mxbh Lbbh = 9)
			  Yxjl SMALLINT NOT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--备注
			  CONSTRAINT PK_CP_PathDiagnosis PRIMARY KEY ( Zdbs )
			)
		CREATE INDEX idx_zddm ON CP_PathDiagnosis(Zddm)
		CREATE INDEX idx_py ON CP_PathDiagnosis(Py)
		CREATE INDEX idx_wb ON CP_PathDiagnosis(Wb)
		CREATE INDEX idx_ysdm ON CP_PathDiagnosis(Ysdm)
	END
go

/* ============================================================ */
/*   Table: CP_DiseaseCFG      病种设置库                           */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DiseaseCFG' ) 
	BEGIN
		CREATE TABLE CP_DiseaseCFG
			(
			  Bzdm VARCHAR(4) NOT NULL ,	--病种代码(单病种或疾病分类代码)
			  Ysdm VARCHAR(16) NULL ,	--映射代码
			  Name VARCHAR(64) NOT NULL ,	--名称
			  Py VARCHAR(8) NULL ,	--拼音代码
			  Wb VARCHAR(8) NULL ,	--五笔代码
			  Jbbm VARCHAR(64) DEFAULT ( '' )
							   NULL ,	--(包含的)疾病诊断代码(诊断代码的前缀,用' ,'隔开)
			  Ssbm VARCHAR(64) DEFAULT ( '' )
							   NULL ,	--(包含的)手术代码(手术代码的前缀,用' ,'隔开)
			  Bzlb SMALLINT NOT NULL ,	--病种类别(CP_DataCategory.Mxbh Lbbh = 7)
			  Tssz VARCHAR(64) NULL ,	--特殊设置值(如用于判断单病中的特定科室等)
			  Ssdm VARCHAR(4) DEFAULT ( '' )
							  NULL ,	--所属(的上级)代码 (表示层次关系,CP_DiseaseCFG.Bzdm)
			  Yxjl SMALLINT NOT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--备注
			  CONSTRAINT PK_CP_DiseaseCFG PRIMARY KEY ( Bzlb, Bzdm )
			)
		CREATE INDEX idx_ysdm ON CP_DiseaseCFG(Bzlb, Ysdm)
	END
go

/* ============================================================ */
/*   Table: CP_Surgery       手术代码库                           */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Surgery' ) 
	BEGIN
		CREATE TABLE CP_Surgery
			(
			  Ssdm VARCHAR(12) NOT NULL ,	--手术代码(ICD9-CM3)
			  Ysdm VARCHAR(16) NULL ,	--映射代码
			  Bzdm VARCHAR(12) NOT NULL ,	--(手术)标准代码(用户自定义代码有标准代码时，填写此字段)
			  Name VARCHAR(64) NOT NULL ,	--手术名称
			  Py VARCHAR(8) NULL ,	--拼音
			  Wb VARCHAR(8) NULL ,	--五笔
			  Bzlb VARCHAR(4) DEFAULT ( '' )
							  NULL ,	--病种类别(CP_DiseaseCFG.Bzdm, Bzlb = 701)
			  Sslb SMALLINT NULL ,	--手术类别(CP_DataCategory.Mxbh Lbbh = 8)
			  Yxjl SMALLINT NOT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--备注
			  CONSTRAINT PK_CP_Surgery PRIMARY KEY ( Ssdm )
			)
		CREATE INDEX idx_py ON CP_Surgery(Py)
		CREATE INDEX idx_wb ON CP_Surgery(Wb)
		CREATE INDEX idx_ysdm ON CP_Surgery(Ysdm)
	END
go

/* ============================================================ */
/*   Table: CP_Operation       (院内)手术操作库                     */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Operation' ) 
	BEGIN
		CREATE TABLE CP_Operation
			(
			  Ssdm VARCHAR(12) NOT NULL ,	--手术代码(ICD9-CM3)
			  Ysdm VARCHAR(16) NULL ,	--映射代码
			  Name VARCHAR(64) NOT NULL ,	--手术名称
			  Py VARCHAR(8) NULL ,	--拼音
			  Wb VARCHAR(8) NULL ,	--五笔
			  Sslb SMALLINT NULL ,	--手术类别(CP_DataCategory.Mxbh Lbbh = 8)
			  Yxjl SMALLINT NOT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--备注
			  CONSTRAINT PK_CP_Operation PRIMARY KEY ( Ssdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_Anesthesia 麻醉代码库                                 */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Anesthesia' ) 
	BEGIN
		CREATE TABLE CP_Anesthesia
			(
			  Mzdm VARCHAR(12) NOT NULL ,	--麻醉代码
			  Ysdm VARCHAR(16) NULL ,	--映射代码
			  Name VARCHAR(64) NOT NULL ,	--麻醉名称
			  Py VARCHAR(8) NULL ,	--拼音
			  Wb VARCHAR(8) NULL ,	--五笔
			  Yxjl SMALLINT NOT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--备注
			  CONSTRAINT PK_CP_Anesthesia PRIMARY KEY ( Mzdm )
			)
		CREATE INDEX idx_py ON CP_Anesthesia(Py)
		CREATE INDEX idx_wb ON CP_Anesthesia(Wb)
		CREATE INDEX idx_ysdm ON CP_Anesthesia(Ysdm)
	END
go

/* ============================================================ */
/*   Table: CP_DiagnosisOfChinese       中医诊断库                           */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DiagnosisOfChinese' ) 
	BEGIN
		CREATE TABLE CP_DiagnosisOfChinese
			(
			  Zyzddm VARCHAR(12) NOT NULL ,	--中医诊代码
			  Ysdm VARCHAR(16) NULL ,	--映射代码
			  Name VARCHAR(64) NOT NULL ,	--名称
			  Py VARCHAR(8) NULL ,	--拼音
			  Wb VARCHAR(8) NULL ,	--五笔
			  Nbfl VARCHAR(4) NULL ,	--内部分类(预留字段)
			  Bzlb VARCHAR(4) NULL ,	--病种类别(所属单病种, 预留字段)
			  Yxjl SMALLINT NOT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--备注
			  CONSTRAINT PK_CP_DiagnosisOfChinese PRIMARY KEY ( Zyzddm )
			)
		CREATE INDEX idx_py ON CP_DiagnosisOfChinese(Py)
		CREATE INDEX idx_wb ON CP_DiagnosisOfChinese(Wb)
		CREATE INDEX idx_ysdm ON CP_DiagnosisOfChinese(Ysdm)
	END
go
/* ============================================================ */
/*   Table: CP_DrugClassify	药品分类库                              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DrugClassify' ) 
	BEGIN
		CREATE TABLE CP_DrugClassify
			(
			  Fldm VARCHAR(12) NOT NULL ,	--(药品)分类代码
			  Name VARCHAR(32) NOT NULL ,	--(分类)名称
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔
			  Memo VARCHAR(16) NULL ,    	--备注
			  CONSTRAINT PK_CP_DrugClassify PRIMARY KEY ( Fldm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_DrugClassDetail	药品分类明细库                          */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DrugClassDetail' ) 
	BEGIN
		CREATE TABLE CP_DrugClassDetail
			(
			  Flmxdm VARCHAR(12) NOT NULL ,	--(药品)分类明细代码
			  Name VARCHAR(32) NOT NULL ,	--(分类明细)名称
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔
			  Fldm VARCHAR(12) NOT NULL ,	--(所属)分类名称(CP_DrugClassify.Fldm)
			  Memo VARCHAR(16) NULL ,    	--备注
			  CONSTRAINT PK_CP_DrugClassDetail PRIMARY KEY ( Flmxdm )
			)
		CREATE INDEX idx_py ON CP_DrugClassDetail(Py)
		CREATE INDEX idx_wb ON CP_DrugClassDetail(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_DosageForm	药品剂型库                              */
/*   			EMR中不需要很详细的剂型信息             */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DosageForm' ) 
	BEGIN
		CREATE TABLE CP_DosageForm
			(
			  Jxdm VARCHAR(12) NOT NULL ,	--剂型代码
			  Name VARCHAR(16) NOT NULL ,	--(剂型)名称
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔	
			  Memo VARCHAR(16) NULL ,    	--备注
			  CONSTRAINT PK_CP_DosageForm PRIMARY KEY ( Jxdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_DrugOrigin	药品来源库                              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DrugOrigin' ) 
	BEGIN
		CREATE TABLE CP_DrugOrigin
			(
			  Yplydm VARCHAR(4) NOT NULL ,	--药品来源代码
			  Name VARCHAR(16) NOT NULL ,	--(药品来源)名称
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔	
			  Memo VARCHAR(16) NULL ,    	--备注
			  CONSTRAINT PK_CP_DrugOrigin PRIMARY KEY ( Yplydm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_ClinicOfDrug	药品临床目录库                          */
/*			(从HIS中导入,EMR中不能维护)		*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_ClinicOfDrug' ) 
	BEGIN
		CREATE TABLE CP_ClinicOfDrug
			(
			  Lcxh NUMERIC(9, 0) NOT NULL ,	--临床序号
			  Ypmc VARCHAR(64) NOT NULL ,	--药品名称
			  Ywmc VARCHAR(32) NULL ,	--英文名称
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔	
			  Jxdm VARCHAR(12) NULL ,	--剂型代码(CP_DosageForm.Jxdm)
			  Ggdw VARCHAR(8) NULL ,	--规格单位(名称)
			  Ylm VARCHAR(16) NULL ,	--药理名
			  Yxjl SMALLINT NOT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(64) NULL ,	--备注
			  CONSTRAINT PK_CP_ClinicOfDrug PRIMARY KEY ( Lcxh )
			)
		CREATE INDEX idx_py ON CP_ClinicOfDrug(Py)
		CREATE INDEX idx_wb ON CP_ClinicOfDrug(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_FormatOfDrug	药品规格目录库                          */
/*			(从HIS中导入,EMR中不能维护)		*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_FormatOfDrug' ) 
	BEGIN
		CREATE TABLE CP_FormatOfDrug
			(
			  Ggxh NUMERIC(9, 0) NOT NULL ,	--规格序号
			  Lcxh NUMERIC(9, 0) NOT NULL ,	--临床序号(CP_ClinicOfDrug.Lcxh)
			  Ypmc VARCHAR(64) NOT NULL ,	--药品名称
			  Ypdm VARCHAR(12) NULL ,	--药品代码
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔	
			  Ypgg VARCHAR(32) NOT NULL ,	--药品规格
			  Jxdm VARCHAR(12) NULL ,	--剂型代码(CP_DosageForm.Jxdm)
			  Flmxdm VARCHAR(12) NOT NULL ,	--(药品)分类明细代码(CP_DrugClassDetail.Flmxdm)
			  Zxdw VARCHAR(8) NOT NULL ,	--最小单位(名称)
			  Ggdw VARCHAR(8) NOT NULL ,	--规格单位(名称)
			  Ggxs NUMERIC(12, 4) NOT NULL ,	--规格系数
			  Yplb SMALLINT NOT NULL ,	--药品类别(CP_DataCategory.Mxbh, Lbbh = 24)
			  Fysm VARCHAR(MAX) NULL ,	--服用说明
			  Cfsm VARCHAR(MAX) NULL ,	--存放说明
			  Ylm VARCHAR(16) NULL ,	--药理名
			  Yxjl SMALLINT NOT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(64) NULL ,	--备注
			  CONSTRAINT PK_CP_FormatOfDrug PRIMARY KEY ( Ggxh )
			)
		CREATE INDEX idx_ypdm ON CP_FormatOfDrug(Ypdm)
		CREATE INDEX idx_py ON CP_FormatOfDrug(Py)
		CREATE INDEX idx_wb ON CP_FormatOfDrug(Wb)
		CREATE INDEX idx_lcxh ON CP_FormatOfDrug(Lcxh)
	END
go


/* ============================================================ */
/*   Table: CP_PlaceOfDrug	药品产地目录库                          */
/*			(从HIS中导入,EMR中不能维护)		*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_PlaceOfDrug' ) 
	BEGIN
		CREATE TABLE CP_PlaceOfDrug
			(
			  Cdxh NUMERIC(9, 0) NOT NULL ,	--产地序号
			  Ggxh NUMERIC(9, 0) NOT NULL ,	--规格序号(CP_FormatOfDrug.Ggxh)
			  Lcxh NUMERIC(9, 0) NOT NULL ,	--临床序号(CP_ClinicOfDrug.Lcxh)
			  Ypmc VARCHAR(64) NOT NULL ,	--药品名称(商品名)
			  Ypdm VARCHAR(12) NULL ,	--药品代码
			  Srm VARCHAR(12) NULL ,	--(药品)输入码
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔	
			  Ypgg VARCHAR(32) NOT NULL ,	--药品规格
			  Jxdm VARCHAR(12) NULL ,	--剂型代码(CP_DosageForm.Jxdm)
			  Flmxdm VARCHAR(12) NOT NULL ,	--(药品)分类明细代码(CP_DrugClassDetail.Flmxdm)
			  Zxdw VARCHAR(8) NOT NULL ,	--最小单位(名称)
			  Ggdw VARCHAR(8) NOT NULL ,	--规格单位(名称)
			  Ggxs NUMERIC(12, 4) NOT NULL ,	--规格系数
			  Ykdw VARCHAR(8) NOT NULL ,	--药库单位(名称)
			  Ykxs NUMERIC(12, 4) NOT NULL ,	--药库系数
			  Mzdw VARCHAR(8) NOT NULL ,	--门诊单位(名称)
			  Mzxs NUMERIC(12, 4) NOT NULL ,	--门诊系数
			  Zydw VARCHAR(8) NOT NULL ,	--住院单位(名称)
			  Zyxs NUMERIC(12, 4) NOT NULL ,	--住院系数
			  Ekdw VARCHAR(8) NULL ,	--儿科单位(名称)
			  Ekxs NUMERIC(12, 4) NULL ,	--儿科系数
			  Lsj MONEY NOT NULL ,	--零售价(药库单位)
			  Mzbxbz SMALLINT NOT NULL ,	--门诊报销标志(CP_DataCategory.Mxbh, Lbbh = 25)
			  Zybxbz SMALLINT NOT NULL ,	--住院报销标志(CP_DataCategory.Mxbh, Lbbh = 25)
			  Ypxz INT NOT NULL ,	--药品性质(以二进制位表示药品性质)
							--0x01(1)	皮试(有时间限制)
							--0x02(2)	皮试(永久有效)
							--0x04(4)	贵重药品
							--0x08(8)	OTC标志
			  Tsypbz SMALLINT NOT NULL ,	--特殊药品标志(CP_DataCategory.Mxbh, Lbbh = 26)
			  Yplydm VARCHAR(4) NULL ,	--药品来源代码(CP_DrugOrigin.Yplydm)
			  Cjmc VARCHAR(64) NULL ,	--厂家名称
			  Yzglbz SMALLINT NULL ,	--医嘱管理标志(CP_DataCategory.Mxbh, Lbbh = 27)
			  Syfw SMALLINT NULL ,	--使用范围(CP_DataCategory.Mxbh, Lbbh = 28)
			  Yplb SMALLINT NOT NULL ,	--药品类别(CP_DataCategory.Mxbh, Lbbh = 24, Mxbh = 2401/2402/2403)
			  Yxjl SMALLINT NOT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(255) NULL ,	--备注
			  CONSTRAINT PK_CP_PlaceOfDrug PRIMARY KEY ( Cdxh )
			)
		CREATE INDEX idx_ypdm ON CP_PlaceOfDrug(Ypdm)
		CREATE INDEX idx_py ON CP_PlaceOfDrug(Py)
		CREATE INDEX idx_wb ON CP_PlaceOfDrug(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_UsageMapping	药品用法对应库                          */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_UsageMapping' ) 
	BEGIN
		CREATE TABLE CP_UsageMapping
			(
			  Cdxh NUMERIC(9, 0) NOT NULL ,	--产地序号(CP_PlaceOfDrug.Cdxh)
			  Yfdm VARCHAR(2) NOT NULL ,	--(药品)用法代码(CP_DrugUseage.Yfdm)
			  Pcdm VARCHAR(2) NOT NULL ,	--(药品)频次代码(YY_YZPCK.Pcdm)	
			  Ypjl NUMERIC(14, 3) NULL ,	--药品剂量
			  Zxdw VARCHAR(8) NULL ,	--最小单位(名称)(统一换算成最小单位,界面显示何种单位根据模块设置)
			  Ts INT DEFAULT ( 1 )
					 NULL ,	--天数
			  Xtbz SMALLINT NOT NULL ,	--系统标志(CP_DataCategory.Mxbh, Lbbh = 14)
			  CONSTRAINT PK_CP_UsageMapping PRIMARY KEY ( Cdxh, Xtbz )
			)
	END
go

/* ============================================================ */
/*   Table: CP_DrugNickName	药品别名库                              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DrugNickName' ) 
	BEGIN
		CREATE TABLE CP_DrugNickName
			(
			  Cdxh NUMERIC(9, 0) NOT NULL ,	--产地序号(CP_PlaceOfDrug.Cdxh)
			  ypbm VARCHAR(64) NOT NULL ,	--药品别名
			  Ypdm VARCHAR(12) NOT NULL ,	--药品(别名)代码
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔
			  Memo VARCHAR(64) NULL ,    	--备注
			  CONSTRAINT PK_CP_DrugNickName PRIMARY KEY ( Cdxh, ypbm )
			)
		CREATE INDEX idx_py ON CP_DrugNickName(Py)
		CREATE INDEX idx_wb ON CP_DrugNickName(Wb)
		CREATE INDEX idx_ypdm ON CP_DrugNickName(Ypdm)
	END
go

/* ============================================================ */
/*   Table: CP_ChargingBigItem     收费大项目库                            */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_ChargingBigItem' ) 
	BEGIN
		CREATE TABLE CP_ChargingBigItem
			(
			  Dxdm VARCHAR(12) NOT NULL ,	--大项代码
			  Name VARCHAR(16) NOT NULL ,	--项目名称
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔
			  Xtbz SMALLINT NOT NULL ,	--系统标志(CP_DataCategory.Mxbh, Lbbh = 14)
			  Xmlb SMALLINT NOT NULL ,	--项目类别(CP_DataCategory.Mxbh, Lbbh = 24)
			  Memo VARCHAR(16) NULL ,    	--备注
			  CONSTRAINT PK_CP_ChargingBigItem PRIMARY KEY ( Dxdm )
			)
		CREATE INDEX idx_py ON CP_ChargingBigItem(Py)
		CREATE INDEX idx_wb ON CP_ChargingBigItem(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_ChargingMinItem     收费小项目库                          */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_ChargingMinItem' ) 
	BEGIN
		CREATE TABLE CP_ChargingMinItem
			(
			  Sfxmdm VARCHAR(12) NOT NULL ,	--收费项目代码
			  Name VARCHAR(64) NOT NULL ,	--项目名称
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔
			  Dxdm VARCHAR(12) NOT NULL ,	--(所属)大项代码(CP_ChargingBigItem.Dxdm)
			  Xmdw VARCHAR(8) NULL ,	--项目单位(名称)
			  Xmgg VARCHAR(32) NULL ,	--项目规格
			  Xmdj MONEY NOT NULL ,	--项目单价
			  Mzbxbz SMALLINT NOT NULL ,	--门诊报销标志(CP_DataCategory.Mxbh, Lbbh = 25)
			  Zybxbz SMALLINT NOT NULL ,	--住院报销标志(CP_DataCategory.Mxbh, Lbbh = 25)
			  Xmlb SMALLINT NOT NULL ,	--项目类别(CP_DataCategory.Mxbh, Lbbh = 24)
			  Xtbz SMALLINT NOT NULL ,	--系统标志(CP_DataCategory.Mxbh, Lbbh = 14)
			  Xmxz SMALLINT NOT NULL ,	--项目性质(用二进制位表示)
							--0x01(1)	常规医嘱
							--0x02(2)	纯医嘱(文字医嘱)
			  Xskz SMALLINT NOT NULL ,	--显示控制(用二进制位表示)
							--0x01(1)	不显示频次
							--0x02(2)	不显示用量
							--0x04(4)	不打印
			  Fjxx VARCHAR(16) NULL ,	--附加信息(提供额外的处理信息,比如对应的手术代码)
			  Syfw SMALLINT NULL ,	--使用范围(CP_DataCategory.Mxbh, Lbbh = 28)
			  Yzglbz SMALLINT NULL ,	--医嘱管理标志(CP_DataCategory.Mxbh, Lbbh = 27)
			  Yxjl SMALLINT NOT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(64) NULL ,    	--备注
			  CONSTRAINT PK_CP_ChargingMinItem PRIMARY KEY ( Sfxmdm )
			)
		CREATE INDEX idx_py ON CP_ChargingMinItem(Py)
		CREATE INDEX idx_wb ON CP_ChargingMinItem(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_MinItemNick	收费小项目别名库                        */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_MinItemNick' ) 
	BEGIN
		CREATE TABLE CP_MinItemNick
			(
			  Sfxmdm VARCHAR(12) NOT NULL ,	--收费项目代码
			  Xmbm VARCHAR(64) NOT NULL ,	--项目别名
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔
			  Memo VARCHAR(64) NULL ,    	--备注
			  CONSTRAINT PK_CP_MinItemNick PRIMARY KEY ( Sfxmdm, Xmbm )
			)
		CREATE INDEX idx_py ON CP_MinItemNick(Py)
		CREATE INDEX idx_wb ON CP_MinItemNick(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_AdviceGroup	成套医嘱库                          */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_AdviceGroup' ) 
	BEGIN
		CREATE TABLE CP_AdviceGroup
			(
			  Ctyzxh NUMERIC(9, 0) IDENTITY
								   NOT NULL ,	--成套医嘱序号
			  PahtDetailID varchar(50) NOT NULL, --配置节点ID
			  Name VARCHAR(32) NOT NULL ,	--(成套医嘱)名称
			  Ljdm VARCHAR(12),--临床路径代码(CP_ClinicalPath.Ljdm)
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔
			  Ksdm VARCHAR(12) NULL ,	--(所属)科室代码(YY_KSDMK.Ksdm)
			  Bqdm VARCHAR(12) NULL ,	--(所属)病区代码(YY_BQDMK.Bqdm)
			  Ysdm VARCHAR(6) NULL ,	--(所属)医生代码(CP_Employee.zgdm)
			  Syfw SMALLINT NULL ,	--使用范围(CP_DataCategory.Mxbh, Lbbh = 29)
			  Memo VARCHAR(16) NULL ,    	--备注
			  CONSTRAINT PK_CP_AdviceGroup PRIMARY KEY ( Ctyzxh )
			)
		CREATE INDEX idx_py ON CP_AdviceGroup(Py)
		CREATE INDEX idx_wb ON CP_AdviceGroup(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_AdviceGroupDetail	成套医嘱明细库              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_AdviceGroupDetail' ) 
	BEGIN
		CREATE TABLE CP_AdviceGroupDetail
			(
			  Ctmxxh NUMERIC(9, 0) IDENTITY
								   NOT NULL ,	--成套明细序号
			  Ctyzxh NUMERIC(9, 0) NOT NULL ,	--(所属)成套医嘱序号(CP_AdviceGroup.Ctyzxh)
			  Yzbz SMALLINT NULL ,	--医嘱标志(CP_DataCategory.Mxbh, Lbbh = 27)
			  Fzxh NUMERIC(12, 0)  null,	--分组序号(每组的第一条医嘱的序号)
			  Fzbz SMALLINT NULL ,	--分组标志(CP_DataCategory.Mxbh, Lbbh = 35)
			  Cdxh NUMERIC(9, 0) NOT NULL ,	--产地序号(CP_PlaceOfDrug.Cdxh)
			  Ggxh NUMERIC(9, 0) NOT NULL ,	--规格序号(CP_FormatOfDrug.Ggxh)
			  Lcxh NUMERIC(9, 0) NOT NULL ,	--临床序号(CP_ClinicOfDrug.Lcxh)
			  Ypdm VARCHAR(12) NOT NULL ,	--药品代码(or收费小项目代码or临床项目代码,具体是哪种代码根据项目类别来判断)(CP_PlaceOfDrug.Ypdm/CP_ChargingMinItem.Sfxmdm/CP_LCChargingItem.Lcxmdm)
			  Ypmc VARCHAR(64) NULL ,	--药品(项目)名称(CP_PlaceOfDrug.Name/CP_ChargingMinItem.Name)
			  Xmlb SMALLINT NOT NULL ,	--项目类别(CP_DataCategory.Mxbh, Lbbh = 24)
			  Zxdw VARCHAR(8) NULL ,	--最小单位(CP_PlaceOfDrug.Zxdw)
			  Ypjl NUMERIC(14, 3) NULL ,	--药品剂量
			  Jldw VARCHAR(8) NULL ,	--剂量单位(显示用)(CP_PlaceOfDrug.Ggdw/CP_PlaceOfDrug.Zydw)
			  Dwxs NUMERIC(12, 4) NULL ,	--单位系数(规格系数或住院系数,注意规格系数要存它的分数
			  Dwlb SMALLINT NULL ,	--单位类别(CP_DataCategory.Mxbh, Lbbh = 30)
			  Yfdm VARCHAR(2) NULL ,	--(药品)用法代码(CP_DrugUseage.Yfdm)
			  Pcdm VARCHAR(2) DEFAULT ( '' )
							  NULL ,	--频次代码(YY_YZPCK.Pcdm)
			  Zxcs INT DEFAULT ( 1 )
					   NULL ,	--执行次数
			  Zxzq INT DEFAULT ( 1 )
					   NULL ,	--执行周期
			  Zxzqdw SMALLINT DEFAULT ( -1 )
							  NULL ,	--执行周期单位(CP_DataCategory.Mxbh, Lbbh = 34)
			  Zdm CHAR(7) DEFAULT ( '' )
						  NULL ,	--周代码
			  Zxsj VARCHAR(64) NULL ,	--(频次的)执行时间
			  Zxts INT NULL ,	--执行天数(为出院带药保留)
			  Ypzsl NUMERIC(14, 3) NULL ,	--药品总数量(为出院带药保留,使用剂量单位)
			  Ztnr VARCHAR(64) NULL ,	--嘱托内容
			  Yzlb SMALLINT NOT NULL ,	--医嘱类别(CP_DataCategory.Mxbh, Lbbh = 31)
			  CONSTRAINT PK_CP_AdviceGroupDetail PRIMARY KEY ( Ctmxxh )
			)
	END
go

/* ============================================================ */
/*   Table: CP_LCChargingItem	临床收费项目库                          */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_LCChargingItem' ) 
	BEGIN
		CREATE TABLE CP_LCChargingItem
			(
			  Lcxmdm VARCHAR(12) NOT NULL ,	--临床项目代码
			  Name VARCHAR(64) NOT NULL ,	--(临床项目)名称
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔
			  Srm VARCHAR(12) NULL ,	--(项目)输入码
			  Xmdj MONEY NULL ,	--项目单价
			  Zxmdm VARCHAR(12) NULL ,	--主项目代码
			  Yxjl SMALLINT NOT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Xmlb SMALLINT NULL ,	--项目类别(CP_DataCategory.Mxbh, Lbbh = 24)
			  Sjdm VARCHAR(12) NULL ,	--(所属)上级代码
			  Xmjb SMALLINT NULL ,	--(临床)项目级别(从高到低1~4,用来建立层次关系;只有4级才有详细信息)
			  CONSTRAINT PK_CP_LCChargingItem PRIMARY KEY ( Lcxmdm )
			)
		CREATE INDEX idx_py ON CP_LCChargingItem(Py)
		CREATE INDEX idx_wb ON CP_LCChargingItem(Wb)
	END
go

/* ============================================================ */
/*   Table: CP_LCChargingItemMap	临床收费项目对应库              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_LCChargingItemMap' ) 
	BEGIN
		CREATE TABLE CP_LCChargingItemMap
			(
			  Lcxmdm VARCHAR(12) NOT NULL ,	--(所属)临床项目代码(CP_LCChargingItem.Lcxmdm)
			  Sfxmdm VARCHAR(12) NOT NULL ,	--收费项目代码(CP_ChargingMinItem.Sfxmdm)
			  Xmsl NUMERIC(10, 2) NOT NULL ,	--项目数量
			  Dxdm VARCHAR(12) NULL ,	--(所属)大项代码(CP_ChargingBigItem.Dxdm)
			  Jlwz INT NULL ,	--记录位置(0:只有一条; 1:开始; (1,1000):中间; 1000:结束)
			  Memo VARCHAR(16) NULL ,    	--备注
			  CONSTRAINT PK_CP_LCChargingItemMap PRIMARY KEY
				( Lcxmdm, Sfxmdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_DrugUseage	药品用法库                              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DrugUseage' ) 
	BEGIN
		CREATE TABLE CP_DrugUseage
			(
			  Yfdm VARCHAR(2) NOT NULL ,	--(药品)用法代码
			  Name VARCHAR(16) NOT NULL ,	--(用法)名称
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔
			  Ctsy SMALLINT NOT NULL ,	--成套使用(只用于成套医嘱)(CP_DataCategory.Mxbh Lbbh = 0)
			  Zdfz SMALLINT NOT NULL ,	--自动分组(CP_DataCategory.Mxbh Lbbh = 0)
			  Yflb SMALLINT NOT NULL ,	--用法类别(CP_DataCategory.Mxbh Lbbh = 45)
			  Yxjl SMALLINT NOT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,    	--备注
			  CONSTRAINT PK_CP_DrugUseage PRIMARY KEY ( Yfdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_Dosage2Useage	剂型用法对应库                          */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Dosage2Useage' ) 
	BEGIN
		CREATE TABLE CP_Dosage2Useage
			(
			  Jxdm VARCHAR(12) NOT NULL ,	--剂型代码(CP_DosageForm.Jxdm)
			  Yfjh VARCHAR(255) NOT NULL ,	--(对应的)用法集合(以'用法代码1','用法代码2'的形式组合)
			  Memo VARCHAR(16) NULL ,    	--备注
			  CONSTRAINT PK_CP_Dosage2Useage PRIMARY KEY ( Jxdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_AdviceFrequency	医嘱频次库                              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_AdviceFrequency' ) 
	BEGIN
		CREATE TABLE CP_AdviceFrequency
			(
			  Pcdm VARCHAR(2) NOT NULL ,	--频次代码
			  Name VARCHAR(16) NOT NULL ,	--(频次)名称
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔	
			  Zxcs INT NOT NULL ,	--执行次数(每个周期执行的次数)
			  Zxzq INT DEFAULT ( 1 )
					   NOT NULL ,	--执行周期
			  Zxzqdw SMALLINT NOT NULL ,	--执行周期单位(单位为周时,执行周期表示1周中允许执行的天数)(CP_DataCategory.Mxbh, Lbbh = 34)
			  Zdm CHAR(7) DEFAULT ( '' )
						  NOT NULL ,	--周代码(指定在一周中的哪几天执行,以对应于星期中的某天的数组合而成,从1-7分别表示星期一到日)
			  Zxsj VARCHAR(64) NULL ,	--执行时间(医嘱每天执行的时间点,24小时制,精确到小时,用'0'补足2位,多个时以','隔开)
			  zbbz SMALLINT NULL ,	--自备标志(CP_DataCategory.Mxbh Lbbh = 0)
			  Yzglbz SMALLINT NULL ,	--医嘱管理标志(CP_DataCategory.Mxbh, Lbbh = 27)
			  Yxjl SMALLINT NOT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,    	--备注
			  CONSTRAINT PK_CP_AdviceFrequency PRIMARY KEY ( Pcdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_OperationDept	手术科室库                     	        */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_OperationDept' ) 
	BEGIN
		CREATE TABLE CP_OperationDept
			(
			  Ssksdm VARCHAR(12) NOT NULL ,	--手术科室代码
			  Name VARCHAR(32) NOT NULL ,	--(手术科室)名称
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔
			  Memo VARCHAR(16) NULL ,    	--备注
			  CONSTRAINT PK_CP_OperationDept PRIMARY KEY ( Ssksdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_AnesthesiaDept	麻醉科室库                     	        */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_AnesthesiaDept' ) 
	BEGIN
		CREATE TABLE CP_AnesthesiaDept
			(
			  Mzksdm VARCHAR(12) NOT NULL ,	--麻醉科室代码
			  Name VARCHAR(32) NOT NULL ,	--(麻醉科室)名称
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔
			  Memo VARCHAR(16) NULL ,    	--备注
			  CONSTRAINT PK_CP_AnesthesiaDept PRIMARY KEY ( Mzksdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_Oper2Anest	手术麻醉科室对应库              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Oper2Anest' ) 
	BEGIN
		CREATE TABLE CP_Oper2Anest
			(
			  Ssksdm VARCHAR(12) NOT NULL ,	--手术科室代码(CP_OperationDept.Ssksdm)
			  Mzksdm VARCHAR(12) NOT NULL ,	--麻醉科室代码(CP_AnesthesiaDept.Mzksdm)
			  CONSTRAINT PK_CP_Oper2Anest PRIMARY KEY ( Ssksdm, Mzksdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_OperRoom (手术)手术房间                             */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_OperRoom' ) 
	BEGIN
		CREATE TABLE CP_OperRoom
			(
			  Ssfjdm VARCHAR(12) NOT NULL ,	--手术房间代码
			  Name VARCHAR(16) NOT NULL ,	--(手术房间)名称
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔
			  Ssksdm VARCHAR(12) NOT NULL ,	--(所属)手术科室代码(CP_OperationDept.Ssksdm)
			  Memo VARCHAR(16) NULL ,    	--备注
			  CONSTRAINT PK_CP_OperRoom PRIMARY KEY ( Ssfjdm, Ssksdm )
			)
	END
go


/* ============================================================ */
/*   Table: CP_Bed	床位代码库                               */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Bed' ) 
	BEGIN
		CREATE TABLE CP_Bed
			(
			  Cwdm VARCHAR(12) NOT NULL ,	--床位代码
			  Bqdm VARCHAR(12) NOT NULL ,	--病区代码(YY_BQDMK.Bqdm)
			  Ksdm VARCHAR(12) NOT NULL ,	--科室代码(YY_KSDMK.Ksdm)
			  Fjh VARCHAR(16) NULL ,	--房间号
			  Zyysdm VARCHAR(6) NULL ,	--住院医师代码(CP_Employee.zgdm)
			  Zzysdm VARCHAR(6) NULL ,	--主治医师代码(CP_Employee.zgdm)
			  Zrysdm VARCHAR(6) NULL ,	--主任医师代码(CP_Employee.zgdm)
			  Cwlx SMALLINT NOT NULL ,	--床位类型(CP_DataCategory.Mxbh Lbbh = 11)
			  Bzlx SMALLINT NOT NULL ,	--编制类型(CP_DataCategory.Mxbh Lbbh = 12)
			  Zcbz SMALLINT NOT NULL ,	--占床标志(CP_DataCategory.Mxbh Lbbh = 13)
			  Txbz SMALLINT NOT NULL ,	--特需标志(CP_DataCategory.Mxbh Lbbh = 0)
			  Syxh NUMERIC(9, 0) NULL ,	--首页序号(住院流水号)
			  Hissyxh NUMERIC(9, 0) NULL ,	--HIS首页序号
			  Ybqdm VARCHAR(12) NULL ,	--原病区代码(YY_BQDMK.Bqdm)
			  Ycwdm VARCHAR(12) NULL ,	--原床位代码(BL_BCDMK.Cwdm)
			  Yksdm VARCHAR(12) NULL ,	--原科室代码(YY_KSDMK.Ksdm)
			  Jcbz SMALLINT NULL ,	--借床标志(CP_DataCategory.Mxbh Lbbh = 0)
			  Yxjl SMALLINT NOT NULL ,	--有效记录(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(16) NULL ,	--备注
			  CONSTRAINT PK_CP_Bed PRIMARY KEY ( Cwdm, Bqdm )
			)
	END
go

/* ============================================================ */
/*   Table: CP_InPatient (住院)病人首页库                             */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_InPatient' ) 
	BEGIN
		CREATE TABLE CP_InPatient
			(
			  Syxh NUMERIC(9, 0) IDENTITY
								 NOT NULL ,	--首页序号(住院流水号)
			  Hissyxh NUMERIC(9, 0) NOT NULL ,	--HIS首页序号(HIS中病人每次住院的唯一标识,对应HIS中的Syxh)
			  Mzhm VARCHAR(24) NULL ,	--门诊号码
			  Bahm VARCHAR(32) NOT NULL ,	--病案号码
			  Zyhm VARCHAR(24) NOT NULL ,	--住院号码
			  Glzyhm VARCHAR(24) NULL ,	--关联住院号码(用来标识同一病人多次入院、住院号不一样的情况,目前是根据社保卡好关联)
			  Hzxm VARCHAR(32) NOT NULL ,	--患者姓名
			  Py VARCHAR(8) NULL ,	--拼音(病人姓名缩写)
			  Wb VARCHAR(8) NULL ,	--五笔(病人姓名缩写)
			  Brxz VARCHAR(4) NULL ,	--病人性质(即 医疗付款方式)(CP_DictionaryDetail.Mxdm, lbdm = '1')
			  Brly VARCHAR(4) NULL ,	--病人来源(CP_DictionaryDetail.Mxdm, lbdm = '2')
			  Rycs INT NOT NULL ,	--入院次数
			  Brxb VARCHAR(4) NOT NULL ,	--病人性别(CP_DictionaryDetail.Name, lbdm = '3')
			  Csrq CHAR(10) NOT NULL ,	--出生日期
			  Brnl INT NULL ,	--病人年龄(实际的年龄,格式为YYYYMMDD,YYYY表示年的数值,MM表示月的数值,DD表示日的数值)
			  Xsnl VARCHAR(16) NULL ,	--显示年龄(根据实际情况显示的年龄,如XXX年,XX月XX天,XX天)
			  Sfzh VARCHAR(18) NULL ,	--身份证号
			  Hyzk VARCHAR(4) NULL ,	--婚姻状况(CP_DictionaryDetail.Mxdm, lbdm = '4')
			  Zydm VARCHAR(4) NULL ,	--职业代码(CP_DictionaryDetail.Mxdm, lbdm = '41')
			  Ssdm VARCHAR(10) NULL ,	--(出生地)省市代码(YY_DQDMK.dqdm, dqlb = 1000)
			  Qxdm VARCHAR(10) NULL ,	--(出生地)区县代码(YY_DQDMK.dqdm, dqlb = 1001)
			  Mzdm VARCHAR(4) NULL ,	--民族代码(CP_DictionaryDetail.Mxdm, lbdm = '42')
			  Gjdm VARCHAR(4) NULL ,	--国籍代码(CP_DictionaryDetail.Mxdm, lbdm = '43')
			  Jgssdm VARCHAR(10) NULL ,	--籍贯省市代码(YY_DQDMK.dqdm, dqlb = 1000)
			  Jgqxdm VARCHAR(10) NULL ,	--籍贯区县代码(YY_DQDMK.dqdm, dqlb = 1001)
			  Gzdw VARCHAR(64) NULL ,	--工作单位(暂缺)
			  Dwdz VARCHAR(64) NULL ,	--单位地址
			  Dwdh VARCHAR(16) NULL ,	--单位电话
			  Dwyb VARCHAR(16) NULL ,	--单位邮编
			  Hkdz VARCHAR(64) NULL ,	--户口地址
			  Hkdh VARCHAR(16) NULL ,	--户口电话
			  Hkyb VARCHAR(16) NULL ,	--户口邮编
			  Dqdz VARCHAR(255) NULL ,	--当前地址
			  Lxrm VARCHAR(32) NULL ,	--联系人名
			  Lxgx VARCHAR(4) NULL ,	--联系关系(CP_DictionaryDetail.Mxdm, lbdm = '44')
			  Lxdz VARCHAR(255) NULL ,	--联系地址
			  Lxdw VARCHAR(64) NULL ,	--联系(人)单位
			  Lxdh VARCHAR(16) NULL ,	--联系电话
			  Lxyb VARCHAR(16) NULL ,	--联系邮编
			  Bscsz VARCHAR(64) NULL ,	--病史陈述者
			  Sbkh VARCHAR(32) NULL ,	--社保卡号
			  Bxkh VARCHAR(32) NULL ,	--保险卡号
			  Qtkh VARCHAR(32) NULL ,	--其他卡号(存磁卡号)
			  Ryqk VARCHAR(4) NULL ,	--入院情况(入院时病情, CP_DictionaryDetail.Mxdm, lbdm = '5')
			  Ryks VARCHAR(12) NULL ,	--入院科室(YY_KSDMK.Ksdm)
			  Rybq VARCHAR(12) NULL ,	--入院病区(YY_BQDMK.Bqdm)
			  Rycw VARCHAR(12) NULL ,	--入院床位(CP_Bed.Cwdm)
			  Ryrq CHAR(19) NOT NULL ,	--入院日期
			  Rqrq CHAR(19) NULL ,	--入区日期
			  Ryzd VARCHAR(50) NULL ,	--入院诊断(CP_Diagnosis.zddm)
			  Cyks VARCHAR(12) NULL ,	--出院科室(YY_KSDMK.Ksdm)
			  Cybq VARCHAR(12) NULL ,	--出院病区(YY_BQDMK.Bqdm)
			  Cycw VARCHAR(12) NULL ,	--出院床位(CP_Bed.Cwdm)
			  Cqrq CHAR(19) NULL ,	--出区日期
			  Cyrq CHAR(19) NULL ,	--出院日期
			  Cyzd VARCHAR(12) NULL ,	--出院诊断(CP_Diagnosis.zddm)
			  Zyts NUMERIC(6, 1) NULL ,	--住院天数
			  Mzzd VARCHAR(12) NULL ,	--门诊诊断(CP_Diagnosis.zddm)
			  Mzzdzy VARCHAR(12) NULL ,	--门诊诊断(中医)(CP_DiagnosisOfChinese.Zyzddm)
			  Mzzhzy VARCHAR(12) NULL ,	--门诊症候(中医)(CP_DiagnosisOfChinese.Zyzddm)
			  Fbjq VARCHAR(16) NULL ,	--发病节气
			  Rytj VARCHAR(4) NULL ,	--入院途径(CP_DictionaryDetail.Mxdm, lbdm = '6')
			  Cyfs VARCHAR(4) NULL ,	--出院方式(CP_DictionaryDetail.Mxdm, lbdm = '15')	
			  Mzys VARCHAR(6) NULL ,	--门诊医生(CP_Employee.zgdm)
			  Zyys VARCHAR(6) NULL ,	--住院医生(CP_Employee.zgdm)
			  Zzysdm VARCHAR(6) NULL ,	--主治医师代码(CP_Employee.zgdm)
			  Zrysdm VARCHAR(6) NULL ,	--主任医师代码(CP_Employee.zgdm)
			  Whcd VARCHAR(4) NULL ,	--文化程度(CP_DictionaryDetail.Mxdm, lbdm = '25')
			  Jynx NUMERIC(10, 2) NULL ,	--(受)教育年限(单位:年)
			  Zjxy VARCHAR(32) NULL ,	--宗教信仰
			  Brzt SMALLINT NOT NULL ,	--病人状态(CP_DataCategory.Mxbh, Lbbh = 15)
			  Wzjb VARCHAR(2) NULL ,	--危重级别(CP_DictionaryDetail.Mxdm, lbdm = '53')
			  Hljb VARCHAR(12) NULL ,	--护理级别(CP_ChargingMinItem.Sfxmdm, Xmlb = 2409)
			  Zdbr SMALLINT NULL ,	--重点病人(CP_DataCategory.Mxbh, Lbbh = 0)
			  Yexh SMALLINT NOT NULL ,	--婴儿序号(从1开始，0表示不是婴儿)
			  Mqsyxh NUMERIC(9, 0) NULL ,	--母亲首页序号(CP_InPatient.Syxh, yexh = 0)
			  Ybdm VARCHAR(4)   NULL ,	--医保代码(CP_MedicareInfo.ybdm)
			  Ybde MONEY NOT NULL ,	--医保定额
			  Brlx VARCHAR(2) NULL ,	--病人类型(CP_DictionaryDetail.Mxdm, lbdm = '45')
			  Pzlx VARCHAR(12) NULL ,	--凭证类型(代码)(CP_MedicareInfo.pzlx)
			  Pzlxmc VARCHAR(16) NULL ,	--凭证类型名称(CP_MedicareInfo.pzlxmc)
			  Pzh VARCHAR(64) NULL ,	--凭证号
			  Czyh VARCHAR(6) NULL ,	--操作员(YY_CZRYK.czydm)
			  Xxh VARCHAR(64) NULL ,   --X线号
			  Gxrq CHAR(19) NULL ,	--更新日期
			  Memo VARCHAR(64) NULL ,	--备注	
			  CONSTRAINT PK_CP_InPatient PRIMARY KEY ( Syxh )
			)
		ALTER TABLE CP_InPatient ADD CONSTRAINT idx_syxh UNIQUE (Hissyxh)
		CREATE INDEX idx_zyhm ON CP_InPatient(Zyhm)
		CREATE INDEX idx_sbkh ON CP_InPatient(Sbkh)
	END
go

/* ============================================================ */
/*   Table: CP_BedInfo	病人床位信息库                          */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_BedInfo' ) 
	BEGIN
		CREATE TABLE CP_BedInfo
			(
			  Cwxxxh NUMERIC(12, 0) IDENTITY
									NOT NULL ,	--床位信息序号
			  Syxh NUMERIC(9, 0) NOT NULL ,	--首页序号(CP_InPatient.Syxh)
			  Ksdm VARCHAR(12) NOT NULL ,	--(原)科室代码(YY_KSDMK.Ksdm)
			  Bqdm VARCHAR(12) NOT NULL ,	--(原)病区代码(YY_BQDMK.Bqdm)
			  Cwdm VARCHAR(12) NOT NULL ,	--(原)床位代码(CP_Bed.Cwdm)
			  Ksrq CHAR(19) NOT NULL ,	--开始日期(分配到原床位的时间)
			  Jsrq CHAR(19) NULL ,	--结束日期(离开原床位的时间)
			  Xksdm VARCHAR(12) NULL ,	--新科室代码(转科或转床后的科室, YY_KSDMK.Ksdm)
			  Xbqdm VARCHAR(12) NULL ,	--新病区代码(转科或转床后的病区, YY_BQDMK.Bqdm)
			  Xcwdm VARCHAR(12) NULL ,	--新床位代码(转科或转床后的床位, CP_Bed.Cwdm)
			  Isdqcw SMALLINT NOT NULL ,	--是当前床位(CP_DataCategory.Mxbh, Lbbh = 0)
			  CONSTRAINT PK_CP_BedInfo PRIMARY KEY NONCLUSTERED ( Cwxxxh )
			)
		CREATE CLUSTERED INDEX idx_syxh ON CP_BedInfo(Syxh)
	END
go

/* ============================================================ */
/*   Table: CP_TempOrder	临时医嘱库                             */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_TempOrder' ) 
	BEGIN
		CREATE TABLE CP_TempOrder
			(
			  Lsyzxh NUMERIC(12, 0) IDENTITY
									NOT NULL ,	--临时医嘱序号
			  Syxh NUMERIC(9, 0) NOT NULL ,	--首页序号(CP_InPatient.Syxh)
			  Fzxh NUMERIC(12, 0) NOT NULL ,	--分组序号(每组的第一条医嘱的序号)
			  Fzbz SMALLINT NOT NULL ,	--分组标志(表明该条记录在同组记录中的位置, CP_DataCategory.mxxh, Lbbh = 35)
			  Bqdm VARCHAR(12) NOT NULL ,	--病区代码(YY_BQDMK.Bqdm)
			  Ksdm VARCHAR(12) NOT NULL ,	--科室代码(YY_KSDMK.Ksdm)
			  Lrysdm VARCHAR(6) NOT NULL ,	--录入医生代码(CP_Employee.zgdm, zglb = 400,401)
			  Lrrq CHAR(19) NOT NULL ,	--录入日期
			  Shczy VARCHAR(16) NULL ,	--审核操作员(代码)(因为审核/执行都是HIS的护士,所以EMR的职工表要与HIS一致)
			  Shrq CHAR(19) NULL ,	--审核日期
			  Zxczy VARCHAR(16) NULL ,	--执行操作员(代码)(医嘱具体的执行护士)
			  Zxrq CHAR(19) NULL ,	--执行日期(医嘱具体的执行时间,和领药无关)
			  Qxysdm VARCHAR(6) NULL ,	--取消医生代码(CP_Employee.zgdm, zglb = 400,401)
			  Qxrq CHAR(19) NULL ,	--取消日期
			  Ksrq CHAR(19) NULL ,	--(医嘱)开始日期
			  Cdxh NUMERIC(9, 0) NOT NULL ,	--产地序号(CP_PlaceOfDrug.Cdxh)
			  Ggxh NUMERIC(9, 0) NOT NULL ,	--规格序号(CP_FormatOfDrug.Ggxh)
			  Lcxh NUMERIC(9, 0) NOT NULL ,	--临床序号(CP_ClinicOfDrug.Lcxh)
			  Ypdm VARCHAR(12) NOT NULL ,	--药品代码(or收费小项目代码or临床项目代码,具体是哪种代码根据项目类别来判断)(CP_PlaceOfDrug.Ypdm/CP_ChargingMinItem.Sfxmdm/CP_LCChargingItem.Lcxmdm)
			  Ypmc VARCHAR(64) NULL ,	--药品(项目)名称(CP_PlaceOfDrug.Name/CP_ChargingMinItem.Name)
			  Ypgg VARCHAR(32) NULL ,	--药品规格(CP_PlaceOfDrug.Ypgg)
			  Xmlb SMALLINT NOT NULL ,	--项目类别(CP_DataCategory.Mxbh, Lbbh = 24)
			  Zxdw VARCHAR(8) NULL ,	--最小单位(CP_PlaceOfDrug.Zxdw)
			  Ypjl NUMERIC(14, 3) NULL ,	--药品剂量
			  Jldw VARCHAR(8) NULL ,	--剂量单位(显示用)(CP_PlaceOfDrug.Ggdw/CP_PlaceOfDrug.Zydw)
			  Dwxs NUMERIC(12, 4) NULL ,	--单位系数(规格系数或住院系数,注意规格系数要存它的分数
			  Dwlb SMALLINT NULL ,	--单位类别(当前剂量使用的是何种单位,CP_DataCategory.Mxbh, Lbbh = 30)
			  Yfdm VARCHAR(2) NULL ,	--(药品)用法代码(CP_DrugUseage.fydm)
			  Pcdm VARCHAR(2) DEFAULT ( '' )
							  NULL ,	--频次代码(YY_YZPCK.Pcdm)
			  Zxcs INT DEFAULT ( 1 )
					   NULL ,	--执行次数
			  Zxzq INT DEFAULT ( 1 )
					   NULL ,	--执行周期
			  Zxzqdw SMALLINT DEFAULT ( -1 )
							  NULL ,	--执行周期单位(CP_DataCategory.Mxbh, Lbbh = 34)
			  Zdm CHAR(7) DEFAULT ( '' )
						  NULL ,	--周代码
			  Zxsj VARCHAR(64) NULL ,	--(频次的)执行时间
			  Zxts INT NULL ,	--执行天数(为出院带药保留)
			  Ypzsl NUMERIC(14, 3) NULL ,	--药品总数量(为出院带药保留,使用剂量单位)
			  Zxks VARCHAR(12) NULL ,	--项目的执行科室(目前只对从申请单插入的项目有效)
			  Ztnr VARCHAR(64) NULL ,	--嘱托内容
			  Yzlb SMALLINT NOT NULL ,	--医嘱类别(CP_DataCategory.Mxbh, Lbbh = 31)
			  Yzzt SMALLINT NOT NULL ,	--医嘱状态(CP_DataCategory.Mxbh, Lbbh = 32)
			  Tsbj SMALLINT NOT NULL ,	--特殊标记(以二进制位表示)
							--0x01(1)	自备药
							--0x02(2)	输液
							--0x04(4)	打印
							--0x08(8)	手术停长期医嘱
							--0x10(16)	需要医保审批
			  Ybsptg SMALLINT NULL ,	--医保审批通过(CP_DataCategory.Mxbh Lbbh = 0)
			  Ybspbh VARCHAR(32) NULL ,	--医保审批编号
			  Tzxh NUMERIC(12, 0) NULL ,	--停止序号(CP_LongOrder.Cqyzxh)
			  Tzrq CHAR(19) NULL ,	--停止日期	
			  Sqdxh NUMERIC(12, 0) NULL ,	--(医技)申请单序号(等处理医技申请接口时再处理!!!)
			  Yznr VARCHAR(255) NULL ,	--医嘱内容(显示在界面上的医嘱内容)
			  Tbbz SMALLINT NULL ,	--同步标志(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(64) NULL ,	--备注
			  Djfl VARCHAR(4) NULL ,	--单据分类(兼容护理) --wxg add, 2009-1-8
			  Bxbz INT NULL ,	--必须标准（1.是0.否）
			  Ctmxxh NUMERIC(9, 0) ,	--成套明细序号
			  CONSTRAINT PK_CP_TempOrder PRIMARY KEY NONCLUSTERED ( Lsyzxh )
			)
		CREATE CLUSTERED INDEX idx_syxh ON CP_TempOrder(Syxh) WITH FILLFACTOR=90
		CREATE INDEX idx_fzxh ON CP_TempOrder(Fzxh)
	END
go

/* ============================================================ */
/*   Table: CP_LongOrder (病区)长期医嘱                         */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_LongOrder' ) 
	BEGIN
		CREATE TABLE CP_LongOrder
			(
			  Cqyzxh NUMERIC(12, 0) IDENTITY
									NOT NULL ,	--长期医嘱序号
			  Syxh NUMERIC(9, 0) NOT NULL ,	--首页序号(CP_InPatient.Syxh)
			  Fzxh NUMERIC(12, 0) NOT NULL ,	--分组序号(每组的第一条医嘱的序号)
			  Fzbz SMALLINT NOT NULL ,	--分组标志(表明该条记录在同组记录中的位置, CP_DataCategory.mxxh, Lbbh = 35)
			  Bqdm VARCHAR(12) NOT NULL ,	--病区代码(YY_BQDMK.Bqdm)
			  Ksdm VARCHAR(12) NOT NULL ,	--科室代码(YY_KSDMK.Ksdm)
			  Lrysdm VARCHAR(6) NOT NULL ,	--录入医生代码(CP_Employee.zgdm, zglb = 400,401)
			  Lrrq CHAR(19) NOT NULL ,	--录入日期
			  Shczy VARCHAR(16) NULL ,	--审核操作员(代码)(CP_Employee.zgdm, zglb = 402)(因为审核/执行都是HIS的护士,所以EMR的职工表要与HIS一致)
			  Shrq CHAR(19) NULL ,	--审核日期
			  Zxczy VARCHAR(16) NULL ,	--执行操作员(代码)(医嘱具体的执行护士)(CP_Employee.zgdm, zglb = 402)
			  Zxrq CHAR(19) NULL ,	--执行日期(医嘱具体的执行时间,和领药无关)
			  Qxysdm VARCHAR(6) NULL ,	--取消医生代码(CP_Employee.zgdm, zglb = 400,401)
			  Qxrq CHAR(19) NULL ,	--取消日期
			  tzysdm VARCHAR(6) NULL ,	--停止医生代码(CP_Employee.zgdm, zglb = 400,401)
			  Tzrq CHAR(19) NULL ,	--停止日期
			  tzshhs VARCHAR(6) NULL ,	--停止审核护士(代码)(CP_Employee.zgdm, zglb = 402)
			  tzshrq CHAR(19) NULL ,	--停止审核日期
			  Ksrq CHAR(19) NULL ,	--(医嘱)开始日期                                   --开始时间
			  Mq SMALLINT DEFAULT ( 0 )
						  NULL ,	--明起(从明天开始执行)
			  Cdxh NUMERIC(9, 0) NOT NULL ,	--产地序号(CP_PlaceOfDrug.Cdxh)
			  Ggxh NUMERIC(9, 0) NOT NULL ,	--规格序号(CP_FormatOfDrug.Ggxh)
			  Lcxh NUMERIC(9, 0) NOT NULL ,	--临床序号(CP_ClinicOfDrug.Lcxh)
			  Ypdm VARCHAR(12) NOT NULL ,	--药品代码(or收费小项目代码or临床项目代码,具体是哪种代码根据项目类别来判断)(CP_PlaceOfDrug.Ypdm/CP_ChargingMinItem.Sfxmdm/CP_LCChargingItem.Lcxmdm)
			  Ypmc VARCHAR(64) NULL ,	--药品(项目)名称(CP_PlaceOfDrug.Name/CP_ChargingMinItem.Name)    ---项目名称
			  Ypgg VARCHAR(32) NULL ,	--药品规格(CP_PlaceOfDrug.Ypgg)
			  Xmlb SMALLINT NOT NULL ,	--项目类别(CP_DataCategory.Mxbh, Lbbh = 24)              --类型
			  Zxdw VARCHAR(8) NULL ,	--最小单位(CP_PlaceOfDrug.Zxdw)
			  Ypjl NUMERIC(14, 3) NULL ,	--药品剂量                                          --剂量
			  Jldw VARCHAR(8) NULL ,	--剂量单位(显示用)(CP_PlaceOfDrug.Ggdw/CP_PlaceOfDrug.Zydw) --单位
			  Dwxs NUMERIC(12, 4) NULL ,	--单位系数(规格系数或住院系数,注意规格系数要存它的分数
			  Dwlb SMALLINT NULL ,	--单位类别(CP_DataCategory.Mxbh, Lbbh = 30)
			  Yfdm VARCHAR(2) NULL ,	--(药品)用法代码(CP_DrugUseage.Yfdm)                  --用法
			  Pcdm VARCHAR(2) DEFAULT ( '' )
							  NULL ,	--频次代码(YY_YZPCK.Pcdm)                        --频次
			  Zxcs INT DEFAULT ( 1 )
					   NULL ,	--执行次数
			  Zxzq INT DEFAULT ( 1 )
					   NULL ,	--执行周期
			  Zxzqdw SMALLINT DEFAULT ( -1 )
							  NULL ,	--执行周期单位(CP_DataCategory.Mxbh, Lbbh = 34)
			  Zdm CHAR(7) DEFAULT ( '' )
						  NULL ,	--周代码
			  Zxsj VARCHAR(64) NULL ,	--(频次的)执行时间
			  Zxks VARCHAR(12) NULL ,	--项目的执行科室(保留字段)
			  Ztnr VARCHAR(64) NULL ,	--嘱托内容
			  Yzlb SMALLINT NOT NULL ,	--医嘱类别(CP_DataCategory.Mxbh, Lbbh = 31)
			  Yzzt SMALLINT NOT NULL ,	--医嘱状态(CP_DataCategory.Mxbh, Lbbh = 32)
			  Tsbj SMALLINT NOT NULL ,	--特殊标记(以二进制位表示)
							--0x01(1)	自备药
							--0x02(2)	输液
							--0x04(4)	打印
							--0x08(8)	手术停长期医嘱(录入手术医嘱时，用户选择“停”则在该手术医嘱嘱托中加上“停长期医嘱”)
							--0x10(16)	需要医保审批
			  Ybsptg SMALLINT NULL ,	--医保审批通过(CP_DataCategory.Mxbh Lbbh = 0)
			  Ybspbh VARCHAR(32) NULL ,	--医保审批编号
			  Yztzyy SMALLINT NULL ,	--医嘱停止(或取消)原因(CP_DataCategory.Mxbh, Lbbh = 33)	
			  Ssyzxh NUMERIC(12, 0) NULL ,	--手术医嘱序号(当前医嘱类型是术后医嘱时有效,对应临嘱中的手术医嘱序号)
			  Yznr VARCHAR(255) NULL ,	--医嘱内容(显示在界面上的医嘱内容)
			  Tbbz SMALLINT NULL ,	--同步标志(CP_DataCategory.Mxbh Lbbh = 0)
			  Memo VARCHAR(64) NULL ,	--备注	
			  Bxbz INT NULL ,	--必须标准（1.是0.否）
			  Djfl VARCHAR(4) NULL ,	--单据分类(兼容护理) --wxg add, 2009-1-8
			  Ctmxxh NUMERIC(9, 0) ,	--成套明细序号
			  CONSTRAINT PK_CP_LongOrder PRIMARY KEY NONCLUSTERED ( Cqyzxh )
			)
		CREATE CLUSTERED INDEX idx_syxh ON CP_LongOrder(Syxh) WITH FILLFACTOR=90
		CREATE INDEX idx_fzxh ON CP_LongOrder(Fzxh)
	END
go


/* ============================================================ */
/*   Table: CP_ClinicalPath	临床路径				*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_ClinicalPath' ) 
	BEGIN
		CREATE TABLE CP_ClinicalPath
			(
			  Ljdm VARCHAR(12) NOT NULL ,	--临床路径代码
			  Name VARCHAR(64) NOT NULL ,	--(路径)名称
			  Py VARCHAR(8) NULL ,	--拼音	  
			  Ljms VARCHAR(255) NOT NULL ,   --路径描述
			  Zgts	 NUMERIC(9,1)				not null, --总共天数
			  Jcfy	money			  not null,--均次费用
			  Vesion NUMERIC(5,1)				not null ,--版本
			  Cjsj CHAR(19) NOT NULL ,	--创建时间
			  Syks varchar(12) not null,--适应科室
			  Shsj CHAR(19) NULL ,	--审核时间
			  Shys VARCHAR(6) NULL ,--审核医师
			  Yxjl INT NOT NULL , --是否有效(0、无效1有效.2停止.3审核)
			  WorkFlowXML VARCHAR(8000) --工作流XML
			  IsPathCut	NULL,			--是否裁剪产生(0否，1是)（默认值0）	  
			  CONSTRAINT PK_CP_ClinicalPath PRIMARY KEY ( Ljdm )
			)
	END
GO


/* ============================================================ */
/*   Table: CP_PathDetail	临床路径明细					修改：方全伟  2011-4-21 修改内容：添加字段PrePahtDetailID，NextPahtDetailID，ActivityType删除主键							*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_PathDetail' ) 
	BEGIN
		CREATE TABLE CP_PathDetail
			(                    
			  PahtDetailID  varchar(50) NOT NULL ,	--明细ID
			  PrePahtDetailID	  varchar(50) NOT NULL ,	--前置节点
			  NextPahtDetailID	  varchar(50) NOT NULL ,	--后置节点	  
			  ActivityType	  varchar(50) NOT NULL ,	--节点类型	  
			  Ljdm VARCHAR(12) NOT NULL ,	--临床路径代码(CP_ClinicalPath.Ljdm)
			  Ts INT  NULL ,	--天数
			  Ljmc VARCHAR(255) NOT NULL ,--节点名称
			  LJs	varchar(255) null	,--提示
			  Bqms VARCHAR(MAX) NULL ,	--病情描述
			  Zljh int NULL 	--诊疗计划(CP_ClinicalEmrTemplate.ID)
			  --CONSTRAINT PK_CP_PathDetail PRIMARY KEY ( PahtDetailID )
			)
	END
go



/* ============================================================ */
/*   Table: CP_PathCondition	临床路径纳入条件         				*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_PathCondition' ) 
	BEGIN
		CREATE TABLE CP_PathCondition
			(
			  Tjdm VARCHAR(12) NOT NULL , --条件代码
			  Ljdm VARCHAR(12) NOT NULL ,--临床路径代码(CP_ClinicalPath.Ljdm)
			  Tjmc VARCHAR(255) NOT NULL , --条件描述
			  TJlb INT NOT NULL , --条件类别(1：纳入条件0 退出条件)
			  Yxjl INT NOT NULL , --路径是否有效
			  CONSTRAINT PK_CP_PathCondition PRIMARY KEY ( Tjdm )
			)
		CREATE INDEX idx_Ljdm ON CP_PathCondition(Ljdm)
		CREATE INDEX idx_TJlb ON CP_PathCondition(TJlb);
        CREATE INDEX idx_Tjdm ON CP_PathCondition(Tjdm);
	END
go


/* ============================================================ */
/*   Table: CP_InPathPatient	纳入临床路径病人         				*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_InPathPatient' ) 
	BEGIN
		CREATE TABLE CP_InPathPatient
			(
			  Id NUMERIC(9, 0) IDENTITY
							   NOT NULL ,	--序号
			  Syxh NUMERIC(9, 0) NOT NULL ,	--病人序号(CP_InPatient.Syxh)
			  Ljdm VARCHAR(12) NOT NULL ,	--临床路径代码(CP_ClinicalPath.Ljdm)
			  Cwys VARCHAR(6) NOT NULL ,--床位医师
			  Jrsj CHAR(19) NOT NULL ,	--进入路径时间
			  Tcsj CHAR(19) NULL ,--退出时间
			  Wcsj CHAR(19) NULL ,--完成时间
			  Ljts int not null ,--当前步骤天数
			  Ljzt INT NOT NULL ,--路径状态(1进入,2.退出,3完成)
			  CONSTRAINT PK_CP_InPathPatient PRIMARY KEY ( Id )
			)
	END
go

/* ============================================================ */
/*   Table: CP_InPathPatientCondition	病人纳入条件记录        */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_InPathPatientCondition' ) 
	BEGIN
		CREATE TABLE CP_InPathPatientCondition
			(
			  Id NUMERIC(9, 0) IDENTITY
							   NOT NULL ,	--序号
			  Ljxh numeric(9,0) NOT NULL ,  --路径序号(CP_InPathPatient.Id)
			  Syxh NUMERIC(9, 0) NOT NULL ,	--病人序号(CP_InPatient.Syxh)
			  Tjdm VARCHAR(255)  NULL , --条件代码(用，分开)
			  Memo VARCHAR(MAX) NULL ,--额外条件
			  CONSTRAINT PK_CP_InPathPatientCondition PRIMARY KEY ( Id )
			)
			create index idx_CP_InPathPatientCondition_Ljxh on  CP_InPathPatientCondition(Ljxh)
	END
go
	


/* ============================================================ */
/*   Table: CP_PathExecuteInfo	临床路径执行记录库         		*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_PathExecuteInfo' ) 
	BEGIN
		CREATE TABLE CP_PathExecuteInfo
			(
			  Id numeric(9,0) IDENTITY
					 NOT NULL ,	--序号
			  Ljxh numeric(9,0) NOT NULL ,  --路径序号(CP_InPathPatient.Id)
			  Ljcz INT NOT NULL ,	--路径操作(1100创建1104退出)
			  Czyy VARCHAR(MAX)  NULL ,--退出原因
			  Czys VARCHAR(6) NOT NULL ,--床位医师
			  Czsj CHAR(19) NULL ,--退出时间
			  CONSTRAINT PK_CP_PathExecuteInfo PRIMARY KEY ( Id )
			)
	END
go



/* ============================================================ */
/*   Table: CP_PathVariation	临床路径变异表								*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_PathVariation' ) 
	BEGIN
		CREATE TABLE CP_PathVariation
			(
			  Bydm VARCHAR(12) NOT NULL ,--变异编码
			  Bymc VARCHAR(64) NOT NULL ,--变异名称
			  Byms VARCHAR(255) NOT NULL ,--变异描述
			  Yxjl INT NOT NULL ,--有效记录
			  Py VARCHAR(8) NULL ,    	--拼音
			  CONSTRAINT PK_CP_PathVariation PRIMARY KEY ( Bydm )
			)
	END
go


/* ============================================================ */
/*   Table: CP_VariationToPath	临床路径代码与路径变异表对应    */
/* ============================================================ */
if not exists ( select  1
                from    sysobjects
                where   Name = 'CP_VariationToPath' ) 
    begin
        create table CP_VariationToPath
            (
              Id numeric(12, 0) identity
                                not null ,
              Ljdm varchar(12) not null ,--路径代码
              ActivityId varchar(50) not null ,--路径结点ID
              Bydm varchar(12) not null ,--变异编码
              Yxjl int not null
                       default 1 ,--有效记录
              Create_Time varchar(19)
                not null
                default convert(varchar(19), getdate(), 120) ,	--创建时间
              Create_User varchar(10) ,
              Cancel_Time varchar(19) ,
              Cancel_User varchar(10) ,
              constraint PK_CP_VariationToPath primary key ( Id )
            )
    end
go


/* ============================================================ */
/*   Table: CP_VariantRecords	临床路径变异记录表				*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_VariantRecords' ) 
	BEGIN
		CREATE TABLE CP_VariantRecords
			(
			  Id numeric(12,0) IDENTITY
					 NOT NULL ,	--序号
			  Ljxh NUMERIC(9, 0) NOT NULL ,	--路径序号(CP_InPatient.Syxh)
			  Syxh NUMERIC(9, 0) NOT NULL,--首页序号
			  Ljdm VARCHAR(12) NOT NULL ,	--临床路径代码(CP_ClinicalPath.Ljdm)
			  
			  Mxdm VARCHAR(50) NOT NULL ,	--路径明细子节点(PahtDetailID的子节点)
			  Ypdm VARCHAR(12) NOT NULL ,	--药品代码(or收费小项目代码or临床项目代码,具体是哪种代码根据项目类别来判断)(CP_PlaceOfDrug.Ypdm/CP_ChargingMinItem.Sfxmdm/CP_LCChargingItem.Lcxmdm)
			  Bylb VARCHAR(12) NOT NULL ,	--变异类别(1200医嘱1201护理1203诊疗计划,1204退出)
			  Bylx VARCHAR(12) NOT NULL ,   --变异类型（1300，必选末执行，1301，新增，1302，表单,1303,退出）
			  Bynr VARCHAR(MAX),	--变异内容
			  Bydm VARCHAR(12) NOT NULL ,--变异编码
			  Byyy VARCHAR(MAX),	--变异原因
			  Bysj CHAR(19) NOT NULL ,--变异时间
			  PahtDetailID VARCHAR(50) NOT NULL ,	  --路径明细(CP_PathDetail.PahtDetailID)	  
			  CONSTRAINT PK_CP_VariantRecords PRIMARY KEY ( Id )
			)
			create index idx_CP_VariantRecords_Ljxh on  CP_VariantRecords(Ljxh)
	END
go


/* ============================================================ */
/*   Table: CP_ReportType	临床路径医技信息大类表							*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_ReportType' ) 
	BEGIN
		CREATE TABLE CP_ReportType
			(
			  Lbbh INT NOT NULL ,	--(数据)类别编号
			  Name VARCHAR(80) NOT NULL ,	--(分类)名称
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔
			  Memo VARCHAR(64) NULL ,    	--备注
			  CONSTRAINT PK_CP_ReportType PRIMARY KEY ( Lbbh )
			)
	END
go

/* ============================================================ */
/*   Table: CP_ReportItem	临床路径医技信息项目表							*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_ReportItem' ) 
	BEGIN
		CREATE TABLE CP_ReportItem
			(
			  Mxbh INT NOT NULL ,	--明细编号(作为数据分类代码,组成形式为'类别序号'+'2位的流水号', 例: 101, 102, 201, 205, 1201)
			  Name VARCHAR(80) NOT NULL ,	--分类名称
			  Lbbh SMALLINT NOT NULL ,	--类别编号(CP_ReportType.Lbbh)
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔
			  Memo VARCHAR(16) NULL ,    	--备注
			  CONSTRAINT PK_CP_ReportItem PRIMARY KEY ( Mxbh )
			)
	END
go

/* ============================================================ */
/*   Table: CP_PatientReport	临床路径医技信息表							*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_PatientReport' ) 
	BEGIN
		CREATE TABLE CP_PatientReport
			(
			  Id INT IDENTITY
					 NOT NULL ,--
			  Syxh NUMERIC(9, 0) NOT NULL ,--病人序号(CP_InPatient.Syxh)
			  Name VARCHAR(12) NOT NULL ,--病患姓名
			  PatNoOfHis NUMERIC(9, 0) NOT NULL ,--HIS NO
			  HospitalNo VARCHAR(12) NULL ,--医院代码(CP_Hospital.Yydm)
			  ReportCatalog INT NOT NULL ,--报告大类(CP_ReportType.Lbbh)
			  ReportType INT NOT NULL ,--报告类型代码(CP_ReportItem.Mxbh)
			  ReportName VARCHAR(80) NOT NULL ,--报告类型名称
			  ReportNo VARCHAR(80) NULL ,--报告编号
			  SubmitDate DATETIME NOT NULL ,--执行日期
			  ReleaseDate DATETIME NULL ,--
			  HadRead VARCHAR(1) NULL ,--
			  Result VARCHAR(80) NULL ,--结果
			  CONSTRAINT PK_CP_PatientReport PRIMARY KEY ( Id )
			)
	END
go

/* ============================================================ */
/*   Table: CP_AttendanceType	临床路径护理信息大类表							*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_AttendanceType' ) 
	BEGIN
		CREATE TABLE CP_AttendanceType
			(
			  Lbbh INT NOT NULL ,	--(数据)类别编号
			  Name VARCHAR(80) NOT NULL ,	--(分类)名称
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔
			  Memo VARCHAR(64) NULL ,    	--备注
			  CONSTRAINT PK_CP_AttendanceTypee PRIMARY KEY ( Lbbh )
			)
	END
go

/* ============================================================ */
/*   Table: CP_AttendanceItem	临床路径护理信息项目表							*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_AttendanceItem' ) 
	BEGIN
		CREATE TABLE CP_AttendanceItem
			(
			  Mxbh INT NOT NULL ,	--明细编号(作为数据分类代码,组成形式为'类别序号'+'2位的流水号', 例: 101, 102, 201, 205, 1201)
			  Name VARCHAR(80) NOT NULL ,	--分类名称
			  Lbbh SMALLINT NOT NULL ,	--类别编号(CP_CPathCareType.Lbbh)
			  Py VARCHAR(8) NULL ,    	--拼音
			  Wb VARCHAR(8) NULL ,    	--五笔
			  Memo VARCHAR(16) NULL ,    	--备注
			  CONSTRAINT PK_CP_AttendanceItem PRIMARY KEY ( Mxbh )
			)
	END
go

/* ============================================================ */
/*   Table: CP_AttendanceInfo	临床路径护理信息表							*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_AttendanceInfo' ) 
	BEGIN
		CREATE TABLE CP_AttendanceInfo
			(
			  Id INT IDENTITY
					 NOT NULL ,--
			  CareCatalog INT NOT NULL ,--护理大类(CP_CPathCareType.Lbbh)
			  CareType INT NOT NULL ,--护理类型代码(CP_CPathCareItem.Mxbh)
			  CareName VARCHAR(80) NOT NULL ,--护理类型名称
			  CareNo VARCHAR(12) NULL ,--护理编号
			  Syxh NUMERIC(9, 0) NOT NULL ,--病人序号(CP_InPatient.Syxh)
			  PatNoOfHis NUMERIC(9, 0) NOT NULL ,--HIS NO
			  HospitalNo VARCHAR(12) NULL ,--医院代码(CP_Hospital.Yydm)
			  NAME VARCHAR(12) NOT NULL ,--病患姓名
			  SubmitDate DATETIME NOT NULL ,--执行日期
			  ReleaseDate DATETIME NULL ,--
			  Result VARCHAR(80) NULL ,--护理内容
			  CONSTRAINT PK_CP_AttendanceInfo PRIMARY KEY ( Id )
			)
	END
go

/* ============================================================ */
/*   Table: CP_ClinicalDiagnosis	临床路径病种			*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_ClinicalDiagnosis' ) 
	BEGIN
		CREATE TABLE CP_ClinicalDiagnosis
			(
			  Ljdm VARCHAR(12) NOT NULL ,	--临床路径代码
			  Bzdm VARCHAR(12) NOT NULL ,   --(诊断代码CP_Diagnosis.zddm)
		  Bzmc VARCHAR(64) NOT NULL ,   --(诊断名称CP_Diagnosis.Name)
			  CONSTRAINT PK_CP_ClinicalDiagnosis PRIMARY KEY ( Ljdm,Bzdm)
			)
	END
GO

/* ============================================================ */
/*   Table: CP_PhysicalSignInfo  (病区)病人体诊明细库                     */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_PhysicalSignInfo' ) 
   BEGIN
		create table CP_PhysicalSignInfo 
		(
			Syxh      numeric(9, 0)   NOT NULL, --首页序号
			Tzxh      numeric(12,0)		  not null, --体诊序号
			Zlrq	  char(8)		  not null,	--测量日期
			Lrrq      char(16)         not null, --录入日期
			Clsj      char(16)         not null, --测量时间 
			Tw		  numeric(5,2)	  null,		--体温数量
			Mb		  integer		  null,		--脉搏数量
			Hx		  integer		  null,		--呼吸数量
			Xy		  varchar(16)		  null,		--血压数量
			Xl		  varchar(16)		  null,		--心率
			Memo	  varchar(24)		  null,		--备用数量 
			Memo2 	  varchar(24) 		  null,		--说明2(用于显示下半部分的补充信息 如:不升)  
			Wljw 	numeric(5,2) 		null,		--物理降温 
			Qbxl 	varchar(16) 		null,		--起搏心率
			Rghx 	varchar(16) 		null,		--人工呼吸
			Kb 		varchar(16) 		null,		--口表
			Yb 		varchar(16) 		null,		--腋表
			Gw 		varchar(16) 		null,		--肛温
			Cjsj	varchar(24) 		null,		--采集时间，新表单专用
			constraint PK_CP_PhysicalSignInfo primary key(Tzxh, Clsj)
		)
 END
GO

/* ============================================================ */
/*   Table: 临床路径文书模板	CP_ClinicalEmrTemplate    */
/*   						                                */
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_ClinicalEmrTemplate')
begin
	
	create table CP_ClinicalEmrTemplate
	(
		ID			numeric(9, 0)	 identity not null,	--记录序号
		Name		varchar(64)		 not null,	--模板名称
		Valid		int				not null,	--有效纪录
		Content		Varchar(max)	not null,	--病历内容
		SortID		varchar(12)			 null,	--模板分类类别(备用)
		Memo		varchar(255)		null,		--备注
		constraint PK_CP_ClinicalEmrTemplate primary key(ID)
	)
end
go

/* ============================================================ */
/*   Table: CP_InPatientPathEnForce	临床路径执行记录			*/
/* ============================================================ */
if not exists ( select  1
                from    sysobjects
                where   Name = 'CP_InPatientPathEnForce' ) 
    begin
        create table CP_InPatientPathEnForce
            (
              Syxh numeric(9, 0) not null ,	--首页序号(CP_InPatient.Syxh)
              Ljxh numeric(9, 0) not null ,  --路径序号(CP_InPathPatient.Id)
              Ljdm varchar(12) not null ,	--临床路径代码
              EnFroceXml varchar(8000) not null ,--路径执行记录
              Content1 varchar(10) null ,
              Content2 varchar(10) null ,
              Content3 varchar(10) null ,
              constraint PK_CP_InPatientPathEnForce primary key ( Syxh )
            )
        create index idx_CP_InPatientPathEnForce_Ljxh on  CP_InPatientPathEnForce(Ljxh)
    end
go

/* ============================================================ */
/*   Table:CP_AppConfig	应用设置                       				*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   name = 'CP_AppConfig' ) 
	BEGIN
		CREATE TABLE CP_AppConfig
			(
			  Configkey VARCHAR(32) NOT NULL ,--设置键,唯一(不要使用','字符)
			  Name VARCHAR(64) NOT NULL ,	--设置的名称
			  Value VARCHAR(MAX) NOT NULL ,	--设置值,
			  Descript VARCHAR(255) NOT NULL ,	--设置描述
			  ParamType INT NOT NULL ,	--参数类型(0 variant, 1 string, 2 int, 3 double, 4 bool, 5 xml, 6 color, 7 configset 配置集合)
			  Cfgkeyset VARCHAR(1024) NULL ,	--组内配置键值集合(仅type=7时有意义,最多31个,组内配置可以是另一个组配置
			  Design VARCHAR(255) NULL ,	--动态设置类(保存在设置模块内部)
			  ClientFlag SMALLINT NOT NULL ,	--参数设置级别(0 无法设置用户级 1可以设置用户级)
			  Hide SMALLINT NOT NULL ,	--隐藏标志,无法使用程序设置(0 无效, 1有效=隐藏)
			  Valid SMALLINT NOT NULL ,	--0 无效, 1 有效
			  CONSTRAINT PK_CP_AppConfig PRIMARY KEY ( Configkey )
			)
	END
go

/* ============================================================ */
/*   Table: CP_LogException     异常记录                        */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   name = 'CP_LogException' ) 
	BEGIN
		CREATE TABLE CP_LogException
			(
			  ID INT IDENTITY ,--模块登录者ID
			  Messages VARCHAR(8000) NOT NULL,--内容
			  Module_Name VARCHAR(255) ,--模块名称
			  HostName VARCHAR(255) ,--HostName
			  MACADDR VARCHAR(255)  ,--MAC地址
			  Client_ip VARCHAR(255)  ,--机器Ip地址
			  Create_time DATETIME NOT NULL
								   DEFAULT GETDATE() ,--创建时间
			  Create_user VARCHAR(6)  --登录者ID
			)
	END
go

/* ============================================================ */
/*   Table: CP_ClinicalPath_Log	临床路径修改记录				*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_ClinicalPath_Log' ) 
	BEGIN
		CREATE TABLE CP_ClinicalPath_Log
			(
			  ID NUMERIC(9, 0) IDENTITY ,--
			  Ljdm VARCHAR(12) NOT NULL ,	--临床路径代码
			  Modify_User VARCHAR(6) NOT NULL ,--CP_Employee.Zgdm
			  Modify_Time VARCHAR(19)
				DEFAULT CONVERT(VARCHAR(19), GETDATE(), 120)
				NOT NULL ,
			  CONSTRAINT PK_CP_ClinicalPath_Log PRIMARY KEY ( ID )
			)
	END
GO


-------------------------------------------------------------------------------权限管理
/* ============================================================ */
/*   Table: PE_Role    角色表                     */
/*                     */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'PE_Role' ) 
	BEGIN
		CREATE TABLE PE_Role
			(
				RoleCode varchar(10) NOT NULL,--角色编码
				RoleName varchar(100) NOT NULL,--角色名称
			  CONSTRAINT PK_PE_Role PRIMARY KEY ( [RoleCode] ASC)
			)
	END

/* ============================================================ */
/*   Table: PE_RoleFun    角色功能表                     */
/*                  */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'PE_RoleFun' ) 
	BEGIN
		CREATE TABLE PE_RoleFun
			(
				RoleCode varchar(10) NOT NULL,--角色代码
				FunCode varchar(100) NOT NULL,--功能代码
			  CONSTRAINT PK_PE_RoleFun PRIMARY KEY ( RoleCode,FunCode)
			)
	END
/* ============================================================ */
/*   Table: PE_Fun    功能表										 */
/*                    */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'PE_Fun' ) 
	BEGIN
		CREATE TABLE PE_Fun
			(
				FunCode varchar(10) NOT NULL,--功能代码
				FunName varchar(100) NOT NULL,--功能名称
				FunCodeFather varchar(10)  NULL,--父级功能代码
				FunURL varchar(100)  NULL,--路径地址
			  CONSTRAINT PK_PE_Fun PRIMARY KEY ( FunCode )
			)
	END
/* ============================================================ */
/*   Table: PE_UserRole    用户角色表                     */
/*                      */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'PE_UserRole' ) 
	BEGIN
		CREATE TABLE PE_UserRole
			(
				UserID varchar(6) NOT NULL,--用户ID(CP_Employee.zgdm)
				RoleCode varchar(100) NOT NULL,--角色代码(PE_Role.RoleCode)
			  CONSTRAINT PK_PE_UserRole PRIMARY KEY ( UserID ,
				RoleCode )
			)
	END


-------------------------------------------------------------------------------
/* ============================================================ */
/*   Table: CP_QCProblem     问题登记					*/
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_QCProblem')--问题登记
begin
	CREATE TABLE CP_QCProblem
	(
		Wtxh		int identity not null,	--问题序号
		Syxh		int			 not null, --首页序号
		Wtzt		int			 not null default 0,--0-登记,1-答复-2挂起-4关闭问题
		Ljdm		varchar(12)  not null,--路径代码
		Wtnr		varchar(600) null, --问题内容
		Dfnr		varchar(600) null,--回复内容
		Shnr		varchar(600) null,--审核内容
		Zrys	    varchar(6)   null,	--医生代码(住院医生代码)
		Djrq		datetime DEFAULT getdate(),--登记日期
		Djry		varchar(6)	 not null,--登记人员
		Dfrq	    datetime	 null,--回复日期
		Dfys		varchar(6)   null,--回复医生
		Shrq		datetime	 null,--审核日期
		Shry		varchar(6)   null,--审核人员
		Zfrq		datetime null,--作废日期
		Zfry		varchar(6)  NULL--作废人员
		constraint PK_CP_QCProblem primary key (Wtxh)	
	)
end
go

/* ============================================================ */
/*   Table: CP_AdviceSuitCategory	医嘱套餐类别                              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
                FROM    sysobjects
                WHERE   Name = 'CP_AdviceSuitCategory' ) 
    BEGIN
        CREATE TABLE CP_AdviceSuitCategory
            (
              CategoryId		VARCHAR(50) 	NOT NULL ,	--套餐类别序号
              NAME			    VARCHAR(32)		NOT NULL ,	--(医嘱套餐类别)名称
              ParentID			VARCHAR(50)		NULL ,--父节点
              Py			    VARCHAR(8)		NULL ,    	--拼音
              Wb				VARCHAR(8)		NULL ,    	--五笔
			  Zgdm				VARCHAR(6)		NULL ,	--职工代码(录入人员代码)
              AddTime			VARCHAR(20)		NULL, --录入时间
              Yxjl				SMALLINT		NULL,--有效记录
              Memo				VARCHAR(50)		NULL ,   --备注
              constraint PK_CP_AdviceSuitCategory primary key (CategoryId)	
            )
    END
go

/* ============================================================ */
/*   Table: CP_AdviceSuit	医嘱套餐                              */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
                FROM    sysobjects
                WHERE   Name = 'CP_AdviceSuit' ) 
    BEGIN
        CREATE TABLE CP_AdviceSuit
            (
              Ctyzxh NUMERIC(9, 0) IDENTITY
                                   NOT NULL ,	--套餐序号
			  --PahtDetailID varchar(50) NOT NULL, --配置节点ID
              Name VARCHAR(32) NOT NULL ,	--(医嘱套餐)名称
              CategoryId VARCHAR(50) NOT NULL, --套餐类别序号(CP_AdviceSuitType.Typexh)
              Py VARCHAR(8) NULL ,    	--拼音
              Wb VARCHAR(8) NULL ,    	--五笔
			  Zgdm VARCHAR(6)  NULL ,	--职工代码(录入人员代码)
              Ksdm VARCHAR(12) NULL ,	--(所属)科室代码(YY_KSDMK.Ksdm)
              Bqdm VARCHAR(12) NULL ,	--(所属)病区代码(YY_BQDMK.Bqdm)
              Ysdm VARCHAR(6) NULL ,	--(所属)医生代码(CP_Employee.zgdm)
              Syfw SMALLINT NULL ,	--使用范围(CP_DataCategory.Mxbh, Lbbh = 29)
              Memo VARCHAR(16) NULL ,    	--备注
			  OrderNum INT NOT NULL ,--排序字段
			  UserReason1 varchar(100),--使用原因一
              UserReason2 varchar(100),--使用原因二
              UserReason3 varchar(100),--使用原因三
              CONSTRAINT PK_CP_AdviceSuit PRIMARY KEY ( Ctyzxh )
            )
        CREATE INDEX idx_py ON CP_AdviceSuit(Py)
        CREATE INDEX idx_wb ON CP_AdviceSuit(Wb)
    END
go

/* ============================================================ */
/*   Table: CP_AdviceSuitDetail	医嘱套餐明细库                          */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
                FROM    sysobjects
                WHERE   Name = 'CP_AdviceSuitDetail' ) 
    BEGIN
        CREATE TABLE CP_AdviceSuitDetail
            (
              Ctmxxh NUMERIC(9, 0) IDENTITY
                                   NOT NULL ,	--医嘱套餐明细序号
              Ctyzxh NUMERIC(9, 0) NOT NULL ,	--(所属)医嘱套餐序号(CP_AdviceSuit.Ctyzxh)
              Yzbz SMALLINT NULL ,	--医嘱标志(CP_DataCategory.Mxbh, Lbbh = 27)
			  Fzxh NUMERIC(12, 0)  null,	--分组序号(每组的第一条医嘱的序号)
              Fzbz SMALLINT NULL ,	--分组标志(CP_DataCategory.Mxbh, Lbbh = 35)
              Cdxh NUMERIC(9, 0) NOT NULL ,	--产地序号(CP_PlaceOfDrug.Cdxh)
              Ggxh NUMERIC(9, 0) NOT NULL ,	--规格序号(CP_FormatOfDrug.Ggxh)
              Lcxh NUMERIC(9, 0) NOT NULL ,	--临床序号(CP_ClinicOfDrug.Lcxh)
              Ypdm VARCHAR(12) NOT NULL ,	--药品代码(or收费小项目代码or临床项目代码,具体是哪种代码根据项目类别来判断)(CP_PlaceOfDrug.Ypdm/CP_ChargingMinItem.Sfxmdm/CP_LCChargingItem.Lcxmdm)
              Ypmc VARCHAR(64) NULL ,	--药品(项目)名称(CP_PlaceOfDrug.Name/CP_ChargingMinItem.Name)
              Xmlb SMALLINT NOT NULL ,	--项目类别(CP_DataCategory.Mxbh, Lbbh = 24)
              Zxdw VARCHAR(8) NULL ,	--最小单位(CP_PlaceOfDrug.Zxdw)
              Ypjl NUMERIC(14, 3) NULL ,	--药品剂量
              Jldw VARCHAR(8) NULL ,	--剂量单位(显示用)(CP_PlaceOfDrug.Ggdw/CP_PlaceOfDrug.Zydw)
              Dwxs NUMERIC(12, 4) NULL ,	--单位系数(规格系数或住院系数,注意规格系数要存它的分数
              Dwlb SMALLINT NULL ,	--单位类别(CP_DataCategory.Mxbh, Lbbh = 30)
              Yfdm VARCHAR(2) NULL ,	--(药品)用法代码(CP_DrugUseage.Yfdm)
              Pcdm VARCHAR(2) DEFAULT ( '' )
                              NULL ,	--频次代码(YY_YZPCK.Pcdm)
              Zxcs INT DEFAULT ( 1 )
                       NULL ,	--执行次数
              Zxzq INT DEFAULT ( 1 )
                       NULL ,	--执行周期
              Zxzqdw SMALLINT DEFAULT ( -1 )
                              NULL ,	--执行周期单位(CP_DataCategory.Mxbh, Lbbh = 34)
              Zdm CHAR(7) DEFAULT ( '' )
                          NULL ,	--周代码
              Zxsj VARCHAR(64) NULL ,	--(频次的)执行时间
              Zxts INT NULL ,	--执行天数(为出院带药保留)
              Ypzsl NUMERIC(14, 3) NULL ,	--药品总数量(为出院带药保留,使用剂量单位)
              Ztnr VARCHAR(64) NULL ,	--嘱托内容
              Yzlb SMALLINT NOT NULL ,	--医嘱类别(CP_DataCategory.Mxbh, Lbbh = 31)
			  Yznr VARCHAR(255) NULL ,	--医嘱内容(显示在界面上的医嘱内容)
			 OrderNum INT NOT NULL ,--排序字段
			 Mzdm VARCHAR(12) NOT NULL ,	--麻醉代码CP_Anesthesia.Mzdm
              CONSTRAINT PK_CP_AdviceSuitDetail PRIMARY KEY ( Ctmxxh )
            )
    END
go




/* ============================================================ */
/*   Table: CP_Areas	地区代码                               */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Areas' ) 
	BEGIN
		create table CP_Areas
		(
			Dqdm		varchar(10)		not null,	--地区代码
			Name		varchar(64)		not null,	--地区名称
			Py			varchar(8)		null    ,	--拼音
			Wb			varchar(8)		null    ,	--五笔
			Dqlb		smallint		not null,	--地区类别(YY_SJLBMXK.mxbh lbbh = 10)
			Ssdqdm		varchar(10)		null    ,	--所属的地区代码(YY_DQDMK.dqdm)
			Ssdqmc		varchar(32)		null    ,	--所属的地区名称
			Memo		varchar(32)	null    ,	--备注
			constraint PK_CP_Areas primary key (Dqdm)
		)
	END

	create index idx_py on CP_Areas(Py)
	go
	create index idx_wb on CP_Areas(Wb)
	go



/* ============================================================ */
/*   Table: CP_Dictionary     字典分类库                         */
/*          保存代码字典分类的名称和说明,用户不可维护           */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Dictionary' ) 
Begin
	create table CP_Dictionary
	(
		Lbdm		varchar(2)		not null,	--(字典)类别代码
		Name		varchar(32)		not null,	--(分类)名称
		Py			varchar(8)		null    ,	--拼音
		Wb			varchar(8)		null    ,	--五笔
		Memo		varchar(32)	null    ,	--备注
		constraint PK_CP_Dictionary primary key(Lbdm)
	)
end
go

/* ============================================================ */
/*   Table: CP_Dictionary_detail       字典分类明细库            	*/
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_Dictionary_detail' ) 
Begin
	create table CP_Dictionary_detail  
	(
		Mxdm		varchar(4)		not null,	--明细代码
		Name		varchar(32)		not null,	--名称
		Py			varchar(8)		null	,	--拼音
		Wb			varchar(8)		null	,	--五笔
		Lbdm		varchar(2)		not null,	--(字典)类别代码(CP_Dictionary.lbdm)
		Yxjl		smallint		null	,	--有效记录(CP_DataCategoryDetail.mxbh lbbh = 0)
		Memo		varchar(32)	null	,	--备注
		constraint PK_CP_Dictionary_detail primary key(Lbdm, Mxdm)
	)
end

go

/* ============================================================ */
/*   Table: CP_VitalSignsRecord	   生命体征记录表               */
/* ============================================================ */
if not exists ( select  1
                from    sysobjects
                where   name = 'CP_VitalSignsRecord' ) 
    begin
        create table CP_VitalSignsRecord
            (
              Jlxh numeric(9, 0) identity ,                   --记录序号（自动生成）
              Zyhm varchar(24) not null ,	                 --住院号码(病历号)
              Ljxh numeric(9, 0) not null ,	--路径序号(CP_InPatient.Syxh)
              Ljdm varchar(12) not null ,	--临床路径代码（CP_ClinicalPath.Ljdm)
              ActivityId varchar(50) not null ,--路径结点ID
              ActivityChildId varchar(50) not null ,--路径子节点ID(真正执行结点KEY值)             
              Clrq varchar(10) not null ,                    --测量日期期（格式2010-01-01）
              Clsj varchar(5) check ( len(Clsj) = 5 )
                              not null ,  --测量时间（格式：01:02）
              Sjd char(2) not null ,                        --测量时间段
              Hzztdm int not null ,                            --患者状态代码，(CP_DataCategoryDetail.lbbh=59)
              Hzzt varchar(50) ,                            --患者状态（五种）
              Hztw varchar(20) ,--患者体温
              Clfsdm int ,  --体温测量方式代码(CP_DataCategoryDetail.lbbh=48)4801-液温、4801-口温、4802-肛温
              Clfs varchar(50) ,  --体温测量方式名称
              Fzcsdm int default 0
                         not null ,  --体温测量辅助措施代码，(CP_DataCategoryDetail.lbbh=49)  4900-无
              Fzcs varchar(200) ,  --体温测量辅助措施
              Hzmb varchar(20) ,--脉搏 
              Hzxl varchar(20) ,--心率	    
              Qbq bit default 0
                      not null ,--起搏器 0-无，1-使用
              Hzhx varchar(20) ,--患者呼吸
              Hxq bit default 0
                      not null ,--呼吸器 0-无，1-使用
              Hzxy varchar(20) ,--患者血压
              Djrq varchar(19) default convert(varchar(19), getdate(), 121) ,--登记日期(格式：2010-02-01 01:02:03) 
              Djysdm varchar(6) , --登记医生ID
              Djys varchar(30) ,--登记医生
              Zfrq varchar(19) ,--作废日期(格式：2010-02-01 01:02:03) 
              Zfrydm varchar(6) , --作废人员ID
              Zfry varchar(30) --作废人员							
						
            )
    end
go

/* ============================================================ */
/*   Table: CP_PatientInOutRecord 病人输入量/排出量记            */
/* ============================================================ */
if not exists ( select  1
                from    sysobjects
                where   name = 'CP_PatientInOutRecord' ) 
    begin
        create table CP_PatientInOutRecord
            (
              Jlxh numeric(9, 0) identity ,--记录序号（自动生成）
              Zyhm varchar(24) not null ,	--住院号码(病历号)
              Ljxh numeric(9, 0) not null ,	--路径序号(CP_InPatient.Syxh)
              Ljdm varchar(12) not null ,	--临床路径代码（CP_ClinicalPath.Ljdm)
              ActivityId varchar(50) not null ,--路径结点ID
              ActivityChildId varchar(50) not null ,--路径子节点ID(真正执行结点KEY值)  
              Jllx bit default 0
                       not null ,--记录类型，0-入量，1-出量
              Clrq varchar(10) not null , --测量日期（格式2010-01-01）
              Clsj varchar(5) check ( len(Clsj) = 5 )
                              not null ,--测量时间（格式：01:02）
							-----病人入量-----
              Ysl varchar(20) ,--饮食量
              Hsl varchar(20) ,--饮水量
              Syl varchar(20) ,--输液量
              Zsl varchar(20) ,--注射量
              Sxl varchar(20) ,--输血量
              Qtrllxdm1 int ,--其他入量1类型代码，(CP_DataCategoryDetail.lbbh=50)
              Qtrllx1 varchar(50) ,--其他入量1类型名称,格式:类型名称(单位)
              Qtrl1 varchar(20) ,--其他入量1值
              Qtrllxdm2 int ,--其他入量2类型代码 (CP_DataCategoryDetail.lbbh=50)
              Qtrllx2 varchar(50) ,--其他入量2类型名称,格式:类型名称(单位)
              Qtrl2 varchar(20) ,--其他入量2值
							-----病人出量-----
              Hzxb varchar(20) ,--患者小便
              Xbxzdm varchar(20) ,--小便性状代码，(CP_DataCategoryDetail.lbbh=51)
              Xbxz varchar(50) ,--小便性状，格式:颜色_形状，如：黄色_柱状
              Xbcsdm int ,--排小便措施代码 ，(CP_DataCategoryDetail.lbbh=52)，5200-无
              Xbcs varchar(100) ,--排小便措施， 
							--Hzdb		float,--大便量
              Dbcs varchar(50) ,--大便次数，格式：1*(3/2E ),'*'表示大便失禁 
              Dbxzdm int ,--大便性状代码，(CP_DataCategoryDetail.lbbh=53)
              Dbxz varchar(50) ,--大便性状,格式:颜色_形状
              Pbcsdm int ,--排大便措施代码，(CP_DataCategoryDetail.lbbh=54)，5500-无
              Pbcs varchar(100) ,--排大便措施，如：灌肠、人工肛门等 
              Hztl varchar(20) ,--患者痰量
              Txzdm int ,--痰的性状代码，(CP_DataCategoryDetail.lbbh=55)
              Txz varchar(50) ,--痰的性状名称，格式：颜色_性状
              Yll varchar(20) ,--引流量
              Ylsm varchar(50) ,--引流说明
              Qtcllxdm1 int ,--其他出量1类型代码，(CP_DataCategoryDetail.lbbh=56)
              Qtcllx1 varchar(50) ,--其他出量1类型名称,格式:类型名称(单位)
              Qtcl1 varchar(20) ,--其他出量1值
              Qtcllxdm2 int ,--其他出量2类型代码，(CP_DataCategoryDetail.lbbh=56)
              Qtcllx2 varchar(50) ,--其他出量2类型名称,格式:类型名称(单位)
              Qtcl2 varchar(20) ,--其他出量2值
              Djrq varchar(19) default convert(varchar(19), getdate(), 121) ,--登记日期(格式：2010-02-01 01:02:03) 
              Djysdm varchar(6) , --登记医生ID
              Djys varchar(30) ,--登记医生
              Zfrq varchar(19) ,--作废日期(格式：2010-02-01 01:02:03) 
              Zfrydm varchar(6) , --作废人员ID
              Zfry varchar(30) --作废人员	
						
            )
    end
go


/* ============================================================ */
/*   Table: CP_VitalSignSpecialRecord	  病人护理特殊记录表    */
/* ============================================================ */
if not exists ( select  1
                from    sysobjects
                where   name = 'CP_VitalSignSpecialRecord' ) 
    begin
        create table CP_VitalSignSpecialRecord
            (
              Jlxh numeric(9, 0) identity ,--记录序号（自动生成）
              Zyhm varchar(24) not null ,	--住院号码(病历号)
              Ljxh numeric(9, 0) not null ,	--路径序号(CP_InPatient.Syxh)
              Ljdm varchar(12) not null ,	--临床路径代码（CP_ClinicalPath.Ljdm)
              ActivityId varchar(50) not null ,--路径结点ID
              ActivityChildId varchar(50) not null ,--路径子节点ID(真正执行结点KEY值)  
              Clrq varchar(10) not null , --测量日期期（格式2010-01-01）
              Clsj varchar(5) check ( len(Clsj) = 5 )
                              not null ,--测量时间（格式：01:02）
              Hzsg varchar(20) ,--患者身高
              Hztz varchar(20) ,--患者体重
              Hzfw varchar(20) ,--患者腹围
              Hzxxdm int ,--患者血型代码，(CP_DataCategoryDetail.lbbh=57),5701-A型，5702-B型，5703-O型，5704-AB型
              Hzxx varchar(50) ,--患者血型
              Xyxxdm int ,--血液血性代码,(CP_DataCategoryDetail.lbbh=58),5801-HR阴性、5802-HR阳性
              Xyxx varchar(50) ,--血液血性：HR阴性、HR阳性
              Hzsss varchar(200) ,--患者手术史
              Hzsxs varchar(200) ,--患者输血史
              Hzgms varchar(200) ,--患者过敏史
							--Hzst        varchar(200),--患者舌苔
							--Hzmx        varchar(200),--患者脉象
              Djrq varchar(19) default convert(varchar(19), getdate(), 121) ,--登记日期(格式：2010-02-01 01:02:03) 
              Djysdm varchar(6) , --登记医生ID
              Djys varchar(30) ,--登记医生
              Zfrq varchar(19) ,--作废日期(格式：2010-02-01 01:02:03) 
              Zfrydm varchar(6) , --作废人员ID
              Zfry varchar(30) --作废人员	
						
            )
    end
go


/* ============================================================ */
/*   Table: CP_TreatmentFlow	  病人主要治疗流程记录表        */
/* ============================================================ */
if not exists ( select  1
                from    sysobjects
                where   name = 'CP_TreatmentFlow' ) 
    begin
        create table CP_TreatmentFlow
            (
              Jlxh numeric(9, 0) identity ,--记录序号（自动生成）
              Zyhm varchar(24) not null ,	--住院号码(病历号)
              Ljxh numeric(9, 0) not null ,	--路径序号(CP_InPatient.Syxh)
              Ljdm varchar(12) not null ,	--临床路径代码（CP_ClinicalPath.Ljdm)
              ActivityId varchar(50) not null ,--路径结点ID
              ActivityChildId varchar(50) not null ,--路径子节点ID(真正执行结点KEY值)  
              Clrq varchar(10) not null , --测量日期期（格式2010-01-01）
              Clsj varchar(5) check ( len(Clsj) = 5 )
                              not null ,--测量时间（格式：01:02）
              Zllc varchar(255) not null ,--主要治疗流程名称
              Lcsm varchar(500) not null ,--治疗流程说明
              Sfss bit default 0
                       not null ,--是否手术,0无手术，1有手术
              Djrq varchar(19) default convert(varchar(19), getdate(), 121) ,--登记日期(格式：2010-02-01 01:02:03) 
              Djysdm varchar(6) , --登记医生ID
              Djys varchar(30) ,--登记医生
              Zfrq varchar(19) ,--作废日期(格式：2010-02-01 01:02:03) 
              Zfrydm varchar(6) , --作废人员ID
              Zfry varchar(30) --作废人员	
						
            )
    end
go

/* ============================================================ */
/*   Table: CP_DoctorTaskSet   医生任务提示设置			    */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE   Name = 'CP_DoctorTaskSet' ) 
	BEGIN
		CREATE TABLE CP_DoctorTaskSet
			(
			  ID		NUMERIC(9, 0) identity(1,1)		NOT NULL ,--任务设置编号
			  Name		VARCHAR(40)						NOT NULL ,--名称
			  Ljdm		varchar(12)						NULL	 ,--路径编码（预留字段。对指定路径设置，暂时不用）
			  Yzlb		VARCHAR(8)						NULL	 ,--医嘱类别（设置对应医嘱类别进行提升）CP_DataCategoryDetail Lbbh = 31
			  Mess		VARCHAR(400)					NULL	 ,--提示信息
			  orderby	int								null	 ,--信息提示顺序（如：检验检查提示在营养膳食之前）
			  Yxjl		INT			default 1			NOT NULL ,--有效记录(1:有效 0：无效)
			  Cjsj		datetime	default getdate()	not null ,--创建时间
			  Cjgh		varchar(9)						not null ,--创建人工号
			  Memo		VARCHAR(400)					null	 ,--备注
			  
			  CONSTRAINT PK_CP_DoctorTaskSet PRIMARY KEY ( ID )
			)
	END
go



/* ============================================================ */
/*   Table: CP_DoctorTaskMessage   医生任务提示信息表		    */
/* ============================================================ */
if not exists ( select  1
				from    sysobjects
				where   Name = 'CP_DoctorTaskMessage' ) 
	begin
		create table CP_DoctorTaskMessage
			(
			  MsgID			numeric(9, 0)					not null ,	--信息编号
			  SetID			numeric(9, 0)					not null ,	--设置表编号：对应CP_DoctorTaskSet表ID字段
			  Syxh			numeric(9, 0)					not null ,	--病人序号(CP_InPatient.Syxh)
			  Ljdm			varchar(12)						null	 ,	--路径编码（对应路径提示编码）
			  PathDetailID  varchar(50)						null	 ,	--路径结点ID 
			  Yxjl			int			default 1			not null ,	--有效记录(1:有效0：无效)
			  Cjsj			datetime	default getdate()	not null ,	--任务提示信息创建时间（后台创建任务提示信息时间）默认为服务器时间
			  Rwzt			int			default 0			not null ,	--任务状态（0：创建1：完成）
			  Yqsj			datetime						not null ,	--预期完成时间（页面中根据该字段对信息进行倒序排列）
			  Wcsj			datetime						null	 ,	--医生完成任务时间（医生完成路径步骤后回写时间）		
			  Ysbm			varchar(6)						null	 ,	--医生代码
			  Ksdm			varchar(12)						null	 ,  --科室代码（暂时不用作为预留字段）
			  Bqdm			varchar(12)						null	 ,	--病区代码（暂时不用作为预留字段）
			  Mess			varchar(400)					null	 ,	--提示信息
			  Memo			varchar(400)					null	 ,  --备注
			  
			  constraint PK_CP_DoctorTaskMessage primary key ( MsgID )
			)
	end
go

/* ============================================================ */
/*   Table: CP_PatientContacts  病人联系人表                   */
/* ============================================================ */
IF NOT EXISTS ( SELECT  1
				FROM    sysobjects
				WHERE	Name = 'CP_PatientContacts' )
	 BEGIN
CREATE TABLE CP_PatientContacts
(
	Lxbh NUMERIC(9, 0) IDENTITY not null,--联系人编号，是病人联系人的唯一标识
	Syxh NUMERIC(9, 0)  NOT NULL ,	--首页序号(住院流水号)(InPatient.Syxh)
	Lxrm VARCHAR(32) NULL ,	--联系人名
	Lxgx VARCHAR(4) NULL ,	--联系关系(CP_DictionaryDetail.Mxdm, lbdm = '44')
	Lxdz VARCHAR(255) NULL ,--联系地址
	Lxdw VARCHAR(64) NULL ,	--联系(人)单位
	Lxjtdh VARCHAR(16) NULL ,--联系人家庭电话
	Lxgzdh VARCHAR(16) NULL,--联系人工作电话
	Lxyb VARCHAR(16) NULL ,	--联系邮编
    Lxcsrq CHAR(10)	NULL ,--联系人出生日期
	CONSTRAINT PK_CP_PatientContacts PRIMARY KEY(Lxbh)
)
	 END
go

/* ============================================================ */



/* ============================================================ */
/*   Table: CP_FamilyHistory       家族史		            	*/
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_FamilyHistory')
begin
create table CP_FamilyHistory
(--jack
	ID	NUMERIC(9, 0) identity(1,1)	NOT NULL,	--唯一列			
	Syxh			NUMERIC(9, 0)   not null,	--病人首页序号
	Jzgx			SMALLINT 		not null,	--家族关系(CP_DataCategoryDetail.Mxbh  Lbbh = 62)
	Csrq			char(10)   not null,	--出生日期（在前台显示年龄）
	Bzdm			varchar(32)		not null,	--病种代码(对应CP_Diagnosis.Zddm)
	Sfjz			int				not null	,	--是否健在(1:是：否)
	Swyy			varchar(200)	null,	--死亡原因
	Memo			varchar(255)	null	,	--备注
	CONSTRAINT CP_FamilyHistoryID PRIMARY KEY ( ID )
)
create index idx_FamilyHistorySyxh ON CP_FamilyHistory (Syxh)
End
Go
  
/* ============================================================ */
/*   Table: CP_PersonalHistory       个人史		            	*/
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_PersonalHistory')
begin
create table CP_PersonalHistory
(
	ID	NUMERIC(9, 0) identity(1,1)	NOT NULL,	--唯一列	
	Syxh			NUMERIC(9, 0)   not null,	--病人首页序号
	Hyzk			SMALLINT 		not null,	--婚姻状况(CP_DataCategoryDetail.Lbbh = 63)
	Hzsl		int		default 0	not null,	--孩子数量
	Zymc	 	    varchar(100)	null	,	--职业名称
	Sfyj			int				null	,	--是否饮酒（1：有 0：无）
	Yjs				varchar(255)	null	,	--饮酒史
	Sfxy			int				not null,	--是否吸烟（1：有 0：无）
	Csd             varchar(20)	null	,  	    --出生地
	Jld             varchar(20)	null	,	    --经历地
	Xys				varchar(255)	not null,	--吸烟史
	Memo			varchar(255)	null	,	--备注
	CONSTRAINT CP_PersonalHistoryID PRIMARY KEY ( ID )
)
create index idx_PersonalHistorySyxh ON CP_PersonalHistory (Syxh)
End
Go
 
/* ============================================================ */
/*   Table: CP_AllergyHistory       过敏史		            	*/
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_AllergyHistory')
begin
create table CP_AllergyHistory
(
	ID	NUMERIC(9, 0) identity(1,1)	NOT NULL,	--唯一列
	Syxh			NUMERIC(9, 0)   not null,	--病人首页序号
	Gmlx			SMALLINT 		not null,	--过敏类型(CP_DataCategoryDetail.Lbbh = 60)
	Gmcd			SMALLINT 		not null,	--过敏程度（CP_DataCategoryDetail.Lbbh = 61）
	Dlys	 	    varchar(100)	null	,	--代理医生
	Gmbw			varchar(100)	null	,	--过敏部位
	Fylx			varchar(255)	null	,	--反应类型
	Memo			varchar(255)	null	,	--备注
	CONSTRAINT CP_AllergyHistoryID PRIMARY KEY ( ID )
)
create index idx_AllergyHistorySyxh ON CP_AllergyHistory (Syxh)
end
go
 
操作
 
/* ============================================================ */
/*   Table: CP_SurgeryHistory       手术史		            	*/
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_SurgeryHistory')
begin
create table CP_SurgeryHistory
(
	ID	NUMERIC(9, 0) identity(1,1)	NOT NULL,	--唯一列
	Syxh			NUMERIC(9, 0)   not null,	--病人首页序号
	Ssdm			varchar(12)		not null,	--手术代码(CP_Surgery维护)
	Bzdm			varchar(32)		not null,	--疾病（对应CP_Diagnosis.Zdbs）
	Sspl			varchar(200)	null	,	--评论
	Ssys			varchar(100)	null	,	--手术医生
	Memo			varchar(255)	null	,	--备注
	CONSTRAINT CP_SurgeryHistoryID PRIMARY KEY ( ID )
)
create index idx_SurgeryHistorySyxh ON CP_SurgeryHistory (Syxh)
end
go
 
/* ============================================================ */
/*   Table: CP_MedicalRecordsHistory       治疗记录		    	*/
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_MedicalRecordsHistory')
begin
create table CP_MedicalRecordsHistory
(
	ID	NUMERIC(9, 0) identity(1,1)	NOT NULL,	--唯一列
	Syxh			NUMERIC(9, 0)   not null,	--病人首页序号
	Zlys			varchar(100)	not null,	--治疗医生
	Zllb			varchar(100)	not null,	--类别
	Zlyy		 	varchar(200)	null	,	--治疗医院
	Zlpl			varchar(200)	null	,	--治疗评论
	Zlsj			datetime		not null,	--治疗时间
	Memo			varchar(255)	null	,	--备注
	CONSTRAINT CP_MedicalRecordsHistoryID PRIMARY KEY ( ID )
)
create index idx_MedicalRecordsHistorySyxh ON CP_MedicalRecordsHistory (Syxh)
end
go

 
/* ============================================================ */
/*   Table: CP_IllnessHistory       疾病史		    	*/
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_IllnessHistory')
begin
create table CP_IllnessHistory
(
	ID	NUMERIC(9, 0) identity(1,1)	NOT NULL,	--唯一列
	Syxh			NUMERIC(9, 0)   not null,	--病人首页序号
	Bzdm			varchar(32)		not null,	--病种代码（对应CP_Diagnosis.Zdbs）
	Jbpl			varchar(200)	null	,	--疾病评论
	Bfsj			datetime		not null,	--病发时间
	Sfzy			int				not	null,	--是否治愈（1：是0：否）
	Memo			varchar(255)	null	,	--备注
	CONSTRAINT CP_IllnessHistoryID PRIMARY KEY ( ID )
)
create index idx_IllnessHistorySyxh ON CP_IllnessHistory (Syxh)
end
go

/* ============================================================ */
/*   Table: CP_InpatientDiagnosisInfo病人诊断提示库             */
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_InpatientDiagnosisInfo')
begin
	create table CP_InpatientDiagnosisInfo
	(
		ID	NUMERIC(9, 0) identity(1,1)		NOT NULL,	--唯一列
		Syxh			  NUMERIC(9, 0)		not null,	--病人首页序号
		Msg				  varchar(255)		not null,	--诊断相关提示信息
		Djsj			  varchar(19)		not null,	--提示信息登记日期
		Zxsj			  varchar(19)	    null,		--注销提示时间
		Zxys			  varchar(16)	    null,		--修改诊断医生
		Yxjl			  int				not null,	--是否有效
	   CONSTRAINT PK_CP_InpatientDiagnosisInfo PRIMARY KEY ( ID )
	 )
	create index idx_CP_InpatientDiagnosisInfoSyxh ON CP_InpatientDiagnosisInfo (Syxh)
end
go

/* ============================================================ */
/*   Table: CP_InpathEnterInfo   病人进入路径提示信息		   */
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_InpathEnterInfo')
begin
create table CP_InpathEnterInfo
(
	ID	NUMERIC(9, 0) identity(1,1)		NOT NULL,	--唯一列
	Syxh			  NUMERIC(9, 0)		not null,	--病人首页序号
	Ljdm			  VARCHAR(12)		NOT NULL ,	--临床路径代码			
	Msg				  varchar(255)		not null,	--相关提示信息
	Djsj			  varchar(19)		not null,	--提示信息登记日期
	Zxsj			  varchar(19)	    null,		--注销提示时间
	Zxys			  varchar(16)	    null,		--注销提示医生
	Zxly			  varchar(255)	    null,		--注销理由
	Tslb			  int				not null,	--提示信息类别(1：允许进入0:不允许进入)
	Yxjl			  int				not null,	--是否有效
   CONSTRAINT PK_CP_InpathEnterInfo PRIMARY KEY ( ID )
 )

create index idx_CP_InpathEnterInfoSyxh ON CP_InpathEnterInfo (Syxh)
create index idx_CP_InpathEnterInfoLjdm ON CP_InpathEnterInfo (Ljdm)
end
go


/* ============================================================ */
/*   Table: CP_InpathExitInfo   病人退出路径提示信息		   */
/* ============================================================ */
if not exists(select 1 from sysobjects where name='CP_InpathExitInfo')
begin
create table CP_InpathExitInfo
(
	ID	NUMERIC(9, 0) identity(1,1)		NOT NULL,	--唯一列
	Syxh			  NUMERIC(9, 0)		not null,	--病人首页序号
	Ljdm			  VARCHAR(12)		NOT NULL ,	--临床路径代码			
	Msg				  varchar(255)		not null,	--退出路径理由
	Djsj			  varchar(19)		not null,	--提示信息登记日期
	Zxsj			  varchar(19)	    null,		--注销提示时间
	Zxys			  varchar(16)	    null,		--注销提示医生
	Zxly			  varchar(255)	    null,		--注销理由
	Yxjl			  int				not null,	--是否有效
   CONSTRAINT PK_CP_InpathExitInfo PRIMARY KEY ( ID )
 )

create index idx_CP_InpathExitInfoSyxh ON CP_InpathExitInfo (Syxh)
create index idx_CP_InpathExitInfoLjdm ON CP_InpathExitInfo (Ljdm)
end
go

/* ============================================================ */
/*   Table: CP_OrderToPath   长期/临时医嘱与路径对应关系表      */
/* ============================================================ */
if not exists ( select  1
                from    sysobjects
                where   Name = 'CP_OrderToPath' ) 
    begin
        create table CP_OrderToPath
            (
              Id numeric(12, 0) identity
                                not null ,
              Yzxh numeric(12, 0) not null ,	--长期(CP_LongOrder.Cqyzxh)/临时医嘱序号(CP_TempOrder.Lsyzxh)
              Yzbz smallint null ,	--医嘱标志(只会有长期，临时）(CP_DataCategory.Mxbh, Lbbh = 27)
			  Ljxh NUMERIC(9, 0) NOT NULL ,	--路径序号(CP_InPatient.Syxh)
              Ljdm varchar(12) not null ,	--临床路径代码（CP_ClinicalPath.Ljdm)
              ActivityId varchar(50) not null ,--路径结点ID
              ActivityChileId varchar(50) not null ,--路径子节点ID(真正执行结点KEY值)             
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
/*   Table: CP_PathLeadInRecord   路径引入记录                  */
/* ============================================================ */
if not exists ( select  1
                from    sysobjects
                where   Name = 'CP_PathLeadInRecord' ) 
    begin
        create table CP_PathLeadInRecord
            (
              Id numeric(12, 0) identity
                                not null ,
              Ljxh numeric(12, 0) not null ,--路径序号CP_InPathPatient.Id
              Syxh numeric(9, 0) not null ,	--首页序号
              Ljdm varchar(12) not null ,--路径代码
              Yxjl smallint not null ,--1,有效，0，无效 
              Create_Time varchar(19) not null ,
              Create_User varchar(6) not null ,
              constraint PK_CP_PathLeadInRecord primary key ( Id )
            )
        create index idx_Ljxh on CP_PathLeadInRecord(Ljxh)
        create index idx_Syxh on CP_PathLeadInRecord(Syxh)
    end
GO

/* ============================================================ */
/*   Table: CP_TriggerConditionDetail   事务触发异常条件详细表	*/
/* ============================================================ */
if not exists ( select  1
				from    sysobjects
				where   name = 'CP_TriggerConditionDetail' ) 
begin
	create table CP_TriggerConditionDetail  
	(
		Jlxh   		numeric(9,0) identity,                          --自动生成
		Zbm         varchar(50)                      not null,      --（触发条件范围）值编码
		Jcbm        varchar(50)                      not null,      --检查项目编码分类字典详细编码CP_ExamDictionaryDetail.Jcbm
		Tjbm		varchar(50)	                     not null,	    --条件编码CP_TriggerCondition.Tjbm
		Zmc         varchar(200)                     not null,      --（触发条件范围）值编码名称
		Tjfw1       varchar(50)                      not null,      --触发条件范围值，闭合区间左边值，或半闭合区间值.
		Ysf1        varchar(20)                      not null,      --与范围值比较运算符，闭合区间左边运算符，或半闭合区间运算符.
		Tjfw2       varchar(50)                      null,          --触发条件范围值，闭合区间右边值，或半闭合区间无值（即不输入值）.
		Ysf2        varchar(20)                      null,          --与范围值比较运算符，闭合区间右边运算符，或半闭合区间无运算符（即不输入值）.
		Zysf        varchar(20)                      null,          --闭合区间两个条件之间运算符:(&(与)、|(或)
		Syrq		varchar(50)						 null,		    --适用人群
		Zlx         bit                              not null,      --触发条件范围值类型，1正常，0异常
		Yxjl        bit default 1                    not null,      --有效记录1有效，0无效
		Py			varchar(50)			 	         null,	        --拼音
		Wb			varchar(50)			             null,	        --五笔
		Bz   		varchar(200)                     null       	--备注		
		constraint PK_CP_TriggerConditionDetail primary key(Zbm)
	)
	create index idx_Zbm on CP_TriggerConditionDetail(Zbm)
end

go
 
/* ============================================================ */
/*   Table: CP_TriggerConditionGroup 事务触发异常条件组详细表  	*/
/* ============================================================ */
if not exists ( select  1
				from    sysobjects
				where   name = 'CP_TriggerConditionGroup' ) 
begin
	create table CP_TriggerConditionGroup  
	(
		Jlxh   		numeric(9,0) identity,                          --自动生成
		Zbm         varchar(50)                      not null,      --（触发条件范围）值编码
		Tjbm		varchar(50)  	                 not null,	    --条件编码CP_TriggerCondition.Tjbm
		Zmc         varchar(200)                     not null,      --（触发条件范围）值编码名称
		Tjzh        varchar(200)                     not null,      --触发最小条件组合，用'，'分开,CP_TriggerConditionDetail.Zbm组合
		Ysf         varchar(20)                      not null,      --触发最小条件组合之间关系运算符，用'，'分开,从左到右的顺序匹配
		Syrq		varchar(50)						 null,			--适用人群
		Zlx         bit                              not null,      --触发条件范围值类型，1正常，0异常
		Yxjl        bit default 1                    not null,      --有效记录1有效，0无效
		Py			varchar(50)			 	         null,	        --拼音
		Wb			varchar(50)			             null,	        --五笔
		Bz   		varchar(200)                     null       	--备注		
		constraint PK_CP_TriggerConditionGroup primary key(Zbm)
	)
	create index idx_Zbm on CP_TriggerConditionGroup(Zbm)
end

go

/* ======================================================== */
/*   Table: CP_NurExecItem 护理执行项目表               	*/
/* ======================================================== */
if not exists ( select  1
                from    sysobjects
                where   NAME = 'CP_NurExecItem' ) 
    create table CP_NurExecItem
        (
          Xmxh varchar(12) not null ,		--项目编码
          Name varchar(12) not null ,		--项目名称
          OrderValue numeric(12, 0) not null
                                    default 0 ,	--排序字段
          Yxjl smallint not null
                        default 1 ,				--是否有效
          Create_Time varchar(19) not null
                                  default convert(varchar(19), getdate(), 120) ,	--创建时间
          Create_User varchar(10) ,
          Cancel_Time varchar(19) ,
          Cancel_User varchar(10) ,
          constraint PK_CP_NurExecItem primary key ( Xmxh )
        )
go

/* ======================================================== */
/*   Table:  CP_NurExecCategory 护理执行类别表              */
/* ======================================================== */
if not exists ( select  1
                from    sysobjects
                where   NAME = ' CP_NurExecCategory' ) 
    create table CP_NurExecCategory
        (
          Lbxh varchar(12) not null ,		--类别编码
          Name varchar(12) not null ,		--项目名称
          Xmxh varchar(12) not null ,		--项目编码,CP_NurExecItem. Xmxh
          InputType smallint not null
                             default 0 ,  --输入控件类型（0无,1用户控件）暂时保留
          OrderValue numeric(12, 0) not null
                                    default 0 ,	--排序字段
          Yxjl smallint not null
                        default 1 ,				--是否有效
          Create_Time varchar(19) not null
                                  default convert(varchar(19), getdate(), 120) ,	--创建时间
          Create_User varchar(10) ,
          Cancel_Time varchar(19) ,
          Cancel_User varchar(10) ,
          constraint PK_CP_NurExecCategory primary key ( Lbxh )
        )
go

/* ======================================================== */
/*   Table:  CP_NurExecCategoryDetail 护理执行类别明细表        	*/
/* ======================================================== */
if not exists ( select  1
                from    sysobjects
                where   NAME = ' CP_NurExecCategoryDetail' ) 
    create table CP_NurExecCategoryDetail
        (
          Mxxh varchar(50) not null ,		--明细编码
          Name varchar(12) not null ,		--项目名称
          Lbxh varchar(3000) not null ,		--类别编码,CP_NurExecCategory.Lbxh
          InputType smallint not null
                             default 0 ,    --输入控件类型（0无,1TEXTBOX,2COMBBOX…）暂时保留
          OrderValue numeric(12, 0) not null
                                    default 0 ,--排序字段
          Yxjl smallint not null
                        default 1 ,			   --是否有效
          Create_Time varchar(19) not null
                                  default convert(varchar(19), getdate(), 120) ,	--创建时间
          Create_User varchar(10) ,
          Cancel_Time varchar(19) ,
          Cancel_User varchar(10) ,
		  Sfsy		int			
									NOT NULL,default 0 	--是否使用中(0否 1是)     (5.13	zm添加)   
          constraint PK_CP_NurExecCategoryDetail primary key ( Mxxh )
        )
go

/* ======================================================== */
/*   Table:  CP_NurExecToPath 护理执行类别明细表        	*/
/* ======================================================== */
if not exists ( select  1
                from    sysobjects
                where   NAME = 'CP_NurExecToPath' ) 
    create table CP_NurExecToPath
        (
          Id numeric(12, 0) identity
                            not null ,
          Ljdm varchar(12) not null ,		--路径代码,CP_ClinicalPath.Ljdm
          PathDetailId varchar(50) not null ,--路径结点
          Mxxh varchar(50) not null ,		--明细编码,CP_NurExecCategoryDetail.Mxxh
          Yxjl smallint not null
                        default 1 ,			   --是否有效
          Create_Time varchar(19) not null
                                  default convert(varchar(19), getdate(), 120) ,	--创建时间
          Create_User varchar(10) ,
          Cancel_Time varchar(19) ,
          Cancel_User varchar(10) ,
          constraint PK_CP_NurExecToPath primary key ( Id )
        )
go


/* ======================================================== */
/*   Table:  CP_NurExecRecord 护理执行记录表        	*/
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
          Ljdm varchar(12) not null ,		--路径代码,CP_ClinicalPath.Ljdm
          PathDetailId varchar(50) not null ,--路径结点
          Mxxh varchar(12) not null ,		--明细编码,CP_NurExecCategoryDetail.Mxxh
          Bdmx varchar(12) , --表单明细编码CP_NurExecFormsDetail.Id暂时保留
          Bdxh varchar(12) ,	--表单明细编码CP_ NurExecForms.Bdxh暂时保留
          Yzxh numeric(12, 0) ,	--医嘱序号，为医嘱保留,暂时保留
          Value varchar(600) ,			--结果值，为输入类型的保留，暂时保留
          Yxjl smallint not null
                        default 1 ,			   --是否有效
          Create_Time varchar(19) not null
                                  default convert(varchar(19), getdate(), 120) ,	--创建时间
          Create_User varchar(10) ,
          Cancel_Time varchar(19) ,
          Cancel_User varchar(10) ,
          constraint PK_CP_NurExecRecord primary key ( Id )
        )
GO
/* ======================================================== */
/*   Table: CP_MedicalTreatmentWarm 路径执行提前提醒表		*/
/* ======================================================== */
IF NOT EXISTS(SELECT * FROM sysobjects WHERE name='CP_MedicalTreatmentWarm')
 DROP TABLE CP_MedicalTreatmentWarm
Create table CP_MedicalTreatmentWarm
(
	ID		NUMERIC(9, 0)	IDENTITY NOT NULL,  --自增字段
	Syxh	NUMERIC(9, 0)  NOT NULL ,			--首页序号(住院流水号)(InPatient.Syxh)
	Ljxh	NUMERIC(9, 0) NOT NULL ,			--路径序号CP_InPathPatient.Id
	Ljdm	varchar(12) not null ,				--临床路径代码（CP_ClinicalPath.Ljdm)
	Jddm	VARCHAR(50) ,						--节点的GUID 
	Hzjddm  VARCHAR(50) ,						--前置节点UniqueID
	Txlx	int  not null, 						--提醒类型(1:手术，2：检查，3：其他信息)
	Txzt	int not NULL,						--提醒状态(0:未查看，1：已查看)
	dm		VARCHAR(12) NOT NULL ,				--提醒编码（药品代码||手术代码(or收费小项目代码or临床项目代码,具体是哪种代码根据项目类别来判断)(CP_PlaceOfDrug.Ypdm/CP_ChargingMinItem.Sfxmdm/CP_LCChargingItem.Lcxmdm)）
	mc		VARCHAR(64) NULL ,					--提醒内容（药品(项目)名称||手术名称||其他(CP_PlaceOfDrug.Name/CP_ChargingMinItem.Name)）
	CONSTRAINT CP_MedicalTreatmentWarm_ID PRIMARY KEY(ID)
)
GO
/* ======================================================== */
/*   Table: CP_InpatientPathExedetail 路径执行记录节点顺序明细表	 zm 8.9 修改 加入节点名称，节点类型	*/
/* ======================================================== */
IF NOT EXISTS(SELECT * FROM sysobjects WHERE name='CP_InpatientPathExedetail')
 DROP TABLE CP_InpatientPathExedetail
CREATE TABLE CP_InpatientPathExedetail
(
	ID numeric(9, 0) IDENTITY,		--自增
	Syxh numeric(9, 0) NOT NULL,	--首页序号
	Ljxh numeric(9, 0) NOT NULL,	--路径序号
	Ljdm varchar(12) NOT NULL,		--路径代码
	Jddm varchar(50) NOT NULL,		--节点代码
	Zxsx numeric(9,0) NOT NULL,		--执行顺序(编号有大到小排序)
	Jrsj varchar(20)				--执行时间
	ActivityName varchar(50) -- 节点名称
	ActivityType varchar(50) -- 节点类型
)
GO

/* ======================================================== */
/*   Table:  CP_NurResult 护理结果基础表              */
/* ======================================================== */
if not exists ( select  1
                from    sysobjects
                where   NAME = ' CP_NurResult' ) 
    create table CP_NurResult
        (
          Jgbh INT IDENTITY(1,1) not null ,		--结果编号
          Name varchar(12) not null ,		--护理结果名称
          Yxjl smallint not null
                        default 1 ,				--是否有效
          Create_Time varchar(19) not null
                                  default convert(varchar(19), getdate(), 120) ,	--创建时间
          Create_User varchar(10) ,--创建人
          Update_Time varchar(19) ,--修改时间
          Update_User varchar(10) ,--修改人
          constraint PK_CP_NurResult primary key ( Jgbh )
        )
GO
/* ======================================================== */
/*   Table:  CP_NurExecuteResult 护理结果表              */
/* ======================================================== */
if not exists ( select  1
                from    sysobjects
                where   NAME = ' CP_NurExecuteResult' ) 
    create table CP_NurExecuteResult
        (
          Id INT IDENTITY(1,1) NOT NULL ,		--自增序号
          Jgbh VARCHAR(50) NOT NULL ,		--结果编号
          Mxxh VARCHAR(100) NOT NULL,       --护理编号
          Yxjl smallint NOT NULL default 1 ,--是否有效
          Create_Time varchar(19) NOT NULL default convert(varchar(19), getdate(), 120) ,	--创建时间
          Create_User varchar(10) ,--创建人
          constraint CP_NurExecuteResult primary key ( Id )
        )
GO
/* ======================================================== */
/*   Table:  CP_NurExecRecordResult 护理执行结果记录表        	*/
/* ======================================================== */
if not exists ( select  1
                from    sysobjects
                where   NAME = 'CP_NurExecRecordResult' ) 
    create table CP_NurExecRecordResult
        (
          Id  VARCHAR(50) NOT NULL ,--护理执行结果编号
          HlzxId varchar(50) NOT NULL ,		--护理执行记录编号,CP_NurExecRecord.Id
          JgId VARCHAR(50) NOT NULL,        --护理结果编号,CP_NurResult.Jgbh
          Yxjl smallint NOT NULL default 1 , --有效记录
          Create_Time varchar(19) NOT NULL default convert(varchar(19), getdate(), 120) ,	--创建时间
          Create_User varchar(10) ,--创建人
          constraint PK_CP_NurExecRecordResult primary key ( Id )
        )
GO


/* ======================================================== */
/*   Table: CP_MasterDrugs  	关键药品表	*/
/* ======================================================== */
IF NOT EXISTS ( SELECT  1
                FROM    sysobjects
                WHERE   NAME = 'CP_MasterDrugs' ) 
    CREATE TABLE CP_MasterDrugs
        (
          Cdxh		VARCHAR(12) NOT NULL ,	--药品代码	//CP_PlaceOfDrug. Cdxh
          Txfs		VARCHAR(1) NULL ,		--提醒方式（1：提醒，2：输入帐号密码）
          ZgdmCj	VARCHAR(20) NULL ,		--创建者编码(CP_Employee.Zgdm)
          Cjsj		CHAR(19) NULL ,			--创建时间
          ZgdmXg	VARCHAR(20) NULL ,		--修改者编码(CP_Employee.Zgdm)
          Xgsj		CHAR(19) NULL ,			--修改时间
          Bz		VARCHAR(300) NULL ,		--备注
          CONSTRAINT PK_CP_MasterDrugs_Cdxh PRIMARY KEY ( Cdxh )
        )
GO
/* ======================================================== */
/*   Table: CP_MasterDrugRoles  	 	药品角色表	*/
/* ======================================================== */
IF NOT EXISTS ( SELECT  1
                FROM    sysobjects
                WHERE   NAME = 'CP_MasterDrugRoles' ) 
    CREATE TABLE CP_MasterDrugRoles
        (
          Jsbm		VARCHAR(50) NOT NULL ,	--角色编码
          Jsmc		VARCHAR(50) NULL ,	--角色名称
          ZgdmCj	VARCHAR(20) NULL ,	--创建者编码(CP_Employee.Zgdm)
          Cjsj		CHAR(19) NULL ,		--创建时间
          ZgdmXg	VARCHAR(20) NULL ,	--修改者编码(CP_Employee.Zgdm)
          Xgsj		CHAR(19) NULL ,		--修改时间
          Bz		VARCHAR(300) NULL ,
          CONSTRAINT PK_CP_MasterDrugRoles_Jsbm PRIMARY KEY ( Jsbm )
        )
GO
/* ======================================================== */
/*   Table: CP_MasterDrug2Role  	  	关键药品对应关键药品角色表	*/
/* ======================================================== */
IF NOT EXISTS ( SELECT  1
                FROM    sysobjects
                WHERE   NAME = 'CP_MasterDrug2Role' ) 
    CREATE TABLE CP_MasterDrug2Role
        (
          Jsbm		VARCHAR(50) NOT NULL ,	--角色编码（DrugRoles. Jsbm）
          Cdxh		VARCHAR(12) NOT NULL ,	--药品代码	//CP_PlaceOfDrug. Cdxh
          ZgdmCj	VARCHAR(20) NULL ,	--创建者编码(CP_Employee.Zgdm)
          Cjsj		CHAR(19) NULL ,		--创建时间
          ZgdmXg	VARCHAR(20) NULL ,	--修改者编码(CP_Employee.Zgdm)
          Xgsj		CHAR(19) NULL ,		--修改时间
          Bz		VARCHAR(300) NULL ,
          CONSTRAINT PK_CP_MasterDrug2Role_JsbmCdxh PRIMARY KEY ( Jsbm, Cdxh)
        )
GO

/* ======================================================== */
/*   Table: CP_MasterDrug2User  	  	2.1.4.	账户对应药品角色表	*/
/* ======================================================== */
IF NOT EXISTS ( SELECT  1
                FROM    sysobjects
                WHERE   NAME = 'CP_MasterDrug2User' ) 
    CREATE TABLE CP_MasterDrug2User
        (
          Zgdm		VARCHAR(6) NOT NULL ,	--职工代码(CP_Employee.Zgdm)
          Jsbm		VARCHAR(50) NOT NULL ,--角色编码(MasterDrugRoles. Jsbm)
          ZgdmCj	VARCHAR(20) NULL ,	--创建者编码(CP_Employee.Zgdm)
          Cjsj		CHAR(19) NULL ,		--创建时间
          ZgdmXg	VARCHAR(20) NULL ,	--修改者编码(CP_Employee.Zgdm)
          Xgsj		CHAR(19) NULL ,		--修改时间
          Bz		VARCHAR(300) NULL ,
          CONSTRAINT PK_CP_MasterDrug2User_ZgdmJsbm PRIMARY KEY ( Zgdm,Jsbm )
        )
GO
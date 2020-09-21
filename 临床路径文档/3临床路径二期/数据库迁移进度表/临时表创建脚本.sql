  病人列表问题
  
  CP_InPatient  的Wzjb 字段 
    类型为varchar2  值均为0
 
 但大部分字段的值  前有空格 需要trim     	    

/*患者费用信息*/

create global temporary table temp_Grfy
(
SyxhID VARCHAR(100)  NOT NULL,--首页序号
      Hzxm VARCHAR(100) NULL,--患者姓名
      Ljmc VARCHAR(100) NULL,--路径名称
      Bzts VARCHAR(30) NULL,--标准天数
      Zyts VARCHAR(30) NULL,--住院天数
      Rjsj VARCHAR(30) NULL,--入径时间
      Tcsj VARCHAR(30) NULL,--退出时间
      Wcsj VARCHAR(30) NULL,--完成时间
      Bzfy VARCHAR(100) NULL,--标准费用
      Ljzt VARCHAR(100) NULL,--路径状态
      Qita VARCHAR(12) NULL,--其它
      XyFei VARCHAR(12) NULL,--西药费
      ZhiliaoFei VARCHAR(12) NULL,--治疗费
      JcFei VARCHAR(12) NULL,--检查费
      JyFei VARCHAR(12) NULL,--检验费
      ZlFei VARCHAR(12) NULL,--诊疗费
      CwFei VARCHAR(12) NULL,--床位费
      HshlFei VARCHAR(12) NULL,--护士护理费
      Zj VARCHAR(12) NULL,--总计
			Yjlj VARCHAR(12) NULL--押金累计
) on commit preserve rows;

/*
护理维护
*/

CREATE global temporary TABLE temp_Necd
(
		Mxxh VARCHAR(100)  NOT NULL,--护理编号
		MxxhName VARCHAR(100),--护理名称
		Lbxh VARCHAR(100),--类别序号
		LbxhName VARCHAR(20),--类别名称
		Yxjl VARCHAR(20),--有效记录
		Sfsy VARCHAR(20),--是否使用
		JgName VARCHAR(1000)--护理结果
)on commit preserve rows;

/*
提醒中心
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

/*报表
*/

CREATE global temporary TABLE temp_EnterpathStatistics
(
      LjdmID varchar(100)  NOT NULL, --路径代码
			KsdmID VARCHAR(100) NULL ,--科室代码 
			Ksmc varchar(100) null,--科室名称
			Ljmc varchar(100) null,--路径名称
			Bhzs int null,--病患总数
			Rjrs int null,--入径人数
			Rjl int null,--入径率
			Wcrs int null,--完成人数
			Wcl int null,--完成率
			Tcrs int null,--退出人数
			Tcl int null,--退出率
			Zjrs int null,--在径人数
			Zjl int null--在径率
)on commit preserve rows;


CREATE global temporary TABLE temp_PathExecuteInfo
(
		LjdmID		varchar(100)	 not null, --路径代码
		Ljcz		int					not null,--路径执行状态
		Czsj		varchar(100)		null--退出时间(路径执行表,此项可以为空)
)on commit preserve rows;


create global temporary table temp_pathQuitMonthCompare
(
    Ljdm		varchar(100)		 not null, --路径代码
    Ljmc		varchar(100)		not null,--路径名称
    Syks		varchar(100)		null,--适应科室(路径表,此项可以为空)
    Jan			int					null,--一月
    Feb			int					null,--二月
    Mar			int					null,--三月
    Apr			int					null,--四月
    May			int					null,--五月
    Jun			int					null,--六月
    Jul			int					null,--七月
    Aug			int					null,--八月
    Sept		int					null,--九月
    Oct			int					null,--十月
    Nov			int					null,--十一月
    Dec			int					null--十二月
)on commit preserve rows;

create global temporary table temp_PathVariation
(
  BydmSt		VARCHAR(100)		NULL, --一级编码代码
  BymcSt		VARCHAR(100)		NULL,--一级编码名称
  St			VARCHAR(100)		 NULL,--一级编码缩写字段
  BydmNd		VARCHAR(100)		 NULL, --二级编码代码
  BymcNd		VARCHAR(100)		NULL,--二级编码名称
  Nd			VARCHAR(100)		 NULL,--二级编码缩写字段
  BydmRd		VARCHAR(100)		 NULL, --三级编码代码
  BymcRd		VARCHAR(100)		NULL--三级编码名称
)on commit preserve rows;

create global temporary table temp_PathVariationNd
(
  BydmNd		VARCHAR(100)		null, --二级编码代码
  BymcNd		VARCHAR(100)		NULL--二级编码名称
)on commit preserve rows;

create global temporary table temp_PathVariationSt
(
  BydmSt		VARCHAR(100)		 null, --一级编码代码
  BymcSt		VARCHAR(100)		NULL--一级编码名称
)
on commit preserve rows;

create global temporary table temp_VariantRecords
(
  BydmId	VARCHAR(100)	 NOT null, --变异代码
  Ljxh	VARCHAR(100)	NULL--路径序号
)on commit preserve rows;

create global temporary table temp_PathVariationAnalyse           
(
  Bydm	VARCHAR(100)	 null, --变异代码
  BymcSt		VARCHAR(100)		NULL,--一级编码名称
  BymcNd		VARCHAR(100)		NULL,--二级编码名称
  BymcRd		VARCHAR(100)		NULL,--三级编码名称
  VariationCount	INT				NULL--数目
)on commit preserve rows;



create global temporary table temp_EnForce
(
		Ljdm	VARCHAR(100)	 NULL,--路径代码
		PathDetailId	VARCHAR(100)	NULL--路径节点
)on commit preserve rows;

create global temporary table temp_PathVariantRecords             /*重名已改*/
(
		Ljdm	varchar(100)	 NULL,--路径代码
		PathDetailId	varchar(100)	NULL--路径节点
)on commit preserve rows;

create global temporary table temp_PathVariationMonitor
(
		Ljmc			VARCHAR(100)		 NULL,--路径节点名
		PahtDetail		VARCHAR(100)		NULL,--路径节点ID
		enForceCount	INT					NULL,--执行数
		variationCount	INT					NULL,--变异数
		per				DECIMAL				NULL	--差异率
)on commit preserve rows;

/*总结，打印*/
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

/*总结，打印*/
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

create global temporary table temp_Order                            /*重名已改*/
	(
		Yzbz	varchar(100)	NOT NULL,	--医嘱类别（长期/临时）
		Xmlb	varchar(100)	NULL,		--项目类别
		Ypdm	VARCHAR(100)	NULL,		--项目代码
		Ypmc	varchar(500)	NULL,		--项目内容
		Yznr	varchar(500)	NULL,		--医嘱内容
		ActivityId	varchar(500)	NULL,	--路径节点
		ActivityChildID varchar(500)	NULL,	--路径子节点
		Yzzt	varchar(100) NULL --医嘱状态
	)on commit preserve rows;
  
  create global temporary table temp_Xmlb
	(
		Xmlb	VARCHAR(100)	NULL,		--项目类别
		Ypdm	VARCHAR(100)	NULL		--项目代码
	)on commit preserve rows;
  
  CREATE global temporary table temp_Variation
	(
		Xmlb	VARCHAR(100)	NULL,		--项目类别		
		Ypdm	VARCHAR(100)	NULL,		--项目代码
		Bynr	varchar(500)	NULL,		--变异理由
		PahtDetailID	varchar(500)	NULL,--路径节点
		Mxdm VARCHAR(500) NULL --路径子节点
	)on commit preserve rows;
  
  	CREATE global temporary table temp_DisXmlb
	(
		Xmlb	VARCHAR(100)	NULL,		--项目类别
		Ypdm	VARCHAR(100) NULL		--项目代码
	)on commit preserve rows;
  
  	CREATE global temporary table temp_CategoryDetail
	(
		Mxbh VARCHAR(100) NULL,
		NAME VARCHAR(100) NULL,
		Cols VARCHAR(50) NULL,
		Lb VARCHAR(50) NULL
	)on commit preserve rows;
  
  
  /*裁剪*/
CREATE GLOBAL TEMPORARY TABLE temp_PathEnterJudgeCondition

on commit preserve rows

AS

SELECT * FROM CP_PathEnterJudgeCondition;



  /*裁剪*/
CREATE GLOBAL TEMPORARY TABLE temp_DetailNur

on commit preserve rows

AS

SELECT * FROM CP_NurExecToPath




  /*裁剪*/
CREATE GLOBAL TEMPORARY TABLE temp_DeatilVar

on commit preserve rows

AS

SELECT * FROM CP_VariationToPath


/*医嘱裁剪*/
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

Create global temporary Table temp_Head					--表头(用于处理表头)
(
	Bydm	varchar(100)	NULL,		--表头标识
	Bymc	varchar(100)	NULL		--表头名
)on commit preserve rows;

Create global temporary Table temp_Content				--数据（用于处理数据）
(
	Ljmc	varchar(100) NULL,		--路径名称
	Bydm	varchar(100)	NULL,								--变异代码（匹配）
	Ljdm	varchar(100)	 NULL		--路径代码
)on commit preserve rows;


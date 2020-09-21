IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_RWPathSummary' ) 
    DROP PROCEDURE usp_CP_RWPathSummary
go
CREATE  PROCEDURE [dbo].usp_CP_RWPathSummary

@Syxh	NVARCHAR(100) = '',	--病人首页序号
@Ljxh	NVARCHAR(100) = ''	--入径序号
AS /**********
[版本号]	1.0.0.0.0               
[创建时间]	2011-05-05              
[作者]		ZM         
[版权]		YidanSoft          
[描述]		6路径总结
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
 路径总结功能         


[调用的sp]
[调用实例]
			exec usp_CP_RWPathSummary '779','11'
[修改记录]


----窗口需求说明
6路径总结功能
在路径执行界面增加一个按钮《路径总结》，医生可以时刻通过这个按钮，调阅出这个病人的路径执行情况，包括执行医嘱、诊疗状况（诊断、文书、费用等等）、路径变异情	
备注：两种视图显示（其中一种不显示变异信息）
(1)	查询条件
	病人首页序号
	项目类别
(2)	查询结果
	列表展现 
**********/

BEGIN     
	DECLARE @tempsqlOne nvarchar(4000)
	DECLARE @tempsqlTwo nvarchar(4000)
	DECLARE @tempsqlThree nvarchar(4000)
	DECLARE @tempsqlFour nvarchar(4000)
	DECLARE @tempsqlFive nvarchar(4000)
	DECLARE @tempsqlSix nvarchar(4000)
    
    SET nocount ON
    
--创建临时医嘱表
	CREATE TABLE #TempOrder
	(
		Yzbz	nvarchar(100)	NOT NULL,	--医嘱类别（长期/临时）
		Xmlb	nvarchar(100)	NULL,		--项目类别
		Ypdm	NVARCHAR(100)	NULL,		--项目代码
		Ypmc	nvarchar(500)	NULL,		--项目内容
		Yznr	nvarchar(500)	NULL,		--医嘱内容
		ActivityId	nvarchar(500)	NULL	--路径节点
	)
	
	
--插入临时表中
	set @tempsqlOne = N'INSERT INTO #TempOrder(Yzbz,Xmlb,Ypdm,Ypmc,Yznr,ActivityId)
	SELECT otp.Yzbz,long.Xmlb,long.Ypdm,long.Ypmc,long.Yznr,otp.ActivityId
	FROM dbo.CP_LongOrder long
	INNER JOIN dbo.CP_OrderToPath otp ON otp.Yzxh = long.Cqyzxh
	WHERE otp.Yzbz = 2703			/*长期医嘱对应*/
	AND long.Syxh = '''+@Syxh+'''	/*须是一个病人*/
	AND otp.Ljxh = '''+@Ljxh+'''	/*该次入径*/
	'
	
	set @tempsqlTwo = N'INSERT INTO #TempOrder(Yzbz,Xmlb,Ypdm,Ypmc,Yznr,ActivityId)
	SELECT otp.Yzbz,temp.Xmlb,temp.Ypdm,temp.Ypmc,temp.Yznr,otp.ActivityId
	FROM dbo.CP_TempOrder temp
	INNER JOIN dbo.CP_OrderToPath otp ON otp.Yzxh = temp.Lsyzxh
	WHERE otp.Yzbz = 2702			/*临时医嘱对应*/
	AND temp.Syxh = '''+@Syxh+'''	/*须是一个病人*/
	AND otp.Ljxh = '''+@Ljxh+'''	/*该次入径*/
	'
	
	print @tempsqlOne
	print @tempsqlTwo
	exec sp_executesql @tempsqlOne
	exec sp_executesql @tempsqlTwo
	
	
--创建成套医嘱（非重复）类别表
	CREATE TABLE #tempDisAdviceGroup
	(
		Xmlb	NVARCHAR(100)	NULL,		--项目类别
		Ypdm	NVARCHAR(100)	COLLATE Chinese_PRC_CI_AS  NULL,		--项目代码
		Ypmc	NVARCHAR(100)	NULL		--项目内容
	)
	
	SET @tempsqlThree = N'
	INSERT INTO #tempDisAdviceGroup
	SELECT DISTINCT Xmlb,Ypdm,Ypmc FROM dbo.CP_AdviceGroupDetail
	'
	
--创建新增医嘱（非重复）类别表
	CREATE TABLE #tempDisOrder
	(
		Xmlb	NVARCHAR(100)	NULL,		--项目类别
		Ypdm	NVARCHAR(100)	COLLATE Chinese_PRC_CI_AS  NULL,		--项目代码
		Ypmc	NVARCHAR(100)	NULL		--项目内容
	)
	
	SET @tempsqlFour = '
	INSERT INTO #tempDisOrder
	SELECT DISTINCT Xmlb,Ypdm,Ypmc FROM #TempOrder
	'
	
	print @tempsqlThree
	print @tempsqlFour
	exec sp_executesql @tempsqlThree
	exec sp_executesql @tempsqlFour
	
--	SELECT * FROM #TempOrder
--	SELECT * FROM #tempDisOrder
--	SELECT * FROM #tempDisAdviceGroup

--创建临时变异表
	CREATE TABLE #tempVariation
	(
		Xmlb	NVARCHAR(100)	NULL,		--项目类别		
		Ypdm	NVARCHAR(100)	COLLATE Chinese_PRC_CI_AS  NULL,		--项目代码
		Ypmc	NVARCHAR(100)	NULL,		--项目内容
		Bynr	nvarchar(100)	NULL,		--变异理由
		PahtDetailID	nvarchar(100)	NULL,--路径节点
	)
	
	SET @tempsqlFive = N'
	INSERT INTO #tempVariation
	SELECT tdo.Xmlb,va.Ypdm,tdo.Ypmc,(REPLACE((REPLACE((ISNULL(va.bynr,'''')),''医嘱【'','''')),''】'','':	'')+'',''+ISNULL(va.Byyy,''''))AS Bynr,va.PahtDetailID
	FROM dbo.CP_VariantRecords va
	INNER JOIN #tempDisOrder tdo ON tdo.Ypdm = va.Ypdm
	WHERE	va.Bylx = 1301				/*新增*/
	AND		va.Syxh = '''+@Syxh+'''		/*必须同一病人*/
	AND		va.Ljxh = '''+@Ljxh+'''		/*必须该次入径*/
	'
	
	SET @tempsqlSix = N'
	INSERT INTO #tempVariation
	SELECT tdo.Xmlb,va.Ypdm,tdo.Ypmc,(REPLACE((REPLACE((ISNULL(va.bynr,'''')),''医嘱【'','''')),''】'','':	'')+'',''+ISNULL(va.Byyy,''''))AS Bynr,va.PahtDetailID
	FROM dbo.CP_VariantRecords va
	INNER JOIN #tempDisAdviceGroup tdo ON tdo.Ypdm = va.Ypdm
	WHERE	va.Bylx = 1300				/*必选未执行，成套医嘱库*/
	AND		va.Syxh = '''+@Syxh+'''		/*必须同一病人*/
	AND		va.Ljxh = '''+@Ljxh+'''		/*必须该次入径*/
	'
	
	print @tempsqlFive
	print @tempsqlSix
	exec sp_executesql @tempsqlFive
	exec sp_executesql @tempsqlSix
	
	SELECT * FROM #TempOrder
	SELECT * FROM #tempVariation
	SELECT enForce.Jddm,detail.Ljmc,enForce.Zxsx,enForce.Jrsj
	FROM CP_InPatientPathEnForceDetail enForce
	INNER JOIN dbo.CP_PathDetail detail ON detail.PahtDetailID = enForce.Jddm
	WHERE enForce.Syxh = @Syxh
	AND enForce.Ljxh = @Ljxh
	ORDER BY enForce.Zxsx DESC
	
	end
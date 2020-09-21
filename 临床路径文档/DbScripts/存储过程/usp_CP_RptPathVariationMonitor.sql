IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_RptPathVariationMonitor' ) 
    DROP PROCEDURE usp_CP_RptPathVariationMonitor
go
CREATE  PROCEDURE [dbo].[usp_CP_RptPathVariationMonitor]

@begindate nvarchar(100) ,--查询开始日期
@enddate nvarchar(100),   --查询结束日期  
@Ljdm nvarchar(100) = ''     --路径代码
AS /**********
[版本号] 1.0.0.0.0               
[创建时间]  2011-04-25             
[作者]    ZM         
[版权]    YidanSoft          
[描述] 8.6	路径监测报表
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
路径监测报表         


[调用的sp]                    
[调用实例]              
		exec usp_CP_RptPathVariationMonitor  '2011-01-12','2011-05-11','P.111.004'
[修改记录]           


----报表需求说明
(5)路径监测报表
统计某段时间内,某路径各节点的变异情况
(1)	查询条件
	时间段
	路径种类
(2)	查询结果
	列表展现 
**********/   


BEGIN     
	DECLARE @tempsqlOne nvarchar(4000)
	DECLARE @tempsqlTwo nvarchar(4000)
	DECLARE @sql nvarchar(4000)       
    SET nocount ON  

--创建执行临时表
	CREATE TABLE #tempEnForce
	(
		Ljdm	VARCHAR(100)	COLLATE Chinese_PRC_CI_AS NULL,--路径代码
		PathDetailId	VARCHAR(100)	NULL--路径节点
	)
SET @tempsqlTwo =  N'insert into #tempEnForce
		SELECT Ljdm,Jddm FROM CP_InPatientPathEnForceDetail
		WHERE
		Ljdm = '''+@Ljdm+'''
		and Jrsj >= '''+@begindate+'''
		and Jrsj <= '''+@enddate+'''
'

--创建变异临时表
	create table #tempVariantRecords
	(
		Ljdm	varchar(100)	COLLATE Chinese_PRC_CI_AS NULL,--路径代码
		PathDetailId	varchar(100)	NULL--路径节点
	)
	
--插入临时表中
set @tempsqlOne = N'insert into #tempVariantRecords
		select Ljdm,PahtDetailID from CP_VariantRecords
		where 
		Ljdm = '''+@Ljdm+'''
		and Bysj >= '''+@begindate+'''
		and Bysj <= '''+@enddate+'''
		'

	print @tempsqlOne
	exec sp_executesql @tempsqlOne
	print @tempsqlTwo
	exec sp_executesql @tempsqlTwo
	
--更新路径监控

--创建表
	CREATE TABLE #tempPathVariationMonitor
	(
		Ljmc			VARCHAR(100)		COLLATE Chinese_PRC_CI_AS NULL,--路径节点名
		PahtDetail		VARCHAR(100)		NULL,--路径节点ID
		enForceCount	INT					NULL,--执行数
		variationCount	INT					NULL,--变异数
		per				DECIMAL				NULL	--差异率
	)
	
--插入节点名
	set @sql = N'INSERT INTO #tempPathVariationMonitor(Ljmc,PahtDetail)
	SELECT Ljmc,PahtDetailID FROM CP_PathDetail
	WHERE Ljdm = '''+@Ljdm+'''
	'
	
	print @sql
	exec sp_executesql @sql 
	
--更新数据
	UPDATE #tempPathVariationMonitor SET enForceCount = 
	ISNULL((SELECT COUNT(*) FROM #tempEnForce temp 
	WHERE temp.PathDetailId = PahtDetail),0)
	
	UPDATE #tempPathVariationMonitor SET variationCount = 
	ISNULL((SELECT COUNT(*) FROM #tempVariantRecords temp 
	WHERE temp.PathDetailId = PahtDetail),0)
	
--返回最终查询结果
--select * from #tempPathVariationMonitor
	SELECT  '入院' as Ljmc,'0ec62159-941e-4050-995f-d287fbae82ae' as PahtDetail,43 AS enForceCount,40 as variationCount
	UNION	select '入院第一天','46cc46cf-2f80-486c-84f9-410590dafe8d',87,45
	UNION	select '（手术准备日）','56a0ca57-0bbb-4a7f-a6f0-f0a8f32ff697',34,23
	UNION	select '（手术日）','7245314f-4f87-41bf-8280-878e6801e0fe',25,22
	UNION	select '(术后第一天)','9290165c-8e5f-4c92-a416-4ca1b6af41f0',53,45
	UNION	select '术后第二天','b2f31f11-5f87-471d-99a2-15dceed19b88',21,12
	UNION	select '术后第三天','c8a93211-e97f-4405-9a7d-78158ba98a8d',56,11
	UNION	select '术后第四天','e0069b60-5152-49ed-a731-2781945610bc',33,21
	UNION	select '出院','fe4e66f5-647e-4d60-b490-6d28d0e8d3c5',11,8
	
END

GO
IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_RptPathVariationAnalyse' ) 
    DROP PROCEDURE usp_CP_RptPathVariationAnalyse
go
CREATE  PROCEDURE [dbo].[usp_CP_RptPathVariationAnalyse]

@begindate nvarchar(100) ,--查询开始日期
@enddate nvarchar(100),   --查询结束日期  
@dept nvarchar(12) = '',       --临床科室 
@Ljdm nvarchar(100) = ''     --路径代码
AS /**********    
[版本号] 1.0.0.0.0               
[创建时间]  2011-04-26              
[作者]    ZM         
[版权]    YidanSoft          
[描述] 8.8	变异情况分析
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
变异情况分析          


[调用的sp]                    
[调用实例]              
exec usp_CP_RptPathVariationAnalyse  '2011','2012','',''           
[修改记录]           


----报表需求说明
(5)变异情况分析
统计某段时间内,路径的变异分类情况
(1)	查询条件
	时间段
	路径种类
	临床科室
(2)	查询结果
	列表展现 
	统计图显示
**********/

BEGIN     
	DECLARE @tempsql nvarchar(4000)
	DECLARE @sql nvarchar(4000)       
    SET nocount ON 
    
    
--创建左侧临时表
		create table #tempPathVariation
		(
			BydmSt		VARCHAR(100)		NULL, --一级编码代码
			BymcSt		VARCHAR(100)		NULL,--一级编码名称
			St			VARCHAR(100)		COLLATE Chinese_PRC_CI_AS NULL,--一级编码缩写字段
			BydmNd		VARCHAR(100)		COLLATE Chinese_PRC_CI_AS NULL, --二级编码代码
			BymcNd		VARCHAR(100)		NULL,--二级编码名称
			Nd			VARCHAR(100)		COLLATE Chinese_PRC_CI_AS NULL,--二级编码缩写字段
			BydmRd		VARCHAR(100)		COLLATE Chinese_PRC_CI_AS NULL, --三级编码代码
			BymcRd		VARCHAR(100)		NULL,--三级编码名称
		)
--创建二级临时表
		create table #tempPathVariationNd
		(
			BydmNd		VARCHAR(100)		COLLATE Chinese_PRC_CI_AS null, --二级编码代码
			BymcNd		VARCHAR(100)		NULL,--二级编码名称
		)
--创建一级临时表
		create table #tempPathVariationSt
		(
			BydmSt		VARCHAR(100)		COLLATE Chinese_PRC_CI_AS null, --一级编码代码
			BymcSt		VARCHAR(100)		NULL--一级编码名称
		)


--插入左侧临时表中
--(多级显示)
		insert into #tempPathVariation(BydmRd,BymcRd,Nd,St)
		SELECT Bydm,Bymc,REPLACE(SUBSTRING(Bydm,1,7),'.',''),SUBSTRING(Bydm,1,3) FROM dbo.CP_PathVariation
		WHERE LEN(Bydm) = 11
--插入二级临时表中		
		insert into #tempPathVariationNd(BydmNd,BymcNd)
		SELECT REPLACE(Bydm,'.',''),Bymc FROM dbo.CP_PathVariation
		WHERE LEN(Bydm) = 7
--插入一级临时表中	
		INSERT INTO #tempPathVariationSt(BydmSt,BymcSt)
		SELECT Bydm,Bymc FROM dbo.CP_PathVariation
		WHERE LEN(Bydm) = 3
--更新左侧临时表二级数据	
		UPDATE #tempPathVariation SET BydmNd = (
		SELECT BydmNd FROM #tempPathVariationNd tempNd
		WHERE tempNd.BydmNd = Nd
		)	
		UPDATE #tempPathVariation SET BymcNd = (
		SELECT BymcNd FROM #tempPathVariationNd tempNd
		WHERE tempNd.BydmNd = Nd
		)
--更新左侧临时表一级数据		
		UPDATE #tempPathVariation SET BydmSt = (
		SELECT BydmSt FROM #tempPathVariationSt tempSt
		WHERE tempSt.BydmSt = St
		)
		UPDATE #tempPathVariation SET BymcSt = (
		SELECT BymcSt FROM #tempPathVariationSt tempSt
		WHERE tempSt.BydmSt = St
		)
		
--创建记录表临时表
		CREATE TABLE #tempVariantRecords
		(
			BydmId	VARCHAR(100)	COLLATE Chinese_PRC_CI_AS NOT null, --变异代码
			Ljxh	VARCHAR(100)	NULL--路径序号
		)

--插入临时表中
		set @tempsql = N'INSERT INTO #tempVariantRecords(BydmId,Ljxh)
		SELECT variantRecords.Bydm,variantRecords.Ljxh
		FROM dbo.CP_VariantRecords 
		variantRecords
		LEFT JOIN dbo.CP_ClinicalPath clinicalPath ON clinicalPath.ljdm = variantRecords.Ljdm
		WHERE Bysj >= '''+@begindate+'''
		AND bysj <= '''+@enddate+'''
		'

--临床科室
	IF @dept<>''
	begin
		SET @tempsql = @tempsql + N' and clinicalPath.Syks in('''+@dept+''')'
	END


--路径代码				
	IF @Ljdm<>''
	BEGIN
		SET @tempsql = @tempsql + N' and clinicalPath.Ljdm in('+replace(@Ljdm,'~','''')+')'
	END


	print @tempsql
	exec sp_executesql @tempsql



--更新变异情况分析

--创建表
		CREATE TABLE #tempPathVariationAnalyse
		(
			Bydm	VARCHAR(100)	COLLATE Chinese_PRC_CI_AS null, --变异代码
			BymcSt		VARCHAR(100)		NULL,--一级编码名称
			BymcNd		VARCHAR(100)		NULL,--二级编码名称
			BymcRd		VARCHAR(100)		NULL,--三级编码名称
			VariationCount	INT				NULL--数目
		)
		
--插入左侧表
		

		set @sql = N'INSERT INTO #tempPathVariationAnalyse(Bydm ,BymcSt ,BymcNd ,BymcRd)
		SELECT BydmRd,BymcSt,BymcNd,BymcRd FROM #tempPathVariation
		'
		
		print @sql
		exec sp_executesql @sql
		
		
--更新数据
		UPDATE #tempPathVariationAnalyse SET VariationCount = 
		(
			SELECT COUNT(*) 
			FROM #tempVariantRecords vr WHERE vr.BydmId = Bydm
		)

--返回最终查询结果
--SELECT * FROM #tempPathVariationAnalyse
SELECT  'D01.001.001' as Bydm,'医生变异' as BymcSt,'人为' AS BymcNd,'伤口溃烂' AS BymcRd,23 as VariationCount
	UNION	select 'D01.001.002','患者变异','人为','患者拒绝',45
	UNION	select 'D01.D01.D02','医生变异','人为','医生变异001.002',24
	UNION	select 'D01.D01.D03','医生变异','恶化','医生停用',45
	UNION	select 'D01.D01.D04','医生变异','恶化','医生没开',44
	UNION	select 'D01.D01.D05','患者变异','恶化','花费',45
	UNION	select 'D01.D01.D06','患者变异','恶化','不耐受',23
	UNION	select 'D01.D01.D07','医生变异','恶化','不详',45
	UNION	select 'D01.D01.D08','医生变异','恶化','己经使用',32
	UNION	select 'D01.D01.D09','医生变异','恶化','病情变化',43

END
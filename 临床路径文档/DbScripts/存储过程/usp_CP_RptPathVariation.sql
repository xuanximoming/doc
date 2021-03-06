IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_RptPathVariation' ) 
    DROP PROCEDURE usp_CP_RptPathVariation
go
CREATE  PROCEDURE [dbo].[usp_CP_RptPathVariation] 

@begindate VARCHAR(40) ,--查询开始日期
@enddate VARCHAR(40),   --查询结束日期  
@Ljdm varchar(40) ,      --路径代码(暂时无用)
@dept VARCHAR(40)        --临床科室 
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]  2010-11-16              
[作者]    yxy          
[版权]    YidanSoft          
[描述] 路径变异原因统计分析   
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
路径变异原因统计数据集              
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_RptPathVariation   '2010-01-01 00:00:00','2010-12-31','P.K62.001',''            
[修改记录]            
    
----报表需求说明

1)	路径变异原因统计分析
统计某个时间段内，已完成的临床路径执行变异原因，并做相关分析
(1)	查询条件
	时间段
	路径种类
	临床科室
(2)	查询结果
	列表展现
          列表显示查询结果，结果集包括:变异类别、变异个数、科室、路径名称，按照变异类别分组
	饼状图分析    

**********/     
BEGIN     
	DECLARE @sql nvarchar(4000)       
    SET nocount ON    



	SELECT Dept.Name DeptName, ClinicalPath.Name PathName,
			pathvariation.Bymc VariationName,
			(CASE variantrecords.Bylb when '1200' THEN '医嘱' when '1201' THEN '护理' 
			WHEN '1203' then '诊疗计划' else '未知' end) VariationType,
			count(1) VariationCount
		FROM CP_InPathPatient inpathpatient
			LEFT JOIN CP_ClinicalPath ClinicalPath on inpathpatient.Ljdm =  ClinicalPath.Ljdm
			LEFT JOIN CP_VariantRecords variantrecords on variantrecords.Ljxh = inpathpatient.Id
			inner JOIN CP_PathVariation pathvariation on variantrecords.bydm = pathvariation.Bydm
			LEFT JOIN CP_Department Dept on ClinicalPath.Syks = Dept.Ksdm
			WHERE inpathpatient.Ljzt = 3
			AND inpathpatient.Wcsj >= @begindate
			AND inpathpatient.Wcsj <= @enddate
			and (@dept = '' or ClinicalPath.Syks = @dept)
			and (@Ljdm = '' or ClinicalPath.Ljdm = @Ljdm)
			GROUP BY ClinicalPath.Name,pathvariation.Bymc,variantrecords.Bylb,Dept.Name
	

	
	----测试饼图显示效果模拟数据
	
--	SELECT  '外科1' as DeptName,'直肠息肉临床路径2' as PathName,
--					'病患拒绝' as VariationName, '医嘱' VariationType,
--					'5' VariationCount
--	UNION
--	SELECT  '外科2' as DeptName,'直肠息肉临床路径2' as PathName,
--				'病患拒绝' as VariationName, '护理' VariationType,
--				'10' VariationCount
--	UNION
--	SELECT  '外科3' as DeptName,'直肠息肉临床路径2' as PathName,
--				'病患拒绝' as VariationName, '诊疗计划' VariationType,
--				'17' VariationCount
-- 

END 

go
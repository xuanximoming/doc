
IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_QCRecord' ) 
    DROP PROCEDURE usp_CP_QCRecord
go
CREATE  PROCEDURE [dbo].[usp_CP_QCRecord] 
@StartDate varchar(19),      --开始日期(带时间：2010-01-01 00:00:00)
@EndDate VARCHAR(19)         --结束日期(带时间：2010-02-01 23:59:59)
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]  2010-11-29             
[作者]    hjh          
[版权]    YidanSoft          
[描述] 
[功能说明]查询待执行病历提示或警告
[输入参数]开始日期和结束日期 （可以都为空）              
[输出参数]                   
[结果集、排序]              
             
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_QCRecord '2010-10-09 00:00:00','2010-11-11 23:59:59'  
 exec usp_CP_QCRecord '','' 
[修改记录]            
    

**********/     
BEGIN    
    
	DECLARE @sql nvarchar(4000)
	DECLARE @currdate VARCHAR(19)
    SET nocount ON 
    SET @currdate=CONVERT(VARCHAR(19),GETDATE(),120)
    --返回值：序号、病人序号、病人名称、路径代码、路径名称、床位医生ID、床位医生姓名、
    --        进入时间、退出时间、完成时间、当天步骤天数、路径状态、条件成立时间、提示或警告信息
    SET @sql='SELECT t1.Id,t1.Syxh,t2.Hzxm,t1.Ljdm,t3.Name Ljmc,t1.Cwys,t4.Name  Ysxm,t1.Jrsj,t1.Tcsj,
         t1.Wcsj,t1.Ljts,t1.Ljzt,v.ConditionTime Tjsj,v.MessageInfo Blts
		 FROM YidanEMR..V_QCRecord v  JOIN CP_InPathPatient t1 ON t1.Syxh=v.Syxh
			LEFT JOIN CP_InPatient t2 ON t1.Syxh=t2.Syxh 
			LEFT JOIN CP_ClinicalPath t3 ON t1.Ljdm=t3.Ljdm 
			LEFT JOIN CP_Employee t4 ON t1.Cwys=t4.Zgdm 
		 WHERE t1.Ljzt=1 ' 
		
	 --开始日期不为空,日期格式为：2010-01-01 或2010-01-01 01:01:01  
    IF ( @StartDate<>'')
    BEGIN
		SET @sql=@sql+' AND v.ConditionTime>='''+@StartDate+''' '  --日期处理
	END
	
	 --结束日期不为空,日期格式为：2010-01-01 或2010-01-01 01:01:01  
	IF ( @EndDate<>'') 
    BEGIN
		SET @sql=@sql+' AND v.ConditionTime<='''+@EndDate+''' '  --日期处理
	END
	
	 --已退出时间为排序
	SET @sql=@sql+' ORDER BY t1.Jrsj' 
	
	--测试数据（开始）
	--SET @sql='SELECT ''3'' Id,''7'' Syxh,''章永达'' Hzxm,''P.K62.001'' Ljdm,''直肠息肉临床路径2'' Ljmc,''00'' Cwys,''supervisor'' Ysxm,''2010-11-10 10:06:00'' Jrsj,''NULL'' Tcsj,
    --     ''NULL'' Wcsj,''1'' Ljts,''1'' Ljzt,''2010-11-20 10:06:00'' Tjsj,''提示：给病人喂药'' Blts ' 
	--测试数据（结束）
		 
	print @sql
	exec sp_executesql @sql       
END 






















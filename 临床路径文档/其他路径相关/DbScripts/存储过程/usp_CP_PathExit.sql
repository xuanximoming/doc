
IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_PathExit' ) 
    DROP PROCEDURE usp_CP_PathExit
go
CREATE  PROCEDURE [dbo].[usp_CP_PathExit] 
@StartDate varchar(19),      --开始日期(带时间：2010-01-01 00:00:00)
@EndDate VARCHAR(19)        --结束日期(带时间：2010-02-01 23:59:59)
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]  2010-11-29             
[作者]    hjh          
[版权]    YidanSoft          
[描述] 
[功能说明]查询临床路径中途退出的病人信息                     
[输入参数]开始日期和结束日期 （可以都为空）              
[输出参数]                   
[结果集、排序]              
             
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_PathExit '2010-10-09 00:00:00','2010-11-11 23:59:59'  
 exec usp_CP_PathExit '',''
[修改记录]            
    

**********/     
BEGIN    
    
	DECLARE @sql nvarchar(4000)
    SET nocount ON 
     --返回值：序号、病人序号、病人名称、路径代码、路径名称、床位医生ID、床位医生姓名、
    --        进入时间、退出时间、完成时间、当天步骤天数、路径状态
    SET @sql=N'SELECT t1.Id,t1.Syxh,t2.Hzxm,t1.Ljdm,t3.Name Ljmc,t1.Cwys,t4.Name Ysxm,t1.Jrsj,t1.Tcsj,t1.Wcsj,t1.Ljts,t1.Ljzt 
		 FROM CP_InPathPatient t1 LEFT JOIN CP_InPatient t2 ON t1.Syxh=t2.Syxh 
			LEFT JOIN CP_ClinicalPath t3 ON t1.Ljdm=t3.Ljdm
			LEFT JOIN CP_Employee t4 ON t1.Cwys=t4.Zgdm 
		 WHERE t1.Ljzt=2 '
	 
	 --开始日期不为空 
    IF ( @StartDate<>'')
    BEGIN
		SET @sql=@sql+' AND t1.Tcsj>='''+@StartDate+''' '  --日期处理
	END
	
	 --结束日期不为空 
	IF ( @EndDate<>'') 
    BEGIN
		SET @sql=@sql+' AND t1.Tcsj<='''+@EndDate+''' '  --日期处理
	END
	
	 --已退出时间为排序
	SET @sql=@sql+' ORDER BY t1.Tcsj' 
	
	print @sql
	exec sp_executesql @sql       
END 























IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_ForceToPath' ) 
    DROP PROCEDURE usp_CP_ForceToPath
go
CREATE  PROCEDURE [dbo].[usp_CP_ForceToPath]
--强制进入时间
@StartDate varchar(19),      --开始日期
@EndDate VARCHAR(19)         --结束日期
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]  2010-11-29             
[作者]    hjh          
[版权]    YidanSoft          
[描述] 
[功能说明]查询强制进入路径的病人                  
[输入参数]开始日期和结束日期 （可以都为空）              
[输出参数]                   
[结果集、排序]              
             
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_ForceToPath '2010-10-09','2010-11-11'   
[修改记录]            
    

**********/     
BEGIN    
    
	DECLARE @sql nvarchar(4000)
    SET nocount ON 
     --返回值：序号、病人序号、病人名称、路径代码、路径名称、床位医生ID、床位医生姓名、
    --        进入时间、退出时间、完成时间、当天步骤天数、路径状态、牵制进入条件
    SET @sql=N'SELECT t1.Id,t1.Syxh,t2.Hzxm,t1.Ljdm,t3.Name Ljmc,t1.Cwys,t5.Name Ysxm,t1.Jrsj,
         t1.Tcsj,t1.Wcsj,t1.Ljts,t1.Ljzt,t4.Memo 
		 FROM CP_InPathPatient t1 LEFT JOIN CP_InPatient t2 ON t1.Syxh=t2.Syxh 
			LEFT JOIN CP_ClinicalPath t3 ON t1.Ljdm=t3.Ljdm
			LEFT JOIN CP_InPathPatientCondition t4 ON t1.Id=t4.Ljxh
			LEFT JOIN CP_Employee t5 ON t1.Cwys=t5.Zgdm '
	 
	 --开始日期不为空,日期格式为：2010-01-01 或2010-01-01 01:01:01  
    IF ( LEN(@StartDate)=19 OR LEN(@StartDate)=10)
    BEGIN
		SET @sql=@sql+' AND t1.Jrsj>='''+LEFT(@StartDate,10) +' 00:00:00'' '  --日期处理
	END
	
	 --结束日期不为空,日期格式为：2010-01-01 或2010-01-01 01:01:01  
	IF ( LEN(@EndDate)=19 OR LEN(@EndDate)=10) 
    BEGIN
		SET @sql=@sql+' AND t1.Jrsj<='''+LEFT(@EndDate,10)+' 23:59:59'' '  --日期处理
	END
	
	 --已退出时间为排序
	SET @sql=@sql+' ORDER BY t1.Jrsj' 
	
	print @sql
	exec sp_executesql @sql       
END 




















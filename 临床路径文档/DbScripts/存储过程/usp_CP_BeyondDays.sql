
IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_BeyondDays' ) 
    DROP PROCEDURE usp_CP_BeyondDays
go
CREATE  PROCEDURE [dbo].[usp_CP_BeyondDays] 
@Days NVARCHAR(20)     --最近Days天数住院天数超标
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]  2010-11-29             
[作者]    hjh          
[版权]    YidanSoft          
[描述] 
[功能说明]查询超出标注住院天数的住院病人                    
[输入参数]          
[输出参数]                   
[结果集、排序]              
             
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_BeyondDays '0'
[修改记录]            
    

**********/     
BEGIN    
    
	DECLARE @sql nvarchar(4000)
	DECLARE @currdate VARCHAR(19)
    SET nocount ON 
    SET @currdate=CONVERT(VARCHAR(19),GETDATE(),120)
    --返回值：序号、病人序号、病人名称、路径代码、路径名称、床位医生ID、床位医生姓名、
    --        进入时间、退出时间、完成时间、当天步骤天数、路径状态、路径标准住院时间、实际住院时间 、住院超出时间
    SET @sql='SELECT t1.Id,t1.Syxh,t2.Hzxm,t1.Ljdm,t3.Name Ljmc,t1.Cwys,t4.Name  Ysxm,t1.Jrsj,t1.Tcsj,
         t1.Wcsj,t1.Ljts,t1.Ljzt,t3.Zgts,DATEDIFF(DAY,t1.Jrsj,'''+@currdate+''') Sjts, DATEDIFF(DAY,t1.Jrsj,'''+@currdate+''')-t3.Zgts Ccts
		 FROM CP_InPathPatient t1 LEFT JOIN CP_InPatient t2 ON t1.Syxh=t2.Syxh 
			LEFT JOIN CP_ClinicalPath t3 ON t1.Ljdm=t3.Ljdm 
			LEFT JOIN CP_Employee t4 ON t1.Cwys=t4.Zgdm 
		 WHERE DATEDIFF(DAY,t1.Jrsj,'''+@currdate+''')>t3.Zgts and t1.Ljzt=1 ' 
		
	 PRINT @Days
	 --最近Days天超标的 
    IF (@Days>0)
		BEGIN
			SET @sql=@sql+' and (DATEDIFF(DAY,t1.Jrsj,'''+@currdate+''')-t3.Zgts)<='+@Days +' '
		END
	
	
	
	 --已退出时间为排序
	SET @sql=@sql+' ORDER BY t1.Jrsj' 
	
	print @sql
	exec sp_executesql @sql       
END 





















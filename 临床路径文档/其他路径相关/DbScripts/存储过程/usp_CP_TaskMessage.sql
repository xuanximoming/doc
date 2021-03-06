IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_TaskMessage' ) 
    DROP PROCEDURE usp_CP_TaskMessage
go
CREATE  PROCEDURE [dbo].[usp_CP_TaskMessage] 

@DoctorID VARCHAR(40) ,	 --医生编码
@Rwzt VARCHAR(40),		 --任务状态  
@Day varchar(40)	     --任务日期
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]  2010-12-22              
[作者]    yxy          
[版权]    YidanSoft          
[描述] 查询任务信息 
[功能说明]                    
[输入参数]               
[输出参数]                    
           
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_TaskMessage   '00','0','2010-12-22'            
[修改记录]            

**********/     
BEGIN     
	DECLARE @sql nvarchar(4000)       
    SET nocount ON   
    
	select CP_InPatient.Syxh,
	CP_InPatient.Hzxm,
	CP_InPatient.Cycw,
	CP_ClinicalPath.Name Ljmc,
	CP_Employee.Name Ysxm,
	dbo.CP_DataCategoryDetail.Name Yzlb,
	CP_DoctorTaskMessage.Mess,
	CP_DoctorTaskMessage.Yqsj,
	case when CP_DoctorTaskMessage.Rwzt = 0 then '未完成' else '已完成' end as Rwzt,
	(case when CONVERT(CHAR(8),CP_DoctorTaskMessage.Yqsj,24) < '08:00:00' then '00:00:00~08:00:00'
	when CONVERT(CHAR(8),CP_DoctorTaskMessage.Yqsj,24) < '10:00:00' and CONVERT(CHAR(8),CP_DoctorTaskMessage.Yqsj,24) >= '08:00:00' then '08:00:00~10:00:00'
	when CONVERT(CHAR(8),CP_DoctorTaskMessage.Yqsj,24) < '12:00:00' and CONVERT(CHAR(8),CP_DoctorTaskMessage.Yqsj,24) >= '10:00:00' then '10:00:00~12:00:00'
	when CONVERT(CHAR(8),CP_DoctorTaskMessage.Yqsj,24) < '14:00:00' and CONVERT(CHAR(8),CP_DoctorTaskMessage.Yqsj,24) >= '12:00:00' then '12:00:00~14:00:00'
	when CONVERT(CHAR(8),CP_DoctorTaskMessage.Yqsj,24) < '16:00:00' and CONVERT(CHAR(8),CP_DoctorTaskMessage.Yqsj,24) >= '14:00:00' then '14:00:00~16:00:00'
	when CONVERT(CHAR(8),CP_DoctorTaskMessage.Yqsj,24) < '18:00:00' and CONVERT(CHAR(8),CP_DoctorTaskMessage.Yqsj,24) >= '16:00:00' then '16:00:00~18:00:00'
	when CONVERT(CHAR(8),CP_DoctorTaskMessage.Yqsj,24) < '20:00:00' and CONVERT(CHAR(8),CP_DoctorTaskMessage.Yqsj,24) >= '18:00:00' then '18:00:00~20:00:00'
	when CONVERT(CHAR(8),CP_DoctorTaskMessage.Yqsj,24) < '22:00:00' and CONVERT(CHAR(8),CP_DoctorTaskMessage.Yqsj,24) >= '20:00:00' then '20:00:00~22:00:00'
	when CONVERT(CHAR(8),CP_DoctorTaskMessage.Yqsj,24) < '24:00:00' and CONVERT(CHAR(8),CP_DoctorTaskMessage.Yqsj,24) >= '22:00:00' then '22:00:00~24:00:00'
	else '' end) as group_col
	from CP_DoctorTaskMessage 
	left join CP_InPatient on CP_DoctorTaskMessage.Syxh = CP_InPatient.Syxh
	left join CP_ClinicalPath on CP_DoctorTaskMessage.Ljdm = CP_ClinicalPath.Ljdm
	left join CP_Employee on CP_Employee.Zgdm = CP_InPatient.Zyys
	left join dbo.CP_DoctorTaskSet on dbo.CP_DoctorTaskSet.ID = dbo.CP_DoctorTaskMessage.SetID
	left join dbo.CP_DataCategoryDetail on dbo.CP_DoctorTaskSet.Yzlb = dbo.CP_DataCategoryDetail.Mxbh
	where (@DoctorID = '' 
			or CP_DoctorTaskMessage.Ysbm = @DoctorID)
	and (@Rwzt = '' 
		or CP_DoctorTaskMessage.Rwzt = @Rwzt )
	and (@Day = ''
		or CONVERT(CHAR(10),CP_DoctorTaskMessage.Yqsj,23) = @Day) 
	and dbo.CP_DoctorTaskSet.Yxjl = 1
	order by CP_DoctorTaskMessage.Yqsj 
	
 
END 











if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_GetNurToPathInfo' ) 
    drop procedure usp_CP_GetNurToPathInfo
GO
create  procedure [dbo].usp_CP_GetNurToPathInfo 
@Ljdm varchar(12),
@PathDetailId varchar(50)
as /**********                    
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 获取临床护理对应路径结点信息
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]                  
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_InsertNurExecToPath  
[修改记录]            
**********/       

    select  *
    from    dbo.CP_NurExecToPath
    where   Ljdm = @Ljdm and PathDetailId = @PathDetailId
            and Yxjl = 1

go





if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_CancelNurExecRecord' ) 
    drop procedure usp_CP_CancelNurExecRecord
GO
create  procedure [dbo].usp_CP_CancelNurExecRecord
    @NurRecordId numeric ,
    @User varchar(10)
as /**********                    
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 获取临床护理对应路径结点执行信息
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]                  
             
[调用的sp]                    
[调用实例]              
 
[修改记录]            
**********/    

    update  dbo.CP_NurExecRecord
    set     Yxjl = 0 ,
            Cancel_Time = convert(varchar(19), getdate(), 120) ,
            Cancel_User = @User
    where   Id = @NurRecordId

go


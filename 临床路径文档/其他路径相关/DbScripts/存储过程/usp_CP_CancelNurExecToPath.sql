
if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_CancelNurExecToPath' ) 
    drop procedure usp_CP_CancelNurExecToPath
GO
create  procedure [dbo].usp_CP_CancelNurExecToPath
    @Id numeric ,
    @User varchar(10)
as /**********                    
[�汾��] 1.0.0.0.0               
[����ʱ��]                
[����]              
[��Ȩ]                     
[����] ȡ���ٴ������Ӧ·�������Ϣ
[����˵��]                    
[�������]               
[�������]                    
[�����������]                  
             
[���õ�sp]                    
[����ʵ��]              
 exec usp_CP_CancelNurExecToPath 0,'00'  
[�޸ļ�¼]            
**********/       

 
    update  dbo.CP_NurExecToPath
    set     Cancel_Time = convert(varchar(19), getdate(), 120) ,
            Cancel_User = @User ,
            Yxjl = 0
    where   Id = @Id
go





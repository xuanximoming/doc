if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_GetNurToPathInfo' ) 
    drop procedure usp_CP_GetNurToPathInfo
GO
create  procedure [dbo].usp_CP_GetNurToPathInfo 
@Ljdm varchar(12),
@PathDetailId varchar(50)
as /**********                    
[�汾��] 1.0.0.0.0               
[����ʱ��]                
[����]              
[��Ȩ]                     
[����] ��ȡ�ٴ������Ӧ·�������Ϣ
[����˵��]                    
[�������]               
[�������]                    
[�����������]                  
             
[���õ�sp]                    
[����ʵ��]              
 exec usp_CP_InsertNurExecToPath  
[�޸ļ�¼]            
**********/       

    select  *
    from    dbo.CP_NurExecToPath
    where   Ljdm = @Ljdm and PathDetailId = @PathDetailId
            and Yxjl = 1

go







if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_GetVariationToPathInfo' ) 
    drop procedure usp_CP_GetVariationToPathInfo
GO
create  procedure [dbo].usp_CP_GetVariationToPathInfo
    @ActivityId varchar(50)
as /**********                    
[�汾��] 1.0.0.0.0               
[����ʱ��]                
[����]              
[��Ȩ]                     
[����] ��ȡ�ٴ�����·������Ӧ���쳣��Ϣ
[����˵��]                    
[�������]               
[�������]                    
[�����������]                  
             
[���õ�sp]                    
[����ʵ��]              
 
[�޸ļ�¼]            
**********/ 
    select  *
    from    dbo.CP_VariationToPath
    where   ActivityId = @ActivityId
            and Yxjl = 1
go


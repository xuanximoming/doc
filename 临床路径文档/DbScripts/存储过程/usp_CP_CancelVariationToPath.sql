
if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_CancelVariationToPath' ) 
    drop procedure usp_CP_CancelVariationToPath
GO
create  procedure [dbo].usp_CP_CancelVariationToPath
    @Id numeric ,
    @User varchar(10)
as /**********                    
[�汾��] 1.0.0.0.0               
[����ʱ��]                
[����]              
[��Ȩ]                     
[����] ��ȡ�ٴ������Ӧ·�����ִ����Ϣ
[����˵��]                    
[�������]               
[�������]                    
[�����������]                  
             
[���õ�sp]                    
[����ʵ��]              
 
[�޸ļ�¼]            
**********/    
    update  dbo.CP_VariationToPath
    set     Yxjl = 0 ,
            Cancel_Time = convert(varchar(19), getdate(), 120) ,
            Cancel_User = @User
    where   Id = @Id

go


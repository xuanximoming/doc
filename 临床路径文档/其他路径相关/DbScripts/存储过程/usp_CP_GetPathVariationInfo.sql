if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_GetPathVariationInfo' ) 
    drop procedure usp_CP_GetPathVariationInfo
GO
create  procedure [dbo].usp_CP_GetPathVariationInfo
as /**********                    
[�汾��] 1.0.0.0.0               
[����ʱ��]                
[����]              
[��Ȩ]                     
[����] ��ȡ�ٴ�����·������Ӧ�Ļ����쳣��Ϣ
[����˵��]                    
[�������]               
[�������]                    
[�����������]                  
             
[���õ�sp]                    
[����ʵ��]              
 
[�޸ļ�¼]            
**********/    

    select  *
    from    dbo.CP_PathVariation
    where   len(Bydm) = 11
            and Yxjl = 1 ;

go


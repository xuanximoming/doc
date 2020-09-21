if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_InsertVariationToPath' ) 
    drop procedure usp_CP_InsertVariationToPath
GO
create  procedure [dbo].usp_CP_InsertVariationToPath
    @Ljdm varchar(12) ,
    @ActivityId varchar(50) ,
    @Bydm varchar(12) ,
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

    insert  into dbo.CP_VariationToPath
            ( Ljdm, ActivityId, Bydm, Create_User )
    values  ( @Ljdm, -- Ljdm - varchar(12)
              @ActivityId, @Bydm, -- Bydm - varchar(12)
              @User  -- 
              )

go


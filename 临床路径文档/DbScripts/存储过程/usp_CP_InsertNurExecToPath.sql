


if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_InsertNurExecToPath' ) 
    drop procedure usp_CP_InsertNurExecToPath
GO
create  procedure [dbo].usp_CP_InsertNurExecToPath
    @Ljdm varchar(12) ,
    @PathDetailId varchar(50) ,
    @Mxxh varchar(50) ,
    @User varchar(10)
as /**********                    
[�汾��] 1.0.0.0.0               
[����ʱ��]                
[����]              
[��Ȩ]                     
[����] �����ٴ������Ӧ·�������Ϣ
[����˵��]                    
[�������]               
[�������]                    
[�����������]                  
             
[���õ�sp]                    
[����ʵ��]              
 exec usp_CP_InsertNurExecToPath  
[�޸ļ�¼]            
**********/       

    insert  into dbo.CP_NurExecToPath
            ( Ljdm ,
              PathDetailId ,
              Mxxh ,
              Yxjl ,
              Create_User 
            )
    values  ( @Ljdm , -- Ljdm - varchar(12)
              @PathDetailId , -- PathDetailId - varchar(50)
              @Mxxh , -- Mxxh - varchar(12)
              1 , -- Yxjl - smallint
              @User -- Create_User - varchar(10)
            )
go





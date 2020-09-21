if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_InsertNurExecRecord' ) 
    drop procedure usp_CP_InsertNurExecRecord
GO
CREATE  procedure [dbo].[usp_CP_InsertNurExecRecord]
	@Id VARCHAR(50),
    @Syxh numeric ,
    @Ljxh numeric ,
    @Ljdm varchar(50) ,
    @PathDetailId varchar(50) ,
    @Mxxh varchar(50) ,
    @User varchar(10)
AS  
/**********                    
[�汾��] 1.0.0.0.0               
[����ʱ��]                
[����]  dxj            
[��Ȩ]                     
[����] �ٴ������Ӧ·�����ִ����Ϣ
[����˵��]                    
[�������]               
[�������]                    
[�����������]                  
             
[���õ�sp]                    
[����ʵ��]              
 
[�޸ļ�¼]            
**********/    
BEGIN
	IF NOT EXISTS(SELECT * FROM CP_NurExecRecord WHERE Syxh=@Syxh AND Ljdm =@Ljdm AND PathDetailId=@PathDetailId AND  Mxxh=@Mxxh)
	INSERT INTO [YidanEHR].[dbo].[CP_NurExecRecord]
           ([Id]
           ,[Syxh]
           ,[Ljxh]
           ,[Ljdm]
           ,[PathDetailId]
           ,[Mxxh]
           ,[Yxjl]
           ,[Create_User])
     VALUES
			( @Id,
			  @Syxh , -- Syxh - numeric
              @Ljxh , -- Ljxh - numeric
              @Ljdm , -- Ljdm - varchar(12)
              @PathDetailId , -- PathDetailId - varchar(50)
              @Mxxh , -- Value - varchar(600)
              1 , -- Yxjl - smallint
              @User  -- Create_User - varchar(10)
            )
END

GO

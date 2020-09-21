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
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]  dxj            
[版权]                     
[描述] 临床护理对应路径结点执行信息
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]                  
             
[调用的sp]                    
[调用实例]              
 
[修改记录]            
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

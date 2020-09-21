


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
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 插入临床护理对应路径结点信息
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]                  
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_InsertNurExecToPath  
[修改记录]            
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





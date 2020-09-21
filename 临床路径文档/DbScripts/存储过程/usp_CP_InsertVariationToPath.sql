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
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 获取临床护理对应路径结点执行信息
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]                  
             
[调用的sp]                    
[调用实例]              
 
[修改记录]            
**********/    

    insert  into dbo.CP_VariationToPath
            ( Ljdm, ActivityId, Bydm, Create_User )
    values  ( @Ljdm, -- Ljdm - varchar(12)
              @ActivityId, @Bydm, -- Bydm - varchar(12)
              @User  -- 
              )

go


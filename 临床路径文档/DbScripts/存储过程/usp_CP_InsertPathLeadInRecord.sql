



if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_InsertPathLeadInRecord' ) 
    drop procedure usp_CP_InsertPathLeadInRecord
go
create procedure [dbo].[usp_CP_InsertPathLeadInRecord]
    @Ljxh numeric ,
    @Syxh numeric ,
    @Ljdm varchar(12) ,
    @Zgm varchar(6)
as /**********                    
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 路径执行时，若执行的引入路径的动作，进行相应的记录
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
质量控制统计数据集              
             
[调用的sp]                    
[调用实例]              
[修改记录]            
**********/              
    begin            
        set nocount on
        
        declare @count numeric
        
        select  @count = count(*)
        from    CP_PathLeadInRecord
        where   Ljxh = @Ljxh
                and Syxh = @Syxh
                and Ljdm = @Ljdm
                and Yxjl = 1
        
        if @count = 0 
            begin
        
                insert  into dbo.CP_PathLeadInRecord
                        ( Ljxh ,
                          Syxh ,
                          Ljdm ,
                          Yxjl ,
                          Create_Time ,
                          Create_User
                        )
                values  ( @Ljxh , -- Ljxh - numeric
                          @Syxh , -- Syxh - numeric
                          @Ljdm , -- Ljdm - varchar(12)
                          1 , -- Yxjl - smallint
                          convert(varchar(19), getdate(), 120) , -- Create_Time - varchar(19)
                          @Zgm  -- Create_User - varchar(6)
                        )
            end
   
       
    end  
    
    go







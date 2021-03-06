if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_UpdateClinicalPathInfo' ) 
    drop procedure usp_CP_UpdateClinicalPathInfo
go
create  procedure [dbo].[usp_CP_UpdateClinicalPathInfo]
    @Ljdm varchar(12) ,
    @Name varchar(64) ,
    @Ljms varchar(255) ,
    @Zgts numeric ,
    @Jcfy numeric ,
    @Vesion numeric ,
    @Shys varchar(6) ,
    @Yxjl int ,
    @Syks varchar(12)
as /**********                    
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]             
             
             
[调用的sp]                    
[调用实例]              
 
[修改记录]            
**********/              
    begin            
        set nocount on
        update  dbo.CP_Clinicalpath
        set     Name = @Name ,	--(路径)名称
				Py = dbo.fun_getPY(@Name),--拼音代码      
                Ljms = @Ljms ,   --路径描述
                Zgts = @Zgts , --总共天数
                Jcfy = @Jcfy ,--均次费用
                Vesion = @Vesion ,--版本
                Syks = @Syks ,--适应科室
                Shsj = convert(char(19), getdate(), 120) ,	--审核时间
                Shys = @Shys ,--审核医师
                Yxjl = @Yxjl  --是否有效(0、无效1有效.2停止)
        where   CP_Clinicalpath.Ljdm = @Ljdm ;

    end 
    go
    

























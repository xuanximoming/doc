IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_UpdateClinicalPathInfo' ) 
    DROP PROCEDURE usp_CP_UpdateClinicalPathInfo
go
CREATE  PROCEDURE [dbo].[usp_CP_UpdateClinicalPathInfo]
    @Ljdm VARCHAR(12) ,
    @Name VARCHAR(64) ,
    @Ljms VARCHAR(255) ,
    @Zgts NUMERIC ,
    @Jcfy NUMERIC ,
    @Vesion NUMERIC ,
    @Shys VARCHAR(6) ,
    @Yxjl INT ,
    @Syks VARCHAR(12)
AS /**********                    
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
    BEGIN            
        SET nocount ON
        UPDATE  dbo.CP_Clinicalpath
        SET     Name = @Name ,	--(路径)名称
                Ljms = @Ljms ,   --路径描述
                Zgts = @Zgts , --总共天数
                Jcfy = @Jcfy ,--均次费用
                Vesion = @Vesion ,--版本
                Syks = @Syks ,--适应科室
              --Shsj = CONVERT(CHAR(19), GETDATE(), 120) ,	--审核时间
              --Shys = @Shys,--审核医师
                Yxjl = @Yxjl  --是否有效(0、无效1有效.2停止)
        WHERE   CP_Clinicalpath.Ljdm = @Ljdm ;

    END 
    go
    

























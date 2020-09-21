IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_InsertClinicalDiagnosis' ) 
    DROP PROCEDURE usp_CP_InsertClinicalDiagnosis
go
CREATE   PROCEDURE [dbo].[usp_CP_InsertClinicalDiagnosis]
    @Ljdm VARCHAR(12) ,
    @Bzdm VARCHAR(12) ,
    @Bzmc VARCHAR(64) 
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
        INSERT INTO dbo.CP_ClinicalDiagnosis
                ( Ljdm, Bzdm, Bzmc )
        VALUES  ( @Ljdm, -- Ljdm - varchar(12)
                  @Bzdm, -- Bzdm - varchar(12)
                  @Bzmc  -- Bzmc - varchar(64)
                  )

    END  
    go






















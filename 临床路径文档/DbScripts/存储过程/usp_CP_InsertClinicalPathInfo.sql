IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_InsertClinicalPathInfo' ) 
    DROP PROCEDURE usp_CP_InsertClinicalPathInfo
go
CREATE  PROCEDURE [dbo].[usp_CP_InsertClinicalPathInfo]
    @Name VARCHAR(64) ,
    @Ljms VARCHAR(255) ,
    @Zgts NUMERIC ,
    @Jcfy NUMERIC ,
    @Vesion NUMERIC ,
    @Shys VARCHAR(6) ,
    @Yxjl INT ,
    @Syks VARCHAR(12) ,
    @Bzdm VARCHAR(12)
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
        DECLARE @count INT
        DECLARE @LjdmTemp VARCHAR(12)
        DECLARE @Ljdm VARCHAR(12)
        SELECT  @Ljdm = MAX(Ljdm)
        FROM    dbo.CP_ClinicalDiagnosis
        where substring(CP_ClinicalDiagnosis.Bzdm,1,3) = substring(@Bzdm,1,3)
        IF @Ljdm IS NULL 
            BEGIN
                SET @Ljdm = 'P.' + SUBSTRING(@Bzdm, 1, 3) + '.001'
            END
        ELSE 
            BEGIN
                SET @Ljdm = SUBSTRING(@Ljdm, 1, 6) + RIGHT('0000'
                                                           + CONVERT(VARCHAR, ( CONVERT(NUMERIC, SUBSTRING(@Ljdm,
                                                              7, 3)) + 1 )), 3)
            END
        
        INSERT  INTO dbo.CP_ClinicalPath
                ( Ljdm ,
                  Name ,
				  Py,                
                  Ljms ,
                  Zgts ,
                  Jcfy ,
                  Vesion ,
                  Cjsj ,
                  Shsj ,
                  Shys ,
                  Yxjl ,
                  Syks
                )
        VALUES  ( @Ljdm , -- Ljdm - varchar(12)
                  @Name , -- Name - varchar(64)
				  dbo.fun_getPY(@Name),--拼音代码                
                  @Ljms , -- Ljms - varchar(255)
                  @Zgts , -- Zgts - numeric
                  @Jcfy , -- Jcfy - money
                  @Vesion , -- Vesion - numeric
                  CONVERT(CHAR(19), GETDATE(), 120) , -- Cjsj - char(19)
                  NULL , -- Shsj - char(19)
                  @Shys , -- Shys - varchar(6)
                  @Yxjl , -- Yxjl - int
                  @Syks  -- Syks - varchar(12)
                )
        SELECT  @Ljdm AS Ljdm ;

    END  

go























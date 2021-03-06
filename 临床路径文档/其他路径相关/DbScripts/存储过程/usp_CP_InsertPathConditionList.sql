IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_InsertPathConditionList' ) 
    DROP PROCEDURE usp_CP_InsertPathConditionList
go
CREATE  PROCEDURE [dbo].[usp_CP_InsertPathConditionList]
    @Ljdm VARCHAR(12) ,
    @Tjmc VARCHAR(255) ,
    @Tjlb INT ,
    @Yxjl INT
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
        DECLARE @tjdm VARCHAR(12)
        SELECT  @tjdm = SUBSTRING(@Ljdm, 3, 8) + '.'
                + CONVERT(VARCHAR(5), COUNT(Ljdm))
        FROM    CP_PathCondition
        WHERE   CP_PathCondition.Ljdm = @Ljdm
        INSERT  INTO dbo.CP_PathCondition
                ( Tjdm, Ljdm, Tjmc, TJlb, Yxjl )
        VALUES  ( @tjdm, -- Tjdm - varchar(12)
                  @Ljdm, -- Ljdm - varchar(12)
                  @Tjmc, -- Tjmc - varchar(255)
                  @Tjlb, -- TJlb - int
                  @Yxjl  -- Yxjl - int
                  )
    END 
    go


























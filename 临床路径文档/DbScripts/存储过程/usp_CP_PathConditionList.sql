IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_PathConditionList' ) 
    DROP PROCEDURE usp_CP_PathConditionList
go
CREATE  PROCEDURE [dbo].[usp_CP_PathConditionList]
    @Ljdm VARCHAR(12)
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
        SELECT  Tjdm ,
                Ljdm ,
                Tjmc ,
                TJlb ,
                CASE TJlb
                  WHEN 1 THEN '纳入条件'
                  WHEN 0 THEN '退出条件'
                END AS TJlbName ,
                Yxjl
        FROM    dbo.CP_PathCondition
        WHERE Ljdm = @Ljdm AND Yxjl = 1
        ORDER BY TJlb,Tjdm
    END 
    go



























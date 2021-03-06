IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_DiagnosisList' ) 
    DROP PROCEDURE usp_CP_DiagnosisList
go
CREATE  PROCEDURE [dbo].[usp_CP_DiagnosisList]
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 获取病种代码         
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
病种代码 数据集              
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_DiagnosisList      
[修改记录]            
**********/              
    BEGIN            
        SET nocount ON    
        SELECT  Zdbs ,--诊断标识
                Zddm ,--诊断代码(ICD10)
                Name ,--疾病名称
                py AS QueryName
        FROM    dbo.CP_PathDiagnosis
        WHERE   Yxjl = 1
        ORDER BY Zddm ;
    END
    go



if exists(select 1 from sysobjects where name = 'usp_CP_ClinicalDiagnosisList')
	drop procedure usp_CP_ClinicalDiagnosisList
go
CREATE  PROCEDURE [dbo].[usp_CP_ClinicalDiagnosisList]
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 获取所有效的临床路径诊断  
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
             
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_ClinicalDiagnosisList 1 ,'K62.001'
[修改记录]            
**********/              
    BEGIN            
        SET nocount ON
        SELECT  Ljdm ,	--临床路径代码
                Bzdm ,   --(诊断代码CP_Diagnosis.zddm)
                Bzmc --诊断名称
        FROM    CP_ClinicalDiagnosis ccd
        WHERE   EXISTS ( SELECT 1
                         FROM   CP_ClinicalPath ccp
                         WHERE  ccp.Ljdm = ccd.Ljdm
                                AND ccp.Yxjl NOT IN ( 0 ) )

    END 
    
    go
    



















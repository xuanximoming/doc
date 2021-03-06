IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_DeptmentList' ) 
    DROP PROCEDURE usp_CP_DeptmentList
go
CREATE  PROCEDURE [dbo].[usp_CP_DeptmentList]
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 获取科室        
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
科室 数据集              
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_DeptmentList      
[修改记录]            
**********/              
    BEGIN            
        SET nocount ON    
        SELECT  dept.Ksdm ,--代码
                dept.Name ,--名称
                dept.Py AS QueryName
        FROM    dbo.CP_Department dept
        WHERE   Yxjl = 1
                AND EXISTS ( SELECT 1
                             FROM   CP_Dept2Ward
                             WHERE  Ksdm = dept.Ksdm )
        ORDER BY Ksdm ;
    END  
    go
    
    











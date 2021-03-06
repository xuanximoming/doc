IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_InpatientPathCVInfo' ) 
    DROP PROCEDURE usp_CP_InpatientPathCVInfo
go
CREATE  PROCEDURE [dbo].[usp_CP_InpatientPathCVInfo] 
@Ljxh decimal(9,0)
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 获取临床路径病患路径变异信息       
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
质量控制统计数据集              
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_InpatientPathCVInfo 10
[修改记录]            
**********/              
    BEGIN            
        SET nocount ON
        SELECT Id ,	--序号
              Syxh ,--首页序号
              Ljdm ,	--临床路径代码(CP_ClinicalPath.Ljdm)
              Mxdm ,	--路径明细(CP_CPathDetail.Id)
              Bylb ,	--变异类别
              CASE Bylb
              WHEN '1200' THEN  '医嘱'
              WHEN '1201' THEN  '护理'
              WHEN '1203' THEN  '诊疗计划'
              WHEN '1204' THEN  '退出'
              END AS BylbName,--变异类别NAME
              Bynr ,	--变异内容
              Byyy ,	--变异原因
              Bysj --变异时间 
            FROM CP_VariantRecords cpcv
            WHERE cpcv.Ljxh = @Ljxh;

    END 
    go

















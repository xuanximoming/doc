IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_PathExecVariantRecords' ) 
    DROP PROCEDURE usp_CP_PathExecVariantRecords
go
CREATE  PROCEDURE [dbo].[usp_CP_PathExecVariantRecords]  
@Ljxh varchar(12),      --路径序号
@Mxdm VARCHAR(500)       --路径明细代码 
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]  2010-11-25             
[作者]    hjh          
[版权]    YidanSoft          
[描述] 
[功能说明]查询临床路径实际每步执行对应的临床变异信息                     
[输入参数]路径代码、路径明细代码                
[输出参数]项目类别、项目名称、变异原因、变异种类和变异时间                    
[结果集、排序]              
 临床路径每步执行的变异信息
              
[调用的sp]                    
[调用实例]              
 exec usp_CP_PathExecVariantRecords 'P.K62.001','7245314f-4f87-41bf-8280-878e6801e0fe'       
[修改记录]            
    

**********/     
BEGIN    


select case CP_VariantRecords.Bylb WHEN '1200' THEN  '医嘱'
  WHEN '1201' THEN  '护理'
  WHEN '1203' THEN  '诊疗计划'
  WHEN '1204' THEN  '退出'
  END AS Blbmc,--变异类别NAME
  CP_VariantRecords.Bylb,
  CP_VariantRecords.Byyy,
  CP_VariantRecords.Bynr,
  isnull(CP_PlaceOfDrug.Ypmc,'') Xmmc,
  dbo.CP_VariantRecords.Bysj,
  dbo.CP_VariantRecords.Ljxh,
  dbo.CP_VariantRecords.Mxdm
from dbo.CP_VariantRecords 
left join CP_PlaceOfDrug on dbo.CP_VariantRecords.Ypdm = dbo.CP_PlaceOfDrug.Ypdm
WHERE CP_VariantRecords.Ljxh = @Ljxh AND CP_VariantRecords.Mxdm = @Mxdm


	
END 
go















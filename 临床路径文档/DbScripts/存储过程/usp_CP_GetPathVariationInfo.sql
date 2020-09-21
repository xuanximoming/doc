if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_GetPathVariationInfo' ) 
    drop procedure usp_CP_GetPathVariationInfo
GO
create  procedure [dbo].usp_CP_GetPathVariationInfo
as /**********                    
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 获取临床护理路径结点对应的基本异常信息
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]                  
             
[调用的sp]                    
[调用实例]              
 
[修改记录]            
**********/    

    select  *
    from    dbo.CP_PathVariation
    where   len(Bydm) = 11
            and Yxjl = 1 ;

go


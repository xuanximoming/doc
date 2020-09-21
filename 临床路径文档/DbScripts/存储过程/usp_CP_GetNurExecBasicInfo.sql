
if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_GetNurExecBasicInfo' ) 
    drop procedure usp_CP_GetNurExecBasicInfo
GO
create  procedure [dbo].usp_CP_GetNurExecBasicInfo
as /**********                    
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 获取临床路径护理系统基本执项目信息     
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]                  
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_GetNurExecBasicInfo  
[修改记录]            
**********/       

    select  nec.Lbxh ,
            nec.Name as LbxhName ,
            nec.InputType as IsUserControl ,
            nec.OrderValue as LbOrderValue ,
            nec.Xmxh ,
            nec.Xmxh as XmxhName,
            necd.Mxxh ,
            necd.Name as MxxhName ,
            necd.InputType ,
            necd.OrderValue as MxOrderValue
    from    dbo.CP_NurExecCategory nec
            inner join dbo.CP_NurExecCategoryDetail necd on nec.Lbxh = necd.Lbxh
                                                            and nec.Yxjl = 1
                                                            and necd.Yxjl = 1
go





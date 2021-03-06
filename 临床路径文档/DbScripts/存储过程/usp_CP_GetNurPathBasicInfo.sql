if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_GetNurPathBasicInfo' ) 
    drop procedure usp_CP_GetNurPathBasicInfo
GO
create  procedure [dbo].[usp_CP_GetNurPathBasicInfo]
    @Ljdm varchar(12) ,
    @PathDetailId varchar(50) ,
    @PathChildId varchar(50) ,
    @Ljxh numeric
as /**********                    
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 获取临床护理对应路径结点执行信息
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]                  
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_GetNurPathBasicInfo 'P.K62.001','56a0ca57-0bbb-4a7f-a6f0-f0a8f32ff697','3933b500-b63a-4cd5-a653-31c887443745',11
[修改记录]            
**********/       


    select  ntp.Id as ToPathId ,
            ntp.Ljdm ,
            ntp.PathDetailId ,
            nec.Lbxh ,
            nec.Name as LbxhName ,
            nec.InputType as IsUserControl ,
            nec.OrderValue as LbOrderValue ,
            nec.Xmxh ,
            nec.Xmxh as XmxhName ,
            necd.Mxxh ,
            necd.Name as MxxhName ,
            necd.InputType ,
            necd.OrderValue as MxOrderValue ,
            ner.Id as NurRecordId,
            ner.Ljxh
    from    dbo.CP_NurExecToPath ntp
            inner join dbo.CP_NurExecCategoryDetail necd on ntp.Mxxh = necd.Mxxh
                                                            and necd.Yxjl = 1
            inner join dbo.CP_NurExecCategory nec on nec.Lbxh = necd.Lbxh
                                                     and nec.Yxjl = 1
            left join dbo.CP_NurExecRecord ner on ner.Yxjl = 1
                                                  and ner.Mxxh = ntp.Mxxh
                                                  and ner.Ljxh = @Ljxh
                                                  and ner.PathDetailId = @PathChildId
    where   ntp.Ljdm = @Ljdm
            and ntp.PathDetailId = @PathDetailId
            and ntp.Yxjl = 1


go






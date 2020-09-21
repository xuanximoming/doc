
if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_GetNurExecBasicInfo' ) 
    drop procedure usp_CP_GetNurExecBasicInfo
GO
create  procedure [dbo].usp_CP_GetNurExecBasicInfo
as /**********                    
[�汾��] 1.0.0.0.0               
[����ʱ��]                
[����]              
[��Ȩ]                     
[����] ��ȡ�ٴ�·������ϵͳ����ִ��Ŀ��Ϣ     
[����˵��]                    
[�������]               
[�������]                    
[�����������]                  
             
[���õ�sp]                    
[����ʵ��]              
 exec usp_CP_GetNurExecBasicInfo  
[�޸ļ�¼]            
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





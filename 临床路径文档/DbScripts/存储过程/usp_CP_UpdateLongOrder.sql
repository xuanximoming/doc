if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_UpdateLongOrder' ) 
    drop procedure usp_CP_UpdateLongOrder
go
create  procedure [dbo].[usp_CP_UpdateLongOrder]
    @Syxh numeric ,
    @Fzxh numeric ,
    @Fzbz numeric ,
    @Bqdm varchar(12) ,
    @Ksdm varchar(12) ,
    @Lrysdm varchar(6) ,
    @Lrrq varchar(19) ,
    @Cdxh numeric ,
    @Ggxh numeric ,
    @Lcxh numeric ,
    @Ypdm varchar(12) ,
    @Ypmc varchar(64) ,
    @Xmlb numeric ,
    @Zxdw varchar(8) ,
    @Ypjl numeric ,
    @Jldw varchar(8) ,
    @Dwxs decimal ,
    @Dwlb numeric ,
    @Yfdm varchar(2) ,
    @Pcdm varchar(2) ,
    @Zxcs numeric ,
    @Zxzq numeric ,
    @Zxzqdw numeric ,
    @Zdm varchar(7) ,
    @Zxsj varchar(64) ,
    @Ztnr varchar(64) ,
    @Yzlb numeric ,
    @Yzzt numeric ,
    @Tsbj numeric ,
    @Yznr varchar(255) ,
    @Tbbz numeric ,
    @Memo varchar(64) ,
    @Ksrq varchar(19) ,
    @Ypgg varchar(32) ,
    @Yzxh numeric ,
    @Ctmxxh numeric
as /**********                    
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 长期医嘱
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
             
             
[调用的sp]                    
[调用实例]              
 
[修改记录]            
**********/              
    begin            
        set nocount on
        update  dbo.CP_LongOrder
        set     Fzxh = @Fzxh ,
                Fzbz = @Fzbz ,
                Bqdm = @Bqdm ,
                Ksdm = @Ksdm ,
                Lrysdm = @Lrysdm ,
                Lrrq = @Lrrq ,
                Cdxh = @Cdxh ,
                Ggxh = @Ggxh ,
                Lcxh = @Lcxh ,
                Ypdm = @Ypdm ,
                Ypmc = @Ypmc ,
                Xmlb = @Xmlb ,
                Zxdw = @Zxdw ,
                Ypjl = @Ypjl ,
                Jldw = @Jldw ,
                Dwxs = @Dwxs ,
                Dwlb = @Dwlb ,
                Yfdm = @Yfdm ,
                Pcdm = @Pcdm ,
                Zxcs = @Zxcs ,
                Zxzq = @Zxzq ,
                Zxzqdw = @Zxzqdw ,
                Zdm = @Zdm ,
                Zxsj = @Zxsj ,
                Ztnr = @Ztnr ,
                Yzlb = @Yzlb ,
                Yzzt = @Yzzt ,
                Tsbj = @Tsbj ,
                Yznr = @Yznr ,
                Tbbz = @Tbbz ,
                Memo = @Memo ,
                Ksrq = convert(varchar(19), convert(datetime, @Ksrq), 120) ,
                Ypgg = @Ypgg ,
                Ctmxxh = @Ctmxxh
        where   Cqyzxh = @Yzxh
                and Syxh = @Syxh     

    end 
    GO










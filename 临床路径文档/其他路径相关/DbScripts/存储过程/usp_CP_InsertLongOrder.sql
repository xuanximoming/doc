if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_InsertLongOrder' ) 
    drop procedure usp_CP_InsertLongOrder
go
create    procedure [dbo].[usp_CP_InsertLongOrder]
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
    @Zxzqdw int ,
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
    @Ctmxxh numeric ,
    @Ljdm varchar(12) = '' ,
    @ActivityID varchar(50) = '' ,
    @ActivityChildID varchar(50) = '' ,
    @Ljxh numeric
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
        insert  into dbo.CP_LongOrder
                ( Syxh ,
                  Fzxh ,
                  Fzbz ,
                  Bqdm ,
                  Ksdm ,
                  Lrysdm ,
                  Lrrq ,
                  Cdxh ,
                  Ggxh ,
                  Lcxh ,
                  Ypdm ,
                  Ypmc ,
                  Xmlb ,
                  Zxdw ,
                  Ypjl ,
                  Jldw ,
                  Dwxs ,
                  Dwlb ,
                  Yfdm ,
                  Pcdm ,
                  Zxcs ,
                  Zxzq ,
                  Zxzqdw ,
                  Zdm ,
                  Zxsj ,
                  Ztnr ,
                  Yzlb ,
                  Yzzt ,
                  Tsbj ,
                  Yznr ,
                  Tbbz ,
                  Memo ,
                  --PathDetailID ,
                  Ksrq ,
                  Ypgg ,
                  Ctmxxh
                )
        values  ( @Syxh ,
                  @Fzxh ,
                  @Fzbz ,
                  @Bqdm ,
                  @Ksdm ,
                  @Lrysdm ,
                  @Lrrq ,
                  @Cdxh ,
                  @Ggxh ,
                  @Lcxh ,
                  @Ypdm ,
                  @Ypmc ,
                  @Xmlb ,
                  @Zxdw ,
                  @Ypjl ,
                  @Jldw ,
                  @Dwxs ,
                  @Dwlb ,
                  @Yfdm ,
                  @Pcdm ,
                  @Zxcs ,
                  @Zxzq ,
                  @Zxzqdw ,
                  @Zdm ,
                  @Zxsj ,
                  @Ztnr ,
                  @Yzlb ,
                  @Yzzt ,
                  @Tsbj ,
                  @Yznr ,
                  @Tbbz ,
                  @Memo ,
                  --@PathDetailID ,
                  convert(varchar(19), convert(datetime, @Ksrq), 120) ,
                  @Ypgg ,
                  @Ctmxxh
                  
                ) ;
        declare @yzxh numeric
        select  @yzxh = @@IDENTITY      
        insert  into CP_OrderToPath
                ( Yzxh ,
                  Yzbz ,
                  Ljxh ,
                  Ljdm ,
                  ActivityId ,
                  ActivityChileId
                )
        values  ( @yzxh , -- Yzxh - numeric
                  2703 , -- Yzbz - smallint
                  @Ljxh ,
                  @Ljdm , -- Ljdm - varchar(12)
                  @ActivityID , -- ActivityId - varchar(50)
                  @ActivityChildID  -- ActivityChileId - varchar(50)
                )
                
        select  @yzxh

    end 
    
    go








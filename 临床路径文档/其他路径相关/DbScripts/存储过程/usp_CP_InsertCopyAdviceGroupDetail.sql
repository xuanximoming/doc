IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_InsertCopyAdviceGroupDetail' ) 
    DROP PROCEDURE usp_CP_InsertCopyAdviceGroupDetail
go
CREATE  PROCEDURE [dbo].[usp_CP_InsertCopyAdviceGroupDetail]
    @OldPahtDetailID VARCHAR(50) ,--OLD活动结点GUID
    @NewPahtDetailID VARCHAR(50) ,--NEW活动结点GUID
    @NewCtyzxh NUMERIC--新的成套医嘱序号
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 插入COPY组套医令明细时调用
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
质量控制统计数据集              
             
[调用的sp]                    
[调用实例]              
       
[修改记录]            
**********/    
    BEGIN
        DECLARE @OldCtyzxh NUMERIC
        SET @OldCtyzxh = 0
        SELECT  @OldCtyzxh = Ctyzxh
        FROM    CP_AdviceGroup
        WHERE   PahtDetailID = @OldPahtDetailID
        
        DECLARE @Yzbz NUMERIC
        DECLARE @Fzxh NUMERIC
        DECLARE @Fzbz NUMERIC
        DECLARE @Cdxh NUMERIC
        DECLARE @Ggxh NUMERIC
        DECLARE @Lcxh NUMERIC
        DECLARE @Ypdm VARCHAR(12)
        DECLARE @Ypmc VARCHAR(64)
        DECLARE @Xmlb NUMERIC
        DECLARE @Zxdw VARCHAR(8)
        DECLARE @Ypjl NUMERIC
        DECLARE @Jldw VARCHAR(8)
        DECLARE @Dwxs NUMERIC
        DECLARE @Dwlb NUMERIC
        DECLARE @Yfdm VARCHAR(2)
        DECLARE @Pcdm VARCHAR(2)
        DECLARE @Zxcs NUMERIC
        DECLARE @Zxzq NUMERIC
        DECLARE @Zxzqdw NUMERIC
        DECLARE @Zdm CHAR(7)
        DECLARE @Zxsj VARCHAR(64)
        DECLARE @Zxts NUMERIC
        DECLARE @Ypzsl NUMERIC
        DECLARE @Ztnr VARCHAR(64)
        DECLARE @Yzlb NUMERIC
        
        DECLARE Cur_Old CURSOR FOR 
        SELECT     Yzbz ,
        Fzxh ,
        Fzbz ,
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
        Zxts ,
        Ypzsl ,
        Ztnr ,
        Yzlb
        FROM    CP_AdviceGroupDetail
        WHERE   Ctyzxh = @OldCtyzxh             
  
        
        
        OPEN Cur_Old
        FETCH NEXT FROM Cur_Old INTO @Yzbz ,
                        @Fzxh ,
                        @Fzbz ,
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
                        @Zxts ,
                        @Ypzsl ,
                        @Ztnr ,
                        @Yzlb
        WHILE @@fetch_status = 0 
            BEGIN
                INSERT  INTO CP_AdviceGroupDetail
                        ( Ctyzxh ,
                          Yzbz ,
                          Fzxh ,
                          Fzbz ,
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
                          Zxts ,
                          Ypzsl ,
                          Ztnr ,
                          Yzlb
                        )
                VALUES  ( @NewCtyzxh ,
                          @Yzbz ,
                          @Fzxh ,
                          @Fzbz ,
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
                          @Zxts ,
                          @Ypzsl ,
                          @Ztnr ,
                          @Yzlb
                        )
                        
                FETCH NEXT FROM Cur_Old INTO @Yzbz ,
                        @Fzxh ,
                        @Fzbz ,
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
                        @Zxts ,
                        @Ypzsl ,
                        @Ztnr ,
                        @Yzlb
            END   
        CLOSE Cur_Old   
        DEALLOCATE Cur_Old
    END
    
    go






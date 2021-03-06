IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_InsertCopyAdviceGroup' ) 
    DROP PROCEDURE usp_CP_InsertCopyAdviceGroup
go
CREATE  PROCEDURE [dbo].[usp_CP_InsertCopyAdviceGroup]
    @PahtDetailID VARCHAR(50) ,--活动结点GUID
    @Name VARCHAR(50)
AS 
/**********                    
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 插入COPY组套医令时调用
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
        INSERT  INTO CP_AdviceGroup
        VALUES  ( @PahtDetailID, @Name, '', '', '', '', '', 0, '' )
        SELECT  @@identity 
    END
    
    go






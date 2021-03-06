IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_InpatientPhySign' ) 
    DROP PROCEDURE usp_CP_InpatientPhySign
go
CREATE  PROCEDURE [dbo].[usp_CP_InpatientPhySign] 
@syxh int,
@timeBegin varchar(8),
@timeEnd varchar(8)
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 获取临床路径病患体征信息        
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
质量控制统计数据集              
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_InpatientPhySign  1 ,'20100829', '20100831'
[修改记录]            
**********/              
    BEGIN            
        SET nocount ON
        DECLARE @staticday INT   
        SELECT 
			Syxh, --首页序号int
			Tzxh, --体诊序号int
			Zlrq,	--测量日期
			Lrrq, --录入日期
			SUBSTRING(Clsj,1,2) AS Clsj, --测量时间 
			Tw,		--体温数量
			Mb,		--脉搏数量int
			Hx,		--呼吸数量int
			Xy,		--血压数量
			Xl,		--心率
			Memo,		--备用数量 
			Memo2,		--说明2(用于显示下半部分的补充信息 如:不升)  
			Wljw,		--物理降温 
			Qbxl,		--起搏心率
			Rghx,		--人工呼吸
			Kb,		--口表
			Yb,		--腋表
			Gw,		--肛温
			Cjsj		--采集时间，新表单专用
		INTO #temp
		FROM CP_PhysicalSignInfo
		WHERE Syxh =@syxh AND Zlrq BETWEEN @timeBegin AND @timeEnd
		ORDER BY Zlrq,Clsj;
		SELECT  @staticday = COUNT(DISTINCT Zlrq) FROM #temp;
		SELECT *,@staticday AS staticday FROM #temp;

    END
    go 
















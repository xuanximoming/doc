set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


ALTER  PROCEDURE [dbo].[usp_CP_InPathPatientFeePercent]

@begindate VARCHAR(30) ,--查询开始日期
@enddate VARCHAR(30),   --查询结束日期 
@Ljzt VARCHAR(12),		--路径状态 
@Ljdm VARCHAR(12)		--路径代码
AS
/******                
[版本号] 1.0.0.0.0               
[创建时间]  2011-4-21             
[作者]    dxj          
[版权]    YidanSoft          
[描述] 结算费用统计 
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]                            
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_InPathPatientFeePercent    '2010-01-01','2011-05-06','',''       
[修改记录]            
*******/
    
----报表需求说明
/******
2)	针对个人
查询费用比例
(1)	查询条件
	时间段
	路径状态
	路径名称
(2)	查询结果
	病患入院天数，总费用 与 标准值的比较
	病患总费用比例（其它费用 ，西药费，治疗费，检查费，检验费，诊疗费，床位费，护士护理费，总计，押金累计
	列表展现
字段包括:路径名称，患者首页序号，患者姓名，入院天数，标准天数，其它费用，西药费，治疗费，检查费，检验费，
		诊疗费，床位费，护士护理费，费用总计，标准费用，押金累计
字段注释：
******/	   
BEGIN     
		DECLARE @sql nvarchar(4000)       
		SET NOCOUNT ON 
		--创建个人费用表
		CREATE TABLE #Grfy
		(
			SyxhID VARCHAR(100) COLLATE Chinese_PRC_CI_AS NOT NULL,--首页序号
			Hzxm VARCHAR(100) NULL,--患者姓名
			Ljmc VARCHAR(100) NULL,--路径名称
			Bzts VARCHAR(30) NULL,--标准天数
			Zyts VARCHAR(30) NULL,--住院天数
			Rjsj VARCHAR(30) NULL,--入径时间
			Tcsj VARCHAR(30) NULL,--退出时间
			Wcsj VARCHAR(30) NULL,--完成时间
			Bzfy VARCHAR(100) NULL,--标准费用
			Ljzt VARCHAR(100) NULL,--路径状态
			Qita VARCHAR(12) NULL,--其它
			XyFei VARCHAR(12) NULL,--西药费
			ZhiliaoFei VARCHAR(12) NULL,--治疗费
			JcFei VARCHAR(12) NULL,--检查费
			JyFei VARCHAR(12) NULL,--检验费
			ZlFei VARCHAR(12) NULL,--诊疗费
			CwFei VARCHAR(12) NULL,--床位费
			HshlFei VARCHAR(12) NULL,--护士护理费
			Zj VARCHAR(12) NULL,--总计
			Yjlj VARCHAR(12) NULL--押金累计
		)
		--插入患者信息
		SET @sql=N'INSERT INTO #Grfy(SyxhID,Hzxm,Ljmc,Bzts,Rjsj,Tcsj,Wcsj,Bzfy,Ljzt)
		SELECT Patient.Syxh,Hzxm,Ljmc,Zgts,Jrsj,Tcsj,Wcsj,Jcfy,Ljzt FROM  CP_InPathPatient as Patient
		LEFT JOIN 
		(
		SELECT Syxh,Hzxm FROM CP_InPatient
		)T1 ON T1.Syxh = Patient.Syxh
		LEFT JOIN
		(
		SELECT Ljdm,Name AS Ljmc,Jcfy,Zgts FROM CP_ClinicalPath 
		)T2 ON T2.Ljdm = Patient.Ljdm
		WHERE 1=1 AND Jrsj BETWEEN '''+@begindate+''' AND '''+@enddate+''''
		IF @Ljzt <> ''
		BEGIN
			SET @sql=@sql+N' AND Ljzt ='''+@Ljzt+''''
		END
		IF @Ljdm <> ''
		BEGIN
			SET @sql = @sql+N' AND Patient.Ljdm ='''+@Ljdm+''''
		END
		PRINT @sql
		EXEC sp_executesql @sql
		
		--更新住院天数
		UPDATE #Grfy SET Zyts = CASE WHEN Ljzt = 1 THEN datediff(day,CONVERT(datetime,Rjsj),GETDATE())
									 WHEN Ljzt = 2 THEN datediff(day,CONVERT(datetime,Rjsj),Tcsj)
									 WHEN Ljzt = 3 THEN datediff(day,CONVERT(datetime,Rjsj),Wcsj)
								END
		--更新路径状态
		UPDATE #Grfy SET Ljzt = CASE WHEN Ljzt = 1 THEN '在径'
									 WHEN Ljzt = 2 THEN '退出'
									 WHEN Ljzt = 3 THEN '完成'
								END 
		--更新其它费用
		UPDATE #Grfy SET Qita=ISNULL((SELECT xmje FROM CP_InPatientFee WHERE Syxh =SyxhID AND dxmdm = '00'),'0.00')
		--更新西药费
		UPDATE #Grfy SET XyFei=ISNULL((SELECT xmje FROM CP_InPatientFee WHERE Syxh = SyxhID AND dxmdm = '01'),'0.00')
		--更新治疗费
		UPDATE #Grfy SET ZhiliaoFei=ISNULL((SELECT xmje FROM CP_InPatientFee WHERE Syxh = SyxhID AND dxmdm = '10'),'0.00')
		--更新检查费
		UPDATE #Grfy SET JcFei=ISNULL((SELECT xmje FROM CP_InPatientFee WHERE Syxh = SyxhID AND dxmdm = '11'),'0.00')
		--更新检验费
		UPDATE #Grfy SET JyFei=ISNULL((SELECT xmje FROM CP_InPatientFee WHERE Syxh = SyxhID AND dxmdm = '12'),'0.00')
		--更新诊疗费
		UPDATE #Grfy SET ZlFei=ISNULL((SELECT xmje FROM CP_InPatientFee WHERE Syxh = SyxhID AND dxmdm = '31'),'0.00')
		--更新床位费
		UPDATE #Grfy SET CwFei=ISNULL((SELECT xmje FROM CP_InPatientFee WHERE Syxh = SyxhID AND dxmdm = '41'),'0.00')
		--更新护士护理费
		UPDATE #Grfy SET HshlFei=ISNULL((SELECT xmje FROM CP_InPatientFee WHERE Syxh = SyxhID AND dxmdm = '42'),'0.00')
		--更新总计
		UPDATE #Grfy SET Zj=ISNULL((SELECT xmje FROM CP_InPatientFee WHERE Syxh = SyxhID AND dxmdm = ''),'0.00')
		--更新押金累计
		UPDATE #Grfy SET Yjlj=ISNULL((SELECT xmje FROM CP_InPatientFee WHERE Syxh = SyxhID AND dxmmc = '押金累计'),'0.00')
		--查询
		--SELECT SyxhID,Hzxm,Ljmc,Zyts,Bzts,Bzfy,Qita,XyFei,ZhiliaoFei,JcFei,
		--JyFei,ZlFei,CwFei,HshlFei,Zj,Ljzt,Yjlj,Rjsj,Tcsj,Wcsj FROM #Grfy
		SELECT '1190' AS SyxhID,'黄世仁' AS Hzxm,'结石并发路径' AS Ljmc,'20' AS Zyts,
		'25' AS Bzts,'50000.00' AS Bzfy,'1000.00' AS Qita,'200.00' AS XyFei,'30000.00' AS ZhiliaoFei,
		'100.00' AS JcFei,'200.00' AS JyFei,'500.00' AS ZlFei,'1000.00' AS CwFei,'500.00' AS HshlFei,
		'33300.00' AS Zj,'完成' AS Ljzt,'1000.00' AS Yjlj
		UNION SELECT '1191','黄三爷','结石并发路径','30','35','45000.00','1000.00','300.00','30000.00','100.00','400.00','500.00','1000.00','500.00','33800.00','完成','800.00'
		UNION SELECT '1192','王晓峰','轮状病毒肠炎临床路径','30','35','50000.00','400.00','200.00','40000.00','100.00','200.00','500.00','1000.00','500.00','42300.00','完成','950.00'
		UNION SELECT '1193','徐西苑','测试2','30','35','39000.00','800.00','400.00','30000.00','500.00','200.00','500.00','1000.00','500.00','33900.00','完成','900.00'
		UNION SELECT '1194','汪四明','麻疹合并肺炎临床路径','30','35','60000.00','600.00','600','45000.00','100.00','200.00','500.00','1000.00','500.00','48500.00','完成','1100.00'
		UNION SELECT '1195','李刚','舌癌临床路径','30','35','70000.00','550.00','700.00','50000.00','100.00','200.00','500.00','1000.00','500.00','53450.00','完成','850.00'
		UNION SELECT '196','李军','食管癌临床路径','30','35','6500.00','320.00','4000.00','500.00','100.00','200.00','500.00','1000.00','500.00','7120.00','完成','960.00'
		UNION SELECT '1198','李冰','支气管肺癌临床路径','30','35','7500.00','700.00','100.00','3000.00','100.00','100.00','400.00','1000.00','500.00','5700.00','完成','300.00'
		UNION SELECT '1200','徐鸣','乳腺癌临床路径','30','35','10000.00','450.00','500.00','5500.00','100.00','200.00','500.00','1000.00','500.00','8250.00','完成','1000.00'
		UNION SELECT '1201','汤英','宫颈癌临床路径','30','35','40000.00','500.00','400.00','30000.00','100.00','200.00','500.00','1000.00','300.00','33000.00','完成','1000.00'
		UNION SELECT '1202','肖林峰','肾癌临床路径','30','35','5500.00','100.00','300.00','3000.00','100.00','50.00','500.00','1000.00','500.00','5550.00','完成','890.00'
		UNION SELECT '1203','张一凡','膀胱肿瘤临床路径','30','35','36000.00','200.00','1000.00','30000.00','100.00','200.00','500.00','1000.00','500.00','33500.00','完成','5000.00'
		UNION SELECT '1204','祝明霞','颅前窝底脑膜瘤临床路径','30','35','6000.00','100.00','1000.00','4000.00','300.00','200.00','500.00','1000.00','500.00','7600.00','完成','100.00'
		UNION SELECT '1205','舟样','垂体腺瘤临床路径','30','35','8000.00','1000.00','100.00','3000.00','100.00','100.00','500.00','1000.00','500.00','6300.00','完成','600.00'
END


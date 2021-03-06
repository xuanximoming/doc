USE [YidanEHR]
GO
/****** Object:  StoredProcedure [dbo].[usp_CP_MedicalTreatmentWarm]    Script Date: 05/23/2011 15:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[usp_CP_MedicalTreatmentWarm]
 @Syxh varchar(12)='',	--首页序号
 @Ljxh varchar(12)='',	--路径序号
 @Ljdm varchar(12)='',		--临床路径代码（CP_ClinicalPath.Ljdm)
 @Operation VARCHAR(50)='InsertAndSelect',	--操作符（insert插入操作，select查询操作，update更新操作）
 @ID VARCHAR(50)='0',		--CP_MedicalTreatmentWarm主键
 @Jddm VARCHAR(50)=''
AS
BEGIN
	PRINT @Operation
	IF @Operation='InsertAndSelect'
				   
	BEGIN
		DECLARE @IsExist int
		SET @IsExist=(SELECT COUNT(0) FROM dbo.CP_MedicalTreatmentWarm WHERE  Ljdm=@Ljdm AND Ljxh=@Ljxh)
		IF @IsExist=0
		BEGIN
			if   object_id( 'tempdb..#MedicalTreatmentWarmTemp ')   is   not   null   drop   table   #MedicalTreatmentWarmTemp
			--检验检查,插入临时表
			SELECT @Syxh Syxh,@Ljxh Ljxh,@Ljdm Ljdm ,ag.PahtDetailID Jddm,@Jddm Hzjddm,2 Txlx ,0 Txzt,Ypdm dm,isnull(cp.Ypmc,'')+' '+isnull(af.Name,'')+' '+isnull(du.Name,'') as mc 
			INTO #MedicalTreatmentWarmTemp   from CP_AdviceGroupDetail  cp 
			left join CP_DataCategoryDetail cd on cd.Mxbh=cp.Yzbz Left join CP_AdviceFrequency af  on af.Pcdm=cp.Pcdm 
			left join CP_DrugUseage du on du.Yfdm=cp.Yfdm
			LEFT JOIN CP_AdviceGroup ag  ON ag.Ctyzxh=cp.Ctyzxh
			LEFT JOIN CP_PathDetail pd ON  pd.PahtDetailID=ag.PahtDetailID
			Where cp.Yzlb='3114' and ag.Ljdm=@Ljdm
			--手术，插入临时表
			insert into #MedicalTreatmentWarmTemp 
			select @Syxh Syxh,@Ljxh Ljxh,@Ljdm Ljdm,ag.PahtDetailID Jddm,@Jddm Hzjddm,1 Txlx ,0 Txzt,Ssdm dm ,'在 '+ ca.Name +' '+'下'+' '+'行'+' '+cp.Ssmc+' ' as mc  from CP_AdviceAnesthesiaDetail  cp 
			left join CP_DataCategoryDetail cd on cd.Mxbh=cp.Yzbz 
			Left join CP_Anesthesia ca on ca.Mzdm=cp.Mzdm  
			LEFT JOIN CP_AdviceGroup ag  ON ag.Ctyzxh=cp.Ctyzxh
			LEFT JOIN CP_PathDetail pd ON  pd.PahtDetailID=ag.PahtDetailID
			Where   ag.Ljdm=@Ljdm

			--插入正式表
			INSERT INTO CP_MedicalTreatmentWarm(Syxh,	Ljxh,	Ljdm,	Jddm,	Hzjddm,	Txlx,	Txzt,	dm,	mc)
			SELECT * FROM #MedicalTreatmentWarmTemp
			PRINT 'InsertAndSelect2'
		END
			PRINT 'InsertAndSelect3'
		
		--查询明细
		SELECT mtw.*,pd.Ljmc jdmc,CASE  WHEN mtw.Txlx=1 THEN '手术'  WHEN   mtw.Txlx=2 THEN '检查' END TxlxName FROM CP_MedicalTreatmentWarm mtw
		LEFT JOIN (SELECT DISTINCT  PahtDetailID,Ljmc FROM  dbo.CP_PathDetail) pd ON pd.PahtDetailID=mtw.Jddm
		WHERE Hzjddm=@Jddm AND Syxh=@Syxh AND Ljxh=@Ljxh
		
		--查询分组
		SELECT MAX(pd.PahtDetailID) jddm, MAX(pd.Ljmc) jdmc,COUNT(mtw.Txlx) txsl,(COUNT(mtw.Txlx)-SUM(Txzt)) dysl,mtw.Txlx,CASE  WHEN mtw.Txlx=1 THEN '手术'  WHEN   mtw.Txlx=2 THEN '检查' end  TxlxName  FROM  CP_MedicalTreatmentWarm mtw
		LEFT JOIN (SELECT DISTINCT  PahtDetailID,Ljmc FROM  dbo.CP_PathDetail) pd ON pd.PahtDetailID=mtw.Jddm
		WHERE mtw.Hzjddm=@Jddm AND Syxh=@Syxh AND Ljxh=@Ljxh
		 GROUP BY mtw.Txlx
		
		--SELECT DATEDIFF(dd, jrsj,GETDATE()) Rjts--入径天数
		--,Zgts Bzts --标准天数
		--,CONVERT(varchar(100), CAST(jrsj AS DATETIME), 23) Rjrq --路径日期
		--FROM dbo.CP_InPathPatient ip
		--LEFT JOIN CP_ClinicalPath cp ON ip.Ljdm=@Ljdm
	END
	
	IF @Operation='UpdateAndSelect'
	BEGIN
		DECLARE @c VARCHAR(1000)
		DECLARE @split CHAR(1)
		SET @c=@ID+','
		SET @split=','
		if   object_id( 'tempdb..#t ')   is   not   null   drop   table   #t
		CREATE TABLE #t
		(
		col VARCHAR(10)
		)
		while(charindex(@split,@c) <> 0) 
			begin 
			insert   #t(col)   values   (substring(@c,1,charindex(@split,@c)-1)) 
			PRINT substring(@c,1,charindex(@split,@c)-1)
			set   @c   =   stuff(@c,1,charindex(@split,@c), ' ') 
		end 
		IF @ID<>'0'
		BEGIN
			UPDATE CP_MedicalTreatmentWarm SET Txzt=0 where Syxh=@Syxh AND Ljdm=@Ljdm AND Ljxh=@Ljxh
			UPDATE CP_MedicalTreatmentWarm SET Txzt=1 WHERE   ID  IN (SELECT col FROM  #t)
		END
		
		--查询明细
		SELECT mtw.*,pd.Ljmc jdmc,CASE  WHEN mtw.Txlx=1 THEN '手术'  WHEN   mtw.Txlx=2 THEN '检查' END TxlxName FROM CP_MedicalTreatmentWarm mtw
		LEFT JOIN (SELECT DISTINCT  PahtDetailID,Ljmc FROM  dbo.CP_PathDetail) pd ON pd.PahtDetailID=mtw.Jddm
		WHERE Hzjddm=@Jddm AND Syxh=@Syxh AND Ljxh=@Ljxh
		--查询分类
		SELECT MAX(pd.PahtDetailID) jddm, MAX(pd.Ljmc) jdmc,COUNT(mtw.Txlx) txsl,(COUNT(mtw.Txlx)-SUM(Txzt)) dysl,mtw.Txlx,CASE  WHEN mtw.Txlx=1 THEN '手术'  WHEN   mtw.Txlx=2 THEN '检查' end  TxlxName  FROM  CP_MedicalTreatmentWarm mtw
		LEFT JOIN (SELECT DISTINCT  PahtDetailID,Ljmc FROM  dbo.CP_PathDetail) pd ON pd.PahtDetailID=mtw.Jddm
		WHERE mtw.Hzjddm=@Jddm AND Syxh=@Syxh AND Ljxh=@Ljxh
		GROUP BY mtw.Txlx
		
		SELECT '标准天数:'+CAST(Zgts AS VARCHAR(10))+',入径天数:'+CAST(DATEDIFF(dd, jrsj,GETDATE()) AS VARCHAR(10)) mc,
		(DATEDIFF(dd, jrsj,GETDATE())-Zgts ) chaobiao,3 Txlx,'天数' TxlxName
		FROM dbo.CP_InPathPatient ip
		LEFT JOIN CP_ClinicalPath cp ON ip.Ljdm=@Ljdm
		WHERE ip.Syxh=@Syxh 
		UNION ALL
		SELECT '标准费用：'+CAST(MAX(cp.Jcfy) AS VARCHAR(10))+',当前费用:'+CAST(SUM(xmje) AS VARCHAR(10)) mc,(SUM(xmje)-MAX(cp.Jcfy)) chaobiao,4 Txlx,'费用' TxlxName  FROM 	CP_InPatientFee ipf 
		LEFT JOIN CP_InPathPatient ip on ip.Syxh=ipf.Syxh
		LEFT JOIN CP_ClinicalPath cp ON ip.Ljdm=cp.Ljdm
		WHERE ipf.Syxh=@Syxh
		GROUP BY ipf.Syxh
	END
	
	
	
--SELECT * FROM CP_MedicalTreatmentWarm
--delete FROM CP_MedicalTreatmentWarm
END
/**[版本号] 1.0.0.0.0               
[创建时间]  2011-4-22
[作者]    fqw          
[版权]    YidanSoft          
[描述] 退出路径的统计  
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
路径变异原因统计数据集              
             
[调用的sp]                    
[调用实例]              
exec usp_CP_MedicalTreatmentWarm @Syxh=N'1201',@Ljxh=N'172',@Ljdm=N'P.K80.003',@Operation=N'InsertAndSelect',@ID=default,@Jddm=N'f0771404-08ae-43c8-96c1-fcddde063acb'
exec usp_CP_MedicalTreatmentWarm @Syxh=N'1201',@Ljxh=N'172',@Ljdm=N'P.K80.003',@Operation=N'UpdateAndSelect',@ID=N'117,118,121,122',@Jddm=N'f0771404-08ae-43c8-96c1-fcddde063acb'
[修改记录]            
    
----报表需求说明
@Operation VARCHAR(10)='insert'	--操作符（insertselect插入操作，select查询操作，update更新操作）
InsertAndSelect:
往提醒表中插入并查询需要提醒的信息

UpdateAndSelect：
更新提醒并查询表中的莫条记录的状态为已查看


**********/     
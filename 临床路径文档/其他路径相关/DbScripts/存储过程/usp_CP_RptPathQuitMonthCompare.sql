IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_RptPathQuitMonthCompare' ) 
    DROP PROCEDURE usp_CP_RptPathQuitMonthCompare
go
CREATE  PROCEDURE [dbo].[usp_CP_RptPathQuitMonthCompare]

@begindate nvarchar(100) ,--查询开始日期
@enddate nvarchar(100),   --查询结束日期  
@dept nvarchar(12) = '',       --临床科室 
@Ljdm nvarchar(100) = ''     --路径代码
AS /**********    
[版本号] 1.0.0.0.0               
[创建时间]  2011-04-19              
[作者]    ZM         
[版权]    YidanSoft          
[描述] 8.3月度出径指标统计分析
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
月度出径指标统计分析          


[调用的sp]                    
[调用实例]              
 exec usp_CP_RptPathQuitMonthCompare  '2011','2012','',''            
[修改记录]           


----报表需求说明
(5)月度出径指标统计分析
统计某年内,每个月路径的退出情况
(1)	查询条件
	时间段
	路径种类
	临床科室
(2)	查询结果
	列表展现 
	统计图显示
**********/   

BEGIN     
	DECLARE @tempsqlOne nvarchar(4000)
	DECLARE @tempsqlTwo nvarchar(4000)
	DECLARE @sql nvarchar(4000)       
    SET nocount ON   


--创建临时表
	create table #tempPathExecuteInfo
	(
		LjdmID		varchar(100)		COLLATE Chinese_PRC_CI_AS not null, --路径代码
		Ljcz		int					not null,--路径执行状态
		Czsj		varchar(100)		null--退出时间(路径执行表,此项可以为空)
	)

--插入临时表中
--(目前过滤条件为,状态为退出/完成路径以及传入附加条件)
		set @tempsqlOne = N'insert into #tempPathExecuteInfo(LjdmID,Ljcz,Czsj)
		SELECT clinicalpath.Ljdm,inpathpatient.Ljzt,inpathpatient.Tcsj 
		FROM dbo.CP_InPathPatient	inpathpatient
		LEFT JOIN dbo.CP_ClinicalPath clinicalpath ON clinicalpath.Ljdm = inpathpatient.Ljdm
		WHERE inpathpatient.ljzt = 2
		AND inpathpatient.Tcsj >= '''+@begindate+'''
		AND inpathpatient.Tcsj <= '''+@enddate+'''
		'
		
		set @tempsqlTwo = N'insert into #tempPathExecuteInfo(LjdmID,Ljcz,Czsj)
		SELECT clinicalpath.Ljdm,inpathpatient.Ljzt,inpathpatient.Wcsj
		FROM dbo.CP_InPathPatient	inpathpatient
		LEFT JOIN dbo.CP_ClinicalPath clinicalpath ON clinicalpath.Ljdm = inpathpatient.Ljdm
		WHERE inpathpatient.ljzt = 3
		AND inpathpatient.Wcsj >= '''+@begindate+'''
		AND inpathpatient.Wcsj <= '''+@enddate+'''
		'

--临床科室
	IF @dept<>''
	begin
		SET @tempsqlOne = @tempsqlOne + N' and clinicalpath.Syks in('''+@dept+''')'
		SET @tempsqlTwo = @tempsqlTwo + N' and clinicalpath.Syks in('''+@dept+''')'
	END


--路径代码				
	IF @Ljdm<>''
	BEGIN
		SET @tempsqlOne = @tempsqlOne + N' and clinicalpath.Ljdm in('+replace(@Ljdm,'~','''')+')'
		SET @tempsqlTwo = @tempsqlTwo + N' and clinicalpath.Ljdm in('+replace(@Ljdm,'~','''')+')'
	END


	print @tempsqlOne
	print @tempsqlTwo
	exec sp_executesql @tempsqlOne
	exec sp_executesql @tempsqlTwo

--更新月度出径环比

--创建表
	create table #temppathQuitMonthCompare
	(
		Ljdm		varchar(100)		COLLATE Chinese_PRC_CI_AS not null, --路径代码
		Ljmc		varchar(100)		not null,--路径名称
		Syks		varchar(100)		null,--适应科室(路径表,此项可以为空)
		Jan			int					null,--一月
		Feb			int					null,--二月
		Mar			int					null,--三月
		Apr			int					null,--四月
		May			int					null,--五月
		Jun			int					null,--六月
		Jul			int					null,--七月
		Aug			int					null,--八月
		Sept		int					null,--九月
		Oct			int					null,--十月
		Nov			int					null,--十一月
		Dec			int					null,--十二月
	)


--插入路径基本信息
	set @sql = N'insert into #temppathQuitMonthCompare(Ljdm,Ljmc,Syks)
	select ljdm,[name],syks from CP_ClinicalPath where 1=1
	'

--临床科室
	IF @dept<>''
	begin
		SET @sql = @sql + N' and Syks in('''+@dept+''')'
	END


--路径代码				
	IF @Ljdm<>''
	BEGIN
		SET @sql = @sql + N' and Ljdm in('+replace(@Ljdm,'~','''')+')'
	END

	print @sql
	exec sp_executesql @sql 


--更新一月
	update #temppathQuitMonthCompare set Jan = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-01' and temp.Czsj <= ''+@begindate+'-02'  then 1 ELSE 0 end) 
	from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--更新二月
	update #temppathQuitMonthCompare set Feb = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-02' and temp.Czsj <= ''+@begindate+'-03'  then 1 ELSE 0 end)
	 from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--更新三月
	update #temppathQuitMonthCompare set Mar = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-03' and temp.Czsj <= ''+@begindate+'-04'  then 1 ELSE 0 end)
	 from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--更新四月
	update #temppathQuitMonthCompare set Apr = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-04' and temp.Czsj <= ''+@begindate+'-05'  then 1 ELSE 0 end) 
	from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--更新五月
	update #temppathQuitMonthCompare set May = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-05' and temp.Czsj <= ''+@begindate+'-06'  then 1 ELSE 0 end) 
	from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--更新六月
	update #temppathQuitMonthCompare set Jun = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-06' and temp.Czsj <= ''+@begindate+'-07'  then 1 ELSE 0 end)
	 from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--更新七月
	update #temppathQuitMonthCompare set Jul = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-07' and temp.Czsj <= ''+@begindate+'-08'  then 1 ELSE 0 end)
	 from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--更新八月
	update #temppathQuitMonthCompare set Aug = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-08' and temp.Czsj <= ''+@begindate+'-09'  then 1 ELSE 0 end) 
	from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--更新九月
	update #temppathQuitMonthCompare set Sept = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-09' and temp.Czsj <= ''+@begindate+'-10'  then 1 ELSE 0 end)
	 from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--更新十月
	update #temppathQuitMonthCompare set Oct = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-10' and temp.Czsj <= ''+@begindate+'-11'  then 1 ELSE 0 end)
	 from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--更新十一月
	update #temppathQuitMonthCompare set Nov = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-11' and temp.Czsj <= ''+@begindate+'-12'  then 1 ELSE 0 end)
	 from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--更新十二月
	update #temppathQuitMonthCompare set Dec = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-12' and temp.Czsj < ''+@enddate+'-01'  then 1 ELSE 0 end)
	 from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)


--返回最终查询结果

--select * from #temppathQuitMonthCompare
SELECT  'P.K40.001' as Ljdm,'腹股沟疝临床路径' as Ljmc,'2032' as Syks, 
'35'as Jan,'23' as Feb,'54'as Mar,'65' as Apr,'34' as May,'65' as Jun,'67'as Jul,'33' as Aug,'66' AS Sept,'54' as Oct,'67' as Nov, '34' AS Dec
	UNION	select 'P.A08.001','轮状病毒肠炎临床路径','3130','34','56','56','54','33','56','43','3','32','45','32','45'
	UNION	select 'P.B05.001','麻疹合并肺炎临床路径','3127','45','78','54','23','3','6','14','5','3','43','2','21'
	UNION	select 'P.C01.001','舌癌临床路径','3120','34','78','25','65','11','56','54','65','32','45','35','45'
	UNION	select 'P.C15.001','食管癌临床路径','4102','67','62','54','34','43','56','34','3','54','43','22','23'
	UNION	select 'P.C34.001','支气管肺癌临床路径','4102','34','23','11','67','32','56','43','1','16','45','32','45'
	UNION	select 'P.C50.001','乳腺癌临床路径','2032','44','4','56','65','33','24','67','65','54','24','32','45'
	UNION	select 'P.C53.001','宫颈癌临床路径','2011','32','243','43','4','23','56','43','76','42','45','89','54'
	UNION	select 'P.C64.001','肾癌临床路径','3202','46','22','4','24','65','34','43','76','43','45','32','45'
	UNION	select 'P.C64.002','膀胱肿瘤临床路径','3202','5','24','44','24','78','56','43','24','34','7','87','45'
	UNION	select 'P.C64.003','肾恶性肿瘤','3101','31','23','14','24','33','56','78','65','32','43','76','45'
	UNION	select 'P.C70.001','颅前窝底脑膜瘤临床路径','4098','10','43','2','65','33','56','56','65','54','14','32','45'
	UNION	select 'P.C75.001','垂体腺瘤临床路径','4098','78','45','1','65','22','56','43','7','32','43','42','45'
	UNION	select 'P.C75.002','小脑扁桃体下疝畸形临床路径','4098','75','23','45','98','33','56','56','65','32','3','32','24'
	UNION	select 'P.D25.001','子宫平滑肌瘤临床路径','2011','33','45','32','34','35','32','32','56','21','76','4','45'
	UNION	select 'P.D27.001','卵巢良性肿瘤临床路径','2011','65','56','24','98','87','56','43','2','32','44','31','45'
	UNION	select 'P.E04.001','结节性甲状腺肿临床路径','2032','25','23','24','65','33','56','46','5','34','2','32','23'
	UNION	select 'P.E04.002','甲状腺恶性肿瘤','3130','36','23','23','87','33','56','12','76','32','7','32','45'
	UNION	select 'P.G40.001','癫痫临床路径','3107','68','23','32','65','65','56','4','24','54','45','51','34'
	UNION	select 'P.G40.002','重症肌无力临床路径','3107','75','65','29','65','33','21','43','245','31','45','31','32'
	UNION	select 'P.G61.001','吉兰-巴雷综合征临床路径','3107','25','23','54','45','34','56','43','24','22','45','32','34'
	UNION	select 'P.H40.001','原发性急性闭角型青光眼临床路径','3118','24','76','54','45','33','56','43','13','32','23','24','45'
	UNION	select 'P.H66.001',' 慢性化脓性中耳炎临床路径','3120','65','23','56','45','67','56','43','21','56','43','32','65'
	UNION	select 'P.I26.001','肺血栓栓塞','3101','75','23','54','5','33','56','43','1','234','4','32','45'
	UNION	select 'P.I49.001','病态窦房结综合征临床路径','3102','35','44','11','54','43','56','34','21','32','32','11','12'
	

END 

go
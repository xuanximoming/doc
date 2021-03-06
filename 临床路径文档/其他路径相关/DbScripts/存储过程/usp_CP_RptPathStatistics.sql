IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_RptPathStatistics' ) 
    DROP PROCEDURE usp_CP_RptPathStatistics
go
CREATE  PROCEDURE [dbo].[usp_CP_RptPathStatistics] 

@begindate VARCHAR(100) ,--查询开始日期
@enddate VARCHAR(100),   --查询结束日期  
@Ljdm VARCHAR(1000) ,      --路径名称(可以多选)
@dept VARCHAR(12)        --临床科室 
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]  2010-11-16              
[作者]    yxy          
[版权]    YidanSoft          
[描述] 临床路径执行概括统计 
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
临床路径执行概括统计              
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_RptPathStatistics   '2010-01-01 00:00:00','2012-12-31','',''           
[修改记录]            
    
----报表需求说明

/*
2)	临床路径执行概括统计
统计某一时间段，临床路径的执行情况统计（在选择时间段中进入路径的病人统计）
(1)	查询条件
	时间段
	路径名称（路径可以多选）
	临床科室
(2)	查询结果
	列表展现
字段包括:临床路径，执行情况(已经使用/未使用)，时间间隔(取当时间段内，第一个执行的日期与最近一条的差值)，实施例数，入径率、平均住院费用（包括跟标准费用的差别），
		 平均住院天数（包括与标准路径的住院天数差别）  ，退出例数、退出率
字段注释：
入径率：  实施例数/科室患者数量
平均住院费：病人在院的实际费用(HIS系统中)
标准费用：路径的标准使用费用。
平均住院天数：病人实际平均住院天数。
标志路径住院天数：入径天数
		
?	柱状图显示
主要用来比较各个路径的入径率、平均住院费用、平均住院天数的差别;
备注:可以增加，标准路径的住院天数、费用与实际的差别
*/

**********/     
BEGIN     
	DECLARE @sql nvarchar(4000)       
    SET nocount ON  
    
    --创建路径下患者明细临时表
    create table #temppathInPatient
	(
		Ljdm          VARCHAR(100)          COLLATE Chinese_PRC_CI_AS not null, --路径代码
		SYxh		  VARCHAR(100)			not null, --患者首页序号
		Jrsj          VARCHAR(100)          NULL,     --患者进入路径时间
		Ljts          int                   NULL,     --患者进入路径天数
		Ljzt          int                   NULL,     --患者在路径中状态
		Zyts          int					null,	  --住院天数
		Zyfee         int		         	NULL	  --住院费用 
		
	)
    
    

--插入患者表中信息
--(目前过滤时间段内 路径中的病人条件为：进入路径时间在选择时间段内)
	SET @sql = N'insert into #temppathInPatient(Ljdm,SYxh,Jrsj,Ljts,Ljzt,Zyts)
		SELECT inpathpatient.Ljdm,inpatient.Syxh,inpathpatient.Jrsj,inpathpatient.Ljts, inpathpatient.Ljzt,
			   datediff(day,CONVERT(datetime,inpatient.Ryrq),getdate()) zyts
			FROM CP_InPatient inpatient 
			LEFT JOIN CP_InPathPatient inpathpatient on inpatient.Syxh = inpathpatient.Syxh
			LEFT JOIN CP_ClinicalPath clinicalpath on clinicalpath.Ljdm = inpathpatient.Ljdm 
			where inpathpatient.Ljdm is not NULL
			AND inpathpatient.Jrsj >= '''+@begindate+'''
			AND inpathpatient.Jrsj <= '''+@enddate+''' '
			
--路径代码				
	IF @Ljdm<>''
	BEGIN
		SET @sql = @sql + N' and clinicalpath.Ljdm in( '+replace(@Ljdm,'~','''')+')'
	END

--临床科室
	IF @dept<>''
	begin
		SET @sql = @sql + N' and clinicalpath.Syks in( '''+@dept+''')'
	END
	
	print @sql
	exec sp_executesql @sql 
--SELECT * FROM #temppathInPatient

--更新患者住院费用
	/*更新费用方法：由后台过程从HIS数据库中获取所有病人费用信息，映射到EHR数据库中，再从EHR数据库中获取费用信息。
		  存在问题：费用信息需要定时从HIS数据库中获取，数据存在延时情况。
		  需要字段：病人首页序号，病人住院费用*/
    
    
    
    create table #temppathStatistics
	(
		LjdmID        VARCHAR(12)           COLLATE Chinese_PRC_CI_AS not NULL , --路径代码
		Ljmc		  VARCHAR(100)			not null, --路径名称
		Zxqk          VARCHAR(100)          null, --执行情况（已经执行，未执行）
		Jgsj          int		         	null, --间隔时间(天)
		Ssls          int				 	null, --实施例数
		Jcfy          int					null, --均次费用
		Jcts		  int					null, --均次天数
		Rjts          int					null, --入径天数（进入路径天数）
		Zyts          int				    null, --总住院天数（计算平均住院天数：总住院天数/实施例数）
		Zyfee         int				    null, --总住院费用（计算平均费用：总住院费用/实施例数）
		HzSL          int					null, --患者数量（计算入径率：实施例数/患者数量）(当前科室总病人数)
		Tcsl		  int					null, --退出数量（退出路径数量）
		Tcbl		  VARCHAR(100)			NULL  --退出比例（退出路径数量/实施例数）
	)

 
--插入路径基本信息
INSERT INTO #temppathStatistics (LjdmID,Ljmc,Jcfy,Jcts)
SELECT ClinicalPath.Ljdm, ClinicalPath.Name,
ClinicalPath.Jcfy,ClinicalPath.Zgts
FROM CP_ClinicalPath ClinicalPath 
where exists (select 1 from #temppathInPatient temp where temp.Ljdm = ClinicalPath.Ljdm)

 

--更新实际例数
UPDATE #temppathStatistics SET Ssls = 
			isnull((select count(1) from #temppathInPatient temp where temp.Ljdm = LjdmID),0)

--根据实施例数更新执行情况（>0为已经执行，<= 0 为未执行）
UPDATE #temppathStatistics SET Zxqk = (CASE WHEN Ssls > 0 THEN '已经使用' else '未使用' end)

--更新间隔时间（天）
UPDATE #temppathStatistics SET Jgsj = 
			isnull((select datediff(day,min(temp.Jrsj),max(temp.Jrsj)) from #temppathInPatient temp where temp.Ljdm = LjdmID),0)
						
--更新入径天数
UPDATE #temppathStatistics  SET Rjts = isnull((select sum(temp.Ljts) from #temppathInPatient temp where temp.Ljdm = LjdmID),0)

--更新退出路径数
--注：退出路径数未根据当前时间段内退出的。
--目前计算的退出数量未所有在过滤后的患者状态为退出的患者
UPDATE #temppathStatistics SET Tcsl = isnull((select count(1) from #temppathInPatient temp where temp.Ljzt = 2 and temp.Ljdm = LjdmID),0)

--更新患者数量
update #temppathStatistics SET HzSL = isnull((SELECT count(1) FROM CP_InPatient inpatient 
LEFT JOIN CP_ClinicalPath clinicalpath on clinicalpath.Syks = inpatient.Cyks where clinicalpath.Ljdm = LjdmID),0)


--更新总入院天数
UPDATE #temppathStatistics set Zyts = (select sum(Zyts) from #temppathInPatient temp where temp.Ljdm = LjdmID)

							
---更新总费用	


UPDATE #temppathStatistics set Zyfee = (select isnull(sum(fee.xmje),0) from dbo.CP_InPatientFee fee 
															left join dbo.CP_InPathPatient on fee.Syxh = dbo.CP_InPathPatient.Syxh
															where fee.dxmdm = '' and CP_InPathPatient.Ljdm = LjdmID)


--返回最终查询结果						
------------临床路径，执行情况(已经使用/未使用)，时间间隔(取当时间段内，第一个执行的日期与最近一条的差值)，实施例数，入径率、平均住院费用（包括跟标准费用的差别），
------------		 平均住院天数（包括与标准路径的住院天数差别）  ，退出例数、退出率
select  LjdmID,HzSL,a.Ljmc, --临床路径,
		a.Zxqk,-- 执行情况,
		a.Jgsj,-- 间隔时间,
		a.Ssls,-- 实施例数, 
	    (case when a.HzSL = 0 then 0 else a.Ssls*100/a.HzSL end) Rjl, --入径率,
	    (case when a.HzSL = 0 then 0 else a.Zyfee*100/a.HzSL end) Jzyfy, --平均住院费用,
	    (case when a.Ssls = 0 then 0 else a.Zyts/a.Ssls end) Jzyts,-- 平均住院天数,
	    a.Rjts ,--入径天数,
	    (case when a.Ssls = 0 then 0 else a.Rjts/a.Ssls end) Jrjts,-- 平均入径天数,
	    a.Tcsl,-- 退出例数,
	    (case when a.Ssls = 0 then 0 else a.Tcsl*100/Ssls end) Tcl, -- 退出率
	    a.Jcfy,--均次费用
	    a.Jcts --均次天数
from #temppathStatistics a 


 

END 

go

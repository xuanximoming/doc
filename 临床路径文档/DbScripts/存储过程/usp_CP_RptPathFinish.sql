IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_RptPathFinish' ) 
    DROP PROCEDURE usp_CP_RptPathFinish
go
CREATE  PROCEDURE [dbo].[usp_CP_RptPathFinish] 
@begindate nvarchar(100) ,--查询开始日期
@enddate nvarchar(100),   --查询结束日期  
@Ljdm varchar(100),       --路径代码
@dept VARCHAR(12),        --临床科室 
@period varchar(12)       --统计周期（月:0，季度:1，年:2）
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]  2010-11-16              
[作者]    yxy          
[版权]    YidanSoft          
[描述] 临床路径完成率统计  
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
路径变异原因统计数据集              
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_RptPathFinish   '2009-11-25','2010-11-25','','' ,'0'           
[修改记录]            
    
----报表需求说明

4)	临床路径完成率统计
(1)	查询条件
?	时间段
?	路径名称
?	临床科室
备注：按照时间间隔单位(月、年)统计和显示
(2)	查询结果
     如图  

总人数：入院时间在时间段内
完成人数：入院时间在当前时间内的，且出院时间在时间段内的，且路径状态为完成
完成率：完成人数/总人数

**********/     
BEGIN     
	DECLARE @sql nvarchar(4000) 
	DECLARE @Maxcount int             ---统计周期数    
	DECLARE @count int                --用于循环中计数
	DECLARE @colindex nvarchar(10)    --列下标
	DECLARE @temptime nvarchar(100)     ---用于循环中的中间时间  
    SET nocount ON     
        
--    SET @begindate = '2010-01-01'
--    SET @enddate = '2010-12-31'
    

	--创建路径下患者明细临时表
	create table #temptable
	(
		Ljdm          VARCHAR(100)          COLLATE Chinese_PRC_CI_AS not null, --路径代码
		period_name   varchar(100)          NULL,     --周期名称
		MonFirstDay	  datetime			    null,     --周期开始时间
		MonLastDay    datetime              NULL,     --周期结束时间
		finishcount   int                   NULL,     --完成路径数量
		totalcount    int                   NULL,      --进入路径人数
		colindex      varchar(10)           NOT NULL,  --现实到页面中的列坐标
		rownumber     VARCHAR(10)			NOT NULL   --行下标
	)
    
    --按月度统计
    IF @period = 0
    BEGIN
		
		SELECT @Maxcount = DATEDIFF(MM,@begindate,@enddate)+1
		
		IF @Maxcount > 15
		begin
			SELECT 'False' state,'统计周期超过15' mess
			return
		end
		
		set @count = 0 
		--循环获取每个循环周期的开始时间喝结束时间
		WHILE @count < @Maxcount
		Begin 

			SELECT @temptime = CONVERT(varchar(100),dateadd(month,@count,@begindate),23)

			--记录对应行下标
			select @colindex = cast(@count AS varchar)
			--经过筛选 将路径信息与时间周期信息插入到临时表中 
			set @sql = N'insert into #temptable(Ljdm,period_name, MonFirstDay,MonLastDay,colindex,rownumber)
			SELECT  Clinicalpath.Ljdm,
					cast(year('''+@temptime+''') as varchar) + ''年'' + cast(month('''+@temptime+''') as varchar) + ''月'' period_name,
					cast(cast(year('''+@temptime+''') as varchar) + ''-'' + cast(month('''+@temptime+''') as varchar)  + ''-1'' as datetime)  月度第一天,
					dateadd(month,1,cast(cast(year('''+@temptime+''') as varchar) + ''-'' + cast(month('''+@temptime+''') as varchar)  + ''-1'' as datetime))-1  月度最后一天,
					cast('''+@colindex+''' AS varchar) AS colindex,
					ROW_NUMBER() OVER (order by Ljdm) rownumber
			from CP_ClinicalPath Clinicalpath 
			where 1=1	'
			
			---路径过滤条件
			--根据路径过滤
			if @Ljdm <> ''
			begin
				set @sql = @sql + ' AND Clinicalpath.Ljdm = '''+@Ljdm+''''
			end
			
			---根据科室
			if @dept <> ''
			begin
				set @sql = @sql + ' AND Clinicalpath.Syks = '''+@dept+''''
			end
			
			print @sql
			execute	sp_executesql @sql 
			
			set @count = @count +1;

			----错误返回
			if @@ERROR <> 0
			begin
			  SELECT 'False' state,'数据库错误,请联系管理员!' mess
			  return
			END
		END
    END 
    	
    	
    	
    	
    --按季度统计
    IF @period = 1
    BEGIN
		
		SELECT @Maxcount = DATEDIFF(qq,@begindate,@enddate)+1
		
		
		IF @Maxcount > 15
		begin
			SELECT 'False' state,'统计周期超过15' mess
			return
		end
		
		set @count = 0
		--循环获取每个循环周期的开始时间喝结束时间
		WHILE @count < @Maxcount
		Begin 

			SELECT @temptime = dateadd(month,@count*3,@begindate)
			
			--记录对应行下标
			select @colindex = cast(@count AS varchar)
			--经过筛选 将路径信息与时间周期信息插入到临时表中 
			set @sql = N' insert into #temptable(Ljdm,period_name, MonFirstDay,MonLastDay,colindex,rownumber)
			SELECT  Clinicalpath.Ljdm,
					cast(year('''+@temptime+''') as varchar) + ''年第'' + cast(DATEPART(qq,'''+@temptime+''') as varchar)  + ''季度'' period_name,
					dateadd(month,-(month('''+@temptime+''')-1)%3,'''+@temptime+''') - day(dateadd(month,-(month('''+@temptime+''')-1)%3,'''+@temptime+'''))+1   季度第一天,
					dateadd(month,-(month('''+@temptime+''')-1)%3+3,'''+@temptime+''') - day(dateadd(month,-(month('''+@temptime+''')-1)%3,'''+@temptime+'''))  季度最后一天,
					cast('''+@colindex+''' AS varchar) AS colindex,
					ROW_NUMBER() OVER (order by Ljdm) rownumber
			from CP_ClinicalPath Clinicalpath 
			where 1=1	'
			---路径过滤条件
			
			--根据路径过滤
			if @Ljdm <> ''
			begin
				set @sql = @sql + ' AND Clinicalpath.Ljdm = '''+@Ljdm+''''
			end
			
			---根据科室
			if @dept <> ''
			begin
				set @sql = @sql + ' AND Clinicalpath.Syks = '''+@dept+''''
			end
			
			print @sql
			execute	sp_executesql @sql 
			
			set @count = @count +1;

			----错误返回
			if @@ERROR <> 0
			begin
			  SELECT 'False' state,'数据库错误,请联系管理员!' mess
			  return
			END

		END

    END 
    
        --按年度统计
    IF @period = 2
    BEGIN
		
		SELECT @Maxcount = DATEDIFF(yyyy,@begindate,@enddate)+1
		
		IF @Maxcount > 15
		begin
			SELECT 'False' state,'统计周期超过15' mess
			return
		end
		
		set @count = 0
		--循环获取每个循环周期的开始时间喝结束时间
		WHILE @count < @Maxcount
		Begin 

			SELECT @temptime = dateadd(year,@count,@begindate)

			--记录对应行下标
			select @colindex = cast(@count AS varchar)
			--经过筛选 将路径信息与时间周期信息插入到临时表中 
			set @sql = N'insert into #temptable(Ljdm,period_name, MonFirstDay,MonLastDay,colindex,rownumber)
			SELECT  Clinicalpath.Ljdm,
					cast(year('''+@temptime+''') as varchar) + ''年'' period_name,
					cast(cast(year('''+@temptime+''') as varchar) + ''-01-01'' as datetime)   年度第一天,
					cast(cast(year('''+@temptime+''') as varchar) + ''-12-31''  as datetime)  年度最后一天,
					cast('''+@colindex+''' AS varchar)  as colindex,
					ROW_NUMBER() OVER (order by Ljdm) rownumber
			from CP_ClinicalPath  Clinicalpath
			where 1=1	'

			---路径过滤条件
			--根据路径过滤
			if @Ljdm <> ''
			begin
				set @sql = @sql + ' AND Clinicalpath.Ljdm = '''+@Ljdm+''''
			end
			
			---根据科室
			if @dept <> ''
			begin
				set @sql = @sql + ' AND Clinicalpath.Syks = '''+@dept+''''
			end
			

			print @sql
			execute	sp_executesql @sql 
			
			set @count = @count +1;

			----错误返回
			if @@ERROR <> 0
			begin
			  SELECT 'False' state,'数据库错误,请联系管理员!' mess
			  return
			END

		END


    END 
    
    --将最小起始时间改为@begindate
    UPDATE #temptable SET MonFirstDay = @begindate WHERE MonFirstDay < @begindate
    --将最大起始时间改为@enddate
    UPDATE #temptable SET MonLastDay = @enddate WHERE MonLastDay > @enddate
    

	--根据临时表中的信息更新路径每月的完成信息

	UPDATE #temptable SET finishcount = isnull((SELECT count(1) FROM CP_InPatient InPatient
											LEFT JOIN CP_InPathPatient InPathPatient on InPathPatient.Syxh = InPatient.Syxh
											WHERE InPathPatient.Ljzt = 3
											AND InPatient.Ryrq >= MonFirstDay
											AND InPatient.Ryrq < MonLastDay+1
											AND InPatient.Cyrq >= MonFirstDay
											AND InPatient.Cyrq < MonLastDay+1
											AND InPathPatient.Ljdm = #temptable.Ljdm),0)
					
	--更新每月进入路径总数
	UPDATE #temptable SET totalcount = isnull((SELECT count(1) FROM CP_InPatient InPatient
								LEFT JOIN CP_InPathPatient InPathPatient on InPathPatient.Syxh = InPatient.Syxh
								WHERE InPatient.Ryrq >= MonFirstDay
								AND InPatient.Ryrq < MonLastDay+1 
								AND InPathPatient.Ljdm = #temptable.Ljdm),0)


	SELECT temp.Ljdm ljdm, 
		   ClinicalPath.Name,
		   temp.period_name,
		   finishcount,
		   totalcount,
	CASE WHEN totalcount = 0 THEN 0 ELSE finishcount*100/totalcount END rate,
	cast((CASE WHEN totalcount = 0 THEN 0 ELSE finishcount*100/totalcount END) AS varchar)+'('+cast(finishcount AS varchar)+'人/'+cast(totalcount AS varchar)+'人)' mess,
	temp.colindex,temp.rownumber 
	FROM #temptable temp
	LEFT join CP_ClinicalPath ClinicalPath on temp.Ljdm = ClinicalPath.Ljdm

 
	--测试效果构造数据源 INTO TempPath_Finish
--	SELECT * FROM  TempPath_Finish
	
--	DROP TABLE TempPath_Finish
 
END 

go
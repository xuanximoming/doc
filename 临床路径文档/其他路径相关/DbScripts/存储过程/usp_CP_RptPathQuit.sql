IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_RptPathQuit' ) 
    DROP PROCEDURE usp_CP_RptPathQuit
go
CREATE  PROCEDURE [dbo].[usp_CP_RptPathQuit] 

@begindate nvarchar(100) ,--查询开始日期
@enddate nvarchar(100),   --查询结束日期  
@Ljdm nvarchar(100) = '',      --路径代码
@dept nvarchar(12) = '',       --临床科室 
@Doctor nvarchar(12) = ''		 --执行医师ID
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]  2010-11-16              
[作者]    yxy          
[版权]    YidanSoft          
[描述] 退出路径的统计  
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
路径变异原因统计数据集              
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_RptPathQuit   '2010-01-01 00:00:00','2012-12-31','','' ,'00'           
[修改记录]            
 
 yxy
 
 2011.1.21     
 
 修改内容：根据医嘱变异表生成路径退出原因
 
    
----报表需求说明

3)	退出路径的统计
用来分析某一个时间段，路径的退出情况，以及原因分析     （退出时间在选择时间段内）
(1)	查询条件
?	时间段
?	路径名称
?	临床科室
?	执行医生
(2)	查询结果
?	列表显示
路径名称、退出时间、病人名称，入径日期，退出日期，退出原因、医护人员
备注：单击某一个路径，可以查询该条路径的执行情况
?	饼状图显示
饼状图分析路径退出的原因，看哪种原因导致的路径退出几率最大
备注：对于未被编码的原因，统统归类为“未知”

**********/     
BEGIN     
	DECLARE @sql nvarchar(4000)   
	DECLARE @table_name nvarchar(20) 
	SET @table_name = 'tempQuitPath'    
    SET nocount ON    
    
    IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = @table_name ) 
    begin
		set @sql = N'DROP TABLE '+ @table_name
		print @sql
		exec sp_executesql @sql
    end
    set @sql = N'
    SELECT clinicalpath.Name,clinicalpath.Ljdm,inpathpatient.Id as Ljxh,inpathpatient.Tcsj,inpatient.Hzxm,inpathpatient.Jrsj,
						Employee.Name DName, convert(nvarchar(max),'''') Tcyy into ' +@table_name+'
					FROM CP_InPatient inpatient 
					LEFT JOIN CP_InPathPatient inpathpatient on inpathpatient.Syxh = inpatient.Syxh
					LEFT JOIN CP_ClinicalPath clinicalpath on clinicalpath.Ljdm = inpathpatient.Ljdm
					INNER JOIN CP_PathExecuteInfo pathexecuteinfo on pathexecuteinfo.Ljxh = inpathpatient.Id AND pathexecuteinfo.Ljcz = ''1104''
					LEFT JOIN CP_Employee Employee on Employee.Zgdm = pathexecuteinfo.Czys
					WHERE inpathpatient.Ljzt = 2
										AND inpathpatient.Tcsj >= ''' +@begindate+'''
					AND inpathpatient.Tcsj <= ''' +@enddate+'''
					and (''' +@Ljdm+''' = '''' or clinicalpath.Ljdm = ''' +@Ljdm+''')
					and (''' +@dept+''' = '''' or inpatient.Cyks = ''' +@dept+''' )
					and (''' +@Doctor+''' = '''' or inpathpatient.Cwys = ''' +@Doctor+''')'
 
 		print @sql
		exec sp_executesql @sql
 
	
	------------------------------------------------使用游标统计退出原因	

	declare @Ljxh nvarchar(20),
			@Tcyy nvarchar(100)
	
	--声明一个可循环操作的游标(通过条件过滤掉未查出的路径异常信息)
	declare H_SETTLE scroll cursor for select Ljxh,Byyy from dbo.CP_VariantRecords
	where exists (SELECT inpathpatient.Id as Ljxh
					FROM CP_InPatient inpatient 
					LEFT JOIN CP_InPathPatient inpathpatient on inpathpatient.Syxh = inpatient.Syxh
					LEFT JOIN CP_ClinicalPath clinicalpath on clinicalpath.Ljdm = inpathpatient.Ljdm
					WHERE inpathpatient.Ljzt = 2
					AND inpathpatient.Tcsj >= @begindate
					AND inpathpatient.Tcsj <= @enddate
					and (@Ljdm = '' or clinicalpath.Ljdm = @Ljdm)
					and (@dept = '' or inpatient.Cyks = @dept )
					and (@Doctor = '' or inpathpatient.Cwys = @Doctor)
					and inpathpatient.Id = CP_VariantRecords.Ljxh)

	open H_SETTLE --打开游标

	fetch first from H_SETTLE into @Ljxh,@Tcyy  --打开游标第一条记录

	while (@@FETCH_STATUS=0) --检查游标是不是最后一个，如果不是则进行中间的程序
	begin

	---一段处理程序段

	set @sql = N'update '+@table_name +' set Tcyy = Tcyy+''【'+@Tcyy +'】'' where Ljxh='+@Ljxh
	print @sql
	exec sp_executesql @sql 
	

	fetch next from H_SETTLE into @Ljxh,@Tcyy  

	end
	close H_SETTLE --关闭游标
	deallocate H_SETTLE --释放游标



	
	set @sql = N'SELECT * FROM '+@table_name
	
	print @sql
	exec sp_executesql @sql 
	
	set @sql = N'SELECT temp.Tcyy,count(1) cnt FROM '+@table_name + ' temp group by temp.Tcyy'
	
	print @sql
	exec sp_executesql @sql 
	

END 

go
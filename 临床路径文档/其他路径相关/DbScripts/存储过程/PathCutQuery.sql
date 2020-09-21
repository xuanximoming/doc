IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_PathCutQuery' ) 
    DROP PROCEDURE usp_CP_PathCutQuery
go
CREATE  PROCEDURE [dbo].usp_CP_PathCutQuery

@ljmc NVARCHAR(50) = '',
@dept nvarchar(12) = ''       --临床科室 
AS /**********
[版本号]	1.0.0.0.0               
[创建时间]	2011-05-21              
[作者]		ZM         
[版权]		YidanSoft          
[描述]		路径裁剪查询准备
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
 路径总结功能         


[调用的sp]
[调用实例]
			
[修改记录]


----窗口需求说明

(1)	查询条件

(2)	查询结果
	列表展现 
**********/

DECLARE @SQL as varchar(4000), 
		@Column as varchar(1000), --定义游标参数
		@tempSql as varchar(4000)
		
Create Table #tempHead					--表头(用于处理表头)
(
	Bydm	nvarchar(100)	NULL,		--表头标识
	Bymc	nvarchar(100)	NULL,		--表头名
)

insert into #tempHead
select REPLACE(Bydm,'.','0'),Bymc from CP_PathVariation	--变异编码中点不符合GIRDVIEW Bind关键字要求
WHERE LEN(Bydm) = 7						/*必备条件，取二级编码*/	

insert into #tempHead					--插入其他
values ('a9999','其他')					--9999加上了a

Create Table #tempContent				--数据（用于处理数据）
(
	Ljmc	nvarchar(100)	COLLATE Chinese_PRC_CI_AS NULL,		--路径名称
	Bydm	nvarchar(100)	NULL,								--变异代码（匹配）
	Ljdm	nvarchar(100)	COLLATE Chinese_PRC_CI_AS NULL		--路径代码
)

set @tempSql = N'
insert into #tempContent
SELECT	cp.Name as Ljmc,
		REPLACE(ISNULL(SUBSTRING(va.bydm,1,7),''a9999''),''.'',''0'')as Bydm,--默认记录表中，所有的全是三级码，取两级；其余的归为其他
		cp.Ljdm
FROM dbo.CP_VariantRecords  re
LEFT JOIN CP_PathVariation va ON va.Bydm = re.Bydm
LEFT JOIN CP_ClinicalPath cp ON cp.Ljdm = re.Ljdm
where 1=1
'

IF @ljmc<>''
	begin
		SET @tempSql = @tempSql + N' and cp.Name like '''+@ljmc+''' '
	END


IF @dept<>''
	begin
		SET @tempSql = @tempSql + N' and cp.Syks in('''+@dept+''')'
	END

print @tempSql
EXECUTE(@tempSql)

BEGIN
select * from #tempHead
end

EXECUTE ('DECLARE cursor_new_column CURSOR FOR SELECT DISTINCT 
			Bydm  from   #tempHead  for read only ') --定义游标 (从临时表头)
				
begin 
  SET nocount ON  

  SET @SQL='select cp.Name as Ljmc,cp.Ljdm,cp.Syks,dept.Name as deptName,count(tp.Bydm) AS AllCount' --定义SQL语句头 


  OPEN cursor_new_column 
  while (0=0) 
  BEGIN --遍历游标 
    FETCH NEXT FROM cursor_new_column INTO @Column	--通过游标获取列头信息 
    if (@@fetch_status<>0) break 
        SET @SQL = @SQL + ', count(CASE tp.Bydm WHEN ''' 
	+ @Column + ''' THEN tp.Bydm ELSE Null END) AS [' + @Column + '] ' --循环追加SQL语句 
  END 
  
  SET @SQL = @SQL + 'into #tempCut from CP_ClinicalPath cp				--插入信息总表
  left join #tempContent tp on tp.Ljdm = cp.Ljdm	--联路径表，获取所有路径作为首列
  left join CP_Department dept on dept.Ksdm = cp.Syks
  where 1 = 1
  '
  
  IF @ljmc<>''
	begin
		SET @SQL = @SQL + N' and cp.Name like '''+@ljmc+''' '
	END
  
  IF @dept<>''
	begin
		SET @SQL = @SQL + N' and cp.Syks in('''+@dept+''')'		--筛选科室
	END
  
  SET @SQL = @SQL + N'group by cp.Name,cp.Ljdm,cp.Syks,dept.Name'	--定义SQL语句尾 
  
  
  SET @SQL = @SQL + '
  select * from #tempCut							--查询信息表
  where deptName is not null
  order by AllCount	desc							--按变异总数排列
  ' 

  EXECUTE(@SQL) --执行SQL语句 
  PRINT @SQL --输出SQL语句 
  
  
  IF @@error <>0 RETURN @@error --如果出错，则返回错误代码 
  CLOSE cursor_new_column --关闭游标 
  DEALLOCATE cursor_new_column RETURN 0 --释放游标，释放成功则返回0 
end 
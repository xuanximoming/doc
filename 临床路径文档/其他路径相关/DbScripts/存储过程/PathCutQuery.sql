IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_PathCutQuery' ) 
    DROP PROCEDURE usp_CP_PathCutQuery
go
CREATE  PROCEDURE [dbo].usp_CP_PathCutQuery

@ljmc NVARCHAR(50) = '',
@dept nvarchar(12) = ''       --�ٴ����� 
AS /**********
[�汾��]	1.0.0.0.0               
[����ʱ��]	2011-05-21              
[����]		ZM         
[��Ȩ]		YidanSoft          
[����]		·���ü���ѯ׼��
[����˵��]                    
[�������]               
[�������]                    
[�����������]              
 ·���ܽṦ��         


[���õ�sp]
[����ʵ��]
			
[�޸ļ�¼]


----��������˵��

(1)	��ѯ����

(2)	��ѯ���
	�б�չ�� 
**********/

DECLARE @SQL as varchar(4000), 
		@Column as varchar(1000), --�����α����
		@tempSql as varchar(4000)
		
Create Table #tempHead					--��ͷ(���ڴ����ͷ)
(
	Bydm	nvarchar(100)	NULL,		--��ͷ��ʶ
	Bymc	nvarchar(100)	NULL,		--��ͷ��
)

insert into #tempHead
select REPLACE(Bydm,'.','0'),Bymc from CP_PathVariation	--��������е㲻����GIRDVIEW Bind�ؼ���Ҫ��
WHERE LEN(Bydm) = 7						/*�ر�������ȡ��������*/	

insert into #tempHead					--��������
values ('a9999','����')					--9999������a

Create Table #tempContent				--���ݣ����ڴ������ݣ�
(
	Ljmc	nvarchar(100)	COLLATE Chinese_PRC_CI_AS NULL,		--·������
	Bydm	nvarchar(100)	NULL,								--������루ƥ�䣩
	Ljdm	nvarchar(100)	COLLATE Chinese_PRC_CI_AS NULL		--·������
)

set @tempSql = N'
insert into #tempContent
SELECT	cp.Name as Ljmc,
		REPLACE(ISNULL(SUBSTRING(va.bydm,1,7),''a9999''),''.'',''0'')as Bydm,--Ĭ�ϼ�¼���У����е�ȫ�������룬ȡ����������Ĺ�Ϊ����
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
			Bydm  from   #tempHead  for read only ') --�����α� (����ʱ��ͷ)
				
begin 
  SET nocount ON  

  SET @SQL='select cp.Name as Ljmc,cp.Ljdm,cp.Syks,dept.Name as deptName,count(tp.Bydm) AS AllCount' --����SQL���ͷ 


  OPEN cursor_new_column 
  while (0=0) 
  BEGIN --�����α� 
    FETCH NEXT FROM cursor_new_column INTO @Column	--ͨ���α��ȡ��ͷ��Ϣ 
    if (@@fetch_status<>0) break 
        SET @SQL = @SQL + ', count(CASE tp.Bydm WHEN ''' 
	+ @Column + ''' THEN tp.Bydm ELSE Null END) AS [' + @Column + '] ' --ѭ��׷��SQL��� 
  END 
  
  SET @SQL = @SQL + 'into #tempCut from CP_ClinicalPath cp				--������Ϣ�ܱ�
  left join #tempContent tp on tp.Ljdm = cp.Ljdm	--��·������ȡ����·����Ϊ����
  left join CP_Department dept on dept.Ksdm = cp.Syks
  where 1 = 1
  '
  
  IF @ljmc<>''
	begin
		SET @SQL = @SQL + N' and cp.Name like '''+@ljmc+''' '
	END
  
  IF @dept<>''
	begin
		SET @SQL = @SQL + N' and cp.Syks in('''+@dept+''')'		--ɸѡ����
	END
  
  SET @SQL = @SQL + N'group by cp.Name,cp.Ljdm,cp.Syks,dept.Name'	--����SQL���β 
  
  
  SET @SQL = @SQL + '
  select * from #tempCut							--��ѯ��Ϣ��
  where deptName is not null
  order by AllCount	desc							--��������������
  ' 

  EXECUTE(@SQL) --ִ��SQL��� 
  PRINT @SQL --���SQL��� 
  
  
  IF @@error <>0 RETURN @@error --��������򷵻ش������ 
  CLOSE cursor_new_column --�ر��α� 
  DEALLOCATE cursor_new_column RETURN 0 --�ͷ��α꣬�ͷųɹ��򷵻�0 
end 
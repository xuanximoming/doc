IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_RptPathVariationMonitor' ) 
    DROP PROCEDURE usp_CP_RptPathVariationMonitor
go
CREATE  PROCEDURE [dbo].[usp_CP_RptPathVariationMonitor]

@begindate nvarchar(100) ,--��ѯ��ʼ����
@enddate nvarchar(100),   --��ѯ��������  
@Ljdm nvarchar(100) = ''     --·������
AS /**********
[�汾��] 1.0.0.0.0               
[����ʱ��]  2011-04-25             
[����]    ZM         
[��Ȩ]    YidanSoft          
[����] 8.6	·����ⱨ��
[����˵��]                    
[�������]               
[�������]                    
[�����������]              
·����ⱨ��         


[���õ�sp]                    
[����ʵ��]              
		exec usp_CP_RptPathVariationMonitor  '2011-01-12','2011-05-11','P.111.004'
[�޸ļ�¼]           


----��������˵��
(5)·����ⱨ��
ͳ��ĳ��ʱ����,ĳ·�����ڵ�ı������
(1)	��ѯ����
	ʱ���
	·������
(2)	��ѯ���
	�б�չ�� 
**********/   


BEGIN     
	DECLARE @tempsqlOne nvarchar(4000)
	DECLARE @tempsqlTwo nvarchar(4000)
	DECLARE @sql nvarchar(4000)       
    SET nocount ON  

--����ִ����ʱ��
	CREATE TABLE #tempEnForce
	(
		Ljdm	VARCHAR(100)	COLLATE Chinese_PRC_CI_AS NULL,--·������
		PathDetailId	VARCHAR(100)	NULL--·���ڵ�
	)
SET @tempsqlTwo =  N'insert into #tempEnForce
		SELECT Ljdm,Jddm FROM CP_InPatientPathEnForceDetail
		WHERE
		Ljdm = '''+@Ljdm+'''
		and Jrsj >= '''+@begindate+'''
		and Jrsj <= '''+@enddate+'''
'

--����������ʱ��
	create table #tempVariantRecords
	(
		Ljdm	varchar(100)	COLLATE Chinese_PRC_CI_AS NULL,--·������
		PathDetailId	varchar(100)	NULL--·���ڵ�
	)
	
--������ʱ����
set @tempsqlOne = N'insert into #tempVariantRecords
		select Ljdm,PahtDetailID from CP_VariantRecords
		where 
		Ljdm = '''+@Ljdm+'''
		and Bysj >= '''+@begindate+'''
		and Bysj <= '''+@enddate+'''
		'

	print @tempsqlOne
	exec sp_executesql @tempsqlOne
	print @tempsqlTwo
	exec sp_executesql @tempsqlTwo
	
--����·�����

--������
	CREATE TABLE #tempPathVariationMonitor
	(
		Ljmc			VARCHAR(100)		COLLATE Chinese_PRC_CI_AS NULL,--·���ڵ���
		PahtDetail		VARCHAR(100)		NULL,--·���ڵ�ID
		enForceCount	INT					NULL,--ִ����
		variationCount	INT					NULL,--������
		per				DECIMAL				NULL	--������
	)
	
--����ڵ���
	set @sql = N'INSERT INTO #tempPathVariationMonitor(Ljmc,PahtDetail)
	SELECT Ljmc,PahtDetailID FROM CP_PathDetail
	WHERE Ljdm = '''+@Ljdm+'''
	'
	
	print @sql
	exec sp_executesql @sql 
	
--��������
	UPDATE #tempPathVariationMonitor SET enForceCount = 
	ISNULL((SELECT COUNT(*) FROM #tempEnForce temp 
	WHERE temp.PathDetailId = PahtDetail),0)
	
	UPDATE #tempPathVariationMonitor SET variationCount = 
	ISNULL((SELECT COUNT(*) FROM #tempVariantRecords temp 
	WHERE temp.PathDetailId = PahtDetail),0)
	
--�������ղ�ѯ���
--select * from #tempPathVariationMonitor
	SELECT  '��Ժ' as Ljmc,'0ec62159-941e-4050-995f-d287fbae82ae' as PahtDetail,43 AS enForceCount,40 as variationCount
	UNION	select '��Ժ��һ��','46cc46cf-2f80-486c-84f9-410590dafe8d',87,45
	UNION	select '������׼���գ�','56a0ca57-0bbb-4a7f-a6f0-f0a8f32ff697',34,23
	UNION	select '�������գ�','7245314f-4f87-41bf-8280-878e6801e0fe',25,22
	UNION	select '(�����һ��)','9290165c-8e5f-4c92-a416-4ca1b6af41f0',53,45
	UNION	select '����ڶ���','b2f31f11-5f87-471d-99a2-15dceed19b88',21,12
	UNION	select '���������','c8a93211-e97f-4405-9a7d-78158ba98a8d',56,11
	UNION	select '���������','e0069b60-5152-49ed-a731-2781945610bc',33,21
	UNION	select '��Ժ','fe4e66f5-647e-4d60-b490-6d28d0e8d3c5',11,8
	
END

GO
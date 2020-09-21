IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_RptPathVariationAnalyse' ) 
    DROP PROCEDURE usp_CP_RptPathVariationAnalyse
go
CREATE  PROCEDURE [dbo].[usp_CP_RptPathVariationAnalyse]

@begindate nvarchar(100) ,--��ѯ��ʼ����
@enddate nvarchar(100),   --��ѯ��������  
@dept nvarchar(12) = '',       --�ٴ����� 
@Ljdm nvarchar(100) = ''     --·������
AS /**********    
[�汾��] 1.0.0.0.0               
[����ʱ��]  2011-04-26              
[����]    ZM         
[��Ȩ]    YidanSoft          
[����] 8.8	�����������
[����˵��]                    
[�������]               
[�������]                    
[�����������]              
�����������          


[���õ�sp]                    
[����ʵ��]              
exec usp_CP_RptPathVariationAnalyse  '2011','2012','',''           
[�޸ļ�¼]           


----��������˵��
(5)�����������
ͳ��ĳ��ʱ����,·���ı���������
(1)	��ѯ����
	ʱ���
	·������
	�ٴ�����
(2)	��ѯ���
	�б�չ�� 
	ͳ��ͼ��ʾ
**********/

BEGIN     
	DECLARE @tempsql nvarchar(4000)
	DECLARE @sql nvarchar(4000)       
    SET nocount ON 
    
    
--���������ʱ��
		create table #tempPathVariation
		(
			BydmSt		VARCHAR(100)		NULL, --һ���������
			BymcSt		VARCHAR(100)		NULL,--һ����������
			St			VARCHAR(100)		COLLATE Chinese_PRC_CI_AS NULL,--һ��������д�ֶ�
			BydmNd		VARCHAR(100)		COLLATE Chinese_PRC_CI_AS NULL, --�����������
			BymcNd		VARCHAR(100)		NULL,--������������
			Nd			VARCHAR(100)		COLLATE Chinese_PRC_CI_AS NULL,--����������д�ֶ�
			BydmRd		VARCHAR(100)		COLLATE Chinese_PRC_CI_AS NULL, --�����������
			BymcRd		VARCHAR(100)		NULL,--������������
		)
--����������ʱ��
		create table #tempPathVariationNd
		(
			BydmNd		VARCHAR(100)		COLLATE Chinese_PRC_CI_AS null, --�����������
			BymcNd		VARCHAR(100)		NULL,--������������
		)
--����һ����ʱ��
		create table #tempPathVariationSt
		(
			BydmSt		VARCHAR(100)		COLLATE Chinese_PRC_CI_AS null, --һ���������
			BymcSt		VARCHAR(100)		NULL--һ����������
		)


--���������ʱ����
--(�༶��ʾ)
		insert into #tempPathVariation(BydmRd,BymcRd,Nd,St)
		SELECT Bydm,Bymc,REPLACE(SUBSTRING(Bydm,1,7),'.',''),SUBSTRING(Bydm,1,3) FROM dbo.CP_PathVariation
		WHERE LEN(Bydm) = 11
--���������ʱ����		
		insert into #tempPathVariationNd(BydmNd,BymcNd)
		SELECT REPLACE(Bydm,'.',''),Bymc FROM dbo.CP_PathVariation
		WHERE LEN(Bydm) = 7
--����һ����ʱ����	
		INSERT INTO #tempPathVariationSt(BydmSt,BymcSt)
		SELECT Bydm,Bymc FROM dbo.CP_PathVariation
		WHERE LEN(Bydm) = 3
--���������ʱ���������	
		UPDATE #tempPathVariation SET BydmNd = (
		SELECT BydmNd FROM #tempPathVariationNd tempNd
		WHERE tempNd.BydmNd = Nd
		)	
		UPDATE #tempPathVariation SET BymcNd = (
		SELECT BymcNd FROM #tempPathVariationNd tempNd
		WHERE tempNd.BydmNd = Nd
		)
--���������ʱ��һ������		
		UPDATE #tempPathVariation SET BydmSt = (
		SELECT BydmSt FROM #tempPathVariationSt tempSt
		WHERE tempSt.BydmSt = St
		)
		UPDATE #tempPathVariation SET BymcSt = (
		SELECT BymcSt FROM #tempPathVariationSt tempSt
		WHERE tempSt.BydmSt = St
		)
		
--������¼����ʱ��
		CREATE TABLE #tempVariantRecords
		(
			BydmId	VARCHAR(100)	COLLATE Chinese_PRC_CI_AS NOT null, --�������
			Ljxh	VARCHAR(100)	NULL--·�����
		)

--������ʱ����
		set @tempsql = N'INSERT INTO #tempVariantRecords(BydmId,Ljxh)
		SELECT variantRecords.Bydm,variantRecords.Ljxh
		FROM dbo.CP_VariantRecords 
		variantRecords
		LEFT JOIN dbo.CP_ClinicalPath clinicalPath ON clinicalPath.ljdm = variantRecords.Ljdm
		WHERE Bysj >= '''+@begindate+'''
		AND bysj <= '''+@enddate+'''
		'

--�ٴ�����
	IF @dept<>''
	begin
		SET @tempsql = @tempsql + N' and clinicalPath.Syks in('''+@dept+''')'
	END


--·������				
	IF @Ljdm<>''
	BEGIN
		SET @tempsql = @tempsql + N' and clinicalPath.Ljdm in('+replace(@Ljdm,'~','''')+')'
	END


	print @tempsql
	exec sp_executesql @tempsql



--���±����������

--������
		CREATE TABLE #tempPathVariationAnalyse
		(
			Bydm	VARCHAR(100)	COLLATE Chinese_PRC_CI_AS null, --�������
			BymcSt		VARCHAR(100)		NULL,--һ����������
			BymcNd		VARCHAR(100)		NULL,--������������
			BymcRd		VARCHAR(100)		NULL,--������������
			VariationCount	INT				NULL--��Ŀ
		)
		
--��������
		

		set @sql = N'INSERT INTO #tempPathVariationAnalyse(Bydm ,BymcSt ,BymcNd ,BymcRd)
		SELECT BydmRd,BymcSt,BymcNd,BymcRd FROM #tempPathVariation
		'
		
		print @sql
		exec sp_executesql @sql
		
		
--��������
		UPDATE #tempPathVariationAnalyse SET VariationCount = 
		(
			SELECT COUNT(*) 
			FROM #tempVariantRecords vr WHERE vr.BydmId = Bydm
		)

--�������ղ�ѯ���
--SELECT * FROM #tempPathVariationAnalyse
SELECT  'D01.001.001' as Bydm,'ҽ������' as BymcSt,'��Ϊ' AS BymcNd,'�˿�����' AS BymcRd,23 as VariationCount
	UNION	select 'D01.001.002','���߱���','��Ϊ','���߾ܾ�',45
	UNION	select 'D01.D01.D02','ҽ������','��Ϊ','ҽ������001.002',24
	UNION	select 'D01.D01.D03','ҽ������','��','ҽ��ͣ��',45
	UNION	select 'D01.D01.D04','ҽ������','��','ҽ��û��',44
	UNION	select 'D01.D01.D05','���߱���','��','����',45
	UNION	select 'D01.D01.D06','���߱���','��','������',23
	UNION	select 'D01.D01.D07','ҽ������','��','����',45
	UNION	select 'D01.D01.D08','ҽ������','��','����ʹ��',32
	UNION	select 'D01.D01.D09','ҽ������','��','����仯',43

END
IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_RWPathSummary' ) 
    DROP PROCEDURE usp_CP_RWPathSummary
go
CREATE  PROCEDURE [dbo].usp_CP_RWPathSummary

@Syxh	NVARCHAR(100) = '',	--������ҳ���
@Ljxh	NVARCHAR(100) = ''	--�뾶���
AS /**********
[�汾��]	1.0.0.0.0               
[����ʱ��]	2011-05-05              
[����]		ZM         
[��Ȩ]		YidanSoft          
[����]		6·���ܽ�
[����˵��]                    
[�������]               
[�������]                    
[�����������]              
 ·���ܽṦ��         


[���õ�sp]
[����ʵ��]
			exec usp_CP_RWPathSummary '779','11'
[�޸ļ�¼]


----��������˵��
6·���ܽṦ��
��·��ִ�н�������һ����ť��·���ܽᡷ��ҽ������ʱ��ͨ�������ť�����ĳ�������˵�·��ִ�����������ִ��ҽ��������״������ϡ����顢���õȵȣ���·��������	
��ע��������ͼ��ʾ������һ�ֲ���ʾ������Ϣ��
(1)	��ѯ����
	������ҳ���
	��Ŀ���
(2)	��ѯ���
	�б�չ�� 
**********/

BEGIN     
	DECLARE @tempsqlOne nvarchar(4000)
	DECLARE @tempsqlTwo nvarchar(4000)
	DECLARE @tempsqlThree nvarchar(4000)
	DECLARE @tempsqlFour nvarchar(4000)
	DECLARE @tempsqlFive nvarchar(4000)
	DECLARE @tempsqlSix nvarchar(4000)
    
    SET nocount ON
    
--������ʱҽ����
	CREATE TABLE #TempOrder
	(
		Yzbz	nvarchar(100)	NOT NULL,	--ҽ����𣨳���/��ʱ��
		Xmlb	nvarchar(100)	NULL,		--��Ŀ���
		Ypdm	NVARCHAR(100)	NULL,		--��Ŀ����
		Ypmc	nvarchar(500)	NULL,		--��Ŀ����
		Yznr	nvarchar(500)	NULL,		--ҽ������
		ActivityId	nvarchar(500)	NULL	--·���ڵ�
	)
	
	
--������ʱ����
	set @tempsqlOne = N'INSERT INTO #TempOrder(Yzbz,Xmlb,Ypdm,Ypmc,Yznr,ActivityId)
	SELECT otp.Yzbz,long.Xmlb,long.Ypdm,long.Ypmc,long.Yznr,otp.ActivityId
	FROM dbo.CP_LongOrder long
	INNER JOIN dbo.CP_OrderToPath otp ON otp.Yzxh = long.Cqyzxh
	WHERE otp.Yzbz = 2703			/*����ҽ����Ӧ*/
	AND long.Syxh = '''+@Syxh+'''	/*����һ������*/
	AND otp.Ljxh = '''+@Ljxh+'''	/*�ô��뾶*/
	'
	
	set @tempsqlTwo = N'INSERT INTO #TempOrder(Yzbz,Xmlb,Ypdm,Ypmc,Yznr,ActivityId)
	SELECT otp.Yzbz,temp.Xmlb,temp.Ypdm,temp.Ypmc,temp.Yznr,otp.ActivityId
	FROM dbo.CP_TempOrder temp
	INNER JOIN dbo.CP_OrderToPath otp ON otp.Yzxh = temp.Lsyzxh
	WHERE otp.Yzbz = 2702			/*��ʱҽ����Ӧ*/
	AND temp.Syxh = '''+@Syxh+'''	/*����һ������*/
	AND otp.Ljxh = '''+@Ljxh+'''	/*�ô��뾶*/
	'
	
	print @tempsqlOne
	print @tempsqlTwo
	exec sp_executesql @tempsqlOne
	exec sp_executesql @tempsqlTwo
	
	
--��������ҽ�������ظ�������
	CREATE TABLE #tempDisAdviceGroup
	(
		Xmlb	NVARCHAR(100)	NULL,		--��Ŀ���
		Ypdm	NVARCHAR(100)	COLLATE Chinese_PRC_CI_AS  NULL,		--��Ŀ����
		Ypmc	NVARCHAR(100)	NULL		--��Ŀ����
	)
	
	SET @tempsqlThree = N'
	INSERT INTO #tempDisAdviceGroup
	SELECT DISTINCT Xmlb,Ypdm,Ypmc FROM dbo.CP_AdviceGroupDetail
	'
	
--��������ҽ�������ظ�������
	CREATE TABLE #tempDisOrder
	(
		Xmlb	NVARCHAR(100)	NULL,		--��Ŀ���
		Ypdm	NVARCHAR(100)	COLLATE Chinese_PRC_CI_AS  NULL,		--��Ŀ����
		Ypmc	NVARCHAR(100)	NULL		--��Ŀ����
	)
	
	SET @tempsqlFour = '
	INSERT INTO #tempDisOrder
	SELECT DISTINCT Xmlb,Ypdm,Ypmc FROM #TempOrder
	'
	
	print @tempsqlThree
	print @tempsqlFour
	exec sp_executesql @tempsqlThree
	exec sp_executesql @tempsqlFour
	
--	SELECT * FROM #TempOrder
--	SELECT * FROM #tempDisOrder
--	SELECT * FROM #tempDisAdviceGroup

--������ʱ�����
	CREATE TABLE #tempVariation
	(
		Xmlb	NVARCHAR(100)	NULL,		--��Ŀ���		
		Ypdm	NVARCHAR(100)	COLLATE Chinese_PRC_CI_AS  NULL,		--��Ŀ����
		Ypmc	NVARCHAR(100)	NULL,		--��Ŀ����
		Bynr	nvarchar(100)	NULL,		--��������
		PahtDetailID	nvarchar(100)	NULL,--·���ڵ�
	)
	
	SET @tempsqlFive = N'
	INSERT INTO #tempVariation
	SELECT tdo.Xmlb,va.Ypdm,tdo.Ypmc,(REPLACE((REPLACE((ISNULL(va.bynr,'''')),''ҽ����'','''')),''��'','':	'')+'',''+ISNULL(va.Byyy,''''))AS Bynr,va.PahtDetailID
	FROM dbo.CP_VariantRecords va
	INNER JOIN #tempDisOrder tdo ON tdo.Ypdm = va.Ypdm
	WHERE	va.Bylx = 1301				/*����*/
	AND		va.Syxh = '''+@Syxh+'''		/*����ͬһ����*/
	AND		va.Ljxh = '''+@Ljxh+'''		/*����ô��뾶*/
	'
	
	SET @tempsqlSix = N'
	INSERT INTO #tempVariation
	SELECT tdo.Xmlb,va.Ypdm,tdo.Ypmc,(REPLACE((REPLACE((ISNULL(va.bynr,'''')),''ҽ����'','''')),''��'','':	'')+'',''+ISNULL(va.Byyy,''''))AS Bynr,va.PahtDetailID
	FROM dbo.CP_VariantRecords va
	INNER JOIN #tempDisAdviceGroup tdo ON tdo.Ypdm = va.Ypdm
	WHERE	va.Bylx = 1300				/*��ѡδִ�У�����ҽ����*/
	AND		va.Syxh = '''+@Syxh+'''		/*����ͬһ����*/
	AND		va.Ljxh = '''+@Ljxh+'''		/*����ô��뾶*/
	'
	
	print @tempsqlFive
	print @tempsqlSix
	exec sp_executesql @tempsqlFive
	exec sp_executesql @tempsqlSix
	
	SELECT * FROM #TempOrder
	SELECT * FROM #tempVariation
	SELECT enForce.Jddm,detail.Ljmc,enForce.Zxsx,enForce.Jrsj
	FROM CP_InPatientPathEnForceDetail enForce
	INNER JOIN dbo.CP_PathDetail detail ON detail.PahtDetailID = enForce.Jddm
	WHERE enForce.Syxh = @Syxh
	AND enForce.Ljxh = @Ljxh
	ORDER BY enForce.Zxsx DESC
	
	end
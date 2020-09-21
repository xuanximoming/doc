IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_RptPathQuitMonthCompare' ) 
    DROP PROCEDURE usp_CP_RptPathQuitMonthCompare
go
CREATE  PROCEDURE [dbo].[usp_CP_RptPathQuitMonthCompare]

@begindate nvarchar(100) ,--��ѯ��ʼ����
@enddate nvarchar(100),   --��ѯ��������  
@dept nvarchar(12) = '',       --�ٴ����� 
@Ljdm nvarchar(100) = ''     --·������
AS /**********    
[�汾��] 1.0.0.0.0               
[����ʱ��]  2011-04-19              
[����]    ZM         
[��Ȩ]    YidanSoft          
[����] 8.3�¶ȳ���ָ��ͳ�Ʒ���
[����˵��]                    
[�������]               
[�������]                    
[�����������]              
�¶ȳ���ָ��ͳ�Ʒ���          


[���õ�sp]                    
[����ʵ��]              
 exec usp_CP_RptPathQuitMonthCompare  '2011','2012','',''            
[�޸ļ�¼]           


----��������˵��
(5)�¶ȳ���ָ��ͳ�Ʒ���
ͳ��ĳ����,ÿ����·�����˳����
(1)	��ѯ����
	ʱ���
	·������
	�ٴ�����
(2)	��ѯ���
	�б�չ�� 
	ͳ��ͼ��ʾ
**********/   

BEGIN     
	DECLARE @tempsqlOne nvarchar(4000)
	DECLARE @tempsqlTwo nvarchar(4000)
	DECLARE @sql nvarchar(4000)       
    SET nocount ON   


--������ʱ��
	create table #tempPathExecuteInfo
	(
		LjdmID		varchar(100)		COLLATE Chinese_PRC_CI_AS not null, --·������
		Ljcz		int					not null,--·��ִ��״̬
		Czsj		varchar(100)		null--�˳�ʱ��(·��ִ�б�,�������Ϊ��)
	)

--������ʱ����
--(Ŀǰ��������Ϊ,״̬Ϊ�˳�/���·���Լ����븽������)
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

--�ٴ�����
	IF @dept<>''
	begin
		SET @tempsqlOne = @tempsqlOne + N' and clinicalpath.Syks in('''+@dept+''')'
		SET @tempsqlTwo = @tempsqlTwo + N' and clinicalpath.Syks in('''+@dept+''')'
	END


--·������				
	IF @Ljdm<>''
	BEGIN
		SET @tempsqlOne = @tempsqlOne + N' and clinicalpath.Ljdm in('+replace(@Ljdm,'~','''')+')'
		SET @tempsqlTwo = @tempsqlTwo + N' and clinicalpath.Ljdm in('+replace(@Ljdm,'~','''')+')'
	END


	print @tempsqlOne
	print @tempsqlTwo
	exec sp_executesql @tempsqlOne
	exec sp_executesql @tempsqlTwo

--�����¶ȳ�������

--������
	create table #temppathQuitMonthCompare
	(
		Ljdm		varchar(100)		COLLATE Chinese_PRC_CI_AS not null, --·������
		Ljmc		varchar(100)		not null,--·������
		Syks		varchar(100)		null,--��Ӧ����(·����,�������Ϊ��)
		Jan			int					null,--һ��
		Feb			int					null,--����
		Mar			int					null,--����
		Apr			int					null,--����
		May			int					null,--����
		Jun			int					null,--����
		Jul			int					null,--����
		Aug			int					null,--����
		Sept		int					null,--����
		Oct			int					null,--ʮ��
		Nov			int					null,--ʮһ��
		Dec			int					null,--ʮ����
	)


--����·��������Ϣ
	set @sql = N'insert into #temppathQuitMonthCompare(Ljdm,Ljmc,Syks)
	select ljdm,[name],syks from CP_ClinicalPath where 1=1
	'

--�ٴ�����
	IF @dept<>''
	begin
		SET @sql = @sql + N' and Syks in('''+@dept+''')'
	END


--·������				
	IF @Ljdm<>''
	BEGIN
		SET @sql = @sql + N' and Ljdm in('+replace(@Ljdm,'~','''')+')'
	END

	print @sql
	exec sp_executesql @sql 


--����һ��
	update #temppathQuitMonthCompare set Jan = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-01' and temp.Czsj <= ''+@begindate+'-02'  then 1 ELSE 0 end) 
	from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--���¶���
	update #temppathQuitMonthCompare set Feb = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-02' and temp.Czsj <= ''+@begindate+'-03'  then 1 ELSE 0 end)
	 from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--��������
	update #temppathQuitMonthCompare set Mar = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-03' and temp.Czsj <= ''+@begindate+'-04'  then 1 ELSE 0 end)
	 from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--��������
	update #temppathQuitMonthCompare set Apr = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-04' and temp.Czsj <= ''+@begindate+'-05'  then 1 ELSE 0 end) 
	from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--��������
	update #temppathQuitMonthCompare set May = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-05' and temp.Czsj <= ''+@begindate+'-06'  then 1 ELSE 0 end) 
	from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--��������
	update #temppathQuitMonthCompare set Jun = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-06' and temp.Czsj <= ''+@begindate+'-07'  then 1 ELSE 0 end)
	 from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--��������
	update #temppathQuitMonthCompare set Jul = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-07' and temp.Czsj <= ''+@begindate+'-08'  then 1 ELSE 0 end)
	 from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--���°���
	update #temppathQuitMonthCompare set Aug = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-08' and temp.Czsj <= ''+@begindate+'-09'  then 1 ELSE 0 end) 
	from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--���¾���
	update #temppathQuitMonthCompare set Sept = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-09' and temp.Czsj <= ''+@begindate+'-10'  then 1 ELSE 0 end)
	 from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--����ʮ��
	update #temppathQuitMonthCompare set Oct = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-10' and temp.Czsj <= ''+@begindate+'-11'  then 1 ELSE 0 end)
	 from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--����ʮһ��
	update #temppathQuitMonthCompare set Nov = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-11' and temp.Czsj <= ''+@begindate+'-12'  then 1 ELSE 0 end)
	 from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)
--����ʮ����
	update #temppathQuitMonthCompare set Dec = isnull(
	(select sum(case when temp.Czsj >= ''+@begindate+'-12' and temp.Czsj < ''+@enddate+'-01'  then 1 ELSE 0 end)
	 from #tempPathExecuteInfo temp where temp.LjdmID = Ljdm)
	,0)


--�������ղ�ѯ���

--select * from #temppathQuitMonthCompare
SELECT  'P.K40.001' as Ljdm,'���ɹ����ٴ�·��' as Ljmc,'2032' as Syks, 
'35'as Jan,'23' as Feb,'54'as Mar,'65' as Apr,'34' as May,'65' as Jun,'67'as Jul,'33' as Aug,'66' AS Sept,'54' as Oct,'67' as Nov, '34' AS Dec
	UNION	select 'P.A08.001','��״���������ٴ�·��','3130','34','56','56','54','33','56','43','3','32','45','32','45'
	UNION	select 'P.B05.001','����ϲ������ٴ�·��','3127','45','78','54','23','3','6','14','5','3','43','2','21'
	UNION	select 'P.C01.001','�఩�ٴ�·��','3120','34','78','25','65','11','56','54','65','32','45','35','45'
	UNION	select 'P.C15.001','ʳ�ܰ��ٴ�·��','4102','67','62','54','34','43','56','34','3','54','43','22','23'
	UNION	select 'P.C34.001','֧���ܷΰ��ٴ�·��','4102','34','23','11','67','32','56','43','1','16','45','32','45'
	UNION	select 'P.C50.001','���ٰ��ٴ�·��','2032','44','4','56','65','33','24','67','65','54','24','32','45'
	UNION	select 'P.C53.001','�������ٴ�·��','2011','32','243','43','4','23','56','43','76','42','45','89','54'
	UNION	select 'P.C64.001','�����ٴ�·��','3202','46','22','4','24','65','34','43','76','43','45','32','45'
	UNION	select 'P.C64.002','���������ٴ�·��','3202','5','24','44','24','78','56','43','24','34','7','87','45'
	UNION	select 'P.C64.003','����������','3101','31','23','14','24','33','56','78','65','32','43','76','45'
	UNION	select 'P.C70.001','­ǰ�ѵ���Ĥ���ٴ�·��','4098','10','43','2','65','33','56','56','65','54','14','32','45'
	UNION	select 'P.C75.001','���������ٴ�·��','4098','78','45','1','65','22','56','43','7','32','43','42','45'
	UNION	select 'P.C75.002','С�Ա��������޻����ٴ�·��','4098','75','23','45','98','33','56','56','65','32','3','32','24'
	UNION	select 'P.D25.001','�ӹ�ƽ�������ٴ�·��','2011','33','45','32','34','35','32','32','56','21','76','4','45'
	UNION	select 'P.D27.001','�ѳ����������ٴ�·��','2011','65','56','24','98','87','56','43','2','32','44','31','45'
	UNION	select 'P.E04.001','����Լ�״�����ٴ�·��','2032','25','23','24','65','33','56','46','5','34','2','32','23'
	UNION	select 'P.E04.002','��״�ٶ�������','3130','36','23','23','87','33','56','12','76','32','7','32','45'
	UNION	select 'P.G40.001','����ٴ�·��','3107','68','23','32','65','65','56','4','24','54','45','51','34'
	UNION	select 'P.G40.002','��֢�������ٴ�·��','3107','75','65','29','65','33','21','43','245','31','45','31','32'
	UNION	select 'P.G61.001','����-�����ۺ����ٴ�·��','3107','25','23','54','45','34','56','43','24','22','45','32','34'
	UNION	select 'P.H40.001','ԭ���Լ��Աս���������ٴ�·��','3118','24','76','54','45','33','56','43','13','32','23','24','45'
	UNION	select 'P.H66.001',' ���Ի�ŧ���ж����ٴ�·��','3120','65','23','56','45','67','56','43','21','56','43','32','65'
	UNION	select 'P.I26.001','��Ѫ˨˨��','3101','75','23','54','5','33','56','43','1','234','4','32','45'
	UNION	select 'P.I49.001','��̬񼷿���ۺ����ٴ�·��','3102','35','44','11','54','43','56','34','21','32','32','11','12'
	

END 

go
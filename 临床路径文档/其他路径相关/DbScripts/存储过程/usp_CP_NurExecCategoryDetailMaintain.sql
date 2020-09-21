IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_NurExecCategoryDetailMaintain' ) 
    DROP PROCEDURE usp_CP_NurExecCategoryDetailMaintain
go
CREATE  PROCEDURE usp_CP_NurExecCategoryDetailMaintain

@Operation	NVARCHAR(100) = '' ,	--������(selectList	��ѯ����select��ѯ������insert���������update���²�����deleteɾ������)
@Lbxh nvarchar(100)	= '',			--�������
@Yxjl nvarchar(100)	= '',			--��ϸ��״̬(1��Ч��0��Ч)
@Sfsy nvarchar(100)= '',			--��ϸ���Ƿ�ʹ�ã�1ʹ���У�0δʹ�ã�
 
@Mxxh nvarchar(100)	= '',			--��ϸ�����
@MxxhName NVARCHAR(100)	= '',		--��ϸ������
@Create_Time NVARCHAR(100)	= '',		--����ʱ��
@Create_User NVARCHAR(100)	= '',		--������
@Cancel_Time NVARCHAR(100)	= '',		--ȡ��ʱ��
@Cancel_User NVARCHAR(100)	= ''	--ȡ����
AS /**********
[�汾��]	1.0.0.0.0               
[����ʱ��]	2011-05-13             
[����]		ZM         
[��Ȩ]		YidanSoft          
[����]		4.5����ά������
[����˵��]                    
[�������]               
[�������]                    
[�����������]              
����ά��     


[���õ�sp]
[����ʵ��]
			exec usp_CP_NurExecCategoryDetailMaintain 'selectList','','',''
[�޸ļ�¼]


----��������˵��
4.5����ά������

(1)	��ѯ����
	����Ĭ������Ч״̬
	�������
	��ϸ��״̬
	��ϸ��ʹ��״̬
(2)	��ѯ���
	�б�չ�� 
**********/

BEGIN

	IF @Operation = 'selectList'
	Begin
		SELECT Lbxh,Name AS LbxhName FROM dbo.CP_NurExecCategory
	END
	
	IF @Operation = 'select'
	BEGIN
		DECLARE @tempsql nvarchar(4000)

		set @tempsql = N'
		SELECT  necd.Mxxh,nec.Name as LbxhName ,
        necd.Name as MxxhName,CASE necd.Yxjl WHEN 0 THEN ''ͣ��''
         WHEN 1 THEN ''��Ч'' END AS Yxjl,CASE necd.Sfsy WHEN 0 THEN ''δ��''
        WHEN 1 THEN ''ʹ����'' END AS Sfsy
		from	dbo.CP_NurExecCategoryDetail necd
		inner join  dbo.CP_NurExecCategory nec on nec.Lbxh = necd.Lbxh
		WHERE	nec.Yxjl = 1		/*������Ч*/
		'
		
		IF @Lbxh<>''
		begin
		SET @tempsql = @tempsql + N'AND	nec.Lbxh = '''+@Lbxh+'''		/*�������*/'
		END
		IF @Yxjl<>''
		begin
		SET @tempsql = @tempsql + N'AND	necd.Yxjl = '''+@Yxjl+'''		/*��ϸ״̬*/'
		END
		IF @Sfsy<>''
		begin
		SET @tempsql = @tempsql + N'AND	necd.Sfsy = '''+@Sfsy+'''		/*��ϸ�Ƿ�ʹ��*/'
		END
		
		print @tempsql
		exec sp_executesql @tempsql
		
	END
	
	IF @Operation = 'insert'
	BEGIN
		INSERT INTO CP_NurExecCategoryDetail(Mxxh,Name,Lbxh,Yxjl,Create_Time,Create_User,Cancel_Time,Cancel_User,Sfsy)
		VALUES(@Mxxh,@MxxhName,@Lbxh,1,@Create_Time,@Create_User,'','',0)
		
		SELECT  necd.Mxxh,
		nec.Name as LbxhName ,
        necd.Name as MxxhName,
        CASE necd.Yxjl WHEN 0 THEN 'ͣ��'
         WHEN 1 THEN '��Ч' END AS Yxjl,
        CASE necd.Sfsy WHEN 0 THEN 'δ��'
        WHEN 1 THEN 'ʹ����' END AS Sfsy
		from	dbo.CP_NurExecCategoryDetail necd
		inner join  dbo.CP_NurExecCategory nec on nec.Lbxh = necd.Lbxh
		WHERE	nec.Yxjl = 1		/*������Ч*/
	END
	
	IF @Operation = 'updateBegin'
	BEGIN
		UPDATE dbo.CP_NurExecCategoryDetail
		SET Yxjl = 1
		WHERE Mxxh = @Mxxh
		
		SELECT  necd.Mxxh,
		nec.Name as LbxhName ,
        necd.Name as MxxhName,
        CASE necd.Yxjl WHEN 0 THEN 'ͣ��'
         WHEN 1 THEN '��Ч' END AS Yxjl,
        CASE necd.Sfsy WHEN 0 THEN 'δ��'
        WHEN 1 THEN 'ʹ����' END AS Sfsy
		from	dbo.CP_NurExecCategoryDetail necd
		inner join  dbo.CP_NurExecCategory nec on nec.Lbxh = necd.Lbxh
		WHERE	nec.Yxjl = 1		/*������Ч*/
	END
	
	IF @Operation = 'updateEnd'
	BEGIN
		UPDATE dbo.CP_NurExecCategoryDetail
		SET Yxjl = 0,
		Cancel_Time = @Cancel_Time,
		Cancel_User = @Cancel_User
		WHERE Mxxh = @Mxxh
		
		
		SELECT  necd.Mxxh,
		nec.Name as LbxhName ,
        necd.Name as MxxhName,
        CASE necd.Yxjl WHEN 0 THEN 'ͣ��'
         WHEN 1 THEN '��Ч' END AS Yxjl,
        CASE necd.Sfsy WHEN 0 THEN 'δ��'
        WHEN 1 THEN 'ʹ����' END AS Sfsy
		from	dbo.CP_NurExecCategoryDetail necd
		inner join  dbo.CP_NurExecCategory nec on nec.Lbxh = necd.Lbxh
		WHERE	nec.Yxjl = 1		/*������Ч*/
	END
	
	IF @Operation = 'delete'
	BEGIN
		DELETE dbo.CP_NurExecCategoryDetail
		WHERE Mxxh = @Mxxh
		
		SELECT  necd.Mxxh,
		nec.Name as LbxhName ,
        necd.Name as MxxhName,
        CASE necd.Yxjl WHEN 0 THEN 'ͣ��'
         WHEN 1 THEN '��Ч' END AS Yxjl,
        CASE necd.Sfsy WHEN 0 THEN 'δ��'
        WHEN 1 THEN 'ʹ����' END AS Sfsy
		from	dbo.CP_NurExecCategoryDetail necd
		inner join  dbo.CP_NurExecCategory nec on nec.Lbxh = necd.Lbxh
		WHERE	nec.Yxjl = 1		/*������Ч*/
	END
	
END
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go






ALTER  PROCEDURE [dbo].[usp_CP_AdviceSuitCategoryManage]
@sqlType		varchar(20)='InsertAndSelect',	--�������(InsertAndSelect��Ӳ�ѯ;Update�޸�;Deleteɾ��)
@CategoryId		VARCHAR(50) ='',	--�ײ�������
@Name			VARCHAR(32)='',		--(ҽ���ײ����)���� 
@Wb				VARCHAR(8)='',		--��� 
@Zgdm			VARCHAR(6)='',		--ְ������(¼����Ա����)
@Yxjl			SMALLINT=1,			--��Ч��¼
@Memo			VARCHAR(50)='',		--��ע
@ParentID		VARCHAR(50)=''		--��ע
AS
/******                
[�汾��] 1.0.0.0.0               
[����ʱ��]  2011-7-14             
[����]    dxj          
[��Ȩ]    YidanSoft          
[����] ҽ���ײ������� 
[����˵��]                    
[�������]               
[�������]                    
[�����������]                           
             
[���õ�sp]                    
[����ʵ��]              
 exec usp_CP_AdviceSuitCategoryManage     
[�޸ļ�¼]            
*******/
    
/******

�ֶΰ���:
�ֶ�ע�ͣ�
******/	   
BEGIN  
	SET NOCOUNT ON 
	--���ǰ��֤�����Ƿ����
	IF	@sqlType='InsertCheckInfo'
	BEGIN
		SELECT NAME FROM CP_AdviceSuitCategory WHERE NAME = @Name    
	END
	--���
	IF	@sqlType='InsertAndSelect'
	BEGIN
		IF  @CategoryId<>''
		BEGIN
			INSERT INTO CP_AdviceSuitCategory(CategoryId,
										  Name,
										  Py, 
										  Wb,    	
										  Zgdm,	
										  AddTime, 
										  Yxjl,
										  ParentID,
										  Memo)
						VALUES(
								@CategoryId,
								@Name,
								dbo.fun_getPY(@Name),
								@Wb,
								@Zgdm,
								convert(varchar(19), getdate(), 120),
								@Yxjl,
								@ParentID,
								@Memo
							  )
		END
		SELECT CategoryId,Name,ParentID,Py,Wb,Zgdm,AddTime,Yxjl,Memo FROM CP_AdviceSuitCategory
	END
	--�޸�ǰ��֤�����Ƿ��ظ�
	IF	@sqlType='UpdateCheckInfo'
		BEGIN
			SELECT Name FROM CP_AdviceSuitCategory WHERE Name=@Name AND CategoryId !=@CategoryId
		END
    --�޸�
	IF	@sqlType='Update'
		BEGIN
			UPDATE CP_AdviceSuitCategory SET 
					  Name=@Name,
					  Py=dbo.fun_getPY(@Name),
					  Wb=@Wb,    	
					  Zgdm=@Zgdm,	
					  AddTime=convert(varchar(19), getdate(), 120), 
					  Yxjl=@Yxjl,
					  Memo=@Memo
					  WHERE CategoryId=@CategoryId
		END
	--ɾ��ǰ��֤�÷����Ƿ�ʹ��
	IF	@sqlType='DeleteCheckInfo'
	BEGIN
		SELECT CategoryId FROM CP_AdviceSuit WHERE CategoryId=@CategoryId
	END
	--ɾ��
	IF @sqlType='Delete'
		BEGIN
			DELETE FROM CP_AdviceSuitCategory WHERE CategoryId=@CategoryId
		END	
END





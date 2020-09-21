set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go






ALTER  PROCEDURE [dbo].[usp_CP_AdviceSuitCategoryManage]
@sqlType		varchar(20)='InsertAndSelect',	--操作类别(InsertAndSelect添加查询;Update修改;Delete删除)
@CategoryId		VARCHAR(50) ='',	--套餐类别序号
@Name			VARCHAR(32)='',		--(医嘱套餐类别)名称 
@Wb				VARCHAR(8)='',		--五笔 
@Zgdm			VARCHAR(6)='',		--职工代码(录入人员代码)
@Yxjl			SMALLINT=1,			--有效记录
@Memo			VARCHAR(50)='',		--备注
@ParentID		VARCHAR(50)=''		--备注
AS
/******                
[版本号] 1.0.0.0.0               
[创建时间]  2011-7-14             
[作者]    dxj          
[版权]    YidanSoft          
[描述] 医嘱套餐类别管理 
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]                           
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_AdviceSuitCategoryManage     
[修改记录]            
*******/
    
/******

字段包括:
字段注释：
******/	   
BEGIN  
	SET NOCOUNT ON 
	--添加前验证名称是否存在
	IF	@sqlType='InsertCheckInfo'
	BEGIN
		SELECT NAME FROM CP_AdviceSuitCategory WHERE NAME = @Name    
	END
	--添加
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
	--修改前验证名称是否重复
	IF	@sqlType='UpdateCheckInfo'
		BEGIN
			SELECT Name FROM CP_AdviceSuitCategory WHERE Name=@Name AND CategoryId !=@CategoryId
		END
    --修改
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
	--删除前验证该分类是否使用
	IF	@sqlType='DeleteCheckInfo'
	BEGIN
		SELECT CategoryId FROM CP_AdviceSuit WHERE CategoryId=@CategoryId
	END
	--删除
	IF @sqlType='Delete'
		BEGIN
			DELETE FROM CP_AdviceSuitCategory WHERE CategoryId=@CategoryId
		END	
END





IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_NurExecCategoryDetailMaintain' ) 
    DROP PROCEDURE usp_CP_NurExecCategoryDetailMaintain
go
CREATE  PROCEDURE usp_CP_NurExecCategoryDetailMaintain

@Operation	NVARCHAR(100) = '' ,	--操作符(selectList	查询类别表，select查询操作，insert插入操作，update更新操作，delete删除操作)
@Lbxh nvarchar(100)	= '',			--类别表序号
@Yxjl nvarchar(100)	= '',			--明细表状态(1有效，0无效)
@Sfsy nvarchar(100)= '',			--明细表是否使用（1使用中，0未使用）
 
@Mxxh nvarchar(100)	= '',			--明细表序号
@MxxhName NVARCHAR(100)	= '',		--明细表名称
@Create_Time NVARCHAR(100)	= '',		--创建时间
@Create_User NVARCHAR(100)	= '',		--创建人
@Cancel_Time NVARCHAR(100)	= '',		--取消时间
@Cancel_User NVARCHAR(100)	= ''	--取消人
AS /**********
[版本号]	1.0.0.0.0               
[创建时间]	2011-05-13             
[作者]		ZM         
[版权]		YidanSoft          
[描述]		4.5护理维护界面
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
护理维护     


[调用的sp]
[调用实例]
			exec usp_CP_NurExecCategoryDetailMaintain 'selectList','','',''
[修改记录]


----窗口需求说明
4.5护理维护界面

(1)	查询条件
	类别表默认是有效状态
	类别表序号
	明细表状态
	明细表使用状态
(2)	查询结果
	列表展现 
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
        necd.Name as MxxhName,CASE necd.Yxjl WHEN 0 THEN ''停用''
         WHEN 1 THEN ''有效'' END AS Yxjl,CASE necd.Sfsy WHEN 0 THEN ''未用''
        WHEN 1 THEN ''使用中'' END AS Sfsy
		from	dbo.CP_NurExecCategoryDetail necd
		inner join  dbo.CP_NurExecCategory nec on nec.Lbxh = necd.Lbxh
		WHERE	nec.Yxjl = 1		/*大类有效*/
		'
		
		IF @Lbxh<>''
		begin
		SET @tempsql = @tempsql + N'AND	nec.Lbxh = '''+@Lbxh+'''		/*大类序号*/'
		END
		IF @Yxjl<>''
		begin
		SET @tempsql = @tempsql + N'AND	necd.Yxjl = '''+@Yxjl+'''		/*明细状态*/'
		END
		IF @Sfsy<>''
		begin
		SET @tempsql = @tempsql + N'AND	necd.Sfsy = '''+@Sfsy+'''		/*明细是否使用*/'
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
        CASE necd.Yxjl WHEN 0 THEN '停用'
         WHEN 1 THEN '有效' END AS Yxjl,
        CASE necd.Sfsy WHEN 0 THEN '未用'
        WHEN 1 THEN '使用中' END AS Sfsy
		from	dbo.CP_NurExecCategoryDetail necd
		inner join  dbo.CP_NurExecCategory nec on nec.Lbxh = necd.Lbxh
		WHERE	nec.Yxjl = 1		/*大类有效*/
	END
	
	IF @Operation = 'updateBegin'
	BEGIN
		UPDATE dbo.CP_NurExecCategoryDetail
		SET Yxjl = 1
		WHERE Mxxh = @Mxxh
		
		SELECT  necd.Mxxh,
		nec.Name as LbxhName ,
        necd.Name as MxxhName,
        CASE necd.Yxjl WHEN 0 THEN '停用'
         WHEN 1 THEN '有效' END AS Yxjl,
        CASE necd.Sfsy WHEN 0 THEN '未用'
        WHEN 1 THEN '使用中' END AS Sfsy
		from	dbo.CP_NurExecCategoryDetail necd
		inner join  dbo.CP_NurExecCategory nec on nec.Lbxh = necd.Lbxh
		WHERE	nec.Yxjl = 1		/*大类有效*/
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
        CASE necd.Yxjl WHEN 0 THEN '停用'
         WHEN 1 THEN '有效' END AS Yxjl,
        CASE necd.Sfsy WHEN 0 THEN '未用'
        WHEN 1 THEN '使用中' END AS Sfsy
		from	dbo.CP_NurExecCategoryDetail necd
		inner join  dbo.CP_NurExecCategory nec on nec.Lbxh = necd.Lbxh
		WHERE	nec.Yxjl = 1		/*大类有效*/
	END
	
	IF @Operation = 'delete'
	BEGIN
		DELETE dbo.CP_NurExecCategoryDetail
		WHERE Mxxh = @Mxxh
		
		SELECT  necd.Mxxh,
		nec.Name as LbxhName ,
        necd.Name as MxxhName,
        CASE necd.Yxjl WHEN 0 THEN '停用'
         WHEN 1 THEN '有效' END AS Yxjl,
        CASE necd.Sfsy WHEN 0 THEN '未用'
        WHEN 1 THEN '使用中' END AS Sfsy
		from	dbo.CP_NurExecCategoryDetail necd
		inner join  dbo.CP_NurExecCategory nec on nec.Lbxh = necd.Lbxh
		WHERE	nec.Yxjl = 1		/*大类有效*/
	END
	
END
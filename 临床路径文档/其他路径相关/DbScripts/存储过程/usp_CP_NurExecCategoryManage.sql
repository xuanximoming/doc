set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


ALTER  PROCEDURE [dbo].[usp_CP_NurExecCategoryManage]
@Lbxh varchar(12),		--类别编码
@Name varchar(12),		--项目名称
@Xmxh varchar(12),--项目编码,CP_NurExecItem. Xmxh
@InputType smallint,  --输入控件类型（0无,1用户控件）暂时保留
@OrderValue numeric(12,0),--排序字段
@Yxjl smallint, --是否有效
@Create_User varchar(10),--创建人
@Cancel_Time varchar(19) ,--删除时间
@Cancel_User varchar(10) ,--删除人
@sqlType varchar(20)='InsertAndSelect'--操作类别
AS
/******                
[版本号] 1.0.0.0.0               
[创建时间]  2011-5-23            
[作者]    dxj          
[版权]    YidanSoft          
[描述]	  护理执行类别表维护 
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]                            
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_NurExecCategoryManage   
[修改记录]            
*******/
/******
字段包括:
字段注释：
******/	
BEGIN     
		DECLARE @sql nvarchar(4000)       
		SET NOCOUNT ON 
		
		--添加，查询
		IF	@sqlType='InsertAndSelect'
		BEGIN
			IF	@Lbxh<>''
			BEGIN
				INSERT INTO dbo.CP_NurExecCategory
					( Lbxh ,
					  Name ,
					  Xmxh ,
					  InputType ,
					  OrderValue ,
					  Yxjl ,
					  Create_User ,
					  Cancel_Time ,
					  Cancel_User
					)
				VALUES( @Lbxh, -- Lbxh - varchar(12)
						@Name, -- Name - varchar(12)
						@Xmxh, -- Xmxh - varchar(12)
						@InputType, -- InputType - smallint
						@OrderValue, -- OrderValue - numeric
						@Yxjl, -- Yxjl - smallint
						@Create_User, -- Create_User - varchar(10)
						@Cancel_Time, -- Cancel_Time - varchar(19)
						@Cancel_User-- Cancel_User - varchar(10)
					   )
			END
			SELECT * FROM dbo.CP_NurExecCategory
		END
		--修改
		IF	@sqlType='Update'
		BEGIN
			UPDATE dbo.CP_NurExecCategory SET 
					  Name=@Name ,
					  Xmxh=@Xmxh ,
					  InputType=@InputType ,
					  OrderValue=@OrderValue ,
					  Yxjl=@Yxjl,
					  Create_User=@Create_User ,
					  Cancel_Time=@Cancel_Time,
					  Cancel_User=@Cancel_User
					  WHERE Lbxh=@Lbxh
		END
		--删除
		IF @sqlType='Delete'
		BEGIN
			DELETE FROM dbo.CP_NurExecCategory WHERE Lbxh =@Lbxh
		END	   
END






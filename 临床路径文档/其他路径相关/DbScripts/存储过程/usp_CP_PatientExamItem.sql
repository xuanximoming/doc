set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

ALTER  PROCEDURE [dbo].[usp_CP_PatientExamItem]
@Operation VARCHAR(50)='InsertAndSelect',--操作类型
@ID VARCHAR(20),--自增主键
@Syxh VARCHAR(100),--首页序号
@Jcxm VARCHAR(50),--检查项目
@Jcjg VARCHAR(50),--检查结果
@Dw VARCHAR(20),--单位
@Bz VARCHAR(200)--备注
AS
/******                
[版本号] 1.0.0.0.0               
[创建时间]  2011-5-13            
[作者]    dxj          
[版权]    YidanSoft          
[描述] 病人检查项维护 
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]                            
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_PatientExamItem       
[修改记录]            
*******/
    
----报表需求说明
/******
字段包括:
字段注释：
******/	   
BEGIN          
	IF	@Operation='InsertAndSelect'
	BEGIN
		IF @Jcxm<>''
		BEGIN
		INSERT INTO dbo.CP_PatientExamItem
		        ( Syxh, Jcxm, Jcjg, Dw, Bz )
		VALUES  ( @Syxh, -- Syxh - numeric
		          @Jcxm, -- Jcxm - varchar(50)
		          @Jcjg, -- Jcjg - varchar(50)
		          @Dw, -- Dw - varchar(20)
		          @Bz -- Bz - varchar(200)
		        )
		 END
		 SELECT ID,Syxh,Jcxm,Jcmc,Jcjg,Dw,Bz FROM CP_PatientExamItem 
		 LEFT JOIN
		 (
		 SELECT Jcbm,Jcmc FROM dbo.CP_ExamDictionaryDetail 
		 )T ON T.Jcbm = CP_PatientExamItem.Jcxm 
		 WHERE Syxh = @Syxh ORDER BY ID DESC
	END
	IF @Operation='Update'
	BEGIN
		UPDATE dbo.CP_PatientExamItem SET
		Syxh=@Syxh,
		Jcxm=@Jcxm,
		Jcjg=@Jcjg,
		Dw=@Dw,
		bz=@Bz
		WHERE ID=@ID
	END
	IF @Operation='Delete'
	BEGIN
		DELETE FROM dbo.CP_PatientExamItem WHERE ID = @ID
	END
END


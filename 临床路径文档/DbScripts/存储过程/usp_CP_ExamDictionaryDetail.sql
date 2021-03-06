set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go



ALTER  PROCEDURE [dbo].[usp_CP_ExamDictionaryDetail]
@Operation VARCHAR(50)='InsertAndSelect',--操作类型
@Jcbm VARCHAR(50),--检查项目编码
@Flbm VARCHAR(50),--分类编号
@Jcmc VARCHAR(200),--检查项目名称
@Mcsx VARCHAR(50),--名称缩写符号
@Ksfw VARCHAR(100),--开始范围(正常范围)
@Jsfw VARCHAR(100),--结束范围(正常范围)
@Jsdw VARCHAR(20),--单位
@Yxjl BIT,--有效记录
@Bz VARCHAR(200)--备注
AS
/******                
[版本号] 1.0.0.0.0               
[创建时间]  2011-5-11            
[作者]    dxj          
[版权]    YidanSoft          
[描述] 添加检查项目 
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]                            
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_ExamDictionaryDetail       
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
		IF @Jcmc<>''
		BEGIN
		INSERT INTO dbo.CP_ExamDictionaryDetail
		        ( Jcbm ,
		          Flbm ,
		          Jcmc ,
		          Mcsx ,
		          Ksfw ,
		          Jsfw ,
		          Jsdw ,
		          Py ,
		          Wb ,
		          Yxjl ,
		          Bz
		        )
		VALUES  ( '' , -- Jcbm - varchar(50)
		          @Flbm , -- Flbm - varchar(50)
		          @Jcmc , -- Jcmc - varchar(200)
		          @Mcsx , -- Mcsx - varchar(50)
		          @Ksfw , -- Ksfw - varchar(100)
		          @Jsfw , -- Jsfw - varchar(100)
		          @Jsdw , -- Jsdw - varchar(20)
		          dbo.fun_getPY(@Jcmc) , -- Py - varchar(50)
		          '' , -- Wb - varchar(50)
		          @Yxjl , -- Yxjl - bit
		          @Bz  -- Bz - varchar(200)
		        )
		 UPDATE dbo.CP_ExamDictionaryDetail SET Jcbm = Jlxh WHERE Jlxh = (SELECT SCOPE_IDENTITY())
		 END
		 SELECT Detail.Jcbm,Flbm,Flmc,Jcmc,Mcsx,Ksfw,Jsfw,Jsdw,Py,Wb,
		 Yxjlmc = CASE WHEN Yxjl=1 THEN '有效' WHEN Yxjl=0 THEN '无效' END,Bz 
         FROM CP_ExamDictionaryDetail Detail
		 LEFT JOIN
		 (
		 SELECT Jcbm,Jcmc Flmc FROM CP_ExamDictionary
		 )T ON T.Jcbm=Detail.Flbm
		 ORDER BY Jlxh DESC
	END
	IF @Operation='Update'
	BEGIN
		UPDATE dbo.CP_ExamDictionaryDetail SET 
		Flbm=@Flbm,
		Jcmc=@Jcmc,
		Mcsx=@Mcsx,
		Ksfw=@Ksfw,
		Jsfw=@Jsfw,
		Jsdw=@Jsdw,
		py=dbo.fun_getPY(@Jcmc),
		wb='',
		Yxjl=@Yxjl,
		bz=@Bz
		WHERE Jcbm=@Jcbm
	END
	IF @Operation='Delete'
	BEGIN
		DELETE FROM dbo.CP_ExamDictionaryDetail WHERE Jcbm=@Jcbm
	END
END
		 
		 

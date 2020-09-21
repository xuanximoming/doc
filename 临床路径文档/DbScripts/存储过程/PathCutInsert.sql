IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_PathCutInsert' ) 
    DROP PROCEDURE usp_CP_PathCutInsert
go
CREATE  PROCEDURE [dbo].usp_CP_PathCutInsert

@Name VARCHAR(64) = '' ,
@Ljms VARCHAR(255)  = '' ,
@Zgts NUMERIC  = 1.0,
@Jcfy NUMERIC  = 1.0,
@Vesion NUMERIC  = 1.0,
@Shys VARCHAR(6)  = '',
@Yxjl INT = 1,
@Syks VARCHAR(12)  = '',
@Bzdm VARCHAR(12) = '',

@Operation varchar(12)	,
@OldLjdm VARCHAR(12) = '',
@NewLjdm VARCHAR(12) = '',

@UniqueID	varchar(250) = '',
@ActivityName	varchar(250) = '',
@PreNodeUniqueID	varchar(250) = '',
@NestNodeUniqueID	varchar(250) = '',
@ActivityType	varchar(250) = '',

@XML varchar(4000)	= '',

@OldWorkFlow varchar(250) = '',
@NewWorkFlow varchar(250) = ''
AS /**********
[版本号]	1.0.0.0.0               
[创建时间]	2011-05-26              
[作者]		ZM         
[版权]		YidanSoft          
[描述]		路径裁剪复制路径（无医嘱）
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
 路径总结功能         


[调用的sp]
[调用实例]
			
[修改记录]
**********/
BEGIN         

	IF @Operation = 'Lj'
	BEGIN
		DECLARE @NewCount VARCHAR(12)
		DECLARE @Ljdm VARCHAR(12)
		
		SELECT @NewCount=COUNT(*) FROM dbo.CP_ClinicalPath WHERE Name = @Ljms
		
		IF @NewCount <> 0
		BEGIN
			SELECT 0 AS Ljdm
		END
		
		IF @NewCount = 0
		BEGIN
		
			SELECT  @Ljdm = MAX(Ljdm)														--创造编码
			FROM    dbo.CP_ClinicalDiagnosis
			where substring(CP_ClinicalDiagnosis.Ljdm,3,3) = substring(@Bzdm,1,3)
			
			IF @Ljdm IS NULL 
				BEGIN
					SET @Ljdm = 'P.' + SUBSTRING(@Bzdm, 1, 3) + '.001'
				END
			ELSE 
				BEGIN
					SET @Ljdm = SUBSTRING(@Ljdm, 1, 6) + RIGHT('0000'+ 
					CONVERT(VARCHAR, ( CONVERT(NUMERIC, SUBSTRING(@Ljdm, 7, 3)) + 1 )), 3)
				END
		        
			INSERT  INTO dbo.CP_ClinicalPath
					(Ljdm,Name,Py,Ljms,Zgts,Jcfy,Vesion,Cjsj,Shsj,Shys,Yxjl,Syks,IsPathCut)
			VALUES  (@Ljdm,@Name,dbo.fun_getPY(@Name),@Ljms ,@Zgts ,@Jcfy ,@Vesion ,
					CONVERT(CHAR(19), GETDATE(),120),NULL,NULL,@Yxjl,@Syks,1)
			SELECT  @Ljdm AS Ljdm
		END
	END
	
	IF @Operation = 'LjCondition'
	BEGIN
		CREATE TABLE #tempCP_PathEnterJudgeCondition
		(
			  ID INT NOT NULL,
			  Lb INT NOT NULL ,					--类别（1：路径，2：节点）
			  Ljdm VARCHAR(12) NOT NULL ,		--路径代码（CP_PathCondition.Ljdm）
			  Jddm VARCHAR(50) ,				--节点的GUID
			  Sjfl VARCHAR(50) ,				--上级分类（CP_ExamDictionary.Jlxh）
			  Jcxm VARCHAR(400) NOT NULL ,		--检查项目（Xmlb=1：CP_ExamDictionaryDetail.Jcbm 或 Xmlb=2：CP_Diagnosis.Zdbs）
			  Xmlb VARCHAR(50) NOT NULL ,		--项目类别（1：检查项目，2：ICD-10）
			  Ksfw VARCHAR(50) ,				--开始范围
			  Jsfw VARCHAR(50) ,				--结束范围
			  Dw VARCHAR(20) ,					--单位（CP_ExamDictionaryDetail.Jldw）
			  Syrq VARCHAR(50)  ,		--适用人群（CP_ExamSyrq.Jlxh人，成人，男人，女人，婴儿等）
			  Bz VARCHAR(200) ,					--备注
		)
		
		INSERT INTO #tempCP_PathEnterJudgeCondition	--先插入临时表
		SELECT * FROM CP_PathEnterJudgeCondition
		WHERE Lb = 1								--是进入路径条件,不是节点
		AND Ljdm = @OldLjdm
		
		UPDATE #tempCP_PathEnterJudgeCondition SET Ljdm = @NewLjdm			--更新临时表中的Ljdm
		
		INSERT INTO dbo.CP_PathEnterJudgeCondition	--插回条件表
		SELECT Lb,Ljdm,Jddm,Sjfl,Jcxm,Xmlb,Ksfw,Jsfw,Dw,Syrq,Bz FROM #tempCP_PathEnterJudgeCondition
	
	END
	
	if @Operation = 'XML'
	BEGIN
		update CP_ClinicalPath set WorkFlowXML = @XML 
		where Ljdm = @NewLjdm
	END
	 
	
	if @Operation = 'Jd'
	BEGIN
		INSERT INTO dbo.CP_PathDetail
		(PahtDetailID ,Ljdm ,Ljmc,PrePahtDetailID,NextPahtDetailID,ActivityType)
		VALUES  (@UniqueID,@NewLjdm,@ActivityName,@PreNodeUniqueID,@NestNodeUniqueID,@ActivityType)
	End
	
	if @Operation = 'JdCondition'
	BEGIN
		select * into #tempDetailCondition
		from CP_PathEnterJudgeCondition
		WHERE Lb = 2								--是进入节点条件
		AND Jddm = @OldWorkFlow 

		UPDATE #tempDetailCondition SET Ljdm = @NewLjdm				--换路径代码
		UPDATE #tempDetailCondition SET Jddm = @NewWorkFlow			--换节点ID
		
		insert into CP_PathEnterJudgeCondition
		SELECT Lb,Ljdm,Jddm,Sjfl,Jcxm,Xmlb,Ksfw,Jsfw,Dw,Syrq,Bz FROM #tempDetailCondition
	END
	
	if @Operation = 'JdNur'
	BEGIN
		SELECT Ljdm ,PathDetailId , Mxxh ,Yxjl ,CREATE_USER INTO #tempDetailNur
		FROM dbo.CP_NurExecToPath
		WHERE PathDetailId = @OldWorkFlow
		
		UPDATE #tempDetailNur SET Ljdm = @NewLjdm					--换路径代码
		UPDATE #tempDetailNur SET PathDetailId = @NewWorkFlow		--换节点ID
			
		insert  into dbo.CP_NurExecToPath( Ljdm ,PathDetailId , Mxxh ,Yxjl ,Create_User )
		SELECT * FROM #tempDetailNur
	END


	if @Operation = 'JdVar'
	BEGIN
		SELECT Ljdm, ActivityId, Bydm, CREATE_USER INTO #tempDeatilVar
		FROM dbo.CP_VariationToPath
		WHERE ActivityId = @OldWorkFlow
		
		UPDATE #tempDeatilVar SET Ljdm = @NewLjdm					--换路径代码
		UPDATE #tempDeatilVar SET ActivityId = @NewWorkFlow			--换节点ID

		insert  into dbo.CP_VariationToPath(Ljdm,ActivityId,Bydm,Create_User)
		SELECT * FROM #tempDeatilVar
    END      
             
END 
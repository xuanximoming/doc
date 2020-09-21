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
[�汾��]	1.0.0.0.0               
[����ʱ��]	2011-05-26              
[����]		ZM         
[��Ȩ]		YidanSoft          
[����]		·���ü�����·������ҽ����
[����˵��]                    
[�������]               
[�������]                    
[�����������]              
 ·���ܽṦ��         


[���õ�sp]
[����ʵ��]
			
[�޸ļ�¼]
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
		
			SELECT  @Ljdm = MAX(Ljdm)														--�������
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
			  Lb INT NOT NULL ,					--���1��·����2���ڵ㣩
			  Ljdm VARCHAR(12) NOT NULL ,		--·�����루CP_PathCondition.Ljdm��
			  Jddm VARCHAR(50) ,				--�ڵ��GUID
			  Sjfl VARCHAR(50) ,				--�ϼ����ࣨCP_ExamDictionary.Jlxh��
			  Jcxm VARCHAR(400) NOT NULL ,		--�����Ŀ��Xmlb=1��CP_ExamDictionaryDetail.Jcbm �� Xmlb=2��CP_Diagnosis.Zdbs��
			  Xmlb VARCHAR(50) NOT NULL ,		--��Ŀ���1�������Ŀ��2��ICD-10��
			  Ksfw VARCHAR(50) ,				--��ʼ��Χ
			  Jsfw VARCHAR(50) ,				--������Χ
			  Dw VARCHAR(20) ,					--��λ��CP_ExamDictionaryDetail.Jldw��
			  Syrq VARCHAR(50)  ,		--������Ⱥ��CP_ExamSyrq.Jlxh�ˣ����ˣ����ˣ�Ů�ˣ�Ӥ���ȣ�
			  Bz VARCHAR(200) ,					--��ע
		)
		
		INSERT INTO #tempCP_PathEnterJudgeCondition	--�Ȳ�����ʱ��
		SELECT * FROM CP_PathEnterJudgeCondition
		WHERE Lb = 1								--�ǽ���·������,���ǽڵ�
		AND Ljdm = @OldLjdm
		
		UPDATE #tempCP_PathEnterJudgeCondition SET Ljdm = @NewLjdm			--������ʱ���е�Ljdm
		
		INSERT INTO dbo.CP_PathEnterJudgeCondition	--���������
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
		WHERE Lb = 2								--�ǽ���ڵ�����
		AND Jddm = @OldWorkFlow 

		UPDATE #tempDetailCondition SET Ljdm = @NewLjdm				--��·������
		UPDATE #tempDetailCondition SET Jddm = @NewWorkFlow			--���ڵ�ID
		
		insert into CP_PathEnterJudgeCondition
		SELECT Lb,Ljdm,Jddm,Sjfl,Jcxm,Xmlb,Ksfw,Jsfw,Dw,Syrq,Bz FROM #tempDetailCondition
	END
	
	if @Operation = 'JdNur'
	BEGIN
		SELECT Ljdm ,PathDetailId , Mxxh ,Yxjl ,CREATE_USER INTO #tempDetailNur
		FROM dbo.CP_NurExecToPath
		WHERE PathDetailId = @OldWorkFlow
		
		UPDATE #tempDetailNur SET Ljdm = @NewLjdm					--��·������
		UPDATE #tempDetailNur SET PathDetailId = @NewWorkFlow		--���ڵ�ID
			
		insert  into dbo.CP_NurExecToPath( Ljdm ,PathDetailId , Mxxh ,Yxjl ,Create_User )
		SELECT * FROM #tempDetailNur
	END


	if @Operation = 'JdVar'
	BEGIN
		SELECT Ljdm, ActivityId, Bydm, CREATE_USER INTO #tempDeatilVar
		FROM dbo.CP_VariationToPath
		WHERE ActivityId = @OldWorkFlow
		
		UPDATE #tempDeatilVar SET Ljdm = @NewLjdm					--��·������
		UPDATE #tempDeatilVar SET ActivityId = @NewWorkFlow			--���ڵ�ID

		insert  into dbo.CP_VariationToPath(Ljdm,ActivityId,Bydm,Create_User)
		SELECT * FROM #tempDeatilVar
    END      
             
END 
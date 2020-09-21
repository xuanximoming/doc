IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_PathCutEditAdviceGroup' ) 
    DROP PROCEDURE usp_CP_PathCutEditAdviceGroup
go
CREATE  PROCEDURE [dbo].usp_CP_PathCutEditAdviceGroup

@NewLjdm		VARCHAR(100) = '',
@OldWorkFlowId	VARCHAR(100) = '',
@NewWorkFlowId	varchar(100) = '',
@Operation		VARCHAR(100),

@Name			varchar(100) = '',

@Ctyzxh NUMERIC = 0 ,
@Yzbz VARCHAR(100) = '',
@Fzxh VARCHAR(100) = '',
@Fzbz VARCHAR(100) = '',
@Cdxh VARCHAR(100) = '', 
@Ggxh VARCHAR(100) = '',
@Lcxh VARCHAR(100) = '',
@Ypdm VARCHAR(100) = '',
@Ypmc VARCHAR(100) = '',
@Xmlb VARCHAR(100) = '',
@Zxdw VARCHAR(100) = '',
@Ypjl VARCHAR(100) = '',
@Jldw VARCHAR(100) = '', 
@Dwxs VARCHAR(100) = '',
@Dwlb VARCHAR(100) = '',
@Yfdm VARCHAR(100) = '',
@Pcdm VARCHAR(100) = '',
@Zxcs VARCHAR(100) = '',
@Zxzq VARCHAR(100) = '',
@Zxzqdw VARCHAR(100) = '',
@Zdm VARCHAR(100) = '',
@Zxsj VARCHAR(100) = '',
@Ztnr VARCHAR(100) = '',
@Yzlb VARCHAR(100) = ''

AS/**********
[�汾��]	1.0.0.0.0               
[����ʱ��]	2011-05-31              
[����]		ZM         
[��Ȩ]		YidanSoft          
[����]		·���ü�ҽ���ü�
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
--���׼�����
	IF @Operation = 'Get'
	BEGIN
		create table #tempAdviceGroupEnForce
		(
			Ctmxxh	NUMERIC			NULL
		)

	--���׳���
		INSERT INTO #tempAdviceGroupEnForce
		SELECT	long.Ctmxxh
		FROM dbo.CP_LongOrder long
		INNER JOIN dbo.CP_OrderToPath otp ON otp.Yzxh = long.Cqyzxh
		INNER JOIN CP_AdviceGroupDetail yzdetail ON yzdetail.Ctmxxh = long.Ctmxxh			--�ų�������ֻ������
		inner join dbo.CP_AdviceGroup yz ON yz.Ctyzxh = yzdetail.Ctyzxh
		WHERE otp.Yzbz = 2703																/*����ҽ����Ӧ*/
		AND yzdetail.Yzbz = 2703															--ҽ�������ʵҽ������ǲ����޸ģ�
		----																				--ƥ��������ʼ
		AND otp.ActivityId = @OldWorkFlowId													--ִ�нڵ㣨��ʵִ�нڵ��ǲ����޸ģ�
		and yz.PahtDetailID = @OldWorkFlowId												--�ڵ�
		AND long.Ypdm = yzdetail.Ypdm														--ִ��ҩƷ��ͬ����ʵִ��ҩƷ���ǲ����޸ģ������ȿ��޸ģ�
	--	AND long.Zxdw = yzdetail.Zxdw														--����
	--	AND long.Ypjl = yzdetail.Ypjl														--����
	--	AND long.Jldw = yzdetail.Jldw														--��λ
	--	and long.Yfdm = yzdetail.Yfdm														--�÷�
	--	and long.Pcdm = yzdetail.Pcdm														--Ƶ��

	--������ʱ
		INSERT INTO #tempAdviceGroupEnForce
		SELECT  temp.Ctmxxh
		FROM dbo.CP_TempOrder temp
		INNER JOIN dbo.CP_OrderToPath otp ON otp.Yzxh = temp.Lsyzxh
		INNER JOIN CP_AdviceGroupDetail yzdetail ON yzdetail.Ctmxxh = temp.Ctmxxh			--�ų�������ֻ������
		inner join dbo.CP_AdviceGroup yz ON yz.Ctyzxh = yzdetail.Ctyzxh
		WHERE otp.Yzbz = 2702																/*��ʱҽ����Ӧ*/
		AND yzdetail.Yzbz = 2702															--ҽ�������ʵҽ������ǲ����޸ģ�
		----																				--ƥ��������ʼ
		AND otp.ActivityId = @OldWorkFlowId													--ִ�нڵ㣨��ʵִ�нڵ��ǲ����޸ģ�
		and yz.PahtDetailID = @OldWorkFlowId												--�ڵ�
		AND temp.Ypdm = yzdetail.Ypdm														--ҩƷ��ͬ����ʵִ��ҩƷ���ǲ����޸ģ������ȿ��޸ģ�
	--	AND temp.Zxdw = yzdetail.Zxdw														--����
	--	AND temp.Ypjl = yzdetail.Ypjl														--����
	--	AND temp.Jldw = yzdetail.Jldw														--��λ
	--	and temp.Yfdm = yzdetail.Yfdm														--�÷�
	--	and temp.Pcdm = yzdetail.Pcdm														--Ƶ��

	--ҽ�����ݱ�
	create table #tempOrder
	(
		Ctmxxh	NUMERIC			NULL,
		Ljdm	VARCHAR(400)	null,
		ActivityId	VARCHAR(400)	null,
		Yzbz	VARCHAR(400)	COLLATE Chinese_PRC_CI_AS NULL,
		Fzxh	VARCHAR(400)	null,
		Fzbz	VARCHAR(400)	NULL,
		Cdxh	VARCHAR(400)	null,
		Ggxh	VARCHAR(400)	null,
		Lcxh	VARCHAR(400)	null,
		Ypdm	VARCHAR(400)	null,
		Ypmc	VARCHAR(400)	COLLATE Chinese_PRC_CI_AS NULL,
		Xmlb	VARCHAR(400)	null,
		Zxdw	VARCHAR(400)	null,
		Ypjl	VARCHAR(400)	null,
		Jldw	VARCHAR(400)	null,
		Dwxs	VARCHAR(400)	null,
		Dwlb	VARCHAR(400)	null,
		Yfdm	VARCHAR(400)	COLLATE Chinese_PRC_CI_AS NULL,
		Pcdm	VARCHAR(400)	COLLATE Chinese_PRC_CI_AS NULL,
		Zxcs	VARCHAR(400)	null,
		Zxzq	VARCHAR(400)	null,
		Zxzqdw	VARCHAR(400)	null,
		Zdm		VARCHAR(400)	null,
		Zxsj	VARCHAR(400)	null,
		Ztnr	VARCHAR(400)	null,
		Yzlb	VARCHAR(400)	NULL,
		counts	INT				NULL 
	)

	--�������
		INSERT INTO #tempOrder
		SELECT 
		yzdetail.Ctmxxh,																			--����group by����ԭ�����Լӳ���������
			yz.Ljdm,yz.PahtDetailID,yzdetail.Yzbz,yzdetail.Fzxh,yzdetail.Fzbz,yzdetail.Cdxh,yzdetail.Ggxh,yzdetail.Lcxh,yzdetail.Ypdm,
			yzdetail.Ypmc,yzdetail.Xmlb,yzdetail.Zxdw,yzdetail.Ypjl,yzdetail.Jldw,yzdetail.Dwxs,yzdetail.Dwlb,yzdetail.Yfdm,
			yzdetail.Pcdm,yzdetail.Zxcs,yzdetail.Zxzq,yzdetail.Zxzqdw,yzdetail.Zdm,yzdetail.Zxsj,yzdetail.Ztnr,yzdetail.Yzlb 
			,COUNT(en.Ctmxxh)AS counts
		FROM dbo.CP_AdviceGroupDetail yzdetail
		LEFT JOIN #tempAdviceGroupEnForce en ON en.Ctmxxh = yzdetail.Ctmxxh
		INNER JOIN dbo.CP_AdviceGroup yz ON yz.Ctyzxh = yzdetail.Ctyzxh
		WHERE yz.PahtDetailID = @OldWorkFlowId
		GROUP BY 
		yzdetail.Ctmxxh,																			--����group by����ԭ�����Լӳ���������
		yz.Ljdm,yz.PahtDetailID,yzdetail.Yzbz,yzdetail.Fzxh,yzdetail.Fzbz,yzdetail.Cdxh,yzdetail.Ggxh,yzdetail.Lcxh,yzdetail.Ypdm,
			yzdetail.Ypmc,yzdetail.Xmlb,yzdetail.Zxdw,yzdetail.Ypjl,yzdetail.Jldw,yzdetail.Dwxs,yzdetail.Dwlb,yzdetail.Yfdm,
			yzdetail.Pcdm,yzdetail.Zxcs,yzdetail.Zxzq,yzdetail.Zxzqdw,yzdetail.Zdm,yzdetail.Zxsj,yzdetail.Ztnr,yzdetail.Yzlb 

	--�������ڼ���������������ҩƷ�ȣ���������ʱ�ͳ��ڵ��������Էֿ�������
		create table #tempNewLongEnForce
	(
		Ljdm	VARCHAR(400)	null,
		ActivityId	VARCHAR(400)	null,
		Yzbz	VARCHAR(400)	null,
		Fzxh	VARCHAR(400)	null,
		Fzbz	VARCHAR(400)	null,
		Cdxh	VARCHAR(400)	null,
		Ggxh	VARCHAR(400)	null,
		Lcxh	VARCHAR(400)	null,
		YpdmId	VARCHAR(400)	null,
		Ypmc	VARCHAR(400)	null,
		Xmlb	VARCHAR(400)	null,
		Zxdw	VARCHAR(400)	null,
		Ypjl	VARCHAR(400)	null,
		Jldw	VARCHAR(400)	null,
		Dwxs	VARCHAR(400)	null,
		Dwlb	VARCHAR(400)	null,
		Yfdm	VARCHAR(400)	null,
		Pcdm	VARCHAR(400)	null,
		Zxcs	VARCHAR(400)	null,
		Zxzq	VARCHAR(400)	null,
		Zxzqdw	VARCHAR(400)	null,
		Zdm		VARCHAR(400)	null,
		Zxsj	VARCHAR(400)	null,
		Ztnr	VARCHAR(400)	null,
		Yzlb	VARCHAR(400)	NULL
	)		
		INSERT INTO #tempNewLongEnForce
		SELECT otp.Ljdm,otp.ActivityId,otp.Yzbz,long.Fzxh,long.Fzbz,long.Cdxh,long.Ggxh,long.Lcxh,long.Ypdm,long.Ypmc,long.Xmlb,long.Zxdw,
		long.Ypjl,long.Jldw,long.Dwxs,long.Dwlb,long.Yfdm,long.Pcdm,long.Zxcs,long.Zxzq,long.Zxzqdw,long.Zdm,long.Zxsj,long.Ztnr,long.Yzlb 		
		FROM dbo.CP_LongOrder long
		INNER JOIN dbo.CP_OrderToPath otp ON otp.Yzxh = long.Cqyzxh
		WHERE long.Ctmxxh NOT IN (SELECT  Ctmxxh FROM dbo.CP_AdviceGroupDetail)		--������ҽ��
		and otp.Yzbz = 2703															/*����ҽ����Ӧ*/
		AND otp.ActivityId = @OldWorkFlowId

	--������ʱ����������������ҩƷ�ȣ���������ʱ�ͳ��ڵ��������Էֿ�������
	create table #tempNewTempEnForce
	(
		Ljdm	VARCHAR(400)	null,
		ActivityId	VARCHAR(400)	null,
		Yzbz	VARCHAR(400)	null,
		Fzxh	VARCHAR(400)	null,
		Fzbz	VARCHAR(400)	null,
		Cdxh	VARCHAR(400)	null,
		Ggxh	VARCHAR(400)	null,
		Lcxh	VARCHAR(400)	null,
		YpdmId	VARCHAR(400)	null,
		Ypmc	VARCHAR(400)	null,
		Xmlb	VARCHAR(400)	null,
		Zxdw	VARCHAR(400)	null,
		Ypjl	VARCHAR(400)	null,
		Jldw	VARCHAR(400)	null,
		Dwxs	VARCHAR(400)	null,
		Dwlb	VARCHAR(400)	null,
		Yfdm	VARCHAR(400)	null,
		Pcdm	VARCHAR(400)	null,
		Zxcs	VARCHAR(400)	null,
		Zxzq	VARCHAR(400)	null,
		Zxzqdw	VARCHAR(400)	null,
		Zdm		VARCHAR(400)	null,
		Zxsj	VARCHAR(400)	null,
		Ztnr	VARCHAR(400)	null,
		Yzlb	VARCHAR(400)	NULL
	)
		INSERT INTO #tempNewTempEnForce
		SELECT otp.Ljdm,otp.ActivityId,otp.Yzbz,temp.Fzxh,temp.Fzbz,temp.Cdxh,temp.Ggxh,temp.Lcxh,temp.Ypdm,temp.Ypmc,temp.Xmlb,temp.Zxdw,
		temp.Ypjl,temp.Jldw,temp.Dwxs,temp.Dwlb,temp.Yfdm,temp.Pcdm,temp.Zxcs,temp.Zxzq,temp.Zxzqdw,temp.Zdm,temp.Zxsj,temp.Ztnr,temp.Yzlb 	
		FROM dbo.CP_TempOrder temp
		INNER JOIN dbo.CP_OrderToPath otp ON otp.Yzxh = temp.Lsyzxh
		WHERE temp.Ctmxxh NOT IN (SELECT  Ctmxxh FROM dbo.CP_AdviceGroupDetail)		--������ҽ��
		and otp.Yzbz = 2702															/*��ʱҽ����Ӧ*/
		AND otp.ActivityId = @OldWorkFlowId
		
	--������������
	create table #tempNewLongOrder
	(
		Ctmxxh	NUMERIC			NULL,
		Ljdm	VARCHAR(400)	null,
		ActivityId	VARCHAR(400)	null,
		Yzbz	VARCHAR(400)	null,
		Fzxh	VARCHAR(400)	null,
		Fzbz	VARCHAR(400)	null,
		Cdxh	VARCHAR(400)	null,
		Ggxh	VARCHAR(400)	null,
		Lcxh	VARCHAR(400)	null,
		Ypdm	VARCHAR(400)	null,
		Ypmc	VARCHAR(400)	null,
		Xmlb	VARCHAR(400)	null,
		Zxdw	VARCHAR(400)	null,
		Ypjl	VARCHAR(400)	null,
		Jldw	VARCHAR(400)	null,
		Dwxs	VARCHAR(400)	null,
		Dwlb	VARCHAR(400)	null,
		Yfdm	VARCHAR(400)	null,
		Pcdm	VARCHAR(400)	null,
		Zxcs	VARCHAR(400)	null,
		Zxzq	VARCHAR(400)	null,
		Zxzqdw	VARCHAR(400)	null,
		Zdm		VARCHAR(400)	null,
		Zxsj	VARCHAR(400)	null,
		Ztnr	VARCHAR(400)	null,
		Yzlb	VARCHAR(400)	NULL,
		counts	INT				NULL 
	)
		INSERT INTO #tempNewLongOrder
		  (Ljdm ,ActivityId , Yzbz ,Fzxh ,Fzbz ,Cdxh , Ggxh ,Lcxh ,Ypdm ,Ypmc ,Xmlb ,Zxdw ,Ypjl ,Jldw ,Dwxs ,Dwlb ,Yfdm ,Pcdm ,Zxcs ,Zxzq ,
			Zxzqdw ,Zdm ,Zxsj ,Ztnr ,Yzlb )
		select * from  
		#tempNewLongEnForce NewLongEnForce
		where not EXISTS
		(
		select 1 from #tempNewLongEnForce 
		where YpdmId = NewLongEnForce.YpdmId 
		and (Zxdw < NewLongEnForce.Zxdw		--����
		or Jldw < NewLongEnForce.Jldw		--����
		or Yfdm < NewLongEnForce.Yfdm		--��λ
		or Pcdm < NewLongEnForce.Pcdm	)	--�÷�
		)
		
		UPDATE #tempNewLongOrder SET counts =							--�ȸ��£��´��ٲ���
		ISNULL((SELECT COUNT(YpdmId) FROM #tempNewLongEnForce temp 
		WHERE temp.YpdmId = Ypdm),0)
		
		UPDATE #tempNewLongOrder SET Ctmxxh = 0							--���±�ʶ�����Ƿ���ף�
	--������ʱ����
	create table #tempNewTempOrder
	(
		Ctmxxh	NUMERIC			NULL,
		Ljdm	VARCHAR(400)	null,
		ActivityId	VARCHAR(400)	null,
		Yzbz	VARCHAR(400)	null,
		Fzxh	VARCHAR(400)	null,
		Fzbz	VARCHAR(400)	null,
		Cdxh	VARCHAR(400)	null,
		Ggxh	VARCHAR(400)	null,
		Lcxh	VARCHAR(400)	null,
		Ypdm	VARCHAR(400)	null,
		Ypmc	VARCHAR(400)	null,
		Xmlb	VARCHAR(400)	null,
		Zxdw	VARCHAR(400)	null,
		Ypjl	VARCHAR(400)	null,
		Jldw	VARCHAR(400)	null,
		Dwxs	VARCHAR(400)	null,
		Dwlb	VARCHAR(400)	null,
		Yfdm	VARCHAR(400)	null,
		Pcdm	VARCHAR(400)	null,
		Zxcs	VARCHAR(400)	null,
		Zxzq	VARCHAR(400)	null,
		Zxzqdw	VARCHAR(400)	null,
		Zdm		VARCHAR(400)	null,
		Zxsj	VARCHAR(400)	null,
		Ztnr	VARCHAR(400)	null,
		Yzlb	VARCHAR(400)	NULL,
		counts	INT				NULL 
	)
		INSERT INTO #tempNewTempOrder
		 (Ljdm ,ActivityId , Yzbz ,Fzxh ,Fzbz ,Cdxh , Ggxh ,Lcxh ,Ypdm ,Ypmc ,Xmlb ,Zxdw ,Ypjl ,Jldw ,Dwxs ,Dwlb ,Yfdm ,Pcdm ,Zxcs ,Zxzq ,
		Zxzqdw ,Zdm ,Zxsj ,Ztnr ,Yzlb )
		select *
		from  #tempNewTempEnForce NewTempEnForce
		where not EXISTS
		(
		select 1 from #tempNewTempEnForce 
		where YpdmId = NewTempEnForce.YpdmId 
		and (Zxdw < NewTempEnForce.Zxdw		--����
		or Jldw < NewTempEnForce.Jldw		--����
		or Yfdm < NewTempEnForce.Yfdm		--��λ
		or Pcdm < NewTempEnForce.Pcdm	)	--�÷�
		)
		
		UPDATE #tempNewTempOrder SET counts =							--�ȸ��£��´��ٲ���
		ISNULL((SELECT COUNT(YpdmId) FROM #tempNewTempEnForce temp 
		WHERE temp.YpdmId = Ypdm),0)
		
		UPDATE #tempNewTempOrder SET Ctmxxh = 0							--���±�ʶ�����Ƿ���ף�

	--������������

		INSERT INTO #tempOrder
	--        (Ljdm ,ActivityId , Yzbz ,Fzxh ,Fzbz ,Cdxh , Ggxh ,Lcxh ,Ypdm ,Ypmc ,Xmlb ,Zxdw ,Ypjl ,Jldw ,Dwxs ,Dwlb ,Yfdm ,Pcdm ,Zxcs ,Zxzq ,
	--        Zxzqdw ,Zdm ,Zxsj ,Ztnr ,Yzlb ,counts)
		SELECT *FROM #tempNewLongOrder orders
		
	--����������ʱ
		INSERT INTO #tempOrder
	--        (Ljdm ,ActivityId , Yzbz ,Fzxh ,Fzbz ,Cdxh , Ggxh ,Lcxh ,Ypdm ,Ypmc ,Xmlb ,Zxdw ,Ypjl ,Jldw ,Dwxs ,Dwlb ,Yfdm ,Pcdm ,Zxcs ,Zxzq ,
	--        Zxzqdw ,Zdm ,Zxsj ,Ztnr ,Yzlb ,counts)
		SELECT * FROM #tempNewTempOrder orders
		
		UPDATE #tempOrder SET Ljdm = @NewLjdm
		UPDATE #tempOrder SET ActivityId = @NewWorkFlowId
		
		
	--��ѯ��������
		SELECT *,cd.[Name] as YzbzName,isnull(cp.Ypmc,'')+' '+isnull(af.Name,'')+' '+isnull(du.Name,'') as Yznr 
		FROM #tempOrder	cp				
		left join CP_DataCategoryDetail cd on cd.Mxbh=cp.Yzbz 
		Left join CP_AdviceFrequency af on af.Pcdm=cp.Pcdm 
		left join CP_DrugUseage du on du.Yfdm=cp.Yfdm 
		ORDER BY counts DESC										--��ִ����������
		
		--	SELECT SUM(counts) FROM #tempOrder	
	END
	
	
--��ɾ����ϸ
	IF @Operation = 'DelDetail'
	BEGIN
		DELETE dbo.CP_AdviceGroupDetail
		WHERE Ctyzxh IN
		(SELECT Ctyzxh FROM dbo.CP_AdviceGroup WHERE PahtDetailID = @NewWorkFlowId )
	END
	
--ɾ���ýڵ��³���
	IF @Operation = 'Del'
	BEGIN
		DELETE dbo.CP_AdviceGroup WHERE PahtDetailID = @NewWorkFlowId
	END

--�ٲ������(�ӽڵ㴫������)
	IF @Operation = 'Insert'
	BEGIN
		if ( len(( isnull(@Name, '') )) != 0 ) 
		begin 
			if exists ( select * from  CP_AdviceGroup where PahtDetailID = @NewWorkFlowId ) 
			begin
				select  Ctyzxh from CP_AdviceGroup where   PahtDetailID = @NewWorkFlowId
			end
			else 
			begin
				insert  into dbo.CP_AdviceGroup( PahtDetailID ,Name ,Ljdm ,Py ,Wb ,Ksdm ,Bqdm ,Ysdm , Syfw ,Memo )
				values  ( @NewWorkFlowId ,@Name , @NewLjdm ,'' ,'' ,'' ,'' ,'' ,0 ,'' )
				select  @@identity 
			end
		end
		else 
		begin
			if exists ( select  Ctyzxh from    CP_AdviceGroup where   PahtDetailID = @NewWorkFlowId ) 
			begin
				select  Ctyzxh from    CP_AdviceGroup where   PahtDetailID = @NewWorkFlowId
			end
			else 
			begin
				select  0 
			end
		END
	END
--����AdviceGroupDetail�����񣬻��AdviceGroup��ID��
	IF @Operation = 'InsertDetail'
	BEGIN
		INSERT INTO dbo.CP_AdviceGroupDetail
				( Ctyzxh ,Yzbz ,Fzxh ,Fzbz ,Cdxh , Ggxh ,Lcxh ,Ypdm , Ypmc , Xmlb ,Zxdw ,Ypjl ,Jldw , Dwxs ,Dwlb ,Yfdm ,
				Pcdm ,Zxcs ,Zxzq ,Zxzqdw ,Zdm ,Zxsj ,Ztnr ,Yzlb)
		VALUES  (@Ctyzxh ,@Yzbz ,@Fzxh ,@Fzbz ,@Cdxh , @Ggxh ,@Lcxh ,@Ypdm , @Ypmc , @Xmlb ,@Zxdw ,@Ypjl ,@Jldw , @Dwxs ,@Dwlb ,@Yfdm ,
				@Pcdm ,@Zxcs ,@Zxzq ,@Zxzqdw ,@Zdm ,@Zxsj ,@Ztnr ,@Yzlb)
	END
END
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
[版本号]	1.0.0.0.0               
[创建时间]	2011-05-31              
[作者]		ZM         
[版权]		YidanSoft          
[描述]		路径裁剪医嘱裁剪
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
--成套计数表
	IF @Operation = 'Get'
	BEGIN
		create table #tempAdviceGroupEnForce
		(
			Ctmxxh	NUMERIC			NULL
		)

	--成套长期
		INSERT INTO #tempAdviceGroupEnForce
		SELECT	long.Ctmxxh
		FROM dbo.CP_LongOrder long
		INNER JOIN dbo.CP_OrderToPath otp ON otp.Yzxh = long.Cqyzxh
		INNER JOIN CP_AdviceGroupDetail yzdetail ON yzdetail.Ctmxxh = long.Ctmxxh			--排除新增，只留成套
		inner join dbo.CP_AdviceGroup yz ON yz.Ctyzxh = yzdetail.Ctyzxh
		WHERE otp.Yzbz = 2703																/*长期医嘱对应*/
		AND yzdetail.Yzbz = 2703															--医嘱类别（其实医嘱类别是不能修改）
		----																				--匹配条件开始
		AND otp.ActivityId = @OldWorkFlowId													--执行节点（其实执行节点是不能修改）
		and yz.PahtDetailID = @OldWorkFlowId												--节点
		AND long.Ypdm = yzdetail.Ypdm														--执行药品相同（其实执行药品名是不能修改，用量等可修改）
	--	AND long.Zxdw = yzdetail.Zxdw														--容器
	--	AND long.Ypjl = yzdetail.Ypjl														--数量
	--	AND long.Jldw = yzdetail.Jldw														--单位
	--	and long.Yfdm = yzdetail.Yfdm														--用法
	--	and long.Pcdm = yzdetail.Pcdm														--频次

	--成套临时
		INSERT INTO #tempAdviceGroupEnForce
		SELECT  temp.Ctmxxh
		FROM dbo.CP_TempOrder temp
		INNER JOIN dbo.CP_OrderToPath otp ON otp.Yzxh = temp.Lsyzxh
		INNER JOIN CP_AdviceGroupDetail yzdetail ON yzdetail.Ctmxxh = temp.Ctmxxh			--排除新增，只留成套
		inner join dbo.CP_AdviceGroup yz ON yz.Ctyzxh = yzdetail.Ctyzxh
		WHERE otp.Yzbz = 2702																/*临时医嘱对应*/
		AND yzdetail.Yzbz = 2702															--医嘱类别（其实医嘱类别是不能修改）
		----																				--匹配条件开始
		AND otp.ActivityId = @OldWorkFlowId													--执行节点（其实执行节点是不能修改）
		and yz.PahtDetailID = @OldWorkFlowId												--节点
		AND temp.Ypdm = yzdetail.Ypdm														--药品相同（其实执行药品名是不能修改，用量等可修改）
	--	AND temp.Zxdw = yzdetail.Zxdw														--容器
	--	AND temp.Ypjl = yzdetail.Ypjl														--数量
	--	AND temp.Jldw = yzdetail.Jldw														--单位
	--	and temp.Yfdm = yzdetail.Yfdm														--用法
	--	and temp.Pcdm = yzdetail.Pcdm														--频次

	--医嘱数据表
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

	--插入成套
		INSERT INTO #tempOrder
		SELECT 
		yzdetail.Ctmxxh,																			--由于group by分组原因，所以加成主键分组
			yz.Ljdm,yz.PahtDetailID,yzdetail.Yzbz,yzdetail.Fzxh,yzdetail.Fzbz,yzdetail.Cdxh,yzdetail.Ggxh,yzdetail.Lcxh,yzdetail.Ypdm,
			yzdetail.Ypmc,yzdetail.Xmlb,yzdetail.Zxdw,yzdetail.Ypjl,yzdetail.Jldw,yzdetail.Dwxs,yzdetail.Dwlb,yzdetail.Yfdm,
			yzdetail.Pcdm,yzdetail.Zxcs,yzdetail.Zxzq,yzdetail.Zxzqdw,yzdetail.Zdm,yzdetail.Zxsj,yzdetail.Ztnr,yzdetail.Yzlb 
			,COUNT(en.Ctmxxh)AS counts
		FROM dbo.CP_AdviceGroupDetail yzdetail
		LEFT JOIN #tempAdviceGroupEnForce en ON en.Ctmxxh = yzdetail.Ctmxxh
		INNER JOIN dbo.CP_AdviceGroup yz ON yz.Ctyzxh = yzdetail.Ctyzxh
		WHERE yz.PahtDetailID = @OldWorkFlowId
		GROUP BY 
		yzdetail.Ctmxxh,																			--由于group by分组原因，所以加成主键分组
		yz.Ljdm,yz.PahtDetailID,yzdetail.Yzbz,yzdetail.Fzxh,yzdetail.Fzbz,yzdetail.Cdxh,yzdetail.Ggxh,yzdetail.Lcxh,yzdetail.Ypdm,
			yzdetail.Ypmc,yzdetail.Xmlb,yzdetail.Zxdw,yzdetail.Ypjl,yzdetail.Jldw,yzdetail.Dwxs,yzdetail.Dwlb,yzdetail.Yfdm,
			yzdetail.Pcdm,yzdetail.Zxcs,yzdetail.Zxzq,yzdetail.Zxzqdw,yzdetail.Zdm,yzdetail.Zxsj,yzdetail.Ztnr,yzdetail.Yzlb 

	--新增长期记数表（由于新增的药品等，还存在临时和长期的区别，所以分开计数）
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
		WHERE long.Ctmxxh NOT IN (SELECT  Ctmxxh FROM dbo.CP_AdviceGroupDetail)		--新增的医嘱
		and otp.Yzbz = 2703															/*长期医嘱对应*/
		AND otp.ActivityId = @OldWorkFlowId

	--新增临时记数表（由于新增的药品等，还存在临时和长期的区别，所以分开计数）
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
		WHERE temp.Ctmxxh NOT IN (SELECT  Ctmxxh FROM dbo.CP_AdviceGroupDetail)		--新增的医嘱
		and otp.Yzbz = 2702															/*临时医嘱对应*/
		AND otp.ActivityId = @OldWorkFlowId
		
	--新增长期类别表
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
		and (Zxdw < NewLongEnForce.Zxdw		--容器
		or Jldw < NewLongEnForce.Jldw		--数量
		or Yfdm < NewLongEnForce.Yfdm		--单位
		or Pcdm < NewLongEnForce.Pcdm	)	--用法
		)
		
		UPDATE #tempNewLongOrder SET counts =							--先更新，下次再插入
		ISNULL((SELECT COUNT(YpdmId) FROM #tempNewLongEnForce temp 
		WHERE temp.YpdmId = Ypdm),0)
		
		UPDATE #tempNewLongOrder SET Ctmxxh = 0							--更新标识符（是否成套）
	--新增临时类别表
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
		and (Zxdw < NewTempEnForce.Zxdw		--容器
		or Jldw < NewTempEnForce.Jldw		--数量
		or Yfdm < NewTempEnForce.Yfdm		--单位
		or Pcdm < NewTempEnForce.Pcdm	)	--用法
		)
		
		UPDATE #tempNewTempOrder SET counts =							--先更新，下次再插入
		ISNULL((SELECT COUNT(YpdmId) FROM #tempNewTempEnForce temp 
		WHERE temp.YpdmId = Ypdm),0)
		
		UPDATE #tempNewTempOrder SET Ctmxxh = 0							--更新标识符（是否成套）

	--插入新增长期

		INSERT INTO #tempOrder
	--        (Ljdm ,ActivityId , Yzbz ,Fzxh ,Fzbz ,Cdxh , Ggxh ,Lcxh ,Ypdm ,Ypmc ,Xmlb ,Zxdw ,Ypjl ,Jldw ,Dwxs ,Dwlb ,Yfdm ,Pcdm ,Zxcs ,Zxzq ,
	--        Zxzqdw ,Zdm ,Zxsj ,Ztnr ,Yzlb ,counts)
		SELECT *FROM #tempNewLongOrder orders
		
	--插入新增临时
		INSERT INTO #tempOrder
	--        (Ljdm ,ActivityId , Yzbz ,Fzxh ,Fzbz ,Cdxh , Ggxh ,Lcxh ,Ypdm ,Ypmc ,Xmlb ,Zxdw ,Ypjl ,Jldw ,Dwxs ,Dwlb ,Yfdm ,Pcdm ,Zxcs ,Zxzq ,
	--        Zxzqdw ,Zdm ,Zxsj ,Ztnr ,Yzlb ,counts)
		SELECT * FROM #tempNewTempOrder orders
		
		UPDATE #tempOrder SET Ljdm = @NewLjdm
		UPDATE #tempOrder SET ActivityId = @NewWorkFlowId
		
		
	--查询最终数据
		SELECT *,cd.[Name] as YzbzName,isnull(cp.Ypmc,'')+' '+isnull(af.Name,'')+' '+isnull(du.Name,'') as Yznr 
		FROM #tempOrder	cp				
		left join CP_DataCategoryDetail cd on cd.Mxbh=cp.Yzbz 
		Left join CP_AdviceFrequency af on af.Pcdm=cp.Pcdm 
		left join CP_DrugUseage du on du.Yfdm=cp.Yfdm 
		ORDER BY counts DESC										--按执行总数排列
		
		--	SELECT SUM(counts) FROM #tempOrder	
	END
	
	
--先删除明细
	IF @Operation = 'DelDetail'
	BEGIN
		DELETE dbo.CP_AdviceGroupDetail
		WHERE Ctyzxh IN
		(SELECT Ctyzxh FROM dbo.CP_AdviceGroup WHERE PahtDetailID = @NewWorkFlowId )
	END
	
--删除该节点下成套
	IF @Operation = 'Del'
	BEGIN
		DELETE dbo.CP_AdviceGroup WHERE PahtDetailID = @NewWorkFlowId
	END

--再插入成套(从节点传个名字)
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
--插入AdviceGroupDetail（事务，获得AdviceGroup的ID）
	IF @Operation = 'InsertDetail'
	BEGIN
		INSERT INTO dbo.CP_AdviceGroupDetail
				( Ctyzxh ,Yzbz ,Fzxh ,Fzbz ,Cdxh , Ggxh ,Lcxh ,Ypdm , Ypmc , Xmlb ,Zxdw ,Ypjl ,Jldw , Dwxs ,Dwlb ,Yfdm ,
				Pcdm ,Zxcs ,Zxzq ,Zxzqdw ,Zdm ,Zxsj ,Ztnr ,Yzlb)
		VALUES  (@Ctyzxh ,@Yzbz ,@Fzxh ,@Fzbz ,@Cdxh , @Ggxh ,@Lcxh ,@Ypdm , @Ypmc , @Xmlb ,@Zxdw ,@Ypjl ,@Jldw , @Dwxs ,@Dwlb ,@Yfdm ,
				@Pcdm ,@Zxcs ,@Zxzq ,@Zxzqdw ,@Zdm ,@Zxsj ,@Ztnr ,@Yzlb)
	END
END
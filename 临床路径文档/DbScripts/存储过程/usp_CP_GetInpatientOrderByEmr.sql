IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_GetInpatientOrderByEmr' ) 
    DROP PROCEDURE usp_CP_GetInpatientOrderByEmr
go
CREATE  PROCEDURE [dbo].[usp_CP_GetInpatientOrderByEmr]
    @HisSyxh numeric = 1,
    @DateTimeBegin varchar(10),
    @DateTimeEnd varchar(10)
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 电子病历系统通过 传入HIS首页序号 获取已经执行过医嘱信息  
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
病人医嘱信息              
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_GetInpatientOrderByEmr  '117330','1988-01-01','2011-12-31'
[修改记录]            
**********/              
    BEGIN   

select  adg.Lsyzxh AS Yzxh ,	--临时医嘱序号
                adg.Lrysdm ,	--录入医生代码(CP_Employee.zgdm, zglb = 400,401)
                adg.Lrrq ,	--录入日期
                adg.Shczy ,	--审核操作员(代码)(因为审核/执行都是HIS的护士,所以EMR的职工表要与HIS一致)
                adg.Shrq ,	--审核日期 
                adg.Zxczy ,	--执行操作员(代码)(医嘱具体的执行护士)
                adg.Zxrq ,	--执行日期(医嘱具体的执行时间,和领药无关)
                adg.Qxysdm ,	--取消医生代码(CP_Employee.zgdm, zglb = 400,401)
                adg.Qxrq ,	--取消日期                
                convert(nvarchar(19),convert(datetime,adg.Ksrq),23) Ksrq,	--(医嘱)开始日期
                2702 Yzbz ,	--医嘱标志(CP_DataCategory.Mxbh, Lbbh = 27)
                adg.Fzxh ,	--分组序号(每组的第一条医嘱的序号)
                adg.Fzbz ,	--分组标志(CP_DataCategory.Mxbh, Lbbh = 35)
                adg.Cdxh ,	--产地序号(CP_PlaceOfDrug.Cdxh)
                adg.Ypgg ,--药品规格(CP_PlaceOfDrug.Ypgg)
                adg.Ggxh ,	--规格序号(CP_FormatOfDrug.Ggxh)
                adg.Lcxh ,	--临床序号(CP_ClinicOfDrug.Lcxh)
                adg.Ypdm ,	--药品代码(or收费小项目代码or临床项目代码,具体是哪种代码根据项目类别来判断)(CP_PlaceOfDrug.Ypdm/CP_ChargingMinItem.Sfxmdm/CP_LCChargingItem.Lcxmdm)
                adg.Ypmc ,	--药品(项目)名称(CP_PlaceOfDrug.Name/CP_ChargingMinItem.Name)
                adg.Xmlb ,	--项目类别(CP_DataCategory.Mxbh, Lbbh = 24)
                adg.Zxdw ,	--最小单位(CP_PlaceOfDrug.Zxdw)
                adg.Ypjl ,	--药品剂量
                adg.Jldw ,	--剂量单位(显示用)(CP_PlaceOfDrug.Ggdw/CP_PlaceOfDrug.Zydw)
                adg.Dwxs ,	--单位系数(规格系数或住院系数,注意规格系数要存它的分数
                adg.Dwlb ,	--单位类别(CP_DataCategory.Mxbh, Lbbh = 30)
                adg.Yfdm ,	--(药品)用法代码(CP_DrugUseage.Yfdm)
                du.Name AS YfdmName ,
                adg.Pcdm ,	--频次代码(YY_YZPCK.Pcdm)
                af.Name AS PcdmName ,
                adg.Zxcs ,	--执行次数
                adg.Zxzq ,	--执行周期
                adg.Zxzqdw ,	--执行周期单位(CP_DataCategory.Mxbh, Lbbh = 34)
                adg.Zdm ,	--周代码
                adg.Zxsj ,	--(频次的)执行时间
                adg.Zxts ,	--执行天数(为出院带药保留)
                adg.Ypzsl ,	--药品总数量(为出院带药保留,使用剂量单位)
                adg.Zxks ,	--项目的执行科室(目前只对从申请单插入的项目有效)
                adg.Ztnr ,	--嘱托内容
                adg.Yzlb ,	--医嘱类别(CP_DataCategory.Mxbh, Lbbh = 31)
                cd.[Name] AS YzbzName ,--医嘱标志名称
                yzcd.Name Yzzt ,--医嘱状态(CP_DataCategory.Mxbh, Lbbh = 32)
                adg.Tsbj ,	--特殊标记(以二进制位表示)
							--0x01(1)	自备药
							--0x02(2)	输液
							--0x04(4)	打印
							--0x08(8)	手术停长期医嘱
							--0x10(16)	需要医保审批 
                adg.Ybsptg ,	--医保审批通过(CP_DataCategory.Mxbh Lbbh = 0)
                adg.Ybspbh ,	--医保审批编号
                adg.Tzxh ,	--停止序号(CP_LongOrder.Cqyzxh)
                adg.Tzrq ,	--停止日期
                adg.Sqdxh ,	--(医技)申请单序号(等处理医技申请接口时再处理!!!)
                adg.Yznr ,	--医嘱内容(显示在界面上的医嘱内容)
                adg.Tbbz ,	--同步标志(CP_DataCategory.Mxbh Lbbh = 0)
                adg.Memo ,	--备注
                adg.Djfl ,	--单据分类(兼容护理) --wxg add, 2009-1-8
                adg.Bxbz ,	--必须标准（1.是0.否）
                otp.ActivityChileId AS PathDetailID,--路径子结点ID	

                0 Yztzyy ,--医嘱停止(或取消)原因,长嘱
                0 Ssyzxh ,--手术医嘱序号,长嘱
                CASE adg.Fzbz
                  WHEN 3501 THEN '┓'--组开始
                  WHEN 3502 THEN '┃'--组中间
                  WHEN 3599 THEN '┛' --组结束
                  ELSE ''
                END AS Flag ,--分组                
                'CP_TempOrder' FromTable , --用来做GRID变色判断
                adg.Ctmxxh , --成套明细序号
                pd.Ljmc as DetailName
        FROM    dbo.CP_TempOrder adg
				left join dbo.CP_InPatient inp on inp.Syxh = adg.Syxh
                INNER JOIN dbo.CP_OrderToPath otp ON otp.Yzbz = 2702 AND otp.Yzxh = adg.Lsyzxh
                LEFT JOIN CP_DataCategoryDetail cd ON cd.Mxbh = 2702
                left join dbo.CP_DataCategoryDetail yzcd on yzcd.Mxbh = adg.Yzzt and yzcd.Lbbh = 32
                LEFT JOIN CP_AdviceFrequency af ON af.Pcdm = adg.Pcdm
                LEFT JOIN CP_DrugUseage du ON du.Yfdm = adg.Yfdm
                left join dbo.CP_PathDetail pd on otp.ActivityChileId = pd.PahtDetailID
        WHERE   ( adg.Tzrq IS NULL OR adg.Tzrq = '' )
                AND CONVERT(varchar(10),convert(datetime,adg.Shrq),23) >= @DateTimeBegin
                AND CONVERT(varchar(10),convert(datetime,adg.Shrq),23) <= @DateTimeEnd
                and adg.Yzzt != 3203
                AND inp.Hissyxh = @HisSyxh

        UNION all
        
        SELECT  adg.Cqyzxh AS Yzxh ,	--长期医嘱序号

                adg.Lrysdm ,	--录入医生代码(CP_Employee.zgdm, zglb = 400,401)
                adg.Lrrq ,	--录入日期
                adg.Shczy ,	--审核操作员(代码)(因为审核/执行都是HIS的护士,所以EMR的职工表要与HIS一致)
                adg.Shrq ,	--审核日期 
                adg.Zxczy ,	--执行操作员(代码)(医嘱具体的执行护士)
                adg.Zxrq ,	--执行日期(医嘱具体的执行时间,和领药无关)
                adg.Qxysdm ,	--取消医生代码(CP_Employee.zgdm, zglb = 400,401)
                adg.Qxrq ,	--取消日期
                convert(nvarchar(19),convert(datetime,adg.Ksrq),23) Ksrq ,	--(医嘱)开始日期
                2703 Yzbz ,	--医嘱标志(CP_DataCategory.Mxbh, Lbbh = 27)
                adg.Fzxh ,	--分组序号(每组的第一条医嘱的序号)
                adg.Fzbz ,	--分组标志(CP_DataCategory.Mxbh, Lbbh = 35)
                adg.Cdxh ,	--产地序号(CP_PlaceOfDrug.Cdxh)
                adg.Ypgg ,--药品规格(CP_PlaceOfDrug.Ypgg)
                adg.Ggxh ,	--规格序号(CP_FormatOfDrug.Ggxh)
                adg.Lcxh ,	--临床序号(CP_ClinicOfDrug.Lcxh)
                adg.Ypdm ,	--药品代码(or收费小项目代码or临床项目代码,具体是哪种代码根据项目类别来判断)(CP_PlaceOfDrug.Ypdm/CP_ChargingMinItem.Sfxmdm/CP_LCChargingItem.Lcxmdm)
                adg.Ypmc ,	--药品(项目)名称(CP_PlaceOfDrug.Name/CP_ChargingMinItem.Name)
                adg.Xmlb ,	--项目类别(CP_DataCategory.Mxbh, Lbbh = 24)
                adg.Zxdw ,	--最小单位(CP_PlaceOfDrug.Zxdw)
                adg.Ypjl ,	--药品剂量
                adg.Jldw ,	--剂量单位(显示用)(CP_PlaceOfDrug.Ggdw/CP_PlaceOfDrug.Zydw)
                adg.Dwxs ,	--单位系数(规格系数或住院系数,注意规格系数要存它的分数
                adg.Dwlb ,	--单位类别(CP_DataCategory.Mxbh, Lbbh = 30)
                adg.Yfdm ,	--(药品)用法代码(CP_DrugUseage.Yfdm)
                du.Name AS YfdmName ,
                adg.Pcdm ,	--频次代码(YY_YZPCK.Pcdm)
                af.Name AS PcdmName ,
                adg.Zxcs ,	--执行次数
                adg.Zxzq ,	--执行周期
                adg.Zxzqdw ,	--执行周期单位(CP_DataCategory.Mxbh, Lbbh = 34)
                adg.Zdm ,	--周代码
                adg.Zxsj ,	--(频次的)执行时间
                0 Zxts ,	--执行天数(为出院带药保留),临嘱
                0 Ypzsl ,	--药品总数量(为出院带药保留,使用剂量单位)，临嘱
                adg.Zxks ,	--项目的执行科室(目前只对从申请单插入的项目有效)
                adg.Ztnr ,	--嘱托内容
                adg.Yzlb ,	--医嘱类别(CP_DataCategory.Mxbh, Lbbh = 31)
                cd.[Name] AS YzbzName ,--医嘱标志名称
                yzcd.Name Yzzt ,--医嘱状态(CP_DataCategory.Mxbh, Lbbh = 32)
                adg.Tsbj ,	--特殊标记(以二进制位表示)
							--0x01(1)	自备药
							--0x02(2)	输液
							--0x04(4)	打印
							--0x08(8)	手术停长期医嘱
							--0x10(16)	需要医保审批 
                adg.Ybsptg ,	--医保审批通过(CP_DataCategory.Mxbh Lbbh = 0)
                adg.Ybspbh ,	--医保审批编号
                0 Tzxh ,	--停止序号(CP_LongOrder.Cqyzxh)临嘱
                adg.Tzrq ,	--停止日期
                0 Sqdxh ,	--(医技)申请单序号(等处理医技申请接口时再处理!!!)，临嘱
                adg.Yznr ,	--医嘱内容(显示在界面上的医嘱内容)
                adg.Tbbz ,	--同步标志(CP_DataCategory.Mxbh Lbbh = 0)
                adg.Memo ,	--备注
                adg.Djfl ,	--单据分类(兼容护理) --wxg add, 2009-1-8
                adg.Bxbz ,	--必须标准（1.是0.否）
                otp.ActivityChileId AS PathDetailID,--路径子结点ID	

                adg.Yztzyy ,--医嘱停止(或取消)原因,
                adg.Ssyzxh ,--手术医嘱序号,
                CASE adg.Fzbz
                  WHEN 3501 THEN '┓'--组开始
                  WHEN 3502 THEN '┃'--组中间
                  WHEN 3599 THEN '┛' --组结束
                  ELSE ''
                END AS Flag ,--分组                
                'CP_LongOrder' FromTable , --用来做GRID变色判断
                adg.Ctmxxh, --成套明细序号
                pd.Ljmc as DetailName
        FROM    dbo.CP_LongOrder adg
				left join dbo.CP_InPatient inp on inp.Syxh = adg.Syxh
                INNER JOIN dbo.CP_OrderToPath otp ON otp.Yzbz = 2703 AND otp.Yzxh = adg.Cqyzxh
                LEFT JOIN CP_DataCategoryDetail cd ON cd.Mxbh = 2703
                left join dbo.CP_DataCategoryDetail yzcd on yzcd.Mxbh = adg.Yzzt and yzcd.Lbbh = 32
                LEFT JOIN CP_AdviceFrequency af ON af.Pcdm = adg.Pcdm
                LEFT JOIN CP_DrugUseage du ON du.Yfdm = adg.Yfdm
                left join dbo.CP_PathDetail pd on otp.ActivityChileId = pd.PahtDetailID
                
        WHERE  ( adg.Tzrq IS NULL OR adg.Tzrq = '' )
                AND CONVERT(varchar(10),convert(datetime,adg.Shrq),23) >= @DateTimeBegin
                AND CONVERT(varchar(10),convert(datetime,adg.Shrq),23) <= @DateTimeEnd
                AND adg.Yzzt != 3203 
                and inp.Hissyxh = @HisSyxh
        ORDER BY PathDetailID,Yzbz DESC ,
                Fzxh ,
                Fzbz
 
                
end






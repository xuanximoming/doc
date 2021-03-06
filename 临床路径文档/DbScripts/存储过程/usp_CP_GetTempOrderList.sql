IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_GetTempOrderList' ) 
    DROP PROCEDURE usp_CP_GetTempOrderList
go
CREATE PROCEDURE [dbo].[usp_CP_GetTempOrderList]
    @mxbh DECIMAL , --项目类别
    @syxh DECIMAL ,  --病人首页序号
    @ksrq VARCHAR(100) ,--查询开始日期
    @jsrq VARCHAR(100) --查询结束日期
AS 
    BEGIN
        SELECT  tporder.Lsyzxh ,--临时医嘱序号
                tporder.Syxh ,--首页序号(CP_InPatient.Syxh)
                tporder.Fzxh ,--分组序号(每组的第一条医嘱的序号)
                tporder.Fzbz ,	--分组标志(表明该条记录在同组记录中的位置, CP_DataCategory.mxxh, Lbbh = 35)
                tporder.Lrrq ,	--录入日期
                tporder.Lrysdm ,--录入医生代码
                tporder.Shczy ,	--审核操作员(代码)(CP_Employee.zgdm, zglb = 402)(因为审核/执行都是HIS的护士,所以EMR的职工表要与HIS一致)
                tporder.Shrq ,	--审核日期
                tporder.Zxczy ,	--执行操作员(代码)(医嘱具体的执行护士)(CP_Employee.zgdm, zglb = 402)
                tporder.Zxrq ,	--执行日期(医嘱具体的执行时间,和领药无关)
                tporder.Qxysdm ,	--取消医生代码(CP_Employee.zgdm, zglb = 400,401)
                tporder.Qxrq ,	--取消日期
                tporder.Tzrq ,	--停止日期
                tporder.Ksrq ,	--(医嘱)开始日期     
                tporder.Ypmc ,	--药品(项目)名称(CP_PlaceOfDrug.Name/CP_ChargingMinItem.Name)    ---项目名称
                tporder.Ypgg ,	--药品规格(CP_PlaceOfDrug.Ypgg)
                tporder.Xmlb ,	--项目类别(CP_DataCategory.Mxbh, Lbbh = 24)              --类型
                tporder.Zxdw ,	--最小单位(CP_PlaceOfDrug.Zxdw)
                tporder.Ypjl ,	--药品剂量                                          --剂量
                tporder.Jldw ,	--剂量单位(显示用)(CP_PlaceOfDrug.Ggdw/CP_PlaceOfDrug.Zydw) --单位
                tporder.Dwxs ,	--单位系数(规格系数或住院系数,注意规格系数要存它的分数
                tporder.Dwlb ,	--单位类别(CP_DataCategory.Mxbh, Lbbh = 30)
                tporder.Yfdm ,	--(药品)用法代码(CP_DrugUseage.Yfdm)                  --用法
                tporder.Pcdm ,	--频次代码(YY_YZPCK.Pcdm)                        --频次
                tporder.Zxcs ,	--执行次数
                tporder.Zxzq ,	--执行周期
                tporder.Zxzqdw ,	--执行周期单位(CP_DataCategory.Mxbh, Lbbh = 34)
                tporder.Zdm ,	--周代码
                tporder.Zxsj ,	--(频次的)执行时间
                tporder.Ztnr ,	--嘱托内容
                tporder.Yznr , --医嘱内容
                tporder.Yzzt,--医嘱状态
                empLrys.[Name] AS LrysName ,--录入医生姓名
                empshczy.[Name] AS ShczyName ,--审核操作员名称
                empzxczy.[Name] AS ZxczyName ,--执行操作员名称
                empQxys.[Name] AS QxysName ,--取消医生名称
                category.[Name] AS DwlbName ,--单位类别名称
                druguse.[Name] AS YfName ,--用法名称
                frequency.[Name] AS PcName ,--频次名称
                zxzqCategory.[Name] AS ZxzqdwName --执行周期单位名称
        FROM    CP_TempOrder tporder
                LEFT JOIN CP_Employee empshczy ON empshczy.Zgdm = tporder.Shczy
                LEFT JOIN CP_Employee empzxczy ON empzxczy.Zgdm = tporder.Zxczy
                LEFT JOIN CP_Employee empQxys ON empQxys.Zgdm = tporder.Qxysdm
                LEFT JOIN CP_Employee empLrys ON empLrys.Zgdm = tporder.Lrysdm
                LEFT JOIN CP_DataCategoryDetail category ON category.Mxbh = tporder.Dwlb
                LEFT JOIN CP_DrugUseage druguse ON druguse.Yfdm = tporder.Yfdm
                LEFT JOIN CP_AdviceFrequency frequency ON frequency.Pcdm = tporder.Pcdm
                LEFT JOIN CP_DataCategoryDetail zxzqCategory ON zxzqCategory.Mxbh = tporder.Zxzqdw
        WHERE   tporder.Syxh = @syxh
                AND tporder.Xmlb = @mxbh
                AND CONVERT(VARCHAR(10), tporder.Lrrq, 23) >= @ksrq
                AND CONVERT(VARCHAR(10), tporder.Lrrq, 23) <= @jsrq

    END
go


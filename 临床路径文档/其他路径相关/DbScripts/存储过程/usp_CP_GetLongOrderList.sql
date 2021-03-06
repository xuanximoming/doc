IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_GetLongOrderList' ) 
    DROP PROCEDURE usp_CP_GetLongOrderList
go
CREATE PROCEDURE [dbo].[usp_CP_GetLongOrderList]
    @mxbh DECIMAL , --项目类别
    @syxh DECIMAL ,  --病人首页序号
    @ksrq VARCHAR(100) ,--查询开始日期
    @jsrq VARCHAR(100) --查询结束日期
AS 
    BEGIN
        SELECT  longorder.Cqyzxh ,--长期医嘱序号
                longorder.Syxh ,--首页序号(CP_InPatient.Syxh)
                longorder.Fzxh ,--分组序号(每组的第一条医嘱的序号)
                longorder.Fzbz ,	--分组标志(表明该条记录在同组记录中的位置, CP_DataCategory.mxxh, Lbbh = 35)
                longorder.Lrrq ,	--录入日期
                longorder.Lrysdm ,--录入医生代码
                longorder.Shczy ,	--审核操作员(代码)(CP_Employee.zgdm, zglb = 402)(因为审核/执行都是HIS的护士,所以EMR的职工表要与HIS一致)
                longorder.Shrq ,	--审核日期
                longorder.Zxczy ,	--执行操作员(代码)(医嘱具体的执行护士)(CP_Employee.zgdm, zglb = 402)
                longorder.Zxrq ,	--执行日期(医嘱具体的执行时间,和领药无关)
                longorder.Qxysdm ,	--取消医生代码(CP_Employee.zgdm, zglb = 400,401)
                longorder.Qxrq ,	--取消日期
                longorder.tzysdm ,	--停止医生代码(CP_Employee.zgdm, zglb = 400,401)
                longorder.Tzrq ,	--停止日期
                longorder.tzshhs ,	--停止审核护士(代码)(CP_Employee.zgdm, zglb = 402)
                longorder.tzshrq ,	--停止审核日期
                longorder.Ksrq ,	--(医嘱)开始日期     
                longorder.Ypmc ,	--药品(项目)名称(CP_PlaceOfDrug.Name/CP_ChargingMinItem.Name)    ---项目名称
                longorder.Ypgg ,	--药品规格(CP_PlaceOfDrug.Ypgg)
                longorder.Xmlb ,	--项目类别(CP_DataCategory.Mxbh, Lbbh = 24)              --类型
                longorder.Zxdw ,	--最小单位(CP_PlaceOfDrug.Zxdw)
                longorder.Ypjl ,	--药品剂量                                          --剂量
                longorder.Jldw ,	--剂量单位(显示用)(CP_PlaceOfDrug.Ggdw/CP_PlaceOfDrug.Zydw) --单位
                longorder.Dwxs ,	--单位系数(规格系数或住院系数,注意规格系数要存它的分数
                longorder.Dwlb ,	--单位类别(CP_DataCategory.Mxbh, Lbbh = 30)
                longorder.Yfdm ,	--(药品)用法代码(CP_DrugUseage.Yfdm)                  --用法
                longorder.Pcdm ,	--频次代码(YY_YZPCK.Pcdm)                        --频次
                longorder.Zxcs ,	--执行次数
                longorder.Zxzq ,	--执行周期
                longorder.Zxzqdw ,	--执行周期单位(CP_DataCategory.Mxbh, Lbbh = 34)
                longorder.Zdm ,	--周代码
                longorder.Zxsj ,	--(频次的)执行时间
                longorder.Ztnr ,	--嘱托内容
                longorder.Yznr , --医嘱内容
                longorder.Yzzt ,--医嘱状态
                empLrys.[Name] AS LrysName ,--录入医生姓名
                empshczy.[Name] AS ShczyName ,--审核操作员名称
                empzxczy.[Name] AS ZxczyName ,--执行操作员名称
                empQxys.[Name] AS QxysName ,--取消医生名称
                empTzys.[Name] AS TzysName ,--停止医生名称
                emptzshhs.[Name] AS TzshhsName ,--停止审核护士名称
                category.[Name] AS DwlbName ,--单位类别名称
                druguse.[Name] AS YfName ,--用法名称
                frequency.[Name] AS PcName ,--频次名称
                zxzqCategory.[Name] AS ZxzqdwName --执行周期单位名称
        FROM    CP_LongOrder longorder
                LEFT JOIN CP_Employee empshczy ON empshczy.Zgdm = longorder.Shczy
                LEFT JOIN CP_Employee empzxczy ON empzxczy.Zgdm = longorder.Zxczy
                LEFT JOIN CP_Employee empQxys ON empQxys.Zgdm = longorder.Qxysdm
                LEFT JOIN CP_Employee empTzys ON empTzys.Zgdm = longorder.tzysdm
                LEFT JOIN CP_Employee emptzshhs ON emptzshhs.Zgdm = longorder.tzshhs
                LEFT JOIN CP_Employee empLrys ON empLrys.Zgdm = longorder.Lrysdm
                LEFT JOIN CP_DataCategoryDetail category ON category.Mxbh = longorder.Dwlb
                LEFT JOIN CP_DrugUseage druguse ON druguse.Yfdm = longorder.Yfdm
                LEFT JOIN CP_AdviceFrequency frequency ON frequency.Pcdm = longorder.Pcdm
                LEFT JOIN CP_DataCategoryDetail zxzqCategory ON zxzqCategory.Mxbh = longorder.Zxzqdw
        WHERE   longorder.Syxh = @syxh
                AND longorder.Xmlb = @mxbh
                AND CONVERT(VARCHAR(10), longorder.Lrrq, 23) >= @ksrq
                AND CONVERT(VARCHAR(10), longorder.Lrrq, 23) <= @jsrq


    END
go









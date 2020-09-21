IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_DrapDropAdviceSuitDetail' ) 
    DROP PROCEDURE usp_DrapDropAdviceSuitDetail
go
CREATE  PROCEDURE [usp_DrapDropAdviceSuitDetail] 
@ctyzxh NUMERIC(9, 0)  --(所属)医嘱套餐序号(CP_AdviceSuit.Ctyzxh)
AS
 /**********                    
[版本号] 1.0.0.0.0               
[创建时间]  2010-12-16             
[作者]    hjh          
[版权]    YidanSoft          
[描述] 
[功能说明]拖拽查询医嘱详细套餐                     
[输入参数]            
[输出参数]                   
[结果集、排序]              
             
             
[调用的sp]                    
[调用实例]              
 exec usp_DrapDropAdviceSuitDetail 1
[修改记录]            
    

**********/     
BEGIN   
    
    SET nocount ON 
    
	SELECT  adg.Ctmxxh ,	--成套明细序号
            adg.Ctyzxh ,	--(所属)成套医嘱序号(CP_AdviceSuit.Ctyzxh)
            adg.Yzbz ,	--医嘱标志(CP_DataCategory.Mxbh, Lbbh = 27)
            adg.Fzxh ,	--分组序号(每组的第一条医嘱的序号)
            adg.Fzbz ,	--分组标志(CP_DataCategory.Mxbh, Lbbh = 35)
            adg.Cdxh ,	--产地序号(CP_PlaceOfDrug.Cdxh)
            cpd.Ypgg ,--药品规格(CP_PlaceOfDrug.Ypgg)
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
            adg.Ztnr ,	--嘱托内容
            adg.Yzlb ,	--医嘱类别(CP_DataCategory.Mxbh, Lbbh = 31)
            cd.[Name] AS YzbzName ,--医嘱标志名称
            3200 Yzzt ,--医嘱状态(CP_DataCategory.Mxbh, Lbbh = 32)
            CASE adg.Fzbz
              WHEN 3501 THEN '┓'--组开始
              WHEN 3502 THEN '┃'--组中间
              WHEN 3599 THEN '┛' --组结束
              ELSE ''
            END AS Flag ,--分组                
            'CP_AdviceSuitDetail' FromTable ,--用来做GRID变色判断
            adg.Yznr --医嘱内容
    FROM    CP_AdviceSuitDetail adg
            LEFT JOIN CP_DataCategoryDetail cd ON cd.Mxbh = adg.Yzbz
            LEFT JOIN CP_AdviceFrequency af ON af.Pcdm = adg.Pcdm
            LEFT JOIN CP_DrugUseage du ON du.Yfdm = adg.Yfdm
            LEFT JOIN CP_PlaceOfDrug cpd ON adg.Cdxh = cpd.Cdxh
    WHERE   adg.Ctyzxh = @ctyzxh
    ORDER BY adg.Yzbz DESC ,
            adg.Fzxh ,
            adg.Fzbz
		
     
END 



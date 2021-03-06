IF EXISTS ( SELECT  1  FROM    sysobjects  WHERE   name = 'usp_CP_InpatientBelongToDoctor' ) 
    DROP PROCEDURE usp_CP_InpatientBelongToDoctor
go
CREATE  PROCEDURE usp_CP_InpatientBelongToDoctor 
@dept VARCHAR(12)='',
@hzxm varchar(12)='',
@zyhm varchar(12)='',
@ksrq varchar(19)='',
@jsrq varchar(19)='',
@Zyys varchar(19)=''--住院医生(CP_Employee.zgdm)
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 获取临床路径病患列表          
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
质量控制统计数据集              
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_InpatientList '2054','','','2006-06-07 10:41:00','2006-06-15 10:41:00',null
[修改记录]            
**********/              
    BEGIN            
        SET nocount ON    
        SELECT  inp.Syxh ,--//首页序号
                inp.Hissyxh ,--//HIS号
                inp.Zyhm ,--//住院号码
                inp.Hzxm ,--//患者姓名
                did.Name AS Brxb ,--//病人性别(CP_DictionaryDetail.Name, lbdm = '3')
                inp.Xsnl ,--//显示年龄(根据实际情况显示的年龄,如XXX年,XX月XX天,XX天)
                inp.Hkdz ,--//户口地址
                inp.Ryrq ,--//入院日期
				inp.Cyks ,--出院科室
				inp.Cybq ,--出院病区
                dcg.name AS Brzt ,--//病人状态(CP_DataCategory.Mxbh, Lbbh = 15)
                dia.Name + inp.Ryzd AS Ryzd ,--入院诊断(CP_Diagnosis.zddm)
                ISNULL(inpp.Ljzt, -1) AS Ljzt ,--//路径状态ID
                CASE WHEN inpp.Ljzt IS NULL THEN '新人未评估'
                     ELSE '已评估'
                END AS Pgqk ,--//评估情况
                CASE WHEN inpp.Ljzt IS NULL
                     THEN ( SELECT TOP 1
                                    '拟(' + cds.Bzmc + ')'
                            FROM    CP_ClinicalDiagnosis cds
                            WHERE   inp.Ryzd = cds.Bzdm
                          )
                     ELSE ( SELECT TOP 1
                                    cp.Name
                            FROM    CP_ClinicalPath cp
                            WHERE   inpp.Ljdm = cp.Ljdm
                                    AND cp.Yxjl IN ( 1, 2 )
                          )
                END AS Ljmc ,--//路径名称
                CASE WHEN inpp.Ljzt IS NULL THEN '未进入'
                     WHEN inpp.Ljzt = 1
                     THEN '执行中(' + CONVERT(VARCHAR, inpp.Ljts) + ')'
                     WHEN inpp.Ljzt = 2 THEN '退出'
                END AS LjztName ,--路径状态
                ISNULL(inpp.Id, 0) AS LqljId ,--临床路径ID
                inp.Csrq , --出生日期
                inp.Cycw , --床位代码
                inpp.Ljdm , --路径代码
                CASE WHEN inpp.Ljdm IS NULL
                     THEN ( SELECT TOP 1
                                    dica.Ljdm
                            FROM    CP_ClinicalDiagnosis dica
                            WHERE   inp.Ryzd = dica.Bzdm
                          )
                     ELSE inpp.Ljdm
                END AS RydmLjdm , --病种信息中的路径代码
                inpp.Ljts , --当前步骤天数
                inp.Zyys AS ZyysDm ,--住院医师代码
                emp.Name AS Zyys ,  --住院医师--住院医师代码姓名 
                ippf.EnFroceXml ,--实际执行路径  
                ( SELECT    WorkFlowXML
                  FROM      CP_ClinicalPath
                  WHERE     CP_ClinicalPath.Ljdm = inpp.Ljdm
                ) AS WorkFlowXML --路径工作流
        FROM    CP_InPatient inp
                INNER JOIN CP_DictionaryDetail did ON inp.Brxb = did.Mxdm
                                                      AND did.Lbdm = '3'
                INNER JOIN CP_DataCategoryDetail dcg ON inp.brzt = dcg.Mxbh
                                                        AND dcg.Lbbh = 15
                LEFT OUTER JOIN CP_Employee emp ON inp.Zyys = emp.zgdm
                                                   AND emp.Yxjl = 1
                LEFT OUTER JOIN CP_InPathPatient inpp ON inp.Syxh = inpp.Syxh
                LEFT OUTER JOIN CP_Diagnosis dia ON inp.Ryzd = dia.zddm
                LEFT OUTER JOIN CP_InPatientPathEnForce ippf ON ippf.Ljxh = inpp.Id
                                                              
        WHERE   
				(@dept='' or inp.Cyks = @dept)
				and (@zyhm='' or inp.Zyhm=@zyhm)
				and (@hzxm='' or inp.Hzxm=@hzxm)
                and (@ksrq='' or inp.Ryrq>@ksrq)
				and (@jsrq='' or inp.Ryrq<@jsrq)
				and (@Zyys='' or inp.Zyys=@Zyys)
    END 
	go
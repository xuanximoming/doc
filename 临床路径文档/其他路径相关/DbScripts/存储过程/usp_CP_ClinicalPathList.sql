IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_ClinicalPathList' ) 
    DROP PROCEDURE usp_CP_ClinicalPathList
go
CREATE  PROCEDURE [dbo].[usp_CP_ClinicalPathList]
    @Kssj VARCHAR(19) = '' ,
    @Jssj VARCHAR(19) = '' ,
    @Ksdm VARCHAR(12) = '' ,
    @Bzdm VARCHAR(12) = '' ,
    @Ljdm varchar(19) = '' ,
    @Ljmc varchar(50) = '' ,
    @Yxjl VARCHAR(12) = ''--路径状态(0、无效1有效.2停止.3审核)
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]                
[作者]              
[版权]                     
[描述] 获取所有效的临床路径 
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
             
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_ClinicalPathList 2010-01-17 00:00:00,2010-12-17 00:00:00,2032,K62.101
[修改记录]            
**********/              
    BEGIN            
        SET nocount ON
        
        SELECT  clin.Ljdm ,/*临床路径代码*/
                clin.Name ,	/*(路径)名称*/
                clin.Ljms ,   /*路径描述*/
                clin.Zgts , /*总共天数*/
                clin.Jcfy ,/*均次费用*/
                clin.Vesion ,/*版本*/
                clin.Cjsj ,	/*创建时间*/
                clin.Syks ,/*适应科室*/
                dept.Name AS DeptName ,
                clin.Shsj ,	/*审核时间*/
                clin.Shys ,/*审核医师*/
                emp.NAME AS ShysName ,
                CASE clin.Yxjl /*是否有效(0、无效1有效.2停止.3审核)*/
                  WHEN 0 THEN '无效'
                  WHEN 1 THEN '有效'
                  WHEN 2 THEN '停止'
                  WHEN 3 THEN '审核'
                END AS Yxjl ,
                clin.Yxjl AS YxjlId ,
                ( SELECT    COUNT(1)
                  FROM      CP_InPathPatient cip
                  WHERE     cip.Ljdm = clin.Ljdm
                            AND cip.Ljzt NOT IN ( 2, 3 )
                ) AS LjSySl ,/*路径使用人数数量*/
                CASE ( SELECT   COUNT(1)
                       FROM     CP_InPathPatient cip
                       WHERE    cip.Ljdm = clin.Ljdm
                                AND cip.Ljzt NOT IN ( 2, 3 )
                     )
                  WHEN 0 THEN '无人使用'
                  ELSE '病患使用中'
                END AS LjSyqk ,
                clin.WorkFlowXML
        FROM    CP_ClinicalPath clin
                JOIN CP_Department dept ON clin.Syks = dept.Ksdm
                                           AND dept.Yxjl = 1
                LEFT JOIN dbo.CP_Employee emp ON clin.Shys = emp.Zgdm
        WHERE   clin.Yxjl NOT IN ( 0 )
                AND ( @Kssj = ''
                      OR clin.Cjsj >= @Kssj
                    )
                AND ( @Jssj = ''
                      OR clin.Cjsj <= @Jssj
                    )
                AND ( @Ksdm = ''
                      OR clin.Syks = @Ksdm
                    )
                AND ( @Bzdm = ''
                      OR clin.Ljdm IN ( SELECT  Ljdm
                                        FROM    dbo.CP_ClinicalDiagnosis
                                        WHERE   Bzdm = @Bzdm )
                    )
                AND ( @Ljdm = ''
                      OR clin.Ljdm = @Ljdm
                    )
				AND (@Ljmc=''
					 OR clin.Ljdm IN(SELECT  Ljdm FROM dbo.CP_ClinicalPath WHERE Name LIKE '%'+@Ljmc+'%')
					 )
                AND ( @Yxjl = ''
                      OR clin.Yxjl = @Yxjl
                    )
    END

    go
     























IF EXISTS ( SELECT  1  FROM    sysobjects  WHERE   name = 'usp_CP_InpatientList' ) 
    DROP PROCEDURE usp_CP_InpatientList
go
CREATE  procedure [dbo].[usp_CP_InpatientList]
    @querykind int ,
    @syxh varchar(18) = '' ,
    @hzxm varchar(12) = '' ,
    @zyhm varchar(12) = '' ,
    @dept varchar(12) = '' ,
    @zyys varchar(12) = '' ,
    @ksrq varchar(19) = '' ,
    @jsrq varchar(19) = ''
as /**********                    
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
 exec usp_CP_InpatientList 3,'','','','001','2054','00','',''
 exec usp_CP_InpatientList 2,'','','','','','00','',''
 exec usp_CP_InpatientList @querykind=3 ,@cycw='001'
[修改记录]            
**********/              
    begin            
        set nocount on   
        declare @sql varchar(8000) ,
            @filter varchar(100)
        select  @sql = N'		 
                SELECT  inp.Syxh ,--//首页序号
				inp.Hissyxh ,--//HIS号
                inp.Zyhm ,--//住院号码
                inp.Hzxm ,--//患者姓名
                did.Name AS Brxb ,--//病人性别(CP_DictionaryDetail.Name, lbdm = ''3'')
                dcd.Name as Wzjb, --//危重级别(CP_DictionaryDetail.Name, lbdm = ''53'')
                inp.Xsnl ,--//显示年龄(根据实际情况显示的年龄,如XXX年,XX月XX天,XX天)
                inp.Hkdz ,--//户口地址
                inp.Ryrq ,--//入院日期
                dcg.name AS Brzt ,--//病人状态(CP_DataCategory.Mxbh, Lbbh = 15)
                dia.Name + inp.Ryzd AS Ryzd ,--入院诊断(CP_Diagnosis.zddm)
                inp.Ryzd AS RyzdCode ,--入院诊断CODE
                ISNULL(inpp.Ljzt, -1) AS Ljzt ,--//路径状态ID
                CASE WHEN inpp.Ljzt IS NULL THEN ''新人未评估''
                     ELSE ''已评估''
                END AS Pgqk ,--//评估情况
                CASE WHEN inpp.Ljzt IS NULL
                     THEN ( SELECT TOP 1
                                    ''拟('' + cds.Bzmc + '')''
                            FROM    CP_ClinicalDiagnosis cds
                            WHERE   inp.Ryzd = cds.Bzdm
                          )
                     ELSE ( SELECT TOP 1
                                    cp.Name
                            FROM    CP_ClinicalPath cp
                            WHERE   inpp.Ljdm = cp.Ljdm
                                    AND cp.Yxjl NOT IN ( 0 )
                          )
                END AS Ljmc ,--//路径名称
                CASE WHEN inpp.Ljzt IS NULL THEN ''未进入''
                     WHEN inpp.Ljzt = 1
                     THEN ''执行中('' + CONVERT(VARCHAR, inpp.Ljts) + '')''
                     WHEN inpp.Ljzt = 2
                     THEN ''退出('' + CONVERT(VARCHAR, inpp.Ljts) + '')''
                     WHEN inpp.Ljzt = 3
                     THEN ''完成('' + CONVERT(VARCHAR, inpp.Ljts) +'')''
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
                                    AND EXISTS ( SELECT 1
                                                 FROM   CP_ClinicalPath cc
                                                 WHERE  cc.Ljdm = dica.Ljdm
                                                        AND cc.Yxjl = 3 )
                          )
                     ELSE inpp.Ljdm
                END AS RydmLjdm , --病种信息中的路径代码
                inpp.Ljts , --当前步骤天数
                inp.Zyys AS ZyysDm ,--住院医师代码
                emp.Name AS Zyys ,  --住院医师--住院医师代码姓名 
                inpp.Id AS BhljId ,--病患路径ID
                ippf.EnFroceXml ,--实际执行路径  
                ( SELECT    WorkFlowXML
                  FROM      CP_ClinicalPath
                  WHERE     CP_ClinicalPath.Ljdm = inpp.Ljdm
                ) AS WorkFlowXML , --路径工作流
                inp.Cyks ,	--出院科室(CP_Department.Ksdm)
                cpd.Name AS CyksName ,
                inp.Cybq ,	--出院病区(CP_Diagnosis.Bqdm)
                cpw.Name AS CybqName ,
                inp.Cycw ,	--出院床位(CP_Bed.Cwdm)
                inp.Cqrq ,	--出区日期
                inp.Cyrq ,	--出院日期
                inp.Cyzd ,	--出院诊断(CP_Diagnosis.zddm)
                dia1.Name AS CyzdName,
                ippf.Ljxh --路径序号
        FROM    CP_InPatient inp
                INNER JOIN CP_DictionaryDetail did ON inp.Brxb = did.Mxdm
                                                      AND did.Lbdm = ''3''
				inner join dbo.CP_DictionaryDetail dcd on dcd.Lbdm = ''53'' 
												and dcd.Mxdm = inp.Wzjb
                INNER JOIN CP_DataCategoryDetail dcg ON inp.brzt = dcg.Mxbh
                                                        AND dcg.Lbbh = 15
                LEFT OUTER JOIN CP_Employee emp ON inp.Zyys = emp.zgdm
                                                   AND emp.Yxjl = 1
                LEFT OUTER JOIN CP_InPathPatient inpp ON inp.Syxh = inpp.Syxh
                LEFT OUTER JOIN CP_Diagnosis dia ON inp.Ryzd = dia.zddm
                                                    AND dia.Yxjl = 1
                LEFT OUTER JOIN CP_InPatientPathEnForce ippf ON inpp.Id = ippf.Ljxh
                LEFT OUTER JOIN dbo.CP_Department cpd ON inp.Cyks = cpd.Ksdm
                                                         AND cpd.Yxjl = 1
                LEFT OUTER JOIN dbo.CP_Ward cpw ON inp.Cybq = cpw.Bqdm
                                                   AND cpw.Yxjl = 1
                LEFT OUTER JOIN CP_Diagnosis dia1 ON inp.Cyzd = dia1.zddm
                                                     AND dia.Yxjl = 1
				'
       --if ( @querykind = 1 ) --按照病人首页序号查询
            --begin
	     
--         select @sql=@sql +' where inp.Syxh='+@syxh+''
--
--		 if(len(@hzxm)<>0)
--			  select @sql=@sql+' and   inp.Zyhm = '+@hzxm+' ' 
--         if(len(@zyhm)<>0)
--			  select @sql=@sql+ ' and  inp.Zyhm = '+@zyhm+' '


                --select  @sql = @sql + ' where (inp.syxh=''' + @syxh
                        --+ ''' or ''' + @syxh + '''='''') '
		 --if(len(@hzxm)<>0)
                --select  @sql = @sql + ' and   (inp.hzxm = ''' + @hzxm
                        --+ ''' or ''' + @hzxm + '''='''') ' 
         --if(len(@zyhm)<>0)
                --select  @sql = @sql + ' and  (inp.Zyhm = ''' + @zyhm
                        --+ ''' or ''' + @zyhm + '''='''') '
            --end
        --else 
             if ( @querykind = 2 )--按照住院医生查询
                begin
                    select  @sql = @sql + ' where inp.Zyys = ''' + @zyys
                            + ''''
					select  @sql = @sql + ' and   (inp.hzxm like '''+'%'+@hzxm+'%'''+ 'or ''' + @hzxm + '''='''') '                           
                end
            else 
                if ( @querykind = 3 ) 
                    begin
		
		-- AND ( len(1'+@ksrq+')=1) OR inp.Ryrq > '+@ksrq+') AND (len(1'+@jsrq+')=1) OR inp.Ryrq < '+@jsrq+') ORDER BY inp.Cycw'
				select  @sql = @sql + ' where (inp.syxh=''' + @syxh
                        + ''' or ''' + @syxh + '''='''') '
		 --if(len(@hzxm)<>0)
                --select  @sql = @sql + ' and   (inp.hzxm = ''' + @hzxm
                --        + ''' or ''' + @hzxm + '''='''') ' 
				select  @sql = @sql + ' and   (inp.hzxm like '''+'%'+@hzxm+'%'''+ 'or ''' + @hzxm + '''='''') '               

				select  @sql = @sql + ' and   (inp.Hissyxh = ''' + @Hissyxh
                        + ''' or ''' + @Hissyxh + '''='''') ' 
         --if(len(@zyhm)<>0)
                select  @sql = @sql + ' and  (inp.Zyhm = ''' + @zyhm
                        + ''' or ''' + @zyhm + '''='''') '

				select @sql = @sql + ' and (inp.Cycw = ''' +@cycw
						+ ''' or ''' + @cycw + '''='''') '

                select  @sql = @sql + ' and (inp.Cyks = ''' + @dept
                                + ''' or '''+ @dept +'''='''')'
                        if ( len(@ksrq) <> 0 ) 
                            select  @sql = @sql + ' and inp.Ryrq > ''' + @ksrq
                                    + ''''
                        if ( len(@jsrq) <> 0 ) 
                            select  @sql = @sql + ' and inp.Ryrq < ''' + @jsrq
                                    + ''''

                    end
        select  @sql = @sql + ' order by inp.Cycw'
        exec (@sql)
    end 


IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_QCProblem' ) 
    DROP PROCEDURE usp_CP_QCProblem
go
CREATE  PROCEDURE [dbo].[usp_CP_QCProblem] 
@QState int,            --问题状态： 0全部，1登记，2答复，3挂起、4完成
@Days NVARCHAR(20),     --最近Days天数
@QueryType int=0        --查询类型：0医务处查询，1医生查询
AS /**********                    
[版本号] 1.0.0.0.0               
[创建时间]  2010-12-4             
[作者]    hjh          
[版权]    YidanSoft          
[描述] 
[功能说明]查询医生回复问题的状态                 
[输入参数]   
[输出参数]                   
[结果集、排序]              
             
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_QCProblem 4,'3'
 exec usp_CP_QCProblem 0,'0',0
 exec usp_CP_QCProblem 2,'0',1
[修改记录]            
    

**********/     
BEGIN    
    
	DECLARE @sql nvarchar(4000)
	DECLARE @currdate VARCHAR(19)
    SET nocount ON 
    SET @currdate=CONVERT(VARCHAR(19),GETDATE(),120)
    
    SET @sql=' SELECT t1.* ,t2.Hzxm,t3.Name Ljmc,t4.Name  Ysxm,t5.Name Djryxm,t6.Name Shryxm,t7.Name Zfryxm,t8.Name Dfysxm,
                 CASE WHEN t1.Wtzt=0 THEN ''登记'' 
			     WHEN t1.Wtzt=1 THEN ''答复'' WHEN t1.Wtzt=2 THEN ''挂起'' WHEN t1.Wtzt=4  THEN ''完成'' END Qczt,
			     CASE  WHEN (t1.Zfrq<>'''' OR t1.Zfrq is NOT NULL) THEN ''已作废'' 
                 WHEN (t1.Shrq<>'''' OR t1.Shrq is NOT NULL) THEN ''已审核'' ELSE ''未审核'' END Shzt 
			     FROM CP_QCProblem  t1 LEFT JOIN CP_InPatient t2 ON t1.Syxh=t2.Syxh 
				 LEFT JOIN CP_ClinicalPath t3 ON t1.Ljdm=t3.Ljdm 
			     LEFT JOIN CP_Employee t4 ON t1.Zrys=t4.Zgdm 
				 LEFT JOIN CP_Employee t5 ON t1.Djry=t5.Zgdm
                 LEFT JOIN CP_Employee t6 ON t1.Shry=t6.Zgdm
                 LEFT JOIN CP_Employee t7 ON t1.Zfry=t7.Zgdm
                 LEFT JOIN CP_Employee t8 ON t1.Dfys=t8.Zgdm  '	  
			     
	
	--问题状态
	DECLARE @where NVARCHAR(4000)
	SET @where='' --QState=0 全部
    IF(@QueryType=0) --医务处查询
		BEGIN
			IF(@QState=1) --登记
			   BEGIN
					SET @where='  where t1.Wtzt=0 '
			   END
			ELSE IF(@QState=2) --答复
				BEGIN
					SET @where='  where t1.Wtzt=1 '
				END
			ELSE IF(@QState=3) --挂起
				BEGIN
					SET @where='  where t1.Wtzt=2 '
				END
			ELSE IF(@QState=4) --完成（审核和作废）
				BEGIN
					SET @where='  where t1.Wtzt=4 '
				END
		END
     ELSE  --医生查询
		BEGIN
			IF(@QState=1) --待回复（登记和挂起）
			   BEGIN
					SET @where='  where (t1.Wtzt=0 or t1.Wtzt=2) '
			   END
			ELSE IF(@QState=2) --已答复
				BEGIN
					SET @where='  where t1.Wtzt=1 '
				END
			ELSE IF(@QState=3) --已完成（审核和作废）
				BEGIN
					SET @where='  where t1.Wtzt=4 '
				END
		END
		
	PRINT @where	
    IF(@where<>'')
      BEGIN			    
		SET @sql=@sql+@where 
	  END

	 --最近Days天
    IF (@Days>0)
		BEGIN
			IF(@where='')
			    BEGIN
					SET @sql=@sql+' where (DATEDIFF(DAY,t1.Djrq,'''+@currdate+'''))<='+@Days +' '
				END
			ELSE
				BEGIN
					SET @sql=@sql+' and (DATEDIFF(DAY,t1.Djrq,'''+@currdate+'''))<='+@Days +' '
				END
		END
	
	
	 --以登记时间为排序
	SET @sql=@sql+' ORDER BY t1.Djrq' 
	
	print @sql
	exec sp_executesql @sql       
END 

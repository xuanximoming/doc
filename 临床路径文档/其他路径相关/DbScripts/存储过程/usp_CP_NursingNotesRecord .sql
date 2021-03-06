if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_NursingNotesRecord' ) 
    drop procedure usp_CP_NursingNotesRecord
go
create procedure [dbo].[usp_CP_NursingNotesRecord]
    @Zyhm varchar(24) , --病历号
    @Ljxh numeric ,--路径序号
    @ActivityChileId varchar(50) ,--路径执行结点ID
    @Days int         --按时间段查询，Days天，0全部
as /**********                    
[版本号] 1.0.0.0.0               
[创建时间]  2010-12-24      
[作者]    hjh          
[版权]    YidanSoft          
[描述] 
[功能说明]跟据病历号，按时间段查询护理记录：生命体征、病人入量/出量、治疗流程、其它                 
[输入参数]            
[输出参数]                   
[结果集、排序]              
             
             
[调用的sp]                    
[调用实例]                
 exec usp_CP_NursingNotesRecord '0263612',3
exec usp_CP_InpatientList 2,'','','0263612','','','',''
usp_CP_InpatientPhySign
[修改记录]            
    

**********/     
    begin  

        set nocount on
    
        declare @currdate varchar(10)
        set @currdate = convert(varchar(10), getdate(), 120)
	
    --病人信息
        --exec usp_CP_InpatientList 1, '', '', @Zyhm, '', '', '', ''
    
	
	--生命体征护理记录
        if ( @Days = 0 ) 
            begin
                select  *
                from    CP_VitalSignsRecord
                where   Zyhm = @Zyhm
                        and Ljxh = @Ljxh
                        and ActivityChildId = @ActivityChileId
                        and ( Zfrq is null
                              or Zfrq = ''
                            )
                order by Clrq ,
                        Clsj 
            end
        else 
            begin
                select  *
                from    CP_VitalSignsRecord
                where   Zyhm = @Zyhm
                        and Ljxh = @Ljxh
                        and ActivityChildId = @ActivityChileId
                        and datediff(DAY, Clrq, @currdate) <= @Days
                        and ( Zfrq is null
                              or Zfrq = ''
                            )
                order by Clrq ,
                        Clsj 
            end
    
	--病人入量护理记录
        if ( @Days = 0 ) 
            begin
                select  *
                from    CP_PatientInOutRecord
                where   Jllx = 0
                        and Zyhm = @Zyhm
                        and Ljxh = @Ljxh
                        and ActivityChildId = @ActivityChileId
                        and ( Zfrq is null
                              or Zfrq = ''
                            )
                order by Clrq ,
                        Clsj 
            end
        else 
            begin
                select  *
                from    CP_PatientInOutRecord
                where   Jllx = 0
                        and Zyhm = @Zyhm
                        and Ljxh = @Ljxh
                        and ActivityChildId = @ActivityChileId
                        and datediff(DAY, Clrq, @currdate) <= @Days
                        and ( Zfrq is null
                              or Zfrq = ''''
                            )
                order by Clrq ,
                        Clsj 
            end

	--病人出量护理记录
        if ( @Days = 0 ) 
            begin
                select  *
                from    CP_PatientInOutRecord
                where   Jllx = 1
                        and Zyhm = @Zyhm
                        and Ljxh = @Ljxh
                        and ActivityChildId = @ActivityChileId
                        and ( Zfrq is null
                              or Zfrq = ''
                            )
                order by Clrq ,
                        Clsj 
            end
        else 
            begin
                select  *
                from    CP_PatientInOutRecord
                where   Jllx = 1
                        and Zyhm = @Zyhm
                        and Ljxh = @Ljxh
                        and ActivityChildId = @ActivityChileId
                        and datediff(DAY, Clrq, @currdate) <= @Days
                        and ( Zfrq is null
                              or Zfrq = ''''
                            )
                order by Clrq ,
                        Clsj 
            end
    
	--病人治疗流程护理记录
        if ( @Days = 0 ) 
            begin
                select  *
                from    CP_TreatmentFlow
                where   Zyhm = @Zyhm
                        and Ljxh = @Ljxh
                        and ActivityChildId = @ActivityChileId
                        and ( Zfrq is null
                              or Zfrq = ''
                            )
                order by Clrq ,
                        Clsj 
            end
        else 
            begin
                select  *
                from    CP_TreatmentFlow
                where   Zyhm = @Zyhm
                        and Ljxh = @Ljxh
                        and ActivityChildId = @ActivityChileId
                        and datediff(DAY, Clrq, @currdate) <= @Days
                        and ( Zfrq is null
                              or Zfrq = ''''
                            )
                order by Clrq ,
                        Clsj 
            end
		   
	--病人护理特殊记录
        if ( @Days = 0 ) 
            begin
                select  *
                from    CP_VitalSignSpecialRecord
                where   Zyhm = @Zyhm
                        and Ljxh = @Ljxh
                        and ActivityChildId = @ActivityChileId
                        and ( Zfrq is null
                              or Zfrq = ''
                            )
                order by Clrq ,
                        Clsj 
            end
        else 
            begin
                select  *
                from    CP_VitalSignSpecialRecord
                where   Zyhm = @Zyhm
                        and Ljxh = @Ljxh
                        and ActivityChildId = @ActivityChileId
                        and datediff(DAY, Clrq, @currdate) <= @Days
                        and ( Zfrq is null
                              or Zfrq = ''''
                            )
                order by Clrq ,
                        Clsj 
            end

    end
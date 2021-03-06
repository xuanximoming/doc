if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_InsertPathPatientInfo' ) 
    drop procedure usp_CP_InsertPathPatientInfo
go
create procedure [dbo].[usp_CP_InsertPathPatientInfo]
    @syxh decimal ,  --病人首页序号
    @ljdm varchar(100) ,--路径代码
    @cwys varchar(100)--床位医生代码
as 
    begin
        declare @ljxh numeric
        insert  into CP_InPathPatient
                ( Syxh ,
                  Ljdm ,
                  Cwys ,
                  Jrsj ,
                  Ljts ,
                  Ljzt
                )
        values  ( @syxh ,
                  @ljdm ,
                  @cwys ,
                  convert(varchar(19), getdate(), 120) ,
                  1 ,
                  1
                )
        select  @ljxh = @@identity
        
        declare @workxml varchar(8000)
        select  @workxml = WorkFlowXML
        from    dbo.CP_ClinicalPath
        where   Ljdm = @ljdm      
        insert  into dbo.CP_InPatientPathEnForce
                ( Ljxh ,
                  Syxh ,
                  Ljdm ,
                  EnFroceXml ,
                  Content1 ,
                  Content2 ,
                  Content3
                )
        values  ( @ljxh ,
                  @syxh , -- Syxh - numeric
                  @ljdm , -- Ljdm - varchar(12)
                  @workxml , -- EnFroceXml - varchar(8000)
                  null , -- Content1 - varchar(10)
                  null , -- Content2 - varchar(10)
                  null  -- Content3 - varchar(10)
                )
        select  @ljxh
    end
go



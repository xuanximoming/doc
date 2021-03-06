if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_InsertAdviceGroup' ) 
    drop procedure usp_CP_InsertAdviceGroup
go
create  procedure [dbo].[usp_CP_InsertAdviceGroup]
    @PahtDetailID varchar(50) ,
    @Name varchar(50) ,
    @Ljdm varchar(12)
as 
    if ( len(( isnull(@Name, '') )) != 0 ) 
        begin 
            if exists ( select  *
                        from    CP_AdviceGroup
                        where   PahtDetailID = @PahtDetailID ) 
                begin
                    select  Ctyzxh
                    from    CP_AdviceGroup
                    where   PahtDetailID = @PahtDetailID
                end
            else 
                begin
                    insert  into dbo.CP_AdviceGroup
                            ( PahtDetailID ,
                              Name ,
                              Ljdm ,
                              Py ,
                              Wb ,
                              Ksdm ,
                              Bqdm ,
                              Ysdm ,
                              Syfw ,
                              Memo 
                            )
                    values  ( @PahtDetailID ,
                              @Name ,
                              @Ljdm ,
                              '' ,
                              '' ,
                              '' ,
                              '' ,
                              '' ,
                              0 ,
                              '' 
                            )
                    select  @@identity 
                end
        end
    else 
        begin
            if exists ( select  Ctyzxh
                        from    CP_AdviceGroup
                        where   PahtDetailID = @PahtDetailID ) 
                begin
                    select  Ctyzxh
                    from    CP_AdviceGroup
                    where   PahtDetailID = @PahtDetailID
                end
            else 
                begin
                    select  0 
                end
        end
go




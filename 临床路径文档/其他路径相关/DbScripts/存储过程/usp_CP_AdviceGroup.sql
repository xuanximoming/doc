if exists(select 1 from sysobjects where name = 'usp_CP_AdviceGroup')
	drop procedure usp_CP_AdviceGroup
GO
CREATE PROCEDURE [dbo].[usp_CP_AdviceGroup]
    @First DECIMAL ,
    @Last DECIMAL ,
    @Middle VARCHAR(2000)
AS 
    IF ( @Middle != '''''' ) 
        BEGIN 
            DECLARE @var VARCHAR(2000)
            SET @var = REPLACE(@Middle, '', '''')
            UPDATE  CP_AdviceGroupDetail
            SET     Fzbz = 3501
            WHERE   Ctmxxh = @First
            UPDATE  CP_AdviceGroupDetail
            SET     Fzbz = 3599 ,
                    Fzxh = @First
            WHERE   Ctmxxh = @Last
            UPDATE  CP_AdviceGroupDetail
            SET     Fzbz = 3502 ,
                    Fzxh = @First
            WHERE   Ctmxxh IN ( @var )
        END
    ELSE 
        BEGIN
            UPDATE  CP_AdviceGroupDetail
            SET     Fzbz = 3501
            WHERE   Ctmxxh = @First
            UPDATE  CP_AdviceGroupDetail
            SET     Fzbz = 3599 ,
                    Fzxh = @First
            WHERE   Ctmxxh = @Last
        END

go





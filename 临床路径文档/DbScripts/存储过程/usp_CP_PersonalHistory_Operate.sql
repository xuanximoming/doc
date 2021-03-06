IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_PersonalHistory_Operate' ) 
    DROP PROCEDURE usp_CP_PersonalHistory_Operate
go
CREATE PROCEDURE [dbo].[usp_CP_PersonalHistory_Operate]
    @ID NUMERIC(9, 0) ,	--唯一列	
    @Syxh NUMERIC(9, 0) ,	--病人首页序号
    @Hyzk CHAR(4) ,	--婚姻状况(CP_DictionaryDetail.Mxbh Lbbh = 4)
    @Hzsl INT ,	--孩子数量
    @Zymc VARCHAR(100) ,	--职业名称
    @Sfyj INT ,	--是否饮酒（：有0：无）
    @Yjs VARCHAR(255) ,	--饮酒史
    @Sfxy INT ,	--是否吸烟（：有0：无）
    @Xys VARCHAR(255) ,	--吸烟史
    @Csd VARCHAR(10),--出生地
    @Jld VARCHAR(10),--经历地
    @Memo VARCHAR(255) ,	--备注
    @OperateType VARCHAR(12) = ''		 --执行类别（如insert，update，select，Delete）
AS 
    BEGIN     
        DECLARE @sql NVARCHAR(4000)   

        SET nocount ON  

--执行修改操作    
        IF ( @OperateType = 'Update' ) 
            BEGIN
--                UPDATE  CP_PersonalHistory
--                SET     Hyzk = @Hyzk ,
--                        Hzsl = @Hzsl ,
--                        Zymc = @Zymc ,
--                        Sfyj = @Sfyj ,
--                        Yjs = @Yjs ,
--                        Sfxy = @Sfxy ,
--                        Xys = @Xys ,
--                        Csd=@Csd,
--                        Jld=@Jld,
--                        Memo = @Memo
--                WHERE   Syxh = @Syxh

				delete CP_PersonalHistory where Syxh = @Syxh

				insert into dbo.CP_PersonalHistory
						 ( Syxh ,
						   Hyzk ,
						   Hzsl ,
						   Zymc ,
						   Sfyj ,
						   Yjs ,
						   Sfxy ,
						   Xys ,
						   Csd ,
						   Jld ,
						   Memo
						 )
				values
						 ( @Syxh ,
						   @Hyzk ,
						   @Hzsl ,
						   @Zymc ,
						   @Sfyj ,
						   @Yjs ,
						   @Sfxy ,
						   @Xys ,
						   @Csd ,
						   @Jld ,
						   @Memo
						 )
                
                SELECT  @@ROWCOUNT
            end
            

    END


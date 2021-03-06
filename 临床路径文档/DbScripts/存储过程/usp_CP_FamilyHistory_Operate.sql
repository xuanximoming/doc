IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_FamilyHistory_Operate' ) 
    DROP PROCEDURE usp_CP_FamilyHistory_Operate
go
CREATE  PROCEDURE [dbo].[usp_CP_FamilyHistory_Operate]
    @ID NUMERIC ,		--编码
    @Syxh NUMERIC(9, 0) ,--病人首页序号
    @Jzgx SMALLINT ,		--家族关系(CP_DataCategoryDetail.Mxbh  Lbbh = 62)
    @Csrq CHAR(10) ,		--出生日期（CP_DataCategoryDetail.Lbdm = 61）
    @Bzdm VARCHAR(32) ,	--病种代码(对应CP_Diagnosis.Zddm)
    @Sfjz INT ,	        --是否健在
    @Swyy VARCHAR(100) ,	--死亡原因
    @Memo VARCHAR(255) ,	--备注
    @OperateType VARCHAR(12) = ''		 --执行类别（如insert，update，select，Delete）
AS 
    BEGIN     
        DECLARE @sql NVARCHAR(4000)   
        DECLARE @table_name NVARCHAR 
        SET @table_name = 'tempQuitPath'    --问题1
        SET nocount ON  
----执行新增操作    
        IF ( @OperateType = 'Insert' ) 
            BEGIN
    
                INSERT  INTO dbo.CP_FamilyHistory
                        ( Syxh ,
                          Jzgx ,
                          Csrq ,
                          Bzdm ,
                          Sfjz ,
                          Swyy ,
                          Memo 
                              
                        )
                VALUES  ( @Syxh , -- Syxh - numeric
                          @Jzgx , -- Jzgx - smallint
                          @Csrq , -- Csrq - smallint
                          @Bzdm , -- Bzdm - varchar(4)
                          @Sfjz , -- Sfjz - int
                          @Swyy , -- Swyy - varchar(100)
                          @Memo  -- Memo - varchar(255)
			            
                        )
                SELECT  @@ROWCOUNT	   
            END
               
--执行删除操作    
        IF ( @OperateType = 'Delete' ) 
            BEGIN
                DELETE  dbo.CP_FamilyHistory
                WHERE   ID = @ID
		
                SELECT  @@ROWCOUNT	 
            END
               
----执行查询操作    
--            if ( @OperateType = 'Select' ) 
--               begin
--                     select ID,Jzgx,Csrq,Xsnl=DATEDIFF(yy,Csrq,getdate())+1,Bzdm,Sfjz,Swyy,Memo 
--                     from CP_FamilyHistory 
--                     where Syxh=@Syxh
--               end

--执行修改操作    
        IF ( @OperateType = 'Update' ) 
            BEGIN
                UPDATE  CP_FamilyHistory
                SET     Jzgx = @Jzgx ,
                        Csrq = @Csrq ,
                        Bzdm = @Bzdm ,
                        Sfjz = @Sfjz ,
                        Swyy = @Swyy ,
                        Memo = @Memo
                WHERE   ID = @ID
                SELECT  @@ROWCOUNT
            END
    END

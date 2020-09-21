IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_AllergyHistory_Operate' ) 
    DROP PROCEDURE usp_CP_AllergyHistory_Operate
go
CREATE  procedure [dbo].[usp_CP_AllergyHistory_Operate]
	  @ID	numeric ,		--编码
      @Syxh numeric(9 , 0) ,--病人首页序号
      @Gmlx smallint ,		--过敏类型(CP_DataCategoryDetail.Lbdm = 60)
      @Gmcd smallint ,		--过敏程度（CP_DataCategoryDetail.Lbdm = 61）
      @Dlys varchar(100) ,	--代理医生
      @Gmbw varchar(100) ,	--过敏部位
      @Fylx varchar(255) ,	--反应类型
      @Memo varchar(255) ,	--备注
      @OperateType varchar(12) = ''		 --执行类别（如insert，update，select，Delete）
as /**********                    
[版本号] 1.0.0.0.0               
[创建时间]  2010-12-28              
[作者]    yxy          
[版权]    YidanSoft          
[描述] 退出路径的统计  
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
维护表CP_AllergyHistory             
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_AllergyHistory_Operate   0,1,0,0,'','','','','Select'           
[修改记录]            
 
**********/     
      begin     
            declare @sql nvarchar(4000)   
            declare @table_name nvarchar 
            set @table_name = 'tempQuitPath'    
            set nocount on  
----执行新增操作    
            if ( @OperateType = 'Insert' ) 
               begin
    
                     insert   into CP_AllergyHistory
                              ( Syxh ,
                                Gmlx ,
                                Gmcd ,
                                Dlys ,
                                Gmbw ,
                                Fylx ,
                                Memo 
                              )
                     values
                              ( @Syxh , -- Syxh - numeric
                                @Gmlx , -- Gmlx - smallint
                                @Gmcd , -- Gmcd - smallint
                                @Dlys , -- Dlys - varchar(100)
                                @Gmbw , -- Gmbw - varchar(100)
                                @Fylx , -- Fylx - varchar(255)
                                @Memo  -- Memo - varchar(255)
			            )
                     select
                        @@ROWCOUNT	   
               end
--执行修改操作    
            if ( @OperateType = 'Update' ) 
               begin
    
                     update
                        CP_AllergyHistory
                     set
                        Syxh = @Syxh ,
                        Gmlx = @Gmlx ,
                        Gmcd = @Gmcd ,
                        Dlys = @Dlys ,
                        Gmbw = @Gmbw ,
                        Fylx = @Fylx ,
                        Memo = @Memo
                     where
                        ID = @ID
 
                     select
                        @@ROWCOUNT	   
               end
--执行删除操作    
            if ( @OperateType = 'Delete' ) 
               begin
                     delete
                        CP_AllergyHistory
                     where
                        ID = @ID
		
                     select
                        @@ROWCOUNT	 
               end
    
--执行查询操作    
            if ( @OperateType = 'Select' ) 
               begin
                     select a.*,d1.Name Gmlx_Name,d2.Name Gmcd_Name
						 from CP_AllergyHistory a
						 left join CP_DataCategoryDetail d1 on a.Gmlx = d1.Mxbh
						 left join CP_DataCategoryDetail d2 on a.Gmcd = d2.Mxbh
						 where
							a.Syxh = @Syxh
               end


      end 





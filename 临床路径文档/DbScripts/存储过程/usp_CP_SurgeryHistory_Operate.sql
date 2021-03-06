IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_SurgeryHistory_Operate' ) 
    DROP PROCEDURE usp_CP_SurgeryHistory_Operate
go
CREATE procedure [dbo].[usp_CP_SurgeryHistory_Operate]
      @ID numeric ,		--编码
      @Syxh numeric(9 , 0) ,--病人首页序号
      @Ssdm varchar(12) ,	--手术代码(CP_Surgery维护)
      @Bzdm varchar(32) ,	--疾病（对应CP_DiseaseCFG.Bzdm）
      @Sspl varchar(200) ,	--评论
      @Ssys varchar(100) ,	--手术医生
      @Memo varchar(255) ,	--备注
      @OperateType varchar(12) = ''		 --执行类别（如insert，update，select，Delete）
as /**********                    
[版本号] 1.0.0.0.0               
[创建时间]  2010-12-28              
[作者]    yxy          
[版权]    YidanSoft          
[描述] 病人手术史操作  
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
维护表CP_SurgeryHistory             
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_SurgeryHistory_Operate   0,1,'','','','','','Select'           
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
    
                     insert   into CP_SurgeryHistory
                              ( Syxh ,
                                Ssdm ,
                                Bzdm ,
                                Sspl ,
                                Ssys ,
                                Memo 
                              )
                     values
                              ( @Syxh ,
                                @Ssdm ,
                                @Bzdm ,
                                @Sspl ,
                                @Ssys ,
                                @Memo
					           
                              )
 
                     select
                        @@ROWCOUNT	   
               end
--执行修改操作    
            if ( @OperateType = 'Update' ) 
               begin
    
                     update
                        CP_SurgeryHistory
                     set
                        Syxh = @Syxh ,
                        Ssdm = @Ssdm ,
                        Bzdm = @Bzdm ,
                        Sspl = @Sspl ,
                        Ssys = @Ssys ,
                        Memo = Memo
                     where
                        ID = @ID

 
                     select
                        @@ROWCOUNT	   
               end
--执行删除操作    
            if ( @OperateType = 'Delete' ) 
               begin
                     delete
                        CP_SurgeryHistory
                     where
                        ID = @ID
		
                     select
                        @@ROWCOUNT	 
               end
    
--执行查询操作    
            if ( @OperateType = 'Select' ) 
               begin
                     select
                        a.* ,
                        CP_Surgery.Name SsName ,
                        CP_Diagnosis.Name BzName
                     from
                        CP_SurgeryHistory a
                        left join CP_Surgery
                           on a.Ssdm = CP_Surgery.Ssdm
                        left join CP_Diagnosis
                           on a.Bzdm = dbo.CP_Diagnosis.Zdbs
                     where
                        a.Syxh = @Syxh
               end


      end 








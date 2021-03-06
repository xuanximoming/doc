IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_IllnessHistory_Operate' ) 
    DROP PROCEDURE usp_CP_IllnessHistory_Operate
go
CREATE   procedure [dbo].[usp_CP_IllnessHistory_Operate]
       @ID numeric ,			--编码
       @Syxh numeric(9 , 0) ,	--病人首页序号
       @Bzdm varchar(32) ,		--病种代码（对应CP_DiseaseCFG.Bzdm）
       @Jbpl varchar(200) ,		--疾病评论
       @Bfsj datetime ,			--病发时间
       @Sfzy int ,				--是否治愈（1：是0：否）
       @Memo varchar(255) ,		--备注
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
 exec usp_CP_IllnessHistory_Operate   0,1,'','','2010-01-01',0,'','Select'           
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
                      insert  into dbo.CP_IllnessHistory
                              ( Syxh ,
                                Bzdm ,
                                Jbpl ,
                                Bfsj ,
                                Sfzy ,
                                Memo
				         
                              )
                      values
                              ( @Syxh ,
                                @Bzdm ,
                                @Jbpl ,
                                @Bfsj ,
                                @Sfzy ,
                                @Memo
				         
                              )

                      select
                        @@ROWCOUNT	   
                end
--执行修改操作    
             if ( @OperateType = 'Update' ) 
                begin
    
                      update
                        CP_IllnessHistory
                      set
                        Syxh = @Syxh ,
                        Bzdm = @Bzdm ,
                        Jbpl = @Jbpl ,
                        Bfsj = @Bfsj ,
                        Sfzy = @Sfzy ,
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
                        CP_IllnessHistory
                      where
                        ID = @ID
		
                      select
                        @@ROWCOUNT	 
                end
    
--执行查询操作    
             if ( @OperateType = 'Select' ) 
                begin
						select
						   a.ID ,
						   a.Bzdm ,
						   a.Jbpl ,
						   ( case when a.Sfzy = 1 then '是'
								  else '否'
							 end ) Sfzy ,
						   a.Memo ,
						   a.Syxh ,
						   convert(char(10) , a.Bfsj , 23) Bfsj ,
						   CP_Diagnosis.Name BzName
						from
						   dbo.CP_IllnessHistory a
						   left join dbo.CP_Diagnosis
							  on a.Bzdm = dbo.CP_Diagnosis.Zdbs
						  where
							a.Syxh = @Syxh
                end


       end 







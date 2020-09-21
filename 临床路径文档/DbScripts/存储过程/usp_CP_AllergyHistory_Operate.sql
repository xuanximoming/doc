IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_AllergyHistory_Operate' ) 
    DROP PROCEDURE usp_CP_AllergyHistory_Operate
go
CREATE  procedure [dbo].[usp_CP_AllergyHistory_Operate]
	  @ID	numeric ,		--����
      @Syxh numeric(9 , 0) ,--������ҳ���
      @Gmlx smallint ,		--��������(CP_DataCategoryDetail.Lbdm = 60)
      @Gmcd smallint ,		--�����̶ȣ�CP_DataCategoryDetail.Lbdm = 61��
      @Dlys varchar(100) ,	--����ҽ��
      @Gmbw varchar(100) ,	--������λ
      @Fylx varchar(255) ,	--��Ӧ����
      @Memo varchar(255) ,	--��ע
      @OperateType varchar(12) = ''		 --ִ�������insert��update��select��Delete��
as /**********                    
[�汾��] 1.0.0.0.0               
[����ʱ��]  2010-12-28              
[����]    yxy          
[��Ȩ]    YidanSoft          
[����] �˳�·����ͳ��  
[����˵��]                    
[�������]               
[�������]                    
[�����������]              
ά����CP_AllergyHistory             
             
[���õ�sp]                    
[����ʵ��]              
 exec usp_CP_AllergyHistory_Operate   0,1,0,0,'','','','','Select'           
[�޸ļ�¼]            
 
**********/     
      begin     
            declare @sql nvarchar(4000)   
            declare @table_name nvarchar 
            set @table_name = 'tempQuitPath'    
            set nocount on  
----ִ����������    
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
--ִ���޸Ĳ���    
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
--ִ��ɾ������    
            if ( @OperateType = 'Delete' ) 
               begin
                     delete
                        CP_AllergyHistory
                     where
                        ID = @ID
		
                     select
                        @@ROWCOUNT	 
               end
    
--ִ�в�ѯ����    
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





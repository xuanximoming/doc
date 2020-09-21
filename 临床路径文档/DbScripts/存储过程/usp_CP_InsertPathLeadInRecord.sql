



if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_InsertPathLeadInRecord' ) 
    drop procedure usp_CP_InsertPathLeadInRecord
go
create procedure [dbo].[usp_CP_InsertPathLeadInRecord]
    @Ljxh numeric ,
    @Syxh numeric ,
    @Ljdm varchar(12) ,
    @Zgm varchar(6)
as /**********                    
[�汾��] 1.0.0.0.0               
[����ʱ��]                
[����]              
[��Ȩ]                     
[����] ·��ִ��ʱ����ִ�е�����·���Ķ�����������Ӧ�ļ�¼
[����˵��]                    
[�������]               
[�������]                    
[�����������]              
��������ͳ�����ݼ�              
             
[���õ�sp]                    
[����ʵ��]              
[�޸ļ�¼]            
**********/              
    begin            
        set nocount on
        
        declare @count numeric
        
        select  @count = count(*)
        from    CP_PathLeadInRecord
        where   Ljxh = @Ljxh
                and Syxh = @Syxh
                and Ljdm = @Ljdm
                and Yxjl = 1
        
        if @count = 0 
            begin
        
                insert  into dbo.CP_PathLeadInRecord
                        ( Ljxh ,
                          Syxh ,
                          Ljdm ,
                          Yxjl ,
                          Create_Time ,
                          Create_User
                        )
                values  ( @Ljxh , -- Ljxh - numeric
                          @Syxh , -- Syxh - numeric
                          @Ljdm , -- Ljdm - varchar(12)
                          1 , -- Yxjl - smallint
                          convert(varchar(19), getdate(), 120) , -- Create_Time - varchar(19)
                          @Zgm  -- Create_User - varchar(6)
                        )
            end
   
       
    end  
    
    go







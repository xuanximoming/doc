if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_GetNurseCode' ) 
    drop procedure usp_CP_GetNurseCode
go
create procedure usp_CP_GetNurseCode

as
 /**********                    
[�汾��] 1.0.0.0.0               
[����ʱ��]  2010-12-22           
[����]    hjh          
[��Ȩ]    YidanSoft          
[����] 
[����˵��]�ӱ�������ȡ�����¼������                   
[�������]            
[�������]                   
[�����������]              
             
             
[���õ�sp]                    
[����ʵ��]              
 exec usp_CP_GetNurseCode
[�޸ļ�¼]            
    

**********/     
begin  
    
    set nocount on 
    
    --���²�����ʽ
	select * from CP_DataCategoryDetail where Lbbh=48 order by Mxbh 
    
    --���²���������ʩ
	select * from CP_DataCategoryDetail where Lbbh=49 order by Mxbh
	
	--������������
	select * from CP_DataCategoryDetail where Lbbh=50 order by Mxbh
	
	--����С����״
	select * from CP_DataCategoryDetail where Lbbh=51 order by Mxbh
	
	--������С���ʩ
	select * from CP_DataCategoryDetail where Lbbh=52 order by Mxbh
	
	--���˴����״
	select * from CP_DataCategoryDetail where Lbbh=53 order by Mxbh
		
	--�����Ŵ���ʩ
	select * from CP_DataCategoryDetail where Lbbh=54 order by Mxbh
	
	--����̵��״
	select * from CP_DataCategoryDetail where Lbbh=55 order by Mxbh
	
	--������������
	select * from CP_DataCategoryDetail where Lbbh=56 order by Mxbh
	
	--����Ѫ��
	select * from CP_DataCategoryDetail where Lbbh=57 order by Mxbh
	
	--����Ѫ��HR
	select * from CP_DataCategoryDetail where Lbbh=58 order by Mxbh
	
	--����״̬
	select * from CP_DataCategoryDetail where Lbbh=59 order by Mxbh

end 



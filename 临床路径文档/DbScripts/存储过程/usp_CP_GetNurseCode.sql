if exists ( select  1
            from    sysobjects
            where   name = 'usp_CP_GetNurseCode' ) 
    drop procedure usp_CP_GetNurseCode
go
create procedure usp_CP_GetNurseCode

as
 /**********                    
[版本号] 1.0.0.0.0               
[创建时间]  2010-12-22           
[作者]    hjh          
[版权]    YidanSoft          
[描述] 
[功能说明]从编码表里获取护理记录单编码                   
[输入参数]            
[输出参数]                   
[结果集、排序]              
             
             
[调用的sp]                    
[调用实例]              
 exec usp_CP_GetNurseCode
[修改记录]            
    

**********/     
begin  
    
    set nocount on 
    
    --体温测量方式
	select * from CP_DataCategoryDetail where Lbbh=48 order by Mxbh 
    
    --体温测量辅助措施
	select * from CP_DataCategoryDetail where Lbbh=49 order by Mxbh
	
	--病人其它入量
	select * from CP_DataCategoryDetail where Lbbh=50 order by Mxbh
	
	--病人小便性状
	select * from CP_DataCategoryDetail where Lbbh=51 order by Mxbh
	
	--病人排小便措施
	select * from CP_DataCategoryDetail where Lbbh=52 order by Mxbh
	
	--病人大便性状
	select * from CP_DataCategoryDetail where Lbbh=53 order by Mxbh
		
	--病人排大便措施
	select * from CP_DataCategoryDetail where Lbbh=54 order by Mxbh
	
	--病人痰性状
	select * from CP_DataCategoryDetail where Lbbh=55 order by Mxbh
	
	--病人其它出量
	select * from CP_DataCategoryDetail where Lbbh=56 order by Mxbh
	
	--病人血型
	select * from CP_DataCategoryDetail where Lbbh=57 order by Mxbh
	
	--病人血性HR
	select * from CP_DataCategoryDetail where Lbbh=58 order by Mxbh
	
	--病人状态
	select * from CP_DataCategoryDetail where Lbbh=59 order by Mxbh

end 



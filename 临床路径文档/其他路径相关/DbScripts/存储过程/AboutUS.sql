IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_AboutUS' ) 
    DROP PROCEDURE usp_AboutUS
go
CREATE  PROCEDURE [dbo].usp_AboutUS

AS /**********
[版本号]	1.0.0.0.0               
[创建时间]	2011-06-23        
[作者]		ZM         
[版权]		YidanSoft          
[描述]		关于我们
[功能说明]                    
[输入参数]               
[输出参数]                    
[结果集、排序]              
 路径总结功能         


[调用的sp]
[调用实例]
			
[修改记录]

***/


SELECT '   V4.0' AS Edit ,'   一丹临床路径管理系统' AS Names ,'   南京一丹软件有限公司' AS Company, '版权 @ 2011 南京一丹 Inc 保留所有权利' AS Times ,
'  本软件版权归南京一丹软件公司所有,受中国法律保护,未经授权擅自复制或散布本软件的部分或全部，将承受严厉的民事处罚和刑事诉讼，对已知的违法者将给予法律范围内的全部制裁。' AS Warning
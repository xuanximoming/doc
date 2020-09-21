IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_CP_Employee' ) 
    DROP PROCEDURE usp_CP_Employee
go
create  proc usp_CP_Employee
    @Yxjl varchar(6) ='' ,
    @Zgdm varchar(6) = '' ,
    @Py	  varchar(12) = '' ,
    @Zgxb varchar(12) = '' ,
	@Ksdm varchar(12) = '' ,
    @Bqdm varchar(12) = '' ,
    @Ysjb varchar(12) = '' 
as 
/**********                    
[调用的sp]                    
[调用实例]              
 exec usp_CP_Employee '1','','','','','',''
[修改记录]            
**********/              
    begin            
        set nocount on   
        declare @sql varchar(8000) ,
            @filter varchar(100)
        select  @sql = N'		 
                SELECT  * from CP_Employee as Emp where 1=1 
				'
				
				select  @sql = @sql + ' and   (Emp.Yxjl = ''' +  @Yxjl
                        + ''' or ''' + @Yxjl + '''='''') ' 
	 
                select  @sql = @sql + ' and   (Emp.Zgdm = ''' + @Zgdm
                        + ''' or ''' + @Zgdm + '''='''') ' 
                select  @sql = @sql + ' and   (Emp.Py = ''' + @Py
                        + ''' or ''' + @Py + '''='''') ' 
       
                select  @sql = @sql + ' and  (Emp.Zgxb = ''' + @Zgxb
                        + ''' or ''' + @Zgxb + '''='''') '

				select @sql = @sql + ' and (Emp.Ksdm = ''' +@Ksdm
						+ ''' or ''' + @Ksdm + '''='''') '
				select @sql = @sql + ' and (Emp.Bqdm = ''' +@Bqdm
						+ ''' or ''' + @Bqdm + '''='''') '
				select @sql = @sql + ' and (Emp.Ysjb = ''' +@Ysjb
						+ ''' or ''' + @Ysjb + '''='''') '

           

     print @sql  
                 

        exec (@sql)

    end 
go


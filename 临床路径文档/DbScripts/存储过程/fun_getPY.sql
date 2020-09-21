CREATE    function [dbo].[fun_getPY]
 (
    @str nvarchar(4000)
 )
returns nvarchar(4000)
as
begin
  declare @word nchar(1),@PY nvarchar(4000)

  set @PY=''

  while len(@str)>0
  begin
    set @word=left(@str,1)

    --����Ǻ����ַ�������ԭ�ַ�
    set @PY=@PY+(case when unicode(@word) between 19968 and 19968+20901
               then ( 
                            select top 1 PY 
                            from 
                            ( 
                             select 'A' as PY,N'�' as word
                             union all select 'B',N'��'
                             union all select 'C',N'�e'
                     union all select 'D',N'�z'
                     union all select 'E',N'��'
                     union all select 'F',N'�v'
                     union all select 'G',N'�B'
                     union all select 'H',N'��'
                     union all select 'J',N'�h'
                     union all select 'K',N'�i'
                     union all select 'L',N'�w'
                     union all select 'M',N'��'
                     union all select 'N',N'��'
                     union all select 'O',N'�a'
                     union all select 'P',N'��'
                     union all select 'Q',N'��'
                     union all select 'R',N'�U'
                     union all select 'S',N'�R'
                     union all select 'T',N'�X'
                     union all select 'W',N'�F'
                     union all select 'X',N'�R'
                     union all select 'Y',N'�'
                     union all select 'Z',N'��'
                      ) T 

where word>=@word collate Chinese_PRC_CS_AS_KS_WS 
                   order by PY ASC
                          ) 
                      else @word 
                 end)
    set @str=right(@str,len(@str)-1)
  end

  return @PY

end
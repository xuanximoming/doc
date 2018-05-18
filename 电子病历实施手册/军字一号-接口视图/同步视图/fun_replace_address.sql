create or replace function fun_replace_address(as_area_code in varchar2) return varchar2 is
  Result varchar2(100);
begin
if as_area_code  is  null then
   --v_code :='132429';
   Result :='河北省涞水县';
   else
   --v_code :=as_area_code;
   if isNumber(as_area_code)  = 1 then
      select AREA_NAME
      into  Result
      from AREA_DICT
      where AREA_CODE =as_area_code;
    else
      Result :=as_area_code;
    end if ;

end if ;



/* select decode(Result,null,as_area_code, Result,'河北省涞水县' ) into Result
  from dual; */

  return(Result);
end fun_replace_address;

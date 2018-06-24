CREATE OR REPLACE Function fun_get_age(ad_birthdate Date,ADMISSION_DATE_TIME date,falg number) RETURN  varchar2 Is
ls_age  varchar2(20);
  ldt_sysdate Date;
  li_years number;
  li_months number;
  li_days number;
  li_hours number;
  li_min number;
  li_age_month number;
  li_age_day number;
Begin
  SELECT sysdate, months_between(ADMISSION_DATE_TIME, ad_birthdate),ADMISSION_DATE_TIME - ad_birthdate
  Into ldt_sysdate, li_age_month ,li_age_day
  From dual;
    /*
    大于1岁 显示几岁
    小于1岁，显示几月
    小于一个月，显示几天
    小于一天，显示几小时
    */
   if falg = 1 then
    if li_age_month >= 12 then --计算年
      ls_age := to_char(trunc(li_age_month/12))||'岁';
      
    elsif li_age_month < 12 and li_age_month >= 1 then --计算月
      li_months := trunc(li_age_month);
      li_days := trunc(ADMISSION_DATE_TIME-add_months(ad_birthdate,li_months));
      ls_age := to_char(li_months) ||'月'||to_char(li_days)||'天' ;
      
    elsif li_age_month < 1  and li_age_day >= 1 then --计算天
      li_days := trunc(li_age_day);
      ls_age := to_char(li_days) ||'天';
      
    elsif li_age_day < 1 and ceil(li_age_day * 24) >= 1 then --计算小时
      li_hours := ceil(li_age_day * 24);
      ls_age := to_char(li_hours) ||'小时';

    elsif ceil(li_age_day * 24) < 1 then --计算分钟
      li_min := ceil(li_age_day * 24 * 60);
      ls_age := to_char(li_min) || '分';
    end if;
   elsif falg = 2 then
     if li_age_month >= 12 then --计算年
      ls_age := to_char(trunc(li_age_month/12));
      
    elsif li_age_month < 12 and li_age_month >= 1 then --计算月
      li_months := trunc(li_age_month);
      --li_days := trunc(ADMISSION_DATE_TIME-add_months(ad_birthdate,li_months));
      ls_age := to_char(li_months);
      
    elsif li_age_month < 1  and li_age_day >= 1 then --计算天
      li_days := trunc(li_age_day);
      ls_age := to_char(li_days);
      
    elsif li_age_day < 1 and ceil(li_age_day * 24) >= 1 then --计算小时
      li_hours := ceil(li_age_day * 24);
      ls_age := to_char(li_hours);

    elsif ceil(li_age_day * 24) < 1 then --计算分钟
      li_min := ceil(li_age_day * 24 * 60);
      ls_age := to_char(li_min);
    end if;
   end if;
return ls_age;
END fun_get_age;

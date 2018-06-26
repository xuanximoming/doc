-----------------------------------------------------
-- Export file for user EMR@ORCL                   --
-- Created by Administrator on 2018/5/27, 13:46:48 --
-----------------------------------------------------

set define off
spool fun.log

prompt
prompt Creating function DATEDIFF
prompt ==========================
prompt
create or replace function emr.datediff(v_type      varchar2, --Ê±¼ä¼ä¸ôÀà±ð
                                    v_startdate   varchar2, --Ê±¼ä¿ªÊ¼Ê±¼ä
                                    v_enddate varchar2 --Ê±¼ä½áÊøÊ±¼ä 
                                    )
 return number IS
begin
  --Äê

  if v_type = 'yy' then
    return round(to_number(to_date(v_enddate, 'yyyy-mm-dd HH24:mi:ss') -
                           to_date(v_startdate, 'yyyy-mm-dd HH24:mi:ss')) / 365);
    --ÔÂ
  elsif v_type = 'mm' then
    return round(to_number(to_date(v_enddate, 'yyyy-mm-dd HH24:mi:ss') -
                           to_date(v_startdate, 'yyyy-mm-dd HH24:mi:ss')) / 30);
    --ÈÕ
  elsif v_type = 'dd' then
    return round(to_number(to_date(v_enddate, 'yyyy-mm-dd HH24:mi:ss') -
                           to_date(v_startdate, 'yyyy-mm-dd HH24:mi:ss')));
    --Ð¡Ê±
  elsif v_type = 'hh' then
    return round(to_number(to_date(v_enddate, 'yyyy-mm-dd HH24:mi:ss') -
                           to_date(v_startdate, 'yyyy-mm-dd HH24:mi:ss')) * 24);
    --·ÖÖÓ
  elsif v_type = 'mi' then
    return round(to_number(to_date(v_enddate, 'yyyy-mm-dd HH24:mi:ss') -
                           to_date(v_startdate, 'yyyy-mm-dd HH24:mi:ss')) * 24 * 60);
    --Ãë
  elsif v_type = 'ss' then
    return round(to_number(to_date(v_enddate, 'yyyy-mm-dd HH24:mi:ss') -
                           to_date(v_startdate, 'yyyy-mm-dd HH24:mi:ss')) * 24 * 60 * 60);
    --ºÁÃë
  elsif v_type = 'ms' then
    return round(to_number(to_date(v_enddate, 'yyyy-mm-dd HH24:mi:ss') -
                           to_date(v_startdate, 'yyyy-mm-dd HH24:mi:ss')) * 24 * 60 * 60 * 1000);
  
  else
    return - 1;
  end if;
end;
/

prompt
prompt Creating function FUN_GET_AGE
prompt =============================
prompt
CREATE OR REPLACE Function EMR.fun_get_age(ad_birthdate Date,ADMISSION_DATE_TIME date,falg number) RETURN  varchar2 Is
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
    ´óÓÚ1Ëê ÏÔÊ¾¼¸Ëê
    Ð¡ÓÚ1Ëê£¬ÏÔÊ¾¼¸ÔÂ
    Ð¡ÓÚÒ»¸öÔÂ£¬ÏÔÊ¾¼¸Ìì
    Ð¡ÓÚÒ»Ìì£¬ÏÔÊ¾¼¸Ð¡Ê±
    */
   if falg = 1 then
    if li_age_month >= 12 then --¼ÆËãÄê
      ls_age := to_char(trunc(li_age_month/12))||'Ëê';

    elsif li_age_month < 12 and li_age_month >= 1 then --¼ÆËãÔÂ
      li_months := trunc(li_age_month);
      li_days := trunc(ADMISSION_DATE_TIME-add_months(ad_birthdate,li_months));
      ls_age := to_char(li_months) ||'ÔÂ'||to_char(li_days)||'Ìì' ;

    elsif li_age_month < 1  and li_age_day >= 1 then --¼ÆËãÌì
      li_days := trunc(li_age_day);
      ls_age := to_char(li_days) ||'Ìì';

    elsif li_age_day < 1 and ceil(li_age_day * 24) >= 1 then --¼ÆËãÐ¡Ê±
      li_hours := ceil(li_age_day * 24);
      ls_age := to_char(li_hours) ||'Ð¡Ê±';

    elsif ceil(li_age_day * 24) < 1 then --¼ÆËã·ÖÖÓ
      li_min := ceil(li_age_day * 24 * 60);
      ls_age := to_char(li_min) || '·Ö';
    end if;
   elsif falg = 2 then
     if li_age_month >= 12 then --¼ÆËãÄê
      ls_age := to_char(trunc(li_age_month/12));

    elsif li_age_month < 12 and li_age_month >= 1 then --¼ÆËãÔÂ
      li_months := trunc(li_age_month);
      --li_days := trunc(ADMISSION_DATE_TIME-add_months(ad_birthdate,li_months));
      ls_age := to_char(li_months);

    elsif li_age_month < 1  and li_age_day >= 1 then --¼ÆËãÌì
      li_days := trunc(li_age_day);
      ls_age := to_char(li_days);

    elsif li_age_day < 1 and ceil(li_age_day * 24) >= 1 then --¼ÆËãÐ¡Ê±
      li_hours := ceil(li_age_day * 24);
      ls_age := to_char(li_hours);

    elsif ceil(li_age_day * 24) < 1 then --¼ÆËã·ÖÖÓ
      li_min := ceil(li_age_day * 24 * 60);
      ls_age := to_char(li_min);
    end if;
   end if;
return ls_age;
END fun_get_age;
/

prompt
prompt Creating function ISNUMBER
prompt ==========================
prompt
CREATE OR REPLACE FUNCTION EMR.isnumber(str varchar2) return number IS
  v_number number;
BEGIN
  v_number := TO_NUMBER(str);
  RETURN 1;
EXCEPTION
  WHEN OTHERS THEN
    RETURN 0;
END;
/

prompt
prompt Creating function FUN_REPLACE_ADDRESS
prompt =====================================
prompt
create or replace function emr.fun_replace_address(as_area_code in varchar2) return varchar2 is
  Result varchar2(100);
begin
if as_area_code  is  null then
   --v_code :='132429';
   Result :='ºÓ±±Ê¡äµË®ÏØ';
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



/* select decode(Result,null,as_area_code, Result,'ºÓ±±Ê¡äµË®ÏØ' ) into Result
  from dual; */

  return(Result);
end fun_replace_address;
/

prompt
prompt Creating function F_DEPTEMMANAGER
prompt =================================
prompt
create or replace function emr.F_DepTemManager(v_querytype int,
                                           v_id        varchar,
                                           v_previd    varchar)
  return varchar IS
  v_groupName  varchar(100);
  v_previdtemp varchar(50);
  v_idtemp     varchar(30);
begin

  IF v_previd != '' then
    BEGIN
      SELECT nvl(ModelDirectory.PrevID, '')
        into v_previdtemp
        FROM ModelDirectory
       WHERE ModelDirectory.ID = v_previd;
    
      SELECT nvl(ModelDirectory.ID, '')
        into v_idtemp
        FROM ModelDirectory
       WHERE ModelDirectory.ID = v_previd;
    
      IF v_querytype = 0 then
        begin
          IF v_idtemp != '' then
            BEGIN
              v_groupName := F_DepTemManager(0, v_idtemp, v_previdtemp);
            END;
          else
            BEGIN
              SELECT nvl(ModelDirectory.Name, '')
                into v_groupName
                FROM ModelDirectory
               WHERE ModelDirectory.ID = v_id;
              RETURN v_groupName;
            END;
          end if;
        end;
      end if;
      if v_querytype = 1 then
        BEGIN
          IF v_previdtemp != '' then
            BEGIN
              v_groupName := F_DepTemManager(1, v_idtemp, v_previdtemp);
            END;
          ELSE
            BEGIN
              SELECT nvl(ModelDirectory.Name, '')
                into v_groupName
                FROM ModelDirectory
               WHERE ModelDirectory.ID = v_id;
              RETURN v_groupName;
            END;
          end if;
        END;
      end if;
    END;
  ELSE
    BEGIN
      SELECT ModelDirectory.Name
        into v_groupName
        FROM ModelDirectory
       WHERE ModelDirectory.ID = v_id;
    END;
  end if;
  
  RETURN v_groupName;

END;
/

prompt
prompt Creating function GETAGE
prompt ========================
prompt
create or replace function emr.GetAge(ABirthday DATE) return VARCHAR2 is
  sAge VARCHAR2(20);
  iYears  INTEGER;
begin
  iYears  := TRUNC(Months_between(SYSDATE, ABirthday)/12);
  sAge    := iYears||'Ëê'||(TRUNC(SYSDATE)- ADD_MONTHS(ABirthday, iYears*12))||'Ìì';
  return(sAge);
end GetAge;
/

prompt
prompt Creating function GETAGEBYBIRTHANDAPPLYDATE
prompt ===========================================
prompt
create or replace function emr.GetAgeByBirthAndApplyDate(ABirthday DATE,ApplyDate Date) return VARCHAR2 is
  sAge VARCHAR2(20);
  iYears  INTEGER;
begin
  iYears  := TRUNC(Months_between(ApplyDate, ABirthday)/12);
  sAge    := iYears||'Ëê'||(TRUNC(ApplyDate)- ADD_MONTHS(ABirthday, iYears*12))||'Ìì';
  return(sAge);
end GetAgeByBirthAndApplyDate;
/

prompt
prompt Creating function GETCONTENTFROMXML
prompt ===================================
prompt
CREATE OR REPLACE FUNCTION EMR.getContentFromXml(v_recordDetailID varchar2,
                                             v_roElementName  varchar2,
                                             v_flag           integer)
/*
     1: »»ÐÐµÄÊý¾ÝÒ²Ò»²¢×¥È¡£¬Ö±µ½·¢ÏÖÏÂÒ»¸öRoElementÔªËØ
     2£ºÊý¾ÝÔÚµ±Ç°ÐÐÖÐ×¥È¡£¬Ö±µ½·¢ÏÖÏÂÒ»¸öRoElementÔªËØ
     3£ºÖ»×¥È¡µ±Ç°ÐÐÖÐRoElemenetÔªËØÖ®ºóµÄÊý¾Ý
  */

 return nvarchar2 IS
  v_result nvarchar2(4000);

  --´´½¨XML½âÎöÆ÷ÊµÀýXMLPARSER.parser
  xmlPar XMLPARSER.parser := XMLPARSER.NEWPARSER;
  --¶¨ÒåDOMÎÄµµ¶ÔÏó
  doc xmldom.DOMDocument;

  --roElementÔªËØ
  roElementNode xmldom.DOMNode;

  --pÔªËØ¼¯ºÏ
  paragraphElementNodes xmldom.DOMNodeList;
  --pÔªËØ¼¯ºÏµÄÊýÁ¿
  paragraphElementCount integer;
  --pÔªËØ
  paragraphElementNode xmldom.DOMNode;

  --pÔªËØµÄËùÓÐ×Ó½Úµã¼¯ºÏ
  childElementNodes xmldom.DOMNodeList;
  --pÔªËØµÄËùÓÐ×Ó½Úµã¸öÊý
  childElementNodesCount integer;

  --selementÔªËØ¼¯ºÏ
  selementNodes xmldom.DOMNodeList;
  --selementÔªËØ¼¯ºÏ¸öÊý
  selementNodesCount integer;
  selementNode       xmldom.DOMNode;
  selementValue      nvarchar2(200);

  xmlClobData clob;

  --½øÈëÂß¼­ÅÐ¶ÏµÄ±êÖ¾Î»
  isEnter integer := 0;

  --½ÚµãÊôÐÔ¼¯ºÏ
  nodeAttributes xmldom.DOMNamedNodeMap;

begin
  --»ñÈ¡xmlÊý¾Ý£¬clob×Ö¶ÎÖÐ»ñÈ¡²¡ÀúÄÚÈÝ
  select content
    into xmlClobData
    from recorddetail
   where id = v_recordDetailID;

  --½âÎöxmlÊý¾Ý
  xmlparser.parseClob(xmlPar, xmlClobData);
  doc := xmlparser.getDocument(xmlPar);

  --ÊÍ·Å½âÎöÆ÷ÊµÀý
  xmlparser.freeParser(xmlPar);

  --»ñÈ¡ËùÓÐPÔªËØ
  paragraphElementNodes := xmldom.getElementsByTagName(doc, 'p');
  paragraphElementCount := xmldom.getLength(paragraphElementNodes);

  --Ñ­»·¶ÎÂä
  For paragraphIndex in 0 .. paragraphElementCount - 1 LOOP
    --********Ñ­»·¶ÎÂä BEGIN********
    BEGIN
      --»ñÈ¡µ±Ç°¶ÎÂä
      paragraphElementNode := xmldom.item(paragraphElementNodes,
                                          paragraphIndex);
      --»ñÈ¡¶ÎÂäÖÐËùÓÐÔªËØ
      childElementNodes      := xmldom.getChildNodes(paragraphElementNode);
      childElementNodesCount := xmldom.getLength(childElementNodes);
      FOR childElementNodesIndex in 0 .. childElementNodesCount - 1 LOOP
        --********¶ÎÂäÖÐµÄÔªËØ BEGIN********
        BEGIN
          roElementNode := xmldom.item(childElementNodes,
                                       childElementNodesIndex);

          IF isEnter = 0 THEN
            --ÕÒµ½ÆðÊ¼RoElementÔªËØ
            BEGIN
              --»ñÈ¡¶ÎÂäÖÐµÄroElementÔªËØ
              IF (xmldom.getNodeName(roElementNode) = 'roelement') THEN
                BEGIN
                  nodeAttributes := xmldom.getAttributes(roElementNode);

                  --»ñÈ¡name == v_roleElementName µÄroELementÔªËØ
                  IF (xmldom.getNodeValue(xmldom.getNamedItem(nodeAttributes,
                                                              'name')) =
                     v_roElementName) THEN
                    BEGIN
                      isEnter := 1;
                    END;
                  END IF;
                END;
              END IF;
            END;
          ELSIF isEnter = 1 THEN
            BEGIN
              --ÅÐ¶ÏÊÇ·ñÓöµ½ºóÃæµÄroElement£¬Èç¹ûÓöµ½ÐèÒªÍË³öÑ­»·
              IF (xmldom.getNodeName(roElementNode) = 'roelement') AND
                 v_flag != 3 THEN
                BEGIN
                  isEnter := 2;
                  EXIT;
                END;
              ELSE
                BEGIN
                  IF (xmldom.getNodeName(roElementNode) = 'selement') THEN
                    --Èç¹ûÊÇ"¶àÑ¡¿ò"ÐèÒª×öÌØÊâ´¦Àí
                    BEGIN
                      nodeAttributes := xmldom.getAttributes(roElementNode);
                      selementValue  := xmldom.getNodeValue(xmldom.getNamedItem(nodeAttributes,
                                                                                'text')); --»ñÈ¡selementÔªËØµÄtextÊôÐÔµÄÖµ
                      /*
                      selementNodes      := xmldom.getChildNodes(roElementNode);
                      selementNodesCount := xmldom.getLength(selementNodes);

                      FOR selementNodesIndex in 0 .. selementNodesCount - 1 LOOP
                        --Ñ­»·selementÔªËØµÄËùÓÐ×ÓÔªËØitem
                        selementNode   := xmldom.item(selementNodes,
                                                      selementNodesIndex);
                        nodeAttributes := xmldom.getAttributes(selementNode);
                        IF xmldom.getNodeValue(xmldom.getNamedItem(nodeAttributes,
                                                                   'selected')) =
                           'true' THEN
                          --ÕÒ³öitemÖÐÊôÐÔselectedÎªtrueµÄ½Úµã
                          selementValue := xmldom.getNodeValue(xmldom.getFirstChild(selementNode));
                        END IF;
                      END LOOP;
                      */

                      v_result := v_result || selementValue;
                    END;
                  ELSIF (xmldom.getNodeName(roElementNode) = 'btnelement') THEN
                    --Èç¹ûÊÇ¡°°´Å¥¡±ÐèÒª×öÌØÊâ´¦Àí
                    BEGIN
                      nodeAttributes := xmldom.getAttributes(roElementNode);
                      selementValue  := xmldom.getNodeValue(xmldom.getNamedItem(nodeAttributes,
                                                                                'print')); --»ñÈ¡btnelementÔªËØµÄprintÊôÐÔµÄÖµ
                      IF selementValue != 'False' THEN
                        BEGIN
                          v_result := v_result ||
                                      xmldom.getNodeValue(xmldom.getFirstChild(roElementNode));
                        END;
                      END IF;
                    END;
                  ELSE
                    selementValue := xmldom.getNodeValue(xmldom.getFirstChild(roElementNode));
                    IF instr(selementValue, 'Ò½Ê¦Ç©Ãû') > 0 or
                       instr(selementValue, 'Ò½ÉúÇ©Ãû') > 0 THEN
                      --Óöµ½Ò½Ê¦Ç©ÃûÔòÍË³ö
                      BEGIN
                        isEnter := 2;
                        EXIT;
                      END;
                    ELSE
                      v_result := v_result || selementValue;
                    END IF;
                  END IF;
                END;
              END IF;
            END;
          END IF;
        END;
        --********¶ÎÂäÖÐµÄÔªËØ END********
      END LOOP;

      IF isEnter = 1 THEN
        --·¢ÏÖÖ¸¶¨µÄRoElementÔªËØ
        BEGIN
          IF v_flag = 2 OR v_flag = 3 THEN
            --Ö»ÅÐ¶Ïµ±Ç°¶ÎÂä
            BEGIN
              isEnter := 2;
              EXIT;
            END;
          END IF;
        END;
      END IF;

    END;
    --********Ñ­»·¶ÎÂä END********
  END LOOP;
  v_result := ltrim(ltrim(v_result, '£º'), ':');
  v_result := rtrim(ltrim(v_result));
  return v_result;

EXCEPTION
  WHEN OTHERS THEN
    return v_result;
END;
/

prompt
prompt Creating function GETCONTENTFROMXMLNEW
prompt ======================================
prompt
CREATE OR REPLACE FUNCTION EMR.getContentFromXmlNEW(v_recordDetailID varchar2,
                                             v_roElementName  varchar2,
                                             v_flag           integer)
/*
     1: »»ÐÐµÄÊý¾ÝÒ²Ò»²¢×¥È¡£¬Ö±µ½·¢ÏÖÏÂÒ»¸öRoElementÔªËØ
     2£ºÊý¾ÝÔÚµ±Ç°ÐÐÖÐ×¥È¡£¬Ö±µ½·¢ÏÖÏÂÒ»¸öRoElementÔªËØ
     3£ºÖ»×¥È¡µ±Ç°ÐÐÖÐRoElemenetÔªËØÖ®ºóµÄÊý¾Ý
  */

 return nvarchar2 IS
  v_result clob;

  --´´½¨XML½âÎöÆ÷ÊµÀýXMLPARSER.parser
  xmlPar XMLPARSER.parser := XMLPARSER.NEWPARSER;
  --¶¨ÒåDOMÎÄµµ¶ÔÏó
  doc xmldom.DOMDocument;

  --roElementÔªËØ
  roElementNode xmldom.DOMNode;

  --pÔªËØ¼¯ºÏ
  paragraphElementNodes xmldom.DOMNodeList;
  --pÔªËØ¼¯ºÏµÄÊýÁ¿
  paragraphElementCount integer;
  --pÔªËØ
  paragraphElementNode xmldom.DOMNode;

  --pÔªËØµÄËùÓÐ×Ó½Úµã¼¯ºÏ
  childElementNodes xmldom.DOMNodeList;
  --pÔªËØµÄËùÓÐ×Ó½Úµã¸öÊý
  childElementNodesCount integer;

  --selementÔªËØ¼¯ºÏ
  selementNodes xmldom.DOMNodeList;
  --selementÔªËØ¼¯ºÏ¸öÊý
  selementNodesCount integer;
  selementNode       xmldom.DOMNode;
  selementValue      nvarchar2(200);

  xmlClobData clob;

  --½øÈëÂß¼­ÅÐ¶ÏµÄ±êÖ¾Î»
  isEnter integer := 2;

  --½ÚµãÊôÐÔ¼¯ºÏ
  nodeAttributes xmldom.DOMNamedNodeMap;

begin
  --»ñÈ¡xmlÊý¾Ý£¬clob×Ö¶ÎÖÐ»ñÈ¡²¡ÀúÄÚÈÝ
  select content
    into xmlClobData
    from recorddetail
   where id = v_recordDetailID;

  --½âÎöxmlÊý¾Ý
  xmlparser.parseClob(xmlPar, xmlClobData);
  doc := xmlparser.getDocument(xmlPar);

  --ÊÍ·Å½âÎöÆ÷ÊµÀý
  xmlparser.freeParser(xmlPar);

  --»ñÈ¡ËùÓÐPÔªËØ
  paragraphElementNodes := xmldom.getElementsByTagName(doc, 'p');
  paragraphElementCount := xmldom.getLength(paragraphElementNodes);

  --Ñ­»·¶ÎÂä
  For paragraphIndex in 0 .. paragraphElementCount - 1 LOOP
    --********Ñ­»·¶ÎÂä BEGIN********
    BEGIN
      --»ñÈ¡µ±Ç°¶ÎÂä
      paragraphElementNode := xmldom.item(paragraphElementNodes,
                                          paragraphIndex);
      --»ñÈ¡¶ÎÂäÖÐËùÓÐÔªËØ
      childElementNodes      := xmldom.getChildNodes(paragraphElementNode);
      childElementNodesCount := xmldom.getLength(childElementNodes);
      FOR childElementNodesIndex in 0 .. childElementNodesCount - 1 LOOP
        --********¶ÎÂäÖÐµÄÔªËØ BEGIN********
        BEGIN
          roElementNode := xmldom.item(childElementNodes,
                                       childElementNodesIndex);

          --IF isEnter = 0 THEN
            --ÕÒµ½ÆðÊ¼RoElementÔªËØ
            /*BEGIN
              --»ñÈ¡¶ÎÂäÖÐµÄroElementÔªËØ
              IF (xmldom.getNodeName(roElementNode) = 'roelement') THEN
                BEGIN
                  nodeAttributes := xmldom.getAttributes(roElementNode);
 --isEnter := 1;
                  --»ñÈ¡name == v_roleElementName µÄroELementÔªËØ
                  \*IF (xmldom.getNodeValue(xmldom.getNamedItem(nodeAttributes,
                                                              'name')) =
                     v_roElementName) THEN
                    BEGIN
                      isEnter := 1;
                    END;
                  END IF;*\
                END;
              END IF;
            END;*/
          
          --ELSIF isEnter = 1 THEN
           -- BEGIN
              --ÅÐ¶ÏÊÇ·ñÓöµ½ºóÃæµÄroElement£¬Èç¹ûÓöµ½ÐèÒªÍË³öÑ­»·
             /* IF (xmldom.getNodeName(roElementNode) = 'roelement') AND
                 v_flag != 3 THEN
                BEGIN
                  isEnter := 2;
                  --EXIT;
                END;*/
              --ELSE
                --BEGIN
                  IF (xmldom.getNodeName(roElementNode) = 'selement') THEN
                    --Èç¹ûÊÇ"¶àÑ¡¿ò"ÐèÒª×öÌØÊâ´¦Àí
                    BEGIN
                      nodeAttributes := xmldom.getAttributes(roElementNode);
                      selementValue  := xmldom.getNodeValue(xmldom.getNamedItem(nodeAttributes,
                                                                                'text')); --»ñÈ¡selementÔªËØµÄtextÊôÐÔµÄÖµ
                      v_result := v_result || selementValue;
                    END;
                  ELSIF (xmldom.getNodeName(roElementNode) = 'btnelement') THEN
                    --Èç¹ûÊÇ¡°°´Å¥¡±ÐèÒª×öÌØÊâ´¦Àí
                    BEGIN
                      nodeAttributes := xmldom.getAttributes(roElementNode);
                      selementValue  := xmldom.getNodeValue(xmldom.getNamedItem(nodeAttributes,
                                                                                'print')); --»ñÈ¡btnelementÔªËØµÄprintÊôÐÔµÄÖµ
                      IF selementValue != 'False' THEN
                        BEGIN
                          v_result := v_result ||
                                      xmldom.getNodeValue(xmldom.getFirstChild(roElementNode));
                        END;
                      END IF;
                    END;
                  ELSE
                    selementValue := xmldom.getNodeValue(xmldom.getFirstChild(roElementNode));
                    IF instr(selementValue, 'Ò½Ê¦Ç©Ãû') > 0 or
                       instr(selementValue, 'Ò½ÉúÇ©Ãû') > 0 THEN
                      --Óöµ½Ò½Ê¦Ç©ÃûÔòÍË³ö
                      BEGIN
                        isEnter := 2;
                        EXIT;
                      END;
                    ELSE
                      v_result := v_result || selementValue;
                    END IF;
                  END IF;
                END;
             -- END IF;
           -- END;
          --END IF;
       -- END;
        --********¶ÎÂäÖÐµÄÔªËØ END********
      END LOOP;

      IF isEnter = 1 THEN
        --·¢ÏÖÖ¸¶¨µÄRoElementÔªËØ
        BEGIN
          IF v_flag = 2 OR v_flag = 3 THEN
            --Ö»ÅÐ¶Ïµ±Ç°¶ÎÂä
            BEGIN
              isEnter := 2;
              EXIT;
            END;
          END IF;
        END;
      END IF;

    END;
    --********Ñ­»·¶ÎÂä END********
  END LOOP;
  v_result := ltrim(ltrim(v_result, '£º'), ':');
  v_result := rtrim(ltrim(v_result));
  return v_result;

EXCEPTION
  WHEN OTHERS THEN
    return v_result;
END;
/

prompt
prompt Creating function GETITEMVALUEFROMXML
prompt =====================================
prompt
CREATE OR REPLACE FUNCTION EMR.getItemValueFromXml(v_xmlContent Clob)
  return varchar IS
  v_itemValue varchar(4000);
  xmlPar      XMLPARSER.parser := XMLPARSER.NEWPARSER;
  doc         xmldom.DOMDocument;
  itemNode       xmldom.DOMNode;
  itemNodes      xmldom.DOMNodeList;
  itemNodescount integer;
begin
  xmlparser.parseClob(xmlPar, v_xmlContent);
  doc := xmlparser.getDocument(xmlPar);
  xmlparser.freeParser(xmlPar);

  itemNodes      := xmldom.getElementsByTagName(doc, 'Item');
  itemNodescount := xmldom.getLength(itemNodes);

  FOR itemNodeIndex in 0 .. itemNodescount - 1 LOOP
    BEGIN
      itemNode    := xmldom.item(itemNodes, itemNodeIndex);
      v_itemValue := v_itemValue || xmldom.getNodeValue(xmldom.getFirstChild(itemNode));
    END;
  END LOOP;

  return v_itemValue;

  EXCEPTION
  WHEN OTHERS THEN
    RETURN '';
end;
/

prompt
prompt Creating function GETYEARAGEBYBIRTHANDAPPLYDATE
prompt ===============================================
prompt
create or replace function emr.getyearagebybirthandapplydate(ABirthday DATE,ApplyDate Date) return VARCHAR2 is
  sAge VARCHAR2(20);
  iYears  INTEGER;
begin
  iYears  := TRUNC(Months_between(ApplyDate, ABirthday)/12);
  if iYears = 0
  then iYears := 1;
  end if;
  sAge    := iYears||'Ëê';
  return(sAge);
end GetYearAgeByBirthAndApplyDate;

/*
create or replace function GetAgeByBirthAndApplyDate(ABirthday DATE,ApplyDate Date) return VARCHAR2 is
  sAge VARCHAR2(20);
  iYears  INTEGER;
begin
  iYears  := TRUNC(Months_between(ApplyDate, ABirthday)/12);
  sAge    := iYears||'Ëê'||(TRUNC(ApplyDate)- ADD_MONTHS(ABirthday, iYears*12))||'Ìì';
  return(sAge);
end GetAgeByBirthAndApplyDate;*/
/

prompt
prompt Creating function GET_PINYIN
prompt ============================
prompt
CREATE OR REPLACE FUNCTION EMR.Get_Pinyin(Str VARCHAR2) RETURN VARCHAR2 IS
  RESULT  VARCHAR2(200);
  i       INTEGER;
  j       INTEGER;
  k       INTEGER;
  Tmpstr  VARCHAR2(2);
  Tmpstr2 VARCHAR2(2000);
  Tmpstr3 VARCHAR2(2);
  Strlen  INTEGER;
  Strlen2 INTEGER;
  TYPE Py IS VARRAY(500) OF VARCHAR2(2000);
  v_Py Py := Py('a°¡°¢ºÇß¹àÄëçï¹åH…°®°«°¤°¥°­°©°¬°¦°§°ª°¯°£°¨´ôàÉæÈè¨êÓÞßíÁàÈïÍö°VÄË´ƒvƒŒƒùØÜ„’…¥ßÀ…Ù†‡Bàæ‡†ˆì',
                'a‰a‰¹ÆæŠÖŠâ‹ÜÌÛ‘°‘¹”±”²•l•á™üšGš±œÜœâžGŸCŸs­a°}°Š²}³v´oµK½iËBÌ@ÖL×c×rÙŒÜtá{æXèPéuºÒêiêqëBì\ìaðg',
                'añLòIöJ÷oø°´°²°µ°¶°³°¸°°°±°·³§¹ãâÖÞîáíï§èñÚÏðÆÛû÷öóƒ‡…\…{†H†††±ˆˆ¥ˆÝ‹F‹jŒå^¸É••›¡«q¯uºÐ±Q±V´U',
                'aÁOÄWÇIÈCÈsÈ€ÉŽÑsÕYÖOØtØßVãQä@åBÇ¯éœêŽê›ë@ëˆì”íí™îOñüñKõcø‘ùgù“°º°¹°»Ñö…nŒì•n–‹áZálóa°À°¼°Á°Â°¾',
                'a°Ã°½°¿°ÄÏùÞÖæÁâÚæñà»ÛêåÛñúòüéáöË÷¡÷éá®…†õàÞ‡Æ‡Ìˆ‰¥‰§ŠSŠW‹‹‹®CåŽS‘R’U’j“³“ý–À—`¹÷›|½½E²ÁŸÑ nª‡­H±l´x´“´ÂKÂOÆbÊTÎ‚Ò\Ö’Ö“ÝEàUçGéOëJòˆö—ø^ø€úqü',
                'b°Ñ°Ë°É°Ö°Î°Õ°Ï°Í°Å°Ç°Ó°Ô°È°Ð°Ê°Ì°Ò°ÆôÎÜØá±öÑîÙ÷ÉÝÃå±”²®…©†\†^ˆzˆ¢‰‰ÎŠBŠ‚Qy’i’pÞã–[èË–Â™ñÅÈžß ã«X°j°q³F¸Ÿ¼“ÁTÁjÃ_ÆžÝÉÍMÒ†ÔyØ^Ú•ÝRá—ášâZïTôƒõEõN÷„÷ˆü–°Ù°×°Ú°Ü°Ø°Ý°Û²®°ÞÞãßÂêþ†hŽß°Ç’…’“ÅÅ”[”¡',
                'b–àÅÉªW¸q»“»Ÿ½]ÞµËbÒoÙ”ì‹÷¹ív°ë°ì°à°ã°è°á°æ°ß°å°é°â°ç°ê°ä°íñ­ÛàîÓô²Úæñ£K·ÖˆmˆÐŠ”Œê±òE“„”‘”Ê•L–D–®œ°­š¶t»O»{½OÃRÎZÎ†ÎŒÑ—ÒƒáÙÛAÞkÞl±æ±çÞnÞqâkã[é›ì‡îCô‘øX°ï°ô°ó°õ°÷°î°ñ°ö°ø°ð°ò°ùäºÝòK†çˆ ˆÈ‰Y‹˜',
                'bLŽ°ŽÀŽÍÅíÏ’²’Ê“sÅÔ—” ¥«g³‰¶œ¼½‰¿R·ÄÅÍKÍ{ÎMó¦Örß™æ^íDòuóo°ü±§±¨±¥±£±©±¡±¦±¬°þ±ªÅÙ±¢°ý±¤°ú°û±«ÅÚÆÙöµæßìÒñÙð±õÀÝáÜƒ˜„ƒÙè„ô´ô‡E‡¥ˆçˆó‹~‹›Œ‡Œ—ŒšÞA•Þ–¢«’³h·‘¸²¾¾‹Ç˜Ê}ËÌ™ÍdÐˆÅÛÙöÑfÒJÙ…ãEèt',
                'bè˜é–ìdìsï’ï–ñhóbóŽõUøRødý_È`±»±±±¶±­±³±¯±¸±®±°±´±²±µ±º±·±¹±ÛñØã£ÝíðÇöÍßÂÚý÷¹ØÃÚéíÕ‚pÙÂ‚³‚Ë‚äƒF†\†h†Õˆ¢ÛýâöÊ‘v“d•K–{–È—G—f—“—”—À²¨ ´ ÍªN¬D¬i¯w° ¶F¹t¼LÆpÆ…ÆÐÝÉÈiÆÏËÍ“òãÒoÕRÕ|Ø°ÏÝKÝ…àfãmä^åCèE',
                'bócùl±¾±¼±½±¿º»ï¼êÚÛÎÛÐÌå‚–†Ï‰úŠM’Ù“à—L—ñ›yœ`žÇŸø ÄªŠÁÏnÙSÝ™ßGåQèM±Ä±Á±Â±À±Å°ö±Ãê´àÔÈÙº°ø‚õßô†çˆ©ˆÈÜ¡‰lŠRÐÆ½Åê’²“sÅÔ°ñmŸÔ¬a¬e¯nµp½l¾X¿‡ÈEÛMßJåAçaéGéaìž±È±Ê±Õ±Ç±Ì±Ø±Ü±Æ±Ï±Û±Ë±É±Ú±Í±Ò±×±Ù±Î±Ð',
                'bÁXÒKñƒó±ÚæÔYó÷º`¿oÞµÓv±ÜõI”Àå¨±ÛÛ‹÷ÂŠ`èµàˆð{ÀVôÅÒgç@íSí{ÜKÜLôxÚFèEòúzú‡ü„±ßí¾óÖ±àìÔ®K¹¾Žòùª ß„æQöýß…±Þöböc»ež×±á±âñ¹ØÒÆíÜ·HñÛ¼DøuËx±åÛÍâí’\›MãêÜÐáŠO±ã±ä‰ä•c',
                'bÒŒ“OçÂ±éÞgÅŒÞl±æ±ç±èÞp×ƒ±ë±êì©÷ÔªYÃ ‰wŽ¼œýæô˜ËŸÏ±ìñ¦ïÚì­ì®ƒšï[žd gÅAÙ™çSïðïjïkïlïnès±íæ»ñÑÕ•ÒFål™~‚l÷§÷B±ï±î÷Mü‚Ì‹ý–„e±ð…ñÇaÍrÖÒXÏhõ¿±ñ°T•ß“±ö±òÙÏ±ó—Ã±õçÍéÄ¬žÙe',
                'bÙfïÙƒ†±ôžIžMÌžáÙžlìEÀ_Ï™è\î šà±÷éëë÷ó‰”Póš›Äœ÷Æ÷ÞóxôW•šê±ù±ø–Þ’ò—€ä‰™‰±ûÚûêvT’m±üÆu•m±ú±þ±ý·’Ís—ŠÙ÷âìïžðV ]²¢KãŽÕˆ—Žð‚v–â²¡¸p‚§‚ìŒ}ÞðÕ@õmìh°h²¦²¨²£°þ±CÑB²§',
                'bâÄà£¼žÀ²±²¤ã\ƒ`ó²¥ðGÜ@ò’÷Q²®ØÃ²µ²¯²´ þ­“‚N²ªÃ`àRÙñ’©›Â¶zîà²¬²°²©²³È•ð¾ö²«â“ãKñA÷ˆƒkŸ¹ ¦²­²²Å‡ñCñgõÛäcéD±¡ñ•õN‘ÅµRº~ænðoùP Ý™ØÒqíçè}õË¹ô¤ŒXë¢éÞ¼\×LÌYÊNmŽïåÍ',
                'bîßêÎâ˜ÕcðJÞKõ³²·ß²²¹²¸²¶ÑaøGûQ²»²¼Ñ²½…ù²ÀšhšiîÐ„Ïˆ¶‹²¿²ºê³EÉžÛYº^ðX²¾çã·ðº»å²ðÚÆÙ',
                'càê²Áíåµgßn²Â²Å²Ä²ÆØ”‘å²Ã²É‚šˆÆŠéŒu²Ê’ñ²ÇÛP¾Z²È²Ë—²Ì¿nk²Îï{æîœ’‹Û²Íò‰²Ð²Ï²Ñšˆ‘MÎ]‘LÐQÐT²Ò‘K‡k‘”÷õüo²ÓôÓƒ…ÓËL Nè² |²Ö¨Ø÷²×²Ô‚}²Õ‚áƒûÈœæªÉnžPÅ“Ï@À˜²Ø™âè†Ù‰“Ù²Ù',
                'c²Ú•ù²ÜàÐæäîÉ˜²ÛÒGô½ó©ç[Ü³ÆH²ÝóòxÃHÒ_²á²à²Þâü²âÇR”˜ÈYÅœy²ßÈm¹ZÉƒ‰x¹‹‘ŠßÄ~á¯—qä¹àá²ãŒÓ¸}òš²ä³€³’Kªeu²æÆOè¾ÃPÅaÓ‚²†â²åâÇã˜ïÊÅ‘®›åšðlˆ“²é–Ë²ç²è¿²ëâªìxé¶²ì²êéß',
                'cñÃïïèdŠgãâ²í÷²ïæ±²î¼p²ðîÎâO åÙ­²ñµ}²ò†¶ƒŠò²ÐƒðûÏŠ‡ÐÞ{êè—{²ô²óäiŽÊæ¿²÷åî—œµìø²ö‹ÈŸž²øª†²õÕSäaâÜ¨äý¿C´vš´àšïâžeƒ§„­ó¸àž‡Á‰ÊŽfžÀpÀsõðéKÆB×‹èð’²ú„i•CP›º„}ÚÆ®a®b',
                'c²ù²ûÝÛ„•ÝIŽÂÊrÕ~éˆºoÙæÀAápçPêU‡Ïž¬×€âã³ƒ“·‘Ï²ü‘Ôåñí]Øö²ýæ½œC²þÝÅãÑ•˜—Ç¬dÑmè å_öðöKüƒ¸³¦ÜÉ³¢³¥³£áä®DÈO®^Äc‡LæÏ¬ Äqä–ƒ”‡ŸÏ^÷•çL÷l³§³¡êÆã®³¨ƒY…”Së©äâê«`³©³«ÛË³ª',
                'c•³®˜Õkío³­€â÷™ù³®ìÌ³¬ân¿ž ŸêË³²Žz³¯à}R³°³±¸JÁVÞC³³³´±|Ÿ·ûžŽlžñéÓe³µÜ‡íº†qÇp³ŒÍ’³¶‚®“Ýåø³¹ÛåÞŠŸEÂs³¸³îJØ³·³º„ï²u …ÞÓ³»—²è¡àÁÕ€Ùo³¾³¼³À³Á³½³ÂÆå·ŸGÇk”³¿ÔHÚÈ',
                'c“ZŸ‹Êc‰m˜¹¯„ëÏIÖRËlû‰•æúmÚ’³•í×‰}‰ö´~Û{Ù•´³³Ä¯M³Æö³³Ãé´·QýYýZ‡¸ÚßÒr×êp›„èß —¢›Õ‚ òÉîõ ª¬bÚW‘r“£ìl“Î³Å¿B˜ûîªÚXîd™f¸V·Ï|çdçpð‰Ø©³É³Ê³ÐèÇ³ÏàJ³ÇŒkw›“Ç^³ËÛô’¬¬A’Þ',
                'c·œÃ”îñˆá³Í—–—¼³Ì¹f½†ñÎëó‰SœË³Õ\®—õ¨ä…¯³Î³È™rõ“žj‘Íòr‘³Ñ³ÒŽñ±òG³Ó³ÔŠw–oøßê«ò¿ð·®Eí÷ó×ÔWàÍæÊ“¤³Õ²ló¤ø|ùA°V÷Îýc”~üJ¯ü[³Ú³Ø³Û³ÙIÜÝ³Ö¸‡ÇKœF¹MÙPßWñYÜ¯õØóøÖs³ß…µ',
                'c…ÕÃL³Þ…q³Ýˆ‰Ãnu³ÜÍNôùšIšnÑlãrñÝýXáÜß³³âžÃ³àâÁ’x„Èp³ãÁ‹³áë·ŸU¯bà´œ‰ÙÑ¯vÄSãMë†‘yÂ@ßo‘Jñ¡ÂBŸë‘´Ú†ð„ùúu³ä³åâç›_Üû›Ò«–Áˆô©†ü“›‘oã¿ÐnÁZô¾ÛŒ³æ³çƒê™³èï¥ã|³éñ¬ºN ß â³ð',
                'cÙ±àü–äã°³ñÇ“³ë½[³î°{³í³ïáO³ê³ìël‹á‘À böÅ® ÜP×‡×‰³óE…Á–„‚G³òáh²ƒô{³ôßcšŽ³öŒç³õ“¹éËØŒýiÛ»³ý³ø³üÉZØa³ú˜ZÂaÉeòÜÚn³û ËNºX³÷‘ÃŽÐ™ŸÏ{³ù™»õéúRÜXèÆ´¡—Æ´¢èúµ—³þñÒéƒ¦™s­l',
                'cµAýsýƒØ¡„I´¦¸aâð’}ç©ØX¸e¬G½I‚â¬`às´¤´¥ÛUézƒãÀ™[”ßšbÄ•÷íÓ|´£ÞõÄu´§à¨àÜõßçÝ´¨ë°´©„”¬´«ô­´¬‡ùå×´ªšN•ÄÝŽâ¶ÇF´­ƒbšö´®«[îËâAÙi„V´Ñ´¯·™´° ¡“œ §¯¸R´² —‡l‚ü´}êJ´´âë„k„y',
                'c„€í´µ´¶ý—´¹–ûÚï´·Ç”é¢é³´¸åNîq•I–~´ºÈN‰@‹a•«´»˜‡¬t¹—òí˜ê™šöjùœ´¿ê´½›ÌÝ»´¾Ã‹ Æœ÷ÉOðÈ_´¼ácõž‚¤ÈoÃ²QÙƒÛw´ÀõÖ´ÁÞuŠÆ·›í´ÂßOê¡áQ¾bÝzöº“ó´‡šf‡ÇýpèqßÚ«u´ÃÚe‚½´Ê«yˆˆ–²',
                'cìôÜë´Ä´ÉÔ~Þe´È®N´Ç´Å´ÆðËôÙÞiï“ð@‹ãžBøyµQÞoú\ú]´ËÕ°r–c´Îè´Ì„pŽãÆ˜–æÇ„½aÍy´ÍÎˆÙn†ï´Ó´Ò‡èÜÊòèÈÆ‰S•Ÿt´Ð^Â‡Ê[æõ•¾˜Ú­Bè®ÂŒ´Ï²jºbÂ”ÏZÀSçWò^ò‹´Ô¾ŠæŒQÀ›äÈçý‘FÕpÙz',
                'cÙ{˜âËq…²žš™ß Ö´Õœé¨ëíê£Ý´ÖÓcû€û‚û›áÞéã´Ùâ§‹{¯|ÝýÕKÚu‘–´×¯•´Ø¿qõ¾üyõíÜAî•Ùàß¥ïé´Ú”xÜfè‰”e™«Žm´ÜŸä´Ûš–ºx¸Zìà´Þ´ßƒþ‰…‘N´ÝéÁª‰´…çJtyè­°„õ¯QÁŒÃy´àßý†Ÿã²´ãÝÍë¥Ÿn',
                'c´á´â´äÄ‹Äƒ¸WÒPÄ›ß—´åñå´¸€´æ„Yââ´ç»v´ê¬›ßu´è´éõãáióqÌ‘áÏÕðîïóÉcõºûzý€ëâ„v„zØÈ‰è´ìÇsÇu´ëßH— ï±Éx´íäSØÖÉ²ÐóÔøëúå¤æöôÒ',
                'dÔŒÒbŸíÖŠbÍBˆkÍhÚdÛL“_Ñnƒ‰ŽÎº@“€åTÛq…¼…ößÕÞÇ®†´îàªñ×‡}‰¡´ïæ§âòˆ™žØÁeÇQ…AóÎ´ðÔzÛQ´ñ÷°ËR÷² [ÀJÏƒÜJèNý‘ý“´ò´ó‡±o™\´ôªy‘·´õ´ö´úšùÞaþˆ‚á·Ž‘ß°çªåÊ´ø´ýµ¡–±´ùçé´ûŽ¡ÜÜ¤',
                'dŽ§½H´ü´þÝD¬x…¦•Î¿Dõ\øl´÷Å•÷ìº‰žŽìOÒyì^µ¤Šlµ¥µ£íñ³NÂnµ¢µ¦ñõÜl‹[ééð÷…SóìÑàîFÙÙ„éš—ÒRº„Â›„[ ý«m­µ¨Ðyðã¼µ§ñdÚü^Ä‘µ©µ«Ž›X›µ®–½¯Dà¢†›µ¯µ¬µ­ÝÌµ°†²µªÄEÍžÓg·žÕQ‡nó‡',
                'd‘„‘žå£¶Vñšø}®X°Q‡·ÙœìKð…µ±«šñÉ¹Y®”ƒ}‡ŽÇ­cÒdºšÅ™Ï}µ²µ³ÚÔ“õ×[žª×•šëÛÊˆWå´í¸ˆ›µ´µµÝÐ®Gë‹´X²^Ú‰³™n­T±UµDµ¶ß¶Œàâáë®Åsá’÷ô€’Òµ¼µºê‰µ¹uµ·µ»µ”“vëIëì˜˜Œ§ëZ‰»ŽW”Fµ¸¶\',
                'dµ½µ¿µÁÈK—Í±IµÀ·R‡‹µ¾Ðm™|ÐpÂRÜ„­ôîzµÃ›úœ¿ï½‡NÔµÂåuµÄ“g’O’YµÆµÇØOàâ‹¿Ÿô­O¸~ô£Å˜ÓRµÅµÈê­µËµÊà‡ëQ‰œáØµÉíãïë™žç‹ªµÍµÐ”†¬ˆ¹ôÆêµÌÚhàÖµÎïá´”íLçCfµÒÃJÙáÆmµÏ†vµÐµÓ',
                'dÝ¶—bµÑêëì{œìµÕÊHÊLîEô†”³‡”Ë‹Øp¼eûMØµ…}Ú®Û¡ês…àÛæµ×~µÖèÜíÆ’ãÇœÝBÂ‚÷¾öWµØµÜ•A–m«ZK–š‚dµÛˆ¯æ·µÝÞž‚±—\Ÿb±ƒµµÚÇ…ÚÐâKé¦íûµÞµÙƒC¶EÄVãdñV‰„‰—íÚÊO‘d®S¾†ŽRÏEàÇ”“µà‚Ù…ŽÑ',
                'dµá˜•¯’µßÛ†áÛñ²ŽoŽp”„°dý‚µäŠHµã‹L”¥—ÏµâÉ_ÊsõÚµçµèµéÚçÛãµêµæ‘úçèîäŠûµëµíµì¬UµîÍŸëŠ‰|‰«˜ëÕµå´ñ°ô¡ò›µóµðšô„aÍ@µòŠP‡¬Íq¬hõõµïš“²fµñõMöôºyü—õ ùmŒÅt®µõµö·–ÓŽµôážîö',
                'dây¸uäHë¯š¸Lä”èSµùµøÒBÆ|µüÛìUgÀ„Ã]ð¬±yÂW‘äµýÜ¦Ž²Þé®’½xñóÔeµþšŠ šëºéPÞµúÎHÑÅŽµû®õÞöø•è¯A¯BšÛ‡Ã¶¡Øê¶£ŽŠçà®kðÛ¶¢¶¤ñôôúìw¶¥í”¶¦àËYç–¶©ð—³G¶¨Ó†ï}à¤Èb—ÅëëíÖ¶§´OÂˆ',
                'dåV´îrG¶ªîûïMäA¶«¶¬ßËá´–|Æ{•kë±‚”ð´ˆÄŠàž›ò¸•Ç‡šæÎXõ[üŠöCù…úH¶­‹Ù¶®¹šÊÕ‰¶¯¶³¶±ÛíŠŸá¼¶²’œ¶°¶´ëËÞ“ƒö‘ãëØ„Ó–íÏ—ÄLƒPñŽëš„r†t¶¼¶µƒÃÝú™XóûÅ¶·cêh¶¶¶¸ò½â^¶¹àK›ÃÇW¶º',
                'dðôY—uÃ–áH¶»ékñ¼ôZðL”ÔêL¸]ô^ô`ôaà½¶½á`¶¾›è¶ÁäÂèüë¹¶¿ÑtÕiÎ}ªšåL„E…X‹óž^™³šœ © Ù­{°òy÷ò×xØKÚGí~÷Çèoíbíüt×˜… ¶ÀóÆ¶ÂŽª¬o¶Ä¶ÃÓGÙ€ºVÜ¶¶Ê¶Å¶ÇŠ¶ÈÇT¶Š¶Éì|¶ÆÎ–š˜åƒÐCó¼‚Ç',
                'd‹e¶ËæH¶Ì¶Î¶Ï‰F¶ÐÈ˜é²ìÑ¬‡Äa´V¶Í¾„š¬óýå‘”àÜY»f…¶ˆŒ¶Ñ‰[Å¯yîXø‹çŽ¶Ó¶Ô¶ÒŒµqí¡êŒíÔ½˜Œ¦í­žAËcïæ‘»ž}×Bç…×m¶Öª¶Ø¶Õ‰•‰Ý“æª–‡“Ç Ôíâ¶×ÜHò—íïõ»ÜO¯ãçìÀ¶Üí»Þš¶Û¶Ù¶ÝâgîD´]ßq',
                'd—Ûv¶àßÍ¶ß„„“šÇñÖ‡š¶áîì„‹¶Þ”Ÿ”£”­¯kâ‡ŠZ„AõâõyèI¶ä–\ßá¶â’–’—ˆÊç¶—ÙÚrÜo¶ã¾EôD‡¾„m¶çãõêwð™ˆ‘Œ¹–ú¶é¶æ¶èÛFÛG¶åï˜ü‘†‰šùzÚàØéêæï¢î®îúâºØ¼',
                'eŠâ³jŠŠŠŽŠãåí¶ï‡êÞˆ¶í¶ð¶ëk›áÝ­«Óž°x±“âeï°¶ì¶ê´dÕMîP¶îî~ùZù[×F–•³Sæ¹òFùE¶òšx‘öêißÀ¶óÜÃêq…Ù³Xéî†@ÛÑS„þ¶ñ³bÍL¶ö‚­…v™³rÚÌÜ—¶õãÕˆñ¬ãµœŠÝàØ`ÝQß]¶ôŽþ“¬cëñƒiÎYïÉðÊÊ‚',
                'eß{îOò¦ðIØ¬”AÓFÖ@ð_åŠöùšdî€™Äötù˜×†èyý|÷{ŠC¶÷ÝìWÞôíE˜s”ñ¶ù¶øõêzX›˜ÇH–éÃsÑLð¹»•Ý[öÜëXó’õbøÞW¶û¶úåÇ¶ý¶ü–êš¾çíîïðDñ“ËnßƒÚ¶þprÙ¦„n…þ·¡Ù@Ð^ÙEÔ àÅßíÚÀ',
                'fïT‰ü–ív–DîCˆóÙSªŠµpˆ©‚¿Ã^ÙH•\±}Ð““Ü–ÂÒUÅx·¢›o°k°l‘óŠ˜ìáe·¦·¥Š‘ÛÒ¯V·£·§–ì‚ë·¤²XÁPéyÁUËtá·¨íÀåzžž·©¬móŒ·«é·¬„å‡h‰“‹Ìá¦‘Œ”ó”õ·­·ªÞNïcïx÷Y·²„F„G…K–i–¯·¯»o·°Åt·³Åw',
                'f¹BâC—¡Ÿ©¾u·®Þ¬˜õìÜ­[ËX·±ÒT¿œÁ€õìž’µ\ÞÀçxÏ›ú‹·´¢’BÞx·µšï·¸Šišø·º·¹·¶··î²ÓŒÜèó±F¹DØœÝGïˆï‰J‹Ë¹ ‹Ñž~·½Úú·»·¼èÊ °îÕœEÍKˆÚâ[åpøh·À·Á·¿·¾ˆªöÐô™·Â·Ã·Ä•P•X­œ±f‚”ë¼ô³',
                'fÔLó„úJ·Å·Éåú·Çïw·ÈŠóŠôœdç³·ÆìéªUìqÑq¾pòãö­öîð[ñIòWòaöEïy·ÊäÇ•›ëèÎNÏn·Ë·ÌŠOã­ì³—’é¼ôäÊ„Õuóõ·Í·Ï–{·Ðáô·Î•h·Ñ‚n„|…Š¯XŒÐÈQŽüÙMðòïÐUÊ†•Õ°Cü”žO™¶çšì]·Ö·ÔŽŒ·×·Ò•S·Õ¸j¼Š',
                'fÁ‰—±ÓŸÜm·Óâpëƒ–Bðið·ØŠ}Œð·Ú–ŒžÇÃR—rÁiÍ_Í`èû·ÙÉkñBëV‰žŽËÊˆôšøX™JŸøŸþØk÷÷Á‚ü‹ØrÞMèMñOüR·Û²büv·Ýˆek·Ü·Þ¶lÙÇ·ß·àƒf‘Š^Ä¼Sö÷å¯÷a·á·ç§„K„NŠ~ãã›h„O·ã·â·è±`í¿ïLo·å‚ª',
                'f—Q·é¬S¥œtœ½ªhÝ×·æ—÷ È·ä¯‚´^ƒtºAà•äh™lØSæ‘çQÛºŒ›ž–ìbïpüK·ë’¸·êˆù½ ·ìÅ‚¿p·íÒƒßôÖS·ï·î®gÙºœ˜ŸuŸ‘ÚRøLøPøiÙˆÌX­žÒ…–ˆu—‚¼€ó¾·ñÀŒÀë€ø]·ò¸ß‘ß»Š•–Ž«c·ôN–´³QÇCÐuŠÂÇX”ê',
                'f¼”õÃáKôïïûõÆâa¹[½š·õ·óûŸ¼JüAüF‘ÊT¸¥·üÙì®iƒì„_æÚ·öÜ½Æ]ÜÀ…ò@Ž“·âö·÷·þ›Šç¦ç¨ÜÞÆ…·ýˆŽ–¢–Á·ú›šžÞ«s®t®wìðî·ÜòÛ®í‚øI†b–ó¸¡®}íÉÝ³ò¶Ùëèõ¸¢ŸJ¬M·û¹A¼›½EÁåõÝÊÌ’¸¤·ù½nÁJÈƒ',
                'f¸£»™½•Å€òÝ·øãRãVïOøD˜_·J¹…Ñ}íhá¥ºòðó‘øqÖDÛ~Ý—õH¯žõvíêùfù›¸§¸¦¸®}ÞÔ¸«‚YàM¸©¸ªáœ’Ñ¸¨—ÓŸr±G¸­äæ¸¯Ýoº…íë¸¸¸¼¸¶¸¾¸º¸½¸Àˆ}¸c¸·æâ¸´µyÓ‡Ø“¸°ÍbÐ•‚¾ƒå¸±Šï‹DÍk¸µ‹c¸»ÍÈiÍ|',
                'fÒ„Ôc¸³—Ú¸¿¸¹öÖ¶OÑ‡êç¾”ÊÎlòóÙxñ€¿`Ý•õVÙŽå‡å˜öû¸²ð¥övªgë¶áë',
                'g«qérøWê¸Ù¤‡QîÅæÙ¸Â¸ÁåmæØ«VÞÎôp¸ÃÚëÛòŠ¡YÇD•|êà®„µ‹Ô“ØdÙWÙ^ã¸Ä½iæYØ¤_„÷„ø–q¸Æ¸Ç¸ÈÈ‘â}ê®¸ÅÉw˜¢˜£[­y¸É¸ÊÆQÞ|¸Ë«\¸ÎÛáãïÜÕ¸Ì¸Íðáôû»ˆx„QŒ¼ÞÏ¹mlŒ¿ŒÀôv°‘¸ÑÐr¸Ï¸Ò¹C¶’',
                'g¸Ðä÷ÚséÏß¦º•÷ ÷hêº±Yí·ç¤‚‰ƒ÷äÆ½CÔló_ŽÖ™g¸Óž¸¸ÔÀ ƒé¸Õ¸Ú¸Ù¸ØŒù ±¯I¸×¸Ö„‚î¸ˆÕ’ââG—ž Âˆþ¾VÀ“ä“æs¸Û¸ÜŸ€óà˜í°¸Þ¸á¸ß°wó{éÀØº¸à˜°™R¸Ý¸âðp™²ízúküŽú‰ùê½Ç¶Ž¸ãçÉéÂªˆ¸å¸ä',
                'g¿cÞ»™…Ì¸æ„ÆÚ¾Û¬zµ†µ‡ï¯¹l¶JÕaä†¸êÛÙæü‘á¸í ·¸ç¸ìñË¸ë¸î¸é¸èœð‘ëéxømøw”RÖgøæŠ…Ïà„ý¸ó¸ï”š¸ñØªÍÅZ¸ð¸ôàÃÜªœèÓkë¡˜†ëõéwïÓík÷ÀÖYõs™ íuÞPíRòZöÛÁô´¸ö¸÷ò´‚€íÑ¸õ¹wª˜¸ø',
                'g¸ù¸úßçØ¨ôÞÝ¢“^“j¸ü„j¸ý®u›Ê¸û’ùÈ@—ÔŸ‰½câÙûf¾¿KÙs¸þùˆàQßì¹¡y’ªç®¹¢Çc¹£½Žöáóiõ†ƒˆí†¯†Ö†ñ¹¤¹­¹«¹¦¹¥–r¹©¼këÅ¹¬Œm¹§ò¼¹ª¹¨…@‰bŽ³ö¡Üp…C´bó•Óyý¹®¹¯¹°’–íçîÝ\ì–¹²¹±Ø•‘E',
                'gŸËƒÀƒÅ¹´Øþ¹µ¹³ÐçÃâh¾—Ñóôº÷¸íxá¸¹·¹¶èÛ«vÂTÂVóÑÂUØxˆx¹¹Ú¸¹º¹¸Š¥Æ™ƒÚ¹»‰òÔ_æÅì°“kåÜëgŸµêí“ÂÓMÙ¹À¹¾¹Ã¹Â¹Á›}–¾éï†f†gÁBð³¸š¹½ÝÔòÁÉuõýÝLÝM¹¼ôþì±¹¿¹‡‹²ºH™OõYøÝž÷½¹Åãé',
                'gÚ¬¹È¹Égêô¹Çî¹ÁlßEîÜ‚ï†˜Ã™¹ÆÍvŒ½ë³‘Ôbð ˜€¹Äü‰ØÅ˜b°–·Y¼MË[žJëûðkžk±Wî­¹Ì¹Êƒó¹ËˆØáÄèôêö—›µ¹Íðó¶™ïÀíƒlådöñöAî™¹Ï¹ÎÆ‚ëÒð»šOŸ…Ÿ°ïN„œ¾ äTøŽòmƒÖ…³ßÉ¹Ð„Ž†§¹ÑØÔˆqÚ´¹Ò',
                'g’ìÁGÁL¹ÓÔŸ¹Ô¹Õ–¡–Ê¹y¹Ös¹Ø¹Û¹Ù¹ÚÒ‹ÙÄ¹×ÉF¸A¯°HÓQ÷¤Ó^÷b¹Ý¯p¹`¹ÜÝ„Åoå]ð^ÜIøAš¯¹á›Œ¡¹ßÞèäÊ µ‘T“¥ßk˜ÀîÂÀ•æš¹à ƒ­µeðÙ¹Þè…÷}¹âž»ïžÓžÕžÖßÛˆŠ­ÆšèæŸD«‡ë×ƒZÝ_ã üU™õ¹ã',
                'gŽÚáî‚U¹ä“Ñ¹é¹çæ£¹ê¹æßžð§Æ—¹ëŽ¢«•w¹èÑO‹‚—Ë¹åàF“±é|öÙ‹¾˜²˜³­Y²nôh­„™Íå³¹ìâÑæØÐ¹îê{ˆ’¹ïÜ‰¹íŽëµƒ…QêÐœˆÍŠÓmÔŽ…‘óþÏj¹ôØÛ”Š¹ñêÁ”‹¹ó¹ð—Î¹KÙFÉ}¹ò²Z„£„¥“Ê˜­¶Wºl™™÷¬÷iÙò¨',
                'gçµÐ–¹õ¹öÉ€LÊFíÞÝöçõPõ…¹÷—œ²O­eÖßÃÛö¹ù†©áÆñøâu¹ø‰¯†‡H˜òååœ‡ë‡î‡ñ¹ú‡ó‡øàþÞâŽ½‘I“XÂƒÊbë½Ùå¹û«›ýâ£Ç‘ðŸé¤Ñx˜¡¾[òä¹üðRèJ¹ýèí¿©Ý¸ßÈ',
                'hðgœWØhØm‚sÄD‰™…Åô‰ í›Íìà@½wå”œ—U›N˜oÅVæ€•± ç’š¸ò…šã†yÁ‡ÔúX›üðÀâ’¿Sù]HÚo‚ëq›²Ò^íW¾iÄNÄs¼@Ý{ß^îþR¹þàËº¢º¡º£ëÜŸQ‰háVõ°º¥º§º¦º¤†ãï™ñ”ñ›‡¯ðŽaƒËÎñü†còÀº¨í™ØE',
                'hº©ñHõA÷ýÚõº¬ºªº¯„TÍH†i‡öŠÎ›¿—êÏ—cº­ìÊº®²º«®]¹b ’ÎK¶äwín…{º±›Èº°ÊGØJô_ººŒå’Iº¹ê\ºµˆ¥º·º´•~›ÛªRÇt•ˆº¸¬HÝÕâFé\°y±Ž‚þÍ”ò¥ÞþÎL•ÂäIädº¶º³º²Î‘îhîuòAënå«ú[ôŒÆf”ãº¼ˆœç¬',
                'h¸‘º½ÍañþØ˜¹V½Wî@ãìÝïàãÞ¶¸hòººÁ—·àÆª|‡sºÀ‡_ª‚ƒŸ•Øº¿º¾å©»DÏ–×qºÃºÂºÅê»•a†ShºÆºÄ•‰œB‚Ûð©Â|Ì–•µ•¼»°€°‚°…ËA°ˆò«å°î—ö‚ž®ƒÁÚ­ºÇºÈÔXàÀÏšºÌºÏºÎÛÀ…ôºÍŠºÓPêÂ–­±A»tºÒ†Y”—',
                'hºË±BîÁºÉ† ºÔœzºÐ¶…ºÊÈMý†²»—ÔZò¢—æÔ†ãFãØ÷…Ÿ¿éuûiû¼ºKôçôŸêHý[Ò‡ùŸ°èYý˜Þˆ†ºØŒyŸZœ¸ÙRŸŒ´EºÖºÕº×ÂGÛÖ°F eúQýLìeìfûSìgü\ºÚºÙ¦‹Ï’‹ºÛì•äºÜºÝÔ‹ºÞºàºß›êÃ†Š¬aºãèìžî',
                'hçñÃtûaºá™Mºâø’ùCÞ¿èUˆý‡ÖYb…·ž¿ºäºåÙêºæÜŸŸp³…Þ°Ý“‡«åÞZ›ºëŠkºì…Æºê›K«YÀ€ãÈŒfãü«aÆyˆ˜Š¼ºé¸fÝ¦ºç›Ä¼‡ÁŠÂo³{¼˜ØAºèœ|¸s»ŽÈ‡Èˆâvéb½“ÁØD~ãpìô„ºCäfšÞ®ë”ÙäëŸø™üZ•{†ß',
                'hÚ§Ó“Ðµ¹äUºî³@ºíŽ«ºïÈ‰ðú²Tóóô×ÂF÷¿æAðfö\ºð êºóàCºñˆ‹áá›•åËºòàjÜ©Ø_ö×÷õ`÷cºõ…Iò®ºôˆ~ºö•U•÷›~Æ~ìÃéõ…Oßüã±œXÌÜ ëŒ‡FŒŒäïëišXàñ’_»¡ºü®@ºúºø‰ÖõúŸW†¼‰Ø‹|ºþâ©½`ºù—ýìÎ',
                'hº÷‡PÊSðÉéÎ¹”ºýºûÐkô–¿eÎ™õ­îgì²æLðbž€ôEö{ù–úCúK[›R»¢ä°»£ÈLçúÌ•¹}åtöU»¥u‘ô»§‘õÙüƒêŽ»¤›Z»¦á²âïìæ•O–ìïóË»‡Šýìèð­½œà‚‹¬‹­“ªœûÊd˜«ŸÚøUºnåð××o÷Ÿí_í’÷sûI»¨Æ_ˆµ‹N—É³“',
                'h¼AÕjåkÌf»ª»©Š£æèîü»¬»«‡W“ç­LÎ”çfò‘ú†»¯»®–»­»°†èë‹O®‹‹Ã®“Ô’„“®˜¥˜å‹½±Õ–Õ üXÀEÌs»³»²»´»±Ñ‘õ×‘¯Ñœ‘Ñ™ÆÂjÌx»µ‰²‰ÄÌ|»¶šZøb‡È‘×âµšgØŽ×’óO»¹»·`ä¡ÇB»¸ÈPÝÈˆâŒ~½bëfÁvØ}',
                'hïÌêaå¾çÙ­hØoæDûq¼]ÀQÞSêX÷ß±»º¾”k»ÃÛ¼ÃKŠJ»Â»½»»ä½»Ážð»¼—h»ÀåÕ†¾´Ñ“Qœo»¾Ÿ¨¬~»¿äñ¯ˆ˜¬öéß§È²oËõŒöZödŽxëÁ»ÄÐY‰E»Å»Ê‚µ»ËÚòüS»Æ†Åˆð‹h¢áå»ÌäÒÈåØ˜R»Í¬‰‰ŸäêªéBŸìè«',
                'hóòÅŠ»Èñ¥»Ç·kÖW»Éó¨å–ðcöüÚ‡çuòböm÷UúŠU»ÐžêŒr»Î•sŠN»Ñ»ÏéÔ…¿mÖe™¤°ŒƒÆœê˜n•Í°æw»Òž¾Ú¶ßÔ»Ö’’»Ó›‘ò³êÍŸFçõØYŠî‹^“]Áš»ÔëD•Ÿ—ò¬qµ˜ÔœŽ¹²N‡j‡vÂEÝx÷â»ÕãÄž`ö™‡ß»Ø‡éÝhjo',
                'hä§ÜîÞ’ŸCßD¯`»×ÍzÍ õt»ÚÎšš«™m S×e»ÜŒá»ã»á»ä›xßÜä«»æÆUÜö»åí£{»â»ßåç»Þ»àà¹»Ý½}çÀÁ™ê_…R¡¢š§»ÙœóÔÙVƒa‡GÊ]ÕdˆHŒ“»Û‘}•Á˜žŒÞ¥Ú™Bª›­_ËCËDÖMî_™b™u Zº_Ë™ðd‡¤‘Î²~·xÀDó³',
                'h™®ÀLÂP×MêTçžìu×wîœ»è•e»ç»é›÷ãÔÇ—•²E²Jé’ù»ëâÆœ†»ê¿Œý@Ú»‚[‚“‡õ’ä»ìŸkäãùÓoÕŸ…¿ñëïÁØååx»íß«òdå»î¶»ð»ïß˜îØâ€â·›[»ò»õ…ü‚i’»±n»ñ„Š»öØ›»ó”üœ­µœ†ØŠ_žC«@»ô™ŠÖf·‚ïìàëžm',
                'hÂhÞ½ó¶‡É•ëÅG°\²‘èZ‰þÐÐí¹à÷',
                'j°nóp®‚¹kºu¸’Ò—˜È¼‚eäzërÌŽÕ‘ˆôÏ…Ó]Æ–Œï¼vÑ\˜‹ïW‰ø…¨«EÅSÅQ•Q÷ZŠoˆðš¼tùJØ¢¼¥»÷„Wß´¼¢ØÀ„Z»ø»úçá¼¡Ü¸í¶¼¦–ˆßÒ¼£ØÞßó¼§åì»ýóÇï|»ù¼¨†À³ïúê÷¹U¼©êå„Þ†æ»ûõÒøKƒ_»þã‚‡\“Ä˜œ˜Û',
                'jçÜ»üÙ}Üuì´ÛÔ‘¢™C¼¤­^·eåZëY´‰ºs¿ƒî¿ÙŠ™›Âfëu×Ií‡ù×^°^ÜQíZúaýVÁaÌ~èWÒˆèiýWÁbûAÒ‰‘¼°³¼ªá§²î¼³¼¶¼´¼«Ø½Ù¥àB…u…¯Š ¼±ªE°uóÅ¼‰“V¼²Óf‚Â…hŽóÃØCê«¼¬˜Oéêœ–¼¯‰J¼µêé®ÝðÎa',
                'jÚl¼­˜ŠÂcÄlãšŽNñ¤¹œÊmÞªì“ûn™W™vÎŽÝ‹ÒQÛˆå‰Å¼®ÞUçgìPúWúnë|ë}¼¸¼ºMŠj ä›‹ò±¼·¼¹Þá÷‚Ž×êªáÕ÷äô‡“Ø”D·mŸ”ú¼Æ¼Ç¼¿¼Íˆj¼Ë¼É¼¼ÜÁÆa¼Ê¼Á¼¾ßâˆ…c¼Èä©¼Ã¼oÆˆÓ‹„ˆ¼¼ÌêéÓ›ÙÊ¼Å¼Ä',
                'jÂ¼Â”û—m¼À¯ÅUÈ—ƒÎ¯s¾@¼»Ñ_ÛEëH‰€ôßPT¶I·I·bÕHõÕö«öÝ•¸ð¢Õ‚öê¼½„©•Ì·]ËEÒH÷Ù™o¿ŽÁYÓJõJ™‹Û”ùHýT^‘Õ°U¼_ÌRæ÷õŸž†À^Ìn÷DÌzìVö›÷C÷qóK¼Ó¼Ð’z¼Ñ›våÈ¼Ïš¹ä¤çì¼Òðè—kóÕÂ_ôÂªoÝç',
                'jõÊ ÇÄ`ãe¼ÎïØ¼OØjØ†æ‰û“ˆ]’SáµÛ£¼ÔàPí¢Çvê©îò‘æòÌ¼ÕÍÛOïäeî]îaø”ùG¼×«wëÎ”Ï¼Ö¼Ø‹T”Ð—ÝÙZâ›˜\˜–ðý™x¼Û¼Ý¼Ü¼Ù¼ÞŽ·˜k¼Úñ{†íê§¼é¼âŽÔ¼á¼ß¼äƒï‘â¼ç¼èŠ¦Š§¼æ¼àˆÔ½ª\¼ãÝÑÈGäÕ  êù',
                'j¼êÈ‚È…égÞö—ß¼å¬{²RçÌÝó¹{˜ÙŸÒ¾}ÊzÊ—öäðÏŸæº]¿Vä’ÆDíKñJû…žh÷µšµMÓVùpžŒšž»Wí[öž‡ØÌ‚ídàî¼ðèÅ¼ó¼í¼ë‚›’³¼ñóÈ¼õ¼ô¼ìœ—õÂ’þ—Êœpíú¼ïñÐÔdïµ¬‚¼ò½€ÚÙ”‘ìê¯¼îƒ€ôå™zËuÒMÒOåÀå¿',
                'j²€º†ÀOÖˆôCörûxžÏ•ç‰ç™û{×vÒ}û|¼û¼þü½¨½¤½£›–êð¼ö¼ú‚k½¡„‡½§«…½¢„É½¥ÚÉâVŒ{”ðé¥ë¦½¦ëìÅ[¼ùÙ`¼ø¼üÙÔ˜c„¦„§‰¤¾¼ý¼GÕÙvÚ{Û`õÝ„ª„«™ZË]æIðT²{´´–ÏMæG”W¿ ÓSÅžÞYèaèbè{èƒ½­',
                'j½ª½«Üü½¬®{ôøÈwÁž½©{Î…‰¬çÖËK™^š™ÏQ÷š®Ÿíä½®ÀPí\÷F½²½±½°‚×½¯ŠXŠ\ÊY˜ªª„ñðÄvÖvîŽ…G½³‰áx–t½µä®ç­‰ÑH½{®–½´“À@Úêñ¼TánôÝáu™ºÖ˜Ü´ÆL½»½¼æ¯½¿j½½Üú½¾½º½·½¹òÔõÓÙÕ†ýÌ—öÞ‹É',
                'jõŽB‘xÄz½¶Ä‰½¸·põoðÔºŠÏtç€ú„úŒ™ËÅT½ÇÙ®ÞØ½Æ½Ê½È•w¸‹ð¨½Ã½Å½Â½Á¹R½Ë„àë¸Ÿ”Ä_Ù]“¼•¯Û]ãqïœƒ‚„¤“èáè”º”¼½É•Ý­d³C°‰ùa‹ùÀq”‡ž«÷R½Ð…Ó’›ÓŠ«„½Î½Ï”œ½Ì½Ñœò†û‡U”Ò]½ÍàÝ‹Ðª—ËŠÚŠÞI',
                'jõ´×_°á†½×ðÜ½Ô½Ó’÷¯^½ÕëAà®àµˆê‹m½ÒÃ½ÖŸ®·MìŒÎf“ø°Xù™æÝŒ¨½ÚÚ¦„f„g½ÙŒî•M„o„Â½ÜÐwÚµÞ×½à½áÞ—èî—AÇ}Ó“æ¼›½ÝÑK‚Ü½Yò¡Ë˜Pœï½Þ¹ÍÔ‘ã]ô‚½Ø˜míÙ½ßÉ•öÚôÉÕmÛdŽÑŽY”Oµ@æOŽ^™Ã',
                'jÏÏ˜ÐV½ãš²‹d½âï™wN½éŒôŽàð½ä½æŒÃ½ì”â«d½ç®v½ê³VÐ|½ë½èò»Èˆû—ô¬pÍŽ÷º ÏÕ]Ñ›ô½å½í½ñ½ïîÄƒ»½ðáŽ½òñæ³\ñÆÓb«ƒ¼Ž®¬Qˆü¬n½î­\ûvüT½ó½öÚáŽ„½ôÝÀÇžƒH½÷½õ‹¦âÛW±M¾oÉ“âËéÈèªå\',
                'jÖ”ð~„³¾¡¾¢æ¡½ü½ø‚B–‡„Å›»Ý£•x½ú½þ½ýêáµ‰ßMŸ¥çÆŒƒ“|œÃ½û½ù¬’ƒq„Bšêîƒàä¿NÙ‡ž‰½‹âøË| a­nÓPÚBý„ˆi¾©ãþ¾­¾¥Š¶p¾£ÇGŠù¾ªìº”ìªS½UÝ¼¾§¶“ëæ¾¦¾¬½›¾¤¾«Â€™Y¾¨ùXöLù~ûü ó@û—¾®',
                'jSÚåØÙŒc›G›HëÂ„q·¾±¾°ÙÓŽÁã½­E‘ •Ç G­Z­`îiÏ‚¾¯Šn¾»åò¾¶åÉ›·ëÖƒô†½¾·¾ºÞŸŠøæº—J—}œQ¾¹¸x¾´¯d‚ý¾¸¾³â°Õe¾²îK•ß¾µìožsçR¸‚¸„ƒÕˆsìçˆ·½Nñoñ’ÌSƒ×‡ååÄ‚C¾¼Þ››ÓŸKŸ ¾½ïG½ŸƒTŸ¡',
                'jŸâ° EÑ•ÌWL„ó¾À–`¾¿¼jð¯¼môñãÎÈ\à±¾¾“[÷Ýôb¾Å¾ÃX`Še›C–w¾Ä¾ÁÅi¾Â¼‘¾ÆéNíƒ…E¾É¾Ê¾Ì¾ÎèÑ–Í‚wèê¾Ç¾È¾ÍŽý…B¾ËÙÖGH‘Wš”ÅfðÕöJû…Yýnú™ã„H’]„û¾Ó¾Ð›t¾ÑÜÚ¾Ô‚˜’±¾Ò¯YÁDêŠÛŠè',
                'j‹J‡Þä—x›ôé§è¢ÄKï¸ñÕöÂÅ‰ÎAÕ‡Ûgä|ñxø~¾Ï÷¶ù‰¾Ö›†‚I ó½ÛšÁœHŸh¾Õà`—»šÆœ¦ ÊÝ]»Üvé…éÙ™hñùVÛžùqŽeÌ^úGóM¾×¾Ú¾Ù¾ØÜì’¤—º¹_é·é°ÉXö´Â‹Åeõá”H™Î™ÛÒz¾ä¾ÞÚªŠŒøþ¾Ü›®ÜÄßš¾ß’‡•Z',
                'jšj¾æ¶€îÒ¾ãÙÆƒâ¾ç»‰Â`ÍiÐˆ¿ˆÏ¾å¾ÝÔn¾àŸqêøâ ì«Ì˜Øe¾âìñÀ¾Ûñu„¡„èåð¾áõX‰±‘§“þÞåáäŒÕïZº–ÜMõ¶‘Ö „Š¤¾ê¾èä¸ÑZ¾é„æägïÔæŒùNçîÃ¾í…ÛŽ™ˆ±ÇšïÃÄ–äŸŠF„»¾ë„Ìèðáú¾îöÁ›û®C¾ìÛ²±’',
                'j½vÁI²C‘gÊ^ðCÁ\àÙ¾ï“ÞŒÖŒØ|ŒHæÞ¾ö„]šÜ¾÷¾ñÆ`«i«k’¢çå³O¾øÍD¾õ¾ó™þáÈ¾ò”Çèöš€ÒõûÔEÚbÚ‘ØÊ½^½~Ò™ÚkâfØã¬œÚÜŽ@ŽD‘•ŸØ “â±¯‹Ê…Þ§ø_ø`‘‰éÓ™@éQ¾ôÄ”ïãÏpÏq u×HõêÜB½ÀÛÇÓXçžŸìßÓ',
                'jž‘Ý¾ð«Pú€™ê²Ÿý™Øè‘¾ü¾ý¾ù›JÐ‚ÜŠ¾ûÇqÍS—Tñä¾úâx´AóÞ°—°˜ÒŸãzã—÷÷åå‹õz…Í¿¡¿¤ê}ˆ­¾þÞÜ•€¿£ðž¿¥¬B®¿¢¹‰ÎDƒyŒ”‘®ðKŸóòEùQùRùUæùÐ®ÛÈ',
                'kåHÌžGóaŠR†Ë‡iãs–FÃdêl˜‚·XË›œÏ½\öŠ…jO³qVÃvÄ„šw—ëãxŠsË^òÂšÎÐŽýJm“‡ÈA´hÊy•þÒ­gðQ¶„t±O×t¼÷™‘’¹“×…Ã„ÛVñißÇ¿§¿¦¿¨ØûˆšëÌÑQãl¿ªŠK¿«Ð_ï´ç˜¿­ØÜÛîâýê]îø„P„’¿®ÝÜ‰Nð¿¬',
                'kÝa•°ïÇå|æzêGïaâéžÍ™üžý„Ñ†þæbf¿¯–Ý¿±íè¿°ê¬ýƒÝ¿²Ù©¿³Ý¨‚°§‰dÝ|¸ƒÞR¿´Ðb€‰{ãÛî«´|²™ý³T»~¿µ‹¢Ü¿¶o˜±·^¿·Ü{ç_÷K¿¸“•¿ºØø…Hß’‡ã¿¹ èãÊ¿»îÖâ‚é`åêó}”Ž¿¼¿½›Ÿèà¿¾îíêûäD÷Š',
                'k¿¿õwõ‘…\¿À¿Á¿Â ˜çæ¿ÆÃméððâÚîÝÁ¿Ã¯zÈdÝVò¤“t Éïýñ½âŽ˜}ËP¿Å˜Êî§¿ÄòòîWáfîw÷ÁµL¿Ç¿ÈÁ˜ŽP¿Éá³žÜœfº”¨¿Ê¿Ë¿Ì„w„Ä„Ë¿ÍQã¡ŠÄŒ¡¿ÎˆÑë´æìç¼à¾ÚäÛï¾´R¾~Õnä˜´žòSÃG¿ÏÃ\¿Ñ¿Ò¿ÐØc',
                'k‰¨åo‘©’õñÌÑy„´¿Ô¿Ó³n ¾ï¬³™ÕUäLå”çHŽ|g†{…ž]¿ÕÙÅˆÂáÇ£³œóíÜwåIùy¿×¿Ö¿ØìW¿ÙÜÒíî„›“²g¿Ú„¼ßµ¿ÛD””ƒãŒt¿Üâ@·óØAÊfÞ¢²]ºpúdØÚß ¿Ý¿Þ–öÜ¥‡ýÚœ¿ß÷¼õpª@¿à—ü¿â‚Vç«Žì¶s',
                'kŸ\ÑFà·½f¿ã¯‰¿áÑ‡¿¿äŠ¯Å~Ù¨†E¿åã’¿æ¿è¿çógØá“ùŽw„SˆQ¿é¿ì¿ëÛ¦ßàáöëÚ‰K¿ê÷Žƒ~à”XªœÄ’”÷¼[÷d¿íŒˆŒ’÷Åèwóy—p¿î¸T¸U¿ï„ÁÚ²ß…NßÑb›¬¿ð¹nÕEÝH¿ñ ïÚ¿Ü’ÜœÕNù\ÞÅƒ—‘ÈÚ÷ÛÛæþ¿ö¿õD',
                'k›r¿ó•pêÜ¿ò±q³m¿ô½T½_ÙLÝAãkäqà—‰¿üY‘Ç•ç p²ŽµV·ƒÀkèk¿÷„l¿ùã¦¿ø¿úÂ¸QÌêNîÌl¿ü•uåÓàkí–Ø¸à­Þñ¿ûóY‘èêÒ—ó—õ¿ýî¥òñî`™œËwåžæKòjÙçÌwÌ€Üi…t¿þŸõÍíŸÛ“ŒºØÑšCà°‹ã´À¢À£ÝÞÀ¡…T',
                'k‡]‹Å‘|óññùÂ‘Ê‰˜æš•ðrºˆÂ˜»Açqè^À¤À¥•‚ˆÒˆÜ‹GŠ‹ª^ÇÑTŸjçûó‚Ñhï¿÷ÕûdŒ±„ÎJÑ‚óˆŸã­@õ«åKöïÅCòOöHù{úAã§À¦ãÍ‰×—yµŒ³¶‘ÑX‰Ú¶Ÿ½™é€éÀ§›Ù±—À©’ˆÀ¨’•èé—I¹QÈuÈvòÒÀ«ÀªîSžNéŸíA',
                'kíp‘²ìHíTôU·i',
                'lÙû„Ð»ŒÕvã‰Œ™ŠÅˆhá”Ô›à~ÄwôfÆŒÍxækãtÁ}ºT±šÄBÌkØF¯•©“ìÖG‚Šö¦ìn ¬“š˜Í®oŒŠ¸MÀ¬À­–¬À²ÁÇ‰ååê¹íÇ“X´rÀ®Ëˆ‡ÄØÝœ¼À°“Y—ïðøÀ¯Î`ÞhÀ±Î|Ä—”j mÅDôF™Ê­†éJö_ÏžèníBÀ´í‚g‚|áÁáâäµÀ³',
                'là[‹@ˆŽòÆ—…œZª[ÈRßF—®¬[¹Xïª¹sånòQöDù„üH†‹êãíù²AÀµÙläþÙ‡îmîsñ®ù`ž|žô¥ÌD°]Òs»[À¼á°À¹À¸À·¹ÈŸÀ»À¶À¾À½ñÜƒ‹ìµÀº LË{Ò[ïçê@­sÒh×EŽÓ”rž‘ž™»@ÀaÌm”Ì™ÚµfÒw‡Ûž±»_™í×ŽÜ_Ò€è|',
                'lè”íeÀÀ›ÇÀ¿ÀÂé­äíî½áY‰°ÀÁÓE”G‹ö‘Ð‹ûÓ[ŒG”ˆ™ì ŠÀ|ÀÃÀÄ A‡•žE f € ˆ­Šž°¼hà¥„ÉÀÉàOšDÀÇÝ¹‹™ÀÈ—OÀÅÉvÀÆ¬˜³„ïüï¶¹^Å…Í™àHòëÜqäZæƒò@”ÀÊãÏ–JŸR‰iÉ‡˜¸ÕLé–Tˆ°ÀËÝõ†}ÀÌ»”“ÆÀÍ„ºÀÎ',
                'lªJ·†[ßëáÀ›Ð„Úðìï©ƒX÷‘Ž–U°A´‹ºŒÏoõ²ç„î‘ó€ÀÏÀÐ†KÀÑ`ÇNèá«™³zîîÍŒã™ÁÊ˜÷õuÞLÀÔÀÓ†ëñìÀÒ‹ª‘³™QÂgÜ~ØìêbÀÖß·à’AšíÆI«Wãî¸…³iÀÕ˜Sí‰º{÷¦ö˜ð›ðEÀ×æÐçÐÉ ˜Ã®šéÛ¿wÀØ™§­zÙúµW',
                'lÀnÀœÌrèDÞ[‰ÍèhìYÌ…÷m™ïÀ}ýF…ŸñçÚ³ÀÝ‰C½t‚ñÕCÀÚÊu´ÀÙÀÜ‰¾°NË‰™¦²µXž˜ÏœÌ{×|ƒ±èˆûPÀßÀá›¤Àà›æœIÀÛõªãîLî[ÀÞåG”b´ ïKîÀhÌq¶aàÏÃšÜ¨ÀâÀã´G¶ ÛkËJÀä‚’ˆÙã¶±œ†o„^Àå„{ÀæÀêÀëÇV',
                'lÀòæê“—~ÀçÇ—à¬—ˆ Àð¿„˜Àì²@¹]çÊÅƒÝñòÛæËŒV˜»Á§±L¸{¼HÊkÑŸä‚öâÀèÀé¿rî¾äœÏ[Ö‚ár‡­Þ¼ß†ëxõ”ç\öPùv÷ó‡Îž¦Ìyó»ÐGŒCc„°èg·ˆ»hóP÷~ûZÀñÀîÀïÙµbÁ¨æ²q›ÉåÎÀíÑeï®»šÑYØNä‡Àðå¢¶YõŽ',
                'lÏ~õ·÷¯ßŠ÷k™ðÁ¦ÀúÀ÷ŒÞÁ¢Àô–^ÀöÀûÀøß¿ÛÞÁ¤ÜÂÀýŒüìåèÀðÝÆnÁ¥ÀþÙ³–ÐèÝðß³PÆÀóÚ\éöÛªŠÚ—Àõ–Û–ï›ãáû«†íÂÀù¶wÝ°à¦‹KŸ¬PóÒÁ£ôÏÍjòÃÀüƒú…—˜Á¡ÍîºõÈö¨‰Wü“…äàÉTÉWãWøE…“…–•·šs¬—',
                'l¾FÎG„î•Ñšvóöë_øtŽ_™‚žW°O´•ë`óœƒ¢•å™ª i Ø¶]Ï‹‡³‰È”ižr­|µZËž™À s­‰°±Xµ[¼cÏ ƒ«°[µ`úbû•‡ÑÞ]™æ×Þ^”‰­–ìZ÷uìc­€Á©‚z‹¼ÞÆÁ¬Á±Á¯Á°Á«ßB—†ÁªñÍŽ†öÁ®‘XiÉ…UŠYÒœ„ …V‡t‘z´nÂŽ',
                'lÂÑžöãå¥ï¿€ÂIÂ’ËOÎ‹™¹Â“ì¡ÛšÖ‹æ`Á­ºŸó¹ôHç ö–»^»dÁ²çöÁ³ñÏ“¢˜­IÝü‹Õ”¿šaÄ˜à˜ÒcÁ„Á·æ®Á¶Áµ›Ëéçˆä‹tœ‹ÈjÁ´ƒIé¬Ÿ’¬…äò¾šÔåbššå€æœž‡ön‘ÙÀ~º|Á¼‚ZÁ¹Áº›öé£ÞcÁ¸Á»Ü®¾HõÔ˜ÅÝˆ¼Z',
                'lIÁ½ƒÉ†|†¤’ëÃžÑo¾nÎW÷ËôuÁÁ†]ÁÂÁ¾†ÈÁÀœ´Á¿Ÿ´ÝgÕÝvåyÜGÁÉÁÆÁÄÁÅÁÈÛÁÎ‘lÄkàÚ‹»å¼ùú‘’ÁÃ”¶â²çÔß|•ÅÁÇ­V¸NÄ‚¸XÁÍðÓŒ×\ºƒÏiØIÙ’ÛŽ rç‚ósïmúîÉá‘à€Þ¤ véRÁËÞÍžÒÁÏŒ®ÁÌ²tßÖš¸',
                'l’£ˆ´ÁÐÁÓÙý„ÃŠ²h’žä£Æ”Þ˜Ûø›¼ÁÒŸIÞæÁÔªdÍ}ÁÑŸ­±ŸÂ~ôóŽ{ïVƒ•õhø•”Y«C ÚõñôQ÷à÷vÁÚÁÖÁÙßø…°ÁÜ•—ÁÕ»‘¯r´@¹ƒôÔàëOá×«ªåà”Ý•ÉŸû­Uê¥ÁØî¬Á×ÅR¿šÂLû‹ÞO‰ÉžŠçlÁÛò•÷ë÷[ÈHz·Aƒj',
                'lÁÝ„C“Ô[âÞ‘¬ãÁÅ™_éÝ°R°SïCÁßt‡ÁÞŸiÙUÝþ˜ð®Vì¢éŠ®žÌAÜCõïÜ\ÜkÞ`ÁàÁæ„cÁéàòˆ{‰çŠ–ÁëH¶ãö ÷Üß•`–EèÚÁáê²Áè°s³g¶{¸nÁåÁêû_Šê’’èèùœR¬O¸ ½@ç±ÁçôáñöÅzÁâòÈÐeµ’ÔfÚšÝCÉˆÑkâ',
                'léqÁãÁä¾cÊCÝsë‘ñ|ÎÊ™ä™ë™õCöìøoûw UëëžýhžƒÛ¹öN‹øÌhýg™Ðáì`™ô ‹û™ý’êtÐ‡ÁìîIŽXÁîÁíßÊžâÁïìÖÁõ›f®qä¯Á÷Áô”éÁð®‘ÁòÑ^‹ˆÍì¼É]ÉsåÞÁóæòÁñ¬Šïv„¢¬–Áö´eïÖñ‡ûm˜ñ­]®œéH°@ÏYñœ‡®',
                'l‘ËžgË˜öÌæyðsûˆçBïdçsòtïiö†úVò˜Áø–Î—B«€—Pç¸ï³¾^ŸÞÁSä™PÁ[‹ôÁùÁ’‰gA¸´zðÒÛ‰ìCëwïfôjúw®F®M‡ÞÁúŒâÁüãñÜ×•oèÐççëÊ±€íÃÁýÁûÂ¡œ¬ð˜™VñªÁþº\‡µŽaŽbÌdçXìN•î–V™É z­‡²”µaµbÒt',
                'l»\Ã@ÐFÐHýŽØLÜ[èxì_ûTÂ¤Â¢ÛâÂ£ƒ¥ë]‰Å‰Æ”n¸_†U—Y³ŠÜÚLÂ¦ÙÍŠäà¶œ¾ÝäƒEÂ¥‡DI‘fÊVßs˜ÇŸÓñïò÷²kÂeÅ”ÏNÖŒÜ}÷ÃíVótáÐÂ§‰vâ“§U®RÂ¨ºtÂªŒÍÂ©ðüïÎ¯›¯œçUÂ¶ààß£‡£”]Â¬Â®Â«Ûä–›ãòÂ¯èÓ',
                'lëÍéñÅyðµ«SôµÂ­â„öÔô—±R‡´‰À]”mžo«G­oÌJ™¾ t­ˆÅF²’»VÀrÀžÆAÐBÞ_èzïBóz÷|ûRüuÂ±Â²’ ’ÇÂ°ûu³”Â³Ì”‰oFÉ˜ÄÂô”“ïéÖ´{ïåžZ™©šÚÅ›æ”Æ@çœèuˆP®fÂ½ôˆv Â¼V„ÎÂ¸éûê‘ŠáœGœOäË³tÇŠ',
                'låÖÂ¹—¶¬fµ“Â»ƒJ„—„ÛÂË±J²FÂµ¶˜ÙTÂ·‰nL“¦äõ¹‚»œÊIÂ¾˜ÌŸÑÄrÄyÓtÚ€Ûjê¤áXÂº·cÊ€ä›åhåjè´óüÏFøšžVº˜ÛÞAòJðØºŽº—çGöIùcùnÂ´çeòƒ»UÓ€Ìú˜ëªÂ¿ãÌéµé‚ñeÄ|™°Ëƒ•ìúyóHÂÀ…ÎÂÂàL‚HÂÃ—o',
                'lŸfµ~ïùÂÁÂÅ½…ÂÆŒÒëöÄoñÚäXÂÄÒ@ƒ–·t¿|·„Œœˆ‡ÂÉ†`ÂÇÂÊÂÌ¯ÂÈÈ„¾G¾v‘]¹˜„í¿†™¬ lèrÂÏÂÍÂÎèïð½ÙõÂÐöÇùFˆJŠaŒDŒ\Žn”•ð™èž¤ÁcÅLˆKž´Ì‰èŽ°f°gû[ÂÑÂÒá›yÂÓÂÔ®ˆï²ˆGäsäxÂÕ’àÂØÂ×àðÂÙ',
                'lÂÚöÂÖ‚ê‡÷‹E‘¥œSÇ’—‹Ä@´K¾]ÎFÛiÝ†´ˆä—öM¶—ÂbÂÛˆÀœÓÕ“ÞÛîb‡ÓÂÞ†ªâ¤ëáÂÜÂßé¡ÄTÂàÂáÂâïÝÂÝÁ_ÓTæ ƒ¬ÓZò…«MÌ}ß‰™åúŸ»jèŒð”òŸ„sÙÀ³`ÉzÂãÜsñ§ÙùÅI”{•ï°eãøRÂåÂçÜýÂæçó¹J½jÂä',
                'lÞûäð ÎöÃñ˜õiùBÀz÷w',
                'm½]³‰Æƒ ¤ÔN£†OŒ©Œª –ˆbß¼“áÁo¶mªCØ€ºÑœ“¸š‰Ø~šÓ Ó…›ýˆý‡`…ÞÂè‹Œ‹ßæÖÂé¯q‹°Êh Ðó¡ÏWÂíáïÂêÂëÂìñRœÔªwßj¬”´aÎ›æ‹úiö‡}è¿µléUÂîßé‚Ø²K‡O˜q¶MÁRñˆµTôKÂð†áÂïÂñö²ÂòÝ¤ÙI‡XÊ{ú”',
                'mÛ½ÂõÏ‰ÓÂóÂôÂöÃ}ûœÐ]„êÙuß~ì@ìAò©î”Š›ŽÂù‘`“¶Âø˜ÑÂ÷²m÷´ðz÷©ôMôNö ÐUŒÌœº±”ÂúMòýÒZÏ\æž²–ÂüƒKÃ¡Ü¬á£ÂýÂþªƒçÏÊAÂûì×ÙïÜ¿zÏTÖ™çNÌp ¯Úø…¹Ã¦šûÃ¢–n–xÃ¤……}¸ˆÃ£†WŠÁ›À ½íËâI',
                'mèš¯gÍ{ä€ñ ÌMÃ§ÇƒÆŸ‰ÜäÝòþÏ‘„õÃ¨ØˆÃ«Ã¬–‰êóÃ©ì¸œ~ÜšáFòÖÃª¾ˆ÷Öòúå^ó±ùšƒÓÃ®‘ùá¹ã÷ÜâêÄÃ­¹FÉ‹ãTƒÐ°pÆdƒØÃ¯Ã°±gÃ³ë£ÙóÒ‘‹uÃ±ÙQà|Ø•§—ûšÊè£î¦Ã²àŽÎcí®†xŽÛ‡¡žQ‡¼Ã´°Z›]Ã»Ã¶ÃµÆ€',
                'm–ÏÃ¼ÃzÝ®Ã·¬CÃŠàdˆõÃ½áÒäØœŽâ­±ŒÉBé¹˜MÃº¬s¶CÄP‰r˜ŽÃ¸ïÑðÌäYÃ¹Ûæ[²‚”uÌjúB”|üqš°Ã¿ƒñÃÀ’¯ä¼‹Z±œ„‹‰Ã¾‹Ê BÜzæVüeÃÃ’{›iÃÁµ|ñÇ±tÃÄÃÂ¯cÚ›ômŸ¢²S÷È¹ŸÎn‡ª—ÈÃÅÞÑ«fîÍéTéY’ÐÇ–­J',
                'm·`å{ÌŠÃÆìËž•¹ Fí¯‘¿ÃÇ‚ƒ’ú”BÃ¥®mòµƒáŽíÁEÃÈÈ_‰ôœÉÃËÝùƒ˜ýÞ«ÊpÎ{à‘à–ŽÌ‘º÷«B•äëüÃÊšÙ²‰íæõ’ô¿ûs²“ìXðîŸûLÛÂÃÍ®HÃÉÃÌô»òìåiãÂó·öQü€ÃÏÃÎ‰õ‘¸ìDÛ_ßä²[ƒßÃÖìòÃÔâ¨ÃÕÉoÔ™ÖiÃÑ',
                'm”CÃÓ÷ãû†÷çÃÒ«Jû” †‘Û”}ÞÂá‚áƒûJáˆÃ×ÁdØÂñåô›¦ôÍ»…ëßÃÐœ}ÈŽÎ^ÊUãŒBž§ôéãèåµÃÚÃÙaµzŒsÃØÃÜœPÒ’Ò“ÃÝÚ×‰QŽ¶Òšà×˜aDeŸÇÊZÃÛü†ƒç˜ÆŽÈóËzÖk™—º€Á]ÆPÃßŠåÃà‹iÃÞ¾d¾‚ÅXÎe‹î™†™¡',
                'm²Š²Œ²DšóÃâãæö¼‚aÃãííÃä‚ÁÃá„Ò†»ÒäÏÃåÈxëï¾’õ|ìrÃæ¼Eû ü@üMüIß÷Ãç‹bÃèÃéðÅ‹·ù‘÷]èÂíðÃëíµÃìç¿ºF¾˜ÃêåãÃîÃí¸kŽøR…¸ßã†_ŒPÃð“}œçÃïËIøpŽÏ‘Ìžfóú™­óºÐ`èf÷x­ŸÃñˆ„Š“áºB•F•G',
                'mçäÜåçë±aƒäÁF‰’Ï¬Y¬\çÅ•¡¬z¯x´CâŒ¾r¾‡ä æFÃóƒí„bãÉÃòãý„Ç”•ÃöÃõÃô¸œ¹Iœ¡éhíª”°üwé}ƒo‘O‘‘˜º‡÷ªÏŸöšÃûÃ÷Ãù›³±bÜøÚ¤–L±…Ãúàp‹“äéªuÉqêÔ˜iã‘øQî¨ÃøÓKâŠ±ƒü‘Dõ¤Ãü’øÔšÃýçÑ¿ŠÖ‡',
                'mÃþ‡±Œ­ÚÓæÆâÉÄ¡Ä£Ä¤üN÷áÄ¦ôž˜íÄ¥¼UÖƒÖ„”Vðx‡¶Ä¢órÄ§„¯ð‘Ä¨‘½üOÄ©„¹ˆ\Š‹\š{éâÄ­ÜÔÄ°Ž”•b–£°t±u±‹³]ï÷ÇeÄª±‰»Š½QÑJÍˆØ{†ù‰sÄ¯Ä®Ýëõöã€Ä«‹º•½ñ¢²a²hïÒôŽüa¿}Ä¬õøËÏ_æŸ jò‡µcÀg',
                'mñòißèÄ²Ù°„Àc›£íøÄ±ãwÖ\öÊøœüEÄ³Ä¸ë¤ª…šÒÄ¶ÄµÄ·Ä´\ ¸®r®yÃk®€®³c®ŽãaÛ[Ä¾ØïÄ¿„Lãå ñÛéžÑÄÁÜÙš»Ç€Í]îâÄ¼Èrë‚Ä¹Ä»Ž¿‘H—úÄÀãfÄ½ÄºÅëŽÄÂíJ”æC—ÒäÅ',
                'n‘¹’jÞÖ¶gÇ_ÑD†ˆšÃ†Hƒ¹ƒºÂYÂxTÞÃ‹©Ú™ÂžÆ›²›ïŽu~Œ³¸oÑA›éSðž…Ø¿˜Ò’‚ÄÃÕyïÕæ“pÄÄë~ÄÚÄÇ…ÈŠ{ÄÉëÇÄÈñÄÄÆ¼{ÐœÞà¸™ØvÜ˜Øy†òÉiì„ô›ÄGŸÃŒYÄËÄÌÜµÄÊ¯GŠ…iÞ•‚™á‹èÄÎèÍÄÍÝÁœ‡Ø¾Ñ”',
                'nÎ—åràïÄÐ’o––‚OÄÏŠÉ®~Ç~ÄÑà«ßa•¨éªŸ²ÖQëyôö“Dœ¯Èlëîòï‘Ú‹Ràìe‡°ÄÒôTâÎ™òð–“îêÙß­ž²ƒ²ýQØ«™`ßÎFÄÓpíÐîóâ®òÍÔi´LŽH‰ëçtŽj«LÛñÄÕ˜ÄÔ…DÃ—ˆßÀ‹šè§ÄX´ZÄÖ‹CÄ×émô[Ú«ÄÅ±„ÔGÄØ',
                'nÄÙÄFðHõƒõšßŸˆÄÛÄÜÇ‚â…äG†«ÄÝÄáÛèâõÄà»uÄßŒÉ¶và\îêˆÐŠöœNâ¥Íe—´ÛCâ‰ÎUÓrØƒÄÞöòöFûŒýuÅMÃÙ£ÄãÄâ’v ùÆs–«ì»•ñDƒ“ëW”MËo™èXšîÞ‹êÇÃfÄæÄä¯[±zˆÓ©‹¤îÄçíþÄå•¿¿QÄ‹òÄéÄê¶j†P',
                'n¶|öÓõRöóùDð¤öTÄíéý“ÓÄìÄëÝ‚ºv”fÜT…`Ø¥ÄîŠ¨ÛþÄï‹ÝÄðá|á„ÄñÜàôÁ‹–ÑUÊ\‹ØÑ™æÕÄòëåÄó“IŽ‹ˆ[Æ}–¨ÚíÄùÄôô«Äö¶êŸ”¤à¿ÔÛW“µÛfÛhÄ÷ÄøŽLºQÅYåRò¨õææ‡êEŒZÄõ™Ç»HÞÁýmŽq¼b¼fÐA‡Ü×‘Übè‡',
                'nïDÃ€‡áÄú’ŒÄþßÌÅ¡ÄüÄûñ÷Œ|Œ‚Œ‰ŒŽƒ‘Äý‡“‹Þ”QªŸËf™ŽÂœè_ôVûH™F²…Øú‚AÅ¢å¸Œ„Ãôæ¤Å£ «âîÅ¤›\áðÅ¦–ƒžÈÅ¥¼~âoìÅ©Ù¯ßæÅ¨Å§¶ŒÞrƒzÞs‡‘âÊ¶ZÄ“·vÒaáx™×ÀYÅª’˜’°°JýPÁ…×a†Ž˜‰ññæe',
                'nç×kÅ«æÛæå¹@ñwÂÅ¬åó³eæÀÅ­‚Õ“xÅ®îÏ»sâSÐZí¤–Hô¬Å±Å°¯‘ŠfœqÅ¯Ÿð`³–üQ \àGÅ²—jÙÐ“ƒ®™DÅµßö’ýßSÞùï»˜`·LÖZ¼KÅ³‘Â¼X·zÅ´í¥Äè',
                'o…Ë“¸àÞÅ¶¹p‰ñjíMÚ©Å·Å¹ê±Å¸‰pšWŸà®TÄpøk™¯Ëšæ–út…¾Å»Å¼ÄUñîÊqÅºâæÅ½‘Ya',
                'pîÙâZÚ•ÁTªWÎŒÑ—é›œ° ¥—”Ïæ^„ƒÒJè˜ÐˆãEõU¬i½l¯n¬aßJÛMÎ“æq»z–Š¯w±Ù·K¹ví@ªpÈqÞÕÌ¾œÞqóTÊEïRûË‘Ö€·…òŠóQ“¿šñ³W­pãu´B´‘ éÆt­”—Kœ_œ”ªtñF‡¥ómÍoªŽùL…ÄÇ[âbà^Æž»OÄ‡Ú“áÝÐv‰âñT',
                'p“žˆ¡ŠvŒ ØfŽˆÒLÒi¸¬Í—¶â·•”hÃ‡žTŒ´±~Ú¢Ò”ŒÛŠr°qÅ¿ÅuÅ¾ÝâèËÅÀ°ÒÅÃóáŽÅÁÅÂÐ’ÅÄÙ½ÅÇÅÅªT—“ÅÆ¹uÝ‡º’ ÛßßÅÉÅÈÝåæW´s±e®‰ÅËÅÊãÝ–®ÅÌÛA‹ŠŽ´Ég“„˜„ÅÍ¿Tõçžbó´Û˜æoíQˆmƒëÅÐ›cãúžÎ',
                'pÅÑ žÅÎÅÏñÈÔjœãîGäƒùbñáè‹ÅÒ›P›`ÃTÃpë„äèÄtìQ…€ÅÓåÌÅÔÅ}‹˜ºUó¦÷›ý‰ý‹ö„ÐI†çÅÕÓIóožÐÅÖÅ×’ëãÅÙÅØˆƒâÒáóÅÚžä ÅÛÞËÍdÝNìŽÑŒûƒÅÜŠEÅÝðå°’³hÈaüBµPµ^ÅÞCÃS–ÈÅßÐ[õ¬êkÅãêŠÅàšÅÅâ',
                'pïÂÅáÑpÙräž‚_¬ÅæÅåàúŠ³”äì·›Ö«˜Åä¸ŸÉ„àÎñ]ïö¬Þ\Åç‡Šåš\­›ÅèäÔÈ†…ÜÁÂM†Ï„úâñÅê›€yÃgÅé—ZÅë³yÝJéopàØñs´yÆMÅó’²¸†‚‡ÇlÜ¡‹ÅíÅï—Ä‚õ‰X‰k“smÅð·@ÅîÅô˜¨˜ÕŸÔ‘uÅìÝ~ÅñÅòåAíŠ',
                'pó—Ïeó²óŸÀeíŽùiòuôJèmÅõœA°v„™’ü—ÕÅöÛs›¹Ž‡êCn†ÔØ§¶ÉÅúç¢ÚüÅ÷WÅû’yžÌ ò øÅø¶u¶y¼„îë”èÁ‘Â\Øwâtâ”ãYãÅü´iñyó‹àèäšåCõB‘šµFµGêVÅùÆ¤êoÜÅBèÁš·ÃYÅþš³Æ£¸“ò·Û¯ÚðÆ¡ÛýšÍn',
                'pØu—ÀŸÅýÆ¢ÄM˜[÷‰î¼ÄmòçëRô“‰ªõQºfÏKõùº”Á`ùd–CÜ±ÐKÆ¥âÏØòÛÜÆkÃ˜Æ¦ã›Õ|øaß¨‡ñ±‡ºÆ¨äÄœk“FæÇ‹œ²Dî¢‡Æ§Ýê¶¯@Æ©úûGÆ¬‡æÆ«‹xêúÆªôæú@æéëÝÄA—è˜FÙXÕ—ójõäñ‰òNÒÚÒÙGÕ›Æ­ôò]ò_',
                'pØâ®Æ¯çÎÆ®´‚”ô¿~ÂHóª ÜïgïhôwÆ°ËiêQéèî©ºgáo°Žî’Æ±ƒG„ÜàÑæÎÒ‘Gë­Æ²“Å•ÈÆ³Ø¯ÜÖçv‹±æ°Æ´µI·|ñPóD«nÆ¶Øš¬VæÉÆµîl‹åËd‡¹²‹ò­ïAÆ·é¯–Wêòšýæ³Æ¸Æ¹®jÙ·›Ú³fÆE¸zîZÆ½ÆÀÆ¾…çÆºJÆ»àZ',
                'pÆÁŽ—èÒ›¯«rÇLŠÐÆ¿ŒÎŽ£œKÆ¼Íg‰BŽ±Ÿv®JÀÂ†É‘ÍƒÔuÝZöÒ„R‘k¹’Ýƒ‘{õG™qºqÌOîÇÆÂŒûÆÃŠËá•ÆÄœÂáNŠáwçkÆÅ‡MÊXÛ¶ð«Öc™ØÏŒžîÞóÍãOñpgFÆÈ”’•^›¨çê†\ŸBÆÆ³kÆÉÉbîHÆÇÆÊïH’g’h’½ÞåÙö¹r',
                'p…ð†VŠç ÁƒÍ†RÆÍê·ÆË’pžÊŽ}Ž~–¿ê†¯jÆÌñmàÛ“ää“òõ‹ˆOÙéÆÎÆÐÇŽÆÏÉhÆÑƒWáT‰è±å§²r·oïäÙŸÀbçhÆÓÆÔÆÒÆÖŸMÆÕ‡þäß•®Æ×ª˜ãë«ÖE™kïè×Võëç’ÅmÅnÆØ',
                'q“³´x•üû]úIüÔˆÜ•ƒ¡™ÂÚmÑE„“”¦ØÎáëB³MÃIã^’M¬g²•ûXý”šðÃQñU’uîM´ëaœ‚Åpà ”Œ”ª¶š©¾ƒÓs¶Sàœçˆð‡ŸdÛeÜeÏlœgÈWúñÊ†kÃƒrìy÷œöúYè~“BÈ“u“°™„ßŸ}Ÿ÷äÐœ©Ïf×Ká½þ‰‡„—¸¯C‚Œ‚Í',
                'q‹}Í„˜Hõ^ÇMˆ²û…‰ƒ‘[šVä›Üù‚’ºôòÚ õLÛRÚzlöÄèL’ÔƒÍX‚àùŠÜjûŠûŽŸa¹„é_šKšMš£“U’®³³LÕF…•ŸÈ RÅˆøBšªÆßÞ€ÆãÆÞÆâ‚ˆÆàÆÜèçÀŽàVŠÝ¢ÆÝ’Ý—RœDÝÂ–OÆÚÆÛ¼–Ñzƒ[àÒ‘i˜éÊÆá¾e‘h´mÕƒ',
                'që’õèôtçKù†ØÁÆîÆëÛßáªŒóÜÎÆäÆæ”ÅÆçÆíÃX¯O¸g„~”Æ”çêÈÆêÍTÍ[ñýˆÎÆéŽ©’åä¿œjªXÆèÝ½Ú–Ü™âHæëÆï—ŽÆåçùç÷ì÷òÓæ³ž´JÑwí ônôoÆì»ž¾Lôë¾N¾zÎBòà­D¶QÞ­ÛaÏB÷’‘¼ùËs™‡™–º“ÄšòTòU÷¢ÌIõš',
                'qùuù}÷è»KÀdÅ Ï“ôGò€ôyö’«Oû˜ÆòßŒÆóá¨ÆñÜ»Æô…Ñè½«^°ž†uØMÆð†™†š†¢Šíç²•’—¤ôìÖHº‘êMÆøÆýšÝãàÆùÆúÆû³HÆZ…æÆüžÅ±[…ýÆõÆöÜù–ÖÓ™†ƒ™û‰óÔ—‰œŒœÝÝíÓ“ •´®P´\‡r‘sÆ÷í¬´w´ƒËjµJÀ™Ï„Æþ',
                'qÝÖ’‰ÚžáMì—ˆXƒîŽ˜Ç¡Ç¢š³sÙ÷ÄÇ§ÇªÚäŠdÇ¤šþÜ·Ç¨ÙÝá©–e›FÇ@¸dÇ¥’ŠÇ£»xã¥ÍOØ@Ç¦Šú ¿âTÇ«ëeƒLí©Ç©å¹ûeåº“¾“Ã¹ˆÕßwå½îv™Œ”o”p™¥ºžçcùk”qòqèBôRôS»`ía¤Œòø’R’ƒqÇ°îÔškò¯Ç®Ç¯Ç¬',
                'q‚¡Þç“bÜ‹`âjãQ‰‰˜póéäEÇ±™NåXÇ­æZübòcžKò`ž»Rö‘Ç³ëÉœ\Òã»Ç²ÎS“Ç´ç×À`×lècÇ·„XÜÍÜçÙ»ŒÇµ‚ßÇ¶—èý°|É`‰qÇ¸ÊgƒŽ˜ ºGÝ€ºR‰µ‹ì¿yÇºÇ¼ãÞê¨”ÖÇ¹«oª]¬jõÄ†ó—¾ª}Ç»†ÜœÙòÞïºè‘ê˜Œ',
                'q ›¬šÁzïÏº[äÛ„ïêÛ–æjçIçjŠÇ¿Ç½æÍÇ¾éÉ\Ê@‰¦‹Ô™{ ÖmÅšÌbÇÀôÇ“ŒÁu‰‚“¬¿‹ñßÀHìÁ†…ŸÍÁ†ƒ¿­™ÇÄíÍàbàzÏõÎàƒà…ØäÇÃÛ^ÇÂ‰Œ´`îN‰§ŽÉÇÁçØ´“å æ@¿”Ú‰ÜEÜFÇÇÇÈÇJÜñÇÅ³~†ÌƒS˜“ÚÛ‡a‹´ã¾',
                'qÊw÷³éÔ˜ò Ö¯ ÇÆ´™Ë–×SÚˆçyíXî˜ÇÉá ã¸ó~ÇÎÚ½ê~ÇÍŽÇÏš¤ÇÌÕVó|ƒsÇËÇÊ¸[ÂNÜNÇÐÆj°mÇÑÂÇÒ…‚æªÇÓ…LÇÔ‚ž‰êü›­ã«›ù¸›ÜÍ‰–Aóæ¾fïÆôŠºDÛo·lË~å›ö@çƒ¸`»]Ç×ÇÖÇÕôÀóVÈB‹]ÂÕWôÓHîzñŸ',
                'qõŒ˜ŽÜÜËÇÛˆ¨«²›ÇØÂlÇ›ÍZ’ÍÇÙ¬lÇÝâsëdÇÚàºäÚì€àßÇÜ”ÜøV‘¦éÕà¯òû‘¥Ïˆˆa•T¸—vÚcŒ€ï·ÇÞŒ‹äuÏO…ÂßÄ’aÇß†wÇ™Þì“l“åžpÌCìiÇàÇâÇáÇãÇäàWàõšäœ[ÇåƒAFòßÝpöëè[‰ð®_„…„ÍÇéš„³|Çç—³',
                'qÇèÈ•¦“÷˜½ÇæéÑ÷ôÜÜÇêÇëŽöí•NÕˆ™”ö¥Çìƒõ’á³ óäìm‘cíàƒ žDóÀ™¼Œ^õ¼öÆ…oÚöÇîñ·Üä–÷¹HóÌÚ^ÄŸwŸzÇíÅ|òËÍ‹Ÿ¦ŸÅ±ž²`¸Fƒ’‘w™K­WË}¸\Ë•ÇðHÇñˆwnÇï¶kŒxòÇ‹pÈcé±ûjºE¾Î~·hÚ‚öúÏbíF',
                'qíGÌUöpöqù”ý•…´Çô’@áì«U–_ÃFÇóò°ÇöÍAÙ´ÓaÓˆÓ‰Çõ†p›½¼zÇiÞåÏá–—Wš‚šÂÇòêäâU¦ÛÏœª°“±HåÙŸª½‡ÍôÃŽ€ÓpÙg­GòøäMábõF÷üõ‰ùjÐ@÷A“zôÜÇøÇúÒ…Já«Ú°êrÇýˆoÇüE’|›µìîÃlÐ …^ÇùÇû¹L»–',
                'qòÐÔxÇ÷çñl‘t”·ÕoñnüLó”Ú…üDÜ|ôð÷ñòŒö÷OÚÛ¾”×ëÔÇ†Ðdð¶œTÇþ½PÈÝ@Þ¡­SíáÏJøzè³ÂJÏgüšÞ¾…Zßž›‘ó™áë¬»cÅJñ³ÐRáéÜdó½èŠûYÈ¡¸lÈ¢¼ Ôs¸yÈ£ýx…È¥„`…íÞ‘àTÂ^ãÖêïÈ¤é‰üCé˜ÓNÓUüzÓY',
                'qZãªÈ¦‡ü—¨ñògçzÈ«È¨çÚ¹ŠºÈª›§ÜõÈ­ »éú†­ˆ»Š÷³È¬³oîýœ² ÅóÜ½hÄCÈ›“‘˜T¬†ÓjÔÝbòéãŒ˜ØÛm¿XÈ©êB÷™÷ÜŒAŽköe™àýjÐSÈ§ïEÈ®›Lî°žïç¹¾JÌ†È°È¯Ž† º—Ñ„áíj„ñÈ²È±ÉUÈ³È´ˆ«‚í¨È¸³‚È·',
                'qã×‰U“n°”ãÚÈµâÈ¶‰”‘Uš¨´_Ú| Pé µCêIùoµ]‰æ‡ïnåÒŒlŽ È¹ÁtÈºÑdÛ§',
                'r…Êƒµƒ¶Ÿß…mˆc¿ó’âc–¹ÏuÄž’fƒÈ›ÝÛœ‹úÇŒÇy«A™“Û’Á@‡Ý…ßÃVÐ€Ð…ÍcÐ™òÅÈ»ó†‡Y÷×È¼¿‘ƒÑÈ½Š˜ÜÛÈ¾«z‹vÉG·yž«KìüÈ¿ð¦Ü`ôX‰´ÈÂÈÀÈÁ }ÈÃ‘Ó×j×ŒÜéÈÄèã˜ïÒYðˆ áÈÅæ¬ëN”_ÈÆßvÀ@ÈÇÈÈŸá',
                'rÈËÈÊÈÉá–Zä¶eÆ\âmôã…øžÈÌÜó–ß–áÇY¶‰ïþ¾BÜrÈÐ„UÈÏØð¡×šÈÎŒã’PÈÒÈÑ–k ®ÀÃMéíÈÍâ¿Šž¼xñÅ¼ŒÓ•Ü—eÑG½VÄHìzì~ígïƒÕJïšÈÓÈÔÞwµiÆeê—ÈÕóR‡ðâJâ~ñ_ÈÖëÀ–ÑáõÈÞÆŽÈ×ÈÙÈÝtš¿ŸV‹†áÉ',
                'r½qÁs‹’“m“r“–˜xÈÜÈØéÅ˜sÈÛ¬Œ·ZòîÑ’éFšÕ¿^ÈÚÎñŒó“‹æŽV hægžq•íÏ”ÈßŒ]‚ÔÝP·\…œ¶bÈá»€‹YÈàœnÈ|¬yÄ\ôÛÎjõåÝŠåˆ÷·­~òkökù’˜QŸ§íqÈâŒ`Ž]ßÈçûŽšÈã–ôÑMï¨œx¹TÉSãœÊ‡Èåønàé‹çÈæå¦Þ¸',
                'rø›•ã ^ñàÈäò¬á}îž÷pÈêÃNÈéÈèàrÈë’CÞz–dä²†ä‹‡äáçÈÝêøMÈì¿d”Jˆë“É‰¼ÈîëÃÈíÂX‚¢Ü›‹\Þ¬}ÄQ‹¯´M¾ÎpÝ‰­wµO—M®c¾qÞ¨ÈïÊt™GÀBÌGÌHÜÇèÄò¸ÈñÈðî£…±‰ÇÈòÈóécét™˜ô…ªÈôÙ¼Èõàe‹SœcŸx—í',
                'r×ÉmóèºO kö}ö”úU',
                'sãGìáè¼”c‚ÆÀu…¢…£…¤†Ð‚ð·_‘¨à“’‘¸ž»æ\Ñ–„x“½”v“˜î‰jˆö¾D\Š¿³×ï†ˆÃá~”™ªkwÝ¿W—Œ˜BY‘mÀŠ¿\æp…g†Î“ú·ƒdŒpå~ßfßr’¡ê^êAêyÌt—­Ø­íH†Fçií}éXì[ç™ÒŽ¥Ç‹‘ˆû”ƒ¯ŸÊ”ž{šÑ·DÐL',
                'sŠÌœV’öôˆTˆUÛÉZËNèAímíI‹Žš —ªÝØ’µØí—EÈöÈ÷ÔQìƒ¥Ø¦ìªëÛÈø“—ëMñ`ïSË_™¨–Óšºà“HÈûšËÈù‡TàçÈúî|†ðÈüƒwÙº›ÌƒÈýqÈþë§šÉ…xšÐ ÑôL‰ÐÉ¡‚ãÉ¢ôÖ¼BâÌ™V¼R¼V¼W¿™çDð€‚^éd–øÉ£˜šÉ¤Þú',
                'síßÑ˜òªærî‹É¥†Ê’ûýÉ¦œÐÉ§çÒëýöþïbòXö…÷fÉ¨’ßÉ©Ü£ðþš×²„óÉ«–ÜÉ¬ØÄœiï¤šm¬X†ÝÉªšoäC®‘­“öæí¯™ð£­­iži·wÀN·†ÞQçmÖ ïoÑSÂ{É­˜¦ÒIÉ®ôOé~¿LÉ±É³É´oÉ°†~’­ªQ»}¼†É¯ï¡ðð³ÊeôÄ',
                's˜×ô‹öèéŒæ|õõÀ\Éµƒƒ¿‚ßþÉ¶Ž¨ÈS†Ãì¦É·ÁœÁ é„ö®É¸ºYºkºÉ¹•ñÉ½áêßˆZÉ¾„hÉ¼–uÜÏæ©ÉÀîÌÛïªGÉºô®¯ZÃˆÜ‘¸–é^õÇ„š“‡AŽ»É¿Ê`äú¿•Ü™cëþõŠÁÁƒÉÁÉÂžèê„éW•Ÿš±˜ŸÄÓ@Ú¨ÉÇðÞÉ»ÉÈÓ˜',
                'sÚ]‚ÞÉÆ—ÖãˆæóƒRÛ·‰‰ŽÉÉæÓÉÃ”»˜èÉÅ´ŠÖbÉÄ¿˜óµ×iÙ ç—ðƒò~÷­ž¨÷XÉËéäÉÌõü‚ûÉÊ‘^CÊKš‘ìØÏDÓxÖ…ôlÉÑÛð‘ûÉÎÉÍÙpèlAÉÏ Œ¬ÉÐvç´¾y„ÉÓÉÒÉÕŸ†ÉÔ”ïóâô¹òÙÝiÊ–Ÿýó™õ}É×ÉÖ–¶«xÉØÉÙÛ¿',
                's…pÉÛÉÜÉÚŠ¾ÐŒ½B¾KäûÉÝâ¦ÉÞî´ÝfÙdÙh™ÉàÙÜÉßÍ…Éá’ÎØÇÉèÉçÅh…‡ÉäÉæ›õœhÔOÉâÉåÉãäÜ‘b“ºÊJÏ‡ísòM‘Øž—÷ê™ÝÉêŒæ’JÉìÉíêÉëŠ»pÉðÁAÚ·–¸šá«|·Œ»rÉïv®`±mÉéˆÞÉî¼ƒÂ—ØÈÑ[ÔYÁKÉ†Ô–',
                's®eÊQŸöËMñ‘÷“õ˜ù_öYöŸÉñ˜Yãhö•ß•z’bÉòÉó² ßÓïòŒqÚÅ×ŸÉôäÉÔBŒÕ”îTô•Ö²s‹ðžcÓ\×}Éö‚L•YÉõëÏ›Ø±sÉøµŠÃŒÄIõÉ÷é©¯}ò×Bäv¯”ÉýÉúêj…ÖÉù”Î•N–™›ˆÆš}Éü«{¸iÊ¤ê…•úê’óÏœ¤Ÿ„ÉûãHÂ•',
                'så•ü›ù|Éþ‘™Æ×WÊ¡íò‚¯œƒÊ¥êÉ•…„Ê¢Ê£„ÙÙKáÓÂ}‰˜˜|Êo™TÙ‹Ê¬Ê§Ê¦…ÚÊ­Ê«ßŸû\ŒÆÊ©›¸Ê¨ŽŸ½Jœ¢ÊªÈžœÛœáª{ÉNÝéÔŠ¬‹õ§øOÎtø[Ñ öõåœöXö‰úPÒ|»iá‡Ê®â»Ê²Ê¯ÞyÛÊ±¸bÊ¶ÊµŒg•Eïz]Ê°ìÂµuÊ´',
                'sÊ³Ûõ•rÝªŒœ›ßY‰PÖœÒÉP˜tÎgãvºIöåõZüœüöˆÊ·Ê¸dõ¹Ê¹Ê¼Ê»ƒ½Êº¹E˜Vâñ‚Ê¿ÊÏìêÊÀFÊËÊÐÊ¾…bÊ½…«ÊÂÊÌÊÆ…á–ÉÊÓÊÔÊÎƒàÊÒ^ÊÑÊÃÊÇ–§ÊÁ±cêÛÊÊ–òžø±i±xóÂéøÊÅîæÒ•á‹«ß±“JÚÖÙBÊÍ„ÝÊÈ',
                'ssŸ³±óßÓlÔ‡ÝYâ‹ï—ÅkÊÄŠ]ÊÉ‹ÒÌÕœÕžß}ðSó§ºº Ònö|ƒ¾­—…§ÊÕÊÖÊØˆ–Ê×ô¼ÊÙÊÜá÷ÊÞÊÛÊÚç·¯lÄf‰ÛÊÝ¾R‰Þª•«FæÊéì¯Êãç£Êå–€Êàêxæ­–µÙ¿‚‚•øÊâ¼‚’æÊáÊçŸYÝÄÜ“àg¯EÊèÊæÞóë¨šÌ½ˆÊäÛSÛ\',
                's˜ÐÊßÝ”™]õ_”dž‚ùeŒ«ïøŠìÊëÊêÛÓÊì­qÚH•¤ÊîÊòÊðÊóü“Êñ©ÊíÊï°PÒe¼^Òl»PÐO÷n÷t–XÊõÊùÊøãðÊö‚JXÊ÷ÊúÇOË¡ÊüŽõ½RÉDÐgÑVÊý¸wëòÊûÊþ”µäøØQ˜äòåfçTùŽÌ Ë¢à§Ë£ÕXË¥Ë¤Ë¦Ë§Ž›ó°…iãÅË©',
                'séVË¨äÌÄYË«œöËªëpæ×óZ‹þò‚™Üµdú{ûtÆCóLûUË¬‰u‘S˜¾¿Yç`ž“Ë­ÃŸÕlãßË®šìéjŽœ›ä›çµˆË°ÑcË¯Ë±˜JË³Ë´í˜ÊŠ˜ù²i²pË²ôBËµåùË¸Ë·îåšFË¶²àÊÞ÷ÝôËÔéÃ´TælÛÌË¿Ë¾¼iË½ßÐ›q‚hË¼lð¸‹wË¹½zçÁ',
                'sòÏ—ö¶Dãjït„@ØË˜{¶LÁQäFïÈË»‡zPËºäù¾ŒÊ‘Î‡æJÏaÏzï\òlçrúƒýDËÀËÈËÄÀŸËÂãáËÅËÆËÙîæ¦›…ìëýŒKãôËÇæáÙ¹ŠÙ–Æ µ—t›—›åÃBï~óÓñêâL¸rÒ–ËÃËÁØ|â–ï•¶Tñ†ÊœƒòIž[ÏArâìËÉ–…–œŠ»–·‚‘',
                'sÚ¡—sáÂŽôäÁÝ¿áÔ³—Î@‘¡™€ëó ËËã¤’¿ËÊñµ‚öèØ‘ZÂ–ñžËÏËÎËÐËÍËÌÔAížÕbðmæƒð’Èànà²ŽùCËÑäÑªvÉLÉrâÈì¬“¡ïËËÒòôágæ}ðtï`òpÛÅ‚ÏàÕî¤ËÓÞ´”\Ë’™¸¯˜ËÕ®dËÖöÕ¸@·dõ‡ÌKÌV™Å‡ÕË×«TÙíËß',
                's›ƒËà›«ä³«ŽËØËÙšƒ»óX‚ÑËÚÔVÚÕà¼‰OËÜ‹•ãºËÝœßÃCßiûhËÛå˜jÄhÝøö¢Úxßp‘ˆ˜Â˜Éšä_ðM¿i­XóùË‚ÖqÛ‘ò“÷Tú‰â¡¯iËá…Wµ{¸Œ¹gËâËã‰åÆVËä‚‹†a›ÔÝ´Ç]íõÈšœñî¡ŸÕå¡ìšëmËçËåËæßU½—ëS­…ÄŽžv',
                'sólËè‚Ëê³ZËî»‚ÚÇˆ¼ÀÃœËìšqšrŸ«ËéËí‹ÓÜ·[ÕrÙw™pìÝ­j¶XËë·u¿…Ò`åä”ø¿“ÀZçw×\ç›ËïáøÝ¥â¸“qªsÉpïŠ˜ƒÊ˜ËV®pËðËñöÀ“pé¾¹æ{Ž…–Ëôæ¶Çj‚éêýèøËóíüàÂôÈËò“™ËõÚtºwºz¿sóšõ€ËùßïË÷Ëö',
                's¬R»Ëø†î•­œÅ¬æaæiææ•ßCœàÎRÏÃâàÝ·ñâÕ¤Êô',
                'tÖO†žÑgƒ{¶UÏsÀWé‹²_èK«ž‚Dk ‚¾I»I‚mˆÇÉ”ù‡â‘“ÒÞ…Þ‡í³ÇEßQœÍß_æ]í^ß¾ÍfÜ–ÙJ°D“Û‡d—ðZüh”†™éßTÊŽº‚ÌoêW–]ìâ cƒ\ŠDóƒÔgwÆl‹XÖBîŒîâšµ÷É‰†—ÂÚgŠcâ‰’dœ§Ô˜î×äWÑƒÎP˜ú¶ÚŽÝ‘‡',
                'tŸõÜ€ä~ì‘òo…õhŒ_ËýØçŸüÝ‰‘Ödð‡p”U”Á¹åŸŠUÃã@›IÏ€÷WÕgÜæÈVŠ¸çÊÑ|ÞÐ›ì¬Ÿƒ©¶´fäl–ŸËûËü ­µk…úõÁîèËú˜däâÑÜD‚@Ëþ‰‡Ì¡õ]÷£«HöÌ¢ªHãË„›ø“‚ßeåÝê`é½šÏ¶N“éßÕwÌ¤‡–åJ‡Å',
                'têÌ£ìŸêFíOêY×nÜcÒk‡òŒLææÌ¥Ì¨Û¢ˆrÌ§Ì¦ìÆžåõÌöØ¹xÅ_ïUƒˆõT‹ê”EÞ·™…»FÌ«ƒè‰ûöÌ­Ì¬ëÄîÑÌ©»†ÅvÌªâœÌ‘B MÌ®Ì°Z†®¯aÅjØÌ¯Ì²‡c Ì±”Z”‚ž©°cÌ³ê¼‚„Ì¸Û°Šò´Žñû˜WÌµïÄÌ·‰›‰ ‘…Ì¶',
                'tÕ„á]‰¯•ÒÌ´îtÀ—Ë“‰Â×TØáv×ZÀú‚ìþÌ¹Ì»îãÈIÌºãg†ú‘˜‘Ÿ•Æáa­fÌ¾Ì¿ˆÅÌ½‚èœžƒN‡@Ì¼ÅlšUÙyÌÀï¦‡R„¨ôÊÎvËTïÛÛçMç|íUü‘â¼ˆnÌÆÌÃ‚Ú†°ÌÄàoÌÁÉÌÂäçÉyëG˜yfŸ¶è©¶KÄgéÌ´g¼CÌÅ˜üºLÌÇó¥',
                'tÛ}¼Qó«ÚZõ±æhðnêOðyúSàûÌÈ‚«ÌÊÙÎñíÌÉéEæ†ƒ¯‘Ü•ò ‡²˜è’ÌÌ“­ÌË C—‰ú|ÌÎÌÐÌÍ½dÔ|‹—Žµþ“†ÌÏ˜…¬•èºï‘¿_¿lýÖzíNíw÷ÒÞ†Gä¬ÌÓÌÒÌÕßû—ƒÌÔÀ‡ÌÑµŽÑi¾TÎIìŠá[ì’ä•åcñŠ™„òPØ»ÌÖÌ×Ó‘®z',
                'tìýß¯ÌØØ–ÃŽï«í«äˆÏcÄ†ü’ÌÛ¯\Ž¸ÌÚÌÜbëøß‚¿gÎŸñÖ`ƒ£ÌÙòv»LöŒ»TÌ„óIìL†z–YÌÞÌÝÌàÌßäRúeúf…†ç°‚¨«ŸÌä¨ÉÌáœv¶”ç¾ÁHßXðÃ†Ù¬v½´YÓz¾ŸÊƒÎyÌâÚ„Ìãõ®ÖpÛ‡å÷–î}õ{ùYòfö[ù•ù—Ìå’«',
                'tÜnóeÜƒów‘øÌëÌê›¢ÙÃã©ÌéåÑŠÌè’óßPµ“WÌæ˜NñÓÑ{šóÌçó›­ƒóž»GÌìƒÌŠõÌíáLìjüVìpÌïŒÄ›pÌñî±®xÃb®ƒ®\ÌðÈJœÌî“ãÙ´[¾g´k¸Kø‰­kêDúcúlãÃéå‚†Š¤’×œL•‹¬_ÌóÓ`¯t±™Ìòï›ÓCÙqå`ìtÞÝ',
                't¬™²VÅq”þÙ¬ŽçÌôìöÂwÆKÌõŒýGÌöµx—lóÔÉ‚ö¶˜Ôòèäpì›÷ØöæÏCõæxýföœŒi•q–IÃxñ»ÕA¸I‹àÌ÷ôÐ½rÒ›ÚqÌøî\¼gÌùÝÆÙNÌúÍuƒcø‡ç“èFò…ãÌûï”÷ÑÌüŽØÍ¡ÆJÌýÂ[…ˆÌþŸN½–ì˜Â—ÂŸaÂ dß‹Í¢Í¤Í¥Üð',
                'tÍ£æÃµœs¹jÝãòÑ—þ˜wéƒöªÂŠÎbÖFüžˆN‚KŠÇÍ¦›àèèŸP¬EÃ‰Í§ïFÕPäbîcìh‡ìžçÍ¨¯]àÌÉŒ˜¿Ÿ×ÙÚÍ¬Ù¡Í®MŽä†LªIÜí•zÍ©›ÏžúíÅÍU±¶‚Í­Í¯»½pÐhÍªãPÙ×„çã~ï ÷‹äü•Ó–S™HšÔ ÕÄ€Í«õjÍ³Í±Í°Í²',
                't½y½ŠâúÍ´‘Q‘qÍµ‚ÊæBÍ·Í¶÷»î^Š‡¼}”«”ÓüWÌeÍ¸Í¹¶dÍºLÍ»†l›Þ’Øˆàœ£¯fÈ‹áäŒùWýC‡íÍ¼ƒòxŽêÍ½’¼Í¿Ý±Í¾ÍÀ—^“\¶•‰TÄ¯…¹\Ä]É\âŠˆDˆEOÛTõ©ñGå„òBùIùúhú“ÍÁˆMÍÂ›BîÊâQƒ·ÞƒÍÃÇÜ¢ÝË',
                'tùrÍÄªlŸ™Ø‡ÍÅ‡âÞÒˆF‘_˜¤™ˆæ˜¼aúoú™ˆCî¶åèœ¨Ñ‰ÍÆÉ—Ë”ÍÇëPîjîkînôs·~ÌLÛ‚QÃ•ÍÈƒUÛƒóhÍËŠÑìÕÍÉÍÊòDÍÌ…×–NŸlêÕü`ÍÍÆXâ½ØZëàÜ”÷ƒôë˜ÍÎÄ™ÙÛ®™ˆdØ±×™ÍÐšúð˜ë…ï’„ÍÏ›k‚MÇhÐ›Óš›ñÃ“',
                'tÍÑï€ô…ÍÔÙ¢ÍÓÛçAãûÍÕèÞíÈ³aÐ†ÍÒ½Fˆ÷õÉõ¢´PñW˜’ñjÛ|ñ„ñ…éÒõDørü˜ònö¾ò™üƒÍ×š¼âÕ‹sÍÖ—ø‹µ™EùKÍØèØÍÙÚ—šÍóê»X',
                'uÞm°iÑCÎ_•éÂ‰ŸH HÜxÉIÉ…ÂS·E› šµš¶ÆŠ–þšÄ–GŸ‡ÍCùæç”Å†ìTê[ŸeŒËš`ÁåwË€ÚJ°›”ÉÂqµs',
                'wÚ~º‡f†„ê‚ýŠÈXévêKêPØž·˜Š¹i²z†JˆåãŽÄÄŠänÖœžx½Œ–M“ÖÉ^‡—”NëoÅŸ’H‡ˆ’[Žh´jËh˜´à„Ïˆé‰î…Ðíië‰ìW›^ëøs×OŽ’šzì…²yÏw‰ŠÃŒR’ç­ŽœrÎT’Ú¬]Ùï“ãözŒÜ„¾ÍÛÍÞºÍÚÍÝæ´®|·“‹z†åÍÜ“‰',
                'wœÎj¸Dü|”…ÍßØôßœ…÷­ ³[Íà†ìëðÄeÒmící€Íá†·¸áËÍâÍäØàŠþŽ¦‰GÍå±›òêŸÍã‰Ïž³Íè„\š÷æýÜ¹ÍêŒññ’eÍæ¸Š¼w’ÂÍçÍé¬TØ™îBßÍð‚{†nÍìÍí±Dˆ¾ÍñÍï•Š—içºëäÝÒ•–—µçþÍîîµÍë¾O¾UÝnÛläjå†',
                'wÍò…d…e–v’ÌÍóÈfÂDä[ËHåsÙ–æ~Ú@ŒµŒ¶Œ·ÍôÍö“ƒÇÍõ©´ÇwÍ^ÍøûÍù¸Í÷Øèã¯ÈD•™—ŸŸƒÍ‡éþ¾WÎ\ÕsÝyž_÷ÍÍýÍüÞ‚Íú±ZÍû–RÎ£ÍþžùÙËåÔêžÚñ†Ò‹W‹nÌ“G“fœwŸŠÈ–ÝÚÎ¢—Ü˜LœÕìÐÔ•¿JÎkÓAŽUÞ±÷˜',
                'w°IÎ¡ögöhàíÎªÎ¤Î§àøãíÎ¥ãÇ_e›”žéífÎ¦ä¶Î¨á¡Î©Î¬†Â‡úáÍŽ®œ‘œ¿ ‘ß`Î«É–àŒ‘¬žHå…éõd°LÓW àìSÎ°Î±Î²Î³ÆYÎ­Î¯ì¿çâä¢æ¸’Ë›¾ÇUÚÃ‚¥‚Î™—|³uÎ®Úóó[½@ÎÎâ«È”ÉJó\ó]•¥—ÛŸ˜¬|ðô',
                'wÄ^ôºè¸ƒ^´SÎOÎVöÛŒ¾•ÊlÕ†ÛcílîQƒ¤žSå—õn‰Ãítï]žw”ÍÎÀÎ´Î»Î¶Æ„Î·Î¸ê¦Î¾³}Ç‹Î½Î¹‹yÎ¼â¬Ÿ£‰ŠÎµÎ¿ŸÝ Ò´o¾“ÎoÐl‘£è­MÁWÐoÖ^ð]õKÏGÒEðjÎºË—ÞEçAìG÷ÌvðŠ×~ÜZ×ˆÜ^•j‰eÎÂšœØ¬˜v',
                'wÎÁØn÷—æ’ðwö€ö“ÎÄ¨ÎÆÆ[žÉ³RÎÅ¼yÍPÎÃ«œãÓâ†ö©¯‡Â„ñbô•øYøjÎéé”ÏRéšü•êZØØÎÇ…Øì’^…ÝÃWÎÉ—SÃ‚ÎÈ·g·€ÎÊŠpãëÇ|†–œbÃ“h“‹½ƒî‚è·ÎÌÎËûlÎŠæfúOŠT‰RÇœåÝî•²²\ÂÎÍÞ³®YÀšýNÎÎÙÁÎÐ',
                'wÝ«†›óœuªiÈnà¸ÎÑ¸CÎÏÎÛbÎÒŠðŠñ’Ó¥ÎÖë¿ÎÔÅP‚¬‹_á¢ÎÕä×ŸsíÒ—çÄOÎÓ²Yü­xö»ý}ÎÚÛØvÎÛÚùÎØ–gÎ×ÎÝ›´ÎÜÎÙÚ„·—âEàw†èÕGÕ_¹™ÎøŒæuöƒÎÞÎãÎâÎá…ÒÎßÎà›žä´Æ•Ç`¬@µûcŸoµŸòÚÊ­NùM',
                'wõˆ÷ùú~WÎåÎçØõÎéÎëåüâÐâèâäåÃ•JÎä«bÎê‚W‚—Îæ†•ŠÕêõ« ‰]““ŸÊ´IðÄ¬Îè‹³T‘“Žåqƒ˜î®Wù^ÜRØ£ÎðÎñÎìÚã°Œä’NŒíè»ÜÌíÎï³J”–Îó„Õ’Îòš»|ßAÎîìÉæÄ¶ðíëFì}æðŠVÎœ×Îíå»Ÿ½Õ`ðÍöÈ',
                'w¸PëœýHìFýIÌFò\úF',
                'xšGŽß‰®’QŸL×¼YÅW™úœä‡båeKÕ™“©½oÍmÒŽŽQõqŽ`ôk…îÖ›Þ†Æ’œéšBàAÎ˜†ÛŸÀ _“Eé{é•é—ô\ãÖ—GÆSÓi‘¤Û¨ªB×ß€éIèGƒª×fŒ@ÈÞF’î“ôåæÊD¿]ÀMŠAˆ®›Ñ‚íÑW…­Ëöx—g¹a´šÒŠéf²vøŸÞBòœ½gÝ^œœ',
                'xîRÓn…ÃÀTˆlŽyˆgîy±rüŸýAäm½ª™›Q›‰„äàåŠ®žF÷ˆÉ‰AêR•všEšL¢“y‘¾‰·‡ZáœÇÌ_Ì`·SxÐiÇm¶[­ŒÙ‚“Ï×DãbãcŸœÖŽ‡I±P‡›j—«Ö[šâ™÷ÅO‘aÝ¡Á{Ên˜½‚]†éófŸò±½­‚É’÷Gõ@Ãa…sÅb´Fƒ¨„ðÌZ',
                'xÀvÀ]ž¢è•âlöwò}ëš¢˜fŠ™áŸ¿„ÇzïYŠ·ñŒj•g¹Gýa†Cã_ª“¹›ÎEŸù…®ËÞ´c’˜þŒOúZ™A“ÚðhðuŒÏšY±]ÉŠÚU¾–Û×í|’ÜÏ¦ÙâèÏ«Î÷Ò‚ÎüÏ£…kÎôÎöÎùñ¶ÃZÃ[‚`¹YÛ­ðœßñÞÉŠÖŒÊÏ¢•„šãä»ÎþªLÇb†ŒÏ¤',
                'xÏ§—Nì¤äÀœlÏ©ŸXŸ_¬NÎøÝ¾ÚTâR‚Ý¦Îú•‘ŸmÏ¬±–Ï¡ôÑôâÁ—ô¸àq…wÆÐÏªŸ›ðªÉYÎýÙÒ˜~Ï¨Îõ¾kòáØgðFÎû‡q‹ÄæÒ¯ŒÏ¥ðO„DéØ˜éì¨ìäŸçŸè¸OôËó£Î‰åa O ×²q´—ó¬ØGØHØlØ‰ÀGëvõ–ùTÓ}×@õµç^ë^ŽdêØ',
                'x x Þá@Ó‚÷ûÐPú Ó„è„Ï°àEÏ¯Á•Ï®êêÏ±—áÉjÉtídÒ Úv˜›Î€Ë@ÚôÏ­ÖæˆìI÷žïeòwò„Òu÷@óN– Ï´çôáãÏ³Ï²È}Ýßâ|åïSÝûãŠ‘‚‘ƒ•Ê™SìûÖL‰¸¿uÖlÏkÛ’­t÷^²—À{Üh…[…cÏ·ŒÁÏµâ¾…äïOÏ¸‚S_±_àS',
                'xš@À…¼šâMãÒ‰I—ÌôªÚiÏ¶øœëìù½”ÚVëKŸ¼ Ì·G‘ï•ÀÊ“ÓB‘ñü_‘ò´ŽÌŸðqô]‡½êSìUÐaÏºØB‚Òéi”¯ŸïPÏ¹ÎröyÏ»ÏÀáò‚bÏ¿èÔžÙÏÁêƒ{žþªM«”µ„íÌ¸—ÁŽÅ{ê˜œÀ³ˆåÚ“ŠÏ¾è¦¹d´WÅrÏ½¿EÊ›¿[ÚYô Ý å’',
                'xÏ¼æ_÷ïòhúTépBÏÂÏÅˆY¯KÏÄ—B²LÕ’‡˜‘³óÁ‰ìç]ÏÉ™ŒÝÏÈŠhÏËÙüë¯–}ìì¶iÆxôÌ«ˆÝ²ÏÆèõÑõ£ÏÇƒMƒm‡Jã”ÏÊåßí„‘œåv¿ÒDí†õrñMÛŸ‹ü`”s×]ÀoúNÒvÜ]Àw÷€Á…ûÏÐŠˆÏÒÏÍÏÌ’¦ÏÑÃjæµŠÞ‹M½L',
                'xÏÏÍpÏÎ†¥ðïÍ€éeðÂÏÓ®Qã•‹¸‹¹‘“Í½ÕtÙtÖPÝá_°B°GËûyµUÚDèvú‘ú’úšÙþªAÏÔÏÕšÀžóáýò¹ê“Ú`óÚŒ¯Œ°“{µ Í˜õÐ¹‘ªªžÞºå‚ìÞî‡ŽÒ”g™ÌÌ\«Ní`ï@ž¶ÏØá­ÜÈÏÖÏßÅ`ÏÞŠ«ÏÜ±hêˆ†ZˆŸŠ½ŠÒs•›×',
                'xÇ{ÏÝ¬FÏÚ±•½mÀ‰ÏÛÏ×»˜ÏÙƒgƒn¾QÕ^“È¾€ä}‘—˜ó¿håDðWØRžnÅ@«I¼`çoö±ýEÏçÜ¼ÏàÏãà_Ïá†“àlàmŽûÏæç½ÝÙàx˜UËGÏä¾|ÄÏåÝæøû‘™Ö­Ïâ÷`è‚óJ­˜ßÏêâÔ–ÙÏé½|ÏèÛKÏí‰ÏìÍJâÃ•}÷ÏÏëã}ðAöß‡»',
                'xÏ†õœí‘ð‹ð“÷zÏòŠ¢ÏïÏî«“ÏóÀ‘Èeí—Ïñ„âñ•ÚÏðÒVó­ç}÷Pž¼ž½…ëèÉ‚PÏ÷ßØèÕæçŒnÏüŽé|Ïûç¯ÌåÐû^†’Šë—nŸ^ªVÏô¯e¯hÏõ³‡·›Á›ÈpÏú“`½‹‡EšRäìóïÛX‡^‘‹“ßª”äNÏö–Ä…Ê’÷Ìø{·nº}ËrÏSÏ]Öyø“',
                'xÏùžtºÏvón‡Æ‡Ì™ÏóuújÐDò”š®Ì‡›©àUáÅÏýÔFÕqÐ¡Ïþ•šóã¹q°~•ÔºSÖj°†Ð¢Ð¤„¿†Dk‚jÏøÐ§Ð£›ßÐ¦Ð¥‚å”¬œøÔ‰‡C‡VÕ[‡[š^Ÿê”Â”ÃÐ©Ð¨ÐªÐ«Ï„µÐ­”ýÐ°…fÐ²ˆ•ŠGe’’¶Ã{Ã|Ã~Ð~ÙÉÐ±Ð³ªn½eÁ–†à',
                'xïÐ¯¬€½’Ÿ»ÄnÛÄß¢“û¾™çÓÎqÐ¬ÖC X”XíPÒp”yÀi×ýšÐ´ƒæŒ‘Ë†ÄžÂÐ¹Ðºµmç¥À‹Ð¶žàžá…lŠÀÐ¼ŒÈ‚ÄÇÐµŸc¶cÙô‹rŒÑ“aäÍ½uÐ»ƒD‰féÇé¿Ñ€‡ƒŒÔ•»í…ŽOâÝÐ¸Êâ³¼IËZÞ¯åâÛÆÒCÖx‰êžaå¬ yÐ·Ï’ý^ýk',
                'xýKÜaŒÚõóÐÄß”Š|ÐÃÐ¾ÐÁê¿–‚ÐÀ±^‚r¹âdÐ¿ÐÂì§Q‡Œ‡‹×Ð½Ü°öÎñQ–“ôgç†²€êc¿Ø¶ŒJžÔÐÅÜŒÃ’ÐÆÔMŸ{ñ^Ågîˆá…ÐË õÐÇˆžóUÐÊÐÉŸ“¬wÐÈÍÓq¹“¹žÅdÖ_•ÛÓwòH°‹ÐÌÐÏÐÎÚêéàD†QÐÍ›™è—ê€ŠÈíÊ',
                'xÑRè™â]ãoã‹ät²MÐÑß©ÐÓÐÕÐÒÐÔÜô‚†ÇnŠüã¬›ë‰D¾m‹ñÅBÐ×ÐÖƒ´ÐÙÜº×›úÐÚ†Mr›°ÃrÐØÔKÔžÐÛÐÜ×œÔw‰é”¸ÐÝ‚cÐÞßÝâÓžñžòÐßÃƒð¼Å^õ÷âÊ˜¼ã–ó…÷ÛæTõxø ð}æ™ïqÆvÐà½œú¼NÐãá¶«‹ÐåÐä¬LÐâäå½‘',
                'x­PÑfÎ¿ÀCçVçnýMÐç•B¯Líì™øñãÐëÓ’çïÌÐé× ‹€Ž­“TšHÌ“íš—ì· íœÐê·PÐèôq‡uÐæ‹Áš[¿HÊŒÎdš_ÕšÖžôzòè`ôP‚TÐìÉ[Ðí…éŠÚ¼ƒÛèò«‚»ÔSœ•• Ô‚à†ôÚõ¯±SÐñÅÐò›Tò…r›UÐðÐô•däªˆ¦šAš~ží',
                'x«—ÛÃ„Ô”›”¢ŸTÐ÷ÐøÐï†Ä‰ÙÐö•ýäÓÐõÔ[Ðá‘Aìã¾AÐîÙ[˜s…±N²W¾wÂ…ã„·V¾{²xË…ÀmÞ£…ºÐù•R†IÐû•tÜŽ—]ÚÎÐú‰H‹lËÐÞïÝæÈkêÑìÓ¬uÉ{²UÙØ¶P¹ŽÂAÎh‹ÖÊžÕÖXæMòC²ÂQÌBÌTÏ×Xö~×zÐþ«tðçÐü',
                'xÐý¬IÍ•‹Ÿäö•Ãè¯™e­v‘ÒÑ¡Ÿ@•œßxÑ¢°_Rãù•]ìÅÑ¤Ñ£Ðžîç¬K±†ÐfäÖ½ké¸ãCíÛÊRïàìœïX¿¿’æ›ÚK¯TÉHÑ¥Ñ¦íYÑ¨”ÄlˆyÑ§ŒúNÆ‹í´Ðû`õ½ŒWŽGÍ KÓ{ëzú›Ñ©˜ÝÄ}Å–ÞG÷¨÷LÑª…ÉV›‡ ü¯N–ùžûÚÊÚp',
                'xÖožyˆ_Ñ«Û÷Ÿ[„×‰_Ñ¬ñ¿ÊM„ë„ìË`ñ‡ ‰¶â´Þ¹êÖ `Ä²†ÌQ‰Ë oÀcõ¸Ñ°Ñ²Ñ®Ñ±–hÑ¯á¾âþä­ä±¼rÜ÷–Õ—Dš½«‘‚ÅŒ¤Ñ­“MÔƒñZà‰öà‡x”˜ßŸïŸñ @­RÒWÏy÷S÷\žµ…_ÑµÑ¶¾Ñ´Ñ¸ùáßªFÞ™Ñ·Ñ³ÓÓ–ÓœŠQÙã',
                'xš¦ßdôÙb‡eÞ¦îšèRÓõ',
                'y…¥ÙŒµK×rìaÈC‹jÈ€¯uéœùgù“••›¡‹‹Á‰¥òˆîY¬„Â]’…ìÓ”‹P‹’F•iŒßŠ´ˆ×“~é‘Ÿ¸ŠmøNÝ‘‰àŸ‚ÐMœÄÑr¾ÏX›þ‡©™ö­’Ýk†¿“Ní‹ŸºÐ„ŸÑ‹ÍY‡‚²ˆ’~«lØ]ØbŒ¢½ÄžìƒeµÇo‚\›s“AˆRƒhØ‹ï…ŠxŸ]ç~žÏîƒ',
                'y@ó–˜·Ø‚™µÜVÝ`”^‹ «Q–ü«DÝr’íŒTƒŒí±†Ç‡y˜®‡§è›Sý{ˆøÛpèŸåWÑv¾_ãUÄdÁm“êÚ_šJšüÁ”ÎƒÝl™LÊ‹ÆÊäJä„’´ŸSØßÍF¿IÀK÷jâPãA¹•‘÷ÖuáŒ†dÕfÕh qèp—V¹SãB«}•@åUœ«„üø˜ÚŒfãŽ—H¹c‹U‹š†',
                'y„Í‘›â’L’¨’É öÞÔq±†œ^›ðŠ€Œ² V¬^¾S…y¯_Ëe…°˜XÞdÝ˜Ýœ„ØÄŸ›@›AžõšT…ÇàNŠÓŸyŸÁÕOš]”¯P´l‹ÍËW†mœ¶ÐjëUŽM³wÁwüGÔ”lèH›ª¼œ½X¾ŠÔDÃ‘Ñ„Ñ…äPªËv÷r˜CÞje¡Ñ¾Ñ¹Ñ½ŽâÑºÑ»èâÑ¼ŒS',
                'yè›—¿øfåEø†‰ºùsçŒÑÀØóá¬Ñ¿…ƒ–‘çð¸ŽÑÁˆÛŽÑÂÑÄªc¬ˆíýÑÃQý\…|ŽÞÑÆ†s†¡ðéÑÅ¯{Ê‹„²ˆLÑÇ·ŠÒÑÈ„ ëåÂ†«eÛëæ«’¥í¼‚oë²ˆº‹I’éÓ ÞëšåªmÂyˆB¶–¸Eý…ÑÊâû„‰ÑÌ«ŠëÙ‚¹áÃÑÍÑÉÝÎÑËäÎëçƒBŸŸ',
                'yÛ³æÌvö˜ÜáZéŽ‹éºc‘±ÅEüiÚ¥ƒÒÑÓãÆÑÏåûÜ¾ÑÔÓ…ÑÒ•VÑØÑ×àIŠ¶ŠÔªPÑÐÇrŠ×ÑÎ¬J³xÔPéZÑÖ»¼óÛ½žÑÑ‰c“C—ðÔ´NÊBÑÕÌšé…—éÜîî†‡À‰ÁŽiº™™¿û’‰ÌŒEŽrŽsŽv™ëµhû}ûš‰ü’Z›WmÙðÑÙÙ²ƒ¼…]m',
                'yÑÜÙÈØÉÑÚÑÛÈTÛ±áD°Ý‘þ“R—¦œ{œçüßVëC—ã³šî»ÑsÑÝÑŠ‘îÎi÷Ê‡{Üy¿t™•üd…˜®[öoùžüfýdýŒƒ°üjükî›ýBŽt•óô|÷úýzüsÑáŠzÓ_ ²Š°©ÑåÑâÑäÑçêÌÑÞÒÑé‚©’ïŸgÑèêš†ÍÑß”©ÑæìÍª_³ŽÈŠÑã—âäÙøH',
                'y…’‰†•¶ŸÌõ¦‹ÇÚÝ÷ÐøeŸðÑàÖVØÍôe•àø‘àòVòY‡²‹÷ÆFÙžÜ‚ wázòzú`ž¥ÚIÓƒ×…á€ðòžúŽÆGž á‰óFž·×—ØVØWž¹Ñë…óŠš’tãóÑêÃo±jÑíÑìãZë‡÷±å}ø„ÑïÑòêgÑô•DÑîì¾Ñð„½šÞÑñè–ïrˆ”áà•[ÑóÁfìÈ«Œ±ˆ',
                'yê–¤§“PòÕ”®•ª—îŸ¬¶@¯ƒÖUÝŒåø—ï^ç{öuìRûF…nÑöÖˆtŠIŒ÷ÑøžæÑõÑ÷½D‚ê˜DÝIûšçÁyðBñ‘Ä”ažY°WµSâó–³í¦ÑùÁkÔh˜”Ñú˜ÓçÛØ²ßºÑý–”µnÔ@†ºÉ@—êÑüø^ÑûØ³Ò¢Œ¸ëÈˆÒ¦ié÷‚xž÷çòÒ¤‚çˆò“e',
                'yš¥Ò¥ÝU†Ú‹„áæç“uÒ¡ªrßbÒ£“Á•¬˜l¬ŽÑþã“ïuïŸŽAŽCÙ´t¸G¸HðPôíÖ{Ö|÷¥ï_Ìiî–öŽ¦ŒaŒë’qèÃš| úÆwÒ§–Ì±l·ñºÒ¨‚¶‹QáÊœÈ˜eø€é™ò[ýoúr·ŽÒ©ÒªÐ‰·š¹OÈ™ÔoŸÆÒì‰ª’ðÎËaýGê× dÅ—ËŽ²‡•êÒ«',
                'yÀfú_×Šè€‚œÒ¬•¢Ò­£ÐJÒ¯Ò®’ÀÞÞîô ”âXäyæU”IÒ²…½ˆÒ±ˆ¸Ò°‡Sc‰­ÒµÒ¶Ò·Ò³ÚþÒ¹’w‹–¥›í“êÊ–¦ìÇÒ´ÒºÚËˆìš‡Ò¸È~àv‰¢˜G˜Iñ@ƒp•Ï•ÐšSŸî”@°‡²wà’ØÌŽIŽJÖÖ]ðY‡™”L•â²|æE”K {µBædðvùw',
                'yìvóBûEÄŒŒèÒ»oÞvñÂÒÁÒÂÒ½…À‰ÒÒÀµtßÞ›¥â¢®ŠàcÒ¿Ò¼Ò¾ì¥Í~¶B‹¡äô·Fãž‹Âàæ‰ß­Cûp¿ˆ™š­át÷ð×búsüpUÒÇ…FÛÝÒÄƒÞŒbÒÊÚ±îÒËâù›n ôÐtåÆâÂß×ÒÌ[‚q–ª®AÜèêÝÞ–ŒhŽƒ‘ü–Ø–õíôÒÈÐ‘ôýðê',
                'yÒÆÈU‹f—×ÁrÍ†ÔrÙOÒÅ•—àÕBÛDí›ÒÃïÒÉƒxŸÛßzŽK£¤Î’îUîVŒ–áÚºmî{õkÒÍ¥Ö–çF»JÓ~×‚û@ÒÒÒÑÒÔÞ~îÆÌ”ÒÓÜÓÆqŽåô¯ÒÏáÒÐ‘ý¸”Þ ‚Ã©”îÒÎârãiøCì½Ý}”¹Î•™}µEÅœÏî‰ÞTýtVÒåÒÚß®Ø×Òä',
                'yÒÕØî„ùÃEÒéêdÒà±ÒÙÒìæÆNÊØý„·ß½ˆ`ÒÛÒÖ•ö–pÂkÆiÒëÒØÙ«…å…êá»@âøÒ×–›užËÒïÒèæä‚XÞÈŽ•Ž–ÞÄ–¤›¶«pÒßôàÐzéó†jˆ£ã¨ÞÚ–å™ý›Å›ÎÒæÐšÒêØ—ê‹„ÖˆËÛü–š¡®Ápñ´ÒîÈ^ÔTÔUØ[Ø\ÒÝâNëc',
                'yŽ¯”§•”—©š…œ™Ÿ|Í‚ÔmÚ˜âzó`{ƒÏÒâÒçª~¯m¸vçËÁxÒÞÒáÑ`Ô„„ã‹M˜]ðùÄjÉšòæìˆñkƒ|“Ì˜¯ÒãìÚŸÖŸé¯ŽÕxï×ûkûoü]ØæˆI‰©‹Î‹ÚŽF‘›‘«•ËéìÛ D¯–²e·j¿OÅ’Þ²ÎœÒAŒ•”¾•Ù™jšc J WôèÒíÒÜØŠõl',
                'yñ¯Ë„Ë‡Ù“æ„ïîÀXÀ[ØsìJöGù€ùù‹ž‹Ì[×g×háyá{ð†‡ÒèOú^úgÜ²Ò~óAú…Ìˆúœ×”ý~]‡àÒòêfÒõðˆŠÒöä¦ÒðÒñÒôóS–ðÒóë³êŽƒø¶†ÑPî÷ê”ê›à³Ü§‹AÖ¹N½sšPœÞµšÉMÊa‘@¯ŠãŸ´€¾žìÖNë–ñ—‡‘ž@éžë í',
                'yƒÜÒ÷ ìÆgÛó›Ž‡ô|žôáþ«»ƒÇZÓ—†‚‹HÒú•ŸÒùÔCÒøâwý‡œô´HÛ´â¹Ê_ÓÕzãyö¸‡wš’­K‡¨™ƒÏrö¯ý]ýlúÒüÒýßÅÒûò¾Òþœ^âYâiï‹ëLì‚ï‡–@Úy™añ«ë[Ž\þÏPÌa™Ó°a×Ó¡Üá›Ø·ˆ¤œšªZJáS‘\°E‘€‘',
                'yõg‘¶™’Ó¦êÓ¢‚Ÿ—@«›Ýº†¦Ó¤‹káœ€À†–PŸ–çø‹”´QéAàÓÞüœî®O¾xÓ§ó¿ÎsÙaÓ£è¬‡|À”Ñšë›øŠðÐ‹ë‘ªâßíŒ®ZævÓ¥úD‡Â‹ýŒ[”tž‰À›Ìc™Ñ­‹µ_×súLè]ÀtÐNúˆÜ…ú—ûKûW°ŸÓ­ÜãÓ¯ÜþÓ«Ó¨Ó©ÓªÝÓÍw†Óœ»œÁ',
                'yÈtƒO‰LéºäÞÝöäëŸÉÓ¬¬“Î„Ùø I¿MÎžõöžLËpÓLÖhÓ®Žc”l”wå­žuž„Ï‰™Õž¡»Yž­ÚA»k³AÛ«—wò£ïIÓ±“²Ó°}ñ¨·fîeŽg_ç°`Ó³•£Ó²ëôÄ{ì™ž]×GÓ´à¡†ÑÓ¶ÓµÓ¸çßÓ¹‚ò†Þà{ÓºÜ­‹£ã¼K˜Ÿ œ‡‡ÛÕ“íÑ',
                'yàaïÞÓ·°MëtçO÷«bžœ÷Ó÷Iúx°bà¯ïJî„öÓÀð®Ó½[Ó¾Ù¸ÓÂ„Ê–Ôˆ¬~–ºÓ¿ÓÁ‚æ¾Óœ¥³‹Ô‰MÓ­òÓ¼úÓ»¶H÷‘Ûxõ—ÓÃÆo³lákÓÅÓÇØüßÏQ›|ÓÄÓÆû~H‘nƒžà›‡¦‘ÉžX™¢ÀlÂiÞÌÓÈÓÉ›YÓÌÓÊJÓÍÃUM',
                'y”åèÖðàr›Á¶xÝ¯ÇxÝµÞœà]ÓË‚ºòÄÔIßKÓÎªqß[öÏ˜Aéà÷†ÝjñfÊ~òöôœÝ’õO™ÔßˆÓÑÓÐJØÕÆhÓÏÁhŽîÁgÝ¬—XÂuÃ…îðœ±ÉKµ™ÍœäB˜©ë» ¨÷îÓÖÓÒÓ×ÓÓÙ§ŒM û¼n†NàóŠµå¶f ¶µvÓÕÞ”†e—`òÊŒØzÓÔáRÕT÷ø',
                'y’GæúÓØÞ}·‹ê|¼uÍG†‰ÓÙ±EÓåðö¹zÓÚ€ÓèßŽ­Óàæ¥’T–fì£«]«_ì¶ÓÛô§ÐsÓãÓáƒÊØ®óÄô¨ÆœÇSŠÊŠØÓéáüÚÄáCâÅÓæÝÇâDêœÓçö§ô~ˆèˆï£·áÎÓäÞí˜KœŸ®Œ®³†ëéÓâó^ÓÞ˜@ÓÜšQ ¢è¤Å„ÓÝêìO²Iñ¾ÓßÑˆ',
                'yšuÁ|ÊvòõÕ˜ëkðNôˆ‹ä‘µÄÓDÛuše­mÏLÝ›å“µHÖ~ókõ‚”ù»BòeöVöiú}ûCÓëØñÓîÓìÓðÓê‚RÙ¶’§ÓíÓïàô}µ€‚¦…Pàöâ×” àhÈgÈhèž‚øŒ†”Ñ—å¬rðõÅcÕZñÁäoö¹‡‰ŽZØ…”Ëû‡ÌPýrÓñÔ¦í²ÓóÆRåýóâÀÓýÓôª',
                'yêÅÓü¶rÆ‘‚qÓø–ëÔ¡³_îÚÔ¤†¸ÓòˆÖƒ±ÓûœMœUÑ@ÚÍßNãÐ†³†ÉÓ÷‹VÔ¢Ž÷Óù—™—š—§Ÿ~¬Z²œÔ£Óöï„ñSðÁÓúœùìÏ·CÁNÉfÝ÷Óþâ•îA‹žî‘íØ¹ªz¯¾sÎCòâÝhãƒëT‡o‘j·UÉ™Ê Ô¥ßyä`ø\ËŸúìÛÊšÖIå[é“øƒø…',
                'yøˆƒ™´›¶RôrðÖ°KµN·{ºh¿›áqùO™Èð|Ì]×uÞXçŸìM™äòå÷»Z÷Nú–ûO™óÜ†ôcôdžº»n Œ‡äð°„uÔ©…€íóÔ§ŒwœaœeÔ¨œm­œYÉA—¥ÉdÍ›ûgóîøSÎQñrä‘øx‹õùtž”üŒüÔªÚOß–Ô±Ô°ãä–zÔ«ë¼Ø’Ô­†TÔ²¸ÍWÔ¬',
                'y…ŒáJ‡ûÔ®œ®ªjÔµâƒö½ˆ@ˆAÜ«‹…‹Ô´œÆÔ³ªxÉV˜g˜rÔ¯¾‰¿FÎmÎzô’éÚÁ~ËQó¢ÖwÞ@üxæ…™´ß‡ò{ù úM…™Ô¶±\ßRßh‰íÃOŠ†Ô·Ô¹ÔºÛùÐc‚ÓæÂÞòè¥µžÔ¸ÑjÑ†Ñ“‡…îŠÔ»•õÔ¼¼s¹–³E¦§ÔÂ‘àë¾Œé’`µjÔÀ–†«h',
                'yxÔ¿‚ÔÃÍQÍRÜ‹îáÔÄ’ÕÚ”Ô¾ÔÁÔ½â_»›ãXé†é‡‹íéÐºMŽ[Ùß»Cå®Ìgüg ~¶^ÜS»aûN»lý›ûVÉCŸ±ÉQŸ¾Š[Î‚ÚSîfñNÙšÔÆ„òÔÈ»…Ô‡çŠu’l›Vç¡Ü¿êÀ®s±d¶nÔÇ›é¼‹ÔÅÂmàyë…äëµœÝ¹oÉlšèŸÂ·Ê|ä]˜øºJ¿a',
                'yÀIÔÊêmŠ@’dáñ«jÔÉÇ\éæ†½âqëEšŒÑŽña´pìBýqýyÔÐÔË–—Û©ã¢ÔÎàiÔÍ‚ÖÁã³Àˆß\‘C•žÄZè¹ÔÏìÙ¿AÊ•ÔÌ¿ZÊŸÙ„ádájðaËœíríyÌNíß@',
                'z”±’Ã‡ÍÖ…MÊiƒÔ‚È…‹Žúò’K’·“cÛ‚Æƒ]™Ù‚t³¤ŸéLéMü…ü{ÖšÖnÞêâ\Úf–bÃw‘~»Ãq½‚›‚šlßgßtÞŒ×rÑ~¾…ÎuÏx¼—“o—¹Ô—Ëg‚¸ÆcãIÊx‚÷úE‚…ˆ§¹Šæm¼ƒœ·åÁÄJÚ}ýwódËF›ÚÄÉ˜ºŸÐ¾‘|ƒœ',
                'zõ¡‡m™ç·‰ºeé˜§º‚y¼¾\îx‰–’ŽÛZ±‘ÊP„‘ÛünáGÁŸºa’† ¹Óh†“ŸÎ[ÛyücøJÕ{Ëyà©Å\öl±‚ü‡–’„†ÂZ´qê ÄR‰ïš†Æ–Ã˜ÞÃiÚâÚM‘ßœõ²G ³ÚC‹¥†‘—ù‡­uöa·}—ä´DøZðe–çÑIžRžˆçZÀU”T¸tøF³^É›',
                'zýeIÛBÃëh’ÁßI®›láB×`óGªK›m“¯Â™‡ËâW…µoÍVýR´„â`Öt¾PÀRÇŸˆ½ÝXõ›ÇŒþwÛI®l¿‰››ºd¹€“””zãJŒ×R~âžßmäK™yË\ËŸúžŒ¥ÌŒ²Bº‹ñ~Ç Òf Ã‹qËS‡¢ç‘‰\GÂzÛ@âŸãnª‘·r¤„Œ„–‰t“»`ºiŒ¾',
                'z•H†”÷ï‚–lñXóCêuÈ[ÌEÂvî“áWåM“ë’V–y†A–žõaíCä\õSö]æcÉ|’Å‚´“ü–sŠ‰¶h–ñÝWZ”Õ›ÆäVâ™ˆSšõŽ‰ÔÑ›eßÆÞÙ›j–ý¼’¼™ãNô˜ÅHÅNÔÓÔÒíˆëj´’ÒSës‡Ùë{žÄÔÖçÞÔÕÔÔžüÇœ…œÖ²PÙ†Ô×ÔØáÌÝdÔÙÔÚ’D',
                'z›’‚îáPƒ„¿fƒ³ôØô¢ºç‡ÔÛ‚Ì†¹êÃŒv“Ëƒ›ÔÜƒ­”€ôõÚŽÔÝ•ºÙmÔÞöÉà™žUÛŠàŸ­ÙçYè¶áA‡Ôž£×{­‘¶`Ò{×“ð• ™ÁnÔßÙ_ê°ÙjÚEóvÚNæàñzÞÊnÔà‰ZÔáäQÄ ÅK‚óÔâÔãÛ›ásÔäèÔçÔæ–ÒÔé——­FÔè­bËkÔåÔî',
                'z°oÔí†rßðÔì—_†×‘VŸ¯ÅÔëºrÔï¸Y×YÚ‹Ôê¸^†¨ÀÔò’k›gÔñ›zÔóÔðåÅ„t†‡ßõàýóÐô·ØŸœÚ²ž‡K‹¨Ž¾óåÊj˜ÁštÕ‹ØÓ“ñÉ°ƒ²cºjÂd´ŸÒ]Ö‰Ù‘Ïý`ývûBØÆ‰÷ŽÙšòê¾•W’¾¡¶ÔôÙ\÷ŒÏŒöf÷eÔõÚÚ×P×U‡×•û',
                'z‰ˆà‹ÔöÔ÷çÕ™IŸå­Q³D´ŒîÀ¿•ÖŸ÷_ï­ä{êµÔùÙ›ß¸ÞÕ¦’s’Ÿ–¼ßî‚¼ÔûÞêÔüœÑé«„ž°•¹†˜ÏÓu°š×A÷þýOÔúÔý®hÔþÜˆÕ¢ÍlÕ¡Ÿ¤ £élëåŽ×Q…~ÆzÕ£íÄ“ƒ÷‡÷ÛzõWõ~Õ§žÁÕ©ßåŠL–ÅÕ¨ŒoðäòÆÔp“’“«Õ¥ám‰ã',
                'z»y’ÆÕ«”ÈÕª˜zýSÕ¬µÔÕ­ãSÕ®íÎ‚ùÕ¯ñ©Õ´Õ±ì¹–îÕ³Ítï¬ÔaÚjÕ²énÚÞ‡~ŽEËUßë•šÖšØÕ°ûr”ö×dðŒø@ò ô}÷gûD×–’€Õ¶ïsÕ¹ÕµÕ¸”Ø¬WÞø±Kãä˜^Õ·ïQ‹¶á\˜öÛ…Ýš°œürÕ¼×Õ½Õ»—CÕ¾‚·ÕÀÇ•—£Õ¿‘é',
                'z¾`øÝu‘ðÌ›ÌœÓOÞJÕºò–ÕÅ{ˆÕÂƒ@ÛµæÑÕÃ‘PÕÄâ¯» ÉŸßl•ÀÕÁè°ð\ó¯çbò†÷Jû–ØëÕÇ›îÕÆqŽÇ´˜ì ç•ÕÉÕÌ’EÕÊÕÈÕÍÕË»wŽ¤Ã›¯oÕÏ‰záÖá¤Ù~¯“ÕÎ²dÔîÈŠ„Ž‚ÕÐÕÑžÝ±@á“ßúãDñq¸Så™ ÕÒÕÓ¬ÕÙÕ×',
                'zÚ¯––ˆªDÕÔóÉÃA”íèþÀ’ÔtÕÕÕÖ¹|ÕØÃDÚw•× Yõe™˜²Á^òØ‹«ÕÚ…zÕÛšy³K³Y»qÍEÕÜˆ³»„ÐŸ†£†•†•‡éü†´—‘ÕÝÔ€ÚØß¡Ým˜µíÝÝtäOÕÞÏU‡¬Ö†Ö•õ„ÞH×yÒx×„ÕßÕàô÷ñÞæNÕâèÏÕãœJ†øÕá˜ÎðÑÏVúpÕêÕëÕì',
                'zä¥Õä«‚Ø‘Žž–×èå±wÕæÕèìõá˜‚É”ž—FáIŒzœÈœßZ“ŽÕå˜Eª€ÕçµÉRÝèâœìké»˜ˆš‹¬‘´U¶G›óð˜çØÕéËmågÝŸåŒæP»E÷yŒÇÕï’rÕíŠª•_ëÓéôî³Õî±pÐ½GÂrÈZÑ]Ò˜Ô\ÝF‹çÇð¡ñ}¿b¿jÞtôIümÛÚÕóÀƒ‚E',
                'z’™ê‡ð²ÕñëÞ–Ú¼…±‡êâ‰`“L½„Í–”´ÕgÙcä‹ÕòÕðøcææ‚ül„JÕùÍŠ’Õ÷Õú Žá¿ÕõžÚÕøŸA±kîÛˆÁ”˜’êªbÕöÂtï£‹o“@óÝÑ± Õôã`Õ¹~áçÛtºPåPô@°Yšé’c¼lÕü’ð‰^•“ñ“ÕÕûÕýÖ¤ÚºÖ£Ö¡ÕþÖ¢Ž¬Ô^àÕŠ',
                'zøg×CÖ®Ö§Ø´Ö­Ö¥Ö¨Ž›DÖ¦ÖªÖ¯Ö«¿èÙìó¶o¶qÃeëÕÐ}Ð‚u¯Uµ…¶~Ö¬ëb—d‘ç—ÐÅ]“w¶A½˜uÖ©ñ\øTÖ}ø¿—Ìuü~¶_Ö´Ö¶ˆpÖ±Š©‚ŽÖµÂpá™ÛúˆÌÖ°Ö²Ö³µ•ôêõÅ­•‰~Þýñc‹À‘eZõÜ˜àÄˆ¿{ÂšÏdÛ•Û—ÜÜUÖ¹',
                'zÖ»„M„¶Ö¼ênÖ·ˆ^ŽŽ’W›E›bÖ½ÜÆ’nìíÆ‡åëdÖ¸è×›œ³Uéòœ]¯W¼ˆÔJÖºÝTíéõ¥ËŒÒjêeÖÁÆWÖ¾âå’XõôÖÆ…„ˆ€àùÖÄÖÎÖËÖÊÛ¤‚fÖÅŽæŽè’”–»èÎ›±µwÚìŠÍ¼Ö¿•yèäªOÖÈÖÂÐ—êÞéùv‚ÀÃÖÀ—„ªa®‡ÖÌ¶ƒ¶ˆÖÏ',
                'z¼•Á“Ð˜ÓdØ èœðº‚ÐªåéÖÇÖÍðëòÎæïŒ…D“ˆœí¶žÖÉ¹eÖÃÛNÝeé@ïô‰y˜—œþ†¯F¯€ÑuÒžÕIã‡ŽÃ‘p“´žŸÜ·Wëùö£Ù|õÙäk”òž\¿@ë\ñ‹øvƒœ„¬‘Á”S”`™±·aÏH‘ÆÙ—™£­}ÓzòsöSµYØTòòŽÜWúvèeØUÖÐ«›O„d',
                'zŠq³Þ‰ÖÒ›wžÆÖÕ–°ÖÑÐxÖÓô±ÖÔ½Kâ{ŽºÊWïñÎ ø‚ó®æRü™Û çŠ»bÖ×ÖÖÚ£†ÁŒ»‰VšpŸŽÄ[¯~·NõàÖÙÖÚŠt ðµrÆ Ð{ÖØÍ\‚£±Šˆú‹g¹WÐ\ÖAÖÝÖÛÖßúÖÜ›ÖÞžë×žžö«‰ÞbàX‹BÅœ@³BßLûb†µÖàÚQÝcã{ÙkÝqë“',
                'zñ™‡œ±TÖaù@òL×pæ¨ÖáÝSíØÖâÖã¯JÈF•Ž²H¹öBæûÆ…âÖäÖæç§ƒÙ†BÖç¼qëÐÝ§•ƒÖåôü»‹È’Ôk®Lƒu°™ñt‡€¿UÖèô¦»Q»NóEÖì„¸ÙªÖïÛ¥ä¨ÜïÖêÖéÖîÖí³pÑNîù½ZÖëÕDÛHéÆäóÎwãéÍÖTØiñ–õfø–žzË ™½™Áü}',
                'zö^ÐEÖñ›{óÃžÛ¸‰ÇAÖò·”Öð¸˜ô¶ðñÉ TÏŽõî÷E„±ŒFž¯”á•ô™î ‰ÐWè“Ö÷ŒeÖô³dÁCê•ä¾Ÿ—ÖóÔ}Ööî÷æÖõŒÙ‡Ú²šØùÐ×¡ÖúÀ‚Æ^ÜÑˆ|èÌ×¢ÆrÖüÞŽ×¤‰ÔÖù–ÇšŸìÄ×£ðæ±vµ‚¸mÇd¶‹¼Ÿ½AÁqÖøÖû­ÖþÔ]ÙAÚŸ',
                'zÝOÖý¹hãLïŒñ[‰£óçôã˜ÖäŠñvºBºZë—û„èT×¥™tÄºœó˜×¦×§ÛJ×¨…¡ŒŸ×©Œ£à‹§­A®UÄxò§´uÖKÏmî…÷H×ªŒNÜž¸|ÞDžÀßùˆæÉE¬ƒƒQ×¬×«×­âÍ¿xÒNÙ×Nð‚‡Ê»M×±×¯ŠyŽáÇPŠÏ×®Çfœ³»’×°Ñb˜¶¼PãÜ×³‰Ñ×´',
                'z î‰Õ—[Ÿ`´±×²‘Þö¿×·æí×µ×¶åFòKùx›d×¹¸ŠÜ×ºã·®IçÄ®•³›Äi‰‹¾Y×¸¿PÕ…á^åYðU´œÙ˜ÞVèVŒdÞ„ëÆñ¸×»ÕÐq×¼ˆÍƒýœÊ¾MÔR¶›×¿×¾žãÙ¾×½×À—‡äÃ—¬¬k¸B˜‘·q·‡ÐXˆV° æ×Æ…¬Šƒ×Âí½×ÇQä·ŸOÚÂ×Ã',
                'z×Ä†Šß—z×Å”Ù•Œ—Á×Á”Ú³˜·ŸÁM“â“ð”Ûìú„ŸÕ}ÕŽäráºWßª”½”Þåª™·Ö‘ïíè@ùhž•Ï—èC»Sú|»m×ÐŒI×ÎÆ†×È×ÉŠœ×ËÆ–ã«R¼|êß×Ê ×Í¶‡ç»ÚÑÚa†êæÜáÑ—Âœ¹×ÌÈŒê¢àtŒUµ›õþÙDÙYôôïÅ·T¾lâˆéCö·Ýwüˆ',
                'zÐÖJÚƒÝ–åO÷ÚööæSætîoîpõ™ùƒýUö‹ýb×Ñ×Ó…»Š—æ¢–j³I¶fÃc…èïöñèÍIóÊè÷âB†×Ï×Òö¤Ô`˜h™U×Ö×ÔÆTÆ“‚•„í§ ¼×Õ±{íöÃhÃun†€×Ú‚×ÛóWˆî¸¾È×ØªfëêÈ –Q—ÞÙ·O¾C¾hŸÙ¾›ÂCÅ‹ÎxÛr×Ù´†Øq',
                'zÛ™òR××òiôAôiöRö`èQ×ÜÙÌ’Ö¼ß“K“i‚ôÉ~“¨¾t¿G Q¿‚æCçE×Ý•f¯S‚~ª`³ŸôÕ¼F¯—¿kåS¿v×ÞæãÚÁàYÚî’ôÇˆ—¯—°àu¹t¾jÕŒÛ¸öíöOüPò|ýÚ[×ßõ•×à×á‹ƒ×âÝÏÈ{Éa…a×ã×ä†XŒœ×å‚ú·B¹ŒÛnÛ€ïßæ—×ç',
                'z×è×éÙÞ •«~×æ½MÔ{ì†æŽÖŠ„®õòèjÜgèÀFçÚ×ëÀj»gÀy×ê“Sß¬…‰–K†÷˜áÏ`Àxê×ì‡’û­r–˜–è½SáE•×îµ‘×ïÞfáUÞ©×íŽT™däŽå@™i·s™Þ×ðý×ñé×¿ŸÀ–ùŒç÷®÷Vú•ƒV‡gß¤×J’Äã†×ò¶}Çg’Û—½Èy¶š¹iâ—',
                'z×ó×ô¿–×÷×øÚèŒõŒöâô‚F×õìñëÑßò×ùÐŠ×öÈzÉïŽ¼d…ø');
BEGIN
  Strlen := Length(Str);
  RESULT := '';
  FOR i IN 1 .. Strlen LOOP
    Tmpstr := Substr(Str, i, 1);
    IF (Ascii(Tmpstr) >= 1 AND Ascii(Tmpstr) <= 254) THEN
      RESULT := RESULT || Lower(Tmpstr);
    ELSE
      j := 1;
      LOOP
        Tmpstr2 := v_Py(j);
        Strlen2 := Length(Tmpstr2);
        k       := 2;
        LOOP
          Tmpstr3 := Substr(Tmpstr2, k, 1);
          IF (Ascii(Tmpstr) = Ascii(Tmpstr3)) THEN
            RESULT := RESULT || Substr(Tmpstr2, 1, 1);
            k      := Strlen2;
            j      := v_Py.COUNT;
          END IF;
          EXIT WHEN k = Strlen2;
          k := k + 1;
        END LOOP;
        EXIT WHEN j = v_Py.COUNT;
        j := j + 1;
      END LOOP;
    END IF;
  END LOOP;
  RETURN(UPPER(RESULT));
END Get_Pinyin;
/

prompt
prompt Creating function GET_WB
prompt ========================
prompt
CREATE OR REPLACE FUNCTION EMR.Get_WB(Str VARCHAR2) RETURN VARCHAR2 IS
  RESULT  VARCHAR2(200);
  i       INTEGER;
  j       INTEGER;
  k       INTEGER;
  Tmpstr  VARCHAR2(2);
  Tmpstr2 VARCHAR2(2000);
  Tmpstr3 VARCHAR2(2);
  Strlen  INTEGER;
  Strlen2 INTEGER;
  TYPE WB IS VARRAY(500) OF VARCHAR2(2000);
  v_WB WB := WB('A÷¹÷¸÷·÷¶÷µ÷´÷³÷²÷±÷°öÆõ¼ôëôèòËò©ðÙðÅð´ð°í«êîêêêÛê±ê¬éÑåÂß°ß¯ß®ÞþÞôÞÃÞÂÞÁÞÀÞ¿Þ¾Þ½Þ¼Þ»ÞºÞ¹Þ¸Þ·Þ¶ÞµÞ´Þ³Þ²Þ±Þ°Þ¯Þ®Þ­Þ¬Þ«ÞªÞ©Þ¨Þ§Þ¦Þ¥Þ¤Þ£Þ¢Þ¡ÝþÝýÝüÝûÝúÝùÝøÝ÷ÝöÝõÝôÝóÝòÝñÝðÝïÝîÝíÝìÝëÝêÝéÝèÝçÝæÝåÝäÝãÝâÝáÝàÝßÝÞÝÝÝÜÝÛÝÚÝÙÝØÝ×ÝÖÝÕÝÔÝÓÝÒÝÑÝÐÝÏÝÎÝÍÝÌÝËÝÊÝÉÝÈÝÇÝÆÝÅÝÄÝÃÝÂÝÁÝÀÝ¿Ý¾Ý½Ý¼Ý»ÝºÝ¹Ý¸Ý·Ý¶ÝµÝ´Ý³Ý²Ý±Ý°Ý¯Ý®Ý­Ý¬Ý«ÝªÝ©Ý¨Ý§Ý¦Ý¥Ý¤Ý£Ý¢Ý¡ÜþÜýÜüÜûÜúÜùÜøÜ÷ÜöÜõÜôÜóÜòÜñÜðÜïÜîÜíÜìÜëÜêÜéÜèÜçÜæÜåÜäÜãÜâÜáÜàÜßÜÞÜÝÜÜÜÛÜÚÜÙÜØÜ×ÜÖÜÕÜÔÜÓÜÒÜÑÜÐÜÏÜÎÜÍÜÌÜËÜÊÜÉÜÈÜÇÜÆÜÅÜÄÜÃÜÂÜÁÜÀÜ¿Ü¾Ü½Ü¼Ü»ÜºÜ¹Ü¸Ü·Ü¶ÜµÜ´Ü³Û´Û±ÚöØåØáØÓØÒØÑØÐØÏØÎØ¥×ÂÖøÖ¥ÕôÕåÕáÕºÔåÔáÔÑÔÌÔ·ÓóÓ«ÓªÓ©Ó¨Ó¢ÒñÒðÒÕÒÃÒ½Ò©Ò¢ÑàÑÅÑÀÑ¿Ñ»Ñ¦Ñ¥ÐîÐ¾Ð½Ð°Ð¬ÏôÏïÏîÏ»ÎõÎôÎßÎ×ÎÔÎµÎ®Î­ÌÙÌÑÌ¦ËòËâËÕË¹ÊíÊßÊÀÊ½ÉõÉÖÉ»É¯É¢ÈøÈôÈïÈãÈÙÈØÈ×ÈÖÈÇÈµÈ§ÇøÇæÇÛÇÚÁ«ÀóÀòÀÙÀÕÀÍÀ¶À³¿û¿ï¿à¿Ö¿Á¿±¾ú¾Þ¾Õ¾Ï¾´¾¯¾¥¾£½ù½æ½å½ä½Ú½¶½³½¯¼ö¼ë¼Ô¼»»ù»ó»ò»ñ»çÇÑÇÐÇÌÇÊÇÉÇ¾ÆäÆßÆÛÆÚÆÑÆÐÆÏÆÎÆ¼Æ»Æ¥ÅîÅºÅ¹Å¸Å·ÄõÄèÄäÄ½Ä¼Ä»ÄºÄ¹Ä³ÄªÄ¢Ä¡ÃïÃêÃçÃÉÃÈÃ¯Ã©Ã§Ã£Ã¢ÂûÂäÂÜÂ«Áâ»Æ»Ä»®»¨ºùºÊºÉºª¹½¹¶¹²¹±¹¯¹®¹§¹¦¹¥¹¤¸ð¸ï¸ê¸Ê·Ò·Ë·Æ·¼·¶·ª·¡¶­¶«µÙµ´´Ð´Ä³¼²è²ç²Ý²Ø²Ô²Ì²Ë²¤±Þ±Î±Í±½±¡°ú°Ð°Å°°°¬°ª',
'BôÐò¿ò¨ñùñøñ÷ñöñõñôæïæßæÞæÝåøãÄÛÉÛÂÛ¸ÚôÚóÚòÚñÚðÚïÚîÚíÚìÚëÚêÚéÚèÚçÚæÚåÚäÚãÚâÚáØ½Ø©×è×Ó×Î×¹Ö°ÕóÕÏÔÉÔºÓçÒþÒõÒ²Ò®ÑôÑ·ÏÞÏÝÏÕÏ¶ÎÀÍÓÌÕËïËîËíËæËåÉÂÈîÈæÈ¢È¡ÁËÁÉÁÄÁª¿×¾Û½×½µ¼ÊÆ¸ÅãÄôÄ°ÃÏÂ½ÂªÂ¤Â¡Áêº¯º¢¹Â¹¢¸ô¸½·À¶ú¶é¶Ó¶¸µ¢´Ï³ý³ö³Ü³Ð³Â±Ý°¯°¢',
'CöÊó±òúòªñæñåðÖðÍð®î¦í¡ìÆë§æøæ÷æöæõæôæóæòæðæîæíæìæëæêæéæèæçæææäæãæâæáæàæÄåÒåÊåÉÛÏÛÎÛÍÛÌÛ¢ØÙ×¤ÖèÔéÔÊÔ¦Ô¥Ô¤ÓèÓÖÓÂÓÁÒÔÒÓÑéÑ±ÐÜÏ·ÍÕÍÔÍ¨Ì¨Ë«Ê»Ê¥É§É£ÈþÈáÈ°ÇýÀÝ¿¥¾Ô¾±¾¢½¾¼è¼¦ÆïÆ­ÄÜÄÑÄ²Ã¬ÂíÂæÂâÂ¿»¶º§¹Û¶ÔµþµËµ¡³Û³Ò²æ²Î²µ°Í',
'D÷à÷ß÷Þ÷Ý÷Ü÷Û÷Ú÷Ù÷Ø÷×÷Ö÷Õ÷Ô÷Êõ¾õ»ôäô©òãò×ò²ñòñññðñïñîñíñìñëñêñéñèñçðÓðÉðÆð¹ð³ð­íçíæíåíäíãíâíáíßíÞíÝíÜíÛíÚíÙíØí×íÖíÕíÔíÓíÒíÑíÐíÏíÍíÌíËíÊíÉíÈíÇíÆíÅíÄíÃíÂíÁíÀí¿í¾í½í¼í»íºí¹í¸í·í¶í¤í¢ìâì³ì­ì¥ëéêüê°ê©åçÞÏÞÎÞÍÞÌÞËÞÇÞÆÞÅÛ½ÛºØãØÞØÚØÍØÌØËØÊØÉØÈØÇØÆØÅ×ó×à×××©ÕèÕÉÔÚÔÒÔÅÔ¸Ô­ÓôÓÒÓÑÓÐÓÈÓ²Ò³ÑãÑâÑáÑÞÑÙÑÐÑ¹ÐçÐÛÏõÏáÏÌÏÄÏÃÏ®ÎùÎøÎìÍþÍòÍëÌüÌ×Ì¼Ì¬Ì«Ì©ËéËÁË¶Ë¬Ë£ÊùÊÙÊ¯Ê¢ÉéÉÝÉ°ÈýÈèÈ·È®ÇØÀúÀùÀøÀ÷ÀåÀÚ¿ü¿ø¿ó¿ä¿Ë¿Ä¿³¾Ç¾Â¾¤½¸¼ï¼î»Û»Ò»ÇÇ£ÆöÆõÆæÆÝÆÆÅøÅöÅðÅéÅáÅÕÄëÄÎÄÍÃæÂõÂëÂµÂ¢ÁûÁúÁòÁ×ºúºñºÄº»¹è¹Ë¹Ê¹Å¹¼¹¨¸û¸Ð·î·á·Ü·Ç·¯¶ø¶ò¶áµúµïµâ´ó´ï´è´æ´Å´À´½´º´¡³ø³É³½³§²ê²Þ²¼±Ã±¼±²±¯±®°õ°ï°î°Ù°Ò°­',
'EöÂõùõøõ÷õöõõõôõ¹ôíðÎìÞì¢ì¡ëþëýëüëûëúëùëøë÷ëõëôëóëòëñëðëïëîëíëìëëëêëèëçëæëåëäëãëâëáëàëßëÞëÝëÜëÛëÚëÙëØë×ëÖëÕëÔëÓëÒëÑëÏëÎëÍëÌëËëÊëÉëÇëÆëÅëÄëÃëÂëÀë¿ë¾ë½ë¼ê®æÚæØåãáêáÙÞÉÛÒÛ®Ø¾ÖúÖðÖâÖ×Ö¬Ö«ÕÍÔàÔÐÔÂÓÃÓ·Ó¯ÒÜÒÈÒ¸Ò¨Ò£ÑüÐüÐëÐØÐÈÐ²ÏÙÏØÏ¥ÍóÍ×ÍÑÍÈÌóÌÚÌÅÌ¥Ë´Ë¦ÊÜÊ¤ÉÅÈùÈéÁ³ÀßÀ°¿è¾ô½Å½º¼°¼¡ÇÒÇ»ÆêÆ¢ÅôÅóÅòÅßÅÖÅ§ÄåÄÔÄËÄ¤ÃÙÃ²ÂöºÑ¹É¸ì¸Ø¸Î¸¹¸­¸¬·þ·ô·Î·Ê·¾¶Çµ¨´à³¦²Ê²É²²²±±ª°û°ò°¹°·°®',
'Fö½ö²ö±ö°ö¯ö®ö­ö¬ö«öªö©ö¨ö§ö¥ô÷ôöôõôôôóôòôñôðôãôÃóäóÀó§ò«ò¡ñüñóð¾îÁî­íàí¨í£ìäì²ì±ì°ë£êíêëêåêÚêÈê´êªéýèºè¹æËåÜåÓåÏÜ²Ü±Ü°Ü¯Ü®Ü­Ü¬Ü«ÜªÜ©Ü¨Ü§Ü¦Ü¥Ü¤Ü£Ü¢Ü¡ÛþÛýÛüÛûÛúÛùÛøÛ÷ÛöÛõÛôÛóÛñÛðÛïÛîÛíÛìÛëÛêÛéÛèÛçÛæÛåÛäÛãÛâÛáÛàÛßÛÞÛÝÛÜÛÛÛÚÛÙÛØÛ×Û¹ÚõØÔØÄØÃØÁØ£Ø¡×ß×¨ÖóÖ¾Ö·Ö±Ö§ÕðÕæÕßÕÔÔöÔØÔÕÔÔÔËÔÆÔ½Ô¶Ô¬Ô«ÔªÓòÓêÒ¼ÑßÑÏÑÎÑ©ÐèÐæÐÒÐ­Ð¢ÏöÏ×ÏÖÏ¼Ï²ÎíÎëÎÞÎÓÎ´Î¥Î¤ÍçÍÁÌîÌæÌËÌÁÌ¹Ì³Ì®ËþËúË÷ËÂËªÊ¿Ê¾Ê®ÉùÉâÉÊÉ¥ÈÍÈÀÈ´È¥È¤Ç÷ÇóÀ×ÀÏÀ¬À¤¿÷¿î¿é¿å¿Ó¿Ç¿À¿¼¿²¿°¿¯¾ù¾È¾³¾®½ø½Ù½Ø½Ì¼Î¼ª»ø»÷»ê»ÜÇ½Ç¬ÆðÆÒÆÂÆºÅùÅ÷ÅíÅàÄÞÄÏÃ¹ÂôÂñÂ¶ÁãÁØ»µºøºÕºÂº¾º²º«¹ý¹ç¹æ¹Ä¹¸¹¡¸Ï¸É¸°·ò·â·Ø·»¶þ¶â¶Õ¶Ñ¶Â¶¼¶¯µßµØµÌ´÷´ç´£³á³à³Ç³Ã³¯³¬³¡²Å²Ã²º²ª²©±¢°Ô°Ó°£',
'G÷Ñ÷Ð÷¡öËö¦ôùôøôïôîôçó¼òüò³ñúðÄð¿ìýì£ë·êãê¯ê§ê¦éìéëéêéééèéçéæéåéäéãéâéáéÒè¶è³è²è±è°è¯è®è­è¬è«èªè©è¨è§è¦è¥è¤è£è¢è¡çþçýçüçûçúçùçøç÷çöçõçóçòçñçðçïçîçíçìçëçêçéçèçççæçåçäçãçâçáçàæñåÛåÎåÍãÃÛÔÛÑÛ³ÛªÛ¤Û£ÚüÚûØÝØÂØ¬Ø«ØªØ¨Ø§Ø¦Ø¤×Á×¸ÖéÖÂÖÁÖ³ÕþÕýÕûÕéÕäÕµÔðÔæÔâÔÙÓñÓëÓÛÓÚÓØÒÄÒ»ÑþÑêÑÉÑÇÑ³ÐÏÐÎÐÍÐÌÏÂÎåÎäÎáÍõÍæÍãÍáÍßÍÍÍÌÌìËöËÙËØËÀÊøÊâÊÂÊ´ÉºÉªÈðÈÚÇòÇíÇàÇÙÁÑÁÐÁ½Á§ÀöÀíÀÅÀµÀ´¿ª¾Á¾²½ú¼í¼ß¼Õ¼Ð¼¬»ô»ÝÆÞÆ½ÅýÅÃÅªÄÒÄ©ÃðÃµÂóÂêÁðÁáÁÕÁÒ»¹»·»­»¥º÷¹å¸ü¸±¸¦·ó·ñ·©¶ñ¶Ù¶¾¶º¶¹µåµ½´ù´ø´õ´Ì²Ü²Ð²Ï²»²£±û±í±Ì±Æ±Â°à°ß°¾°½',
'Hò®öÄö»öºö¹ö¸ö·ö¶öµö´ö³ö¤õþõºôÓò¯ò­ò¬ðµî¬î«îªî©î¨î§î¥î¤î£î¢î¡íþíýíüíûíúíùíøí÷íöíõíôíñíðíïíîíííìíÎìþë¬êïêèêßê·åáÛÖÛÇØÕØÀØ­×Ï×À×¿ÖõÖ¹ÕöÕêÕ½Õ¼Õ°Õ£ÓÝÑÛÑ£ÐéÐ©Ï¹Í¹Í«Ì÷Ë²Ë¯ÊåÉÏÈ£¿ô¿Ï¿¨¾ß¾É¾¦½ÞÇÆÆçÆÄÆµÆ¤ÅÎÅ°ÄÀÄ¿ÃéÃßÃÐÂ÷ÂÇÂ²Â±Â­Â¬Áä»¢¶Ã¶½¶¦¶¢µãµÉ´Ë´Æ³ò³Ý²ñ²Í²Ç²½²·±ë',
'Iöèö×öÌöÈôÄíµí´í³í¯ë©êýæÙæ¶åÐå±å°å¯å®å­å¬å«åªå©å¨å§å¦å¥å¤å£å¢å¡äþäýäüäûäúäùäøä÷äöäõäôäóäòäñäðäïäîäíäìäëäêäéäèäçäæäåäääãäâäáäàäßäÞäÝäÜäÛäÚäÙäØä×äÖäÕäÔäÓäÒäÑäÐäÏäÎäÍäÌäËäÊäÉäÈäÇäÆäÅäÄäÃäÂäÁäÀä¿ä¾ä½ä¼ä»äºä¹ä¸ä·ä¶äµä´ä³ä²ä±ä°ä¯ä®ä­ä¬ä«äªä©ä¨ä§ä¦ä¥ä¤ä£ä¢ä¡ãþãýãüãûãúãùãøã÷ãöãõãôãóãòãñãðãïãîãíãìãëãêãéãèãçãæãåãäãããâãáãàãßà·ÛÊÙäØ»×Õ×Ò×Í×Ì×¢ÖÞÖÎÖÍÖ­ÕãÕ×ÕÓÕÇÕÆÕÄÕ¿Õ´ÔüÔóÔèÔ´Ô¨Ô¡ÓþÓæÓåÓÙÓÎÓÍÓ¿Ó¾ÒùÒçÒÊÒºÒ«ÑúÑóÑÝÑÍÑÄÑ´Ñ§ÐÚÐËÐºÐ¹Ð¤Ð¡ÏýÏûÏ÷ÏæÏÑÏ´Ï«ÏªÎÛÎÖÎÐÎÂÎ¼Î«ÍôÍåÍÝÍÄÍ¿Í¡ÌíÌéÌÔÌÓÌÏÌÎÌÌÌÊÌÄÌÃÌÀÌ¶Ì²Ì­ËÝË®ÊþÊçÊªÊ¡ÉøÉòÉîÉæÉÙÉÑÉÐÉÍÉÇÉ³É¬È÷ÈóÈêÈÜÈ¾È¸ÇþÇöÇåÇßÁÊÁ»ÁºÁ°Á¤ÀìÀáÀÔÀËÀÄÀ½À£¿Ê¿£¾õ¾Ú¾Ù¾Æ½þ½ò½à½½½­½§½¦½¥¼â¼Ã¼¹¼³¼¤»î»ì»ë»ã»ÔÇ³Ç±Ç¢ÆüÆûÆãÆâÆáÆÙÆÖÆÅÆÃÆ¯ÅìÅæÅÝÅËÅÉÅÈÅ½Å¨Å¢ÄùÄçÄàÄ×Ä®Ä­ÃìÃÚÃ»ÂþÂúÂåÂÙÂÐÂËÂºÂ©Á÷ÁïÁÜÁÓ»Á»´»¬»¦ºþºéºèºÔºÓºÆººº¹º­º£¹â¹à¹Á¹µ¸Û¸È¸¢¸¡·Ú·Ð·º·¨¶ý¶É¶´µíµáµÓµÎµ³µ±µ­´ã´¾³ü³Ø³Î³Á³¾³º³±³¨³£³¢²â²×²´²³²¨±õ±ô°Ä',
'Jó½óºó¹ó¸ó·ó¶óµó´ó³ó²ó°ó¯ó­ó¬ó«óªó©ó¨ó¦ó¥ó¤ó£ó¢ó¡òþòýòûòùòøò÷òöòõòôòóòòòñòðòïòîòíòìòëòêòéòèòçòæòåòäòâòáòàòßòÞòÝòÜòÛòÚòÙòÖòÕòÔòÓòÒòÑòÐòÏòÎòÍòÌòÊòÉòÈòÇòÆòÅòÄòÃòÂòÁòÀò¾ò½ò¼ò»òºò¹ò¸ò·ò¶òµò´ò±ò°ìãêÙêØê×êÖêÕêÔêÓêÒêÑêÐêÏêÎêÍêÌêËêÊêÉêÇêÅêÄêÂêÁêÀê¿ê¾ê½ê¼ê»êºê¹ê­è¸åßåÝâ·ÛÃØÖØ®×ò×îÖûÖëÖ©ÕÕÕÑÔçÔÎÔ»ÓöÓÞÓ¼Ó³Ó°Ó¬Ò×ÒÏÒ·Ò°ÑÑÑÁÐÇÐ«ÐªÏþÏÔÏÍÏ¾ÏºÎúÎîÎÏÎÃÍúÍíÍÜÍÉÌâÌÞË§ÊûÊúÊïÊîÊÇÊ±Ê¦ÉöÉêÉßÉÎÉ¹ÈäÈÕÇùÇçÁÀÁ¿ÀïÀÀÀ¯À¥¿Å¾°¾§½ô¼ø¼á¼à»Þ»×»Î»ÈÆØÅ¯ÃøÃ÷ÃáÃËÃÁÃ°ÂüÂìÂÝÁÙºûºçºµ¹û¹ö¹é¹Æ¸ò·ä¶ô¶êµûµçµ©³æ³×³¿³©²ý²õ±©°ö°º°µ',
'K÷Òö¾ö¼õóõòõñõðõïõîõíõìõëõêõéõèõçõæõåõäõãõâõáõàõßõÞõÝõÜõÛõÚõÙõØõ×õÖõÕõÔõÓõÒõÑõÐõÏõÎõÍõÌõËõÊõÉõÈõÇõÆõÅõÄõÃõÂõÁõÀò¦ðØðÊê«è´àìàëàêàéàèàçàæàåàäàãàâàáàààßàÞàÝàÜàÛàÚàÙàØà×àÖàÕàÔàÓàÒàÑàÐàÏàÍàÌàËàÊàÉàÈàÇàÆàÅàÄàÃàÂàÁàÀà¿à¾à½à¼à»àºà¹à¸à¶àµà³à²à±à°à¯à®à­à¬à«àªà©à¨à§à¦à¥à¤à£à¢à¡ßþßýßüßûßúßùßøß÷ßößõßôßóßòßñßðßïßîßíßìßëßêßéßèßçßæßåßäßãßâßáßàßßßÞßÝßÜßÛßÚßÙßØß×ßÖßÕßÔßÓßÒßÑßÐßÏßÎßÍßÌßËßÊßÉßÈßÇßÆßÅßÄßÃßÂßÁßÀß¿ß¾ß½ß¼ß»ßºß¹ß¸ß·ß¶ßµß´ß³ß²Û«×ì×ã×Ù×ÄÖöÖäÖÒÖÑÖÐÖ»ÖºÖ¨Õ¦ÔûÔëÔêÔÛÔÇÔ¾Ô±Ó÷ÓõÓ½Ó»Ó´Ò÷ÒØÒÅÒ¶Ò­Ò§ÑäÑÊÑÆÑ½Ñ«ÐúÐêÐáÐÖÐ¥ÏùÏøÏìÏÅÎüÎûÎâÎØÎËÎÇÎ¹Î¶Î¨ÍÛÍÙÍÂÌýÌøÌçÌäÌãÌßÌ¾Ì¤Ì£ËôËäËÔËÃË»Ë³Ë±ÊÉÊÈÊ·ÉëÉÚÉ¶É¤ÈÂÁ¨À²À®¿õ¿ç¿Þ¿Ú¿Ô¿Ð¿È¿©¿§¿¦¾é¾á¾à¾×½Ð½À¼ùÇºÇ²Æ÷Æ·Æ¡ÅçÅÞÅÜÅØÅ¿Å¾Å»Å¶ÄöÄØÄÅÄÄÃùÂðÂïÂîÂÀÂ·ÁüÁí»½»¼»©»£ºôºðºíºåºßºÙºÈºÇºÅº¿º°¹þ¹ó¹ò¹Ð¹¾¸ú¸Â¸Á¸À·Ô·Í·È¶õ¶å¶ß¶×¶Ö¶£µøµõµðµÅµ¸´ô´Ú´µ´®´­´¨³ù³ì³Ô³Ñ³Ê³³³°³ª²ä²È²¸±ð±É±Ä°Ï°É°È°¦°¥°¡',
'L÷ö÷õ÷ô÷ò÷ñ÷ð÷ï÷î÷íöÉôÂîÀî¿î¾î½î¼î»îºî¹î¸î·î¶îµî³î²î±î°î¯î®ê¥ê¤ê£ê¢ê¡éþéüéûéúéùéøé÷éöéõéôéóéòéñéðéïéîéíèýæÕåÈà÷àöàõàôàóàòàñàðàïàîàíÛÄÛÁ×ï×Ç×ªÖáÖÃÕÞÕÖÕ·Õ¶ÔþÔÝÔ²Ô°Ô¯ÒòÑ¼ÐùÏ½Î¸Î·Î§ÍÅÍ¼ÌïËÄË¼ÊñÊðÊäÈíÈ¦ÇôÇáÁ¾Á¬Á¦ÀÛÀ§½ç½Ï½Î¼Ý¼Ü¼×¼Ó¼­»û»ØÇµÇ­ÆèÆÔÅþÅÏÄÐÄ¬Ä«ÃóÂßÂÞÂÖÂÔºäºÚºØ¹ú¹õ¹ì¹Ì¸¨·ø·£¶÷¶Ú³ë³µ±ß°ì°Õ',
'M÷Ç÷Æ÷Å÷Ä÷Ã÷Â÷Á÷À÷¿÷¾÷½÷¼÷»÷ºó¿ò§ðÐì¯ì®ì¬ì«ì©ëÐêéêçêæêäêâêáêàêÝêÜå×åÄáÛáÚáØá×áÖáÕáÔáÓáÑáÐáÏáÎáÍáÌáËáÊáÉáÇáÆáÅáÄáÃáÂáÁáÀá¿á¾á½á¼á»áºá¹á¸á¶áµá´á³á²á±á°á¯á­á¬á«áªá©á¨á§á¦á¥á¤á£á¢á¡àþàýàüàúàùàøÙîÙíØèØçØÜØÛ×¬ÖüÖÜÖÅÖÄÖ¡ÕËÕÊÕ¸ÔùÔôÔòÔßÓøÓìÓÊÓÉÓ¤ÒÙÑìÑëÑÒÑÂÏ¿Î¡ÍøÍ®Í¬ÌûÌùÌ¿ËêËèÊêÉÞÉÄÉ¾É½ÈâÈ½Çú¿ù¿­¾þ½í¼û¼ú¼¸»ß»Ï»ËÇÍÇ¶ÆñÆéÅâÅÁÄÚÃ±Â¸Áëº¡¹Ç¹º¸Ú¸Õ¸Ô¸³·ù·ï·ç·å···²·«¶ë¶ç¶ä¶ÄµñµäµÏµ¤´Þ´Í´±³ç²á²Æ±á±À±´°Ü°¼°»°¶',
'NöÍôàôÅñãñâðÒðÌíªìÙë¢ê¶éÞèµæÔåñåðåïåîåíåìåëåêåÚãÞãÝãÂãÁãÀã¿ã¾ã½ã¼ã»ãºã¹ã¸ã·ã¶ãµã´ã³ã²ã±ã°ã¯ã®ã­ã¬ã«ãªã©ã¨ã§ã¦ã¥ã¤ã£ã¢ã¡âþâýâüâûâúâùâøâ÷âöâõâôâóâòâñâðâïâîâíâìâëâêâéâèâçâæâåâäâãâââáâàáÒáÈÞÊÙãØ¿ÖçÕúÕ¹Ô÷ÔÃÓðÓäÓÇÒîÒíÒìÒäÒÒÒÑÑ¸ÐôÐÔÐÊÐÄÐÃÐ¼Ð¸Ï°Ï¬Ï§ÎòÎÝÎ¿Î¾Î²Î©ÍïÍÎÍÀÌñÌëÌèËÈË¾Ë¢ÊôÊéÊèÊÕÊÑÊºÊ­Ê¬É÷ÉåÇüÇéÁ¯ÀÁÀ¢¿ì¿¶¿®¾ç¾å¾Ö¾Ó¾ª¾¡½ì¼É¼Â¼º»Ú»Ö»Ð»ÌÇÓÇÄÇ¡ÆÁÆ©Æ¨ÅüÅÂÅ³ÄòÄáÄÕÃõÃñÃ¼Ã¦ÂýÂòÂÅÂÄÂ¾»Å»³ºãºÞº·º¶º©¹ß¹Ö¸Ò¸Ä·ß·É·¢¶è¶²¶®µóµîµëµÔµ¿µ¼µ°µ¬´ä´Á³ó³ß³Ù³À²ã²Ò²Ñ²À±Ü±Û±Ú±Ù±Ø°Ã',
'OôÝôÜôÛôÚôÙôØô×ôÖôÕôÔôÑôÏôÎôÍôÌíëíêíéìáìßìÝìÜìÛìÚìØì×ìÖìÕìÔìÓìÑìÐìÏìÎìÍìÌìËìÊìÉìÈìÇìÅìÄìÃìÂìÁìÀì¿ì¾åàÛÆÛ°ÚþØß×Ñ×ÆÖòÕ³Õ¨ÔïÔîÔäÔãÒµÑæÑ×ÑÌÏ©Ï¨ÍéÌþÌÇË¸ÊýÉÕÉ¿ÈÛÈ¼È²ÁÏÁÇÁ¸Á¶Á£ÀàÀÓÀÃ¿¾¿»¿·¾æ¾¼¾¬¾«½ý»ð»â»ÍÆÉÅÚÅ´Ã×ÃÔÃºÂ¯Â¦»Àºýºæº¸¸â·é·à·Û·³¶ÏµÆ´â´Ö´¸´¶³ã³´²Ú²Ó±þ±º±¬',
'PñÂñÁñÀñäñáñàñßñÞñÝñÜñÛñÚñÙñØñ×ñÖñÕñÔñÓñÒñÑñÐñÏñÎñÍñÌñËñÊñÉñÈñÇñÆñÅñÄñÃñ¿ñ¾ñ½ñ¼ñ»ñºñ¹ñ¸ñ·ñ¶ð²ìüìûìúìùìøì÷ìöìõìôìóìòìñìðìïìîìíìììëìêåäåÕåÁåÀå¿å¾å½å¼å»åºå¹å¸å·å¶åµå´å³å²ÛÈÛ©Ú¤Ú£Ú¢Øà×æ×Ú×Ö×£ÖæÖÏÖ®Õ¯Õ­Õ¬Ô×ÔÖÔ©Ô£Ô¢ÓîÒúÒËÒ¾Ò¤ÑçÑ¨ÐûÐäÐ´ÏüÏéÏÜÎÑÍðÍêÍàÍÊÍ»Ì»ËüËÞËÎÊØÊÓÊÒÊµÉóÉñÉçÉÀÈüÈûÈìÈßÈÝÈ¹ÇîÇÞÁÈÁ±ÀñÀÎ¿ú¿í¿ã¿ß¿Ü¿Õ¿Í¾ü¾¿¾½½ó½Ñ¼Ò¼Å¼Ä»ö»íÇÔÇÏÆîÆíÅÛÅ©ÄþÄ¯ÃÝÃÜÃÛÃÂÂãÂ»Áþ»Âºêº×ºÖº±º®º¦¹Ú¹Ù¹Ó¹Ñ¹¬¸î¸»¸¤¸£¶î¶¨µ»´Ü´°´©³õ³è³Ä²ì²¹±ö±»±¦°À°¸°²',
'Q÷¯÷®÷­÷¬÷«÷©÷¨÷§÷¦÷¥÷¤÷£÷¢öþöýöüöûöúöùöøö÷öööõöôöóöòöñöðöïöîöíöìöëöêöéöçöæöåöäöãöâöáöàöÞöÝöÜöÛöÚöÙöØöÖöÕöÔöÓöÒöÑöÐöÏöÎö£ö¢ö¡õýõüõûõúôÁð×ð·ð¶ïñïðïïïîïíïìïëïêïéïèïçïæïåïäïãïâïáïàïßïÞïÝïÜïÛïÚïÙïØï×ïÖïÕïÔïÓïÒïÑïÐïÏïÎïÍïÌïËïÊïÉïÈïÇïÆïÅïÄïÃïÂïÁïÀï¿ï¾ï½ï¼ï»ïºï¹ï¸ï·ï¶ïµï´ï³ï²ï±ï°ï¯ï®ï­ï¬ï«ïªï©ï¨ï§ï¦ï¥ï¤ï£ï¢ï¡îþîýîüîûîúîùîøî÷îöîõîôîóîòîñîðîïîîîíîìîëîêîéîèîçîæîåîäîãîâîáîàîßîÞîÝîÜîÛîÚîÙîØî×îÖîÕîÔîÓîÒîÑîÐîÏîÎîÍîÌîËîÊîÉîÈîÇîÆîÅîÄîÂíóì¤ëÈéÍèîèÉçôåâåÞåÑåÇâÎâÍâÌâËâÊâÉâÈâÇâÆâÅâÄâÃâÂâÁâÀâ¿â¾â½â¼â»â¹â¸â¶âµâ´â³â²â±â°â¯â®â­â¬â«âªâ©â¨â§â¦â¥â¤â£â¢â¡áþáýáüáûáúáùáøá÷áöáõáôáóáòáñáðáïáîáíáìáëß±ÛËÛ¾Û¼Û»Û­Û¨Û§Û¡ÚùÙìÙëÙêÙéÙèØØØ×ØµØ³Ø¢×ê×Þ×¶ÖýÖíÖåÖÓÖËÕùÕøÕòÕëÕàÕ²Õ¡ÔÈÔ¿Ô¹Ô³Ô§ÓüÓãÓÌÓËÓ­Ó¡ÒûÒøÒÝÒ¿Ñ®ÐâÐÙÐ×ÐÉÐ¿Ð·ÏúÏóÏâÏÚÏÊÏÇÏÁÏ³Ï¦Ï£ÎýÎðÎÚÎÙÎ£ÍâÍÒÍÃÍ­ÌúÌàÌ¡ËøËÇÊÏÊÎÊ¨É×É·É²É±É«ÈúÈñÈÄÈ»ÇäÁÍÁ´Á­ÀôÀðÀêÀØÀÖÀÇÀ¡¿ñ¾û¾ä¾â¾Ñ¾Ä¾Ã¾µ¾¨½õ½ð½â½È½Ç½Æ½Â½¤¼ü¼Ø¼±¼¢»èÇÕÇÂÇ·Ç¯Ç®Ç¦Ç¥ÆÌÅÙÅ¥ÄüÄøÄ÷ÄñÄÙÄÆÃûÃúÃãÃâÃÍÃÌÃ¾Ã³Ã®Ã­ÃªÃ¨ÂøÂàÂÑÂÁÂ³ÁôÁóÁåÁÔ»«ºüºöºïºÝ¹ø¹ê¹ä¹Ý¹»¹·¹´¹³¸õ¸ä¸Ö¸Æ¸º·õ·æ·¹·¸·°¶ü¶û¶ù¶ö¶à¶Û¶Í¶Æ¶À¶µ¶§¶¤µöµéµÒµº´í´Ò´¥³û³ú³®²þ²ù²ö²Â²¬²§±·±µ±«±¥°ü°÷',
'R÷Î÷Í÷Ì÷Ë÷É÷Èõ½ôêóÁó¾òØñýðÇðºð¬ð«ð©ð¨ð§ë¸ëµë´ë³ë²ë±ë°ë¯ë®ë­ë¡êþêÞåØåËß­ß¬ß«ßªß©ß¨ß§ß¦ß¥ß¤ß£ß¢ß¡ÞýÞüÞûÞúÞùÞøÞ÷ÞöÞõÞóÞòÞñÞðÞïÞîÞíÞìÞëÞêÞéÞèÞçÞæÞåÞäÞãÞâÞáÞàÞßÞÞÞÝÞÜÞÛÞÚÞÙÞØÞ×ÞÖÞÕÞÔÞÓÞÒÞÑÞÐÛ¯Û¥Ø´×á×¾×½×²×«×§×¦×¥ÖôÖìÖÊÖÆÖÀÖ¿Ö¸Ö´ÕüÕõÕñÕÝÕÜÕÛÕÒÕÐÕªÔúÔñÔíÔÜÔÀÔ®ÓµÒóÒÖÒ´Ò¡ÑûÑõÑïÑÚÑºÐÀÐ¶Ð¯Ð®ÏÆÎèÎæÎÕÎÎÍîÍìÍÚÍØÍÐÍÏÍÆÍ¶Í±Í¦ÌôÌáÌÍÌÂÌ½Ì¯Ì§Ì¢ËùËðËÓËÑËºË©Ë¤ÊãÊÚÊÖÊÆÊÅÊÄÊÃÊ°Ê§ÉãÉÓÉÃÉ¨É¦ÈöÈàÈÓÈÈÈÅÈÁÈ±ÈªÇñÇðÇèÇâÇÜÁÌÁÃÀÞÀÌÀ¿À¹À­À©À¨À¦¿ý¿æ¿Û¿Ù¿Ø¿½¿¹¿¸¿´¿«¾ò¾ñ¾ð¾ï¾è¾Ý¾Ü¾Ð¾¾½ü½ï½Ý½Ó½Ò½Á¼ñ¼ð¼¼¼·»Ó»ÊÇËÇÀÇ¤ÆþÆøÆËÆÈÆÇÆ¹Æ´Æ²ÅûÅúÅõÅêÅ×ÅÒÅÅÅÄÅÀÅ²Å¤Å£Å¡ÄóÄíÄìÄêÄéÄâÄÓÄÊÄ´Ä¨ÃþÃòÃèÂÕÂÓÂÈÂ°Â§Â£Áà»»»¤ºóº´º³º¤¹í¹Þ¹Õ¹Ò¹Ï¹°¸é¸ã¸Þ¸×¸§·ú·÷·ö·Õ·µ·´¶ó¶Þ¶Ý¶Ü¶¶µüµôµæµàµÖµÄµ·µ²µªµ§µ£´ò´î´ì´ë´ê´é´Ý´·´§´¤³é³â³Ö³Å³¸³·³¶³­²ô²ó²ð²ë²å²Ù²Á²¶²¯²«²¦²¥±ø±÷±ì±°±¨±§°è°ç°â°á°Ý°Ú°×°Ñ°Î°Ç°Æ°¿°´°±°¨°¤',
'Sõ¸õ·õ¶õµõ´õ³õ²õ±õ°õ¯õ®õ­õ¬õ«õªõ©õ¨õ§õ¦õ¥õ¤õ£õ¢õ¡ôþôýôüôûôúñûðªí®éßéÝéÜéÛéÚéÙéØé×éÖéÕéÔéÓéÐéÏéÎéÌéËéÊéÉéÈéÇéÆéÅéÄéÂéÁéÀé¿é¾é½é¼é»éºé¹é¸é·é¶éµé´é³é²é±é¯é®é­é¬é«éªé©é¨é§é¦é¥é¤é£é¢é¡èþèüèûèúèùèøè÷èöèõèôèóèòèñèíèìèëèêèéèèèçèæèåèäèãèâèáèàèßèÞèÝèÜèÛèÚèÙèØè×èÖèÕèÔèÓèÒèÑèÐèÏèÎèÍèÌèËèÊèÈèÇèÆèÅèÄèÃèÂèÁèÀè¿è¾è½è¼è»Û²Øâ×õ×í×Ø×Ã×µ×®ÖùÖêÖ²Ö¦ÕíÕçÕÈÕÁÕ»Õ¥Õ¤ÔýÔÍÓÜÓÏÓ£ÒÎÒ¬ÒªÑùÑîÐïÐàÐÓÐÑÐµÐ¨Ð£ÏðÏëÏàÏ­Î÷ÎöÎàÎ¦Í÷ÍÖÍ°ÍªÍ©ÌÝÌÒÌ´ÌªËóËáËÚËÖËÉË¨Ê÷ÊöÊõÊáÊàÊÁÉÒÉ¼É­È¶È©È¨ÀõÀîÀãÀâÀÒÀÆÀ¸À·¿ò¿á¿Ý¿É¿Ã¿Â¿¬½û½Ü½Û½Í½·¼÷¼ì¼Ö¼Ï¼«»úÇÅÇÁÇ¹ÆåÆÜÆÓÆ±Æ°Æ®ÅïÅäÅÊÄûÄðÄ¾Ä£ÃÞÃÑÃÎÃÊÃ¸Ã·Ã¶Â´Â¥ÁøÁñÁÖ»¸»±ºáºËº¼º¨¹÷¹ñ¹ð¹×¹¹¹£¸ù¸ñ¸è¸ç¸Ü¸Ì¸Ë¸Å¸²·ã·Ù·Ó·®¶Å¶°¶¥¶¡µµ´å´×´¼´»´ª³þ³÷³ê³È³»²é²Û²Ä±ú±ò±ê±¾±­°ô°ñ°ð°å°Ø',
'T÷þ÷ý÷ü÷ó÷ªöÃô¿ô¾ô½ô¼ô»ôºô¹ô¸ô·ô¶ôµô´ô³ô²ô±ô°ô¯ô®ô­ô¬ô«ô¦ô¥ô¤ô£ô¢ô¡óþóýóüóûóúóùóøó÷óöóõóôóóóòóñóðóïóîóíóìóëóêóéóèóçóæóåóãóâóáóàóßóÞóÝóÜóÛóÚóÙóØó×óÖóÕóÔóÓóÒóÑóÐóÏóÎóÍóÌóËóÊóÉóÈóÇóÆóÅóÄóÃóÂó®ðÀð»ð¦ð¥ð¤ð£ð¢ð¡ïþïýïüïûïúïùïøï÷ïöïõïôïóïòíòí¬í©ì¦ë»ëºë¹ë¶ë«ëªë¦ë¥ë¤êûêúêùêøê÷êöêõêôêóêòêÃé°åÔåÌåÆåÅåÃâºáéáèáçáæáåáäáãáâáááàáßáÞáÝáÜá®Û¶Û¬ÙáÙàØæØºØ¹Ø·Ø¶Ø²Ø±Ø¯×ë×â×Ô×­ÖþÖñÖÛÖØÖÖÖÉÖÈÖÇÖªÕ÷Õ±Õ§ÔõÔìÔÞÔÁÓùÓíÓÔÒÛÒÆÑíÑÜÑÓÑÃÑ­Ñ¬ÑªÑ¡ÐìÐãÐÐÐÆÐ¦ÏòÏäÏãÏÏÏÎÏÈÏµÏ¤Ï¢Ï¡ÎþÎñÎïÎçÎÒÎÈÎºÎ¯Î¢ÍùÍÇÍ½ÍºÍ¸Í²Í§Í¢ÌõÌòÌðÌØÌÉÌºËñËëËãËÒË½Ë°ÊòÊÍÊÊÊ¸Ê£ÉýÉüÉûÉúÉíÉäÉàÉÔÉÈÉ¸ÈëÈÉÇûÇïÀûÀéÀèÀçÀæÀº¿ð¿ê¿Æ¿¿¾Ø¾Ì¾¶½î½Ö½Õ½Ã½¢¼ý¼ò¼ã¼Ú¼¾¼®»þ»ý»ü»à»Õ»ÉÇÇÇ©Ç¨Ç§ÆùÆòÆ¬ÆªÅñÅÍÅÌÅÇÅÆÄÂÄÁÄµÃôÃëÃØÃ¿Ã´Ã«ÂáÂÒÂÉÂ¨Áý»²ºõºâºÜºÍºÌº½¹Ü¹Ô¹Î¹¿¹ª¸÷¸æ¸å¸Ý¸Ñ¸Í¸´·û·ê·±·­·¬·¦·¤¶ì¶æ¶ã¶Ì¶¿¶¬¶ªµÚµÑµÐµÈµÃµÂµ¾´ý´ð´Û´Ø´Ñ´Ç´¹´¬´¦³ô³ï³î³í³Ó³Í³Ì³Ë³Æ³¹³¤²ß²Õ²¾²°²­±ü±Ò±Ë±Ê±Ç±¿±¹±¸°æ°ã°Þ°Ê°Â°«',
'Uößõ¿ôåôÒôËôÊôÉôÈôÇôÆñµñ´ñ³ñ²ñ±ñ°ñ¯ñ®ñ­ñ¬ñ«ñªñ©ñ¨ñ§ñ¦ñ¥ñ¤ñ£ñ¢ñ¡ðþðýðüðûðúðùðøð÷ðöðõðôðóðòðñðððïðîðíðìðëðêðéðèðçðæðåðäðãðâðáðàðßðÞðÝðÜðÛðÚðÏðËðÃðÂîÃí°í§í¦ìªì§ê¸êµê³éàéÃèðæÜæªåÙãÜãÛãÚãÙãØã×ãÖãÕãÔãÓãÒãÑãÐãÏãÎãÍãÌãËãÊãÉãÈãÇãÆãÅà´Û·ÛµÚýÚ¡ÙþÙýÙüÙûÙòÙðÙçÙæÙå×ñ×ð×Ü×Ë×Ê×É×È×Å×¼×´×³×±×°ÖÌÖ£Ö¢ÕîÕÎÕÃÕÂÕ¾Õ¢ÔøÔÏÔÄÓ¸ÒôÒæÒãÒâÒßÒ±ÑøÑ÷ÑòÑñÑåÑØÑÖÑÕÑËÑ¾Ñ¢ÐßÐÂÐÁÐ§ÏèÏÛÏÐÎÊÎÅÎÁÍ·Í´Í¯ÌêÌÜÌÛÌµÌ±ËìËÜËÍË·ÊÞÊÝÊ×ÉØÉÌÉÆÉÁÈòÈ³È¯È­È¬ÇõÇ×ÁÆÁ¹Á¢Á¡ÀäÀ¼À»À±À«¿ö¿¢¾ö¾í¾ì¾Ò¾Î¾»¾º¾¹¾¸¾·½ê½ß½¼½»½´½±½°½¬½«½«½ª¼õ¼ô¼æ¼å¼ä¼½¼²Ç¼Ç¸Ç°ÆàÆÕÆÊÆ¿Æ³Æ¦Æ£ÅÔÅÑÅÐÅ±ÄýÄæÄÖÃöÃÆÃÅÃÀÁùÁöÁèÁçÁÝ»¿»¾ºÛºÒ¹ë¹Ø¸þ¸ó¸í¸á¸Ó¸Ç·ë·è·§¶Ò¶Ë¶»¶·¶³µòµìµÝµÜµÛµÁµÀµ¦µ¥´ñ´á´Õ´Î´É´È´Ã´³´¯³å³Õ²û²ú²î²¿²¢²¡±ù±ñ±ï±î±è±ç±æ±×±Ö±Õ±Ô±Å±³±±°ë°ê°Ì°©',
'V÷û÷ú÷ù÷ø÷÷ôßôÞôªô¨ô§ð¯í²í±çßçÞçÝæåæÛæ×æÖæÓæÒæÑæÐæÏæÎæÍæÌæÊæÉæÈæÇæÆæÅæÃæÂæÁæÀæ¿æ¾æ½æ¼æ»æºæ¹æ¸æ·æµæ´æ³æ²æ±æ°æ¯æ­æ¬æ«æ©æ¨æ§æ¦æ¥æ¤æ£æ¢æ¡åþåýåüåûåúåùåóåæåååÖàûÛÅÛ¿Ø¸ÖãÕÙÔÓÓéÒüÒöÒÌÒ¦ÑýÑ²Ñ°ÐöÐõÐñÐÕÏÓÏ±ÍñÍèÍÞÍËÌöËýËàË¡ÊóÊ¼ÉôÉïÉÛÉ©ÈçÈÑÈÐÈÌÈºÁ¥ÀÑ¿Ò¿Ñ¿¤¾ý¾ê¾Ë¾Ê¾Å½ã½Ë½¿½¨¼é¼Þ¼Ë¼È¼µ¼´¼§»é»ÙÅ®Å­Å¬Å«ÄïÄÝÄÛÄÌÄÈÄÇÄ·ÃîÃäÃÄÃÃÃ½ÂèÂ¼ÁéºÃ¹Ã¸¾·Á¶ð¶ÊµÕµ¶´þ³²°þ',
'W÷ìöÅöÁöÀö¿ôâôáôÀò¥ò¢ðÔðÁð¼î´íèí¥ìàìÒì¨ë¨êðêìê²ê¨è·á·ÛÐÛ¦ÙâÙßÙÞÙÝÙÜÙÛÙÚÙÙÙØÙ×ÙÖÙÕÙÔÙÓÙÒÙÑÙÐÙÏÙÎÙÍÙÌÙËÙÊÙÉÙÈÙÇÙÆÙÅÙÄÙÃÙÂÙÁÙÀÙ¿Ù¾Ù½Ù¼Ù»ÙºÙ¹Ù¸Ù·Ù¶ÙµÙ´Ù³Ù²Ù±Ù°Ù¯Ù®Ù­Ù¬Ù«ÙªÙ©Ù¨Ù§Ù¦Ù¥Ù¤Ù£Ù¢Ù¡ØþØýØüØûØúØùØøØ÷ØöØõØôØóØòØñØðØïØîØíØìØëØêØéØä×ø×÷×ö×ô×Ð×·×¡ÖÚÖÙÖ¶ÖµÕìÕÌÕ®ÓûÓúÓâÓáÓàÓßÓÓÓÆÓÅÓ¶ÒÚÒÐÒÇÒÁÒÀÒ¯ÑöÑðÐðÐÞÐÝÐÅÐ±ÏñÏÉÏÀÎêÎéÎÍÎÌÎ»Î±Î°Í¾ÍµÍ£ÌåÌÈÌ°ËûËÛË×ËÌËËËÊËÆËÅÊæÊÛÊÌÊËÊ¹Ê³Ê²ÉìÉáÉËÉµÉ®É¡ÈåÈÔÈÎÈËÈÊÈ«ÇãÇÝÇÖÁÅÁ²Á©ÀþÀýÀüÀÜÀÐ¿þ¿ë¿¡¾ó¾ë¾ã½ö½ñ½é½è½Ä½¹½©½£½¡¼þ¼ó¼Û¼Ù¼Ñ¼À¼¿¼¯»õ»ï»áÇÎÇÈÇªÆóÆÍÆ¾Æ¶Æ«Æ§ÅèÅåÅ¼ÄúÄîÄãÄßÄÃÃüÃÇÂØÂ×ÂÂÁîÁìÁæÁÞÁÛÁÚ»¯»ªºòºîºÐºÏºÎº¬¹ô¹ï¹È¹À¹«¹©¸ö¸ë¸¸¸·¸¶¸µ¸«¸ª¸©·ý·ü·ð·Þ·Ý·Ö·Â·¥¶í¶Î¶±µùµèµÍµÊµÇµ¹µ«´ü´û´ú´ö´ß´Ù´Ô´Ó´´´«´¢³ð³Þ³«³¥²ò²í²à²Ö²®±ý±ã±¶±¤±£°ø°é°ä°Û°Ö°Ë°Á°³',
'X÷Ïôéó»ò£ð¸ð±êñçÜçÛçÚçÙçØç×çÖçÕçÔçÓçÒçÑçÐçÏçÎçÍçÌçËçÊçÉçÈçÇçÆçÅçÄçÃçÂçÁçÀç¿ç¾ç½ç¼ç»çºç¹ç¸ç·ç¶çµç´ç³ç²ç±ç°ç¯ç®ç­ç¬ç«çªç©ç¨ç§ç¦ç¥ç¤ç£ç¢ç¡æþæýæüæûæúæùå÷åöåõåôåòåéåèàÎØ°×é×Ý×Û×ºÖàÖÕÖ½Ö¼Ö¯ÕÅÕÀÔ¼ÔµÓ×ÓÄÓ±Ó§ÒýÒïÒÞÒÍÒÉÑ¤ÐøÐ÷ÐåÏçÏßÏÒÏËÏ¸ÎãÎÆÎ³Î¬Í³ÌÐËõËçË¿ÉþÉðÉÜÉÉÉ´ÈõÈÞÈÒÈÆÇêÁ·ÀÂ¾ø¾î¾À¾­½á½Ô½Ê½É½®¼ê¼Í¼Ì¼¶¼©¼¨»æÇ¿Å¦ÄÉÄ¸ÃåÃàÃÖÂçÂÚÂÌÂÆ»Ã»º»¡ºìºë¹á¹­¸ø¸Ù¸¿¸¥·ì·×·Ñ·Ä¶ÐµÞµ¯´Â´¿³ñ³Ú²ø±à±Ñ±Ð±Ï±È±Á°ó°í',
'Y÷ë÷ê÷é÷è÷ç÷æ÷å÷ä÷ã÷â÷á÷ÓöÇôìôæò¤ñþðÕðÑðÈð½í­ìéìèìçìæìåì½ì¼ì»ìºì¹ì¸ì·ì¶ìµì´ëöëÁêÆèïæ®âßâÞâÝâÜâÛâÚâÙâØâ×âÖâÕâÔâÓâÒâÑâÐâÏÞÈÞÄÛÕÛÓÛÀÚúÚøÚ÷ÚßÚÞÚÝÚÜÚÛÚÚÚÙÚØÚ×ÚÖÚÕÚÔÚÓÚÒÚÑÚÐÚÏÚÎÚÍÚÌÚËÚÊÚÉÚÈÚÇÚÆÚÅÚÄÚÃÚÂÚÁÚÀÚ¿Ú¾Ú½Ú¼Ú»ÚºÚ¹Ú¸Ú·Ú¶ÚµÚ´Ú³Ú²Ú±Ú°Ú¯Ú®Ú­Ú¬Ú«ÚªÚ©Ú¨Ú§Ú¦Ú¥ÙúÙùÙøÙ÷ÙöÙõÙôÙóÙñÙïØ¼×ù×ç×å×ä×»×¯Ö÷ÖïÖîÖßÖÝÖÔÖ¤ÕïÕâÕÚÕØÕ«Õ©ÓýÓïÓÕÓÀÓºÓ¹Ó®Ó¦Ó¥ÒëÒêÒéÒèÒåÒáÒàÒÂÒ¹Ò¥ÑèÑÔÑÈÑ¶ÑµÑ¯ÐþÐýÐóÐòÐíÐ»Ð³ÏíÏêÏåÏ¯ÎóÎÜÎÉÎÄÎ½ÎªÍýÍüÍûÍöÍäÍ¥Í¤ÌÖÌÆÌ¸Ì·ËßËÐËÏËµË­Ë¥ÊüÊìÊëÊÔÊÐÊ¶Ê«Ê©ÉèÈÏÈÃÈ¿ÇìÇëÁÎÁÂÁÁÁ¼ÁµÁ®ÀëÀÊÀÉÀÈÀ¾Àª¿â¿Î¿Ì¿º¿µ¾÷¾Í¾©½÷½ë½²¼ç¼Ç¼Æ¼Á¼¥¼£»å»ä»ÑÇÃÇ´Ç«ÆýÆúÆôÆìÆëÆ×ÆÀÅëÅÓÅµÄ¶Ä±Ä§Ä¦Ä¥ÃýÃíÃÕÃÓÃÒÃ¥Ã¤Ã¡ÂùÂéÂÛÂÏÂÎÂÍÂÊÂÃÂ¹Â®ÁõÁß»°»§ºàºÁºÀº¥¹ü¹ù¹î¹ã¹Í¸ý¸à¸ß¸Ã¸¼¸¯¸®·í·Ï·Ì·Å·Ã·¿·½¶ï¶Ø¶È¶Á¶©µýµ÷µêµ×µ®´Ê´²³ä³Ï²ü²÷²ï±ó±é±å±ä±â±Ó°ý°ù°§');
BEGIN
  Strlen := Length(Str);
  RESULT := '';
  FOR i IN 1 .. Strlen LOOP
    Tmpstr := Substr(Str, i, 1);
    IF (Ascii(Tmpstr) >= 1 AND Ascii(Tmpstr) <= 254) THEN
      RESULT := RESULT || Lower(Tmpstr);
    ELSE
      j := 1;
      LOOP
        Tmpstr2 := v_WB(j);
        Strlen2 := Length(Tmpstr2);
        k       := 2;
        LOOP
          Tmpstr3 := Substr(Tmpstr2, k, 1);
          IF (Ascii(Tmpstr) = Ascii(Tmpstr3)) THEN
            RESULT := RESULT || Substr(Tmpstr2, 1, 1);
            k      := Strlen2;
            j      := v_WB.COUNT;
          END IF;
          EXIT WHEN k = Strlen2;
          k := k + 1;
        END LOOP;
        EXIT WHEN j = v_WB.COUNT;
        j := j + 1;
      END LOOP;
    END IF;
  END LOOP;
  RETURN(RESULT);
END Get_WB;
/

prompt
prompt Creating function ISDATE
prompt ========================
prompt
CREATE OR REPLACE FUNCTION EMR.isdate(str varchar2,
                                  fmt varchar2 default null,
                                  nls varchar2 default null) return number IS
  --RETURN Date
  v_date date;
  v_fmt  varchar2(100) default fmt;
  v_nls  varchar2(100) default nls;
BEGIN
 v_date:= to_date(str,'yyyy-MM:dd HH24:mi:ss');

  RETURN 1;
  -- RETURN v_date ;
EXCEPTION
  WHEN OTHERS THEN
    RETURN 0;
    --      RETURN null;
END;
/

prompt
prompt Creating function ISDAY
prompt =======================
prompt
CREATE OR REPLACE FUNCTION EMR.isday(days number) return number IS
BEGIN
   if days =0 then
    return 1;
 else
    return days;
  end if;
end;
/

prompt
prompt Creating function SPLIT_STRING
prompt ==============================
prompt
create or replace function emr.split_string(pi_str in varchar2, pi_separator in varchar2) --´´½¨º¯Êý
return char_table
 is
  v_char_table char_table;
  --create type char_table is table of varchar2(4000);--´´½¨×Ô¶¨ÒåÀàÐÍ½Å±¾
  v_temp varchar2(4000);
  v_element varchar2(4000);
begin
   v_char_table := char_table();
   v_temp := pi_str;
   while instr(v_temp, pi_separator) > 0
    loop
        v_element := substr(v_temp,1,instr(v_temp, pi_separator)-1);
        v_temp := substr(v_temp, instr(v_temp,pi_separator)+ length(pi_separator) , length(v_temp));
        v_char_table.extend;
        v_char_table(v_char_table.count) := v_element;

   end loop;
    v_char_table.extend;
    v_char_table(v_char_table.count) := v_temp;
   return v_char_table;
end split_string;
/

prompt
prompt Creating function ZLSPELLCODE
prompt =============================
prompt
CREATE OR REPLACE FUNCTION EMR.ZLSPELLCODE (v_Instr In Varchar2,v_OutNum In Integer:=10)
  Return Varchar2 Is
  v_Spell   Varchar2(40);
  v_Input   Varchar2(1000);
  v_Bitchar Varchar2(2);
  v_Bitnum  Integer;
  v_Chrnum  Integer;
  v_OutMaxNum Integer;
  v_Stdstr  Varchar2(50) := '°Å²Á´î¶ê·¢¸Á¹þ»÷-¿¦À¬ÂèÄÃÅ¶Å¾ÆÚÈ»ÈöËúÍÚ-ÍÚÎôÑ¹ÔÑ';
  v_Chara   Varchar2(2000) := 'ß¹ï¹åHàÄïÍæXÞßàÈÜtþH×cö°ì\íÁàÉæÈêÓè¨ÙŒø×rèP÷oìaèñâÖÚÏÕYì”ÖOéœõcùgíù“ëˆÛûï§ë@Þîä@áíØtØåB÷öálÛêÝEëJà»âÚéáåÛÖ’÷¡÷éö—úqüÞÖæÁéOá®æñÖ“öËðÆñúòü';
  v_Charb   Varchar2(2000) := 'á±ôÎášØ^÷„ôƒÜØá—ÝÃÝRïT÷Éü–îÙâZÚ•öÑõEå±êþÞãßÂì‹Ù”ívîCÞnÚæÛàîÓô²âkô‘é›ã[ì‡Þkäºß™íDÝòÖræ^ÙèæßìÒöµé–ý_Ýáï’ï–øRødÙ…ìdõÀè˜ãEìsõUètÚéùlãmØÚýã£àfÝKíÕÝíÕRÝ…ä^÷¹öÍêÚßGÙSï¼åQÛÎÛÐÝ™éaàÔìžßJÛMê´éGçaØP÷”æqùSösÝ©Ø°ßÁåþïõÙÂô°Ø„×ß›î¯ßÙÜêáùîéæ¾âØÝÉé[é]åöã¹ÙCÚPääõÏãGésïàŠæÔÞµõIå¨Û‹í@÷ÂèµàˆôÅç@íSí{ÜKÜLôxÚFèEúzú‡ü„í¾ìÔß„æQöýß…öböcØÒÙHíÜøuÛÍâíãêÜÐáŠÞÕçÂérÞgîYÞlÞmÞpÞq×ƒìáè¼ì©÷ÔïRæôûïÚì­ì®ï[Ö€Ù™çSïðïjïkïlïnèsæ»Õ•ål÷§÷B÷Mü‚ý–õ¿ß“ÙÏçÍéÄØhÙeÙfïÙáÙìEè\î éëë÷÷Æ÷ÞôWÙûä‰ÚûêvÙ÷âãuìïžðVÞðÕ@õmìhâÄà£ã\ðGÜ@÷QØÃàRÙñîàâ“ãK÷ˆõÛäcéDõNØmænùPíçè}õËô¤ë¢éÞ×LåÍîßêÎâ˜ÕcðJÞKõ³ß²øGùLûQîÐê³âbÛYà^ð¾ñ£ñ­ñÑñØñÛó÷óëóÙóÖòùñÙñÔñ¹ñ¦ð±ðÇ';
  v_Charc   Varchar2(2000) := 'àêíåßnØ”ÛPï{æî÷õüoôÓè²ÖØ÷û]úIè†Ù‰àÐäîô½ç[Ü³à“üâüá¯ä¹àáè¾âÇã˜ïÊåšæ\âªìxé¶éßÛ‚ïïèdãâæ±îÎâOÙ­Þ{êèäiæ¿åîìøÕSäaâÜäýàšïâàžõðéK×‹èÚÆÝÛÕ~éˆÙæápÖçPêU×€âãåñí]îØöæ½ÝÅãÑè å_é‹öðöKüÜÉéLéMáäæÏä–÷•çL÷lêÆã®ë©äâêÛËÕkíoâ÷ìÌânêËà}ü…ÞCü{ÖšûžÜ‡íºåøÛåÞŠîJÞÓè¡àÁÕ€ÙoÖnÞå·êÚÈÜ•â\ëÖRû‰úmÚ’í×Û{Ù•ö³Úfé´ýYýZÚß×êpèßîõÚWìlîªÚXîdçdçpèKØ©èÇàJÛôîñëóÕ\õ¨ä…õ“ßêí÷àÍæÊÕvø|ùA÷ÎýcüJü[ÜÝÚdÙPßWÚmßgÜ¯õØßtÖsôùãrýXáÜß³âÁÞŒë·à´ï†ÙÑÛLãMë†ßoã‰Ú†ùúuâçÜûô©ã¿ô¾ÛŒê™ï¥ã|Ù±àüã°áOëlöÅÜPá~×‡×‰áhô{ßcéËØŒýiÛ»ØaÚnãIäzërõéúRÜXèÆèúýsýƒØ¡âðç©ØXàsÛUézÕ‘ãÀ÷íÞõà¨àÜõßçÝë°ô­å×ÝŽâ¶îËâAÙiúEêJâëý—Úïé¢é³åNæmîqÝöjùœêÝ»ácåTõžù‡ÙƒÛwõÖåÁÞußOê¡áQÚ}ÝzöºýpèqýwßÚÚeìôÜëÞeâ‘ôÙÞiï“ð@øyÞoú\ú]ÚÙnÜÊèÈæõè®çWäÈçýÕpÙzÙ{Öé¨ëíê£Ýû€û‚û›áÞéãâ§õ¡ÝýÕKÚuÛqõ¾üyõíÜAî•Ùàß¥ïéÜfè‰ìàéÁçJè­Ú~ßýã²ÝÍë¥îxß—ÛZââßuõãáiáÏïóõºûzý€ëâØÈßHï±äSåeå¤ðûö¿óøó×ò¿ò²ñéñåñÝñÒñÎñÃñ¬ó¸ó©ó¤òíòÜòÉñ¡ðîð·æöðËðÈëú';
  v_Chard   Varchar2(2000) := 'ßÕÞÇàªæpÞ…Þ‡æ§âòí³ßQß_ÛQ÷°÷²æ]ÜJèNí^ý‘ý“ß¾Þaá·ß°çªåÊçéÜÜ¤Ü–ÙJÝDõ\øl÷ìÛìOünì^íñÜláGééàîFÙÙü^à¢ÝÌÕQå£ø}ÙœìKÚÔ×[üh×•ÛÊå´í¸ÝÐßTë‹ÚêWØÖß¶âáë®á’÷ô€ê‰þOëIëZìâÜ„ôîï½åuØOàâô£ê­à‡ëQáØíãïëç‹ôÆêÚhàÖïáå~íLçCÙáÝ¶êëì{îEô†ØpûMØµÚ®Û¡êsÛæèÜíÆÝB÷¾öWæ·ÞžÚÐâKé¦íûßfãdíÚßrÖBÛyàÇÛ†áÛîŒîý‚õÚücÚçÛãçèîäâšëŠô¡õõøJõMöôü—õ ùmážîöâyäHëÕ{ä”èSÛìà©Ü¦ÞéÚgëºéPÕ™õÞöøölØêçàôúá”ìwí”ü‡ç–ï}à¤ëëíÖåVîrîûïMäAßËá´ë±õ[üŠöCù…úHÕ‰Ûíá¼ëËÞ“ëØíÏëšÝúêhî×þKâ^àKôYáHékôZäWðLêLô^ô`ôaê^à½á`êAäÂèüë¹ÕiåL÷ò×xØKÚGí~÷Çèoíbíüt×˜Ù€Ü¶ì|åƒæHé²ìÑå‘ÜYîXø‹çŽí¡êŒê íÔí­ïæ×Bç…×míâÜHíïõ»ÜOãçìÀí»ÞšâgîDßqÛvßÍîìâ‡õâõyèIßáç¶ÚrÜoÜ€ôDãõêwêyÛFÛGï˜ùzð¬óýóûóìò½ñõñôñóñ×ñÖñÉñ¼ñ²ñ°ð÷óÎóÆó¼ðãðÛð´';
  v_Chare   Varchar2(2000) := 'åíÞˆÝ­âeï°ÕMä~îPô‰î~ùZù[×Fæ¹ùEêißÀÜÃêqéîÛÑÚÌÜ—ãÕãµÝàØ`ÝQß]ëñïÉß{îOðIØ¬Ö@é‘åŠöùî€ötù˜×†èyý|÷{ÝìÞôíEêzÝ[öÜëXõbøÞWåÇçíîïãsðDßƒÚÙ¦Ù@ÙEð¹ò¦ðÊ';
  v_Charf   Varchar2(2000) := 'áeÛÒéyíÀåzá¦ÞNïcïx÷YâCÞ¬ìÜõìÞÀçxú‹Þxî²ÜèóØœÝGïˆï‰ØÎÚúèÊîÕÚ“â[åpøhöÐô™áÝô³úJåúïwç³ìéìqö­öîöEïyäÇëèã­ì³é¼ôäÕuáôÙMïÐü”çšì]çãÜmâpëƒèûëVôšøXØk÷÷ü‹ØrÞMèMüRüvÙÇö÷å¯÷aããí¿ïLÝ×à•ähØSæ‘çQÛºìbïpüKßôÖSÙºÚRøLøPøiÙˆë€ø]ß‘ß»õÃáKôïïûõÆâaà~ØføWûŸüAüFÙìæÚÜ½ÜÀâöç¦ç¨ÜÞìðî·ÜòÛ®í‚øIíÉÝ³ÙëèõåõÝÊþEãRãVïOøDíhá¥øqÖDÛ~Ý—õHõvíêùfù›ß¼ÞÔàMáœäæÝoôfíëÚâæâØ“ê‚öÖêçÙxÝ•õVÙŽå‡å˜öûövð¥óõò¶òãòðó¾òóòÝðò';
  v_Charg   Varchar2(2000) := 'ê¸Ù¤îÅæÙáåmæØÞÎôpà@ÚëÛòêàëBØdÙWÙ^æYØ¤â}ê®Þ|ÛáãïÜÕôûÞÏøNôvýžä÷ÚséÏß¦÷ ÷hêºí·ç¤äÆÚMêlî¸âGä“æsí°éÀØºízúküŽúê½çÉéÂÞ»æ€Ú¾Û¬ï¯Õaä†ÛÙæüéxømøwÖgøæŠØªàÃÜªë¡ëõéwïÓì‘ík÷ÀÖYÝ‘õsækíuÞPíRöÛÁô´íÑãtßçØ¨ôÞÝ¢âÙûfÙsùˆàQßìç®öáõ†ëÅö¡ÜpýŠýÞÃçîÝ\ì–Ø•ÚCØþçÃâhã^÷¸íxá¸èÛØxÚ¸æÅì°åÜëgêíÙéïÝÔõýÝLÝMôþì±âõYøÝž÷½úXãéÚ¬êôî¹ßEîÜâ’ü‰ØÅëûî­ù]áÄèôêöïÀíådöñöAî™ëÒïNÚoäTïWøŽßÉØÔÚ´ÙÄévêK÷¤êPöŠ÷bÝ„å]ÜIøAÞèäÊØžßkîÂëqæšè…ûX÷}ßÛèæë×Ý_ã üUáîæ£ßžàFé|öÙõqý”ôhôkþIå³âÑØÐê{Ü‰êÐØÛêÁÙF÷¬íW÷Z÷iØ­ÙòçµíÞÝöçõPõ…ÖßÃÛöáÆâuåàþÞâë½Ùåâ£é¤Ý{ðRèJß^óþóôóàóÑòåòäòÁò¼ò´ñøñæñËðáðÙðÀðóð»ð³ð§';
  v_Charh   Varchar2(2000) := 'îþãxàËëÜáVõ°ï™í™ØEõA÷ýÚõêÏìÊäwínØJô_ê\ÝÕâFé\ÞþäIädîhîuÖ›ënå«ú[ôŒÞ†ç¬Ø˜î@ãìÝïàãÞ¶àÆå©×qê»å°î—ö‚Ú­àÀÛÀàAêÂîÁý†Ø€ãFãØ÷…éuûiûîMôçôŸêHíHý[ùŸèYý˜ëaÙRÛÖúQýLìeìfûSìgü\ì•èìçñûaø’ùCÞ¿èUÙêÜŸØFÞ°Ý“åÞZãÈãüÝ¦ØAâvébØDãpìô„äfÞ®ë”ÙäëŸø™üZÚ§é{äUé•é—ô\ýJãô×÷¿æAö\àCááåËàjÜ©Ø_ö×÷õ`÷cìÃéõßüã±Ü ëŒäïëiÖ—àñõúâ©ìÎéÎô–õ­îgì²æLôEö{ù–úCúKä°çúåtöUÙüá²âïìæìïìèà‚øUå×o÷Ÿí_í’÷sûIÕjåkæèîüänÖœçfú†èëÕ–Õ üXõ×øbùJà âµØŽ×’Û¨ä¡ÝÈëfØ}ïÌêaå¾çÙß€ØoæDéIûqÞSêXèG÷ßÝkÛ¼ä½åÕäñöéß§õŒöZödëÁÚòüSáåäÒåØäêéBè«ÖWå–öüÚ‡í‹çuöm÷UúŠÖeæwÚ¶ßÔêÍçõØYëDÝx÷âãÄö™ä§ÜîÞ’ßDõt×eßÜä«Üöí£èíåçà¹çÀê_ÙVÕdÞ¥ÖMî_×M×fçiêTçžìuí}×wîœãÔé’âÆðQÞFý@Ú»äãÕŸïÁØååxß«ß˜îØâ€â·éXØ›þAÖfëoïìàëÞ½èZì[ð©óóóòòºò³ò«ò¥ò¢ñþñüñëñ¥óËó¶ó³ó¨òÂòÀðúð×ðÉð­';
  v_Charj   Varchar2(2000) := 'Ø¢ß´ØÀçáÜ¸í¶ßÒØÞßóåìï|ïúê÷êåõÒøKã‚çÜÙ}Üuì´ÛÔåZëYî¿ÙŠàœëu×Ií‡ù×^çˆÜQíZúaýVèWèiýWûAá§Ø½Ù¥àBþLØCê«éêé®ÝðÚlãšÞªÛeì“ûnÝ‹Ûˆå‰ÞUçgìPúWúnÜeë|ë}Þá÷‚êªáÕ÷äô‡åæÜÁßâä©êéÙÊÛEëHôßÕHõÕö«öÝÕ‚öê÷ÙõJÛ”öaùHýTæ÷õŸ÷DìVö›÷C÷qåÈä¤çìôÂÝçõÊãeïØØjØ†æ‰û“áµÛ£àPí¢ê©îòÛOïäeî]îaø”ùGëÎÙZâ›ê§ÝÑØ]äÕêùégìyÞöçÌÝóØböäøZä’íKû…÷µ÷œùpöx×töúYí[öžè~ídàîèÅõÂíúïµÚÙê¯ôååÀå¿ÖˆôCörûxç‰ç™û{×vû|êðÚÉâVé¥ë¦ëìÚ™éfÙ`ÙÔÕÙvÚ{Û`õÝÖGæIðTæGçZÞYèaèbè{èƒÜüôøçÖ÷šíäí\÷FÖvîŽä®ç­êñánôÝáuÖ˜Ü´æ¯ÜúõÓÙÕöÞõoøŸÞBç€ú„úŒÙ®ÞØäÐë¸Ù]Û]ãqïœáèùa×K÷Rá½Ý^àÝÚŠÞIõ´×_á†ëAà®àµìŒù™ÚàæÝÚ¦ÚµÞ×Þ—èîæ¼ã]ô‚íÙöÚôÉÕmÛdîRæOõ^ï÷ºÕ]ôîÄáŽûvüTÚáÝÀâÛâËéÈèªå\Ö”æ¡Ý£êáßMçÆêîàäÙÚBý„ãþìºÝ¼ëæùXöLù~ù‚ûü û—ÚåØÙëÂÙÓã½îiåòåÉëÖÞŸæºö¦â°ÕeÛVîKìnìoçRØçìçåÄÞ›ïGîyôñãÎà±øF÷ÝôbéNíƒèÑèêÙÖöJûýnúÜÚêÞäé§è¢ôòÚ ï¸öÂÕ‡Ûgä|õLø~÷¶ù‰à`Ý]ÛRÚzÜvé…éÙùVÛžùqúGüŸýAÜìé·é°ö´þFõáýeÚªÜÄßšîÒÙÆêøÛBâ ì«ØeåðõXåáäïZöÄØ‹ÜMõ¶èLä¸ägämïÔæŒùNçîÃïÃäŸèðáúöÁÛ²ëhï…ðCàÙæÞçåáÈèöõûÚbÚ‘ßIØÊÚkâfØãÚÜâ±Þ§ø_ø`àåéÓéQïã×HõêÜBùŠÛÇç~çìßú€ý™ØÜjè‘ÜŠâxãzã—÷÷åå‹õzûŠûŽê}ÞÜðKùQùRùUð¢ðÏðÜðýóÞóÅòÔòÌò»ò±ò¡ñäñÕñÐñÊñÆñÀñ¤ðèðÕóÕóÈóÇñððÔð¯ð¨';
  v_Chark   Varchar2(2000) := 'ßÇØûëÌãlï´é_ç˜ØÜÛîâýê]îøÝÜÝaïÇå|æzêGïaâéæbíèê¬ýÙ©Ý¨Ý|ÝîƒÞRãÛî«êRÜ{ç_÷KØøß’ãÊîÖâ‚é`åêèàîíêûäD÷Šõwõ‘çæéðÚîÝÝVïýâŽî§îWáfîw÷Áá³ã¡ë´æìç¼à¾äÛï¾Õnä˜ØcØ~åoï¬ÕUäLå”çHÙÅáÇÜwÜxåIùyìÜÒíîßµâ@Þ¢údØÚß Ü¥Úœ÷¼õpç«à·ÕFÙ¨ã’ØáÛ¦ßàáöëÚ÷Žà”÷d÷ÅèwÚ²ßßÑÕEÝHÚ¿Ü’ÜœÕNù\ÞÅÚ÷ÛÛæþêÜÙLÝAãkäqà—üYèkã¦êNîåÓàkí–Ø¸à­ÞñêÒî¥î`åžæKÙçÜiõÍíŸÛ“ØÑà°ã´ÝÞÖdçqè^çûï¿÷Õûdõ«åKöïöHù{úAã§ãÍé€éèéîSéŸíAípìHíTôUðâòÒóñóíóØòòòñò¤ñÌñ½ñù';
  v_Charl   Varchar2(2000) := 'ååê¹íÇØÝÞhôFéJö_èníBáÁáâäµà[ßFïªånöDù„üHêãíùÙläþÙ‡îmîsù`ô¥á°ìµïçê@×E×ŽÜ_è|è”íeé­äíî½áYà¥ýœàOÝ¹ïüï¶àHÜqäZæƒãÏÕLéÝõßëáÀï©õ²ç„î‘èáîîã™õuÞLÜ~Øìêbß·ãîí‰÷¦ö˜ðEæÐçÐéÛÙúèDÞ[èhìY÷mýFÚ³ÕC×|èˆûPõªãîLî[åGïKîàÏÜ¨Ûkã¶æêà¬çÊÝñæËØ‚ä‚öâî¾äœÖ‚árÞ¼ß†áëxõ”ç\öPùv÷óèg÷~ûZþGÙµæ²åÎï®ØNýŸä‡å¢õŽõ·÷¯ßŠ÷kß¿ÛÞÜÂìåèÀÙ³èÝÚ\éöÛªáûíÂÝ°à¦ôÏîºõÈö¨äàãWøEë_øtë`ûáBúbû•ÜVÞ]×Þ^ìZ÷uìcÞÆßBöãå¥ì¡ÛšÖ‹æ`×`ôHç ö–çöÝüà˜æ®éçé¬äòåbå€æœönýé£ÞcÜ®õÔÝˆ÷ËôuÝgÕÝvåyÜGàÚå¼â²çÔß|ØIÙ’ÛŽç‚ïmúîÉá‘à€Þ¤éRÞÍßÖÙýä£Þ˜ÛøÞæôóïVõhø•õñôQ÷à÷vßøôÔàëOý á×åàê¥î¬û‹ÞOçl÷ë÷[âÞãÁéÝïCÙUÝþì¢éŠÜCõïÜ\ÜkÞ`àòãöÜßèÚê²û_èùç±ôáÚšÝCâéqÝsë‘ä™ë™õCöìøoûwëëžýhÛ¹öNýgáì`û™ý’êtîIßÊìÖä¯ì¼åÞæòïvïÖûméHöÌæyûˆçBïdçsïiö†úVç¸ï³äÛ‰ìCëwïfôjúwãñÜ×èÐççëÊíÃýˆçXìNýýŽØLÜ[èxì_ûTÛâë]ÚLÙÍà¶ÝäßsÖŒÜ}÷ÃíVáÐïÎçUààß£ÛäãòèÓëÍéñôµâ„öÔô—Þ_èzïB÷|ûRüuûuô”éÖïåæ”çœèuéûê‘äËåÖÙTÝ`äõÚ€Ûjê¤áXä›åhåjè´øšÛÞAçGöIùcùnçeú˜ëªãÌéµé‚úyàLïùëöäXèrèïÙõöÇùFèŽû[á›ï²äsäxàðêÛiÝ†ä—öMÕ“ÞÛîbâ¤ëáé¡ïÝæ ß‰úŸèŒÙÀÜsÙùãøÜýçóÞûäðöÃõiðµðÓóüóöóÒó»ó¹ò÷òëòÛòÈòÃñöñ®ñªñ§ðüðøðìðßðÝðØðÒð½ñïñìñçñÜñÚñÏñÍð¿';
  v_Charm   Varchar2(2000) := 'æÖáïßjæ‹úiö‡è¿éUßéôKö²Ý¤ÙIú”Û½ûœÙuß~ì@ìAî”÷´÷©ôMôNö æžà„Ü¬á£çÏì×ïÜÖ™çNÚøíËâIèšä€äÝØˆêóì¸ÜšáF÷Öå^ùšá¹ã÷ÜâêÄãTë£ÙóÙQà|è£î¦àŽí®Ý®àdáÒäØâ­é¹ïÑäYæ[úBüqä¼ÜzæVüeÚ›ômíi÷ÈÞÑîÍéTéYå{ìËí¯ë‰ÝùÞ«à‘à–ëüíæõ’ô¿ûsìXîŸûLÛÂô»åiãÂöQü€ìDìWÛ_ßäìòâ¨Öi÷ãû†÷çû”ÞÂéSá‚áƒûJáˆØÂåôôÍëßãÚ¢ôéãèåµÚ×à×ü†Ökå²ãæö¼ííäÏëïõ|ìrû ü@üMüIß÷ù‘÷]èÂíðíµç¿åãØ¿ßãøpèf÷xáºçäÜåçëçÅâŒÙ‚ä øsæFãÉãýéhíªüwé}÷ªöšÜøÚ¤àpäéêÔã‘øQî¨õ¤çÑÖ‡ÚÓæÆâÉüN÷áôžÖƒÖ„×OüOéâÜÔï÷Ø{Ýëõöã€ì…ïÒôŽüaõøæŸßèÙ°íøãwÖ\öÊøœüEë¤ãaÛ[ØïãåÛéÜÙîâë‚ãfëŽíJðÅñÇðÌó·ó±ó¡òþòýòúòìòÖòµóúóºò©ñòñ¢';
  v_Charn   Varchar2(2000) := 'ÕyïÕæ“ë~ëÇÞàØvÜ˜Øyâcì„ô›ÜµÞ•áèÍÝÁØ¾åràïà«ßaéªÖQëyôöëîàìôTâÎêÙß­ýQØ«ßÎíÐîóâ®×DçtÛñè§émô[Ú«ðHõƒõàÅâ…äGÛèâõà\îêâ¥ÛCâ‰ØƒÝröòöFûŒýuÙ£ì»ãbëWèXÞ‹êÇíþöÓõRöóùDöTéýÝ‚ÛœÜTØ¥Ûþá|á„ÜàôÁøBæÕëåí±Úíô«êŸà¿ãcÛWÛfÛhåRõææ‡êEÞÁým×‘Übè‡ïDèßÌè_ôVûHØúå¸æ¤âîáðâoìÙ¯ßæÞrÞsáxýP×aæeç×kæÛæååóæÀîÏâSí¤ô¬üQàGÙÐßößSÞùï»ÖZÛåŸð¤ò¨ñ÷ñññÄòïòÍ';
  v_Charo   Varchar2(2000) := 'àÞíMÚ©ê±økÖŽæ–útý{âæñî';
  v_Charp   Varchar2(2000) := 'ÝâèËÙ½Ý‡ßßÝåæWãÝÛAõçÛ˜æoíQãúîGäƒùbè‹ë„äèìQåÌ÷›ý‰ý‹ö„ëãâÒáóÞËÝNìŽûƒüBõ¬êkêŠïÂÙräžàúì·àÎö¬Þ\äÔâñÝJéoàØÜ¡Ý~åAíŠíŽùiôJèmÛsêCØ§ç¢ÚüîëØwâWâtâ”ãYãàèäšåCõBêVêoÜÅèÁÛ¯ÚðÛýØu÷‰î¼ëRô“õQõùùdÜ±âÏØòÛÜã›Õ|øaß¨äÄæÇî¢ê¶úûGêúôæú@æéëÝÙXÕ—õäÚÒÙGÕ›ôØâçÎïgïhôwêQéèî©áoî’àÑæÎë­Ø¯ÜÖçvæ°ØšæÉîlïAé¯êòæ³Ù·îZàZèÒÝZöÒÝƒõGîÇá•áNáwçkÛ¶ÖcØÏîÞãOçêîHïHÞåÙöê·ë¶ê†àÛäõ‹ÙéáTè±å§ïäÙŸçhäßë«ÖEïè×Võëç’ð«ñâñáó¦ó²óáóÍó´óªòçò·ò­ñÈñ±ðå';
  v_Charq   Varchar2(2000) := 'Þ€èçàVÝÂàÒéÊÕƒÛpÖ[ë’õèôtçKù†ØÁÛßáªÜÎêÈä¿Ý½Ú–Ü™âHæëçùç÷ì÷þDèŸí ônôoôëýRÞ­ÛaåW÷’÷¢õšùuù}÷èôGôyö’û˜ßŒá¨Ü»è½ØMç²ôìÖHêMãàÜùÝÝíÓí¬ÝÖÚžáMì—÷ÄÚäÜ·ÙÝá©ã¥Ø@âTâ`ëeí©ãUå¹ûeåºÕßwå½ÖtîvçcùkèBôRôSíaÝ¡îÔÞçÜâjã@ãQäEåXæZübö‘ÛÉëÉã»ç××lècÜÍÜçÙ»èýÝ€ãÞê¨õÄïºïÏäÛ„ïêÛ–æjçIçjæÍéÉÖmôÇìÁíÍàbàzõÎàƒà…ØäÛ^îNçØå æ@Ú‰ÜEÜFèAÜñÚÛã¾÷³éÔ×SÚˆçyíXî˜á ã¸Ú½ê~ÕVímíIÜNæªêüã«ïÆôŠÛoå›ö@çƒôÀÕWîzõÜËâsëdàºäÚì€àßøVéÕÚ_Úcï·äußÄÞììiàWàõÝXÝpöëõ›è[éÑ÷ôÜÜí•Õˆö¥ìmíàõ¼öÆÚöÜäÚ^é±ûjÚ‚öúíFíGöpöqù”÷Gý•áìÙ´ÞåÏá–êäâUÛÏåÙôÃÙgäMábõF÷üõ‰ùj÷AôÜá«Ú°êrìîÕoüLõ@Ú…üDÜ|ôð÷ñö÷OÛ¾ëÔÝ@Þ¡íáøzè³üšÞ¾ë¬áéÜdèŠûYýxÞ‘àTãÖêïé‰üCé˜üzãªçzÚ¹ÜõéúîýÛIÝbãŒÛmêB÷™÷ÜöeýjïEáëî°ç¹íjí¨ã×ãÚÚ|é êIùoåÒð¶òøòéòàòßòÞòÓòÐòËòÇóéóæóäóÜóÌóÀó½òûò°ò¯ñýñûñßñ·ñ³';
  v_Charr   Varchar2(2000) := '÷×ÜÛìüÜ`ôX×j×ŒÜéèãæ¬ëNßvØéâmôã…øžÜóïþÜrØð×šéíâ¿í¥ÜÝØìzì~ígïƒÕJïšÞwê—âJâ~ëÀáõáÉéÅéFægÝPôÛõåÝŠåˆ÷·ökù’íqßï¨ãœønàéå¦Þ¸ø›á}îž÷pàrÞzä²äáçÈÝêøMëÃÜ›Ý‰Þ¨ÜÇèÄî£äJä„écétÙ¼àeö}ö”úUð¦óèòîòÅò¸ò¬ñÅñà';
  v_Chars   Varchar2(2000) := 'ØíìƒØ¦è•ìªëÛâlëMïSàçî|öwÙë§ôLôÖâÌçDédÞúíßærî‹çÒëýöþïbö…÷fÜ£ØÄï¤ëäCÞQçmÖ ïoôOé~ï¡ôÄô‹öèéŒæ|õõßþì¦é„ö®áêßÜÏæ©îÌÛïô®Ü‘áŸé^õÇäúëþõŠê„éWÚ¨ØßÚ]ãˆæóÛ·æÓÖb×iÙ ç—÷­÷W÷XéäõüìØÖ…ôlÛðÙpèlç´ô¹ÝiïYõ}ÜæÛ¿äûâ¦î´ÝfÙdÙhÙÜØÇäÜís÷êÚ·÷“õ˜ù_öYöŸãhö•ß•ßÓïòÚÅ×ŸäÉÕ”îTô×}ëÏé©ävêjê…ê’þJãHå•ü›ù|äÅ×W÷jíòêÉÙKáÓÙ‹ßŸû\âPÝéãAõ§øOø[öõåœöXö‰úPá‡â»ÞyïzìÂÛõÝªßYãJãvöåõZüœ×Rüöˆõ¹âìêêÛéøîæá‹ß±ÚÖÙBÝYâ‹âžï—ßmäKÕœÕžß}ðSÖuáŒö|ýaÞÐô¼á÷ç·æì¯ç£êxæ­Ù¿ÝÄÜ“àgÞóë¨ÛSÛ\Ý”õ_ùeïøÛÓÚHü“÷núž÷tãðëòã_äøØQåfçTùŽùà§ÕXãÅéVäÌþBëpæ×ú{ûtûUç`Õlãßéjí˜ôBÕfÕhåùîåàÊÞ÷ÝôéÃælèpÛÌæùßÐçÁãjïtØËäFïÈäùälæJï\çrúƒýDãáÙîæ¦ìëãôæáÙ¹ï~âLØ|â–ï•âìÚ¡áÂäÁÝ¿áÔã¤ížÕbæànà²äÑâÈì¬ïËágæ}ï`ÛÅàÕî¤Þ´öÕõ‡Ùíä³ÚÕà¼ãºßiûhÝøö¢Úxßpä_ðMÖqÛ‘÷Tú‰â¡Ý´íõî¡å¡ìšëmßUëSÚÇÕrÙwìÝåäçw×\ç›áøÝ¥â¸ïŠöÀé¾æ{úZæ¶êýèøíüàÂôÈÚtõ€ßïæaæiæææ•ßCð£ð¸ðÞððóßóÓóÏóÂóµó°ó§òôòÙóùóâò×òÏòªñêñµðþ';
  v_Chart   Varchar2(2000) := 'õÁîèäâãBÜDõ]÷£öãËßeåÝê`é½ÕwåJìŸêFíOêY×nÜcææÛ¢ìÆõÌöØïUõTÞ·ëÄîÑâØê¼Û°ïÄÕ„á]åUît×TØáv×Zú‚ìþîããgáaêæÙyï¦ôÊïÛÛçMç|íUü‘â¼àoäçëGè©éÌÛ}ÚZõ±æhêOúSàûÙÎéEæ†è’èºï‘ÖzíNíw÷ÒÞä¬ßûìŠá[ì’ä•åcØ»ìýß¯Ø–ï«í«äˆü’ëøß‚Ö`öŒìLäRúeúfç°ç¾ßXÚ„õ®ÖpÛ‡å÷–ø˜î}õ{ùYö[ù•ù—ÜnÜƒÙÃã©åÑßPç‘ÚŒáLìjüVìpî±ãÙø‰êDúcúlãÃéåï›Ùqå`ìtÞÝÙ¬ìöö¶äpì›÷ØöæõæxýföœÕAôÐï¢Úqî\ÝÆÙNÛ@âŸãŽø‡ç“ç”èFï”÷Ñî®ì˜ß‹ÜðæÃÝãéƒöªÖFüžèèîúïFÕPäbîcàÌÙÚÙ¡ÜííÅÚUãPÙ×ãnã~ï ÷‹äüõjâúæBÙï÷»î^üWäŒùWýCÝ±âŠÛTõ©å„ùIùúhú“îÊâQÞƒÜ¢ÝËùrØ‡ÞÒæ˜úoú™î¶åèëPîjîkînôsÛÛƒìÕêÕü`â½ØZëàÜ”ï‚÷ƒôë˜ÙÛØ±×™ï€ô…Ù¢êuÛçãûÞèÞíÈõÉõ¢Û|éÒõDørü˜ö¾üƒâÕùKözèØÚ—ðÃñ»óêóÔó«ó¥òèòÑñíñÓ';
  v_Charw   Varchar2(2000) := 'æ´ü|Øôßœëðící€áËî“ØàæýÜ¹Ø™îBßÝ¸çºëäÝÒçþîµÝnÛläjå†ä[åsÙ–æ~Ú@Øèã¯éþÕsÝy÷ÍÞ‚ÙËåÔêžÚñÝÚìÐÞ±÷˜ögöhàíÛ×àøãíãÇífä¶á¡áÍß`àŒáWå…éõdìSìTì¿çâä¢æ¸ÚÃÚóâ«ôºè¸öÛÕ†ÛcílîQå—õnítï]í|ê¦â¬Ö^åMõKÞEçAìG÷×~ÜZ×ˆÜ^ÞdØnÝ˜Ýœ÷—æ’ö€ö“ãÓâ†ö©ô•øYøjéé”éšü•êZê[ØØãëî‚è·ûlæfúOÝîÞ³ýNÙÁÝ«à¸Ûbë¿á¢ä×íÒö»ý}ÛØÚùÚâEàwÕGÕ_øŒæuöƒàNßíä´ûcùMõˆ÷ùú~ØõåüâÐâèâäåÃêõåqù^ÜRØ£þ@Úãè»ÜÌßAìÉæÄëFì}æðå»Õ`öÈëœýHìFýIúFðÄòêòÚðôðíðÍ';
  v_Charx   Varchar2(2000) := 'ÙâÚÀÛ­ßñÞÉä»ì¤äÀÝ¾ÚTâRôÑôâô¸àqÙÒÕOØgðFæÒðOéØì¨ìäôËåaØGØHØlØ‰ëvõ–ùT×@õµç^ë^êØá@÷ûú è„àEêêÚvÚôÖæˆìI÷žïe÷@çôáãÝßâ|åïÝûãŠìûÖLÖlÛ’÷^Ühâ¾Û§àSâMãÒôªÚiìùÚVëKü_ô]êSìUßÈØBéiïPöyáòèÔêƒíÌê˜åÚè¦ÚYô Ý å’æ_÷ïúTépÕ’ç]ë¯ììôÌÝ²èõÑõ£ã”åßí„åvåwí†õrÛŸ×]úNÜ]÷€æµéeã•ÕtÙtÖPÝá_ûyÚDèvú‘ú’úšÙþáýê“Ú`õÐëUÞºå‚ìÞî‡í`ï@á­ÜÈêˆÕ^ä}åDØRüGçoö±ýEÜ¼à_àlàmç½ÝÙàxæøû‘÷`è‚âÔÛKâÃ÷Ïã}ðAößõaõœí‘÷zí—ç}÷PèÉßØèÕæçç¯åÐû^äìÛXäN÷Ìø{Öyø“újàUáÅÕqÖjÕ[þMÙÉÛÄß¢çÓÖCíPèH×ýšç¥ÙôäÍéÇé¿í…âÝâ³Þ¯åâÛÆÖxíCå¬ý^ýkýKÜaõóâàß”ê¿Ý·âdì§ä\Ü°öÎôgç†êcØ¶ÜŒîˆá…Ö_õSö]ÚêàDè—ê€íÊè™â]ãoã‹ätß©Üôã¬þNÜº×›×œßÝâÓõ÷âÊã–÷ÛæTõxø æ™ïqá¶äåäPçVçnýMíìí¹çï× íšíœôqÕšÖžôzè`ôPÚ¼èòà†ôÚõ¯äªÛÃäÓìãÙ[ã„÷rÞ£ÜŽÚÎÞïÝæêÑìÓÙØÕÖXæM×Xö~×zäöè¯ßxãùìÅîçäÖé¸ãCíÛïàìœïXæ›ÚKÞjíYí´û`õ½ëzú›ÞG÷¨÷LÚÊÚpÖoÛ÷â´Þ¹êÖõ¸á¾âþä­ä±Ü÷à‰öà÷S÷\áßÞ™ÙãßdÙbÞ¦îšèRðªóïóãóÚóÁó­ó¬ó£òáò¹ñãñ¶ðïðçðÂð¼';
  v_Chary   Varchar2(2000) := 'Ñ¹èâè›øfåEø†ùsçŒØóá¬çðíýý\åÂÛëæ«í¼ë²Þëý…âûëÙáÃÝÎäÎëçÛ³æÌáZéŽüiÚ¥ãÆåûÜ¾àIéZééÜîî†û’û}ûšÙðÙ²ÙÈØÉÛ±áDçüßVëCî»÷ÊÜyüdöoùžüfýdýŒüjükî›ýBô|÷úýzüsêÌêšìÍäÙøHõ¦ÚÝ÷ÐøeÖVØÍôeø‘àÙžÜ‚ázú`ÚIÚJ×…á€úŽá‰×—ØVØWãóãZë‡÷±å}ø„êgì¾è–ïráàìÈê–ÖUÝŒåø—ï^ç{öuìRûFÝIðBâóí¦çÛØ²ßºø^Ø³ëÈé÷çòÝUáæßbã“ïuïŸðPôíÖ{Ö|æc÷¥ï_î–öŽèÃáÊø€é™ýoúrì‰ýGê×ú_×Šè€ÞÞîôâXäyæUÚþí“êÊìÇÚËàvà’ØÌÖ]æEædùwìvûEÞvßÞâ¢àcì¥äôãžàæûpát÷ð×búsüpÛÝÚ±âùåÆâÂß×ÜèêÝÞ–íôôýÙOÕBÛDí›ïßzîUîVáÚî{õkÖ–çF×‚û@Þ~îÆÜÓô¯áÞ ârãiøCì½Ý}î‰ÞTýtß®Ø×ØîêdØýß½Ù«á»âøæäÞÈÞÄôàéóã¨ÞÚØ—ê‹ÛüØ[Ø\âNëcÚ˜ÝWâzçËìˆìÚÕxï×ûkûoü]ØæéìÞ²ôèØŠõlÙ“æ„ïîØsìJöGù€ùù‹×g×háyá{èOú^úgÜ²ú…úœ×”ý~êfä¦ë³êŽî÷ê”ê›à³Ü§ãŸìÖNë–éžë íÛóáþâwý‡Û´â¹Õzãyö¸ö¯ý]ýlúÛÈßÅâYâiï‹ëLì‚ï‡Úyë[×ÜáØ·áSõgÝºçøéAàÓÞüÙaè¬ë›øŠâßíŒævúD×súLè]úˆÜ…ú—ûKûWÜãÜþÝÓéºäÞÝöäëÙøÖhå­ÚAÛ«ïIîeçëôì™×Gà¡çßà{Ü­ã¼äVÛÕàaïÞëtçO÷«÷Ó÷Iúxà¯ïJî„öÙ¸÷‘Ûxõ—ákØüßÏû~à›ÞÌèÖÝ¯ÝµÞœà]ßKß[öÏéàâ™÷†ÝjôœÝ’õOßˆØÕÝ¬îðäBë»÷îÙ§àóå¶Þ”ØzáRÕT÷øæúÞ}ê|ßŽæ¥ì£ì¶ô§Ø®ô¨áüÚÄáCâÅÝÇâDêœö§ô~áÎÞíëéè¤êìÕ˜ëkðNôˆÛuÝ›å“Ö~õ‚öVöiú}ûCØñÙ¶àôàöâ×àhèžÕZäoö¹Ø…û‡ýrí²åýâÀêÅîÚþCÚÍßNãÐï„ìÏÝ÷â•îAØ¹ÝhãƒëTßyä`ø\ìÛÖIå[é“øƒø…øˆôráqùO×uÞXçŸìMå÷÷Nú–ûOÜ†ôcôdíóûgøSä‘øxùtüŒüÚOß–ãäë¼Ø’áJâƒö½Ü«ô’à÷éÚÖwÞ@üxæ…ß‡ù úMßRßhÛùæÂÞòè¥îŠë¾Ü‹îáÚ”â_ãXé†é‡éÐÙßå®ügÜSûNý›ûVÚSîfÙšç¡Ü¿êÀàyë…ëµä]êmáñéæâqëEìBýqýyÛ©ã¢àiã³ß\è¹ìÙÙ„ádájíríyíð®ðÐðéðöó¢òöòõòæòâòÕòÊòÄò¾ò£ñÁóîóÛóÄó¿ñ¿ñ¾ñºñ´ñ¯ñ«ñ¨ðùðõðêðàðÖðÎðÁð°';
  v_Charz   Varchar2(2000) := 'Ø´ØÆØÓØëØùÙªÙ¾ÙÌÙÞÚ£Ú¯ÚºÚÁÚÂÚÑÚØÚÚÚÞÚèÚìÚîÛ¤Û¥ÛµÛ¸ÛÚÛúÜÆÜÑÜïÝ§ÝÏÝèÞ©ÞÊÞÙÞêÞøÞýß¡ß¤ßªß¬ß¸ßÆßåßîßðßòßõßùßúàùàýá¤á¿áÌáÑáÖáçâ¯âÍâåâôã·ä¥ä¨ä·ä¾äÃäóåªåÅåéåëæ¢æ¨æÑæÜæàæãæíæïæûç§ç»çÄçÇçÕçÚçÞè°è¶èÌèÎèÏè×èÙèäèåè÷èþé«é»éÆéÍé×éòéôéùéüê¢ê°êµê¾êÃêÞêßêâëÆëÐëÑëÓëÕëÞëêëùì¹ìÄìíìñìóìõìúí§í½íÄíÎíØíÝíéíöî³îÀîÈîÛîùï£ï­ïÅïßïíïñïôïöð¡ð²ðºðÑðäðæðëðññ©ñ¸ñÞñèò§òÆòÎòØó®ó¯óÃóÉóÊóÐóÝóåóçóðô¢ô¦ô±ô¶ô·ôÒôÕôØôãôêôõô÷ôüõ¥õÅõÙõÜõàõîõòõôõþö£ö¤ö·öÉöíöö÷®÷Ú÷æ÷þ';

Begin
  If v_OutNum<1 Or v_OutNum>40 Then
     v_OutMaxNum:=10;
  Else
    v_OutMaxNum:=v_OutNum;
  End If;

  If v_Instr Is Null Or Length(Ltrim(v_Instr)) = 0 Then
    v_Spell := '';
  Else
    v_Input := Upper(v_Instr);
    v_Spell := '';
    For v_Bitnum In 1 .. Length(v_Input) Loop
      v_Bitchar := Substr(v_Input, v_Bitnum, 1);
      If v_Bitchar >= '°¡' And v_Bitchar <= '×ù' Then
        For v_Chrnum In 1 .. Length(v_Stdstr) Loop
          If Substr(v_Stdstr, v_Chrnum, 1) = '-' Then
            Null;
          Elsif v_Bitchar < Substr(v_Stdstr, v_Chrnum, 1) Then
            v_Spell := v_Spell || Chr(64 + v_Chrnum);
            Exit;
          End If;
        End Loop;
        If v_Bitchar >= 'ÔÑ' Then
          v_Spell := v_Spell || 'Z';
        End If;
      Elsif Instr('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.+-*/', v_Bitchar) > 0 Then
        v_Spell := v_Spell || v_Bitchar;
      Elsif Instr('¢ñ¢ò¢ó¢ô¢õ¢ö¢÷¢ø¢ù', v_Bitchar) > 0 Then
        v_Spell := v_Spell || Chr(Ascii(v_Bitchar) - 41664);
      Elsif Instr('£Á£Â£Ã£Ä£Å£Æ£Ç£È£É£Ê£Ë£Ì£Í£Î£Ï£Ð£Ñ£Ò£Ó£Ô£Õ£Ö£×£Ø£Ù£Ú',v_Bitchar) > 0 Then
        v_Spell := v_Spell || Chr(Ascii(v_Bitchar) - 41856);
      Elsif Instr('¦¡¦Á', v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'A';
      Elsif Instr('¦¢¦Â', v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'B';
      Elsif Instr('¦£¦Ã', v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'G';
      Elsif Instr(v_Chara, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'A';
      Elsif Instr(v_Charb, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'B';
      Elsif Instr(v_Charc, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'C';
      Elsif Instr(v_Chard, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'D';
      Elsif Instr(v_Chare, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'E';
      Elsif Instr(v_Charf, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'F';
      Elsif Instr(v_Charg, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'G';
      Elsif Instr(v_Charh, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'H';
      Elsif Instr(v_Charj, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'J';
      Elsif Instr(v_Chark, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'K';
      Elsif Instr(v_Charl, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'L';
      Elsif Instr(v_Charm, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'M';
      Elsif Instr(v_Charn, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'N';
      Elsif Instr(v_Charo, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'O';
      Elsif Instr(v_Charp, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'P';
      Elsif Instr(v_Charq, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'Q';
      Elsif Instr(v_Charr, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'R';
      Elsif Instr(v_Chars, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'S';
      Elsif Instr(v_Chart, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'T';
      Elsif Instr(v_Charw, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'W';
      Elsif Instr(v_Charx, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'X';
      Elsif Instr(v_Chary, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'Y';
      Elsif Instr(v_Charz, v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'Z';
--      Else
--        v_Spell := v_Spell || '_';
      End If;
      Exit When Length(v_Spell) > v_OutMaxNum-1;
    End Loop;
  End If;
  Return(v_Spell);
End;
/


spool off

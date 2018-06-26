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
create or replace function emr.datediff(v_type      varchar2, --ʱ�������
                                    v_startdate   varchar2, --ʱ�俪ʼʱ��
                                    v_enddate varchar2 --ʱ�����ʱ�� 
                                    )
 return number IS
begin
  --��

  if v_type = 'yy' then
    return round(to_number(to_date(v_enddate, 'yyyy-mm-dd HH24:mi:ss') -
                           to_date(v_startdate, 'yyyy-mm-dd HH24:mi:ss')) / 365);
    --��
  elsif v_type = 'mm' then
    return round(to_number(to_date(v_enddate, 'yyyy-mm-dd HH24:mi:ss') -
                           to_date(v_startdate, 'yyyy-mm-dd HH24:mi:ss')) / 30);
    --��
  elsif v_type = 'dd' then
    return round(to_number(to_date(v_enddate, 'yyyy-mm-dd HH24:mi:ss') -
                           to_date(v_startdate, 'yyyy-mm-dd HH24:mi:ss')));
    --Сʱ
  elsif v_type = 'hh' then
    return round(to_number(to_date(v_enddate, 'yyyy-mm-dd HH24:mi:ss') -
                           to_date(v_startdate, 'yyyy-mm-dd HH24:mi:ss')) * 24);
    --����
  elsif v_type = 'mi' then
    return round(to_number(to_date(v_enddate, 'yyyy-mm-dd HH24:mi:ss') -
                           to_date(v_startdate, 'yyyy-mm-dd HH24:mi:ss')) * 24 * 60);
    --��
  elsif v_type = 'ss' then
    return round(to_number(to_date(v_enddate, 'yyyy-mm-dd HH24:mi:ss') -
                           to_date(v_startdate, 'yyyy-mm-dd HH24:mi:ss')) * 24 * 60 * 60);
    --����
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
    ����1�� ��ʾ����
    С��1�꣬��ʾ����
    С��һ���£���ʾ����
    С��һ�죬��ʾ��Сʱ
    */
   if falg = 1 then
    if li_age_month >= 12 then --������
      ls_age := to_char(trunc(li_age_month/12))||'��';

    elsif li_age_month < 12 and li_age_month >= 1 then --������
      li_months := trunc(li_age_month);
      li_days := trunc(ADMISSION_DATE_TIME-add_months(ad_birthdate,li_months));
      ls_age := to_char(li_months) ||'��'||to_char(li_days)||'��' ;

    elsif li_age_month < 1  and li_age_day >= 1 then --������
      li_days := trunc(li_age_day);
      ls_age := to_char(li_days) ||'��';

    elsif li_age_day < 1 and ceil(li_age_day * 24) >= 1 then --����Сʱ
      li_hours := ceil(li_age_day * 24);
      ls_age := to_char(li_hours) ||'Сʱ';

    elsif ceil(li_age_day * 24) < 1 then --�������
      li_min := ceil(li_age_day * 24 * 60);
      ls_age := to_char(li_min) || '��';
    end if;
   elsif falg = 2 then
     if li_age_month >= 12 then --������
      ls_age := to_char(trunc(li_age_month/12));

    elsif li_age_month < 12 and li_age_month >= 1 then --������
      li_months := trunc(li_age_month);
      --li_days := trunc(ADMISSION_DATE_TIME-add_months(ad_birthdate,li_months));
      ls_age := to_char(li_months);

    elsif li_age_month < 1  and li_age_day >= 1 then --������
      li_days := trunc(li_age_day);
      ls_age := to_char(li_days);

    elsif li_age_day < 1 and ceil(li_age_day * 24) >= 1 then --����Сʱ
      li_hours := ceil(li_age_day * 24);
      ls_age := to_char(li_hours);

    elsif ceil(li_age_day * 24) < 1 then --�������
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
   Result :='�ӱ�ʡ�ˮ��';
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



/* select decode(Result,null,as_area_code, Result,'�ӱ�ʡ�ˮ��' ) into Result
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
  sAge    := iYears||'��'||(TRUNC(SYSDATE)- ADD_MONTHS(ABirthday, iYears*12))||'��';
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
  sAge    := iYears||'��'||(TRUNC(ApplyDate)- ADD_MONTHS(ABirthday, iYears*12))||'��';
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
     1: ���е�����Ҳһ��ץȡ��ֱ��������һ��RoElementԪ��
     2�������ڵ�ǰ����ץȡ��ֱ��������һ��RoElementԪ��
     3��ֻץȡ��ǰ����RoElemenetԪ��֮�������
  */

 return nvarchar2 IS
  v_result nvarchar2(4000);

  --����XML������ʵ��XMLPARSER.parser
  xmlPar XMLPARSER.parser := XMLPARSER.NEWPARSER;
  --����DOM�ĵ�����
  doc xmldom.DOMDocument;

  --roElementԪ��
  roElementNode xmldom.DOMNode;

  --pԪ�ؼ���
  paragraphElementNodes xmldom.DOMNodeList;
  --pԪ�ؼ��ϵ�����
  paragraphElementCount integer;
  --pԪ��
  paragraphElementNode xmldom.DOMNode;

  --pԪ�ص������ӽڵ㼯��
  childElementNodes xmldom.DOMNodeList;
  --pԪ�ص������ӽڵ����
  childElementNodesCount integer;

  --selementԪ�ؼ���
  selementNodes xmldom.DOMNodeList;
  --selementԪ�ؼ��ϸ���
  selementNodesCount integer;
  selementNode       xmldom.DOMNode;
  selementValue      nvarchar2(200);

  xmlClobData clob;

  --�����߼��жϵı�־λ
  isEnter integer := 0;

  --�ڵ����Լ���
  nodeAttributes xmldom.DOMNamedNodeMap;

begin
  --��ȡxml���ݣ�clob�ֶ��л�ȡ��������
  select content
    into xmlClobData
    from recorddetail
   where id = v_recordDetailID;

  --����xml����
  xmlparser.parseClob(xmlPar, xmlClobData);
  doc := xmlparser.getDocument(xmlPar);

  --�ͷŽ�����ʵ��
  xmlparser.freeParser(xmlPar);

  --��ȡ����PԪ��
  paragraphElementNodes := xmldom.getElementsByTagName(doc, 'p');
  paragraphElementCount := xmldom.getLength(paragraphElementNodes);

  --ѭ������
  For paragraphIndex in 0 .. paragraphElementCount - 1 LOOP
    --********ѭ������ BEGIN********
    BEGIN
      --��ȡ��ǰ����
      paragraphElementNode := xmldom.item(paragraphElementNodes,
                                          paragraphIndex);
      --��ȡ����������Ԫ��
      childElementNodes      := xmldom.getChildNodes(paragraphElementNode);
      childElementNodesCount := xmldom.getLength(childElementNodes);
      FOR childElementNodesIndex in 0 .. childElementNodesCount - 1 LOOP
        --********�����е�Ԫ�� BEGIN********
        BEGIN
          roElementNode := xmldom.item(childElementNodes,
                                       childElementNodesIndex);

          IF isEnter = 0 THEN
            --�ҵ���ʼRoElementԪ��
            BEGIN
              --��ȡ�����е�roElementԪ��
              IF (xmldom.getNodeName(roElementNode) = 'roelement') THEN
                BEGIN
                  nodeAttributes := xmldom.getAttributes(roElementNode);

                  --��ȡname == v_roleElementName ��roELementԪ��
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
              --�ж��Ƿ����������roElement�����������Ҫ�˳�ѭ��
              IF (xmldom.getNodeName(roElementNode) = 'roelement') AND
                 v_flag != 3 THEN
                BEGIN
                  isEnter := 2;
                  EXIT;
                END;
              ELSE
                BEGIN
                  IF (xmldom.getNodeName(roElementNode) = 'selement') THEN
                    --�����"��ѡ��"��Ҫ�����⴦��
                    BEGIN
                      nodeAttributes := xmldom.getAttributes(roElementNode);
                      selementValue  := xmldom.getNodeValue(xmldom.getNamedItem(nodeAttributes,
                                                                                'text')); --��ȡselementԪ�ص�text���Ե�ֵ
                      /*
                      selementNodes      := xmldom.getChildNodes(roElementNode);
                      selementNodesCount := xmldom.getLength(selementNodes);

                      FOR selementNodesIndex in 0 .. selementNodesCount - 1 LOOP
                        --ѭ��selementԪ�ص�������Ԫ��item
                        selementNode   := xmldom.item(selementNodes,
                                                      selementNodesIndex);
                        nodeAttributes := xmldom.getAttributes(selementNode);
                        IF xmldom.getNodeValue(xmldom.getNamedItem(nodeAttributes,
                                                                   'selected')) =
                           'true' THEN
                          --�ҳ�item������selectedΪtrue�Ľڵ�
                          selementValue := xmldom.getNodeValue(xmldom.getFirstChild(selementNode));
                        END IF;
                      END LOOP;
                      */

                      v_result := v_result || selementValue;
                    END;
                  ELSIF (xmldom.getNodeName(roElementNode) = 'btnelement') THEN
                    --����ǡ���ť����Ҫ�����⴦��
                    BEGIN
                      nodeAttributes := xmldom.getAttributes(roElementNode);
                      selementValue  := xmldom.getNodeValue(xmldom.getNamedItem(nodeAttributes,
                                                                                'print')); --��ȡbtnelementԪ�ص�print���Ե�ֵ
                      IF selementValue != 'False' THEN
                        BEGIN
                          v_result := v_result ||
                                      xmldom.getNodeValue(xmldom.getFirstChild(roElementNode));
                        END;
                      END IF;
                    END;
                  ELSE
                    selementValue := xmldom.getNodeValue(xmldom.getFirstChild(roElementNode));
                    IF instr(selementValue, 'ҽʦǩ��') > 0 or
                       instr(selementValue, 'ҽ��ǩ��') > 0 THEN
                      --����ҽʦǩ�����˳�
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
        --********�����е�Ԫ�� END********
      END LOOP;

      IF isEnter = 1 THEN
        --����ָ����RoElementԪ��
        BEGIN
          IF v_flag = 2 OR v_flag = 3 THEN
            --ֻ�жϵ�ǰ����
            BEGIN
              isEnter := 2;
              EXIT;
            END;
          END IF;
        END;
      END IF;

    END;
    --********ѭ������ END********
  END LOOP;
  v_result := ltrim(ltrim(v_result, '��'), ':');
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
     1: ���е�����Ҳһ��ץȡ��ֱ��������һ��RoElementԪ��
     2�������ڵ�ǰ����ץȡ��ֱ��������һ��RoElementԪ��
     3��ֻץȡ��ǰ����RoElemenetԪ��֮�������
  */

 return nvarchar2 IS
  v_result clob;

  --����XML������ʵ��XMLPARSER.parser
  xmlPar XMLPARSER.parser := XMLPARSER.NEWPARSER;
  --����DOM�ĵ�����
  doc xmldom.DOMDocument;

  --roElementԪ��
  roElementNode xmldom.DOMNode;

  --pԪ�ؼ���
  paragraphElementNodes xmldom.DOMNodeList;
  --pԪ�ؼ��ϵ�����
  paragraphElementCount integer;
  --pԪ��
  paragraphElementNode xmldom.DOMNode;

  --pԪ�ص������ӽڵ㼯��
  childElementNodes xmldom.DOMNodeList;
  --pԪ�ص������ӽڵ����
  childElementNodesCount integer;

  --selementԪ�ؼ���
  selementNodes xmldom.DOMNodeList;
  --selementԪ�ؼ��ϸ���
  selementNodesCount integer;
  selementNode       xmldom.DOMNode;
  selementValue      nvarchar2(200);

  xmlClobData clob;

  --�����߼��жϵı�־λ
  isEnter integer := 2;

  --�ڵ����Լ���
  nodeAttributes xmldom.DOMNamedNodeMap;

begin
  --��ȡxml���ݣ�clob�ֶ��л�ȡ��������
  select content
    into xmlClobData
    from recorddetail
   where id = v_recordDetailID;

  --����xml����
  xmlparser.parseClob(xmlPar, xmlClobData);
  doc := xmlparser.getDocument(xmlPar);

  --�ͷŽ�����ʵ��
  xmlparser.freeParser(xmlPar);

  --��ȡ����PԪ��
  paragraphElementNodes := xmldom.getElementsByTagName(doc, 'p');
  paragraphElementCount := xmldom.getLength(paragraphElementNodes);

  --ѭ������
  For paragraphIndex in 0 .. paragraphElementCount - 1 LOOP
    --********ѭ������ BEGIN********
    BEGIN
      --��ȡ��ǰ����
      paragraphElementNode := xmldom.item(paragraphElementNodes,
                                          paragraphIndex);
      --��ȡ����������Ԫ��
      childElementNodes      := xmldom.getChildNodes(paragraphElementNode);
      childElementNodesCount := xmldom.getLength(childElementNodes);
      FOR childElementNodesIndex in 0 .. childElementNodesCount - 1 LOOP
        --********�����е�Ԫ�� BEGIN********
        BEGIN
          roElementNode := xmldom.item(childElementNodes,
                                       childElementNodesIndex);

          --IF isEnter = 0 THEN
            --�ҵ���ʼRoElementԪ��
            /*BEGIN
              --��ȡ�����е�roElementԪ��
              IF (xmldom.getNodeName(roElementNode) = 'roelement') THEN
                BEGIN
                  nodeAttributes := xmldom.getAttributes(roElementNode);
 --isEnter := 1;
                  --��ȡname == v_roleElementName ��roELementԪ��
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
              --�ж��Ƿ����������roElement�����������Ҫ�˳�ѭ��
             /* IF (xmldom.getNodeName(roElementNode) = 'roelement') AND
                 v_flag != 3 THEN
                BEGIN
                  isEnter := 2;
                  --EXIT;
                END;*/
              --ELSE
                --BEGIN
                  IF (xmldom.getNodeName(roElementNode) = 'selement') THEN
                    --�����"��ѡ��"��Ҫ�����⴦��
                    BEGIN
                      nodeAttributes := xmldom.getAttributes(roElementNode);
                      selementValue  := xmldom.getNodeValue(xmldom.getNamedItem(nodeAttributes,
                                                                                'text')); --��ȡselementԪ�ص�text���Ե�ֵ
                      v_result := v_result || selementValue;
                    END;
                  ELSIF (xmldom.getNodeName(roElementNode) = 'btnelement') THEN
                    --����ǡ���ť����Ҫ�����⴦��
                    BEGIN
                      nodeAttributes := xmldom.getAttributes(roElementNode);
                      selementValue  := xmldom.getNodeValue(xmldom.getNamedItem(nodeAttributes,
                                                                                'print')); --��ȡbtnelementԪ�ص�print���Ե�ֵ
                      IF selementValue != 'False' THEN
                        BEGIN
                          v_result := v_result ||
                                      xmldom.getNodeValue(xmldom.getFirstChild(roElementNode));
                        END;
                      END IF;
                    END;
                  ELSE
                    selementValue := xmldom.getNodeValue(xmldom.getFirstChild(roElementNode));
                    IF instr(selementValue, 'ҽʦǩ��') > 0 or
                       instr(selementValue, 'ҽ��ǩ��') > 0 THEN
                      --����ҽʦǩ�����˳�
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
        --********�����е�Ԫ�� END********
      END LOOP;

      IF isEnter = 1 THEN
        --����ָ����RoElementԪ��
        BEGIN
          IF v_flag = 2 OR v_flag = 3 THEN
            --ֻ�жϵ�ǰ����
            BEGIN
              isEnter := 2;
              EXIT;
            END;
          END IF;
        END;
      END IF;

    END;
    --********ѭ������ END********
  END LOOP;
  v_result := ltrim(ltrim(v_result, '��'), ':');
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
  sAge    := iYears||'��';
  return(sAge);
end GetYearAgeByBirthAndApplyDate;

/*
create or replace function GetAgeByBirthAndApplyDate(ABirthday DATE,ApplyDate Date) return VARCHAR2 is
  sAge VARCHAR2(20);
  iYears  INTEGER;
begin
  iYears  := TRUNC(Months_between(ApplyDate, ABirthday)/12);
  sAge    := iYears||'��'||(TRUNC(ApplyDate)- ADD_MONTHS(ABirthday, iYears*12))||'��';
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
  v_Py Py := Py('a������߹������H������������������������������������������������V�ˁ��v�����܄������ن��B�懆��',
                'a�a����֊�܍̐ۑ��������l����G���ܜ�G�C�s�a�}���}�v�o�K�i�B�@�L�c�rٌ�t�{�X�P�u���i�q�B�\�a�g',
                'a�L�I�J�o������������������������������������������󃇅\�{�H���������݋F�j��^�ɕ����q�u�бQ�V�U',
                'a�O�W�I�C�sȀɎ�s�Y�O�t؁�V�Q�@�Bǯ����@�����O���K�c���g�����������n��n���Z�l�a�������°�',
                'a�ð��������������������������������ᮅ����އƇ̈������S�W�����C��S�R�U�j�������`���|���E�����Ѡn���H�l�x�����K�O�b�T΂�\֒֓�E�U�G�O�J����^���q��',
                'b�Ѱ˰ɰְΰհϰͰŰǰӰ԰Ȱаʰ̰Ұ��������������屁������\�^�z�����ΊB���Q�y�i�p��[�˖��Ȟߠ�X�j�q�F�����T�j�_ƞ���M҆�y�^ڕ�R���Z�T��E�N�������ٰװڰܰذݰ۲����������h�߰ǒ����Ŕ[��',
                'b���ɪW�q�����]޵�b�oٔ����v��������߰�����������������K�ֈm�Њ����E�����ʕL�D�������t�O�{�O�R�ZΆΌї҃���A�k�l����n�q�k�[���C���X���������������������K�爠�ȉY��',
                'b�L����������ϒ��ʓs�ԗ����g���������R��Ő�K�{�M��rߙ�^�D�u�o�����������������������ٱ����������������������������܃��������E�����~���������ސA�ޖ����h��������ǘ�}˝̙�dЈ�����f�Jم�E�t',
                'b���d�s���h�b��U�R�d�_�`����������������������������������������������������Ղp���˂�F�\�h�Ո������ʑv�d�K�{�ȗG�f�����������ͪN�D�i�w���F�t�L�pƅ�����i��ˍ͓���o�R�|ؐ���K݅�f�m�^�C�E',
                'b�c�l������������������傖�ω��M�ٓ��L��y�`�ǟ��Ī����n�Sݙ�G�Q�M�ı��±��Ű�����ԁ�ٺ������爩��ܡ�l�R��ƽ�꒲�s�԰�m�Ԭa�e�n�p�l�X���E�M�J�A�a�G�a잱ȱʱձǱ̱رܱƱϱ۱˱ɱڱͱұױٱα�',
                'b�X�K����ԏY���`�o޵�v���I��娱�ۋ�`����{�V���g�@�S�{�K�L�x�F�E��z��������ֱ��ԮK��������߄�Q��߅���b�c�e�ױ����Ґ��ܷH�ۼD�u�x������\�M����ኍO����c',
                'bҌ�O�±��gŌ�l�����p׃�����ԪYà�w�������˟ϱ�����쮃��[�d�g�Aٙ�S���j�k�l�n�s�����Օ�F�l�~�l���B����M��̋���e�����a�r���X�h����T��ߓ�����ϱ�ñ����Ĭ��e',
                'b�f�ك����I�M̞�ٞl�E�_ϙ�\�������P󝚛Ĝ�����x�W��������ޒ�䉙������v�T�m���u�m���������s��������V�]���K��Ո����v�ⲡ�p����}���@�m�h�h���������C�B��',
                'b��ࣼ��������\�`���G�@��Q�����ò����������N���`�R�񒩛¶z�ಬ������ȕ������K�A���k��������Ň�C�g���c�D����N�ŵR�~�n�o�P�ݙ��q���}�˹����X��޼\�L�Y�N�m����',
                'b������c�J�K����߲�������a�G�Q�����Ѳ������h�i�Єψ�������곏Eɞ�Y�^�X����������',
                'c�����g�n�²ŲĲ�ؔ��òɂ��Ɗ�u�ʒ���P�Z�Ȳ˗��̿n�k���{��۲��вϲњ��M�]�L�Q�T�ґK�k�����o���Ӄ����L�N負|�ց����ײԂ}�Ղ���Ȝ檁�n�Pœ�@���ؙ��ى�ٲ�',
                'c�ڕ����Ѝ���ɘ���G����[ܳ�H�ݐ��x�H�_���������R���Y�Ŝy���m�ZɃ�x�������~ᯗq����Ӹ}�䳀���K�e�u���O��P�aӐ����������ő����l����˲�荿����x鶲����',
                'c�����d�g������汲�p�����O��٭��}�򆶃��Ѓ��ϊ���{��{�����i��濲���������ȟ��������S�a�ܝ����C�v������e����������ʎf���p�s���K�B׋����i�C�P���}�Ʈa�b',
                'c�����ۄ��ݝI���r�~鈺o���A�p�P�U�Ϟ�׀�㳃���ϲ������]����潜C�����ѕ��Ǭd�m��_���K�������ɳ�������D�O�^�c�L�Ϭ��q䖃����^���L�l������㮳��Y���S����`�����˳�',
                'c�������k�o�����������̳��n�����˳��z���}�R�����J�V�C�����|�����l�����e��܇�q�p��͒������������ފ�E�s�����J�س�����u���ӳ������Հ�o������������Ɛ巟G�k�����H��',
                'c�Z���c�m������I�R�l�����mڒ���׉}���~�{ٕ���įM������鴷Q�Y�Z�����r׏�p���ߠ����Ղ��������b�W�r���l�γſB����X�d�f�V���|�d�p��ة�ɳʳ��ǳ��J�ǌk�w���^�������A��',
                'c��Ô���͗����̹f������S�˳��\����䅝��γșr���j���r���ѳҎ��G�ӳԊw�o���ꏫ��E�����W���ʓ��ղl��|�A�V���c�~�J���[�ڳس۳ٍI�ݳָ��K�F�M�P�W�Yܯ�����s�߅�',
                'c���L�ޅq�݈��n�u���N���I�n�l�r���X��߳��ó����x�Ȑp������뷟U�bജ��ѯv�S�M놑y�@�o�J��B�둴چ�����u�����_���ҫ����������o��n�Z��ی��獃꙳���|���N�ߠ��',
                'cٱ����㰳�Ǔ��[��{����O����l����b�Ů��Pׇ׉��E�����G���h���{���c�����������،�iۻ�������Z�a���Z�a�e���n���ˏN�X���ÎЙ��{�������R�X�ƴ��ƴ��������ҝ郦�s�l',
                'c�A�s��ء�I���a��}��X�e�G�I��`�s�����U�z�����[�ߚbĕ���|�����u��������ݴ�밴��������������״��N��ݎ��F���b�����[���A�i�V�Ѵ��������������R�����l���}�J����k�y',
                'c�������������ﴷǔ�鳴��N�q�I�~���N�@�a�������t����Ꙛ�j����ꁴ���ݻ��Ë�Ɯ��O�ȝ_���c�����o�òQك�w���ִ��u�Ɛ�����O��Q�b�z���󴇚f���p�q�ګu���e���ʫy����',
                'c����Ĵ��~�e�ȮN�ǴŴ������i��@��B�y�Q�o�\�]�ˁհr�c�΁�̄p��Ƙ��Ǆ�a�y��Έ�n��Ӵ҇��ʏ���Ɖ�S���t�Н^�[�����ڭB��ϲj�b�Z�S�W�^�ԏ���Q���������F�p�z',
                'c�{���q�����ߠ�ց�՜�����ݏ���c�����������⧋{�|���K�u���ׯ��ؿq���y���A���ߥ��ڔx�f艔e���m�ܟ�ۚ��x�Z��޴߃����N���������J�t�y議����Q���y������㲴���륟n',
                'c����ċă�W�Pěߗ���坴����Y���v�꬛�u������i�q̑�ύ������c���z����v�z�ȉ���s�u���H����x���S��ɲ�����������',
                'dԌ�b��֝�b�B�k�h�d�L�_�n���κ@���T�q�������Ǯ�����ׇ}������򈙞��e�Q�A�δ��z�Q�����R���[�Jσ�J�N������󁇱o�\���y�����������a����᷎�߰��ʴ��������������܍ܤ',
                'd���H�����D�x���οD�\�l��ŕ�캉���O�y�^���l������N�n�������l�[�����S��э���F�ل隗�R���[���m�����y�㼍���d���^đ�������X�������Dࢆ��������̵������E͞�g���Q�n�',
                'd����壶V��}�X�Q��ٜ�K�������ɹY���}���ǭc�d��ř�}�����ԓ��[��ו���ʈW��������ЮG담X�^ځ���n�T�U�D��߶������s����ҵ���ꉵ��u�������v�I��옘���Z���W�F���\',
                'd�������K�ͱI���R�����m�|�p�R܄����z�Û�����ｇN�Ե��u�ēg�O�Y�Ƶ��O�⋿���O�~��Ř�R�ŵ�ꭵ˵����Q���ص����뙞狁��͏�Д������ꝵ��h�ֵ��ᴔ�L�C�f���J���m�φv�е�',
                'dݶ�b�����{����H�L�E􆔳��ˋ�p�e�Mص�}ڮۡ�s����׏~�����ƒ�ǜ�B���W�صܕA�m�Z�K���d�ۈ�淵�ޞ���\�b������ǅ���K����޵كC�E�V�d�V�������O�d�S���R�E�ǔ����م���',
                'd�ᘕ����ۆ���o�p���d����H��L���ϵ��_�s�ڵ�������������������U��͟늉|����յ崐�������a�@��P�����q�h����f���M���y�����m�ŏt��������ӎ�����',
                'd�y�u�H덯��L��S�����B�|����U�g���]�y�W���ܦ���鮒�x���e��������P�޵��HсŎ����������A�B�ۇö��궣����k�۶��������w��픶����Y疶��G��ӆ�}��b�����ֶ��O',
                'd�V���r�G�����M�A������ᴖ|�{�k뱂��Ċ�����Ǉ���X�[���C���H���ٶ���ʐՉ�������튟ἶ���������ޓ�����؄Ӎ��ϗ��L�P�뚄r�t���������X��ŏ���c�h������^���K���W��',
                'd��Y�uÖ�H���k��Z�L���L�]�^�`�aྲྀ��`���������빶��t�i�}���L�E�X��^�������٭{���y���x�K�G�~���o�b��tט�����ƶ��o�Ķ��Gـ�Vܶ�ʶŶǊ����T�����|��Ζ����C��',
                'd�e���H�̶ζωF��Ș��Ѭ��a�V�;�����呔��Y�f�����щ[�ůy�X��玶ӶԶҌ��q���Խ����A�c�摻�}�B��m�֐��ضՉ��ݓ檖���Ǡ�����H������O���������ޚ�۶ٶ��g�D�]�q',
                'd���v���Ͷ߄������և����섋�ޔ������k⇊Z�A���y�I��\��⒖����綗��r�o��E���D���m�����w𙈑���������F�G��������z�����������ؼ',
                'e��j����������ވ����k��ݭ��Ӟ�x���eﰶ��d�M�P���~�Z�[�F���S��F�E��x���i�������q�ٳX��@�эS����b�L�����v���r��ܗ���Ո�㵜����`�Q�]������c��i�Y����ʂ',
                'e�{�O��Iج�A�F�@�_����d��t��׆�y�|�{�C����W���E���s��������z�X���H���s�L𹻕�[���X��b���W�����Ƕ����ꚾ�����D��n߃ڍ���p�r٦�n�����@�^�EԠ������',
                'f�T�����v�D�C���S���p�����^�H�\�}Г�ܖ��U�x���o�k�l�����e�������үV������뷤�X�P�y�U�t�ᷨ���z�����m󌷫�鷬��h����ᦑ���������N�c�x�Y���F�G�K�i�����o���t���w',
                'f�B�C�����u��ެ���ܭ[�X���T�����잒�\���xϛ�������B�x���ﷸ�i�����������ӌ܏��F�D؜�G�J�˹��ў~���������ʠ��՜E�K���[�p�h���������������·÷ĕP�X���f���뼏��',
                'f�L��J�ŷ������w�Ȋ���d糷���U�q�q�p�������[�I�W�a�E�y���Ǖ����N�n�˷̊O�쳗����ʄ�u���ͷϖ{�����Εh�тn�|���X���Q���M���ЏUʆ�հC���O����]�ַԎ��׷ҕS�ոj��',
                'f����ӟ�m���p냖B�i���؊}��ږ����R�r�i�_�`�����k�B�V����ʈ���X�J�����k�������r�M�M�O�R�۲b�v�݈e�k�ܷ޶l�Ƿ߷��f���^ď�S����a��灧�K�N�~��h�O����`��L�o�傪',
                'f�Q��S���t���h�׷���ȷ䯂�^�t�A���h�l�S��Qۺ�����b�p�K�뒸�������ł�p��҃���S���gٺ���u���R�L�P�iو�X��҅���u������������]��ߑ߻�����c���N���Q�C�u���X��',
                'f�����K�������a�[���������J�A�F�ʁT������i��_�ڷ�ܽ�]����@����������������ƅ�������������ޫs�t�w�����ۮ��I�b�󸡮}��ݳ��������J�M���A���E������̒�����n�Jȃ',
                'f������ŀ�ݷ��R�V�O�D�_�J���}�hᥝ�����q�D�~ݗ�H���v���f���������}�Ը��Y�M����ᜒѸ��ӟr�G���港�o���븸�������������}�c���⸴�yӇؓ���bЕ���帱��D�k���c�����i�|',
                'f҄�c���ڸ����ֶOч�羔ʍ�l���x�`ݕ�Vَ��������v�g���',
                'g�q�r�W�٤�Q���ٸ¸��m�ثV���p�����򊡍Y�D�|�஄��ԓ�d�W�^��Ľi�Yؤ�_�����q�ƸǸ�ȑ�}ꮸ��w�����[�y�ɸ��Q�|�˫\�������ո̸��������x�Q���Ϲm�l�����v�����r�ϸҹC��',
                'g�����s��ߦ�����h꺱Y�礂����ƽC�l�_�֙g�Ӟ�������ոڸٸ،����I�׸ք�Ւ��G�����V����s���۸ܟ������޸�߰w�{��غ�����R�ݸ��p���z�k�������ǐ�������ª����',
                'g�c޻���̸��ھ۬�z����ﯹl�J�a䆸������������˸��鏐�����x�m�w�R�g��抅ρ�������ت���Z�����ܪ���k롘����w���k���Y�s���u�P�R�Z����������򴂀�Ѹ��w����',
                'g������ب��ݢ�^�j���j���u�ʸ����@�ԟ��c���f���K�s�����Q�칡�y��箹��c�������i�����톯�ֆ񹤹��������r���k�Ź��m��򼹪���@�b�����p�C�b��y���������������\얹���ؕ�E',
                'g�˃��Ź�������Н���h��ѐ�������xḹ����۫v�T�V���U�x�x��ڸ������ƙ�ڹ����_��찓k���g������Mُ�����ù¹��}����f�g�B𳸚�������u���L�M����챹������H�O�Y��ݞ������',
                'gڬ�ȹɍg������l�E�܂Ù���v���병�b𠘀�����Řb���Y�M�[�J���k�k�W̹ʃ�ˈ؍�����������������흃l�d���AϹ�Ƃ���O�����N�����T���m�օ��ɹЄ������Ԉqڴ��',
                'g���G�L��ԟ�ԹՖ��ʹy�֐s�ع۹ٹ�ҋ�Ĺ��F�A���H�Q���^�b�ݯp�`��݄�o�]�^�I�A���ᛌ�������ʐ����T���k������暹ࠃ���e�ٹ���}�➻��Ӟ՞��ۈ���ƚ��D���׃Z�_��U����',
                'g����U��ѹ��棹��ߞ�Ɨ�뎢���w���O���˹��F���|�ً������Y�n�h����峹��с��й��{����܉��뵃�Q�М�͊�mԎ�����j���۔����������ιK�F�}��Z�����ʘ��W�l�����i��',
                'g�Ж����ɀ�L�F��݁���P�������O�e֏�������������u�������H����偏������������⎽�I���X�b���������Ǒ���x���[����R�J����ݸ��',
                'h�g�W�h�m�s�D������́��@�w�唐���U�N�o�V怕��璚�򅚐�y��ԍ�X����ⒿS�]�H�o���q���^�W�i�N�s�@�{�^���R���˺������ܟQ�h�V��������������񛇯���a�ˁ����c������E',
                'h���H�A�����������T�H�i���Λ����ϗc���ʺ������]�b���K���w�n�{���Ⱥ��G�J�_����I���\���������~�۪R�t�����H���F�\�y����͔����L���I�d������Α�h�u�A�n��[��f�㺼���',
                'h�����a��ؘ�V�W�@������޶�h�����ƪ|�s���_�����غ���婻Dϖ�q�úº�껕a�S�h�ƺĕ��B����|̖�������������A�����������ڭ�Ǻ��X��Ϛ�̺Ϻ������͊��ӍP���A�t�҆Y��',
                'h�˱B���Ɇ��Ԝz�ж����M�������Z��Ԇ�F�������u�i�����K�����H�[҇�����Y���ވ��،y�Z���R���E�ֺպ��G�ְF�e�Q�L�e�f�S�g�\�ںٝ��ϒ���앁�ܺ�ԋ�޺�ߐ���Æ���a�����',
                'h���t�a��M�����C޿�U���ցY�b����������ܟ�p��ްݓ����Z����k��ƺ�K�Y���Ȍf���a�y������fݦ��ļ����o�{���A��|�s��ȇȈ�v�b�����D�~�p��C�f��ޮ�������Z�{��',
                'hڧӏ�Н����U��@�펫��ȉ���T�����F���A�f�\�����C���ᛕ�˺��jܩ�_�����`�c���I��~���U���~�~�����O��㱜X̏ܠ댇F�����i�X��_�����@���������W���؋|��⩽`������',
                'h���P�S���ι������k���eΙ���g��L�b���E�{���C�K�[�R��䰻��L��̕�}�t�U���u���������ꎏ���Z�������O�����˻�����𭽜�����������d�����U�n����o���_��s�I���_���N�ɳ�',
                'h�A�j�k�f���������������W��LΔ�f�����������������O���î�Ԓ�������勽��Ֆՠ�X�E�s��������ё�ב�ќ�љ��j�x�������|���Z�b�ȑ�ⵚg؎ג�O�����`��B���P�Ȉ�~�b�f�v�}',
                'h���a��٭h�o�D�q�]�Q�S�X�߱������k��ۼ�K�J�»���佻��𻼗h���Ն����ѓQ�o�����~���񯈘���ߧ�Ȳoː���Z�d�x�����Y�E�Żʂ������S�Ɔň��h�������ȏ�ؘR�ͬ����ꪍ�B���',
                'h��Ŋ���Ƿk�W�����c��ڇ�u�b�m�U���U�О�r�Εs�N�ѻϐ�ԅ�m�e�����Ɯ�n�Ͱ��w�Ҟ�ڶ�Ի֒��ӛ���͟F���Y��^�]�����D����q��Ԝ���N�j�v�E�x����Ğ`���߻؇�ݏh�j�o',
                'h���ޒ�C�D�`���z͠�t��Κ���m�S�e�܌����x��䫻��U�����{�����޻�๻ݽ}�����_�R�������ٜ�Ԑ�V�a�G�]�d�H���ۑ}������ޥ�ڙB���_�C�D�M�_�b�u�Z�_˙�d���β~�x�D�',
                'h���L�P�M�T��u�w�e�����ԐǗ��E�J钏����Ɯ��꿌�@ڻ�[�������k����o՟���������x��߫�d�����ߘ���ⷛ[������i���n�񄊻�؛��������؊_�C�@�����f������m',
                'h�h޽�ɕ��G�\���Z�������',
                'j�n�p���k�u��җ�ȁ��e�z�r̎Ց��υ�]Ɩ��v�\���W�����E�S�Q�Q�Z�o���t�Jآ�����Wߴ�����Z�����ἡܸ�����Ҽ�����������|�������������U����ކ�����K�_��ょ\�Ę���',
                'j�ܻ��}�u��ԑ��C���^�e�Z�Y���s���ي���f�u�I����^�^�Q�Z�a�V�a�~�W҈�i�W�b�A҉��������᧏��������ؽ٥�B�u�������E�u�ż��V���f�h��Ð�C꫼��O�꜖���J��������a',
                'j�l�����c�l㚎N��񤹜�mު��n�W�vΎ݋�Qۈ�ŝ���U�g�P�W�n�|�}�����M�j�䛋򱼷��������������ؔD�m�����ƼǼ��͈j�˼ɼ����a�ʼ����∅�c��䩼üoƈӋ��������ӛ�ʼż�',
                'j�¼��m�����Uȗ�ίs�@���_�E�H���ߝP�T�I�I�b�H�����ݕ��Ղ�꼽���̷]�E�H�ٙo���Y�J�J��۔�H�T�^�հU�_�R�������^�n�D�z�V���C�q�K�ӼВz�ћv�ȼϚ�������k���_�ªo��',
                'j�ʠ��`�e���ؼO�j؆����]�S�ۣ���P��v�����̼�͐�O��e�]�a���G�׫w�Δϼּ؋T�З��Z⛘\�����x�ۼݼܼټގ��k���{��ꧼ��Լ�߼����芦������Ԑ��\�����G�ՠ���',
                'j��Ȃȅ�g���߼�{�R����{�ٟҾ}�zʗ���ϟ�]�V��D�K�J���h�����M�V�p�����W�[����̂�d����ż��낛�����ȼ����윗���ʜp�������d﵏������ُ���꯼��z�u�M�O���',
                'j�����Oֈ�C�r�x��ϕ���{�v�}�|��������������������k�������������ɽ����V�{���립����[���`�����Ԙc�����������GՐ�v�{�`�݄����Z�]�I�T�{�����M�G�W���SŞ�Y�a�b�{能�',
                'j���������{���w�����{΅�����K�^���Q�����佮�P�\�F�������׽��X�\�Y�������v�vG����x�t���筏��H�{�������@����T�n���u��ܴ֘�L����毽��j�����������������Ն�̗�ދ�',
                'j���B�x�z��ĉ���p�o�Ժ��t��������T��ٮ�ؽƽʽȕw���ýŽ½��R�˄�븟��_�]�����]�q������蔺���ɕݭd�C���a���q�����R�ЅӒ�ӊ���νϔ��̽ќ���U�ҝ]���݋Ъ�ˊڊ�I',
                'j���_��ᆽ��ܽԽӒ��^���A�ൈ�m��Ý�֟��M��f���X���݌���ڦ�f�g�ٌ�M�o�½��wڵ�׽��ޗ��A�}ӓ漍����K�ܽY�˘P��޹�͝ԑ�]�ؘm�ٽ�ɕ�ڝ����m�d�юY�O�@�O�^��',
                'jϝϘ�V�㚲�d��w�N��������ý��d��v��V�|����Ȉ����p͎�����]ћ������ă���Ꮍ���\���b�������Q���n��\�v�T����ᎄ����Ǟ�H�������۝W�M�oɓ������\',
                'j֔�~������桽����B���ś�ݣ�x�������ᵉ�M���ƌ��|�ý������q�B�����Nف��������|�a�n�P�B���i�����������p���G����캔�S�Uݼ�����澦���������Y���X�L�~�����@����',
                'j�S���ٌc�G�H�q�������ӎ�㽭E���ǠG�Z�`�iς���n�����ɛ��փ􏆏�����ޟ��溗J�}�Q���x���d��������e���K�߾��o�s�R�����Ոs�爷�N�o��S�ׇ��ĂC��ޛ�ӟK�����G���T��',
                'j�❰�Eѕ�W�L����`���j�m�����\౾��[���b�žÁX�`�e�C�w�ľ��i�¼����N탅E�ɾʾ̾��і͂w��ǾȾ͎��B���֏G�H�W���f���J���Y�n����H�]���ӾЛt���ھԂ����үY�Dꏊۊ�',
                'j�J����x�����K�����ŉ�AՇ�g�|�x�~�������֛��I��ۚ��H�h���`���Ɯ����]���v��ٙh��V۞�q�e�^�G�M�׾ھپ��쒤���_���X���e��H�Ι��z���ڪ�������ܛ���ߚ�ߒ��Z',
                'j�j�涀�Ҿ��ƃ�绉�`�iЍ���Ͼ���n���q����̘�e��������u��������X����������䏌��Z���M���֠��������Z����g����N��þ�ێ���ǚ��Ė䟊F����������������C��۲��',
                'j�v�I�C�g�^�C�\�پ�ތ֌؁|�H�޾��]�ܾ����`�i�k����O���D������Ⱦ������ҏ���E�bڑ�ʽ^�~ҙ�k�f�㬜�܎@�D���ؠ�Ɐ�ʅާ�_�`���ә@�Q��Ĕ���p�q�u�H���B�����X珞���Ӂ',
                'j���ݾ�P���겟��؏葾������JЂ܊���q�S�T����x�A�ް���ҟ�z�������z�Ϳ����}�����ܕ���𞿥�B�������D�y�����K���E�Q�R�U��Ю��',
                'k�H�̞G�a�R�ˇi�s�F�d�l���X˛�Ͻ\���j�O�q�V�vĄ�w���x�s�^��Ў�J�m���A�h�y���ҭg�Q���t�O�t�������א�Ä�V�i�ǿ������������Q�l���K���_�瘿��������]���P�����܉N��',
                'k�a�����|�z�G�a��͙����ц��b�f���ݿ��述����ݿ�٩��ݨ�����d�|���R���b���{��|�����T�~�����ܿ��o���^���{�_�K���������Hߒ�㿹���ʿ�����`���}���������࿾�����D��',
                'k���w���\����� �����m����ڐ�ݍ��ïz�d�V�t�����⎘}�P�Ř�����W�f�w���L�ǿ����P��᳞ܜf�����ʿ˿̄w�Ą˿͍Q㡊Č��Έ�����ྐ���ﾴR�~�n䘴��S�G���\�ѿҿ��c',
                'k���o�������y���Կӳn��דּ��U�L��H�|�g�{���]���ň��ǐ������w�I�y�׿ֿ�읏W��������g�ڄ�ߵ�ېD����t���@���؝A�fޢ�]�p�d��ߠ�ݿޖ�ܥ����ڜ�����p�@������V竎�s',
                'k�\�F෽f�㯉��ѝ���䊯�~٨�E��㒿����g����w�S�Q����ۦ�����ډK�����~���X��Ē���[�d�팈�����w�y�p��T�U���ڲߝ�N�ѐb����n�E�H���ڿܒܜ�N�\�Ń��������������D',
                'k�r��p�ܿ�q�m���T�_�L�A�k�q�����Y�Ǖ�p���V���k�k���l��㦿����Q̝�N��l���u���k�ظ�����Y���җ��������`���w��K�j���ẁ�i�t�������ۓ���њCఋ�����������T',
                'k�]�ő|����ʉ�暕�r���A�q�^�������҈܋G�����^Ǎ�T�j����h����d�����Jт��@���K���C�O�H�{�A����͉חy�������X�ڶ��������ٱ�����������I�Q�u�v�������S�N��A',
                'k�p���H�T�U�i',
                'l���л��v㉌��ňh�ԛ�~�w�fƌ�x�k�t�}�T���B�k�F�������G�����n�����ͮo���M����������ǉ����ǓX�r��ˈ���ݜ����Y�������`�h���|ė�j�m�D�F�ʭ��J�_Ϟ�n�B����g�|�������',
                'l�[�@����Ɨ��Z�[�R�F���[�X調s�n�Q�D���H�������A���l��ه�m�s��`�|�����D�]�s�[�����������ȟ���������܃�����L�{�[���@�s�h�E�Ӕr�����@�a�m�̙ڵf�w�۞��_��׎�_Ҁ�|',
                'l��e�������������Y�����E�G���Ћ��[�G���젊�|���ĠA���E�f���������hॄ����O�D��ݹ���ȗO���v�Ƭ�����ﶹ^Ņ͙�H���q�Z��@�����ϖJ�R�iɇ���L遖T�������}�̻����̈́���',
                'l�J���[�����Є���暑X�����U�A�����o��������ІK�ѐ`�N�᫙�z��͌��ʘ��u�L���ӆ����ҋ������Q�g�~���b��߷���A���I�W��i�՘S퉺{������E������ɠ�î��ۿw�ؙ��z���W',
                'l�n���r�D�[���h�Y̅�m���}�F����ڳ�݉C�t���C���u�����܉��Nˉ�����X��Ϝ�{�|����P���ᛤ����I������L�[���G�b���K��h�q�a��Úܨ����G���k�J�䂒��㶱��o�^��{�������V',
                'l���ꐓ�~��Ǘଗ���𿄘��@�]��Ń�����ˌV�����L�{�H�kџ�������r���[ւ�r��޼߆�x���\�P�v��Ξ��y��G�C�c���g���h�P�~�Z������ٵ�b��沍q�������e﮻��Y�N���墶Y��',
                'l�~����ߊ�k���������������^������߿�����������������n����ٳ�����߳Pƍ���\��۪�ڐ����ۖ�����������wݰঋK���P�������j������������́������W�������T�W�W�E�������s��',
                'l�F�G��њv���_�t�_���W�O���`󜃢�噪�i�ض]ϋ���Ȕi�r�|�Z˞���s�����X�[�cϠ���[�`�b�����]��ׁ�^�����Z�u�c�����z���������������B�����́������X�iɏ�U�YҜ���V�t�z�n',
                'lў��奝￀�I�O΋���ۚ֋�`������H����^�d�������ϓ����I���Ք��aĘ���c��������������t���j���I鬟����򾚝��b���朞��n���~�|���Z��������c����ܮ�H�Ԙ�݈�Z',
                'l�I���Ɇ|����Þ�o�n�W���u���]���������������gՏ�v�y�G���������ȍ��Αl�k�ڋ�弍������Ô�����|���ǭV�NĂ�X���ӌ׏\���i�Iْێ�r��s�m�������ޤ�v�R���͞��ό��̲t�֚�',
                'l�����������Ê��h���Ɣޘ�����ҟI���Ԫd�}�џ����~��{�V���h���Y�C�����Q���v�������������ܕ��ջ��r�@�������O�ם������ݕɟ��U�������R���L���O�ɞ��l������[�H�z�A�j',
                'l�݄C�ԏ[�ޑ����ř_�ݰR�S�C�ߐt���ޟi�U����V�銮��A�C���\�k�`����c����{�犖��H�������ߕ`�E�������s�g�{�n�����_�ꍒ�����R�O���@��������z�����e���fښ�CɈ�k�',
                'l�q����c�C�s��|��ʙ���C���o�w�U���h��۹�N���h�g����`���������tЇ���I�X�����ʞ��������f�q������������^������]�s���������v�������e����m��]���H�@�Y񜇮',
                'l�˞g˘���y�s���B�d�s�t�i���V����ΗB���P�ﳾ^���S䍙P�[�������g�A���z��ۉ�C�w�f�j�w�F�M�����������וo�����ʱ�������¡���𘙝V����\���a�b�d�X�N��V�ɠz�����a�b�t',
                'l�\�@�F�H���L�[�x�_�T¤¢��£���]�ŉƔn�_�U�Y�����L¦�͊�ග���E¥�D�I�f�V�s�ǟ������k�eŔ�N֌�}���V�t��§�v�ⓧ�U�R¨�tª��©���ί����U¶��ߣ���]¬®«�䖛��¯��',
                'l�����y�S��­������R�����]�m�o�G�o�J���t���F���V�r���A�B�_�z�B�z�|�R�u±²����°�u��³̔�o�Fɝ�ĝ������ִ{��Z����ś��@��u�P�f½��v��¼�V��¸��ꑊ�G�O�˳tǊ',
                'l��¹���f��»�J�����˱J�Fµ���T·�n�L���������I¾�̟��r�y�tڀ�j��Xº�cʀ��h�j����F���V��ۍ�A�J�غ����G�I�c�n´�e�UӀ́���¿�����e�|��˃���y�H�������L�H�×o',
                'l�f�~�����Ž��ƌ����o���X���@���t�|�������Ɇ`�����̍���Ȅ�G�v�]�������l�r����������������F�J�a�D�\�n����螤�c�L�K��̉莰f�g�[����ᛁy���Ԯ�ﲈG�s�x�Ւ���������',
                'l�ځ��ւ�ꍇ��E�������Sǒ���@�K�]�F�i݆����M���b�ۈ���Փ���b���ކ����������T�����������_�T栃��Z�M�}߉�����j���s���`�z���s����I�{��e���R����������J�j��',
                'l���������i�B�z�w',
                'm�]��ƃ���N���O�������b߼���o�m�C؀�ќ������~�ӠӅ������`���苌������q���h����W�����������R�Ԫw�j���aΛ��i���}迵l�U����زK�O�q�M�R�T�K������������ݤ�I�X�{��',
                'm۽���ω��������}���]���u�~�@�A�������`���������m���z���M�N���U�̜������M���Z�\枲����Káܬ����������A���ם��ܿz�T֙�N�p������æ��â�n�xä���}��ã�W���������I',
                'm蚯g�{���MçǃƟ������ϑ��è؈ëì����é츜~ܚ�F��ê�������^�����î���������í�Fɋ�T�аp�d��ïð�gó���ґ�uñ�Q�|�ؕ�������ò���c�x�ۇ��Q��ô�Z�]ûöõƀ',
                'm��ü�zݮ÷�CÊ�d��ý���؜�⭱��B鹘Mú�s�C�P�r��ø�����Yù���[���u�j�B�|�q��ÿ������伋Z������þ�ʠB�z�V�e�Ò{�i���|�Ǳt���¯cڛ�m���S�ȹ��n�������ѫf���T�Y��ǖ�J',
                'm�`�{̊���ː����F���ǂ����Bå�m����E���_������������ޫ�p�{�����̑����B�����ʚٲ��������s���X����L���ͮH���������i����Q�����Ή����D�_��[������������oԙ�i��',
                'm�C���������ҫJ�����۔}�����J����d�������ͻ����М}Ȏ�^�U㝌B����������ٍa�z�s���ܜPҒғ���׉Q��Қ�טa�D�e���Z������Ǝȝ��z�k�����]�P�ߊ����i�޾d���X�e���',
                'm�������D���������a���������҆��������x�ﾒ�|�r��E���@�M�I����b�����ŋ����]���������翺F����������k���R����_�P��}�����I�p�ϑ̞f������`�f�x���񈄊�ẐB�F�G',
                'm������a���F���ϬY�\�ŕ��z�x�C⌾r����F���b�������ǔ����������I���h���w�}�o�O��������ϟ�����������b��ڤ�L�����p����u�q�Ԙi��Q����K�⊱���D������Ԛ���ѿ�և',
                'm������������ġģĤ�N��Ħ����ĥ�Uփք�V�x��Ģ�rħ���Ĩ���Oĩ���\���\�{��ĭ��İ���b���t�u���]���eĪ�����Q�J͈�{���sįĮ�����ī�����a�h����a�}Ĭ��ˏ�_柠j�c�g',
                'm��i��Ĳٰ���c����ı�w�\�����Eĳĸ뤪���ĶĵķĴ�\���r�y�k�����c���a�[ľ��Ŀ�L���������ٚ�ǀ�]��ļ�r�ĹĻ���H�����fĽĺō����J��C����',
                'n���j�ֶg�_�D���ÆH�����Y�x�T�Ë�ڙƛ����u�~���o�A���S��ؿ�Ғ����y��擁p���~���ǅȊ{���������Ƽ{М�น�vܘ�y���i����G�ÌY����ܵ�ʯG���iޕ��ᝋ�����������ؾє',
                'nΗ�r���Вo�����O�ϊɮ~�~����a��骟��Q�y���D���l����ڋR��e�����T�Ι�����߭�����Qث�`�ΐF�Ӎp��������i�L�H���t�j�L���Ր��ԅD×�ߐ�����X�Z�֋C���m�[ګ�ű��G��',
                'n���F�H�����ߟ�����ǂ��G������������u�ߌɶv�\��Њ��N��e���C��U�r؃�����F���u�M��٣����v���s��컕��D���W�M�o���X��ދ���f����[�z�Ӑ����������啿�Qā������j�P',
                'n�|���R���D��T����������݂�v�f�T�`إ���������|����������U�\��љ��������I���[�}��������������꟔�࿍��W���f�h�����L�Q�Y�R�����E�Z���ǻH���m�q�b�f�A��ב�b�',
                'n�DÀ����������š�������|�������������ޔQ���f���_�V�H�F�����AŢ希��Ý��ţ����Ť�\��Ŧ����ť�~�o�ũٯ��Ũŧ���r�z�s������ʝ�Zē�v�a�x���YŪ�����J�P���a�������e',
                'n��kū����@�w��Ŭ��e��ŭ�ՓxŮ�ϻs�S�Z�H��űŰ���f�qů���`���Q�\�GŲ�j�Г����Dŵ�����S��ﻘ`�L�Z�Kų�¼X�zŴ���',
                'o�˓���Ŷ�p��j�MکŷŹ�Ÿ�p�W��T�p�k��˚��t��Żż�U���qź��Ž�Y�a',
                'p���Zڕ�T�WΌї雜��������^���J�Ј�E�U�i�l�n�a�J�MΓ�q�z���w�ٷK�v�@�p�q�Տ̾��q�T�E�R��ˑր����Q����W�p�u�B�����t���K�_���t�F���m�o���L���[�b�^ƞ�Oćړ���v���T',
                'p�����v���f���L�i��͗��⍷��hÇ�T���~ڢҔ�ۊr�qſ�už�����������ᝏ������В��ٽ���ŪT���ƹu݇�������������W�s�e�������ݖ����A�����g�����ͿT��b�ۘ�o�Q�m���Лc����',
                'p�Ѡ��������j���G��b����қP�`�T�p����t�Q���������}���U����������I�����I�o�����ג������؈������ڞ䠏�����d�N�ь���܊E���尒�h�a�B�P�^�ސC�S�����[���k���������',
                'p�����p�r䞂_������������췛֫��丟Ʉ���]�����\�燊��\������Ȇ�����M�τ����ꛀ�y�g��Z��y�J�o�p���s�y�M�󒲸����lܡ������Ă��X�k�s�m��@�������՟ԑu���~�����A�',
                'p��e���e��i�u�J�m���A�v���������s�����C�n��ا������������W���y�̠�������u�y��������\�w�t��Y����i�y�����C�B���F�G�V��Ƥ�o�ōB�����Y����ƣ���ۯ��ơ�����n',
                'p�u������Ƣ�M�[����m���R�����Q�f�K�����`�d�Cܱ�Kƥ�������kØƦ��|�aߨ��񱇺ƨ�Ĝk�F�ǋ��D�Ƨ��궯@Ʃ���GƬ��ƫ�x��ƪ���@�����A��F�X՗�j����NҐ���G՛ƭ���]�_',
                'p�⏮Ư��Ʈ�����~�H���g�h�wư�i�Q��g�o���Ʊ�G�����ΏґG�Ʋ�ŕ�Ƴد���v���ƴ�I�|�P�D�nƶؚ�V��Ƶ�l���d������AƷ鯖W����Ƹƹ�jٷ�ڳf�E�z�Zƽ��ƾ��ƺ�Jƻ�Z',
                'p�����қ��r�L��ƿ�Ύ��KƼ�g�B���v�J��ɑ̓�u�Z�҄R�k��݃�{�G�q�q�O�����Ê���Ĝ��N���w�k�ŇM�X۶��c���ό������O�p�g�F�Ȕ��^����\�B�Ƴk���b�H�����H�g�h�������r',
                'p���V����͆R����˒p�ʎ}�~��ꆯj���m�ۓ�䁓����O������ǎ���h�уW�T���姲r�o��ٟ�b�h�������֟M�Շ��ߕ��ם�����E�k���V����m�n��',
                'q���x���]�I��Ԉܕ�����m�E��������B�M�I�^�M�g���X�����Q�U�u�M���a���pࠔ����������s�S������d�e�e�l�g�W���ʆkÍ�r�y�����Y�~�Bȓ�u�����ߟ}���М��f�KὍ��������C����',
                'q�}̈́�H�^�M���������[�V���������ڠ�L�R�z�l���L�ԏ��X�����j�����a���_�K�M���U�����L�F���ȠRň�B����ހ�����₈���������V�ݐ��ݒݗR�D�O���ۼ��z�[�ґi������e�h�mՃ',
                'q����t�K����������᪌�������������X�O�g�~�Ɣ������T�[�����鎩��俜j�X��ݽږܙ�H������������Ӑ泞�J�w��n�o�컞�L��N�z�B��D�Qޭ�a�B�������s������Ě�T�U���I��',
                'q�u�}��K�dŠϓ�G��y���O����ߌ�����ܻ���轫^���u�M����������粕������H���M���������������H�Z�����ű[����������ә������ԗ��������ӓ����P�\�r�s���w���j�J��τ��',
                'q�֒�ڞ�M었X�ǡǢ���s����ǧǪ��dǤ��ܷǨ��ᩖe�F�@�dǥ��ǣ�x��O�@Ǧ�����Tǫ�e�L�ǩ��e库��ù�Ս�w��v���o�p�����c�k�q�q�B�R�S�`�a������R���qǰ�Ԛk�ǮǯǬ',
                'q����bܝ�`�j�Q���p���EǱ�N�Xǭ�Z�b�c�K�`���R��ǳ�ɜ\���ǲ�S��Ǵ���`�l�cǷ�X����ٻ��ǵ��Ƕ�����|�`�qǸ�g�����G݀�R����yǺǼ��ꨔ�ǹ�o�]�j�Ć󗾪}ǻ�ܜ���ﺍ�ꘌ',
                'q�����z�Ϻ[�ۄ��ۖ�j�I�j��ǿǽ��Ǿ�ɝ\�@���ԙ{���mŚ�b���Ǔ��u���������H�����������������b�z�������������^���`�N�������ش���@��ډ�E�F�����J���ų~�̃S���ۇa���',
                'q�w���Ԙ�֯��ƴ�˖�Sڈ�y�X������~��ڽ�~�͎��Ϛ����V�|�s���ʸ[�N�N���j�m���҅���ӅL�Ԃ�������㫛�����͉�A��f���D�o�l�~��@烸`�]���������V�B�]���W���H�z�',
                'q���������ۈ��������lǛ�Z���٬l���s�d���������ܔ��V���՝௝����ψ�a�T���v�c����ތ��u�O���Ēa�߆wǙ��l��p�C�i�����������W����[��A�F���p���[��_�����隄�|�痳',
                'q��ȍ�������������������핝NՈ��������᳠���m�c�����D�����^���ƅo���������H���^�ğw�z���|��͋���ű��`�F���w�K�W�}�\˕���H��w�n��k�x�ǋp�c��j�E���~�hڂ���b�F',
                'q�G�U�p�q���������@��U�_�F������Aٴ�aӈӉ���p���z�iޝ��ᖗW���������U���Ϝ����H�ٟ���͏�Î��p�g�G���M�b�F�����j�@�A�z�������҅J�ڰ�r���o���E�|�����lР�^�����L��',
                'q���x�����l�t���o�n�L�څ�D�|��������O��۾����ǆ�d�T���Pȁ�@ޡ�S���J�z��J�g��޾�Z�ߞ����묻c�J��R���d���Yȡ�lȢ���s�yȣ�x��ȥ�`��ޑ�T�^����Ȥ��C��N�U�z�Y',
                'q�Z�Ȧ������g�zȫȨ��ڹ��Ȫ����ȭ������������Ȭ�o�������ܽh�Cț���T���jԏ�b��㌘��m�Xȩ�B���܌A�k�e���j�Sȧ�EȮ�L�繾J̆Ȱȯ�����ф��j��Ȳȱ�Uȳȴ�����ȸ��ȷ',
                'q�׉U�n����ȵ��ȶ���U���_�|�P頵C�I�o�]���n�Ҍl��ȹ�tȺ�dۧ',
                'r�ʃ����߅m�c��󐒝�c���uĞ�f�ț�ۜ��ǌ�y�A��ہ���@�݅��VЀЅ�cЙ��Ȼ�Y��ȼ����Ƚ����Ⱦ�z�v�G�y���K��ȿ��`�X���������}�Ñ��j׌��������Y��������N�_���v�@���ȟ�',
                'r�����ɏ�Z��e�\�m��������ߖ��Y�����B�r�ЄU������ך�Ό�P���іk�����M����⿊��x�ż�ӕܐ�e�G�V�H�z�~�g��J������w�i�e����R���J�~�_����������Ǝ�����ݍt���V����',
                'r�q�s���m�r���x�����Řs�۬��Z��ђ�F�տ^��΍���V�h�g�q��ϔ�ߌ]���P�\���b�Ề�Y���n�|�y�\���j��݊����~�k�k���Q���q��`�]ߏ���������M靖x�T�S�ʇ���n������޸',
                'r����^������}��p���N�����r��C�z�d䲆䋇�������M��d�J��ɉ��������X��ܛ�\�ެ}�Q���M���p݉�w�O�M�c�qި���t�G�B�G�H�����������������c�t������ټ���e�S�c�x��',
                'r���m��O�k�}���U',
                's�G��輔c���u�������Ђ�_�����������\і�x���v��j���D�\������~���k�wݐ�W���B�Y�m���\�p�g�Γ����d�p�~�f�r���^�A�y�t��ح�H�F�i�}�X�[��Ҏ�ǝ����������ʔ�{�ѷD�L',
                's�̜V����T�U�ɏZ�N�A�m�I�������ؒ���E�����Q생�ئ��������M�`�S�_���Ӛ����H�������T�����|�����wِ��̃���q��맚Ʌx�Р��L��ɡ��ɢ�ּB�̙V�R�V�W���D���^�d��ɣ��ɤ��',
                's��ј��r�ɥ�ʒ���ɦ��ɧ�������b�X���fɨ��ɩܣ���ײ��ɫ��ɬ�Ĝi駱m�X��ɪ�o�C���������𣝭�i�i�w�N���Q�m֠�o�S�{ɭ���Iɮ�O�~�Lɱɳɴ�oɰ�~���Q�}��ɯ����e��',
                's�������|�����\ɵ��������ɶ���S���ɷ�������ɸ�Y�k��ɹ��ɽ��ߍ�Zɾ�hɼ�u���������Gɺ���ZÈܑ���^�Ǆ����A��ɿ�`�����ܙc��������������W���������@ڨ����ɻ��Ә',
                's�]���Ɨ����R۷���������Ô����Ŵ��b�Ŀ���i٠����~�����X�����������ʑ^�C�K�����D�xօ�l����������p�l�A�ρ����Аv紾y�������՟��Ԕ��������iʖ����}���֖��x����ۿ',
                's�p�����ڊ�Ќ�B�K���������f�d�h��������ͅ����������h��������h�O�⏍�����ܑb���Jχ�s�M�؞�������J������늍�p���Aڷ����|���r��v�`�m������Ȑ�[�Y�KɆԖ',
                's�e�Q���M������_�Y����Y�h��ߕ�z�b��������q��ן�����B��Ք�T���ֲs��c�\�}���L�Y���ϛرs����Ì�I����驯}�םB�v�������j�����ΕN����Ɓ�}���{�iʤꅕ���Ϝ������H',
                's����|�������Wʡ�򂯜�ʥ�ɕ���ʢʣ���K���}���|�o�Tًʬʧʦ��ʭʫߟ�\��ʩ��ʨ���J��ʪȞ�ۜ�{�N��Ԋ�����O�t�[Ѡ����X���P�|�i�ʮ�ʲʯ�y��ʱ�bʶʵ�g�E�z�]ʰ�µuʴ',
                'sʳ���rݪ�����Y�P�֜��P�t�g�v�I���Z������ʷʸ�d��ʹʼʻ��ʺ�E�V��ʿ�������F����ʾ�bʽ�������ƅ�������΃��Ґ^�����ǖ����c���ʖ���i�x��������ҕው�߱�J���B�̈́���',
                's�s�������lԇ�Y���k�Ċ]�ɋҝ�՜՞�}�S󧺏���n�|�����������؈�����������������緯l�f���ݾR�ު��F��������喀���x歖�ٿ�����⼂������Y��ܓ�g�E������먚̽����S�\',
                's����ݔ�]�_�d���e��������������q�H������������������P�e�^�l�P�O�n�t�X�����������J�X�����Oˡ�����R�D�g�V���w�������������Q����f�T��̠ˢ�ˣ�X˥ˤ˦˧���i��˩',
                's�V˨���Y˫��˪�p���Z���ܵd�{�t�C�L�Uˬ�u�S���Y�`��˭ß�l��ˮ���j����絈˰�c˯˱�J˳˴�ʊ���i�p˲�B˵��˸˷��F˶�����������ôT�l��˿˾�i˽�Лq�h˼�l�w˹�z��',
                's�ϗ��D�j�t�@�˘{�L�Q�F��˻�z�P˺����ʑ·�J�a�z�\�l�r���D���ȁ������������Ɓ���榛�����K������ٹ�ٖƠ��t�����B�~�����L�rҖ�����|�T�ʜ���I�[�A�r���ɖ���������',
                'sڡ�s����ݿ�Գ��@���������㤒�������ؑZ������������A��b�m捃���nಎ��C���Ѫv�L�r��쬓��������g�}�t�`�p�ł������޴�\˒�����ծd���ո@�d���K�V�Ň��׫T����',
                's������䳫����ٚ����X�����V��༉O�܋���ݜ��C�i�h�ې�j�h�����x�p���ɝ��_�M�i�X��˂�qۑ��T��⡯i��W�{���g������V�䂋�a��ݴ�]��Ț������m�������U���S��Ď�v',
                's�l�聂��Z��ǈ���Ü��q�r������ӝܷ[�r�w�p�ݭj�X��u���`������Z�w�\�����ݥ⸓q�s�p�ʘ�V�p�������p龹��{��������j�������������������t�w�z�s�����������',
                's�R������Ŭ��a�i���C���R����ݷ��դ��',
                't�O���g�{�U�s�W鋲_�K���D�k���I�I�m��ɔ��⑓�ޅއ��E�Q���_�]�^߾�fܖ�J�D�ۇd���Z�h�����Tʎ���o�W�]��c�\�D��g�w�l�X�B��⚵�ɉ�����g�c�≒�d��Ԙ���Wу�P���ڎݑ�',
                't��܀�~��o���h�_�����ݝ���d���p�U����埊U���@�Iπ�W�՝g���V������|�Л쬟�����f�l���������k���������d��я�D�@����̡�]���H��̢�H�ˍ������e���`齚϶N����w̤���J��',
                't��̣��F�O�Y�n�c�k��L��̨̥ۢ�ŗ̦�ƞ����عx�_�U���T��E޷���F̫�����̭̬����̩���v̪⁜̑B�M̮̰�Z���a�j؝̯̲�c��̱�Z�����c̳꼂�̸۰�򐴏����W̵��̷������̶',
                'tՄ�]����̴�t��˓���T؍�v�Z������̹̻���I̺�g���������a�f̾̿��̽�蜞�N�@̼�l�U�y��驪R�����v�T��ۏ�M�|�U��⼈n���Âچ����o���������y�G�y�f��詶K�g�̴g�C�Ř��L���',
                't�}�Q��Z���h�n�O�y�S���Ȃ����������E憃��ܕ򠇲���̓��ˠC�����|�����ͽd�|���������Ϙ����_�l���z�N�w��ޏ�G����������������ѵ��i�T�I��[���c񊙄�Pػ����ӑ�z',
                't��߯��ؖÎ����cĆ���ۯ\�����ܝb��߂�gΟ��`�����v�L���T̄�I�L�z�Y���������R�e�f��簂����䍨����v����H�X�Æ٬v���Y�ӝz��ʃ�y��ڄ�����pۇ����}�{�Y�f�[�����咫',
                't�n�e܃�w�����ꛢ������ѐ�����P���W��N���{�����󛭃�G��̊����L�j�V�p��ěp��x�b���\���J����ٴ[�g�k�K���k�D�c�l���傁�����לL���_���`�t������C�q�`�t��',
                't���V�q��٬�������w�K�����G���x�l��ɂ�������p������C���x�f���i�q�I�x��A�I�����нrқ�q���\�g�����N���u�c����F�����������͡�J���[�����N����a �dߋͤͥ͢��',
                'tͣ�Í��s�j���ї��w����b�F���N�K��ͦ����P�EÉͧ�F�P�b�c��h���ͨ�]��Ɍ������ͬ١ͮ�M��L�I��zͩ�Ϟ����U����ͭͯ���p�hͪ�P�ׄ��~������ӖS�H�Ԡ�Āͫ�jͳͱͰͲ',
                't�y����ʹ�Q�q͵���BͷͶ���^���}�����W�e͸͹�dͺ�Lͻ�l�ޒ؈����fȋ����W�C��ͼ��x��ͽ��Ϳݱ;���^�\���T�į��\�]�\⊈D�E�O�T���G��B�I���h�����M�B���Q��ރ��ǁܢ��',
                't�r�Īl��؇�Ň��҈F�_����昼a�o���C��蜨щ��ɗ˔���P�j�k�n�s�~�L۝�QÕ�ȃUۃ�h�ˊ��������D�̅זN�l���`���X��Z��ܔ������ę�ۮ��dرי�К����ϛk�M�hЛӚ��Ó',
                't������٢����A�������ȳaІ�ҽF�������P�W���j�|�����D�r���n������ך��Ջs�֗����E�K������ڗ����X',
                'u�m�i�C�_���H�H�x�IɅ�S�E������Ɗ���ĖG���C����ņ�T�[�e�˚`���wˀ�J�����q�s',
                'w�~���f������X�v�K�P؞�����i�z�J����Ċ�n֜�x���M���^���N�oş�H���[�h�j�h�����ψ����i��W�^���s�O���z셲y�w���ÌR�筎�r�T�ڬ]����z�܄����ޏ�����洮|���z���ܓ�',
                'w�Νj�D�|������ߜ�����[�������e�m�c��ᆷ���������������G�屛�ꝟ�㏝�Ϟ���\����ܹ����e�渊�w������Tؙ�Bߐ���{�n����D������i����ҕ����������O�U�n�l�j�',
                'w��d�e�v�����f�D�[�H�sٖ�~�@���������������������w�^��������������D������͇���W�\�s�y�_������ނ���Z���RΣ�����������ҋW�n�̓G�f�w��Ȗ��΢�ܘL����ԕ�J�k�A�Uޱ��',
                'w�IΡ�g�h��ΪΤΧ����Υ�Ǎ_�e�����fΦ�Ψ�Ωά���͎��������`Ϋɖ�������H���d�L�W���Sΰαβγ�Yέί����渒˛��U�Â��΍��|�uή���[���@�ΐ��Ȕ�J�\�]���۟��|��',
                'w�^��踃^�S�O�V�ی����lՆ�c�l�Q���S��n���t�]�w������δλζƄηθ�ξ�}ǋνι�yμ⬟���εο�ݠҴo���o�l����M�W�o�^�]�K�G�E�jκ˗�E�A�G���v���~�Z׈�^�j�e���ج��v',
                'w���n����w�����ď����[�ɳR�ży�P�ë���������b���Y�jΝ���R����Z���ǅ؏�^���W�ɗSÂ�ȷg���ʊp���|���bÁ�h�����������lΊ�f�O�T�R�ǜ���\��޳�Y���N������',
                'wݫ����u�i�n��ѸC��΁�b�Ҋ���Ӂ�������P���_����ןs�җ��O�ӲY���x���}���؏v�����ؖg���ݛ�����ڏ�����E�w���G�_��Ώ���u������������������ƕ�`�@���c�o����ʏ�N�M',
                'w�����~�W�������������������ÕJ��b��W���憕�������]���ʴI�Ĭ��苳�T�����q����W�^�Rأ�������ば��N����̏���J����Ր��򐚻|�A�����č����F�}���V�Μ���廟��`����',
                'w�P��H�F�I�F�\�F',
                'x�G�߉��Q�L�׼Y�W����b�e�Kՙ���o�mҎ�Q�q�`�k��֛ކƒ��B�AΘ�۟��_�E�{���\�֗�G�S�i��ۨ�B��߀�I�G���f�@ȝ�F������D�]�M�A���т��W�����x�g�a��Ҋ�f�v���B�g�^��',
                'x�R�n���T�l�y�g�y�r���A�m�����Q�����劮�F���ɉA�R�v�E�L���y�����Z፜��_�`�S�x�i�m�[��ق���D�b�c��֎�I�P���j���[����O�aݡ�{�n�����]���f�򱍽���ɒ�G�@�a�s�b�F�����Z',
                'x�v�]����l�w�}끚��f��៿��z�Y����j�g�G�a�C�_�����E�����޴c�����O�Z�A���h�u�ϚY�]Ɋ�U�����|��Ϧ���ϫ��҂��ϣ�k��������Z�[�`���Yۭ����Ɋ֌�Ϣ����������L�b��Ϥ',
                'xϧ�N����lϩ�X�_�N��ݾ�T�R�ݐ������mϬ��ϡ���������q�w�Ə�Ϫ����Y���Ҙ~Ϩ���k���g�F���q���ү�ϥ�O�D�ؘ������O���Ή�a�O�ײq����G�H�l؉�G�v���T�}�@���^�^�d��',
                'x�x���@ӂ���P��ӄ�ϰ�Eϯ��Ϯ��ϱ���j�t��dҠ�v��΀�@��ϭ֐��I���e�w��u�@�N��ϴ����ϳϲ�}���|��S��㊑����ʙS���L���u�l�kے�t�^���{�h�[�cϷ��ϵ⾅��Oϸ�S�_�_�S',
                'x�@�����M�҉I�����i϶���������V�K���̷G���ʓ�B���_��̟�q�]���S�U�aϺ�B���i�����PϹ�r�yϻ����bϿ�Ԟ���ꃍ{���M�����̸����{ꘜ����ړ�Ͼ覹d�W�rϽ�Eʛ�[�Y��ݠ�',
                'xϼ�_���h�T�p�B���ňY�K�ė��B�LՒ���������]�Ɂ����Ȋh�ˁُ�믖}��i�x�̫�ݲ��������ǃM�m�J�����턑��v���D��r�M۟���`�s�]�o�N�v�]�w�������Њ������̒����j浊ދM�L',
                'x���p�Ά���̀�e���ӮQ㕋������͝��t�t�Pݍ�_�B�Gˁ�y�U�D�v���������A���՚��������`�ڌ����{��͘�й�����޺���Ҕg���\�N�`�@������������`�ފ��ܱhꈆZ�����ҍs����',
                'x�{�ݬF�ڱ��m�����׻��كg�n�Q�^�Ⱦ��}����h�D�W�R�n�@�I�`�o���E��ܼ�����_�ᆓ�l�m��������x�U�G��|č��������֭����`��J�������Ԗ���|���K�큉���J�Õ}�����}�A�߇�',
                'xφ�������z����������e���������V��}�P�������ɂP��������n����|���̍���^����n�^�V���e�h���������p���`���E�R�����X�^���ߪ��N����ąʒ���{�n�}�r�S�]�y��',
                'x���t���v�n�Ƈ̙��u�j�D򔚮̇���U�����F�qС������q�~�ԺS�j��ТФ���D�k�j��ЧУ��ЦХ�唬��ԉ�C�V�[�[�^���ЩШЪЫϐ��Э��а�fв���G�e�����{�|�~�~��бг�n�e����',
                'x��Я�������n��ߢ�������qЬ�C�X�X�P�p�y�iא��д�挑ˆ�Ğ�йк�m���ж����l��м�Ȃď�е�c�c��r�ѓa�ͽuл�D�f���р���ԕ�텎O��и��⳼I�Zޯ�����C�x��a嬠yзϒ�^�k',
                'x�K�a������ߔ�|��о��꿖����^�r���dп��짏Q������нܰ���Q���g熁����c��ض�J����܌Ò���M�{�^�g���ˠ��ǈ��U���ɟ��w��͍�q�����d�_���w�H������������D�Q�͛��ꀊ���',
                'x�R��]�o��t�M��ߩ�����������n��㬛�D�m���B���փ���ܺכ���چM�r���r���KԞ����ל�w�锸�݂c�����Ӟ����Ã��^���ʘ������T�x���}��q�v�ཏ���N��ᶫ�����L���彑',
                'x�P�fΐ���C�V�n�M��B�L�������Ӓ��̐��נ�����T�H̓횗췠���P���q�u����[�Hʌ�d�_՚֞�z��`�P�T���[��銐ڼ���򫍂��S����Ԃ�������S�����T��r�U�����d䪈��A�~��',
                'x���ÄԔ����T������ĉ����������[��A��A���[���s���N�W�wㄷV�{�x˅�mޣ�����R�I���t܎�]�����H�l�ː������k���Ӭu�{�U�ضP���A�h��ʞ՝�X�M�C���Q�B�Tύ�X�~�z���t����',
                'x���I͕������诙e�v��ѡ�@���xѢ�_�R���]��ѤѣО��K���f�ֽk��C���R����X������K�T�HѥѦ�YѨ�āl�yѧ���NƋ�Џ�`���W�G�͠K�{�z��ѩ���}Ŗ�G���LѪ�ɐV�����N�������p',
                'x�o�y�_ѫ���[�׉_Ѭ��M����`񏇠���޹�֠`ĝ���Q�ˠo�c��ѰѲѮѱ�hѯ����䱼r���՗D�����Ō�ѭ�Mԃ�Z�����x���ߟ��@�R�W�y�S�\���_ѵѶ��ѴѸ���ߪFޙѷѳӍӖӜ�Q��',
                'x���d���b�eަ��R��',
                'y��ٌ�K�r�a�C�jȀ�u��g��������������Y���]����Ӕ�P���F�i�ߊ��ד~鑟��m�Nݑ�����M���r���X���������k���N틟�Є��ы�Y�����~�l�]�b���Ğ�e���o�\�s�A�R�h؋x�]�~���',
                'y�@󖘷؂���V�`�^���Q���D�r��T���Ǉy����萛S�{���p��W�v�_�U�d�m���_�J����΃�l�Lʁ�ƍ��J䄒��S���F�I�K�j�P�A�����uጆd�f�h�q�p�V�S�B�}�@�U������ڌ�f㎗H�c�U����',
                'y��͑��L���ɠ�ސ�q�����^�������V�^�S�y�_�e���X�dݘݜ��ğ�@�A���T���N�ӟy���O�]���P�l���W�m���j���U�M�w�w�GԔ�l�H�����X���DÑфх�P���v�r�C�j�e��Ѿѹѽ��Ѻѻ��Ѽ�S',
                'y蛗��f�E�����s������ѿ���������ۍ����Īc�����ÝQ�\�|���Ɔs�����ů{ʋ���L�Ƿ�ҁ�ȁ������e��櫒��o번��I��Ӡ���m�y�B���E���������̫��ق���������������B��',
                'y۳�̝v�����Z鎋�c���E�iڥ����������ܾ��Ӆ�ҕV�����I���ԪP���r���άJ�x�P�Z�֍����۽��щc�C��ԝ�N�B��̚鐅��������i�������̌E�r�s�v��h�}�����Z�W�m����ٲ���]�m',
                'y�����������T۱�D���ݑ��R���{�����V�C�㳚��s��ъ���i�ʇ{�y�t���d���[�o���f�d�����j�k��B�t���|���z�s��z�_������������������ҍ�邩��g��Ꚇ��ߔ����ͪ_��Ȋ������H',
                'y�����������������e�����V���e�������V�Y�����Fٞ܂�w�z�z�`���IӃׅ������G����F��ח�V�W����󊚒t�����o�j�����Z����}�������g���D�������������r�����[���f�ȫ���',
                'yꖍ����P�Ք�����@���U݌����^�{�u�R�F�n���ֈt�I�����������D��D�I�����y�B�Ĕa�Y�W�S������k�h��������زߺ�����n�@���@�����^��سҢ���Ȉ�Ҧ�i���x����Ҥ���e',
                'y��ҥ�U�ڋ����uҡ�r�bң�����l������uA�C�ٴt�G�H�P���{�|���_�i������a��q�Ú|���wҧ�̱l���Ҩ���Q�ʜȘe����[�o�r��ҩҪЉ���Oș�o��ҝ쉪����a�G�נdŗˎ����ҫ',
                'y�f�_׊耂�Ҭ��ҭ���JүҮ���������X�y�U�IҲ����ұ��Ұ�S�c��ҵҶҷҳ��ҹ�w��������ʖ���ҴҺ�ˈ욇Ҹ�~�v���G�I�@�p�ϕКS��@���w���̎I�J���]�Y���L��|�E�K�{�B�d�v�w',
                'y�v�B�EČ��һ�o�v������ҽ�������t�ޛ�⢮��cҿҼҾ��~�B�����F㞋���߭C�p�������t���b�s�p�U�ǅF���ăތb��ڱ�������n���t�������̍[���q���A����ޖ�h�����ؖ�����Б����',
                'y���U�f���r͆�r�O�ŕ����B�D�����Ƀx���z�K����Β�U�V���ںm�{�k�͏�֖�F�J�~ׂ�@�������~�Ɓ̔������q��������Б���ޠ�Í������r�i�C��}��Ε�}�EŜρ��T�t�V����߮����',
                'y������E���d����������N������߽�`���֕��p�k�i����٫���Ố@���ז��u��������X�Ȏ����Ė����p�����z��j����ږ���ś���К��ؗꋄֈ������������p����^�T�U�[�\���N�c',
                'y�������������|͂�mژ�z�`�{������~�m�v���x�����`Ԅ�㋝�M�]�����jɚ����k�|�̘����ڟ֟鯎�x���k�o�]��I���΋ڎF��������۠D���e�j�OŒ޲Μ�A�����ٙj�c�J�W������؊�l',
                'y�˄ˇٓ����X�[�s�J�G���������[�g�h�y�{�����O�^�gܲ�~�A��̈��ה�~�]�����f����������������S�����ꎃ����P�����ܧ�A�ֹN�s�P�޵��M�a�@��㟴�����N�񗇑�@���',
                'y�������g�󛎇�|���������Zӗ���H���������C���w�����H۴��_ӝ�z�y���w���K�����r���]�l��������������^�Y�i��L�@�y�a��[�\���P�a�Ӱa׍ӡ�ᛝط�����Z�J�S�\�E����',
                'y�g����Ӧ��Ӣ���@��ݺ��Ӥ�k�ᜀ���P�������Q�A������O�xӧ��s�aӣ謇|��њ����Ћ둪��팮Z�vӥ�D���[�t�����c�ѭ��_�s�L�]�t�N��܅���K�W��ӭ��ӯ��ӫӨөӪ���w�Ӝ���',
                'y�t�O�L��������Ӭ��΄���I�MΞ�����L�p�L�hӮ�c�l�w孞u��ω�՞��Y���A�k�A۫�w��Iӱ��Ӱ�}�f�e�g�_獰`ӳ��Ӳ���{왞]�GӴࡆ�ӶӵӸ��ӹ����{Ӻܭ��㼝K�������Փ��',
                'y�a��ӷ�M�t�O���b�����I�x�b��J������ӽ�[Ӿٸ�ʖԈ��~��ӿ���搾�Ӝ���ԁ�M�ӏ���Ӽ��ӻ�H���x�����o�l�k�������ϐQ�|�����~�H�n�������ɞX���l�i�����ɛY���ʐJ���U�M',
                'y�������r���xݯ�xݵޜ�]�˂����I�K�Ϊq�[�ϘA�����j�f�~����ݒ�O��߈���ЁJ���h���h���gݬ�X�uÅ���K��͜�B��뻠�����������٧�M���n�N��嶍f���v��ޔ�e�`�ʁ��z���R�T��',
                'y�G�����}���|�u�G���ٱE�����z�ځ���ߎ����楒T�f죫]�_������s�����خ����Ɯ�S�ʊ��������C�������D������~����������K�������������^�ޘ@�ܚQ���ń����O�I���ш',
                'y�u�|�v��՘�k�N�䑵���D�u�e�m�Lݛ哵H�~�k�����B�e�V�i�}�C������������Rٶ��������}�����P���ה��h�g�h螂����ї�r���c�Z���o�����Z؅�����P�r��Ԧ����R����������',
                'y�����rƑ�q����ԡ�_��Ԥ����֐������M�U�@���N�І������VԢ�����������~�Z��ԣ����S�������ϷC�N�f������A�����ع�z���s�C���h��T�o�j�Uəʠԥ�y�`�\�˟���ʚ�I�[�����',
                'y�������R�r�ְK�N�{�h���q�O���|�]�u�X��M������Z�N���O��܆�c�d���n�����uԩ������ԧ�w�a�eԨ�m���Y�A���d͛�g���S�Q�r��x���t������Ԫ�OߖԱ԰��zԫ�ؒԭ�TԲ���WԬ',
                'y���J��Ԯ���jԵ����@�Aܫ����Դ��Գ�x�V�g�rԯ���F�m�z�����~�Q��w�@�x慙�߇�{���M��Զ�\�R�h���O��ԷԹԺ���c������襵�Ը�jцѓ���Ի��Լ�s���E������뾌�`�j�����h',
                'y�xԿ�����Q�R܋���Ē�ڔԾ��Խ�_���X�釋��кM�[�߻C��g�g�~�^�S�a�N�l���V�C���Q���[΂�S�f�Nٚ�Ƅ��ȁ��ԇ�u�l�V�ܿ���s�d�n�Ǜ鼋���m�y념�뵜ݹo�l����|�]���J�a',
                'y�I���m�@�d��j���\�憽�q�E��ю�a�p�B�q�y���˖�۩����i�͂֐�����\�C���Z����ٿAʕ�̿Zʟل�d�j�a˜�r�y�N��@',
                'z���Ç�֍�M�i�Ԃȅ�����K���cۂƏ�]�قt�����L�M���{֚�nލ��\�f�b�w�~���q�����l�g�tތ�םr�~���u�x���o��ԗ�g���c�I�x���E�������m�������J�}�w�d�F��ڝ��ɐ���о��|����',
                'z���m�緉�e�阧���y���\�x�����Z���P��ې�n�G�����a�����h�����[�y�c�J�{�y��\�l���������Z�q��R��ƖØ��i���M�ߜ��G���C���������u�a�}��D�Z�e���I�R���Z�U�T�t�F�^ɛ',
                'z�e�I�BÏ�h���I���l�B�`�G�K�m�����W���o�V�R���`�t�P�Rǟ���X���ǌ��w�I�l�����d�����z�J���R�~��m�K�y�\˟����̌�B���~Ǡ�f�Ëq�S��瑉\�G�z�@��n���r�������t���`�i��',
                'z�H����l�X�C�u�[�E�v��W�M��V�y�A���a�C�\�S�]�c�|�ł����s���h���W�Z�՛��V♈S�����ћe���ٛj�������N���H�N������j���S�s���{���������Ԟ�Ǐ���ֲPن�������d���ڒD',
                'z�����P���f����������ۂ̆��Ìv�˃��܃�����ڎ�ݕ��m�������Uۊ����ٝ�Y��A�Ԟ��{���`�{ד𕠙�n���_��j�E�v�N���z�ʏn���Z���QĠ�K������ۛ�s���������闗�F��b�k����',
                'z�o��r����_�בV��Ł��r��Y�Yڋ��^������k�g��z�����ńt����������؟�ڲ��K�������j���tՋ�ӓ�ɰ��c�j�d���]։ّϏ�`�v�B�Ɖ��ٚ�꾕W���������\��ό�f�e�����P�U�ו�',
                'z���������ՙI��Q�D������֟�_��{���ٛ߸ށզ�s�������������髄��������u���A���O�����h��܈բ�lա�����l���Q�~�zգ�ē������z�W�~է��թ��L��ը�o�����p����ե�m��',
                'z�y��ի��ժ�z�Sլ��խ�Sծ�΂�կ�մձ칖�ճ�t��a�jղ�n�އ~�E�U߁땚֚�հ�r���d���@��}�g�Dז��ն�sչյո�جW���K���^շ�Q���\��ۅݚ���rռ��սջ�Cվ����Ǖ��տ��',
                'z�`���u��̛̜�O�Jպ��ŏ{���@۵���ÑP��⯻�ɟ�l������\��b��J�����Ǜ��Ɲq�Ǵ������̒E�������˻w��Û�o�ωz����~���βd���Ȋ������ўݱ@����D�q�S噠����Ӭ�����',
                'zگ�����D�����A�������t���ֹ|���D�w�נY�e�����^�؋��څz�ۚy�K�Y�q�E�܈���П����������������Ԁ��ߡ�m�����t�O���U��ֆ֕���H�y�xׄ���������N������J��������V�p������',
                'z��䫂ؑ������w������ᘂɔ��F�I�z��Ȝ�Z����E���絝�R����k默������U�G���������m�gݟ��P�E�y����r�튪���_�������pА�G�r�Z�]Ҙ�\�F������}�b�j�t�I�m�������E',
                'z�������ޖڼ�����`�L��͖���g�c������c���l�J���͊���������������A�k�ۈ�������b���to�@�ݏѱ����`�չ~���t�P�P�@�Y��c�l�����^���������֤ں֣֡��֢���^��Պ',
                'z�g�C֧֮ش֥֭֨���D֦֪֯֫������o�q�e���}Ё�u�U���~֬�b�d����]�w�A���u֩�\�T�}�����u�~�_ִֶ�pֱ����ֵ�p�����ְֲֳ�����ŭ��~���c���e�Z�ܘ�Ĉ�{�dەۗ܁�Uֹ',
                'zֻ�M��ּ�nַ�^���W�E�bֽ�ƒn��Ƈ��dָ�כ��U��]�W���Jֺ�T����ˌ�j�e���W־��X���ƅ�������������ۤ�f�Ŏ�蒔���Λ��w��͏�ֿ�y��O����З�����v���������a���̶�����',
                'z����И�dؠ��Ѝ�������������D�����ɹe���N�e�@��y�������F���uҞ�I㇎Ñp�����ܷW�����|���k��\�@�\��v�������S�`���a�H��ٗ���}�z�s�S�Y�T���W�v�e�U�Ё��O�d',
                'z�q��މ�қw���Ֆ����x�����ԽK�{���W��Π����R��۠犻b����ڣ�����V�p���[�~�N�����ڊt��rƠ�{���\�������g�W�\�A�����߁��ܛ��ޞ�מ�����b�X�B�Ŝ@�B�L�b�����Q�c�{�k�q�',
                'z񙇜�T�a�@�L�p����S������J�F���H���B���ƅ�����秃نB��q��ݧ��������Ȓ�k�L�u���t���U�����Q�N�E�세٪��ۥ�����������p�N���Z���D�H�����w����T�i��f���zˠ�����}',
                'z�^�E��{�Þ۸��A��������ɍ�Tώ���E���F�������W����e���d�C�侟����}���������هڲ�����ס�����^�ш|��ע�r��ގפ�����ǚ���ף��v���m�d�����A�q���������]�Aڟ',
                'z�O���h�L��[���������v�B�Z����Tץ�tĐ���צק�Jר����ש�������A�U�x�u�K�m��Hת�Nܞ�|�D�������E���Q׬׫׭�Ϳx�Nٍ�N���ʻMױׯ�y���P��׮�f����װ�b���P��׳��״',
                'z��՗[�`��ײ����׷��׵׶�F�K�x�d׹����׺㷮I�Į����i���Y׸�PՅ�^�Y�U��٘�V�V�dބ���׻Ձ�q׼�̓��ʾM�R��׿׾��پ׽�����×��k�B���q���X�V�����ƅ�������ǁQ䷟O����',
                'z�Ć��ߗz�Ŕٕ������ڳ����M���������}Վ�r��Wߪ����媙�֑���@�h��ϗ�C�S�|�m�ЌI��Ɔ���Ɋ���Ɲ��R�|���ʍ��Ͷ�����a�����ї���Ȍ��t�U�����D�Y���ŷT�l��C���w��',
                'z���Jڃݖ�O�����S�t�o�p�����U���b���Ӆ���梖j�I�f�c�������I�����B���������`�h�U�����TƓ�������ձ{���h�u�n���ڂ����W������تf��Ƞ�Q�ލٷO�C�h�پ��Cŋ�x�r�ٴ��q',
                'zۙ�R���i�A�i�R�`�Q���̒֐��ߓK�i���~���t�G�Q���C�E�ݕf�S�~�`���ռF���k�S�v�������Y���ǈ�����u�t�jՌ۸���O�P�|���[�������ዃ�����{�a�a����X��������B���nۀ�����',
                'z�����ޠ��~��M�{��֊�����j�g��F�����j�g�y��S߬���K�����`�x���쇒���r����S�E������f�Uީ��T�d��@�i�s���������׿���������V���V�gߤ�J�����}�g�ۗ��y���i�',
                'z�����������������F����������Њ���zɁd��');
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
  v_WB WB := WB('A��������������������������������������������������߰߯߮������������޿޾޽޼޻޺޹޸޷޶޵޴޳޲ޱްޯޮޭެޫުީިާަޥޤޣޢޡ������������������������������������������������������������������������������������������������������������������������������ݿݾݽݼݻݺݹݸݷݶݵݴݳݲݱݰݯݮݭݬݫݪݩݨݧݦݥݤݣݢݡ������������������������������������������������������������������������������������������������������������������������������ܾܼܻܹܸܷܴܿܽܺܶܵܳ۴۱������������������إ����֥������պ��������Է��ӫӪөӨӢ��������ҽҩҢ������ѿѻѦѥ��онаЬ������ϻ����������εήέ����̦������˹������ʽ����ɻɯɢ������������������ȵȧ�����������������������������ֿ������޾վϾ�������������ڽ���������Լ������������������Ǿ����������������Ƽƻƥ��źŹŸŷ������ĽļĻĺĹĳĪĢġ����������ïéçãâ������«��ƻĻ������ʺɺ�������������������������ʷҷ˷Ʒ������������ٵ��дĳ����ݲزԲ̲˲��ޱαͱ������аŰ�����',
'B��������������������������������۸����������������������������������������ؽة������׹ְ������Ժ������ҲҮ��ѷ������϶����������������������Ȣȡ���������׾۽׽���Ƹ����İ��½ª¤¡�꺯���¹�����������Ӷ����ϳ����ܳг±ݰ���',
'C��������������������������������������������������������������������������������ۢ��פ������ԦԥԤ��������������ѱ��Ϸ����̨ͨ˫ʻʥɧɣ����Ȱ���ݿ��Ծ������輦��ƭ����Ĳì������¿�����۶Ե��˵��۳Ҳ�β���',
'D�����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������۽ۺ������������������������������ש����������Ըԭ����������Ӳҳ������������ѹ��������������Ϯ����������������̼̬̫̩����˶ˬˣ����ʯʢ����ɰ����ȷȮ�������������ڿ������˿Ŀ��Ǿ¾������ۻһ�ǣ����������������������������������µ¢�������׺���ĺ���˹ʹŹ������з��ܷǷ��������������Ŵ����������ɳ�����޲��ñ������������ٰҰ�',
'E���������������������������������������������������������������������������������������������������������������������������������������������������������������ۮؾ��������֬֫����������ӷӯ����ҸҨң����������в����ϥ��������������̥˴˦��ʤ����������������Ž�������ǻ��Ƣ����������ŧ������Ĥ��ò���ѹɸ�ظθ����������ηʷ��ǵ��೦�ʲɲ��������򰹰���',
'F�������������������������������������������������������������������������������������������������ܱܲܰܯܮܭܬܫܪܩܨܧܦܥܤܣܢܡ������������������������������������������������������������������������������۹����������أء��ר��־ֱַ֧��������������������ԽԶԬԫԪ����Ҽ������ѩ������ЭТ������ϼϲ��������δΥΤ������������̹̳̮��������˪ʿʾʮ������ɥ����ȴȥȤ������������������ӿǿ������������Ⱦ������ٽؽ̼μ��������ǽǬ������ƺ������������ù����¶���ػ����պº����������Ĺ����ϸɸ����ط�����նѶ¶����ߵص̴��紣���ǳó������Ųò��������԰Ӱ�',
'G��������������������������������������������������������������������������������������������������������������������������������������������������������������۳۪ۣۤ��������جثتبائؤ��׸������ֳ����������յ��������������������һ��������ѳ����������������������������������������������ʴɺɪ����������������������������������������߼ռм�������ƽ����Ū��ĩ��õ�����������һ������������������񷩶�ٶ������嵽�������̲ܲвϲ�������̱Ʊ°�߰���',
'H����������������������������������������������������������������������������������������������������ح����׿��ֹ����սռհգ����ѣ��ЩϹ͹ͫ��˲˯����ȣ���Ͽ��߾ɾ���������ƵƤ��Ű��Ŀ����������²±­¬�仢�ö�������ɴ˴Ƴ�ݲ�Ͳǲ�����',
'I�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������ػ��������ע������֭������������տմ������ԴԨԡ������������ӿӾ������Һҫ����������Ѵѧ����кйФС����������ϴϫϪ��������μΫ��������Ϳ͡����������������������̶̲̭��ˮ����ʪʡ������������������ɳɬ��������Ⱦȸ���������������������������������ʿ����ھپƽ���ཽ����������ü�����������ǳǱǢ������������������Ư������������ŽŨŢ��������Įĭ����û������������º©�������ӻ������������ԺӺƺ��������������۸ȸ����ڷз������ɶ����ӵε������㴾���سγ���������������ײ�����������',
'J�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������خ��������֩��������Ի����ӼӳӰӬ����ҷҰ������ЫЪ������ϾϺ��������������������˧����������ʱʦ��������ɹ���������������������ž����������޻׻λ���ů����������ð�������ٺ��纵������Ƹ�������絩��׳���������������',
'K������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������߿߾߽߼߻ߺ߹߸߷߶ߵߴ߲߳۫������������������ֺֻ֨զ����������ԾԱ����ӽӻӴ������Ҷҭҧ������ѽѫ��������Х��������������������ιζΨ������������������̤̣̾��������˻˳˱����ʷ����ɶɤ������������޿ڿԿпȿ���������׽н���Ǻǲ��Ʒơ��������ſžŻŶ������������������·����������������ߺٺȺǺź��������й����¸����Էͷȶ���߶׶ֶ�������ŵ����ڴ�����������Գѳʳ�������Ȳ���ɱİϰɰȰ�����',
'L��������������������������������������������������������������������������������������������������������������������ת��������շն����Բ԰ԯ��Ѽ��ϽθηΧ��ͼ����˼��������Ȧ����������������Ͻμݼܼ׼Ӽ�����ǵǭ����������Ĭī���������Ժ�ںع�����̸��������ڳ복�߰��',
'M��������������������������������������������������������������������������������������������������������������������������������������������������������������������׬��������֡����ո����������������Ӥ����������ϿΡ��ͮͬ����̿����������ɾɽ��Ƚ����������������߻ϻ���Ƕ����������ñ¸�뺡�ǹ��ڸոԸ������巷��������ĵ��ϵ��޴ʹ����Ʊ�����ܰ�����',
'N���������������������������������������������������������������������������������������������������������������������������������������������������������ؿ����չ����������������������Ѹ����������миϰϬϧ����οξβΩ��������������˾ˢ����������ʺʭʬ���������������쿶�����־Ӿ�����ɼ¼��ڻֻл�����ǡ��Ʃƨ����ų����������üæ��������¾�Ż���޺������߹ָҸķ߷ɷ��趲������Ե������������߳ٳ���ҲѲ��ܱ۱ڱٱذ�',
'O����������������������������������������������������������������������������������������������������۰����������ճը��������ҵ������ϩϨ������˸����ɿ��ȼȲ���������������ÿ������澼��������������Ŵ����ú¯¦�����溸����۷��ϵƴ�ִ����㳴�ڲӱ�����',
'P�����������������������������������������������������������������������������������������������������������������������������������������������۩ڤڣڢ��������ף����֮կխլ����ԩԣԢ������ҾҤ��Ѩ����д����������������ͻ̻������������ʵ������������������ȹ�����������ο����߿ܿտ;�������ѼҼżĻ�������������ũ��į����������»���º�׺ֺ������ڹٹӹѹ����������ܴ�������Ĳ첹������������',
'Q�����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������߱��۾ۼۻۭۨۧۡ����������������صسآ����׶��������������������ղա��ԿԹԳԧ��������ӭӡ������ҿѮ��������пз��������������ϳϦϣ��������Σ������ͭ����̡��������ʨ��ɷɲɱɫ������Ȼ����������������������������Ѿľþ��������Ƚǽƽ½����ؼ���������ǷǯǮǦǥ����ť������������������������þóîíêè��������³�������Ի�������ݹ����ݹ�����������ָƸ����淹��������������۶Ͷƶ�����������ҵ���Ҵ��������������²���������������',
'R��������������������������������������������������߭߬߫ߪߩߨߧߦߥߤߣߢߡ������������������������������������������������������������������������������������������ۯۥش��׾׽ײ׫קצץ����������ִָֿ����������������ժ����������Ԯӵ����Ҵҡ��������Ѻ��жЯЮ������������������������Ͷͱͦ��������̧̢̯̽��������˺˩ˤ��������������ʰʧ������ɨɦ������������ȱȪ����������������������������������ۿٿؿ���������������ݾܾо�����ݽӽҽ���𼼼��ӻ�����Ǥ����������ƹƴƲ������������������ŲŤţš����������������ĴĨ������������°§£�໻���󺴺�����޹չҹϹ����޸׸��������շ�����޶ݶܶ��������ֵĵ����������������ݴ��������ֳų��������������ٲ����������������챰���������ݰڰװѰΰǰư���������',
'S���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������۲����������׵׮����ֲ֦��������ջեդ��������ӣ��ҬҪ������������еШУ������ϭ������Φ����Ͱͪͩ����̴̪����������˨��������������ɼɭȶȩȨ�������������������ݿɿÿ¿����ܽ۽ͽ�����ּϼ�������ǹ������ƱưƮ����������ľģ��������ø÷ö´¥�����ֻ�����˺��������׹���������̸ܸ˸Ÿ���ٷӷ��Ŷ���������״�����������ȳ���۲ı���걾���������',
'T�����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������۶۬������غعطضزرد������׭����������������֪��ձէ��������������������������ѭѬѪѡ��������Ц������������ϵϤϢϡ������������κί΢����ͽͺ͸Ͳͧ͢����������̺��������˽˰������ʸʣ������������������ɸ�����������������������ƿ��ؾ̾���ֽսý������ڼ�����������ջ���ǩǨǧ����Ƭƪ��������������ĵ������ÿôë������¨��������ܺͺ̺��ܹԹι��������ݸѸ͸����귱������������̶������ڵѵеȵõµ�����۴شѴǴ�����������ӳͳ̳˳Ƴ����߲ղ��������ұ˱ʱǱ��������ްʰ°�',
'U�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������۷۵��ڡ����������������������������������׼״׳ױװ��֣֢��������վբ������Ӹ����������ұ������������������ѾѢ������Ч������������ͷʹͯ������̵̱������˷����������������ȳȯȭȬ�������������������������������Ҿξ�����������߽������������������������伽��ǼǸǰ������ƿƳƦƣ������ű�����������������������ݻ����ۺҹ�ظ�����ӸǷ�跧�Ҷ˶��������ݵܵ۵����������մδɴȴô�����ղ�����������������ױֱձԱű������̰�',
'V�����������������������������������������������������������������������������������������������������������������������������ۿظ��������������Ҧ��ѲѰ����������ϱ��������������ˡ��ʼ������ɩ��������Ⱥ���ѿҿѿ�����˾ʾŽ�˽�����޼˼ȼ��������ŮŭŬū������������ķ��������ý��¼��ùø�����ʵյ�������',
'W�������������������������������������������ۦ������������������������������������������������������������������ٿپٽټٻٺٹٸٷٶٵٴٳٲٱٰٯٮ٭٬٫٪٩٨٧٦٥٤٣٢١��������������������������������������������������������׷ס����ֵֶ����ծ������������������Ӷ����������ү������������б��������������λαΰ;͵ͣ����̰������������������������ʹʳʲ������ɵɮɡ����������ȫ���������������������п��뿡���������Ľ�����������ۼټѼ��������������Ǫ����ƾƶƫƧ����ż�������������������������������ڻ������кϺκ�����ȹ��������븸������������������޷ݷַ·���ζ�����͵ʵǵ������������ߴٴԴӴ�������޳�������ֲ����㱶���������۰ְ˰���',
'X�������������������������������������������������������������������������������������������������������������������������������ذ������׺����ּֽ֯����ԼԵ����ӱӧ����������Ѥ��������������ϸ����γάͳ������˿��������ɴ�������������¾��������Խʽɽ���ͼ̼�������ǿŦ��ĸ�������������ƻû������ṭ���ٸ�����׷ѷĶе޵��´���ڲ���ѱбϱȱ����',
'Y����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������ڿھڽڼڻںڹڸڷڶڵڴڳڲڱڰگڮڭڬګڪکڨڧڦڥ��������������������ؼ��������׻ׯ������������֤��������իթ��������ӺӹӮӦӥ����������������ҹҥ������Ѷѵѯ����������лг������ϯ��������νΪ����������ͥͤ����̸̷������˵˭˥����������ʶʫʩ������ȿ������������������������������ο̿������;����뽲��ǼƼ�����������Ǵǫ������������������ŵĶıħĦĥ����������åäá����������������¹®���߻�����������������͸���߸ø�������Ϸ̷ŷ÷�����ضȶ���������׵��ʴ���ϲ����������Ӱ�����');
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
create or replace function emr.split_string(pi_str in varchar2, pi_separator in varchar2) --��������
return char_table
 is
  v_char_table char_table;
  --create type char_table is table of varchar2(4000);--�����Զ������ͽű�
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
  v_Stdstr  Varchar2(50) := '�Ų���귢������-��������Ŷž��Ȼ������-����ѹ��';
  v_Chara   Varchar2(2000) := '߹��H�����X�����t�H�c���\���������ٌ���r�P�o�a�������Y��O��c�g��������@���@���t؁�B���l���E�J�������֒�������q�������O���֓��������';
  v_Charb   Varchar2(2000) := '�����^���������R�T�������Zڕ���E��������ٔ�v�C�n���������k����[��k�ߙ�D���r�^����������_�����R�dم�d����E�s�U�t���l�mؐ����f�K�����R݅�^�������G�S��Q����ݙ�a����J�M��G�a�P���q�S�sݩذ����������؄םߛ���������������[�]����C�P�����G�s�����޵�I�ۋ�@��������@�S�{�K�L�x�F�E�z�������߄�Q��߅�b�c���H���u��������������r�g�Y�l�m�p�q׃�������R���������[րٙ�S���j�k�l�n�s�Օ�l���B�M������ߓ�������h�e�f�����E�\����������W������v����u���V���@�m�h����\�G�@�Q���R������K�����c�D�N�m�n�P���}��������L��������c�J�K��߲�G�L�Q����b�Y�^����������������������������';
  v_Charc   Varchar2(2000) := '�����nؔ�P�{�����o���֍���]�I�ى�������[ܳ������������������\��x���ۂ���d������O٭�{���i������S�a�������������K׋������~����p֝�P�U׀�����]����������_����K�����L�M��������L�l����������k�o�����n���}���C�{֚��܇�����ފ�J�����Հ�o�nލ����ܕ�\��R���mڒ���{ٕ���f��Y�Z��׏�p�����W�l��X�d�d�p�Kة���J�������\��������������v�|�A���c�J�[���d�P�W�m�gܯ���t�s���r�X��߳��ތ������L�M��o�چ���u���������ی���|ٱ����O�l���P�~ׇ׉�h�{�c��،�iۻ�a�n�I�z�r���R�X�����s��ء����X�s�U�zՑ������������������ݎ����A�i�E�J���������N�m�qݐ�j���ݻ�c�T����ك�w�����u�O��Q�}�z���p�q�w���e�����e����i��@�y�o�\�]ڝ�n��������W�����p�z�{ց����ݏ����������������K�u�q���y���A���ߥ���f������J��~�������xߗ�Z���u���i�������z�������H��S�e���������������������������������������������';
  v_Chard   Varchar2(2000) := '������pޅއ�����Q�_�Q�����]�J�N�^����߾�a�߰�����܍ܤܖ�J�D�\�l��ې�O�n�^���l�G�����F���^����Q��}ٜ�K���[�hו�������T�ځ�W��߶���������O�I�Z��܄����u�O��������Q�����������h�����~�L�C��ݶ���{�E��p�Mصڮۡ�s�������B���W�ޞ���K����f�d���r�B�y��ۆ���������c���������������J�M�������m����y�H��{��S���ܦ���g��Pՙ�����l��������w�����}������V�r���M�A�����[���C���HՉ�����ޓ��������h���K�^�K�Y�H�k�Z�W�L�L�^�`�a�^��`�A������i�L���x�K�G�~���o�b��tטـܶ�|��H�����Y�X������������B��m���H�����O�����ޚ�g�D�q�v��������y�I����r�o܀�D���w�y�F�G��z�����������������������������������';
  v_Chare   Varchar2(2000) := '��ވݭ�e��M�~�P��~�Z�[�F��E�i�����q������ܗ������`�Q�]�����{�O�Iج�@������t��׆�y�|�{�����E�z�[���X�b���W�������s�D߃ڍ٦�@�E����';
  v_Charf   Varchar2(2000) := '�e���y���z��N�c�x�Y�Cެ�������x���x�܏��؜�G����������ړ�[�p�h���������J���w����q�����E�y����������u���M������]���m�p����V���X�k�����r�M�M�R�v������a����L�����h�S��Qۺ�b�p�K���Sٺ�R�L�P�iو��]ߑ߻���K�������a�~�f�W���A�F����ܽ�������������ۮ��I��ݳ���������E�R�V�O�D�h��q�D�~ݗ�H�v���f��߼���M����o�f������ؓ������xݕ�Vَ�����v���������������';
  v_Charg   Varchar2(2000) := '�٤������m�����p�@�������B�d�W�^�Yؤ�}��|�����������N�v�����s��ߦ���h������M�l��G��s���غ�z�k���������޻�ھ۬��a������x�m�w�g���ت��ܪ����w����k���Yݑ�s�k�u�P�R���������t��ب��ݢ���f�s���Q������������p���������\�ؕ�C�����h�^���x����xڸ������g��ُ�������L�M�����Y��ݞ���X��ڬ����E�����������]����������d���A����N�o�T�W������ڴ���v�K���P���b݄�]�I�A����؞�k���q���X�}�������_��U���ߞ�F�|���q���h�k�I������{܉�������F���W�Z�iح�����݁���P��֏�������u�����������{�R�J�^���������������������������������';
  v_Charh   Varchar2(2000) := '���x�����V�����E�A���������w�n�J�_�\���F�\���I�d�h�u֛�n��[�ކ�ؘ�@������޶����q�����ڭ�����A������؀�F�����u�i���M�����H�H�[���Y���a�R���Q�L�e�f�S�g�\������a���C޿�U��ܟ�Fްݓ��Z����ݦ�A�v�b�D�p���fޮ�������Zڧ�{�U���\�J������A�\�C�����jܩ�_�����`�c�������ܠ����i֗��������������g��L�E�{���C�K����t�U��������������U��o���_��s�I�j�k�����n֜�f����Ֆՠ�X���b�J��؎גۨ����f�}���a���߀�o�D�I�q�S�X�G���kۼ�������ߧ���Z�d�����S���������B��W���ڇ��u�m�U���e�wڶ�������Y�D�x���������ޒ�D�t�e��������������_�V�dޥ�M�_�M�f�i�T��u�}�w�������Q�F�@ڻ��՟�����x߫ߘ�����X؛�A�f�o����޽�Z�[���������������������������������';
  v_Charj   Varchar2(2000) := 'آߴ����ܸ����������|���������K����}�u����Z�Y�ي���u�I����^��Q�Z�a�V�W�i�W�A�ؽ٥�B�L�C�������l�ު�e��n݋ۈ��U�g�P�W�n�e�|�}����������������������E�H���H������Ղ�����J۔�a�H�T�����D�V���C�q������������e���j؆����ۣ�P�����O��e�]�a���G���Z�����]�����g�y�������b���Z��K�������p�x�t���Y�[���~�d�����������������ֈ�C�r�x���{�v�|�����V����ڙ�f�`��Ր�v�{�`���G�I�T�G�Z�Y�a�b�{������������\�F�v������n���uܴ֘����������o���B�����ٮ������]�]�q����a�K�R��^��ڊ�I���_��A���������ڦڵ��ޗ����]��������m�d�R�O�^����]�����v�T������������\֔�ݣ���M������ف�B�����ݼ���X�L�~������������������i������ޟ�����e�V�K�n�o�R������ޛ�G�y������F���b�N��������J���n�����������ڠ���Շ�g�|�L�~�����`�]�R�z�v����V۞�q�G���A�������F���eڪ��ߚ�������B���e���X����Z��؋�M���L��g�m����N������������۲�h��C�������������bڑ�I���k�f�����ާ�_�`�����Q���H���B�����~�������؏�j�܊�x�z�������z�����}���K�Q�R�U�����������������������������������������������';
  v_Chark   Varchar2(2000) := '�������l��_��������]�����a���|�z�G�a���b�����٩ݨ�|ݝ��R����R�{�_�K��ߒ������`���������D���w������ڐ���V�����W�f�w�������������n��c�~�o��U�L��H�����w�x�I�y�����ߵ�@ޢ�d��ߠܥڜ���p���F٨���ۦ�����������d���wڲߝ���E�Hڿܒܜ�N�\�����������L�A�k�q���Y�k��N����k�ظ�������`��K���i���ۓ�������d�q�^������d���K���H�{�A��������S��A�p�H�T�U��������������������';
  v_Charl   Varchar2(2000) := '��������h�F�J�_�n�B������[�F��n�D���H�����l��ه�m�s�`�������@�E׎�_�|��e�����Y����Oݹ����H�q�Z����L������������������u�L�~���b߷��������E���������D�[�h�Y�m�Fڳ�C�|��P����L�[�G�K���ܨ�k����������؂�����ւ�r޼߆��x���\�P�v���g�~�Z�Gٵ�����N����������ߊ�k߿��������ٳ���\��۪����ݰ�����������W�E�_�t�`���B�b���V�]ׁ�^�Z�u�c���B����ۚ֋�`�`�H����������������b���n����cܮ��݈���u�gՏ�v�y�G�������|�Iْێ��m�������ޤ�R�������ޘ�������V�h�����Q���v�������O�����������O�l���[�������C�U�����C���\�k�`����������_�����ښ�C��q�s����C���o�w���h۹�N�g��`�����t�I�����������v���m�H���y���B�d�s�i���V���ۉ�C�w�f�j�w���������������X�N�����L�[�x�_�T���]�L������s֌�}���V�����U��ߣ������������������_�z�B�|�R�u�u���������u��������T�`��ڀ�j��X��h�j���ۍ�A�G�I�c�n�e��������y�L�����X�r�������F��[���s�x����i݆��MՓ���b�������߉������s���������������i��������������������������������������������������������';
  v_Charm   Varchar2(2000) := '�����j��i����U���K��ݤ�I��۽���u�~�@�A������M�N�����ܬ�������֙�N�����I����؈���ܚ�F���^����������T����Q�|�����ݮ�d���������Y�[�B�q��z�V�eڛ�m�i�������T�Y�{������ޫ�������������s�X��L�����i���Q���D�W�_������i�����������S���J����������ڢ������������k������������|�r���@�M�I�����]��������ؿ���p�f�x����������ق��s�F�����h��w�}������ڤ�p������Q�����և�������N����փք�O�O�������{����������a�����ٰ���w�\�����E��a�[������������f��J���������������������������';
  v_Charn   Varchar2(2000) := '�y����~�����vܘ�y�c���ܵޕ�����ؾ�r����a��Q�y�������T����߭�Qث��������D�t����m�[ګ�H��������G�����\����C�؃�r���F���u٣��b�W�Xދ�������R���D�T��݂ۜ�Tإ���|������B������������c�W�f�h�R����E���mב�b��D����_�V�H���������o�ٯ���r�s�x�P�a�e��k�����������S����Q�G�����S����Zہ�������������';
  v_Charo   Varchar2(2000) := '���Mک��k֎��t�{����';
  v_Charp   Varchar2(2000) := '����ٽ݇�����W���A��ۘ�o�Q���G��b�����Q�������������������N����B���k����r���������\�����J�o��ܡ�~�A���i�J�m�s�Cا������w�W�t��Y�����C�B�V�o����ۯ�����u����R���Q���dܱ��������|�aߨ���������G�����@�����X՗�����G՛�������g�h�w�Q����o������د���v�ؚ���l�A����ٷ�Z�Z���Z��݃�G����N�w�k۶�c�����O���H�H���������������T����ٟ�h����E���V�������������������������';
  v_Charq   Varchar2(2000) := 'ހ���V������Ճ�p�[����t�K������������ݽږܙ�H���������D���n�o���Rޭ�a�W�������u�}���G�y����ߌ�ܻ��M����H�M�����������ڞ�M�����ܷ�����@�T�`�e��U��e�Ս�w��t�v�c�k�B�R�S�aݡ����ܝ�j�@�Q�E�X�Z�b����������l�c����ٻ��݀���������ۄ��ۖ�j�I�j�����m�������b�z���������^�N����@ډ�E�F�A����������Sڈ�y�X���ڽ�~�V�m�I�N��������o��@����W�z�����s�d�������V���_�c��u�����i�W���X�p�����[�������Ո���m�����������^��jڂ���F�G�p�q���G����ٴޝ������U�������g�M�b�F�����j�A���ڰ�r���o�L�@څ�D�|�������O۾���@ޡ���z���޾����d��Y�xޑ�T������C��z��zڹ�������I�b��m�B�����e�j�E�����j������|��I�o����������������������������������������������';
  v_Charr   Varchar2(2000) := '�������`�X�j׌������N�v���m���������r��ך����ܐ���z�~�g��J��w��J�~���������F�g�P����݊����k���qߏ���n���޸���}��p�r�z��������M��ܛ݉ި������J��c�tټ�e�}���U�������������';
  v_Chars   Varchar2(2000) := '���ئ�����l�M�S���|�wِ��L�����D�d�����r��������b���fܣ�����C�Q�m֠�o�O�~��������|������������ߍ���������ܑ��^����������Wڨ���]���۷���b�i٠����W�X������օ�l���p�l����i�Y�}��ۿ�����f�d�h�������s��ڷ�����_�Y���h��ߕ������ן��Ք�T���}����v�j���J�H����|���W�j�����K��ًߟ�\�P���A���O�[����X���P���y�z����ݪ�Y�J�v���Z���R����������������߱���B�Y����m�K՜՞�}�S�u��|�a�����������x�ٿ��ܓ�g����S�\ݔ�_�e�����H���n���t�����_���Q�f�T������X���V���B�p���{�t�U�`�l���j��B�f�h�������������l�p���������j�t���F�����l�J�\�r���D�����������ٹ�~�L�|����ڡ����ݿ�����b��n���������g�}�`�����޴������������i�h�����x�p�_�M�qۑ�T���ݴ������m�U�S���r�w�����w�\���ݥ������{�Z������������t�����a�i����C�����������������������������������';
  v_Chart   Varchar2(2000) := '�������B�D�]�������e���`��w�J��F�O�Y�n�c��ۢ�������U�T޷�����؝�۰��Մ�]�U�t�T؍�v�Z�������g�a���y�����ۏ�M�|�U����o���G����}�Z���h�O�S�����E�����z�N�w��ޏ�����[���cػ��߯ؖ�������߂�`���L�R�e�f���Xڄ���pۇ������}�{�Y�[�����n܃������P�ڌ�L�j�V�p������D�c�l������q�`�t��٬�����p��������x�f���A����q�\���N�@�������F�����ߋ����������F�������F�P�b�c����١�����U�P���n�~������j���B�����^�W��W�Cݱ��T����I���h�����Qރܢ���r؇����o������P�j�k�n�s۝ۃ�����`��Z��ܔ�������رי��٢�u����ސ���������|���D�r���������K�z��ڗ�����������������';
  v_Charw   Varchar2(2000) := '��|��ߜ���c��������ؙܹ�Bߐݸ���������n�l�j��[�sٖ�~�@������s�y��ނ�����������ޱ���g�h�����������f�����`���W���d�S�T���������������Ն�c�l�Q��n�t�]�|���^�M�K�E�A�G���~�Z׈�^�d�nݘݜ���������������Y�j������Z�[�������l�f�O��޳�N��ݫ��b���������}����ڏ�E�w�G�_���u���N����c�M�����~���������������q�^�Rأ�@������A�����F�}����`����H�F�I�F������������';
  v_Charx   Varchar2(2000) := '����ۭ��������ݾ�T�R�������q���O�g�F���O��������a�G�H�l؉�v���T�@���^�^���@������E���v��֐��I���e�@�������|��������L�lے�^�h�ۧ�S�M�����i���V�K�_�]�S�U���B�i�P�y������������Y��ݠ��_���T�pՒ�]�����ݲ����������v�w��r۟�]�N�]����e��t�t�Pݍ�_�y�D�v������������`���U޺�����`�@�����^�}�D�R�G�o���Eܼ�_�l�m����x�����`����K�����}�A���a����z��}�P������������^���X�N���{�y���j�U���q�j�[�M����ߢ���C�P�Hא��������������ޯ�����x�C��^�k�K�a����ߔ�ݷ�d��\ܰ���g��cض܌���_�S�]���D������]�o��tߩ����Nܺכל������������T�x����q����P�V�n�M�����נ���q՚֞�z�`�Pڼ����������������[��rޣ܎������������՝�X�M�X�~�z����x����������C������X��K�j�Y��`���z���G���L���p�o���޹����������������S�\��ޙ���d�bަ��R�������������������������';
  v_Chary   Varchar2(2000) := 'ѹ����f�E���s���������\�����������������������۳���Z��iڥ����ܾ�I�Z��������}����ٲ����۱�D���V�C����y�d�o���f�d���j�k��B�|���z�s��������H�������e�V���e����ٞ܂�z�`�I�Jׅ����ח�V�W���Z����}���g���r������U݌����^�{�u�R�F�I�B�����زߺ�^س�������U���b��u��P���{�|�c���_�����������o�r��G���_׊������X�y�U����������v�����]�E�d�w�v�E�v����c�������p�t���b�s�p��ڱ������������ޖ�����O�B�D���z�U�V���{�k֖�Fׂ�@�~�������ޠ�r�i�C��}��T�t߮�����d��߽٫����������������ؗ����[�\�N�cژ�W�z������x���k�o�]����޲��؊�lٓ����s�J�G�������g�h�y�{�O�^�gܲ����ה�~�f��������ܧ���N���������w��۴��z�y�����]�l�������Y�i��L���y�[׍��ط�S�gݺ���A�����a��������v�D�s�L�]��܅���K�W����������������h��A۫�I�e�����G����{ܭ��V���a���t�O�����I�x��J���ٸ���x���k�����~������ݯݵޜ�]�K�[��������j��ݒ�O߈��ݬ���B���٧���ޔ�z�R�T�����}�|ߎ�����خ�������C�����D����~���������՘�k�N��uݛ��~���V�i�}�C��ٶ�������h��Z�o��؅���r����������C���N���������Aع�h��T�y�`�\���I�[��������r�q�O�u�X��M���N���O܆�c�d���g�S��x�t�����Oߖ���ؒ�J���ܫ�������w�@�x�߇���M�R�h���������܋��ڔ�_�X��������g�S�N���V�S�fٚ�ܿ���y���]�m�����q�E�B�q�y۩��i��\���ل�d�j�r�y��������������������������������������������������������';
  v_Charz   Varchar2(2000) := 'ش��������٪پ����ڣگں������������������ۤۥ۵۸����������ݧ����ީ����������ߡߤߪ߬߸���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������';

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
      If v_Bitchar >= '��' And v_Bitchar <= '��' Then
        For v_Chrnum In 1 .. Length(v_Stdstr) Loop
          If Substr(v_Stdstr, v_Chrnum, 1) = '-' Then
            Null;
          Elsif v_Bitchar < Substr(v_Stdstr, v_Chrnum, 1) Then
            v_Spell := v_Spell || Chr(64 + v_Chrnum);
            Exit;
          End If;
        End Loop;
        If v_Bitchar >= '��' Then
          v_Spell := v_Spell || 'Z';
        End If;
      Elsif Instr('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.+-*/', v_Bitchar) > 0 Then
        v_Spell := v_Spell || v_Bitchar;
      Elsif Instr('���������������', v_Bitchar) > 0 Then
        v_Spell := v_Spell || Chr(Ascii(v_Bitchar) - 41664);
      Elsif Instr('���£ãģţƣǣȣɣʣˣ̣ͣΣϣУѣңӣԣգ֣ףأ٣�',v_Bitchar) > 0 Then
        v_Spell := v_Spell || Chr(Ascii(v_Bitchar) - 41856);
      Elsif Instr('����', v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'A';
      Elsif Instr('����', v_Bitchar) > 0 Then
        v_Spell := v_Spell || 'B';
      Elsif Instr('����', v_Bitchar) > 0 Then
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

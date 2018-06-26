-----------------------------------------------------
-- Export file for user EMR@ORCL                   --
-- Created by Administrator on 2018/5/27, 13:46:34 --
-----------------------------------------------------

set define off
spool TYPE.log

prompt
prompt Creating type CHAR_TABLE
prompt ========================
prompt
CREATE OR REPLACE TYPE EMR."CHAR_TABLE"                                          is table of varchar2(4000)
/

prompt
prompt Creating type QUEST_SOO_ALERTTRACE_LINE_TYP
prompt ===========================================
prompt
CREATE OR REPLACE TYPE EMR."QUEST_SOO_ALERTTRACE_LINE_TYP"                                          IS OBJECT (linedate DATE, linetext VARCHAR2(4000), filestatus NUMBER )
/

prompt
prompt Creating type QUEST_SOO_ALERTTRACE_LOG_TYP
prompt ==========================================
prompt
CREATE OR REPLACE TYPE EMR."QUEST_SOO_ALERTTRACE_LOG_TYP"                                          IS TABLE OF quest_soo_alerttrace_line_typ
/


spool off

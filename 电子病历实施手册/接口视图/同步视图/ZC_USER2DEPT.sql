CREATE OR REPLACE VIEW ZC_USER2DEPT
(userid, deptid, wardid)
AS
(
SELECT
nvl(staff_dict.user_name,00) userid  /*职工代码*/,
staff_dict.dept_code /*科室代码*/,
'51201' /*病区代码*/
FROM staff_dict
);

CREATE OR REPLACE VIEW ZC_DEPT2WARD AS
(
SELECT distinct
dept_vs_ward.ward_code deptid /*科室代码*/,
dept_vs_ward.dept_code wardid /*病区代码*/,
0 totalbed /*床位数*/
FROM dept_vs_ward
);

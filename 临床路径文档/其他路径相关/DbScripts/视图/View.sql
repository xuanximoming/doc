/* ======================================================*/
/*   Table: V_Permission 权限管理视图                */
/*                    */
/* ============================================================ */
if exists (select * from sys.objects where name='V_Permission')
          drop view V_Permission
go
CREATE VIEW [dbo].[V_Permission]
AS
SELECT     
	 PE_UserRole.UserID, --用户编码CP_EmployeeZgdm
	 PE_Role.RoleCode, --角色编码
	 PE_Role.RoleName, --角色名称
	 PE_Fun.FunCodeFather, --父级角色代码
	 PE_FunFather.FunName AS FunFatherName, --父级角色名称
	 PE_FunFather.FunURL AS FunURLFather, --父级地址
	 PE_Fun.FunCode, --功能代码
	 PE_Fun.FunName, --功能名称
	 PE_Fun.FunURL--功能地址
FROM          PE_RoleFun 
	LEFT OUTER JOIN  PE_Fun ON  PE_RoleFun.FunCode =  PE_Fun.FunCode 
	RIGHT OUTER JOIN  PE_Role ON  PE_RoleFun.RoleCode =  PE_Role.RoleCode 
	RIGHT OUTER JOIN  PE_UserRole ON  PE_Role.RoleCode =  PE_UserRole.RoleCode 
	LEFT OUTER JOIN  PE_Fun AS PE_FunFather ON PE_FunFather.FunCode =  PE_Fun.FunCodeFather

go

/* ======================================================*/
/*   Table: V_QueryPathExecute 路径执行查询视图               */
/*                    */
/* ============================================================ */
if exists (select * from sys.objects where name='V_QueryPathExecute')
          drop view V_QueryPathExecute
go
CREATE VIEW [dbo].V_QueryPathExecute
AS
select 
	CP_InPatient.Syxh,--首页序号
	CP_InPatient.Brxb,--病人性质(即 医疗付款方式)(CP_DictionaryDetail.Mxdm, lbdm = '1')
	CP_DictionaryDetail.name as BrxbName,--性别
	CP_InPatient.Xsnl,--显示年龄(根据实际情况显示的年龄,如XXX年,XX月XX天,XX天)
	CP_InPatient.Ryzd,--入院诊断(CP_Diagnosis.zddm)
	CP_Diagnosis.name as RyzdName,--入院诊断名称
	CP_InPatient.Ryrq ,--入院日期
	CP_InPatient.hzxm,--患者姓名
	CP_InPathPatient.Jrsj,--进入路径时间
	case CP_InPathPatient.Ljzt
			when 1 then '执行中'
			when 2 then '退出'
			when 3 then '完成'
			else ''
	end as LjztName--路径状态名称(1进入,2.退出,3完成)
	,CP_InPathPatient.Ljzt--路径状态(1进入,2.退出,3完成)
	,CP_InPathPatient.wcsj--完成时间
	,CP_InPathPatient.tcsj--退出时间
	,CP_InPathPatient.Ljts--当前步骤天数
	,CP_ClinicalPath.ljdm--临床路径代码
	,CP_ClinicalPath.name as PathName--(路径)名称
	,CP_ClinicalPath.WorkFlowXML--工作流XML
	,CP_InPatientPathEnForce.EnFroceXml--路径执行记录XML
from CP_InPatient 
	left join CP_InPathPatient   on CP_InPathPatient.syxh=CP_InPatient.syxh--关联“纳入临床路径病人”表
	left join CP_DictionaryDetail on CP_DictionaryDetail.Mxdm=Brxb and CP_DictionaryDetail.lbdm = '3'--CP_DictionaryDetail.lbdm = '3'查询字典表的性别
	left join CP_Diagnosis on CP_Diagnosis.zddm=CP_InPatient.Ryzd--关联“医院诊断库”表
	left join CP_ClinicalPath on CP_ClinicalPath.ljdm=CP_InPathPatient.ljdm--关联“临床路径”表
	left join CP_InPatientPathEnForce on CP_InPatient.Syxh=CP_InPatientPathEnForce.Syxh----关联“临床路径执行记录”表




					  

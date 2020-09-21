/* ======================================================*/
/*   Table: V_Permission Ȩ�޹�����ͼ                */
/*                    */
/* ============================================================ */
if exists (select * from sys.objects where name='V_Permission')
          drop view V_Permission
go
CREATE VIEW [dbo].[V_Permission]
AS
SELECT     
	 PE_UserRole.UserID, --�û�����CP_EmployeeZgdm
	 PE_Role.RoleCode, --��ɫ����
	 PE_Role.RoleName, --��ɫ����
	 PE_Fun.FunCodeFather, --������ɫ����
	 PE_FunFather.FunName AS FunFatherName, --������ɫ����
	 PE_FunFather.FunURL AS FunURLFather, --������ַ
	 PE_Fun.FunCode, --���ܴ���
	 PE_Fun.FunName, --��������
	 PE_Fun.FunURL--���ܵ�ַ
FROM          PE_RoleFun 
	LEFT OUTER JOIN  PE_Fun ON  PE_RoleFun.FunCode =  PE_Fun.FunCode 
	RIGHT OUTER JOIN  PE_Role ON  PE_RoleFun.RoleCode =  PE_Role.RoleCode 
	RIGHT OUTER JOIN  PE_UserRole ON  PE_Role.RoleCode =  PE_UserRole.RoleCode 
	LEFT OUTER JOIN  PE_Fun AS PE_FunFather ON PE_FunFather.FunCode =  PE_Fun.FunCodeFather

go

/* ======================================================*/
/*   Table: V_QueryPathExecute ·��ִ�в�ѯ��ͼ               */
/*                    */
/* ============================================================ */
if exists (select * from sys.objects where name='V_QueryPathExecute')
          drop view V_QueryPathExecute
go
CREATE VIEW [dbo].V_QueryPathExecute
AS
select 
	CP_InPatient.Syxh,--��ҳ���
	CP_InPatient.Brxb,--��������(�� ҽ�Ƹ��ʽ)(CP_DictionaryDetail.Mxdm, lbdm = '1')
	CP_DictionaryDetail.name as BrxbName,--�Ա�
	CP_InPatient.Xsnl,--��ʾ����(����ʵ�������ʾ������,��XXX��,XX��XX��,XX��)
	CP_InPatient.Ryzd,--��Ժ���(CP_Diagnosis.zddm)
	CP_Diagnosis.name as RyzdName,--��Ժ�������
	CP_InPatient.Ryrq ,--��Ժ����
	CP_InPatient.hzxm,--��������
	CP_InPathPatient.Jrsj,--����·��ʱ��
	case CP_InPathPatient.Ljzt
			when 1 then 'ִ����'
			when 2 then '�˳�'
			when 3 then '���'
			else ''
	end as LjztName--·��״̬����(1����,2.�˳�,3���)
	,CP_InPathPatient.Ljzt--·��״̬(1����,2.�˳�,3���)
	,CP_InPathPatient.wcsj--���ʱ��
	,CP_InPathPatient.tcsj--�˳�ʱ��
	,CP_InPathPatient.Ljts--��ǰ��������
	,CP_ClinicalPath.ljdm--�ٴ�·������
	,CP_ClinicalPath.name as PathName--(·��)����
	,CP_ClinicalPath.WorkFlowXML--������XML
	,CP_InPatientPathEnForce.EnFroceXml--·��ִ�м�¼XML
from CP_InPatient 
	left join CP_InPathPatient   on CP_InPathPatient.syxh=CP_InPatient.syxh--�����������ٴ�·�����ˡ���
	left join CP_DictionaryDetail on CP_DictionaryDetail.Mxdm=Brxb and CP_DictionaryDetail.lbdm = '3'--CP_DictionaryDetail.lbdm = '3'��ѯ�ֵ����Ա�
	left join CP_Diagnosis on CP_Diagnosis.zddm=CP_InPatient.Ryzd--������ҽԺ��Ͽ⡱��
	left join CP_ClinicalPath on CP_ClinicalPath.ljdm=CP_InPathPatient.ljdm--�������ٴ�·������
	left join CP_InPatientPathEnForce on CP_InPatient.Syxh=CP_InPatientPathEnForce.Syxh----�������ٴ�·��ִ�м�¼����




					  

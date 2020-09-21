/* ============================================================ */
/*   Table: V_QCRecord	����ʱ����Ϣ                         */
/* ============================================================ */
if exists (select * from sys.objects where name='V_QCRecord')
          drop view V_QCRecord
go
CREATE VIEW [dbo].[V_QCRecord]
AS
SELECT     
	QCRecord.ID, --���
	QCRecord.Result, --���״̬(�Ƿ����)(CategoryDetail.ID CategoryID = 0)
	ResultStateTable.Name, --CategoryDetail.Name
	QCRecord.FoulState, --Υ��״̬(�Ƿ�Υ��,CategoryDetail.ID CategoryID = 0)
	FoulStateTable.Name AS Expr1, --CategoryDetail.Name
	QCRecord.Reminder, --��ʾ��Ϣ
	QCRecord.FoulMessage, --Υ����Ϣ
	QCRecord.ConditionTime, --����ʱ��(����������ʱ��)
	CASE FoulState WHEN 1 THEN FoulMessage ELSE Reminder END AS MessageInfo, --
	InPatient.Name AS InPatientName, --��������
	InPatient.Resident--סԺҽʦ����(Users.ID)
FROM          QCRecord 
	INNER JOIN  CategoryDetail AS ResultStateTable ON ResultStateTable.ID =  QCRecord.Result AND ResultStateTable.CategoryID = 0 
	INNER JOIN  CategoryDetail AS FoulStateTable ON FoulStateTable.ID =  QCRecord.FoulState AND FoulStateTable.CategoryID = 0 
	INNER JOIN  InPatient ON  InPatient.NoOfInpat =  QCRecord.NoOfInpat
WHERE     ( QCRecord.Result = 0) AND (CONVERT(varchar(100),  QCRecord.ConditionTime, 120) >= GETDATE())

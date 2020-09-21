/* ============================================================ */
/*   Table: V_QCRecord	病历时限信息                         */
/* ============================================================ */
if exists (select * from sys.objects where name='V_QCRecord')
          drop view V_QCRecord
go
CREATE VIEW [dbo].[V_QCRecord]
AS
SELECT     
	QCRecord.ID, --序号
	QCRecord.Result, --结果状态(是否完成)(CategoryDetail.ID CategoryID = 0)
	ResultStateTable.Name, --CategoryDetail.Name
	QCRecord.FoulState, --违规状态(是否违规,CategoryDetail.ID CategoryID = 0)
	FoulStateTable.Name AS Expr1, --CategoryDetail.Name
	QCRecord.Reminder, --提示信息
	QCRecord.FoulMessage, --违规信息
	QCRecord.ConditionTime, --条件时间(条件成立的时间)
	CASE FoulState WHEN 1 THEN FoulMessage ELSE Reminder END AS MessageInfo, --
	InPatient.Name AS InPatientName, --患者姓名
	InPatient.Resident--住院医师代码(Users.ID)
FROM          QCRecord 
	INNER JOIN  CategoryDetail AS ResultStateTable ON ResultStateTable.ID =  QCRecord.Result AND ResultStateTable.CategoryID = 0 
	INNER JOIN  CategoryDetail AS FoulStateTable ON FoulStateTable.ID =  QCRecord.FoulState AND FoulStateTable.CategoryID = 0 
	INNER JOIN  InPatient ON  InPatient.NoOfInpat =  QCRecord.NoOfInpat
WHERE     ( QCRecord.Result = 0) AND (CONVERT(varchar(100),  QCRecord.ConditionTime, 120) >= GETDATE())

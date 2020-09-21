IF EXISTS ( SELECT  1
            FROM    sysobjects
            WHERE   name = 'usp_DrapDropAdviceSuitDetail' ) 
    DROP PROCEDURE usp_DrapDropAdviceSuitDetail
go
CREATE  PROCEDURE [usp_DrapDropAdviceSuitDetail] 
@ctyzxh NUMERIC(9, 0)  --(����)ҽ���ײ����(CP_AdviceSuit.Ctyzxh)
AS
 /**********                    
[�汾��] 1.0.0.0.0               
[����ʱ��]  2010-12-16             
[����]    hjh          
[��Ȩ]    YidanSoft          
[����] 
[����˵��]��ק��ѯҽ����ϸ�ײ�                     
[�������]            
[�������]                   
[�����������]              
             
             
[���õ�sp]                    
[����ʵ��]              
 exec usp_DrapDropAdviceSuitDetail 1
[�޸ļ�¼]            
    

**********/     
BEGIN   
    
    SET nocount ON 
    
	SELECT  adg.Ctmxxh ,	--������ϸ���
            adg.Ctyzxh ,	--(����)����ҽ�����(CP_AdviceSuit.Ctyzxh)
            adg.Yzbz ,	--ҽ����־(CP_DataCategory.Mxbh, Lbbh = 27)
            adg.Fzxh ,	--�������(ÿ��ĵ�һ��ҽ�������)
            adg.Fzbz ,	--�����־(CP_DataCategory.Mxbh, Lbbh = 35)
            adg.Cdxh ,	--�������(CP_PlaceOfDrug.Cdxh)
            cpd.Ypgg ,--ҩƷ���(CP_PlaceOfDrug.Ypgg)
            adg.Ggxh ,	--������(CP_FormatOfDrug.Ggxh)
            adg.Lcxh ,	--�ٴ����(CP_ClinicOfDrug.Lcxh)
            adg.Ypdm ,	--ҩƷ����(or�շ�С��Ŀ����or�ٴ���Ŀ����,���������ִ��������Ŀ������ж�)(CP_PlaceOfDrug.Ypdm/CP_ChargingMinItem.Sfxmdm/CP_LCChargingItem.Lcxmdm)
            adg.Ypmc ,	--ҩƷ(��Ŀ)����(CP_PlaceOfDrug.Name/CP_ChargingMinItem.Name)
            adg.Xmlb ,	--��Ŀ���(CP_DataCategory.Mxbh, Lbbh = 24)
            adg.Zxdw ,	--��С��λ(CP_PlaceOfDrug.Zxdw)
            adg.Ypjl ,	--ҩƷ����
            adg.Jldw ,	--������λ(��ʾ��)(CP_PlaceOfDrug.Ggdw/CP_PlaceOfDrug.Zydw)
            adg.Dwxs ,	--��λϵ��(���ϵ����סԺϵ��,ע����ϵ��Ҫ�����ķ���
            adg.Dwlb ,	--��λ���(CP_DataCategory.Mxbh, Lbbh = 30)
            adg.Yfdm ,	--(ҩƷ)�÷�����(CP_DrugUseage.Yfdm)
            du.Name AS YfdmName ,
            adg.Pcdm ,	--Ƶ�δ���(YY_YZPCK.Pcdm)
            af.Name AS PcdmName ,
            adg.Zxcs ,	--ִ�д���
            adg.Zxzq ,	--ִ������
            adg.Zxzqdw ,	--ִ�����ڵ�λ(CP_DataCategory.Mxbh, Lbbh = 34)
            adg.Zdm ,	--�ܴ���
            adg.Zxsj ,	--(Ƶ�ε�)ִ��ʱ��
            adg.Zxts ,	--ִ������(Ϊ��Ժ��ҩ����)
            adg.Ypzsl ,	--ҩƷ������(Ϊ��Ժ��ҩ����,ʹ�ü�����λ)
            adg.Ztnr ,	--��������
            adg.Yzlb ,	--ҽ�����(CP_DataCategory.Mxbh, Lbbh = 31)
            cd.[Name] AS YzbzName ,--ҽ����־����
            3200 Yzzt ,--ҽ��״̬(CP_DataCategory.Mxbh, Lbbh = 32)
            CASE adg.Fzbz
              WHEN 3501 THEN '��'--�鿪ʼ
              WHEN 3502 THEN '��'--���м�
              WHEN 3599 THEN '��' --�����
              ELSE ''
            END AS Flag ,--����                
            'CP_AdviceSuitDetail' FromTable ,--������GRID��ɫ�ж�
            adg.Yznr --ҽ������
    FROM    CP_AdviceSuitDetail adg
            LEFT JOIN CP_DataCategoryDetail cd ON cd.Mxbh = adg.Yzbz
            LEFT JOIN CP_AdviceFrequency af ON af.Pcdm = adg.Pcdm
            LEFT JOIN CP_DrugUseage du ON du.Yfdm = adg.Yfdm
            LEFT JOIN CP_PlaceOfDrug cpd ON adg.Cdxh = cpd.Cdxh
    WHERE   adg.Ctyzxh = @ctyzxh
    ORDER BY adg.Yzbz DESC ,
            adg.Fzxh ,
            adg.Fzbz
		
     
END 



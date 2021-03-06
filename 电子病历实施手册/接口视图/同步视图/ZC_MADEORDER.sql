CREATE OR REPLACE VIEW ZC_MADEORDER AS
(
SELECT
orders.VISIT_ID            inpatient_no    ,--住院流水号
pat_master_index.inp_no    patient_no      ,--住院病历号
orders.ORDERING_DEPT       deptid    ,--医嘱科室代码
''                         wardid,--医嘱护理站代码
orders.ORDER_NO            MO_ORDER,--医嘱流水号
orders.DOCTOR_USER         doc_code,--医嘱医师代号
orders.DOCTOR              DOC_NAME,--医嘱医师姓名
orders.ENTER_DATE_TIME     MO_DATE ,--医嘱日期
CASE  pat_visit.newborn    WHEN '1' THEN '1'
                           ELSE '2'
                           END  BABY_FLAG,--是否婴儿医嘱   1是/2否
orders.order_class         TYPE_NAME           ,--医嘱类别名称
CASE orders.BILLING_ATTR   WHEN 0 THEN '是'
                           WHEN 2 THEN '是'
                           ELSE '否'
                           END  CHARGE_STATE,--是否计费   1是/2否
orders_costs.ITEM_CODE     ITEM_CODE           ,--项目编码
orders_costs.ITEM_NAME     ITEM_NAME           ,--项目名称
orders_costs.ITEM_CLASS    CLASS_NAME          ,--项目类别名称
''                         EXEC_DPNM           ,--执行科室名称
''                         MIN_UNIT            ,--最小单位
orders_costs.UNITS         PRICE_UNIT          ,--计价单位
orders_costs.AMOUNT        PACK_QTY            ,--包装数量
orders_costs.ITEM_SPEC     SPECS               ,--规格
''                         DOSE_MODEL_CODE     ,--剂型代码
''                         DRUG_TYPE           ,--药品类别
''                         ITEM_PRICE          ,--零售价
''                         COMB_NO             ,--组合序号
''                         MAIN_DRUG           ,--主药标记
orders.ORDER_STATUS        MO_STAT             ,--医嘱状态
orders.ADMINISTRATION      USE_NAME            ,--用法名称
orders.FREQUENCY           DFQ_CEXP            ,--频次名称
orders.DOSAGE              DOSE_ONCE           ,--每次剂量
orders.DOSAGE_UNITS        DOSE_UNIT           ,--剂量单位
''                         USE_DAYS            ,--使用天数
orders_costs.TOTAL_AMOUNT  QTY_TOT             ,--项目总量
orders.START_DATE_TIME     DATE_BGN            ,--开始时间
orders.STOP_DATE_TIME      DATE_END            ,--结束时间
''                         REC_USERCD          ,--录入人员代码 前面有开医嘱医生名称
''                         REC_USERNM          ,--录入人员姓名
CASE orders.processing_nurse         WHEN '' THEN '未确认'
                                      ELSE '已确认'
                                      END  CONFIRM_FLAG        ,--确认标记1未确认/2已
orders.processing_date_time      CONFIRM_DATE        ,--确认时间 转抄
''                                CONFIRM_USERCD      ,--确认人员代码 转抄
''DC_FLAG             ,--Dc标记1未dc/2已dc
''DC_DATE             ,--Dc时间
''DC_CODE             ,--DC原因代码
''DC_NAME             ,--DC原因名称
''DC_DOCCD            ,--DC医师代码
''DC_DOCNM            ,--DC医师姓名
''DC_USERCD           ,--Dc人员代码
''DC_USERNM           ,--Dc人员名称
CASE orders.processing_nurse          WHEN '' THEN '未确认'
                                      ELSE '已确认'
                                      END  EXECUTE_FLAG        ,--执行标记1未执行/2已执行/3DC执行
orders.PERFORM_SCHEDULE           EXECUTE_DATE        ,--执行时间
''                                EXECUTE_USERCD      ,--执行人员代码
orders.FREQ_DETAIL                MO_NOTE1            ,--医嘱说明
''MO_NOTE2            ,--备注
orders.REPEAT_INDICATOR           MOGP_CODE           ,--长嘱组别代码
CASE orders.REPEAT_INDICATOR          WHEN  1 THEN '长期'
                                      ELSE '临时'
                                      END   MOGP_NAME  ,--长嘱组别名称
''GET_FLAG            ,--医嘱提取标记:1待提取/2已提取/3DC提取
''SUBTBL_FLAG        ,--是否附材'1'是
''SORT_ID             ,--排列序号，按排列序号由大到小顺序显示医嘱
''DC_CONFIRM_DATE     ,--DC审核时间
''DC_CONFIRM_OPER     ,--DC审核人
''DC_CONFIRM_FLAG     ,--DC审核标记，0未审核，1已审核
''VALID_USRN        ,
''PSJG                ,--皮试结果 1为阴性0为阳性
''PSBJ                 --皮试标记 1为需要0为不需要

FROM  ORDERS,ORDERS_COSTS,PAT_MASTER_INDEX,PAT_VISIT
WHERE ORDERS.PATIENT_ID=ORDERS_COSTS.PATIENT_ID(+)  AND
      ORDERS.VISIT_ID=ORDERS_COSTS.VISIT_ID(+)      AND
      ORDERS.ORDER_NO=ORDERS_COSTS.ORDER_NO(+)      AND
      ORDERS.ORDER_SUB_NO=ORDERS_COSTS.ORDER_SUB_NO(+)  AND
      PAT_MASTER_INDEX.PATIENT_ID=ORDERS.PATIENT_ID  AND
      PAT_VISIT.PATIENT_ID=ORDERS.PATIENT_ID        AND
      PAT_VISIT.VISIT_ID=ORDERS.VISIT_ID


)

-- End of DDL Script for View YCHIS.YD_MADEORDER;

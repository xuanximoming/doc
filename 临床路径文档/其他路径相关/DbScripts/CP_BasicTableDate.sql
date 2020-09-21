--BaseTable表必须插入此两条固定记录,性别有且只有男女两种
INSERT BaseTable(Bm,Mc,Lb,Sfqy) values(1,'男',1,1)
INSERT BaseTable(Bm,Mc,Lb,Sfqy) values(2,'女',1,1)

--CP_ExamSyrq 适用人群（CP_PathEnterJudgeCondition中使用）
INSERT BaseTable(Jlxh,MC,Yxjb,Xb,Qsnl,Jsnl) values(1,'人',50,0,150)
INSERT BaseTable(Jlxh,MC,Yxjb,Xb,Qsnl,Jsnl) values(2,'成人',49,18,150)
INSERT BaseTable(Jlxh,MC,Yxjb,Xb,Qsnl,Jsnl) values(3,'男人',48,0,150)
INSERT BaseTable(Jlxh,MC,Yxjb,Xb,Qsnl,Jsnl) values(4,'女人',48,0,150)
INSERT BaseTable(Jlxh,MC,Yxjb,Xb,Qsnl,Jsnl) values(5,'儿童',47,2,10)
INSERT BaseTable(Jlxh,MC,Yxjb,Xb,Qsnl,Jsnl) values(6,'婴儿',46,0,1)


CREATE OR REPLACE VIEW ZC_BEDS
(id, deptid, wardid, roomid, resident, attend, chief, sexinfo, style, inbed, patnoofhis, valid)
AS
(
SELECT
b.bed_label       /*床位代码*/,
b.dept_code /*科室代码*/,
b.ward_code /*病区代码*/,
nvl( b.room_no,1) room_no /*房间号*/,
'' resident /*住院医师代码*/,
'' attend   /*主治医师代码*/,
'' chief    /*主任医师代码*/,
case b.bed_sex_type         when '1' then '1100' /*男*/
                            when '2' then '1101' /*女*/
                            when '9' then '1102' /*混*/
end sexinfo,
case b.bed_approved_type      when '0' /*编制内*/   then '1200' /*在编*/
                              when '1' /*编制外*/   then '1201' /*非编*/
                              when '2' /*加床*/     then '1202' /*加床*/
                              when '3' /*童床*/     then '1203' /*童床*/
end style,
case b.bed_status             when '0' then '1300' --空床
                              when '1' then '1301' --占床
                              --when '9' then '1302' 未展开
                              else '1302'
end inbed,
c.patient_id||'_'||a.visit_id patnoofhis /*HIS 首页序号*/,
1  valid     /*有效记录*/
FROM  pats_in_hospital a,bed_rec b,pat_master_index c
where a.patient_id = c.patient_id and a.ward_code = b.ward_code and a.bed_no=b.bed_no

);

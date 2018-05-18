create or replace view zc_transfer as
select patient_id, visit_id, min(admission_date_time) adt_ward_datetime,max(discharge_date_time) dis_ward_datetime
  from transfer
 group by patient_id, visit_id;

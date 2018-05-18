-- Add/modify columns 处理模版子类是否显示
alter table EMR.DICT_CATALOG add isused VARCHAR2(1);
-- Add comments to the columns 
comment on column EMR.DICT_CATALOG.isused
  is '是否在模版列表显示';

-- Add/modify columns 添加用户是否有切换全院科室权限
alter table EMR.USERS add power VARCHAR2(1);
-- Add comments to the columns 
comment on column EMR.USERS.power
  is '用户是否有切换全院科室权限';
  
-- Create table
create table EMR.USER_DEPT
(
  userid VARCHAR2(6) not null,
  deptid VARCHAR2(12) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 8K
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column EMR.USER_DEPT.userid
  is '用户ID';
comment on column EMR.USER_DEPT.deptid
  is '科室ID';
-- Create/Recreate primary, unique and foreign key constraints 
alter table EMR.USER_DEPT
  add constraint PK_USER_DEPT primary key (USERID, DEPTID)
  using index 
  tablespace TSP_YDEMR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
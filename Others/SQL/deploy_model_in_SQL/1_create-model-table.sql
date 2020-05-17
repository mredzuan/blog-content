-- 03-create-model-table.sql

use sample_data;
go

drop table if exists soc_net_model;
go
create table soc_net_model (
   [id] varchar(30) not null default ('new model') primary key,
   [value] varbinary(max) not null
);
go
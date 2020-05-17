--Generate RF Model in SQL

use sample_data;
go

insert into soc_net_model([value])
exec sp_generate_soc_net_model;

update  soc_net_model
set [id] = 'RandomForest'
where [id] = 'new model';

select * from soc_net_model;
go

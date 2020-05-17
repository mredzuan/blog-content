use sample_data
go

exec [dbo].[sp_predict_random_forest]
@inquery = N' select * 
			from soc_net_Test;'
			
go

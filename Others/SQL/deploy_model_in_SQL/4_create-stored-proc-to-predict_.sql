--Create Store Procedure to Predict New Data
use sample_data;
go

drop procedure if exists dbo.sp_predict_random_forest;
go

create procedure dbo.sp_predict_random_forest (@inquery nvarchar(max))
as
begin
	declare @df_RF_model varbinary(max) =
		(select [value] from soc_net_model 
		where [id] = 'RandomForest');

	execute sp_execute_external_script
	@language = N'R',
	@script = N'
	require("randomForest")
	RF_model <- unserialize(df_RF_model)
	
	#Predict test dataset
	predict_result <- predict(RF_model, InputDataSet[-4])
	OutputDataSet <- cbind(InputDataSet, predict_result)
	',


	--input to be called by store procedure 
	@input_data_1 = @inquery,


	@params = N'@df_RF_model varbinary(max)',

	--initialize value defined in declaration
	@df_RF_model = @df_RF_model

	--Result output
	with result sets ((
						"Gender" varchar(255),
						"Age" int,
						"EstimatedSalary" int,
						"Purchased" int,
						"predict_result" int));
end;
go

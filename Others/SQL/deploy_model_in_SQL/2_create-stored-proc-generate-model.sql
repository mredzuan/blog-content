-- Create Stored Procedure to Generate RF Model

use sample_data;
go

drop procedure if exists dbo.sp_generate_soc_net_model;
go

create procedure dbo.sp_generate_soc_net_model
as
begin
	execute sp_execute_external_script
	@language = N'R',
	@script = N'

	#set dependant and all character variables to factor
	InputDataSet$Gender <- as.factor(InputDataSet$Gender)
	InputDataSet$Purchased <- as.factor(InputDataSet$Purchased)

	require(randomForest)

	RF_model <- randomForest( x = InputDataSet[-4],
							  y = InputDataSet$Purchased)

	OutputDataSet <- data.frame(payload = as.raw(serialize(RF_model, connection=NULL)));',

	@input_data_1 = N'select *
					from soc_net_Train;'

	with result sets ((model varbinary(max)));
end;
















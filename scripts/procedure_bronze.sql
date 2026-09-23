===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.
---------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE Bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME , @end_time DATETIME ,@batch_start_time DATETIME ,@batch_end_time DATETIME;
	BEGIN TRY	

	SET @batch_start_time =GETDATE();
		PRINT '=================';
		PRINT 'LOADING BRONZE LAYER';
		PRINT '=================';

		PRINT '------------------';
		PRINT 'LOADING CRM TABLES';
		PRINT '------------------';
	
		
			SET @start_time = GETDATE();
				PRINT '<<TRUNCATING TABLE Bronze.crm_cust_info'
				TRUNCATE TABLE Bronze.crm_cust_info
				PRINT '<<INSERTING DATA INTO Bronze.crm_cust_info'
				BULK INSERT Bronze.crm_cust_info
				FROM 'C:\Users\Admin\Downloads\SQL Project\cust_info.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);
			SET @end_time = GETDATE();
			PRINT 'LOAD DURATION:' + CAST(DATEDIFF (SECOND ,@start_time , @end_time) as NVARCHAR);
			PRINT '-----------------------'


			SET @start_time = GETDATE();
				PRINT '<<TRUNCATING TABLE Bronze.crm_prd_info'
				TRUNCATE TABLE Bronze.crm_prd_info
				PRINT '<<INSERTING DATA INTO Bronze.crm_prd_info'
				BULK INSERT Bronze.crm_prd_info
				FROM 'C:\Users\Admin\Downloads\SQL Project\prd_info.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);
			SET @end_time = GETDATE();
			PRINT 'LOAD DURATION:' + CAST(DATEDIFF (SECOND ,@start_time , @end_time) as NVARCHAR);
			PRINT '-----------------------'

		
			SET @start_time = GETDATE();
				PRINT '<<TRUNCATING TABLE Bronze.crm_sales_details'
				TRUNCATE TABLE Bronze.crm_sales_details
				PRINT '<<INSERTING DATA INTO Bronze.crm_sales_details'
				BULK INSERT Bronze.crm_sales_details
				FROM 'C:\Users\Admin\Downloads\SQL Project\sales_details.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);
			SET @end_time = GETDATE();
			PRINT 'LOAD DURATION:' + CAST(DATEDIFF (SECOND ,@start_time , @end_time) as NVARCHAR);
			PRINT '-----------------------'


			PRINT '------------------';
			PRINT 'LOADING ERP TABLES';
			PRINT '------------------';


			SET @start_time = GETDATE();
				PRINT '<<TRUNCATING TABLE Bronze.erp_cust_az12'
				TRUNCATE TABLE Bronze.erp_cust_az12
				PRINT '<<INSERTING DATA INTO Bronze.erp_cust_az12'
				BULK INSERT Bronze.erp_cust_az12
				FROM 'C:\Users\Admin\Downloads\SQL Project\cust_az12.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);
			SET @end_time = GETDATE();
			PRINT 'LOAD DURATION:' + CAST(DATEDIFF (SECOND ,@start_time , @end_time) as NVARCHAR);
			PRINT '-----------------------'


			SET @start_time = GETDATE();
				PRINT '<<TRUNCATING TABLE Bronze.erp_loc_a101'
				TRUNCATE TABLE Bronze.erp_loc_a101
				PRINT '<<INSERTING DATA INTO Bronze.erp_loc_a101'
				BULK INSERT Bronze.erp_loc_a101
				FROM 'C:\Users\Admin\Downloads\SQL Project\loc_a101.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);
			SET @end_time = GETDATE();
			PRINT 'LOAD DURATION:' + CAST(DATEDIFF (SECOND ,@start_time , @end_time) as NVARCHAR);
			PRINT '-----------------------'


			SET @start_time = GETDATE();
				PRINT '<<TRUNCATING TABLE Bronze.erp_px_cat_g1v2'
				TRUNCATE TABLE Bronze.erp_px_cat_g1v2
				PRINT '<<INSERTING DATA INTO Bronze.erp_px_cat_g1v2'
				BULK INSERT Bronze.erp_px_cat_g1v2
				FROM 'C:\Users\Admin\Downloads\SQL Project\px_cat_g1v2.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);
			SET @end_time = GETDATE();
			PRINT 'LOAD DURATION:' + CAST(DATEDIFF (SECOND ,@start_time , @end_time) as NVARCHAR);
			PRINT '-----------------------'
		SET @batch_end_time = GETDATE();
			PRINT 'LOADING BRONZE LAYER IS COMPLETED'
			PRINT 'BRONZE LAYER LOAD DURATION:' + CAST(DATEDIFF (SECOND ,@start_time , @end_time) as NVARCHAR);
			PRINT '-----------------------'


	END TRY
		BEGIN CATCH 
		PRINT '=====================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR NUMBER' + CAST(ERROR_NUMBER() AS NVARCHAR );
		PRINT '=====================================';
		END CATCH
END

=====================================================
TO EXECUTE THE STORED PROCEDURE ,RUN THE BELOW LINE
=====================================================

EXECUTE Bronze.load_bronze


/*
Creating a fact table to store all six years of data
*/

create table fact_d365srs as
select * from "d365srs2020"
union all
select * from "d365srs2021"
union all
select * from "d365srs2022"
union all
select * from "d365srs2023"
union all
select * from "d365srs2024"
union all
select * from "d365srs2025"
;

/*
Creating a dimension table to store repeating Service Type values 
*/

create table dim_service_type
	(
	 service_type_id int generated always as identity primary key,
	 service_type text unique not null
	);

/*
Creating a dimension table to store repeating Department values
*/

create table dim_department
	(
	 department_id int generated always as identity primary key,
	 department text unique not null
	);

/*
Creating a dimension table to store repeating Status values
*/

create table dim_status
	(
	 status_id int generated always as identity primary key,
	 status text unique not null
	);

/*
Creating a dimension table to store repeating Status Reason values
*/

create table dim_status_reason
	(
	 status_reason_id int generated always as identity primary key,
	 status_reason text unique not null
	);

/*
Creating a dimension table to store Date values
*/

create table dim_date
	(
	 date_key int generated always as identity primary key,
	 full_date date unique not null,
	 year int,
	 quarter int,
	 month int,
	 month_name text,
	 day_of_week int,
	 day_name text,
	 week_of_year int
	);
	

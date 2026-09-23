/*
Inserting values into dim_status_reason dimension table
*/

insert into "dim_status_reason" ("status_reason")
select distinct "Status Reason"
from "stage_d365srs"
where "Status Reason" is not null
and trim("Status Reason") <> ''
on conflict ("status_reason") do nothing;

/*
Inserting values into dim_status dimension table 
*/

insert into "dim_status" ("status")
select distinct "Status"
from "stage_d365srs"
where "Status" is not null
and trim("Status") <> ''
on conflict ("status") do nothing;

/*
Inserting values into dim_service_type dimension table
*/

insert into "dim_service_type" ("service_type")
select distinct "Service Request Type"
from "stage_d365srs"
where "Service Request Type" is not null
and trim("Service Request Type") <> ''
on conflict ("service_type") do nothing;

/*
Inserting values into dim_department dimension table
*/

insert into "dim_department" ("department")
select distinct "Department (Service Request Type) (Service Request Type)"
from "stage_d365srs"
where "Department (Service Request Type) (Service Request Type)" is not null
and trim("Department (Service Request Type) (Service Request Type)") <> ''
on conflict ("department") do nothing;

/*
Inserting values into dim_created_by dimension table
*/

insert into "dim_created_by" ("created_by")
select distinct "Created By"
from "stage_d365srs"
where "Created By" is not null
and trim("Created By") <> ''
on conflict ("created_by") do nothing;

/*
Inserting values into dim_date dimension table. Populating dim_date independently of the staging table so all dates from 2020 to 2025 are included.
*/

insert into "dim_date" (
	"date_key",
	"full_date",
	"year",
	"quarter",
	"month",
	"month_name",
	"day_of_week",
	"day_name",
	"week_of_year"
)
overriding system value
select
	to_char(d, 'YYYYMMDD')::integer as date_key, d::date as full_date,
	extract(year from d)::integer as year,
	extract(quarter from d)::integer as quarter,
	extract(month from d)::integer as month,
	trim(to_char(d, 'Month')) as month_name,
	extract(isodow from d)::integer as day_of_week,
	trim (to_char(d, 'Day')) as day_name,
	extract(week from d)::integer as week_of_year
from generate_series(
	'2020-01-01'::date,
	'2025-12-31'::date,
	'1 day'::interval
	) as d
on conflict ("date_key") do nothing;

/*
Verifying all Status Reason values from staging table are contained in dim_status_reason
*/

select
    "Status Reason",
    "status_reason_id"
from "stage_d365srs"
left join "dim_status_reason"
    on "status_reason" = "Status Reason"
where "status_reason_id" is null;

/*
Verifying all Status values from staging table are contained in dim_status
*/

select
    "Status",
    "status_id"
from "stage_d365srs"
left join "dim_status"
    on "status" = "Status"
where "status_id" is null;

/*
Verifying all Service Request Type values from staging are contained in dim_service_type
*/

select
    "Service Request Type",
    "service_type_id"
from "stage_d365srs"
left join "dim_service_type"
    on "service_type" = "Service Request Type"
where "service_type_id" is null;

/*
Verifying all Department values from staging table are contained in dim_department
*/

select
    "Department (Service Request Type) (Service Request Type)",
    "department_id"
from "stage_d365srs"
left join "dim_department"
    on "department" = "Department (Service Request Type) (Service Request Type)"
where "department_id" is null;

/*
Verifying all Created By values from staging are contained in dim_created_by
*/

select
    "Created By",
    "created_by_id"
from "stage_d365srs"
left join "dim_created_by"
    on "created_by" = "Created By"
where "created_by_id" is null;

/*
Verifying all Created On values from staging table are contained in dim_date
*/

select
    "Created On",
    "date_key"
from "stage_d365srs"
left join "dim_date"
    on "full_date" = "Created On"::date
where "date_key" is null;


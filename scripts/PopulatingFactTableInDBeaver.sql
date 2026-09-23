/*
Creating fact table 
*/

create table "fact_d365srs" (
    "sr_id" bigserial primary key,
    "sr_num" text,
    "d365_num" text,
    "date_key" integer,
    "status_reason_id" integer,
    "status_id" integer,
    "service_type_id" integer,
    "department_id" integer,
    "created_by_id" integer,
    "created_on" timestamp,
    "finish_by" timestamp,
    "actual_finish" timestamp,
    "street_address" text
);

/*
Adding foreign key relationships to fact table 
*/

alter table "fact_d365srs"
add constraint "fk_fact_date"
foreign key ("date_key")
references "dim_date" ("date_key");

alter table "fact_d365srs"
add constraint "fk_fact_status_reason"
foreign key ("status_reason_id")
references "dim_status_reason" ("status_reason_id");

alter table "fact_d365srs"
add constraint "fk_fact_status"
foreign key ("status_id")
references "dim_status" ("status_id");

alter table "fact_d365srs"
add constraint "fk_fact_service_type"
foreign key ("service_type_id")
references "dim_status_reason" ("service_type_id");

alter table "fact_d365srs"
add constraint "fk_fact_department"
foreign key ("department_id")
references "dim_department" ("department_id");

alter table "fact_d365srs"
add constraint "fk_fact_created_by"
foreign key ("created_by_id")
references "dim_created_by" ("created_by_id");

/*
Populating fact table
*/

insert into "fact_d365srs" (
    "sr_num",
    "d365_num",
    "date_key",
    "status_reason_id",
    "status_id",
    "service_type_id",
    "department_id",
    "created_by_id",
    "created_on",
    "finish_by",
    "actual_finish",
    "street_address"
)
select
    "sr_num"::text,
    "d365_num"::text,
	"date_key",
    "status_reason_id",
    "status_id",
    "service_type_id",
    "department_id",
	"created_by_id",
    "Created On"::timestamp,
    nullif(trim("Failure Time (Resolve SLA) (SLA KPI Instance)"),'')::timestamp,
    "actual_finish_date"::timestamp,
    "Street Address"
from "stage_d365srs"
left join "dim_date"
    on "full_date" = "Created On"::date
left join "dim_status_reason"
    on "status_reason" = "Status Reason"
left join "dim_status"
    on "status" = "Status"
left join "dim_service_type"
    on "service_type" = "Service Request Type"
left join "dim_department"
    on "department" = "Department (Service Request Type) (Service Request Type)"
left join "dim_created_by"
	on "created_by" = "Created By";



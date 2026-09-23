/*
The value for Case Number is the 12-digit D365 case number combined with a prepended 6-digit Cityworks SR number when the two systems successfully interface
When the two systems fail to interface, the prepended 6-digit Cityworks SR number is not combined
Creating two new columns in stage_d365srs - sr_num and d365_num
*/

alter table "stage_d365srs"
add column sr_num TEXT,
add column d365_num TEXT;

/*
Splitting the Case Number column into the two new columns - sr_num and d365_num - to isolate the prepended 6-digit Cityworks SR number where interface was successful
*/

update "stage_d365srs"
set
	"sr_num" = split_part("Case Number", '-', 1),
	"d365_num" = split_part("Case Number", '-', 2)
where "Case Number" not like '%-%';

/*
Replacing all blank values in sr_num with 6-digit Cityworks SR number
 */

update "stage_d365srs"
set
	"sr_num" = "Case Number"
where "Case Number" not like '%-%'
and length ("Case Number") = 6;

/*
Replacing all blank values in d365_num with 13-digit case number
 */

update "stage_d365srs"
set
	"d365_num" = "Case Number"
where "Case Number" not like '%-%'
and length ("Case Number") > 6;

/*
 Checking stage_d365srs for any duplicate records
 */

select "Case Number", "Created On", count(*) as duplicate_count
from "stage_d365srs"	
group by "Case Number", "Created On"
having count(*) > 1
order by duplicate_count desc;

/*
Creating 9 new columns in stage_cwwos - request_id1 through request_id9 
*/

alter table "stage_cwwos"
add column request_id1 TEXT,
add column request_id2 TEXT,
add column request_id3 TEXT,
add column request_id4 TEXT,
add column request_id5 TEXT,
add column request_id6 TEXT,
add column request_id7 TEXT,
add column request_id8 TEXT,
add column request_id9 TEXT;

/*
Splitting the request_ids column into the 9 new columns - request_id1 through request_id9 - to separate service requests that are tied to the same work order
*/

update "stage_cwwos"
set
	"request_id1" = split_part("request_ids", ',', 1),
	"request_id2" = split_part("request_ids", ',', 2),
	"request_id3" = split_part("request_ids", ',', 3),
	"request_id4" = split_part("request_ids", ',', 4),
	"request_id5" = split_part("request_ids", ',', 5),
	"request_id6" = split_part("request_ids", ',', 6),
	"request_id7" = split_part("request_ids", ',', 7),
	"request_id8" = split_part("request_ids", ',', 8),
	"request_id9" = split_part("request_ids", ',', 9)
where "request_ids" is not null;


/*
Creating new column in stage_d365srs - actual_finish_date
 */

alter table "stage_d365srs"
add column actual_finish_date date;

/*
Updating values for actual_finish_date where sr_num equals request_id1
 */

update "stage_d365srs"
set
	"actual_finish_date" = "actual_finish"::date
from "stage_cwwos"
where "sr_num" = "request_id1";

/*
Updating values for actual_finish_date where sr_num equals request_id2
 */

update "stage_d365srs"
set
	"actual_finish_date" = "actual_finish"::date
from "stage_cwwos"
where "sr_num" = "request_id2";

/*
Updating values for actual_finish_date where sr_num equals request_id3
 */

update "stage_d365srs"
set
	"actual_finish_date" = "actual_finish"::date
from "stage_cwwos"
where "sr_num" = "request_id3";

/*
Updating values for actual_finish_date where sr_num equals request_id4
 */

update "stage_d365srs"
set
	"actual_finish_date" = "actual_finish"::date
from "stage_cwwos"
where "sr_num" = "request_id4";

/*
Updating values for actual_finish_date where sr_num equals request_id5
 */

update "stage_d365srs"
set
	"actual_finish_date" = "actual_finish"::date
from "stage_cwwos"
where "sr_num" = "request_id5";

/*
Updating values for actual_finish_date where sr_num equals request_id6
 */

update "stage_d365srs"
set
	"actual_finish_date" = "actual_finish"::date
from "stage_cwwos"
where "sr_num" = "request_id6";

/*
Updating values for actual_finish_date where sr_num equals request_id7
 */

update "stage_d365srs"
set
	"actual_finish_date" = "actual_finish"::date
from "stage_cwwos"
where "sr_num" = "request_id7";

/*
Updating values for actual_finish_date where sr_num equals request_id8
 */

update "stage_d365srs"
set
	"actual_finish_date" = "actual_finish"::date
from "stage_cwwos"
where "sr_num" = "request_id8";

/*
Updating values for actual_finish_date where sr_num equals request_id9
 */

update "stage_d365srs"
set
	"actual_finish_date" = "actual_finish"::date
from "stage_cwwos"
where "sr_num" = "request_id9";

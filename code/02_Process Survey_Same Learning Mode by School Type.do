// PURPOSE: Process survey data for districts with the same learning mode by school type

clear all

// LOAD DATA

use "03_Data Derived/01_Import Survey.dta"

// FILTER DISTRICTS
// Keep districts that were always in-person or that followed the same mode across all schools 

keep if (reduced_ops == 1 | (reduced_ops == 2 & school_vars == 2))

keep district dist_mode_* dist_hybrid_days_* reduced_ops scheduled_start actual_start survey_date

// RENAME VARIABLES

rename dist_mode_* mode_*
rename dist_hybrid_days_* days_*

// CLEAN VARIABLES

// Make mode in-person for districts that were always in-person

forvalues month = 1/10 {
  replace mode_`month' = 1 if reduced_ops == 1 & missing(mode_`month')
}

// Expand district shape to 6 rows per district (for elem, midd, high, elem-midd, midd-high, elem-midd-high)

expand 6
bys district: gen grade_level = _n
order district grade_level

// DROP VARIABLE

drop reduced_ops

// SORT & SAVE

sort district
compress
save "03_Data Derived/02_Same Learning Mode by School Type.dta", replace

// PURPOSE: Process survey data for all districts

clear all

// LOAD DATA

use "03_Data Derived/01_Import Survey.dta"

// DROP DISTRICTS
// Keep districts that used different learning modes across all schools 

keep if reduced_ops == 2
drop if school_vars == 2

// DROP VARIABLES

drop dist_mode_* dist_hybrid_days_* reduced_ops school_vars diff_modes

// RENAME VARIABLES

rename elem_mode_* mode_*_1
rename elem_hybrid_days_* days_*_1
rename midd_mode_* mode_*_2
rename midd_hybrid_days_* days_*_2
rename high_mode_* mode_*_3
rename high_hybrid_days_* days_*_3

// CLEAN VARIABLES

// Make learning mode for elem-midd, midd-high, and elem-midd-high

forvalues month = 1/10 {
  gen mode_`month'_4 = mode_`month'_1  // Elem-Midd learning mode = Elem learning mode
  gen mode_`month'_5 = mode_`month'_3  // Midd-High learning mode = High learning mode
  gen mode_`month'_6 = mode_`month'_1  // Elem-Midd-High learning mode = Elem learning mode
  
  gen days_`month'_4 = days_`month'_1  // Elem-Midd hybrid days = Elem hybrid days
  gen days_`month'_5 = days_`month'_3  // Midd-High hybrid days = High hybrid days
  gen days_`month'_6 = days_`month'_1  // Elem-Midd-High hybrid days = Elem hybrid days
}

// ORDER VARIABLES

order district mode_*_1 days_*_1 mode_*_2 days_*_2 mode_*_3 days_*_3 mode_*_4 days_*_4 mode_*_5 days_*_5 mode_*_6 days_*_6

// RESHAPE FROM WIDE FORMAT TO LONG FORMAT

reshape long mode_1_ mode_2_ mode_3_ mode_4_ mode_5_ mode_6_ mode_7_ mode_8_ mode_9_ mode_10_ ///
  days_1_ days_2_ days_3_ days_4_ days_5_ days_6_ days_7_ days_8_ days_9_ days_10_, i(district) j(grade_level)

rename *_ *

replace mode_1 = 3 if district == "State Charter Schools II- Academy For Classical Education" & grade_level == 6
replace mode_2 = 3 if district == "State Charter Schools II- Academy For Classical Education" & grade_level == 6

// APPEND SCHOOLS WITH SAME LEARNING MODE BY SCHOOL TYPE

append using "03_Data Derived/02_Same Learning Mode by School Type.dta"

// SORT & SAVE

sort district grade_level
compress
save "03_Data Derived/03_All Districts by School Type.dta", replace

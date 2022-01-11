// PURPOSE: Import survey data

clear all

// IMPORT DATA

import excel "02_Data Original/Learning Mode Survey.xlsx", sheet("P-EBT Survey") firstrow

// ENCODE VARIABLES

encode reduced_operations, gen(reduced_ops)
encode school_variations, gen(school_vars)
encode different_modes, gen(diff_modes)

// DROP VARIABLES

drop reduced_operations school_variations different_modes

// CLEAN VARIABLES

// Learning mode

foreach var of varlist dist_mode_* elem_mode_* midd_mode_* high_mode_* {
  replace `var' = "1" if `var' == "In-person"
  replace `var' = "2" if `var' == "Hybrid"
  replace `var' = "3" if regexm(`var', "Virtual")
}

// Hybrid days

foreach var in dist elem midd high {
  forvalues month = 1/10 {
    replace `var'_hybrid_days_`month' = . if `var'_mode_`month' != "2"    // Make hybrid days missing if learning mode is not hybrid
  }
}

// DESTRING VARIABLES

destring dist_* elem* midd* high*, replace

// RE-LABEL VARIABLES

label drop reduced_ops school_vars diff_modes

compress
format reduced_ops school_vars diff_modes %9.0g

label define reduced_ops ///
  1 "Never closed" ///
  2 "Closed"

label define school_vars ///
  1 "Different modes by school type" ///
  2 "Same mode" ///
  3 "Same mode, var in students' learning choices"

label define diff_modes ///
  1 "Survey by school level"

label values reduced_ops reduced_ops
label values school_vars school_vars
label values diff_modes diff_modes

// ORDER VARIABLES

order district survey_date scheduled_start actual_start reduced_ops school_vars diff_modes

// SORT & SAVE

sort district
compress
save "03_Data Derived/01_Import Survey.dta", replace

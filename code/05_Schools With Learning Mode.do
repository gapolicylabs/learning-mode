// PURPOSE: Associate learning modes with schools

clear all

// SET MACROS

global Input "C:/Users/tgoldring/Dropbox (GSU Dropbox)/Georgia Policy Labs/(4) CFPL/(2) Projects/Active/P-EBT/Survey/03_Public/03_Data Derived"
global Output "C:/Users/tgoldring/Dropbox (GSU Dropbox)/Georgia Policy Labs/(4) CFPL/(2) Projects/Active/P-EBT/Survey/03_Public/04_Output"

// LOAD DATA

use "03_Data Derived/04_Schools by School Type.dta"

// MERGE ON LEARNING MODE DATA USING DISTRICT AND ASSIGNED GRADE LEVEL (EL/MI/HI/ELMI/MIHI/ELMIHI)

merge m:1 district grade_level using "03_Data Derived/03_All Districts by School Type.dta", keep(1 3) nogen

// MERGE IN FULTON DATA
// Fulton learning data varied across schools and is processed in a separate do file

merge 1:1 district_id school_id using "03_Data Derived/06_Fulton Learning Mode.dta", nogen

forval x = 1/10 {
  replace mode_`x' = mode`x' if district_id == 660
  drop mode`x'
}

// MERGE IN BARROW DATA

merge 1:1 district_id school_id using "03_Data Derived/07_Barrow Learning Mode.dta", nogen

forval x = 1/10 {
  replace mode_`x' = mode`x' if district_id == 607
  replace days_`x' = days`x' if district_id == 607
  drop mode`x'
  drop days`x'
}

// MERGE IN LEE DATA

merge 1:1 district_id school_id using "03_Data Derived/08_Lee Learning Mode.dta", nogen

forval x = 1/10 {
  replace mode_`x' = mode`x' if district_id == 688
  replace days_`x' = days`x' if district_id == 688
  drop mode`x'
  drop days`x'
}

// MERGE IN SCHOOLS FOR THE DEAF OR BLIND DATA

merge 1:1 district_id school_id using "03_Data Derived/09_Schools for the Deaf or Blind Learning Mode.dta", nogen

forval x = 1/10 {
  replace mode_`x' = mode`x' if district_id == 799
  replace days_`x' = days`x' if district_id == 799
  drop mode`x'
  drop days`x'
}

// APPEND MILITARY SCHOOLS

append using "03_Data Derived/05_Military Schools.dta"

// CLEAN VARIABLES

// Clean district name

replace district = "State Charter Schools" if regexm(district, "State Charter")

// DROP VARIABLE

drop grade_level missing_months

// LABEL VARIABLES

// Label variables

label var scheduled_start "Scheduled start date for SY 2020-21"
label var actual_start "Actual start date for SY 2020-21"
label var mode_1 "Predominant learning mode in Aug 2020"
label var mode_2 "Predominant learning mode in Sep 2020"
label var mode_3 "Predominant learning mode in Oct 2020"
label var mode_4 "Predominant learning mode in Nov 2020"
label var mode_5 "Predominant learning mode in Dec 2020"
label var mode_6 "Predominant learning mode in Jan 2021"
label var mode_7 "Predominant learning mode in Feb 2021"
label var mode_8 "Predominant learning mode in Mar 2021"
label var mode_9 "Predominant learning mode in Apr 2021"
label var mode_10 "Predominant learning mode in May 2021"
label var days_1 "Virtual learning days under hybrid learning mode in Aug 2020"
label var days_2 "Virtual learning days under hybrid learning mode in Sep 2020"
label var days_3 "Virtual learning days under hybrid learning mode in Oct 2020"
label var days_4 "Virtual learning days under hybrid learning mode in Nov 2020"
label var days_5 "Virtual learning days under hybrid learning mode in Dec 2020"
label var days_6 "Virtual learning days under hybrid learning mode in Jan 2021"
label var days_7 "Virtual learning days under hybrid learning mode in Feb 2021"
label var days_8 "Virtual learning days under hybrid learning mode in Mar 2021"
label var days_9 "Virtual learning days under hybrid learning mode in Apr 2021"
label var days_10 "Virtual learning days under hybrid learning mode in May 2021"
label var survey_date "Date district completed learning mode survey"

// Define value labels

label define mode ///
  1 "In-person" ///
  2 "Hybrid" ///
  3 "Virtual"

// Label values

label values mode_* mode

// ORDER VARIABLES

order district_id district school_id school grade scheduled_start actual_start

// SORT & SAVE

drop survey_date
sort district_id school_id
compress
save "04_Output/GA School Learning Mode_SY 2020-21.dta", replace

export delimited "04_Output/GA School Learning Mode_SY 2020-21.csv", replace

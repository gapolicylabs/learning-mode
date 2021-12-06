// PURPOSE: Import schools by district data

clear all

// SET MACROS

global Input "C:/Users/Thomas/Dropbox (GSU Dropbox)/Georgia Policy Labs/(4) CFPL/(2) Projects/Active/P-EBT/Survey/03_Public/02_Data Original"
global Output "C:/Users/Thomas/Dropbox (GSU Dropbox)/Georgia Policy Labs/(4) CFPL/(2) Projects/Active/P-EBT/Survey/03_Public/03_Data Derived"

// IMPORT DATA

import excel "${Input}/Schools by Districts.xlsx", firstrow

// DROP UNNEEDED VARIABLES

drop SchoolAddress SchoolCity State SchoolZIPCODE

// RENAME VARIABLES

rename DistrictID district_id
rename DistrictName district
rename SchoolID school_id
rename SchoolName school
rename GradeRange grade

// CLEAN VARIABLES

// Determine assigned grade level for each school
// 6 possible grade levels: Elem, Middle, High, Elem-Midd, Midd-High, Elem-Midd-High

// 1. Use school names

gen     grade_level = 1 if  regexm(school, "Elementary") | regexm(school, "Primary")
replace grade_level = 2 if  regexm(school, "Middle")
replace grade_level = 3 if  regexm(school, "High") & !regexm(school, "High Achievers")
replace grade_level = 4 if  regexm(school, "Elementary") & regexm(school, "Middle") & district_id != 707
replace grade_level = 5 if  regexm(school, "Middle") & regexm(school, "High") & district_id != 633
replace grade_level = 6 if  regexm(school, "Elementary") & regexm(school, "High") & !inlist(district_id, 644, 660, 708, 722)

// 2. Use given grade range served

replace grade_level = 1 if  (regexm(grade, "-PK") | regexm(grade, "-KK") | regexm(grade, "-01") | ///
                            regexm(grade, "-02") | regexm(grade, "-03") | regexm(grade, "-04") | ///
                            regexm(grade, "-05")) & ///
                            missing(grade_level)
                            
replace grade_level = 2 if  (regexm(grade, "06-06") | regexm(grade, "06-07") | regexm(grade, "06-08") | ///
                            regexm(grade, "07-08")) & ///
                            missing(grade_level)
                            
replace grade_level = 3 if  (regexm(grade, "09-09") | regexm(grade, "09-10") | regexm(grade, "09-11") | ///
                            regexm(grade, "09-12") | regexm(grade, "10-12")) & ///
                            missing(grade_level)
                            
replace grade_level = 4 if  (regexm(grade, "03-06") | regexm(grade, "03-08") | regexm(grade, "04-06") | ///
                            regexm(grade, "04-08") | regexm(grade, "05-06") | regexm(grade, "05-07") | ///
                            regexm(grade, "05-08") | regexm(grade, "KK-06") | regexm(grade, "KK-07") | ///
                            regexm(grade, "KK-08") | regexm(grade, "PK-06") | regexm(grade, "PK-08")) & ///
                            missing(grade_level)
                            
replace grade_level = 5 if  (regexm(grade, "06-10") | regexm(grade, "06-12") | regexm(grade, "08-09") | ///
                            regexm(grade, "08-12")) & ///
                            missing(grade_level)
                            
replace grade_level = 6 if  (regexm(grade, "01-12") | regexm(grade, "03-12") | regexm(grade, "04-12") | ///
                            regexm(grade, "05-12") | regexm(grade, "KK-09") | regexm(grade, "KK-11") | ///
                            regexm(grade, "KK-12") | regexm(grade, "PK-09") | regexm(grade, "PK-12")) & ///
                            missing(grade_level)

// LABEL VARIABLES

label var grade_level "Grade Level"

label define grade_level ///
  1 "Elem" ///
  2 "Midd" ///
  3 "High" ///
  4 "Elem-Midd" ///
  5 "Midd-High" ///
  6 "Elem-Midd-High"

label values grade_level grade_level

// SORT & SAVE

sort district_id school_id
compress
save "${Output}/04_Schools by School Type.dta", replace

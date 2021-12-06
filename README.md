# Georgia Schools' Learning Mode During SY 2020-21

## Introduction

This repository contains learning mode data for public schools in Georgia during school year 2020-21. The data were originally collected to administer Pandemic-EBT (P-EBT) benefits to eligible Georgia students and families.

## Learning Mode Survey

The data were collected using a Qualtrics survey of school districts in the summer and fall of 2021. Follow-up calls were placed to non-respondents. The survey was usually completed by district leaders (e.g., a Superintendent or Assistant Superintendent) or a district's Nutrition Director.

The survey requested the predominant learning mode for each month during SY 2020-21. The learning mode options were in-person, hybrid, or fully virtual. A hybrid learning mode included both virtual and in-person days in the same month; respondents indicated the number of virtual learning days. Respondents could specify the monthly learning mode for all schools in the district, separately by school type (elementary, middle, or high), or request to speak to a member of the survey team to specify learning modes by individual school.

## Data Preparation

Survey data were cleaned using Stata; the code is provided. An important part of preparing the data was linking districts' learning mode by school type (elementary, middle, high) to specific schools when the grades served by a school did not match the "traditional" elementary, middle, or high school grades. Learning modes were assigned based on two criteria: (1) the name of the school (e.g., "elementary", "primary", "middle", "high"); and (2) the grades served. Schools serving non-standard grades were assigned as follows: elementary and middle grades were assigned the elementary school learning mode; middle and high grades were assigned the high school learning mode; and elementary through high grades were assigned the elementary school learning mode.

## Data Format

The learning mode data are available in csv and Stata formats. The Stata dataset includes labels as specified below.

## Codebook

**Value Labels:**

Learning mode:  
1 - In-person  
2 - Hybrid  
3 - Virtual

**Variable Labels:**

| Variable           | Label                                 |
| --- | --- |
| scheduled_start    | Scheduled start date for SY 2020-21   |
| actual_start       | Actual start date for SY 2020-21      |
| mode_1             | Predominant learning mode in Aug 2020 |
| mode_2             | Predominant learning mode in Sep 2020 |
| mode_3             | Predominant learning mode in Oct 2020 |
| mode_4             | Predominant learning mode in Nov 2020 |
| mode_5             | Predominant learning mode in Dec 2020 |
| mode_6             | Predominant learning mode in Jan 2021 |
| mode_7             | Predominant learning mode in Feb 2021 |
| mode_8             | Predominant learning mode in Mar 2021 |
| mode_9             | Predominant learning mode in Apr 2021 |
| mode_10            | Predominant learning mode in May 2021 |
| days_1             | Virtual learning days under hybrid learning mode in Aug 2020 |
| days_2             | Virtual learning days under hybrid learning mode in Sep 2020 |
| days_3             | Virtual learning days under hybrid learning mode in Oct 2020 |
| days_4             | Virtual learning days under hybrid learning mode in Nov 2020 |
| days_5             | Virtual learning days under hybrid learning mode in Dec 2020 |
| days_6             | Virtual learning days under hybrid learning mode in Jan 2021 |
| days_7             | Virtual learning days under hybrid learning mode in Feb 2021 |
| days_8             | Virtual learning days under hybrid learning mode in Mar 2021 |
| days_9             | Virtual learning days under hybrid learning mode in Apr 2021 |
| days_10            | Virtual learning days under hybrid learning mode in May 2021 |
| survey_date        | Date district completed learning mode survey |


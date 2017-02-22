
***********************************************
	
* Table 1

	clear
	use "/$dd/isall_n_cm.dta", clear
	
	* svyset psuid [pweight= discwt], strata(stratum)
	* Due to too few observations in units, we decided to merge small stratums into bigger ones. 
	
	svyset psuid [pweight= discwt], strata(stratum_n)
	
	svy: tab agecat3 yearcat, count col cellwidth(15) format(%15.2f) percent 
	svy: tab racecat yearcat, count col cellwidth(15) format(%15.2f) percent
	svy: tab female yearcat, count col cellwidth(15) format(%15.2f) percent
	svy: tab pay3 yearcat, count col cellwidth(15) format(%15.2f) percent
	svy: tab zipinc_qrtl yearcat, count col cellwidth(15) format(%15.2f) percent
	svy: tab loinc yearcat, count col cellwidth(15) format(%15.2f) percent
	svy: tab hosp_location yearcat, count col cellwidth(15) format(%15.2f) percent
	svy: tab hosp_teach yearcat, count col cellwidth(15) format(%15.2f) percent
	svy: tab hosp_bedsize yearcat, count col cellwidth(15) format(%15.2f) percent
	svy: tab hosp_region yearcat, count col cellwidth(15) format(%15.2f) percent
	
***********************************************
	
	

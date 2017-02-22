
***********************************************
	
* Table 3

	clear
	use "$dd/isall_r_trauma.dta", clear
	
	svyset psuid [pweight= discwt], strata(stratum_n)
	svy: tab agecat3, count col cellwidth(15) format(%15.2f) percent 
	
	* AIS
	replace sev_1=9 if sev_1==.
	*label define sev 1 "Minor superficial laceration" 2 "Moderate fractured sternum" 3 "Serious open fracture" 4 "Severe perforated trachea" 5 "Critical ruptured liver" 6 "Maximum total severance of aorta" 9 "Not further specified"
	replace sev_1=4 if sev_1==5 | sev_1==6
	label define sev 1 "Minor superficial laceration" 2 "Moderate fractured sternum" 3 "Serious open fracture" 4 "Severe/Critical/Max" 9 "Not further specified"
	label value sev_1 sev
	
	* counts
	svy: tab sev_1, count col cellwidth(15) format(%15.2f) percent 
	svy: tab sev_1 if types == 1, count col cellwidth(15) format(%15.2f) percent
	svy: tab sev_1 if types == 2, count col cellwidth(15) format(%15.2f) percent
	svy: tab sev_1 if types == 3, count col cellwidth(15) format(%15.2f) percent
	svy: tab sev_1 if types == 4, count col cellwidth(15) format(%15.2f) percent
	
	svy: tab sev_1 if agecat3 == 1, count col cellwidth(15) format(%15.2f) percent
	svy: tab sev_1 if agecat3 == 2, count col cellwidth(15) format(%15.2f) percent
	svy: tab sev_1 if agecat3 == 3, count col cellwidth(15) format(%15.2f) percent

	* overall
	svy: mlogit sev_1 year, base(1) rrr
	prchange, uncentered all help // 
	test year
	
	* intent
	svy: mlogit sev_1 year if types==1, base(1) rrr
	prchange if types==1, uncentered all help // 
	test year
	
	svy: mlogit sev_1 year if types==2, base(1) rrr
	prchange if types==2, uncentered all help // 
	test year
	
	svy: mlogit sev_1 year if types==3, base(1) rrr
	prchange if types==3, uncentered all help // 
	test year
	
	svy: mlogit sev_1 year if types==4, base(1) rrr
	prchange if types==3, uncentered all help // 
	test year
	
	gen aint=year*types
	svy: mlogit sev_1 year i.types aint, base(1) rrr
	test aint
	
	drop aint 

	* age group
	svy: mlogit sev_1 year if agecat3==1, base(1) rrr
	prchange if agecat3==1, uncentered all help // 
	test year
	
	svy: mlogit sev_1 year if agecat3==2, base(1) rrr
	prchange if agecat3==2, uncentered all help // 
	test year
	
	svy: mlogit sev_1 year if agecat3==3, base(1) rrr
	prchange if agecat3==3, uncentered all help // 
	test year
	
	gen aint=year*agecat3
	svy: mlogit sev_1 year i.agecat3 aint, base(1) rrr
	test aint
	
	drop aint 
	
***********************************************

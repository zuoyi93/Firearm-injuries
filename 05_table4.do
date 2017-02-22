
***********************************************
	
* Table 4
	
	clear
	use "$dd/isall_r_trauma.dta", clear
	
	svyset psuid [pweight= discwt], strata(stratum_n)
	
	* ISS (an anatomic scoring system) for all identified cases of abusive injury.16,17 This software uses
	* clinically derived algorithms to assign an abbreviated severity score to each of 6 major body regions based on ICD-9-
	* CM diagnosis codes and the age of the individual.
	label define iss 1 "Head or neck" 2 "Face" 3 "Chest" 4 "Abdominal or pelvic contents" 5 "Extremities or pelvic girdle" 6 "External"
	label value issbr_1 iss
	
	* counts
	svy: tab issbr_1, count col cellwidth(15) format(%15.2f) percent 
	svy: tab issbr_1 if types == 1, count col cellwidth(15) format(%15.2f) percent
	svy: tab issbr_1 if types == 2, count col cellwidth(15) format(%15.2f) percent
	svy: tab issbr_1 if types == 3, count col cellwidth(15) format(%15.2f) percent
	svy: tab issbr_1 if types == 4, count col cellwidth(15) format(%15.2f) percent
	
	svy: tab issbr_1 if agecat3 == 1, count col cellwidth(15) format(%15.2f) percent
	svy: tab issbr_1 if agecat3 == 2, count col cellwidth(15) format(%15.2f) percent
	svy: tab issbr_1 if agecat3 == 3, count col cellwidth(15) format(%15.2f) percent

* overall
	svy: mlogit issbr_1 year, base(1) rrr
	prchange, uncentered all help // 
	test year
	
	* intent
	svy: mlogit issbr_1 year if types==1, base(1) rrr
	prchange if types==1, uncentered all help // 
	test year
	
	svy: mlogit issbr_1 year if types==2, base(1) rrr
	prchange if types==2, uncentered all help // 
	test year
	
	svy: mlogit issbr_1 year if types==3, base(1) rrr
	prchange if types==3, uncentered all help // 
	test year
	
	svy: mlogit issbr_1 year if types==4, base(1) rrr
	prchange if types==3, uncentered all help // 
	test year
	
	gen aint=year*types
	svy: mlogit issbr_1 year i.types aint, base(1) rrr
	test aint
	
	drop aint 

	* age group
	svy: mlogit issbr_1 year if agecat3==1, base(1) rrr
	prchange if agecat3==1, uncentered all help // 
	test year
	
	svy: mlogit issbr_1 year if agecat3==2, base(1) rrr
	prchange if agecat3==2, uncentered all help // 
	test year
	
	svy: mlogit issbr_1 year if agecat3==3, base(1) rrr
	prchange if agecat3==3, uncentered all help // 
	test year
	
	gen aint=year*agecat3
	svy: mlogit issbr_1 year i.agecat3 aint, base(1) rrr
	test aint
	
	drop aint 
	
***********************************************

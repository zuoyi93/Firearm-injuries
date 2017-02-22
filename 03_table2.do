
***********************************************
	
* Table 2

	clear
	use "$dd/isall_r_trauma.dta", clear
	
	svyset psuid [pweight= discwt], strata(stratum_n)
	
	misstable sum niss
	svy: mean niss
	svy: tab types if niss !=. , count col cellwidth(15) format(%15.2f) percent 
	svy: tab agecat3 if niss !=. , count col cellwidth(15) format(%15.2f) percent 
	
	svy: mean niss
	svy: regress niss year if types==1
	svy: regress niss year if types==2
	svy: regress niss year if types==3
	svy: regress niss year if types==4
	
	svy: regress niss year if agecat3==1
	svy: regress niss year if agecat3==2
	svy: regress niss year if agecat3==3
	
	gen aint=year*types
	svy: regress niss year aint i.types
	drop aint 
	
	gen aint=year*agecat3
	svy: regress niss year aint i.agecat3
	drop aint 
	
***********************************************	

     
******************************************************************

* DATA PREP - 	Jan 2016.

* PROGRAMS BY: KALESAN/Zuo

* PROJECT: injury severity

* from HCUPNET: 1993 TO 2013

******************************************************************

* STEP 1: RESTRICT 2011 DATASET TO gunshot==1 & agecat!=.

** Notes 1: Usually firearm injuries would not go into dx1 category. However, we would still consider dx1 when generating new variables.

** Notes 2: From 2003 to 2013, ecode1-4, dx1-15 and dx16-25 are available; from 1993 to 2002, only dx1-15 are available.

* STEP 2: APPEND ALL PRT DATASETS FROM 1993 TO 2013

* STEP 3: EXPLORATORY, SURVEY SET

******************************************************************

* Jan 15, 2016: dx check done for all years
* Jan 15, 2016: Legal E970 check for all years

** Notes: We use ecode1-4 instead of dx1-15 or dx16-25 

* 2013
	clear
	use "$dpp/yr2013dataprep/00_stata/data/NIS_2013_ALL.dta", clear // N = 7,119,563
	
	*drop chron1-chronb25 pclass1-pclass15 dxccs1-dxccs25 prccs1-prccs15 
	* keep all with no missing age
	keep if age!=.
	
	rename hosp_nis psuid
	count // 7,117,978
	
	* accident
	gen accident=.
	for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx1-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx1-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	*for var dx1-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	*for var dx1-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	*for var dx1-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	*for var dx1-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" )
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count // 5675
	
	rename key_nis key
	
	save "$dd/is2013.dta", replace
	
*****************************************************************************

* 2012
	clear
	use "$dpp/yr2012dataprep/00_stata/data/NIS_2012_ALL.dta", clear // N = 7,296,968
	
	*drop chron1-chronb25 pclass1-pclass15 dxccs1-dxccs25 prccs1-prccs15 
	* keep all with no missing age
	keep if age!=.
	
	rename hosp_nis psuid
	count // 7,293,627
	
	* accident
	gen accident=.
	for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx1-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx1-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	*for var dx1-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	*for var dx1-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	*for var dx1-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	*for var dx1-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" )
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count // 5963
	
	rename key_nis key
	
	save "$dd/is2012.dta", replace
	
*****************************************************************************
* 2011: 

** Notes: We use ecode1-4 instead of dx1-15 or dx16-25 

	clear
	use "$dpp/yr2011dataprep/00_stata/data/NIS_2011_ALL.dta", clear // N = 8,023,590
	
	*drop chron1-chronb25 pclass1-pclass15 dxccs1-dxccs25 prccs1-prccs15 
	* keep all with no missing age
	keep if age!=.
	
	rename hospid psuid
	count // 8017646
	
	* accident
	gen accident=.
	for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx1-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx1-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	*for var dx1-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	*for var dx1-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	*for var dx1-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	*for var dx1-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" )
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count // 6102
	
	save "$dd/is2011.dta", replace
	
*****************************************************************************	

* 2010: 
** Notes: We use ecode1-4 instead of dx1-15 or dx16-25 

	clear
	use "$dpp/yr2010dataprep/00_stata/data/NIS_2010_ALL.dta", clear // N = 7,800,441
	
	*drop chron1-chronb25 pclass1-pclass15 dxccs1-dxccs25 prccs1-prccs15 pclass1-pclass15
	* keep all with no missing age
	keep if age!=.
	
	rename hospid psuid
	count // 7,790,163
	
	* accident
	gen accident=.
	for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx1-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx1-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	*for var dx1-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	*for var dx1-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	*for var dx1-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	*for var dx1-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" )
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count // 7949
	
	save "$dd/is2010.dta", replace

*****************************************************************************	

* 2009: 
** Notes: We use ecode1-4 instead of dx1-15 or dx16-25 

	clear
	use "$dpp/yr2009dataprep/00_stata/data/NIS_2009_ALL.dta", clear // N = 7,810,762
	
	*drop chron1-chronb25 pclass1-pclass15 dxccs1-dxccs25 prccs1-prccs15
	* keep all with no missing age
	keep if age!=.
	
	rename hospid psuid
	count // 7,800,241
	
	* accident
	gen accident=.
	for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx1-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx1-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	*for var dx1-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	*for var dx1-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
	
				
	* undetermined intent
	gen uintent=.
	for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	*for var dx1-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	*for var dx1-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" )
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count //  5999
	
	save "$dd/is2009.dta", replace

*****************************************************************************	

* 2008: 
** Notes: We use ecode1-4 instead of dx1-15 or dx16-25 

	clear
	use "$dpp/yr2008dataprep/00_stata/data/NIS_2008_ALL.dta", clear // N = 8,158,381
	
	*drop chron1-chronb15 pclass1-pclass15 dxccs1-dxccs15 prccs1-prccs15 
	* keep all with no missing age
	keep if age!=.
	
	rename hospid psuid
	count // 8,148,298
	
	* accident
	gen accident=.
	for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx1-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx1-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	*for var dx1-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	*for var dx1-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	*for var dx1-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	*for var dx1-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" ) 
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count //  5861
	
	save "$dd/is2008.dta", replace

*****************************************************************************	

* 2007: 
** Notes: We use ecode1-4 instead of dx1-15 or dx16-25 

	clear
	use "$dpp/yr2007dataprep/00_stata/data/NIS_2007_ALL.dta", clear // N = 8,043,415

	*drop chron1-chronb25 pclass1-pclass15 dxccs1-dxccs25 prccs1-prccs15 pclass1-pclass15
	* keep all with no missing age
	keep if age!=.
	
	rename hospid psuid
	count // 8,034,632
	
	* accident
	gen accident=.
	for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx1-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx1-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	*for var dx1-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	*for var dx1-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	*for var dx1-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	*for var dx1-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" ) 
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count //  6615
	
	save "$dd/is2007.dta", replace

*****************************************************************************	

* 2006: 
** Notes: We use ecode1-4 instead of dx1-15 or dx16-25 

	clear
	use "$dpp/yr2006dataprep/00_stata/data/NIS_2006_ALL.dta", clear // N = 8,074,825
	
	*drop chron1-chronb25 pclass1-pclass15 dxccs1-dxccs25 prccs1-prccs15 pclass1-pclass15
	* keep all with no missing age
	keep if age!=.
	
	rename hospid psuid
	count // 8,066,796
	
	* accident
	gen accident=.
	for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx1-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx1-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	*for var dx1-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	*for var dx1-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	*for var dx1-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	*for var dx1-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" ) 
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count //  6611
	
	save "$dd/is2006.dta", replace

*****************************************************************************	

* 2005: 
** Notes: We use ecode1-4 instead of dx1-15 or dx16-25 

	clear
	use "$dpp/yr2005dataprep/00_stata/data/NIS_2005_ALL.dta", clear // N = 7,995,048
	
	*drop chron1-chronb25 pclass1-pclass15 dxccs1-dxccs25 prccs1-prccs15 pclass1-pclass15
	* keep all with no missing age
	keep if age!=.
	
	rename hospid psuid
	count // 7,984,586
	
	* accident
	gen accident=.
	for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx1-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx1-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	*for var dx1-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	*for var dx1-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	*for var dx1-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	*for var dx1-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" ) 
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count //  6485
	
	save "$dd/is2005.dta", replace
		
*****************************************************************************	

* 2004: 
** Notes: We use ecode1-4 instead of dx1-15 or dx16-25 

	clear
	use "$dpp/yr2004dataprep/00_stata/data/NIS_2004_ALL.dta", clear // N = 8,004,571 
	
	*drop dxccs1-dxccs15 prccs1-prccs15
	* keep all with no missing age
	keep if age!=.
	
	rename hospid psuid
	count // 7,994,246
	
	* accident
	gen accident=.
	for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx1-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx1-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	*for var dx1-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	*for var dx1-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	*for var dx1-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	*for var dx1-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" ) 
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count // 7054 
	
	save "$dd/is2004.dta", replace
		
*****************************************************************************		

* 2003: 
** Notes: We use ecode1-4 instead of dx1-15 or dx16-25 

	clear
	use "$dpp/yr2003dataprep/01_stata/data/NIS_2003_ALL.dta", clear // N = 7,977,728 
	
	*drop dxccs1-dxccs15 prccs1-prccs15
	* keep all with no missing age
	keep if age!=.
	
	rename hospid psuid
	count // 7,966,479
	
	* accident
	gen accident=.
	for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx1-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx1-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	*for var dx1-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	*for var dx1-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	*for var dx1-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	*for var dx1-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" ) 
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count // 6243 
	
	save "$dd/is2003.dta", replace
		
*****************************************************************************
	
* 2002: 
** Notes: We use dx1-15 instead of ecode1-4 or dx16-25 

	clear
	use "$dpp/yr2002dataprep/01_stata/data/NIS_2002_ALL.dta", clear // N = 7,853,982 
	
	*drop dxccs1-dxccs15 prccs1-prccs15
	* keep all with no missing age
	keep if age!=.
	
	rename hospid psuid
	count // 7,853,039
	
	* accident
	gen accident=.
	*for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	for var dx1-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	*for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	for var dx1-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	*gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	gen legal=.
	for var dx1-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	*for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	for var dx1-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	*for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	for var dx1-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	*gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	gen war=.
	for var dx1-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" ) 
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count // 6984 
	
	save "$dd/is2002.dta", replace

*****************************************************************************

* 2001: 
** Notes: We use dx1-15 instead of ecode1-4 or dx16-25 

	clear
	use "$dpp/yr2001dataprep/01_stata/data/NIS_2001_ALL.dta", clear // N = 7,452,727
	
	*drop dxccs1-dxccs15 prccs1-prccs15
	* keep all with no missing age
	keep if age!=.
	
	rename hospid psuid
	count // 7,452,276
	
	* accident
	gen accident=.
	*for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	for var dx1-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	*for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	for var dx1-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	*gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	gen legal=.
	for var dx1-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	*for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	for var dx1-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	*for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	for var dx1-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	*gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	gen war=.
	for var dx1-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" ) 
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count // 4811 
	
	save "$dd/is2001.dta", replace

*****************************************************************************

* 2000: 
** Notes: We use dx1-15 instead of ecode1-4 or dx16-25 

	clear
	use "$dpp/yr2000dataprep/01_stata/data/NIS_2000_ALL.dta", clear // N = 7,450,992
	
	*drop dxccs1-dxccs15 prccs1-prccs15
	* keep all with no missing age
	keep if age!=.
	
	rename hospid psuid
	count // 7,449,624
	
	* accident
	gen accident=.
	*for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	for var dx1-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	*for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	for var dx1-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	*gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	gen legal=.
	for var dx1-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	*for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	for var dx1-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	*for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	for var dx1-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	*gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	gen war=.
	for var dx1-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" ) 
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count // 6125
	
	save "$dd/is2000.dta", replace

*****************************************************************************

* 1999: 
** Notes: We use dx1-15 instead of ecode1-4 or dx16-25 

	clear
	use "$dpp/yr1999dataprep/01_stata/data/NIS_1999_ALL.dta", clear // N = 7,198,929
	
	*drop dxccs1-dxccs15 prccs1-prccs15
	* keep all with no missing age
	keep if age!=.
	
	rename hospid psuid
	count // 7,196,772
	
	* accident
	gen accident=.
	*for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	for var dx1-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	*for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	for var dx1-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	*gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	gen legal=.
	for var dx1-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	*for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	for var dx1-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	*for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	for var dx1-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	*gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	gen war=.
	for var dx1-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" ) 
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count // 6176
	
	save "$dd/is1999.dta", replace

*****************************************************************************

* 1998: 
** Notes: We use dx1-15 instead of ecode1-4 or dx16-25 

	clear
	use "$dpp/yr1998dataprep/01_stata/data/NIS_1998_ALL.dta", clear // N = 6,827,350
	
	*drop dxccs1-dxccs15 prccs1-prccs15
	* keep all with no missing age
	keep if age!=.
	
	rename hospid psuid
	count // 6,825,945
	
	* accident
	gen accident=.
	*for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	for var dx1-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	*for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	for var dx1-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	*gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	gen legal=.
	for var dx1-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	*for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	for var dx1-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	*for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	for var dx1-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	*gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	gen war=.
	for var dx1-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" ) 
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count //  6867
	
	save "$dd/is1998.dta", replace

*****************************************************************************

* 1997: 
** Note 1: We use dx1-15 instead of ecode1-4 or dx16-25 
** NOte 2: dx1 dx2-dx15

	clear
	use "$dpp/yr1997dataprep/01_stata/data/NIS_1997_all.dta", clear // N = 7,148,420
	
	*drop dxccs1-dxccs15 prccs1-prccs15
	* keep all with no missing age
	keep if age!=.
	
	rename hospid psuid
	count // 7,146,385
	
	* accident
	gen accident=.
	*for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	for var dx1 dx2-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	*for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	for var dx1 dx2-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	*gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	gen legal=.
	for var dx1 dx2-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	*for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	for var dx1 dx2-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	*for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	for var dx1 dx2-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	*gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	gen war=.
	for var dx1 dx2-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" ) 
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count //   7611
	
	save "$dd/is1997.dta", replace

*****************************************************************************

* 1996: 
** Note 1: We use dx1-15 instead of ecode1-4 or dx16-25 
** NOte 2: dx1 dx2-dx15

	clear
	use "$dpp/yr1996dataprep/01_stata/data/NIS_1996_all.dta", clear // N = 6,542,069
	
	*drop dxccs1-dxccs15 prccs1-prccs15
	* keep all with no missing age
	keep if age!=.
	
	rename hospid psuid
	count // 6,540,511
	
	* accident
	gen accident=.
	*for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	for var dx1 dx2-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	*for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	for var dx1 dx2-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	*gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	gen legal=.
	for var dx1 dx2-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	*for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	for var dx1 dx2-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	*for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	for var dx1 dx2-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	*gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	gen war=.
	for var dx1 dx2-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" ) 
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count //  7528
	
	save "$dd/is1996.dta", replace

*****************************************************************************

* 1995: 
** Note 1: We use dx1-15 instead of ecode1-4 or dx16-25 
** NOte 2: dx1 dx2-dx15

	clear
	use "$dpp/yr1995dataprep/01_stata/data/NIS_1995_All.dta", clear // N = 6,714,935
	
	*drop dxccs1-dxccs15 prccs1-prccs15
	* keep all with no missing age
	keep if age!=.
	
	rename hospid psuid
	count // 6,713,084
	
	* accident
	gen accident=.
	*for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	for var dx1 dx2-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	*for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	for var dx1 dx2-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	*gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	gen legal=.
	for var dx1 dx2-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	*for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	for var dx1 dx2-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	*for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	for var dx1 dx2-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	*gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	gen war=.
	for var dx1 dx2-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" ) 
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count //  10432
	
	save "$dd/is1995.dta", replace
	
*****************************************************************************

* 1994: 
** Note 1: We use dx1-15 instead of ecode1-4 or dx16-25 
** NOte 2: dx1 dx2-dx15

	clear
	use "$dpp/yr1994dataprep/01_stata/data/NIS_1994_All.dta", clear // N = 6,385,011
	
	*drop dxccs1-dxccs15 prccs1-prccs15
	* keep all with no missing age
	keep if age!=.
	
	rename hospid psuid
	count // 6,382,733
	
	* accident
	gen accident=.
	*for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	for var dx1 dx2-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	*for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	for var dx1 dx2-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	*gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	gen legal=.
	for var dx1 dx2-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	*for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	for var dx1 dx2-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	*for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	for var dx1 dx2-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	*gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	gen war=.
	for var dx1 dx2-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" ) 
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count //  8012
	
	save "$dd/is1994.dta", replace
	
*****************************************************************************

* 1993: 
** Note 1: We use dx1-15 instead of ecode1-4 or dx16-25 
** NOte 2: dx1 dx2-dx15

	clear
	use "$dpp/yr1993dataprep/01_stata/data/NIS_1993_ALL.dta", clear // N = 6,538,976
	
	*drop dxccs1-dxccs15 prccs1-prccs15
	* keep all with no missing age
	keep if age!=.
	
	rename hospid psuid
	count // 6,537,017
	
	* accident
	gen accident=.
	*for var ecode1-ecode4: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	for var dx1 dx2-dx15: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	*for var dx16-dx25: replace accident=1 if (X=="E9220" | X=="E9221" | X=="E9222" | X=="E9223" | X=="E9224" | X=="E9228" | X=="E9229") 
	
	* suicide
	gen suicide=.
	*for var ecode1-ecode4: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	for var dx1 dx2-dx15: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 
	*for var dx16-dx25: replace suicide=1 if (X=="E9550" | X=="E9551" | X=="E9552" | X=="E9553" | X=="E9554" | X=="E9556" | X=="E9559") 

	* legal intervention
	*gen legal=1 if (ecode1=="E970" | ecode2=="E970" | ecode3=="E970" | ecode4=="E970") 
	gen legal=.
	for var dx1 dx2-dx15: replace legal=1 if (X=="E970")
	*for var dx16-dx25: replace legal=1 if (X=="E970")
	
	* assault
	gen assault=.
	*for var ecode1-ecode4: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654") 
	for var dx1 dx2-dx15: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")
	*for var dx16-dx25: replace assault=1 if (X=="E9650" | X=="E9651" | X=="E9652" | X=="E9653" | X=="E9654")	
				
	* undetermined intent
	gen uintent=.
	*for var ecode1-ecode4: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 
	for var dx1 dx2-dx15: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
	*for var dx16-dx25: replace uintent=1 if (X=="E9850" | X=="E9851" | X=="E9852" | X=="E9853" | X=="E9854" | X=="E9856") 	
		
	* war
	*gen war=1 if (ecode1=="E991" | ecode2=="E991" | ecode3=="E991" | ecode4=="E991") 
	gen war=.
	for var dx1 dx2-dx15: replace war=1 if (X=="E991" ) 
	*for var dx16-dx25: replace war=1 if (X=="E991" ) 
	
	gen gunshot=1 if accident==1 | suicide==1 | assault==1 | legal==1 | uintent==1 | war==1
	
	gen types=1 if assault==1
	replace types=2 if types==. & accident==1
	replace types=3 if types==. & suicide==1
	replace types=4 if types==. & uintent==1
	replace types=5 if types==. & legal==1
	replace types=6 if types==. & war==1
		
	replace assault=0 if types!=1
	replace accident=0 if types!=2
	replace suicide=0 if types!=3
	replace uintent=0 if types!=4
	replace legal=0 if types!=5
	
	for var gunshot  assault accident suicide uintent legal war: replace X=0 if X==.
	keep if gunshot==1 
	count //   7969
	
	save "$dd/is1993.dta", replace
	
*****************************************************************************
	
	* STEP 2: REALIGNING THE WEIGHTS USING WEIGHTS DATA
	
	clear
	use "$dd/is1993.dta", clear
	rename psuid hospid
	mmerge hospid using "$dpp/yr1993dataprep/01_stata/data/NIS_1993_HOSPITAL_TrendWt.dta"
	keep if _merge==3
	drop _merge
	rename hospid psuid
	save "$dd/is1993.dta", replace
	clear
	use "$dd/is1993.dta", clear
	rename trendwt discwt
	save "$dd/is1993.dta", replace
	
	clear
	use "$dd/is1994.dta", clear
	rename psuid hospid
	mmerge hospid using "$dpp/yr1994dataprep/01_stata/data/NIS_1994_HOSPITAL_TrendWt.dta"
	keep if _merge==3
	drop _merge
	rename hospid psuid
	save "$dd/is1994.dta", replace
	clear
	use "$dd/is1994.dta", clear
	rename trendwt discwt
	save "$dd/is1994.dta", replace
	
	clear
	use "$dd/is1995.dta", clear
	rename psuid hospid
	mmerge hospid using "$dpp/yr1995dataprep/01_stata/data/NIS_1995_HOSPITAL_TrendWt.dta"
	keep if _merge==3
	drop _merge
	rename hospid psuid
	save "$dd/is1995.dta", replace
	clear
	use "$dd/is1995.dta", clear
	rename trendwt discwt
	save "$dd/is1995.dta", replace
	
	clear
	use "$dd/is1996.dta", clear
	rename psuid hospid
	mmerge hospid using "$dpp/yr1996dataprep/01_stata/data/NIS_1996_HOSPITAL_TrendWt.dta"
	keep if _merge==3
	drop _merge
	rename hospid psuid
	save "$dd/is1996.dta", replace
	clear
	use "$dd/is1996.dta", clear
	rename trendwt discwt
	save "$dd/is1996.dta", replace
	
	clear
	use "$dd/is1997.dta", clear
	rename psuid hospid
	mmerge hospid using "$dpp/yr1997dataprep/01_stata/data/NIS_1997_HOSPITAL_TrendWt.dta"
	keep if _merge==3
	drop _merge
	rename hospid psuid
	save "$dd/is1997.dta", replace
	clear
	use "$dd/is1997.dta", clear
	drop discwt
	rename trendwt discwt
	save "$dd/is1997.dta", replace
	
	clear
	use "$dd/is1998.dta", clear
	rename psuid hospid
	mmerge hospid using "$dpp/yr1998dataprep/01_stata/data/NIS_1998_HOSPITAL_TrendWt.dta"
	keep if _merge==3
	drop _merge
	rename hospid psuid
	save "$dd/is1998.dta", replace
	clear
	use "$dd/is1998.dta", clear
	drop discwt
	rename trendwt discwt
	save "$dd/is1998.dta", replace
	
	clear
	use "$dd/is1999.dta", clear
	rename psuid hospid
	mmerge hospid using "$dpp/yr1999dataprep/01_stata/data/NIS_1999_HOSPITAL_TrendWt.dta"
	keep if _merge==3
	drop _merge
	rename hospid psuid
	save "$dd/is1999.dta", replace
	clear
	use "$dd/is1999.dta", clear
	drop discwt
	rename trendwt discwt
	save "$dd/is1999.dta", replace
	
	clear
	use "$dd/is2000.dta", clear
	rename psuid hospid
	mmerge hospid using "$dpp/yr2000dataprep/01_stata/data/NIS_2000_HOSPITAL_TrendWt.dta"
	keep if _merge==3
	drop _merge
	rename hospid psuid
	save "$dd/is2000.dta", replace
	clear
	use "$dd/is2000.dta", clear
	drop discwt
	rename trendwt discwt
	save "$dd/is2000.dta", replace
	
	clear
	use "$dd/is2001.dta", clear
	rename psuid hospid
	mmerge hospid using "$dpp/yr2001dataprep/01_stata/data/NIS_2001_HOSPITAL_TrendWt.dta"
	keep if _merge==3
	drop _merge
	rename hospid psuid
	save "$dd/is2001.dta", replace
	clear
	use "$dd/is2001.dta", clear
	drop discwt
	rename trendwt discwt
	save "$dd/is2001.dta", replace
	
	clear
	use "$dd/is2002.dta", clear
	rename psuid hospid
	mmerge hospid using "$dpp/yr2002dataprep/01_stata/data/NIS_2002_HOSPITAL_TrendWt.dta"
	keep if _merge==3
	drop _merge
	rename hospid psuid
	save "$dd/is2002.dta", replace
	clear
	use "$dd/is2002.dta", clear
	drop discwt
	rename trendwt discwt
	save "$dd/is2002.dta", replace
	
	clear
	use "$dd/is2003.dta", clear
	rename psuid hospid
	mmerge hospid using "$dpp/yr2003dataprep/01_stata/data/NIS_2003_HOSPITAL_TrendWt.dta"
	keep if _merge==3
	drop _merge
	rename hospid psuid
	save "$dd/is2003.dta", replace
	clear
	use "$dd/is2003.dta", clear
	drop discwt
	rename trendwt discwt
	save "$dd/is2003.dta", replace
	
	clear
	use "$dd/is2004.dta", clear
	rename psuid hospid
	mmerge hospid using "$dpp/yr2004dataprep/00_stata/data/NIS_2004_HOSPITAL_TrendWt.dta"
	keep if _merge==3
	drop _merge
	rename hospid psuid
	save "$dd/is2004.dta", replace
	clear
	use "$dd/is2004.dta", clear
	drop discwt
	rename trendwt discwt
	save "$dd/is2004.dta", replace
	
	clear
	use "$dd/is2005.dta", clear
	rename psuid hospid
	mmerge hospid using "$dpp/yr2005dataprep/00_stata/data/NIS_2005_HOSPITAL_TrendWt.dta"
	keep if _merge==3
	drop _merge
	rename hospid psuid
	save "$dd/is2005.dta", replace
	clear
	use "$dd/is2005.dta", clear
	drop discwt
	rename trendwt discwt
	save "$dd/is2005.dta", replace
	
	clear
	use "$dd/is2006.dta", clear
	rename psuid hospid
	mmerge hospid using "$dpp/yr2006dataprep/00_stata/data/NIS_2006_HOSPITAL_TrendWt.dta"
	keep if _merge==3
	drop _merge
	rename hospid psuid
	save "$dd/is2006.dta", replace
	clear
	use "$dd/is2006.dta", clear
	drop discwt
	rename trendwt discwt
	save "$dd/is2006.dta", replace
	
	clear
	use "$dd/is2007.dta", clear
	rename psuid hospid
	mmerge hospid using "$dpp/yr2007dataprep/00_stata/data/NIS_2007_HOSPITAL_TrendWt.dta"
	keep if _merge==3
	drop _merge
	rename hospid psuid
	save "$dd/is2007.dta", replace
	clear
	use "$dd/is2007.dta", clear
	drop discwt
	rename trendwt discwt
	save "$dd/is2007.dta", replace
	
	clear
	use "$dd/is2008.dta", clear
	rename psuid hospid
	mmerge hospid using "$dpp/yr2008dataprep/00_stata/data/NIS_2008_HOSPITAL_TrendWt.dta"
	keep if _merge==3
	drop _merge
	rename hospid psuid
	save "$dd/is2008.dta", replace
	clear
	use "$dd/is2008.dta", clear
	drop discwt
	rename trendwt discwt
	save "$dd/is2008.dta", replace
	
	clear
	use "$dd/is2009.dta", clear
	rename psuid hospid
	mmerge hospid using "$dpp/yr2009dataprep/00_stata/data/NIS_2009_HOSPITAL_TrendWt.dta"
	keep if _merge==3
	drop _merge
	rename hospid psuid
	save "$dd/is2009.dta", replace
	clear
	use "$dd/is2009.dta", clear
	drop discwt
	rename trendwt discwt
	save "$dd/is2009.dta", replace
	
	clear
	use "$dd/is2010.dta", clear
	rename psuid hospid
	mmerge hospid using "$dpp/yr2010dataprep/00_stata/data/NIS_2010_HOSPITAL_TrendWt.dta"
	keep if _merge==3
	drop _merge
	rename hospid psuid
	save "$dd/is2010.dta", replace
	clear
	use "$dd/is2010.dta", clear
	drop discwt
	rename trendwt discwt
	save "$dd/is2010.dta", replace
	
	clear
	use "$dd/is2011.dta", clear
	rename psuid hospid
	mmerge hospid using "$dpp/yr2011dataprep/00_stata/data/NIS_2011_HOSPITAL_TrendWt.dta"
	keep if _merge==3
	drop _merge
	rename hospid psuid
	save "$dd/is2011.dta", replace
	clear
	use "$dd/is2011.dta", clear
	drop discwt
	rename trendwt discwt
	save "$dd/is2011.dta", replace

*****************************************************************************

	* STEP 3: APPEND ALL PRT DATASETS FROM 1993 TO 2013
	
	clear
	use "$dd/is1993.dta", clear
	gen key=_n
	append using "$dd/is1994.dta"
	replace key=_n if key==.
	append using "$dd/is1995.dta"
	replace key=_n if key==.
	append using "$dd/is1996.dta"
	replace key=_n if key==.
	append using "$dd/is1997.dta"
	replace key=_n if key==.
	rename stratum nis_stratum
	append using "$dd/is1998.dta"
	append using "$dd/is1999.dta"
	append using "$dd/is2000.dta"
	append using "$dd/is2001.dta"
	append using "$dd/is2002.dta"
	append using "$dd/is2003.dta"
	append using "$dd/is2004.dta"
	append using "$dd/is2005.dta"
	append using "$dd/is2006.dta"
	append using "$dd/is2007.dta"
	append using "$dd/is2008.dta"
	append using "$dd/is2009.dta"
	append using "$dd/is2010.dta"
	append using "$dd/is2011.dta"
	append using "$dd/is2012.dta"
	append using "$dd/is2013.dta"
	rename nis_stratum stratum
	
	tab year, m
	replace year=1993 if year==93
	replace year=1994 if year==94
	replace year=1995 if year==95
	replace year=1996 if year==96
	replace year=1997 if year==97
	tab year, m
	
	save"$dd/is_all.dta",replace
		
	* unique id
	
	sort year key
	egen unid=group(year key)
		
	drop _merge
	
	* race-(1) white, (2) black, (3) Hispanic, (4) Asian or Pacific Islander, (5) Native American, (6) other			
	gen racecat=race
	replace racecat=4 if race==4 | race==5 | race==6 
	replace racecat=5 if racecat==.
	tab1 race racecat, m
	
	* pay1- (1) Medicare, (2) Medicaid, (3) private including HMO, (4) self-pay, (5) no charge, (6) other
	tab pay1, m
	tab pay1 race, m ro
	gen pay3=0 if pay1 == 3
	replace pay3=0 if pay1 == 1
	replace pay3=1 if pay1 == 4
	replace pay3=2 if pay1 == 2 | pay1 == 5 | pay1 ==6
	label define pay3 0 "private/medicare" 1 "self-pay" 2 "medicaid/nocharge/other"
	label value pay3 pay3
	tab pay1 pay3, m
	tab year pay3, m
	
	* income quartile: Already defined
	replace zipinc_qrtl=zipinc if year==1998 | year==1999 | year==2000 | year==2001 | year==2002
	replace zipinc_qrtl=1 if (zipinc8==1 | zipinc8==2 | zipinc8==3) & (year==1993 | year==1994 | year==1995 | year==1996 | year==1997) 
	replace zipinc_qrtl=2 if (zipinc8==4 | zipinc8==5) & (year==1993 | year==1994 | year==1995 | year==1996 | year==1997) 
	replace zipinc_qrtl=3 if (zipinc8==6 | zipinc8==7) & (year==1993 | year==1994 | year==1995 | year==1996 | year==1997) 
	replace zipinc_qrtl=4 if (zipinc8==8) & (year==1993 | year==1994 | year==1995 | year==1996 | year==1997) 
	tab year zipinc_qrtl, m	
	
	label define zipinc_qrtl 1 "$1-$24,999" 2 "$25,000-$34,999" 3 "$35,000-$44,999" 4 "$45,000+"
	label value zipinc_qrtl zipinc_qrtl
	tab year zipinc_qrtl, m
		
	* low inc
	gen loinc=1 if zipinc_qrtl==1 
	replace loinc=0 if zipinc_qrtl==2 | zipinc_qrtl==3 | zipinc_qrtl==4
	tab year loinc, m
	
	* age - 5 categories
	gen agecat4=0 if age!=. & age<=15
	replace agecat4=1 if age>15 & age<=25
	replace agecat4=2 if age>25 & age<=45
	replace agecat4=3 if age>45 & age<=60
	replace agecat4=4 if age>60 & age!=.
	label define agecat4 0 "0-15" 1 "16-25" 2 "26-45" 3 "46-60" 4 "61+"
	label value agecat4 agecat4	
	tab year agecat4, m
	
	* age - 3 categories
	gen agecat3 = 1 if age!=. & age<=15
	replace agecat3 = 2 if age>15 & age<=45
	replace agecat3 = 3 if age>45 & age!=.
	tab agecat3, m
	
			
	* CREATE HOSPITAL COVARIATE CATEGORIES
	
	*Hospital bed size
	tab hosp_bedsize, m
	replace hosp_bedsize= h_bedsz if year==1993 | year==1994 | year==1995 | year==1996 | year==1997
	tab year hosp_bedsize, m
			
	label define hosp_bedsize 1 "small" 2 "medium" 3 "large"
	label value hosp_bedsize hosp_bedsize 
		
	*Teaching Status
	tab hosp_teach
	replace hosp_teach=h_tch if year==1993 | year==1994 | year==1995 | year==1996 | year==1997
	replace hosp_teach=0 if (year==2012 | year==2013) & (hosp_locteach==2)
	replace hosp_teach=1 if (year==2012 | year==2013) & (hosp_locteach==3)
	label define hosp_teach 0 "nonteaching" 1 "teaching"
	label value hosp_teach hosp_teach 
	tab year hosp_teach, m ro
	
	*Urban vs. Rural
	replace hosp_location=h_loc if year==1993 | year==1994 | year==1995 | year==1996 | year==1997
	replace hosp_location=0 if (year==2012 | year==2013) & (hosp_locteach==1)
	replace hosp_location=1 if (year==2012 | year==2013) & (hosp_locteach==2 | hosp_locteach==3)
	label define hosp_location 0 "rural" 1 "urban"
	label value hosp_location hosp_location
	tab year hosp_location, m ro
	
	* hospital region
	replace hosp_region=h_region if year==1993 | year==1994 | year==1995 | year==1996 | year==1997
	label define hosp_region 1 "northeast" 2 "midwest" 3 "south" 4 "west"
	label value hosp_region hosp_region
	tab year hosp_region, m
	
	* Hospital zip: What are we doing again with this?
	* we decided to not use this, shospital characteristis
		
	*CREATE OUTCOME
	
	*in-hospital Death
	tab died, m
		
	gen death= 0 if died==0
	replace death=1 if died==1
	*label define yn 1 "yes" 0 "no"
	label value death yn
	tab death, m
		
	*LOS
	sum los, d
		
	* discharge outcome
	* dispuniform-Disposition of patient, uniform coding used beginning in 1998:
	*(1) routine, (2) transfer to short term hospital, 
	* (5) other transfers, including skilled nursing facility, intermediate care, and another type of facility, 
	*(6) home health care, (7) against medical advice, (20) died in hospital, 
	* (99) discharged alive, destination unknown
	* Disposition of patient, uniform coding used prior to 1998: 
	* (1) routine, (2) short-term hospital, (3) skilled nursing facility, 
	* (4) intermediate care facility, (5) another type of facility, (6) home health care, 
	* (7) against medical advice, (20) died
	gen outc=0 if dispuniform==1 | dispuniform==99
	replace outc=1 if dispuniform==2 | dispuniform==5 | dispuniform==6 | dispuniform==7 
	replace outc=2 if died==1
	tab outc, m
	
	* total chg
	sum totchg
		
	* states
	tab hospst, m
	gen state=1 if hospst=="AK"
	replace state=2 if hospst=="AR"
	replace state=3 if hospst=="AZ"
	replace state=4 if hospst=="CA"
	replace state=5 if hospst=="CO"
	replace state=6 if hospst=="CT"
	replace state=7 if hospst=="FL"
	replace state=8 if hospst=="GA"
	replace state=9 if hospst=="HI"
	replace state=10 if hospst=="IA"
	replace state=11 if hospst=="IL"
	replace state=12 if hospst=="IN"
	replace state=13 if hospst=="KS"
	replace state=14 if hospst=="KY"
	replace state=15 if hospst=="LA"
	replace state=16 if hospst=="MA"
	replace state=17 if hospst=="MD"
	replace state=18 if hospst=="ME"
	replace state=19 if hospst=="MI"
	replace state=20 if hospst=="MN"
	replace state=21 if hospst=="MO"
	replace state=22 if hospst=="MS"
	replace state=23 if hospst=="MT"
	replace state=24 if hospst=="NC"
	replace state=25 if hospst=="ND"
	replace state=26 if hospst=="NE"
	replace state=27 if hospst=="NH"
	replace state=28 if hospst=="NJ"
	replace state=29 if hospst=="NM"
	replace state=30 if hospst=="NV"
	replace state=31 if hospst=="NY"
	replace state=32 if hospst=="OH"
	replace state=33 if hospst=="OK"
	replace state=34 if hospst=="OR"
	replace state=35 if hospst=="PA"
	replace state=36 if hospst=="RI"
	replace state=37 if hospst=="SC"
	replace state=38 if hospst=="SD"
	replace state=39 if hospst=="TN"
	replace state=40 if hospst=="TX"
	replace state=41 if hospst=="UT"
	replace state=42 if hospst=="VA"
	replace state=43 if hospst=="VT"
	replace state=44 if hospst=="WA"
	replace state=45 if hospst=="WI"
	replace state=46 if hospst=="WV"
	replace state=47 if hospst=="WY"
	
	* hospstco
	tab hospstco, m
	tab hospst if hospstco==.
	
	* identifying hospitalization after ED
	*asource- (1) ER (2) another hospital,(3) another facility including long-term care, 
	* (4) court/law enforcement, (5) routine/birth/other 
	tab year asource, m, 
	* atype- (1) emergency, (2) urgent, (3) elective, (4) newborn, (5) Delivery (coded in 1988-1997 data only), 
	* (5) trauma center beginning in 2003 data, (6) other
	tab asource atype, m
	tab year atype, m
	
	* admission from where
	tab atype, m
	label define atype 1 "emergency" 2 "urgent" 3 "elective" 4 "newborn" 5 "trauma center" 6 "other"
	label value atype atype
	tab year atype, m
	gen fromer=1 if asource==1 | atype==1
	replace fromer=1 if atype==5 & (year>=2003 & year<=2011)
	replace fromer=0 if fromer==.
	tab year fromer , m ro
	
	* hcup_Ed: Indicator that discharge record includes evidence of emergency department (ED) services: 
	*(0) Record does not meet any HCUP Emergency Department criteria, 
	* (1) Emergency Department revenue code on record, 
	* (2) Positive Emergency Department charge (when revenue center codes are not available), 
	* (3) Emergency Department CPT procedure code on record, (4) Admission source of ED, 
	* (5) State- defined ED record; no ED charges available
	tab year hcup_ed , m ro
	tab fromer, m
	tab year fromer, m ro
	
	* build on fromer
	replace fromer=0 if (year>=2012) & hcup_ed==0
	replace fromer=1 if (year>=2012) & (hcup_ed==1 | hcup_ed==2 | hcup_ed==3 | hcup_ed==4)
	tab fromer, m
	tab year fromer, m ro
	
	* year categories
	gen yearcat = 1 if year >= 1993 & year <=1997 
	replace yearcat = 2 if year >= 1998 & year <= 2002
	replace yearcat = 3 if year >= 2003 & year <= 2007
	replace yearcat = 4 if year >= 2008 & year <=2013
	tab yearcat, m
	
	* include legal under assault 
	replace types=1 if types == 5
	tab types, m
	
	* gender or sex
	* available as sex (1=male, 2=female) from 1993 to 1997
	* avaliable as female (0=male, 1=female) from 1998 to 2013
	* harmonization- 
	replace female=1 if sex==2 & (year<1998)
	replace female=0 if sex==1 & (year<1998)
	
	* keep only index hospitalizatin, those directly from ER
	keep if fromer==1
	
	save "$dd/isall.dta", replace

*****************************************************************************
	
	* ASSESSING STRATUM
	
	clear
	use "$dd/isall.dta", clear
	
	svyset psuid [pweight= discwt], strata(stratum)
	svydes 
	
	gen stratum_n=stratum
	replace  stratum_n=1032 if (stratum>=1011 & stratum<=1032)
	replace  stratum_n=1033 if stratum==1033
	replace  stratum_n=1332 if (stratum>=1111 & stratum<=1332)
	replace  stratum_n=2032 if (stratum>=2021 & stratum<=2032)
	replace  stratum_n=2033 if stratum==2033
	replace  stratum_n=2413 if (stratum>=2111 & stratum<=2413)
	replace  stratum_n=3032 if (stratum>=3031 & stratum<=3032)
	replace  stratum_n=3033 if stratum==3033
	replace  stratum_n=3133 if (stratum>=3111 & stratum<=3133)
	replace  stratum_n=3233 if (stratum>=3211 & stratum<=3233)
	replace  stratum_n=3333 if (stratum>=3311 & stratum<=3333)
	replace  stratum_n=4033 if (stratum>=4031 & stratum<=4033)
	replace  stratum_n=4133 if (stratum>=4111 & stratum<=4133)
	replace  stratum_n=4413 if (stratum>=4211 & stratum<=4413)
	replace  stratum_n=6333 if (stratum>=5111 & stratum<=6333)
	replace  stratum_n=9332 if stratum>=7111
	
	svyset psuid [pweight= discwt], strata(stratum_n)
	svydes 
	bysort year : count if stratum ==.
	*/
	save "$dd/isall_n.dta", replace

*****************************************************************************
		
	* CREATE DATASET for creating comorbidity variables in years 1993 to 2001
	
	clear
	use "$dd/isall_n.dta", clear
	drop if year>2001
	
	* saved the data into a lower version
	saveold "$dd/isall_cm.dta", replace
	
	* SCC has a poor SAS environment. Therefore, this statdata () was downloaded into google drive and worked on SAS.
	* C:\Users\zuoyi\Google Drive\Current Projects\36_14_Injuryseverity\09_Analysis\03_stata\data\isall_cm.dta
	* files used: 
	* the SAS analysis
	/*
	/* convert SAS data file into STATA data file*/
	proc export data=OUT1.ANALYSIS
	dbms=dta
	*outfile='C:\Users\zuoyi\Google Drive\Current Projects\36_14_Injuryseverity\09_Analysis\03_stata\data\cm_data_created.dta' replace;
	*run;
	*/
	
*****************************************************************************

	* MERGE THE COMORBIDITY DATA FROM 1993 TO 2001 TO THE ORIGINAL DATASET
	
	clear
	use "$dd/isall_n.dta", clear
	mmerge key year using "$dd/cm_data_created.dta"
	
	replace cm_chf=chf if year<2002
	for var valve pulmcirc perivasc para neuro chrnlung dm dmcx hypothy ///
	renlfail liver ulcer aids lymph mets tumor arth coag obese wghtloss lytes ///
	bldloss anemdef alcohol drug psych depress htn_c ///
	: replace cm_X=X if year<2002
	
	save "$dd/isall_n_cm.dta", replace
	
	**********************************************************************

	* ASSESSING INJURY SEVERITY
	
	clear
	use "$dd/isall_n.dta", clear
	keep dx1 dx2 dx3 dx4 dx5 dx6 dx7 dx8 dx9 dx10 dx11 dx12 dx13 dx14 dx15 dx16 dx17 dx18 dx19 dx20 dx21 dx22 dx23 dx24 dx25 ///
	psuid discwt stratum stratum_n year gunshot assault accident suicide uintent legal war types racecat outc age agecat3
	order dx1 dx2 dx3 dx4 dx5 dx6 dx7 dx8 dx9 dx10 dx11 dx12 dx13 dx14 dx15 dx16 dx17 dx18 dx19 dx20 dx21 dx22 dx23 dx24 dx25 ///
	psuid discwt stratum stratum_n year gunshot assault accident suicide uintent legal war types racecat outc age agecat3
	save "$dd/isall_r.dta", replace

*****************************************************************************
	*db icdpic
	
	*db trauma
	clear
	trauma "/projectnb/msmathypo/36_14_Injuryseverity/09_Analysis/03_stata/data/isall_r.dta" ///
	"/projectnb/msmathypo/36_14_Injuryseverity/09_Analysis/03_stata/data/isall_r_trauma.dta" 1 1 dx
	
	clear
	use "$dd/isall_r_trauma.dta", clear
	
	**********************************************************************
	
	clear
	use "$dd/isall_r_trauma.dta", clear
	replace niss = . if niss == 0 | niss == 99
	tab niss, m
	save "$dd/isall_r_trauma.dta",replace
		
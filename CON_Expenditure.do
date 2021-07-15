*-------------------------------------------------------------------------------
* Estimating the Impact of Certificate of Need Laws on Expenditure: A Synthetic Control Approach
* ------------------------------------------------------------------------------
clear

* Setting Env Variables
global directory: env HealthExpenditureDirectory

* Setting Directory
cd "$directory"


* Setting Globals
global controls "income_pcp_adj pop_density unemp_rate top1_adj gini prop_age_25to45_bsy prop_age_45to65_bsy prop_age_over65_bsy prop_bach_degree_bsy prop_male_bsy prop_married_bsy prop_white_bsy"

*-------------------------------------------------------------------------------
* Total Health Expenditure - Clean up
* ------------------------------------------------------------------------------

insheet using "PROV_US_AGGREGATE14.csv"

* Creating fips state id
{ 
	rename state_name state
	gen id = .
replace id = 1 if state=="Alabama"
replace id = 2 if state=="Alaska"
replace id = 4 if state=="Arizona"
replace id = 5 if state=="Arkansas"
replace id = 6 if state=="California"
replace id = 8 if state=="Colorado"
replace id = 9 if state=="Connecticut"
replace id = 10 if state=="Delaware"
replace id = 11 if state=="District of Columbia"
replace id = 12 if state=="Florida"
replace id = 13 if state=="Georgia"
replace id = 15 if state=="Hawaii"
replace id = 16 if state=="Idaho"
replace id = 17 if state=="Illinois"
replace id = 18 if state=="Indiana"
replace id = 19 if state=="Iowa"
replace id = 20 if state=="Kansas"
replace id = 21 if state=="Kentucky"
replace id = 22 if state=="Louisiana"
replace id = 23 if state=="Maine"
replace id = 24 if state=="Maryland"
replace id = 25 if state=="Massachusetts"
replace id = 26 if state=="Michigan"
replace id = 27 if state=="Minnesota"
replace id = 28 if state=="Mississippi"
replace id = 29 if state=="Missouri"
replace id = 30 if state=="Montana"
replace id = 31 if state=="Nebraska"
replace id = 32 if state=="Nevada"
replace id = 33 if state=="New Hampshire"
replace id = 34 if state=="New Jersey"
replace id = 35 if state=="New Mexico"
replace id = 36 if state=="New York"
replace id = 37 if state=="North Carolina"
replace id = 38 if state=="North Dakota"
replace id = 39 if state=="Ohio"
replace id = 40 if state=="Oklahoma"
replace id = 41 if state=="Oregon"
replace id = 42 if state=="Pennsylvania"
replace id = 44 if state=="Rhode Island"
replace id = 45 if state=="South Carolina"
replace id = 46 if state=="South Dakota"
replace id = 47 if state=="Tennessee"
replace id = 48 if state=="Texas"
replace id = 49 if state=="Utah"
replace id = 50 if state=="Vermont"
replace id = 51 if state=="Virginia"
replace id = 53 if state=="Washington"
replace id = 54 if state=="West Virginia"
replace id = 55 if state=="Wisconsin"
replace id = 56 if state=="Wyoming"
}

* Reshape data
drop if id==.
reshape long y, i(id code) j(year)

* Drop and rename variables
rename y total_spending 
drop average_annual_percent_growth
drop item
drop state

* Saving total health expenditure data
save TotalHealthSpending, replace


*-------------------------------------------------------------------------------
* Medicare - Clean up
* ------------------------------------------------------------------------------
clear
insheet using "PROV_MEDICARE_AGGREGATE14.csv"

* Creating fips state id
{ 
	rename state_name state
	gen id = .
replace id = 1 if state=="Alabama"
replace id = 2 if state=="Alaska"
replace id = 4 if state=="Arizona"
replace id = 5 if state=="Arkansas"
replace id = 6 if state=="California"
replace id = 8 if state=="Colorado"
replace id = 9 if state=="Connecticut"
replace id = 10 if state=="Delaware"
replace id = 11 if state=="District of Columbia"
replace id = 12 if state=="Florida"
replace id = 13 if state=="Georgia"
replace id = 15 if state=="Hawaii"
replace id = 16 if state=="Idaho"
replace id = 17 if state=="Illinois"
replace id = 18 if state=="Indiana"
replace id = 19 if state=="Iowa"
replace id = 20 if state=="Kansas"
replace id = 21 if state=="Kentucky"
replace id = 22 if state=="Louisiana"
replace id = 23 if state=="Maine"
replace id = 24 if state=="Maryland"
replace id = 25 if state=="Massachusetts"
replace id = 26 if state=="Michigan"
replace id = 27 if state=="Minnesota"
replace id = 28 if state=="Mississippi"
replace id = 29 if state=="Missouri"
replace id = 30 if state=="Montana"
replace id = 31 if state=="Nebraska"
replace id = 32 if state=="Nevada"
replace id = 33 if state=="New Hampshire"
replace id = 34 if state=="New Jersey"
replace id = 35 if state=="New Mexico"
replace id = 36 if state=="New York"
replace id = 37 if state=="North Carolina"
replace id = 38 if state=="North Dakota"
replace id = 39 if state=="Ohio"
replace id = 40 if state=="Oklahoma"
replace id = 41 if state=="Oregon"
replace id = 42 if state=="Pennsylvania"
replace id = 44 if state=="Rhode Island"
replace id = 45 if state=="South Carolina"
replace id = 46 if state=="South Dakota"
replace id = 47 if state=="Tennessee"
replace id = 48 if state=="Texas"
replace id = 49 if state=="Utah"
replace id = 50 if state=="Vermont"
replace id = 51 if state=="Virginia"
replace id = 53 if state=="Washington"
replace id = 54 if state=="West Virginia"
replace id = 55 if state=="Wisconsin"
replace id = 56 if state=="Wyoming"
}

* Reshape data
drop if id==.
reshape long y, i(id code) j(year)

* Drop and rename variables
rename y medicare_spending 
drop average_annual_percent_growth
drop item
drop state

* Saving total health expenditure data
save MedicareSpending, replace


*-------------------------------------------------------------------------------
* Medicaid Expenditure - Clean up
* ------------------------------------------------------------------------------
clear
insheet using "PROV_MEDICAID_AGGREGATE14.csv"

* Creating fips state id
{ 
	rename state_name state
	gen id = .
replace id = 1 if state=="Alabama"
replace id = 2 if state=="Alaska"
replace id = 4 if state=="Arizona"
replace id = 5 if state=="Arkansas"
replace id = 6 if state=="California"
replace id = 8 if state=="Colorado"
replace id = 9 if state=="Connecticut"
replace id = 10 if state=="Delaware"
replace id = 11 if state=="District of Columbia"
replace id = 12 if state=="Florida"
replace id = 13 if state=="Georgia"
replace id = 15 if state=="Hawaii"
replace id = 16 if state=="Idaho"
replace id = 17 if state=="Illinois"
replace id = 18 if state=="Indiana"
replace id = 19 if state=="Iowa"
replace id = 20 if state=="Kansas"
replace id = 21 if state=="Kentucky"
replace id = 22 if state=="Louisiana"
replace id = 23 if state=="Maine"
replace id = 24 if state=="Maryland"
replace id = 25 if state=="Massachusetts"
replace id = 26 if state=="Michigan"
replace id = 27 if state=="Minnesota"
replace id = 28 if state=="Mississippi"
replace id = 29 if state=="Missouri"
replace id = 30 if state=="Montana"
replace id = 31 if state=="Nebraska"
replace id = 32 if state=="Nevada"
replace id = 33 if state=="New Hampshire"
replace id = 34 if state=="New Jersey"
replace id = 35 if state=="New Mexico"
replace id = 36 if state=="New York"
replace id = 37 if state=="North Carolina"
replace id = 38 if state=="North Dakota"
replace id = 39 if state=="Ohio"
replace id = 40 if state=="Oklahoma"
replace id = 41 if state=="Oregon"
replace id = 42 if state=="Pennsylvania"
replace id = 44 if state=="Rhode Island"
replace id = 45 if state=="South Carolina"
replace id = 46 if state=="South Dakota"
replace id = 47 if state=="Tennessee"
replace id = 48 if state=="Texas"
replace id = 49 if state=="Utah"
replace id = 50 if state=="Vermont"
replace id = 51 if state=="Virginia"
replace id = 53 if state=="Washington"
replace id = 54 if state=="West Virginia"
replace id = 55 if state=="Wisconsin"
replace id = 56 if state=="Wyoming"
}

* Reshape data
drop if id==.
reshape long y, i(id code) j(year)

* Drop and rename variables
rename y medicaid_spending 
drop average_annual_percent_growth
drop item
drop state

* Saving total health expenditure data
save MedicaidSpending, replace

*-------------------------------------------------------------------------------
* Merging Data on Total, Medicare, and Medicaid Spending
* ------------------------------------------------------------------------------

clear
use "TotalHealthSpending.dta"

* Merging datasets
merge 1:1 id year code using MedicareSpending.dta
drop _merge
merge 1:1 id year code using MedicaidSpending.dta
drop _merge

* Saving final data
save Health_Spending_Data, replace


*-------------------------------------------------------------------------------
* Loading population data and merging it with health exp data
* ------------------------------------------------------------------------------

clear 
insheet using "PopulationStates.csv"
reshape long pop, i(year) j(id)

* Saving Population data
save PopulationStates, replace

merge m:m id year using Health_Spending_Data.dta
drop if region_number==.
drop region_number
drop _merge 

* Creating spending per capita data
gen total_spending_pcp = total_spending/pop
gen medicare_spending_pcp = medicare_spending/pop
gen medicaid_spending_pcp = medicaid_spending/pop

drop group
drop region_name
save CON_Expenditure.dta, replace

*-------------------------------------------------------------------------------
* Loading CPI and adjusting health spendging levels for inflation (2015 prices)
* ------------------------------------------------------------------------------

clear 
insheet using "CPI_2015Prices.csv"

* Merging data with Exp. per capita data
merge m:m year using CON_Expenditure.dta
drop if _merge==1
       // only year 1960-1979 and 2015-2019 did not match

* Creating  expenditure per capita adjusted for inflation (2015 prices)

gen total_spending_pcp_adj = total_spending_pcp/cpi*100
gen medicare_spending_pcp_adj = medicare_spending_pcp/cpi*100
gen medicaid_spending_pcp_adj = medicaid_spending_pcp/cpi*100

* Dropping old expenditure variables
drop total_spending
drop total_spending_pcp
drop medicare_spending
drop medicare_spending_pcp
drop medicaid_spending
drop medicaid_spending_pcp

* Renaming expenditure variables
rename total_spending_pcp_adj total_exp
rename medicare_spending_pcp_adj medicare_exp
rename medicaid_spending_pcp_adj medicaid_exp

* Saving
drop _merge 
sort year id
save CON_Expenditure.dta, replace

*-------------------------------------------------------------------------------
* Merging Con data with cleaned Expenditure
* ------------------------------------------------------------------------------

clear 
insheet using "CON_Data.csv"
rename yearofrepeal repeal_y
reshape long con, i(id) j(year)
save CON_Data, replace

merge 1:m year id using CON_Expenditure.dta

* Droping Louisiana because it did not have CON laws until 1991 and then implemented it, so it does not work with our model
drop _merge 
save CON_Expenditure.dta, replace

*-------------------------------------------------------------------------------
* Merging with Income per Capita Data
* ------------------------------------------------------------------------------

clear 
insheet using "income_pcp.csv"

*clean up
keep if linecode==3
gen id=geofips/1000
drop geofips
drop geoname
drop linecode
drop description 

*Reshaping and saving income per capita data
reshape long i, i(id) j(year)
rename i income_pcp
save income_pct, replace

* Loading CPI and adjusting income per capita for inflation (2015 prices)
clear 
insheet using "CPI_2015Prices.csv"

* Merging data with Exp. per capita data
merge 1:m year using income_pct.dta
drop if _merge==2
       
* Creating  income per capita adjusted for inflation (2015 prices)
gen income_pcp_adj = .
replace income_pcp_adj = income_pcp/cpi*100

* Clean Up
drop income_pcp
drop _merge 
sort year id

merge 1:m year id using CON_Expenditure.dta
drop if _merge==1
drop _merge
save CON_Expenditure.dta, replace

* ------------------------------------------------------------------------------
* Merging with Gini Coefficients Data
* ------------------------------------------------------------------------------
clear 
insheet using "Gini.csv"

* Creating Fips id
{
	gen id = .
replace id = 1 if state=="Alabama"
replace id = 2 if state=="Alaska"
replace id = 4 if state=="Arizona"
replace id = 5 if state=="Arkansas"
replace id = 6 if state=="California"
replace id = 8 if state=="Colorado"
replace id = 9 if state=="Connecticut"
replace id = 10 if state=="Delaware"
replace id = 11 if state=="District of Columbia"
replace id = 12 if state=="Florida"
replace id = 13 if state=="Georgia"
replace id = 15 if state=="Hawaii"
replace id = 16 if state=="Idaho"
replace id = 17 if state=="Illinois"
replace id = 18 if state=="Indiana"
replace id = 19 if state=="Iowa"
replace id = 20 if state=="Kansas"
replace id = 21 if state=="Kentucky"
replace id = 22 if state=="Louisiana"
replace id = 23 if state=="Maine"
replace id = 24 if state=="Maryland"
replace id = 25 if state=="Massachusetts"
replace id = 26 if state=="Michigan"
replace id = 27 if state=="Minnesota"
replace id = 28 if state=="Mississippi"
replace id = 29 if state=="Missouri"
replace id = 30 if state=="Montana"
replace id = 31 if state=="Nebraska"
replace id = 32 if state=="Nevada"
replace id = 33 if state=="New Hampshire"
replace id = 34 if state=="New Jersey"
replace id = 35 if state=="New Mexico"
replace id = 36 if state=="New York"
replace id = 37 if state=="North Carolina"
replace id = 38 if state=="North Dakota"
replace id = 39 if state=="Ohio"
replace id = 40 if state=="Oklahoma"
replace id = 41 if state=="Oregon"
replace id = 42 if state=="Pennsylvania"
replace id = 44 if state=="Rhode Island"
replace id = 45 if state=="South Carolina"
replace id = 46 if state=="South Dakota"
replace id = 47 if state=="Tennessee"
replace id = 48 if state=="Texas"
replace id = 49 if state=="Utah"
replace id = 50 if state=="Vermont"
replace id = 51 if state=="Virginia"
replace id = 53 if state=="Washington"
replace id = 54 if state=="West Virginia"
replace id = 55 if state=="Wisconsin"
replace id = 56 if state=="Wyoming"
}

* Clean Up 
drop if id==.
rename Year year
keep year id gini

* Merging with current data
merge 1:m year id using CON_Expenditure.dta
drop if _merge==1
drop _merge

save CON_Expenditure.dta, replace

* ------------------------------------------------------------------------------
* Merging with Income Shares Data
* ------------------------------------------------------------------------------

clear 
insheet using "IncomeShares.csv"

* Creating Fips id
{
	gen id = .
replace id = 1 if state=="Alabama"
replace id = 2 if state=="Alaska"
replace id = 4 if state=="Arizona"
replace id = 5 if state=="Arkansas"
replace id = 6 if state=="California"
replace id = 8 if state=="Colorado"
replace id = 9 if state=="Connecticut"
replace id = 10 if state=="Delaware"
replace id = 11 if state=="District of Columbia"
replace id = 12 if state=="Florida"
replace id = 13 if state=="Georgia"
replace id = 15 if state=="Hawaii"
replace id = 16 if state=="Idaho"
replace id = 17 if state=="Illinois"
replace id = 18 if state=="Indiana"
replace id = 19 if state=="Iowa"
replace id = 20 if state=="Kansas"
replace id = 21 if state=="Kentucky"
replace id = 22 if state=="Louisiana"
replace id = 23 if state=="Maine"
replace id = 24 if state=="Maryland"
replace id = 25 if state=="Massachusetts"
replace id = 26 if state=="Michigan"
replace id = 27 if state=="Minnesota"
replace id = 28 if state=="Mississippi"
replace id = 29 if state=="Missouri"
replace id = 30 if state=="Montana"
replace id = 31 if state=="Nebraska"
replace id = 32 if state=="Nevada"
replace id = 33 if state=="New Hampshire"
replace id = 34 if state=="New Jersey"
replace id = 35 if state=="New Mexico"
replace id = 36 if state=="New York"
replace id = 37 if state=="North Carolina"
replace id = 38 if state=="North Dakota"
replace id = 39 if state=="Ohio"
replace id = 40 if state=="Oklahoma"
replace id = 41 if state=="Oregon"
replace id = 42 if state=="Pennsylvania"
replace id = 44 if state=="Rhode Island"
replace id = 45 if state=="South Carolina"
replace id = 46 if state=="South Dakota"
replace id = 47 if state=="Tennessee"
replace id = 48 if state=="Texas"
replace id = 49 if state=="Utah"
replace id = 50 if state=="Vermont"
replace id = 51 if state=="Virginia"
replace id = 53 if state=="Washington"
replace id = 54 if state=="West Virginia"
replace id = 55 if state=="Wisconsin"
replace id = 56 if state=="Wyoming"
}

* Clean Up 
drop if id==.
rename Year year
drop number state

* Merging with current data
merge 1:m year id using CON_Expenditure.dta
drop if _merge==1
drop _merge

save CON_Expenditure.dta, replace

* ------------------------------------------------------------------------------
* Merging with Unemployment Rate data
* ------------------------------------------------------------------------------

clear 
insheet using "Unemployment_states.csv"

* Clean up and Reshape
replace id = id/1000
drop area
reshape long u, i(id) j(year)
rename u unemp_rate
drop if id==0

* Merging with current data
merge 1:m year id using CON_Expenditure.dta
drop if _merge==1
drop _merge

save CON_Expenditure.dta, replace

* ------------------------------------------------------------------------------
* Merging with Population Density
* ------------------------------------------------------------------------------

clear 
insheet using "Area_States.csv"

* Creating Fips id

{
	rename State state
	gen id = .
replace id = 1 if state=="Alabama"
replace id = 2 if state=="Alaska"
replace id = 4 if state=="Arizona"
replace id = 5 if state=="Arkansas"
replace id = 6 if state=="California"
replace id = 8 if state=="Colorado"
replace id = 9 if state=="Connecticut"
replace id = 10 if state=="Delaware"
replace id = 11 if state=="District of Columbia"
replace id = 12 if state=="Florida"
replace id = 13 if state=="Georgia"
replace id = 15 if state=="Hawaii"
replace id = 16 if state=="Idaho"
replace id = 17 if state=="Illinois"
replace id = 18 if state=="Indiana"
replace id = 19 if state=="Iowa"
replace id = 20 if state=="Kansas"
replace id = 21 if state=="Kentucky"
replace id = 22 if state=="Louisiana"
replace id = 23 if state=="Maine"
replace id = 24 if state=="Maryland"
replace id = 25 if state=="Massachusetts"
replace id = 26 if state=="Michigan"
replace id = 27 if state=="Minnesota"
replace id = 28 if state=="Mississippi"
replace id = 29 if state=="Missouri"
replace id = 30 if state=="Montana"
replace id = 31 if state=="Nebraska"
replace id = 32 if state=="Nevada"
replace id = 33 if state=="New Hampshire"
replace id = 34 if state=="New Jersey"
replace id = 35 if state=="New Mexico"
replace id = 36 if state=="New York"
replace id = 37 if state=="North Carolina"
replace id = 38 if state=="North Dakota"
replace id = 39 if state=="Ohio"
replace id = 40 if state=="Oklahoma"
replace id = 41 if state=="Oregon"
replace id = 42 if state=="Pennsylvania"
replace id = 44 if state=="Rhode Island"
replace id = 45 if state=="South Carolina"
replace id = 46 if state=="South Dakota"
replace id = 47 if state=="Tennessee"
replace id = 48 if state=="Texas"
replace id = 49 if state=="Utah"
replace id = 50 if state=="Vermont"
replace id = 51 if state=="Virginia"
replace id = 53 if state=="Washington"
replace id = 54 if state=="West Virginia"
replace id = 55 if state=="Wisconsin"
replace id = 56 if state=="Wyoming"
}

keep id landarea
merge 1:m id using CON_Expenditure.dta
drop _merge

gen pop_density = pop/landarea

* ------------------------------------------------------------------------------
* Merging with Demographic Controls - ASEC
* ------------------------------------------------------------------------------

rename id state
merge m:1 state year using ASEC_1980-2014_State.dta

rename state id
save CON_Expenditure.dta, replace


* ------------------------------------------------------------------------------
* Synthetic Control Estimates
* ------------------------------------------------------------------------------

* Installing Synth Command
*ssc install synth, replace all

/* Variable Code can be changed for different break downs of expenditure data:
1 = Total Personal Health Care
2 = Hopital Care
3 = Physician & Clinical Services
6 = Home Health Care
9 = Durable Medical Products
10 = Nursing Home Care 
*/


* ------------------------------------------------------------------------------
* Preparing Data for Graphs from Synthetic control analysis
* ------------------------------------------------------------------------------

clear 
use CON_Expenditure.dta

replace total_exp = total_exp*1000
replace medicare_exp = medicare_exp*1000
replace medicaid_exp = medicaid_exp*1000

save CON_Expenditure.dta, replace


* ------------------------------------------------------------------------------
* Pennsylvania Synthetic Control Analysis
* ------------------------------------------------------------------------------

*   ---Trend and Gap Graphs---
clear

local Exp_code "1 1 1 10 10 10 6 6 6 3 3 3 2 2 2"
local Exp_code_name_one " "Health" "Health" "Health" "Nursing Home" "Nursing Home" "Nursing Home" "Home Care" "Home Care" "Home Care" "Physician and Clinical Services" "Physician and Clinical Services" "Physician and Clinical Services" "Hospital" "Hospital" "Hospital" "
local Exp_code_name_two " "Total_Health" "Total_Health" "Total_Health" "Nursing_Home" "Nursing_Home" "Nursing_Home" "Home_Care" "Home_Care" "Home_Care" "Physician" "Physician" "Physician" "Hospital" "Hospital" "Hospital" "
local Exp_type " "total_exp" "medicaid_exp" "medicare_exp" "total_exp" "medicaid_exp" "medicare_exp" "total_exp" "medicaid_exp" "medicare_exp" "total_exp" "medicaid_exp" "medicare_exp" "total_exp" "medicaid_exp" "medicare_exp" "
local Exp_type_name " "Total" "Medicaid" "Medicare" "Total" "Medicaid" "Medicare" "Total" "Medicaid" "Medicare" "Total" "Medicaid" "Medicare" "Total" "Medicaid" "Medicare" "

forvalues i = 1/15 {
	*setting up local macros to refer to the current element in the parallel lists being looped through
	local exp_code : word `i' of `Exp_code'
	local exp_code_name_one : word `i' of `Exp_code_name_one'
	local exp_code_name_two : word `i' of `Exp_code_name_two'
	local exp_type : word `i' of `Exp_type'
	local exp_type_name : word `i' of `Exp_type_name'
		
	*load fresh data
	use CON_Expenditure.dta, clear
	replace medicare_exp = 0.01 if medicare_exp == 0	/* to avoid the unstable or asymmetric Hessian error */
	
	*Restrict to PA and Control States by expenditure type
	keep if code == `exp_code'
	keep if alwaysconpa==1 | repeal_y=="1996"
	
	*declare data as a time series with year as time variable (required for synth command)
	tsset id year
		
	*Create synthetic control
	# delimit
		quietly synth `exp_type' $controls 
		`exp_type'(1989) `exp_type'(1988) `exp_type'(1987) `exp_type'(1986) `exp_type'(1985) 
		`exp_type'(1984) `exp_type'(1983) `exp_type'(1982) `exp_type'(1981) `exp_type'(1980), 
		trunit(42) trperiod(1996) nested
		keep(CON_Expenditure_PA\Synth_Output\synth_`exp_code_name_two'_`exp_type'.dta, replace);
	# delimit cr
	
	*Process synthetic control output
	use CON_Expenditure_PA\Synth_Output\synth_`exp_code_name_two'_`exp_type'.dta, clear
	rename _time year
	gen alpha = _Y_treated - _Y_synthetic
	keep year _Y_* alpha
	drop if missing(year)
	save CON_Expenditure_PA\Synth_Output\synth_`exp_code_name_two'_`exp_type'.dta, replace
	
	*Trend graphs
	# delimit
	twoway
		(line _Y_treated year, lwidth(medthick) lcolor(black) xline(1995, lwidth(thick) lcolor(gs10)) )
		(line _Y_synthetic year, lwidth(medthick) lpattern(dash) lcolor(black))
		,
		leg(lab(1 "Pennsylvania") lab(2 "Synthetic Pennsylvania") size(medsmall) order(1 2) pos(11) ring(0) cols(1))
		xtitle("Year") xlab(1980[5]2014, grid glcolor(gs15))
		ytitle("`exp_type_name' `exp_code_name_one' Expenditure Per Capita") ylab(, grid glcolor(gs15))
		graphregion(color(white)) bgcolor(white) plotregion(color(white));
	# delimit cr
	graph export CON_Expenditure_PA\Figures\\`exp_code_name_two'_`exp_type'_Trends.pdf, replace
	
	*Gap graphs
	# delimit
	twoway
		(line alpha year, lwidth(medthick) lcolor(black) xline(1995, lwidth(thick) lcolor(gs10)) yline(0, lwidth(thick) lcolor(gs10)))
		,
		legend(off)
		xtitle("Year") xlab(1980[5]2014, grid glcolor(gs15))
		ytitle("Gap in `exp_type_name' `exp_code_name_one' Expenditure Per Capita") ysc(r(-300 300)) ylab(-300(150)300, grid glcolor(gs15))
		graphregion(color(white)) bgcolor(white) plotregion(color(white));
	# delimit cr
	graph export CON_Expenditure_PA\Figures\\`exp_code_name_two'_`exp_type'_Gaps.pdf, replace
}



use CON_Expenditure.dta

keep if code == 1

tsset id year
keep if alwaysconpa==1 | repeal_y=="1996"

*   ---Total Expenditure Analysis---

*synth total_exp $controls total_exp(1995) total_exp(1990) total_exp(1984), trunit(42) trperiod(1996) nested fig
synth total_exp $controls total_exp(1989) total_exp(1988) total_exp(1987) total_exp(1986) total_exp(1985) total_exp(1984) total_exp(1983) total_exp(1982) total_exp(1981) total_exp(1980), trunit(42) trperiod(1996) nested fig

*   ---Medicaid Expenditure Analysis---

synth medicaid_exp $controls medicaid_exp(1995) medicaid_exp(1990) medicaid_exp(1984), trunit(42) trperiod(1996) nested fig
synth medicaid_exp $controls medicaid_exp(1989) medicaid_exp(1988) medicaid_exp(1987) medicaid_exp(1986) medicaid_exp(1985) medicaid_exp(1984) medicaid_exp(1983) medicaid_exp(1982) medicaid_exp(1981) medicaid_exp(1980), trunit(42) trperiod(1995) nested fig

*   ---Medicare Expenditure Analysis---

*synth medicare_exp $controls medicare_exp(1995) medicare_exp(1990) medicare_exp(1984), trunit(42) trperiod(1996) nested fig
synth medicare_exp $controls medicare_exp(1988) medicare_exp(1987) medicare_exp(1986) medicare_exp(1985) medicare_exp(1984) medicare_exp(1983) medicare_exp(1982) medicare_exp(1981) medicare_exp(1980), trunit(42) trperiod(1995) nested fig


















* ------------------------------------------------------------------------------
* North Dakota Synthetic Control Analysis
* ------------------------------------------------------------------------------

clear 
use CON_Expenditure.dta

keep if code == 10

tsset id year
keep if alwaysconpa==1 | id==38

*   ---Total Expenditure Analysis---

*synth total_exp $controls total_exp(1995) total_exp(1990) total_exp(1984), trunit(38) trperiod(1996) nested fig
synth total_exp $controls total_exp(1988) total_exp(1987) total_exp(1986) total_exp(1985) total_exp(1984) total_exp(1983) total_exp(1982) total_exp(1981) total_exp(1980), trunit(38) trperiod(1994) nested fig

*   ---Medicaid Expenditure Analysis---

*synth medicaid_exp $controls medicaid_exp(1995) medicaid_exp(1990) medicaid_exp(1984), trunit(42) trperiod(1996) nested fig
synth medicaid_exp $controls medicaid_exp(1988) medicaid_exp(1987) medicaid_exp(1986) medicaid_exp(1985) medicaid_exp(1984) medicaid_exp(1983) medicaid_exp(1982) medicaid_exp(1981) medicaid_exp(1980), trunit(38) trperiod(1994) nested fig

*   ---Medicare Expenditure Analysis---

*synth medicare_exp $controls medicare_exp(1995) medicare_exp(1990) medicare_exp(1984), trunit(42) trperiod(1996) nested fig
synth medicare_exp $controls medicare_exp(1988) medicare_exp(1987) medicare_exp(1986) medicare_exp(1985) medicare_exp(1984) medicare_exp(1983) medicare_exp(1982) medicare_exp(1981) medicare_exp(1980), trunit(38) trperiod(1994) nested fig






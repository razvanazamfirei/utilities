* KDIGO Classification of AKI

version 17.0
program aki_ra
syntax newvarname(generate) [if] [in], pre(varname numeric) post(varname numeric)
	marksample touse, novarlist
	
local akivar `varlist'
tempvar creatinine_difference creatinine_ratio aki_var
capture {
	label define aki_label 0 "No AKI" 1 "AKI Stage 1" 2 "AKI Stage 2" 3 "AKI Stage 3" 4 "CKD - No AKI"
}
gen `creatinine_difference' = `post' - `pre' if `touse'
gen `creatinine_ratio' = `post' / `pre' 
gen `aki_var' = 0 if `creatinine_difference' <= 0.3 & `creatinine_ratio' < 1.5
replace `aki_var' = 3 if `post' >= 4.0 | `creatinine_ratio' >= 3
replace `aki_var' = 4 if `aki_var' == 3 & `creatinine_difference' < 0.3 & `creatinine_ratio' < 1.5
replace `aki_var' = 2 if `aki_var' != 3 & (`creatinine_ratio' >= 2.0) 
replace `aki_var' = 1 if (`aki_var' != 2 & `aki_var' != 3) & (`creatinine_ratio' >= 1.5 | `creatinine_difference' >= 0.3)
replace `akivar' = `aki_var' if `touse'
label values `akivar' aki_label
end

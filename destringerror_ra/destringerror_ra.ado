cap program drop destringerror_ra
version 17.0
program destringerror_ra
syntax varname, [Empty]
tempname empty
if "`Empty'" != "" {
		scalar empty = 1
	}
	else{
		scalar empty = 0
	}
	if empty == 0 {
		list `varlist' if missing(real(`varlist')) & `varlist' != ""
	}
	if empty == 1 {
		list `varlist' if missing(real(`varlist'))
	}
end

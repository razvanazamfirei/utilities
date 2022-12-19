cap program drop ***
program define ***
syntax filename
local index = 1  // this is the matrix index
foreach x of local myvars {
	local i = 0  // this is the starting count of each variable
	foreach y of varlist v* { // loop over all the variables
	 
	  // use regular expressions to check for exact matches
	  
	  cap drop `x'_`y'
	  qui gen `x'_`y' = ustrregexm(`y', "\s(`x')\s?") == 1
	 
	  qui summ `x'_`y'   // find the total of each column
	  local i = `i' + r(sum)  // increment the counter 
	 
	  drop `x'_`y'
	  
	}
 di "`x' - `i'"  // display the info
 
 mat vars[`index', 1] = `i'  // add it to the matrix
 
 local index= `index' + 1  // increment the index
 
}

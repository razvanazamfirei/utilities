version 17
cap program drop 	datefix_ra
	program 		datefix_ra

	syntax, [not(varlist) DATEformat(string) TIMEformat(string)]
qui{
	local notlist `not'
	local dateform `dateformat'
	local timefor `timeformat'

	* Verify format is appropriate
	capture confirm format `dateform'
	if _rc != 0{
		local dateform %td
	}
	capture confirm format `timefor'
	if _rc != 0{
		local timefor %tc
	}
	ds, has (format %t*)
	local ds_vars `r(varlist)'
	local vars: list ds_vars- not
	ds `vars', not(format `timefor' | format `dateform')
	local timewrong `r(varlist)'
	ds `timewrong', has(format %td*)
	local tdv `r(varlist)'
	capture confirm names `tdv'
	if _rc == 0 {
	format `tdv' `dateform'
	}
	if _rc != 0 {
		error 0
	}
	ds `timewrong', has(format %tc* | %tC*)
	local tcv `r(varlist)'
	capture confirm names `tcv'
	if _rc == 0 {
		format `tcv' `timefor'
	}
	if _rc != 0 {
		error 0
	}
}
end

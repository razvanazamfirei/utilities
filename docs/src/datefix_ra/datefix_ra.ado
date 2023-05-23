*! | Version: 1.0 | Last Updated: May 23, 2023
/*----------------------------------------------------------------------------*\
|   Copyright 2022 Razvan Azamfirei                                            |
|                                                                              |
|   Licensed under the Apache License, Version 2.0 (the"License"); you may not |
|   use this file except in compliance with the License. You may obtain a copy |
|   of the License at:                                                         |
|                                                                              |
|       http://www.apache.org/licenses/LICENSE-2.0                             |
|                                                                              |
|   Unless required by applicable law or agreed to in writing,                 |
|   software distributed under the License is distributed on an                |
|   "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,               |
|   either express or implied.                                                 |
|                                                                              |
| See the License for the specific language governing permissions and          |
| limitations under the License.                                               |
\*----------------------------------------------------------------------------*/
version 17
program datefix_ra
syntax, [not(varlist) DATEformat(string) TIMEformat(string)]
quietly{
	local notlist `not'
	local dateform `dateformat'
	local timefor `timeformat'
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

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

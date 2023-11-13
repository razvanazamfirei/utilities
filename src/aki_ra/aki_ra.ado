*! | Version: 1.2 | Last Updated: May 23, 2023

*  | KDIGO Classification of AKI | Author: Razvan Azamfirei |

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

version 17.0
    cap program drop    aki_ra
        program         aki_ra

    syntax newvarname(generate) [if] [in],                                   ///
        pre(varname numeric) post(varname numeric)
        
    preserve
        marksample touse, novarlist

        local akivar `varlist'
        tempvar creatinine_difference creatinine_ratio aki_var
        tempname dif1 ratio1 ratio2 ratio3 abs0
        capture {
            label define aki_label 0 "No AKI" 1 "AKI Stage 1" 2 "AKI Stage 2"///
                3 "AKI Stage 3" 4 "CKD - No AKI"
        }

    * Define bounds for classification
        sca dif1 = 0.3
        sca ratio1 = 1.5
        sca ratio2 = 2.0
        sca ratio3 = 3.0
        sca abs0 = 4.0
        
    * Calculate differences, ratios and assign AKI category   

    gen double `creatinine_difference' = `post' - `pre' if `touse'
    gen double `creatinine_ratio' = `post' / `pre'
    
    gen `aki_var' = 0 if                                                     ///
        `creatinine_difference' <= dif1 & `creatinine_ratio' < ratio1
        
    replace `aki_var' = 3 if                                                 ///
        inrange(`post', abs0, .) | inrange(`creatinine_ratio', ratio3, .)
        
    replace `aki_var' = 4 if                                                 ///
        `creatinine_difference' < dif1 & `creatinine_ratio' < ratio1 &       ///
        `aki_var' == 3
        
    replace `aki_var' = 2 if ///
        `aki_var' != 3 & inrange(`creatinine_ratio', ratio2, .)
        
    replace `aki_var' = 1 if ///
        !inlist(`aki_var', 1, 2, 3) &                                        ///
        (inrange(`creatinine_ratio', ratio1, .) |                            ///
        inrange(`creatinine_difference', dif1, .))
        
    replace `akivar' = `aki_var' if `touse'
    
    label values `akivar' aki_label
    
    restore, not
    
end

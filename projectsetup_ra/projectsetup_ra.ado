capture program drop projectsetup_ra
program projectsetup_ra
    version 17

    syntax 

scalar i = 0
scalar g = 0

local scriptversion 1.1

/*while i == 0 & g != 5{
    di as text "What is the project title?" _request(ans_proj)
    if "$ans_proj" == ""{
        di as text "What is the project title?" _request(ans_proj)
        scalar i = 0
        scalar g = g + 1
    }
    if "$ans_proj" != ""{
        local projectname $ans_proj
        scalar i = 1
        scalar g = g + 1
    }
}*/
local projectname something
scalar i = 0
scalar g = 0
while i == 0 & g != 5{
	di as text "This is version `scriptversion' of the project set-up script."_n
	di as text "You can always type exit to end the script."_n
	di as text "This current directory is: `c(pwd)'"_n
	di as text "Would you like to:" _n 
	di as text "1. Set up the project in the current folder (1)" _n
	di as text "2. Set up the project in a different folder (2)" _n
	di as result "Select your option (1/2):" _request(folderopt)
	if "$folderopt" == "1" {
		local directory `c(pwd)'
		scalar i = 0
		cap cd "`directory'"
	}
	if "$folderopt" == "2" {
		di as text "What is the path to the directory you want to use?" _request(diropt)
			if "$diropt" == "exit"{
				di as error "Script exited by user."
				err 498
			}
			pause
		cap cd "$diropt"
		di _rc
		if _rc == 0{
			local directory $diropt
			scalar i = 0
			cap cd "`directory'"
		}
		if _rc != 0{
			di as text "Directory does not exit. Create? (Y/N)" _request(dirmakeopt)
			if inlist("$dirmakeopt", "Y", "y", "YES", "yes", "Yes") {
				cap mkdir "$diropt"
				pause 
				local directory $diropt
				scalar i = 0
				cap cd "`directory'"
			}
			else{
				di as error "Script exited by user."
				err 498
			}
		}
	}
	if "$folderopt" == "exit" {
		di as error "Script exited by user."
		err 498
	}
	else{
		scalar g = g + 1
	}
	
    di as text "The current directory is:"
    pwd
    di as result "Is this the location where you want to create the project? (Y/N)" _request(ans)
if "$ans" == "N"{
    di as result "What is the location?" _request(dir)
    local directory $dir
    di "`directory'"
    cap cd "`directory'"
        if _rc != 0 {
    cap mkdir "`directory'"
    }
    scalar i = 1
}
if "$ans" == "Y"{
    di "Setting up directory structure."
    local directory `c(pwd)'
    scalar i = 1
    cap cd "`directory'"
}
if "$ans" != "Y" & "$and" != "N"{
    scalar i = 0
    scalar g = g + 1
}
}

global projectfolder `c(pwd)'
cap cd $projectfolder

cap mkdir "$projectfolder/data"
cap mkdir "$projectfolder/data/raw_data"
cap mkdir "$projectfolder/data/processed_data"
cap mkdir "$projectfolder/analysis_scripts"
cap mkdir "$projectfolder/results"
cap mkdir "$projectfolder/results/graphs"
cap mkdir "$projectfolder/results/tables"
cap mkdir "$projectfolder/logs"
cap mkdir "$projectfolder/data/participant_key"
cap mkdir "$projectfolder/papers"

log using README, replace smcl name(README)
noisily di as text "{hline}"
noisily di as text "The project name is `projectname'."
noisily di as text "This project was created on `c(current_date)' `c(current_time)'."
noisily di as text "The version in use is: Stata `c(stata_version)'/`c(edition_real)'"
noisily di as text "The computer is: `c(hostname)' [`c(machine_type)']"
noisily di as text "The user initiating this project is: `c(username)'"
noisily di as text "{hline}"
log close README

cap cd "$projectfolder"

	tempname 	oldHandle
	local 		oldTextFile 	"$projectfolder/analysis_scripts/masterdofile.do"
	file open `oldHandle' using `"`oldTextFile'"', read write
	file write `oldHandle' /// 
			_col(4) "* ******************************************************************** *" _n ///
			_col(4) "* ******************************************************************** *" _n ///
			_col(4) "*" _col(75) "*" _n ///
			_col(4) "*" _col(20) "`projectname'" _col(75) "*" _n ///
			_col(4) "*" _col(20) "MASTER DO_FILE" _col(75) "*" _n ///
			_col(4) "*" _col(75) "*" _n ///
			_col(4) "* ******************************************************************** *" _n ///
			_col(4) "* ******************************************************************** *" _n ///
			_n ///
			_col(8) "/*" ///
			_n ///
				_col(8)"** PURPOSE:" _col(25) "Write intro to project here" _n ///
				_n ///
				_col(8)"** OUTLINE:" _col(25) "PART 0: Standardize settings and install packages" _n ///
				_col(25) "PART 1: Set globals for dynamic file paths" _n ///
				_col(25) "PART 2: Set globals for constants and varlist" _n ///
				_col(32) "used across the project. Install all user-contributed" _n ///
				_col(32) "commands needed." _n ///
				_col(25) "PART 3: Call the task-specific master do-files " _n ///
				_col(32) "that call all dofiles needed for that " _n ///
				_col(32) "task." ///
				_n ///
				_n  ///
			_col(8)"** IDS VAR:" _col(25) "list_ID_var_here		//Uniquely identifies households (update for your project)" _n ///	
			_n	///
			_col(8)"** NOTES:" _n ///
			_n ///
			_col(8)"** WRITTEN BY:" _col(25) "names_of_contributors" _n ///
			_n ///
			_col(8)"** Last date modified: `c(current_date)'" _n ///
			_col(8)"*/" _n ///
			_col(4)"* ******************************************************************** *" _n ///
			_col(4)"*" _n ///
			_col(4)"*" _col(12) "PART 0:  INSTALL PACKAGES AND STANDARDIZE SETTINGS" _n ///
			_col(4)"*" _n ///
			_col(4)"*" _col(16) "- Install packages needed to run all dofiles called" _n ///
			_col(4)"*" _col(17) "by this master dofile." _n ///
			_col(4)"*" _col(16) "- Use ieboilstart to harmonize settings across users" _n ///
			_col(4)"*" _n ///
			_col(4)"* ******************************************************************** *" _n ///
			_col(4)"*Install all packages that this project requires:" _n ///
			_col(4)"*(Note that this never updates outdated versions of already installed commands, to update commands use adoupdate)" _n ///
			_col(4)"local user_commands ietoolkit iefieldkit" _col(40) "//Fill this list will all user-written commands this project requires" _n ///
			_col(4)"foreach command of local user_commands {" _n ///
			_col(8)		"cap which " _char(96) "command'" _n ///
			_col(8)		"if _rc == 111 {" _n ///
			_col(12)		"ssc install " _char(96) "command'" _n ///
			_col(8)		"}" _n ///
			_col(4)"}" _n ///
			_n	 ///
			_col(4)"*Standardize settings accross users" _n ///
			_col(4)"ieboilstart, version(12.1)" _col(40) "//Set the version number to the oldest version used by anyone in the project team" _n ///
			_col(4) _char(96)"r(version)'" 		_col(40) "//This line is needed to actually set the version from the command above" _n ///
	* At some point here I'll want to verify that the list does not contain any of my commands and capture the ones that fail ssc. 
	file close `oldHandle'

		*Write folder globals section header and the root folders
	file open `oldHandle' using `"`oldTextFile'"', write append
	file write `oldHandle' /// 
			_col(4)"* ******************************************************************** *" _n ///
			_col(4)"*" _n ///
			_col(4)"*" _col(12) "PART 1:  PREPARING FOLDER PATH GLOBALS" _n ///
			_col(4)"*" _n ///
			_col(4)"*" _col(16) "- Set the global box to point to the project folder" _n ///
			_col(4)"*" _col(17) "on each collaborator's computer." _n ///
			_col(4)"*" _col(16) "- Set other locals that point to other folders of interest." _n ///
			_col(4)"*" _n ///
			_col(4)"* ******************************************************************** *" _n ///
			_n ///
			_col(4)"* Users" _n ///
			_col(4)"* -----------" _n ///
			_n ///
			_col(4)"*User Number:" _n ///
			_col(4)"* You" _col(30) "1" _col(35) `"// Replace "You" with your name"' _n ///
			_col(4)"* Next User" _col(30) "2" _col(35) "// Assign a user number to each additional collaborator of this code" _n ///
			_n ///
			_col(4)"*Set this value to the user currently using this file" _n ///
			_col(4)"global user  1" _n ///
			_n ///
			_col(4)"* Root folder globals" _n ///
			_col(4)"* ---------------------" _n ///
			_n ///
			_col(4)"if "_char(36)"user == 1 {" _n ///
			_col(8)`"global projectfolder "$projectFolder""' _n ///
			_col(4)"}" _n ///
			_n ///
			_col(4)"if "_char(36)"user == 2 {" _n ///
			_col(8)`"global projectfolder ""  // Enter the file path to the project folder for the next user here"' _n ///
			_col(4)"}" _n _n ///
			_col(4)"* Project folder globals" _n ///
			_col(4)"* ---------------------" _n _n ///
			_col(4)"global datafolder " _col(34) `"""' _char(36)`"projectfolder/dataf""' _n ///
			_col(4)"* Set all non-folder path globals that are constant accross" _n ///
			_col(4)"* the project. Examples are conversion rates used in unit" _n  	///
			_col(4)"* standardization, different sets of control variables," _n 		///
			_col(4)"* adofile paths etc." _n _n 									///
			_col(4) `"do ""' _char(36) `"datafolder/global_setup.do" "' _n _n ///
				_col(4)"* ******************************************************************** *" _n 	///
				_col(4)"*" _n 																			///
				_col(4)"*" _col(12) "PART `partNum': - RUN DOFILES CALLED BY THIS MASTER DOFILE" _n 	///
				_col(4)"*" _n ///
					_col(4)"*" _col(16) "- A task master dofile has been created for each high-"  _n 		///
					_col(4)"*" _col(17) "level task (cleaning, construct, analysis). By "  _n 			///
					_col(4)"*" _col(17) "running all of them all data work associated with the "  _n 	///
					_col(4)"*" _col(17) "`rndName' should be replicated, including output of "  _n 		///
					_col(4)"*" _col(17) "tables, graphs, etc." _n 										///
					_col(4)"*" _col(16) "- Feel free to add to this list if you have other high-"  _n 	///
					_col(4)"*" _col(17) "level tasks relevant to your project." _n ///
				_col(4)"*" _n ///
				_col(4)"* ******************************************************************** *" _n ///
				_col(4)"**Set the locals corresponding to the tasks you want" _n ///
				_col(4)"* run to 1. To not run a task, set the local to 0." _n ///
				_col(4)"local importDo" _col(25) "0" _n ///
				_col(4)"local cleaningDo" _col(25) "0" _n ///
				_col(4)"local constructDo" _col(25) "0" _n ///
				_col(4)"local analysisDo" _col(25) "0" _n
				
	file close `oldHandle'

end		
cap program drop    global_setup
program define      global_setup

    *Create a temporary textfile
    tempname    glbStupHandle
    tempfile    glbStupTextFile

    cap file close  `glbStupHandle'
    file open       `glbStupHandle' using "`glbStupTextFile'", text write append


    file write  `glbStupHandle' ///
        _col(4)"* ******************************************************************** *" _n    ///
        _col(4)"*" _n                                                                           ///
        _col(4)"*" _col(12) "SET UP STANDARDIZATION GLOBALS AND OTHER CONSTANTS" _n             ///
        _col(4)"*" _n                                                                           ///
        _col(4)"*" _col(16) "- Set globals used all across the project" _n                      ///
        _col(4)"*" _col(16) "- It is bad practice to define these at multiple locations" _n     ///
        _col(4)"*" _n                                                                           ///
        _col(4)"* ******************************************************************** *" _n	///
        _n                                                                                      ///
        _col(4)"* ******************************************************************** *" _n    ///
        _col(4)"* Set all conversion rates used in unit standardization " _n                    ///
        _col(4)"* ******************************************************************** *" _n    ///
        _n                                                                                      ///
        _col(4)"**Define all your conversion rates here instead of typing them each " _n        ///
        _col(4)"* time you are converting amounts, for example - in unit standardization. "     ///
        _n                                                                                      ///
        _col(4)"*Standardizing MME and Midazolam equivalent conversions" _n                     ///
        _col(8)"global fentanyl" _col(24) "= 100" _n                                            ///
        _col(8)"global hydromorphone" _col(24) "= 4" _n                                         ///
        _col(8)"global hydrocodone" _col(24) "= 1" _n                                           ///
        _col(8)"global morphine"   _col(24) "= 1" _n                                            ///
        _col(8)"global midazolam" _col(24) "= 1" _n                                             ///
        _col(8)"global lorazepam" _col(24) "= 2" _n                                       		///
		_col(8)"global diazepam" _col(24) "= 0.26666666666666666" _n                            ///
        _n                                                                                      ///
        _col(4)"*Standardizing weight to kilograms and drug dosages to mg" _n                   ///
        _col(8)"global pound"   _col(24) "= 0.453592" _n                                        ///
        _col(8)"global mcg"     _col(24) "= 0.001" _n                                           ///
        _col(8)"global g"   _col(24) "= 1000" _n                                                ///
        _n                        																///                   
		_col(4)"*Standardizing units to US lab values" _n                   					///
        _col(8)"global glucose_mmol"   _col(24) "= 18.016" _n                                   ///
        _col(8)"global creatinine_mmol"     _col(24) "= 11.312" _n     							///
        _col(8)"global creatinine_umol"     _col(24) "= 0.11312" _n     						///					
        _col(8)"global bun_mmol"     _col(24) "= 2.8" _n     									///		
        _col(4)"* ******************************************************************** *" _n    ///
        _col(4)"* Set global lists of variables" _n                                             ///
        _col(4)"* ******************************************************************** *" _n    ///
        _n                                                                                      ///
        _col(4)"**This is a good location to create lists of variables to be used at " _n       ///
        _col(4)"* multiple locations across the project. Examples of such lists might " _n      ///
        _col(4)"* be different list of controls to be used across multiple regressions. " _n    ///
        _col(4)"* By defining these lists here, you can easliy make updates and have " _n       ///
        _col(4)"* those updates being applied to all regressions without a large risk " _n      ///
        _col(4)"* of copy and paste errors." _n                                                 ///
        _n                                                                                      ///
        _col(8)"*Control Variables" _n                                                          ///
        _col(8)"*Example: global baseline_control" _col(50) "age gender i.ethnicity" _n         ///
        _n                                                                                      ///
        _col(4)"* ******************************************************************** *" _n    ///
        _col(4)"* Set custom adofile path" _n                                                   ///
        _col(4)"* ******************************************************************** *" _n    ///
        _n                                                                                      ///
        _col(4)"**It is possible to control exactly which version of each command that " _n     ///
        _col(4)"* is used in the project. This prevents that different versions of " _n         ///
        _col(4)"* installed commands leads to different results." _n _n                         ///
        _col(4)"/*"_n                                                                           ///
        _col(8)"global ado"     _col(24) `"""' _char(36) `"datafolder/your_ado_folder""' _n 	///
        _col(12)"adopath ++"    _col(24) `"""' _char(36) `"ado" "'   _n                         ///
        _col(12)"adopath ++"    _col(24) `"""' _char(36) `"ado/m" "' _n                         ///
        _col(12)"adopath ++"    _col(24) `"""' _char(36) `"ado/b" "' _n                         ///
        _col(4)"*/"_n                                                                           ///
        _n                                                                                      ///
        _col(4)"* ******************************************************************** *" _n    ///
        _col(4)"* Anything else" _n                                                    			 ///
        _col(4)"* ******************************************************************** *" _n    ///
        _n                                                                                      ///

    file close      `glbStupHandle'

    *Copy the new master dofile from the tempfile to the original position
    copy "`glbStupTextFile'"  "$projectfolder/global_setup.do" , replace

end


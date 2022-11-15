{smcl}
{* *! version 1.0 13 Nov 2022}{...}
{vieweralsosee "Datetime display formats" "help datetime_display_formats"}{...}
{viewerjumpto "Syntax" "datefix_ra##syntax"}{...}
{viewerjumpto "Description" "datefix_ra##description"}{...}
{viewerjumpto "Options" "datefix_ra##options"}{...}
{viewerjumpto "Remarks" "datefix_ra##remarks"}{...}
{viewerjumpto "Examples" "datefix_ra##examples"}{...}
{title:Title}
{phang}
{bf:datefix_ra} {hline 2} a command to make the date and time formatting uniform.

{marker syntax}{...}
{title:Syntax}
{p 8 17 2}
{cmdab:datefix_ra}
[{cmd:,}
{it:options}]

{synoptset 25 tabbed}{...}
{synopthdr}
{synoptline}
{synopt:{opt not(varlist)}} specifies variables that should be excluded.{p_end}
{synopt:{opth date:format(datetime_display_formats:%td format)}} specifies the date format. Defaults to {help format:%td}.{p_end}
{synopt:{opth time:format(datetime_display_formats:%tc format)}} specifies the time format. Defaults to {help format:%tc}. {p_end}

{marker examples}{...}
{title:Examples}

 {stata datefix_ra}
 {stata datefix_ra, not(variable1 variable2)}
 {stata datefix_ra, date(%tdyymmdd)}


{title:Author}
{p}

Razvan Azamfirei

Email {browse "mailto:stata@azamfirei.com":stata@azamfirei.com}




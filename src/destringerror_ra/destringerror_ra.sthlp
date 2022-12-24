{smcl}
{* *! version 1.0 13 Nov 2022}{...}
{vieweralsosee "" "--"}{...}
{viewerjumpto "Syntax" "destringerror_ra##syntax"}{...}
{viewerjumpto "Description" "destringerror_ra##description"}{...}
{viewerjumpto "Options" "destringerror_ra##options"}{...}
{viewerjumpto "Remarks" "destringerror_ra##remarks"}{...}
{viewerjumpto "Examples" "destringerror_ra##examples"}{...}
{title:Title}
{phang}
{bf:destringerror_ra} {hline 2} a command to find values that prevent clean destringing

{marker syntax}{...}
{title:Syntax}
{p 8 17 2}
{cmdab:destringerror_ra}
varname
[{cmd:,}
{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}

{syntab:Optional}
{synopt:{opt e:mpty}} specifices that empty values i.e "" should be displayed.

{synoptline}
{p2colreset}{...}
{p 4 6 2}

{marker description}{...}
{title:Description}
{pstd}

{pstd}
 {cmd:destringerror_ra} finds the values that prevent clean destringing.

{marker options}{...}
{title:Options}
{dlgtab:Main}

{phang}
{opt e:mpty}  specifices that empty values i.e "" should be displayed.



{marker examples}{...}
{title:Examples}

 {stata destringerror_ra stringvariable}
 {stata destringerror_ra stringvariable, empty}


{title:Author}
{p}

Razvan Azamfirei

Email {browse "mailto:stata@azamfirei.com":stata@azamfirei.com}

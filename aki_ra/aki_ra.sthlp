{smcl}
{* *! version 1.0 21 Jul 2022}{...}
{title:Title}

{phang}
{bf:AKI KDIGO Classification} {hline 2} a command to classify AKI based on serum creatinine

{marker syntax}{...}
{title:Syntax}
{p 8 17 2}
{cmdab:aki_ra}
newvar
[{help if}]
[{help in}]
{cmd:,}
{opt pre(varname numeric)} 
{opt post(varname numeric)}

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{synopt:newvar} Specify a valid new variable name to hold your classification results. {p_end}

{synopt:{opt pre(varname)}} baseline creatinine value.{p_end}
 
{synopt:{opt post(varname)}} maximum creatinine value.{p_end}
{synoptline}

{title:References}
{pstd}

{pstd}
Kidney Disease: Improving Global Outcomes (KDIGO). Acute Kidney Injury Work Group. KDIGO clinical practice guidelines for acute kidney injury. Kidney Int Suppl 2012; 2:1.

{title:Author}
{p}

Razvan Azamfirei
Email: {browse "mailto:stata@azamfirei.com":stata@azamfirei.com}

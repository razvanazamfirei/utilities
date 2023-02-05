{smcl}
{* *! version 1.1 5 Feb 2023}{...}
{viewerjumpto "License" "./aki_ra##License"}{...}
{viewerjumpto "Syntax" "./aki_ra##syntax"}{...}

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

{marker License}{...}
{title:License}
{p}{hi:Copyright 2022 Razvan Azamfirei}

{pstd}Licensed under the Apache License, Version 2.0 (the"License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at: {p_end}

{pstd}{browse "https://www.apache.org/licenses/LICENSE-2.0":http://www.apache.org/licenses/LICENSE-2.0}{p_end}

{pstd}Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.{p_end}
{pstd} See the License for the specific language governing permissions and limitations under the License. {p_end}

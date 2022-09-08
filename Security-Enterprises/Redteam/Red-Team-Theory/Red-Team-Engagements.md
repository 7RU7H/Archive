# Red Team Engagements

## Introduction

Successful Red Team engagements have:
1. Clearly defined client objectives
2. Well-defined scope
	1. Scope is boolean of in-scope or out-of-scope.
3. Clearly defined Rules of Engagement
4. White Cell omnipresence and in-the-loop overseeing
5. Both Blue and Red's adherence to Rules of Engagement
6. Well-coordinated planning  from all parties involved
7. Well-coordinated  communication from all parties involved


Engagement Categorization:
- General internal or network penetration test will use more standard TTPs.
- Focused adversary emulation will define a specific APT or group to emulate

## Concept of Operation (CONOPS)

CONOPS is part of the engagement plan that details a high-level overview of the proceedings of an engagement. It is document written from a semi-technical summary perspective, assuming the target audience/reader has zero to minimal technical knowledge to serve as a business/client reference and starting point for Red Cell. General Standard:
-   Client Name
-   Service Provider
-   Timeframe
-   General Objectives/Phases
-   Other Training Objectives (Exfiltration)
-   High-Level Tools/Techniques planned to be used
-   Threat group to emulate (if any)


## Resource Plan

The resource plan details a brief overview of dates, knowledge required (optional), resource requirements, written as bulleted lists of subsections. There is no standard set of resource plan templates or documents, below is an outline:

-   Header
    -   Personnel writing
    -   Dates
    -   Customer
-   Engagement Dates
    -   Reconnaissance Dates
    -   Initial Compromise Dates
    -   Post-Exploitation and Persistence Dates
    -   Misc. Dates
-   Knowledge Required (optional)
    -   Reconnaissance
    -   Initial Compromise
    -   Post-Exploitation
-   Resource Requirements
    -   Personnel
    -   Hardware
    -   Cloud
    -   Misc.

## Operation Plan

The operations plan is a flexible document(s) expanding upon the current CONOPS and should include a majority of specific engagement information; the ROE can also be placed here depending on the depth and structure of the ROE.

-   Header
    -   Personnel writing
    -   Dates
    -   Customer
-   Halting/stopping conditions (can be placed in ROE depending on depth)
-   Required/assigned personnel
-   Specific TTPs and attacks planned
-   Communications plan
-   Rules of Engagement (optional)

## Mission Plan
The mission plan is a cell-specific document that details the exact actions to be completed by operators. Below is a list of the minimum detail that cells should include within the plan:

-   Objectives
-   Operators
-   Exploits/Attacks
-   Targets (users/machines/objectives)
-   Execution plan variations


## Rules of Engagement

Rules of Engagement (RoE) are a legally binding outline of the client objectives and scope with further details of engagement expectations between both parties.

**Section Name** | **Section Details**
--- | ---
Executive Summary | Overarching summary of all contents and authorization within RoE document  
Purpose | Defines why the RoE document is used
References | Any references used throughout the RoE document (HIPAA, ISO, etc.)  
Scope | Statement of the agreement to restrictions and guidelines  
Definitions | Definitions of technical terms used throughout the RoE document  
Rules of Engagement and Support Agreement | Defines obligations of both parties and general technical expectations of engagement conduct  
Provisions | Define exceptions and additional information from the Rules of Engagement  
Requirements, Restrictions, and Authority | Define specific expectations of the red team cell  
Ground Rules | Define limitations of the red team cell's interactions  
Resolution of Issues/Points of Contact | Contains all essential personnel involved in an engagement  
Authorization | Statement of authorization for the engagement  
Approval  | Signatures from both parties approving all subsections of the preceding document 
Appendix | Any further information from preceding subsections

## Campaign Planning

**Type of Plan** | **Explanation of Plan** | **Plan Contents**
--- | --- | ---
Engagement Plan  | An overarching description of technical requirements of the red team.   | CONOPS, Resource and Personnel Requirements, Timelines  
Operations Plan | An expansion of the Engagement Plan. Goes further into specifics of each detail.   | Operators, Known Information, Responsibilities, etc.  
Mission Plan | The exact commands to run and execution time of the engagement.   | Commands to run, Time Objectives, Responsible Operator, etc.  
Remediation Plan | Defines how the engagement will proceed after the campaign is finished.   |  Report, Remediation consultation, etc.


## Checklist
[[Redteam-Checklist]] from [redteam.guide/](https://redteam.guide/docs/checklists/red-team-checklist/)

## Engagement Documentation Purpose

**Engagement Plan:** 

**Component** | **Purpose**
--- | ---
CONOPS (Concept of Operations) | Non-technically written overview of how the red team meets client objectives and target the client.  
Resource plan  | Includes timelines and information required for the red team to be successful—any resource requirements: personnel, hardware, cloud requirements.  

**Operations Plan:**

**Component** | **Purpose**
--- | ---
Personnel   | Information on employee requirements.  
Stopping conditions   | How and why should the red team stop during the engagement.  
RoE (optional)   | -
Technical requirements   | What knowledge will the red team need to be successful.  

**Mission Plan:**

**Component** | **Purpose**
--- | ---
Command playbooks (optional)   | Exact commands and tools to run, including when, why, and how. Commonly seen in larger teams with many operators at varying skill levels.  
Execution times | Times to begin stages of engagement. Can optionally include exact times to execute tools and commands.  
Responsibilities/roles   | Who does what, when.  

**Remediation Plan (optional):**

Component | Purpose
--- | ---
Report   | Summary of engagement details and report of findings.  
Remediation/consultation   | How will the client remediate findings? It can be included in the report or discussed in a meeting between the client and the red team.

## References
[redteam.guide](https://redteam.guide/)
[redteam.guide/checklist](https://redteam.guide/docs/checklists/red-team-checklist/)
[THM Red Team Engagements Room](https://tryhackme.com/room/redteamengagements)
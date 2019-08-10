*** Settings ***
Suite Setup
Test Setup        Launch Browser  ${BROWSER}  ${url}
Test Teardown     When Test Fail Take Screenshot
Resource          ../Variables/MainFunctions.robot
Resource          ../Facilities/LoginFacilities.robot
Library           Selenium2Library
Library           ../Variables/PythonFunctions.py

*** Variables ***
${BROWSER}=   ff

*** Test Cases ***
01.Login DEMO
    Login With New User



*** Keywords ***

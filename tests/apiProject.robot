*** Settings ***
Resource          ../Variables/MainFunctions.robot
Resource          ../Facilities/LoginFacilities.robot
Library           Selenium2Library
Library           ../Variables/PythonFunctions.py

*** Variables ***

*** Test Cases ***
01.Restful DEMO
    ${username}  ${password}=  Create New User With API
    Login With API  ${username}  ${password}



*** Keywords ***

*** Settings ***
Library           Selenium2Library
Library           ExtendedRequestsLibrary
Library           ../Variables/PythonFunctions.py
Resource          ../Variables/MainFunctions.robot
Resource          ../Variables/LoginVariables.robot


*** Keywords ***

Login With New User
    Get Title Name And Check
    Check Page Title
    Check Status  ${shouldStatusNotLogin}
    ${username}  ${password}  New User Add
# Trying to Wrong Password
    Fill Form  ${username}  123123
    Check Status  ${shouldStatusFailedLogin}
# Tryin to Correct Password
    Reload Page
    Fill Form  ${username}  ${password}
    Check Status  ${shouldstatuslogin}


Check Status
    [Arguments]  ${statusText}
    ${pageLoginStatusCurrent}=  Wait Element And Get Text  ${loginStatus}
    Run Keyword If  '${pageLoginStatusCurrent}'=='${statusText}'  ConsoleLog  Page status is correct - ${statusText}
    ...  ELSE  ConsoleLog  Page Status is Wrong!! - ${statusText}

New User Add
    Go To  ${AddUserURL}
    Generate Random First Name
    ${userName}=  Generate Random First Name
    ${password}=  Generate Random Number  8
    Fill Form  ${userName}  ${password}
    ${currentUrl}=  Get Location
    Run Keyword If  '${currentUrl}'=='${shouldUrlForSaveUser}'  ConsoleLog  Save Url is correct
    ...  ELSE  ConsoleLog  Save URL is Wrong!!
    Go To  ${url}
    [Return]  ${userName}  ${password}

Fill Form
    [Arguments]  ${userName}  ${password}
    Wait And Send Text  ${usernameInput}  ${userName}
    Wait And Send Text  ${passwordInput}  ${password}
    Wait And Click Element  ${loginButton}

Get Title Name And Check
    @{titleNames}=  Get Window Titles
    Run Keyword If  '@{titlenames}[0]'=='${shouldTitle}'  ConsoleLog  Title is correct
    ...  ELSE  ConsoleLog  Title is Wrong!!

Check Page Title
    ${pageTitleName}=  Wait Element And Get Text  ${pageTitle}
    Run Keyword If    '${pageTitleName}'=='${shouldPageTitle}'  ConsoleLog  Page Title is correct
    ...  ELSE  ConsoleLog  Page Title is Wrong!!

Create New User With API
    ${userName}=  Generate Random First Name
    ${password}=  Generate Random Number  8
    Create Session   httpbin     ${urlAPI}
    ${headers}=  Create Dictionary  content-type=application/x-www-form-urlencoded    cache-control=no-cache
    ${data}=    Create Dictionary   username=${username}  password=${password}
    ${resp}=     Post Request   httpbin   /savedata.php    data=${data}  headers=${headers}
    [Return]  ${username}  ${password}

Login With API
    [Arguments]  ${username}  ${password}
    Create Session   httpbin     ${urlAPI}
    ${headers}=  Create Dictionary  content-type=application/x-www-form-urlencoded    cache-control=no-cache
    ${data}=    Create Dictionary   username=${username}   password=${password}
    ${resp}=     POST Request  httpbin  ${urlpath}    data=${data}   headers=${headers}
    ${tag}  parse html  ${resp.text}
    Run Keyword If  '${tag}'=='<b>${shouldStatusLogin}</b>'  ConsoleLog  Login is Succesfully
    ...  ELSE IF  '${tag}'=='<b>${shouldStatusFailedLogin}</b>'  ConsoleLog  Login isn't Succesfully !!!
    ...  ELSE IF  '${tag}'=='<b>${shouldStatusNotLogin}</b>'  ConsoleLog  Doesn't login in page with API

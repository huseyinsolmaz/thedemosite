*** Settings ***
Library           Collections
Library           String
Library           Selenium2Library
Resource          ../Variables/Variables.robot
Library           FakerLibrary  locale=en_us
Library           DateTime

*** Keywords ***
Launch Browser
    [Arguments]  ${BROWSER}  ${Url}
    Run keyword and ignore error  Empty Directory     ${CURDIR}/../results/${TEST_NAME}
    Set Screenshot Directory  ${CURDIR}/../results/${TEST_NAME}
    Open Browser    ${Url}    ${BROWSER}    alias=Main
    Maximize Browser Window

wait for home page
    [Arguments]    ${elementName}
    Wait Until Keyword Succeeds    20 sec    1 sec    Page Should Contain Element    ${elementName}
    Log    Homepage is viewed    level=WARN
    Capture Page Screenshot

Wait For Element
    [Arguments]    ${element}    ${timeout}=20 sec    ${interval}=1 sec
    Wait Until Keyword Succeeds    ${timeout}    ${interval}    Page Should Contain Element    ${element}
    Capture Page Screenshot

Wait And Click Element
    [Arguments]    ${element}    ${timeout}=20 sec    ${interval}=1 sec
    Wait For Element    ${element}    ${timeout}    ${interval}
    Click Element    ${element}

Wait And Send Text
    [Arguments]    ${element}    ${text}    ${timeout}=20 sec    ${interval}=1 sec
    Wait For Element    ${element}    ${timeout}    ${interval}
    Input Text    ${element}    ${text}

Select IFrame
    [Arguments]    ${element}
    Wait For Element    ${element}
    Select Frame    ${element}

Is Text Found
    [Arguments]    ${text}
    ${status}    ${value}=    Run keyword and ignore error    Page Should Contain Textfield    ${text}
    [Return]    ${status}

Focus Element
    [Arguments]    ${element}
    Set Focus To Element    ${element}

Wait And Focus Element
    [Arguments]    ${element}    ${timeout}=20 sec    ${interval}=1 sec
    Wait For Element    ${element}    ${timeout}    ${interval}
    focus element    ${element}

Create Random Text
    ${randomText}=    Generate Random String    8    [LOWER]
    [Return]  ${randomText}

Create Random Email
    ${randomText}=    Generate Random String    8    [LOWER]
    ${randomText}=    Set Variable    ${randomText}@gmail.com
    [Return]  ${randomText}

When Test Fail Take Screenshot
    Run Keyword And Ignore Error   Make Pptx    ${CURDIR}/../Tests/testresults/${TEST_NAME}
    Run Keyword If Test Failed    Capture Page Screenshot
    Run Keyword If Test Failed    Close Browser
    Run Keyword If Test Passed    Close Browser
    Close Browser

Scroll To Element
    [Arguments]    ${element}
    Wait For Element    ${element}
    Scroll Element Into View    ${element}

Wait Element And Get Text
    [Arguments]    ${element}    ${timeout}=20 sec    ${interval}=1 sec
    Wait For Element    ${element}    ${timeout}    ${interval}
    ${text}=  Get Text    ${element}
    [Return]   ${text}

Wait Element And Get Value
    [Arguments]    ${element}    ${timeout}=20 sec    ${interval}=1 sec
    Wait For Element    ${element}    ${timeout}    ${interval}
    Get Value    ${element}

Generate Random First Name
    ${randomFirstName}=    FakerLibrary.first_name
    [Return]    ${randomFirstName}

Generate Random Last Name
    ${randomLastname}=    FakerLibrary.first_name
     [Return]    ${randomLastname}

Generate Random Date
    ${randomDate}=    FakerLibrary.date    pattern=%d-%m-%Y
    ${randomDate}=    Remove String    ${randomDate}    -
      [Return]    ${randomDate}

Generate Random Phone
    ${randomPhone}=    FakerLibrary.Phone_number
    [Return]    ${randomPhone}

Generate Mail
    ${randomEmail}=    FakerLibrary.email
    [Return]    ${randomEmail}

Generate Random Text
    [Arguments]    ${nb_word}
    ${randomText}=    FakerLibrary.sentence    nb_words=${nb_word}
    [Return]    ${randomText}

Generate Random Number
    [Arguments]    ${digits}
    ${randomNumber}=    Random Number    ${digits}
    [Return]    ${randomNumber}

Delete Attribute By Id
    [Arguments]    ${locationId}    ${attribute}
    Execute Javascript    document.getElementById("${locationId}").removeAttribute("${attribute}");


Scroll To Location
    [Arguments]    ${y}
    Execute Javascript    window.scrollTo(0,${y})

CurrentDate
    ${currentDate}=    Get Current Date    result_format=%Y %m %d
    [Return]    ${currentDate}

CreateBirthDateOver18
    ${currentDate}=  CurrentDate
    ${birthDate}=  Subtract Time From Date  ${currentDate}  7570 days
    ${birthDate}=  Remove String  ${birthDate}   00:00:00.000
    ${birthDate}=  Remove String  ${birthDate}   -
    ${birthDate}=    Replace String    ${birthDate}    ${space}    ${empty}
    [Return]    ${birthDate}

Erase Space Characters
    [Arguments]    ${element}
    ${element}=    Replace String    ${element}    ${space}    ${empty}
    [Return]    ${element}

Delete Csv
    [Arguments]  ${file}
    Remove File  ${file}


CheckElementText
    [Arguments]   ${element}  ${expectedText}  ${checkMessage}   ${timeout}=30s
    Capture Page Screenshot
    Wait For Element  ${element}  ${timeout}
    Sleep  1s
    ${expectedText}=  convert to string  ${expectedText}
    ${status}    ${value}=    Run Keyword And Ignore Error    Element Text Should Be    ${element}    ${expectedText}
    Run Keyword If    '${status}'=='PASS'    log to console    \n${checkMessage} Success
    ...    ELSE    Fail    \nERROR-${checkMessage}-ERROR
    Capture Page Screenshot

SelectNgSelect
    [Arguments]    ${location}  ${customerType}
    Wait And Click Element    ${location}
    Sleep    1s
    Wait And Click Element    xpath=//span[contains(text(),'${customerType}')]

ConsoleLog
    [Arguments]   ${text}
    Log To Console  \n${text}


Set Chrome Options
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    : FOR    ${option}    IN    @{chrome_arguments}
    \    Call Method    ${options}    add_argument    ${option}
    [Return]    ${options}

HeadlessChrome
    [Arguments]   ${URL}   ${alias}=None
    Set Screenshot Directory  ${CURDIR}/../Tests/testresults/${TEST_NAME}
    ${chrome_options}=    Set Chrome Options
    ${ws}=    Set Variable    window-size=1920,1200
    ${disableLogging}=    Set Variable    --log-level=3
    Call Method   ${chrome_options}    add_argument    ${ws}
    Call Method   ${chrome_options}    add_argument    ${disableLogging}
    Create Webdriver    Chrome   ${alias}   chrome_options=${chrome_options}
    consolelog  Created WebDriver
    Go To  ${URL}
    Capture Page Screenshot

CreateChrome
    [Arguments]   ${URL}   ${alias}=None
    ${chrome_options}=    Set Chrome Options
    ${ws}=    Set Variable    window-size=1920,1200
    ${disableLogging}=    Set Variable    --log-level=3
    Call Method   ${chrome_options}    add_argument    ${ws}
    Call Method   ${chrome_options}    add_argument    ${disableLogging}
    Create Webdriver    Chrome   ${alias}   chrome_options=${chrome_options}
    consolelog  Created WebDriver
    Go To  ${URL}
    Capture Page Screenshot

DropRow
    [Arguments]    ${Csvpath}
    drop_first_row    ${csvpath}

Get Xpath Count
    [Arguments]  ${location}
    ${count}=    Get Element Count    ${location}
    ${count}=    Convert To Integer    ${count}
    [Return]   ${count+1}

ViewScreen
    [Arguments]  ${location}
    Execute Javascript   function getElementByXpath(path) { return document.evaluate(path, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; }; getElementByXpath('${location}').style.zoom="55%";

Send Mail
    [Arguments]  ${to}  ${Subject}  ${message}
    Send_Email  ${to}   ${Subject}   ${message}

ScrollEnd
    Execute Javascript  document.querySelector('.ps').scrollTo(0,2000)

ScrollTop
    Execute Javascript  document.querySelector('.ps').scrollTo(0,0)

ScrollVariablesCssSelector
    [Arguments]  ${location}  ${y}
    Execute Javascript  document.querySelector('${location}').scrollTo(0,${y})
Scroll To Element With JS
    [Arguments]  ${element}
    Wait For Element  ${element}
    ${location}  Get Horizontal Position  ${element}
    Execute Javascript  document.querySelector('#MTPageDetail').scrollTo(0,${location+300})

Image Request
    [Arguments]  ${path}
    ${statuscode}=  set variable  500
    ${status}  ${value}=  run keyword and ignore error  ${statuscode}=  get image request  ${path}
    [Return]   ${statuscode}

Wait Until Loader Not Visible
    Wait Until Element Is Not Visible  ${loader}  timeout=20s

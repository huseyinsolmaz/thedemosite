#Install

 Go to https://www.python.org/ and download Python 3.7.x version as shown below and install it.

 Open command prompt and run below command.

 You have to install robot framework

Open CMD

    `pip install robotframework`

then Libraries
Selenium2library for UI automation
ExtendedRequestLibrary for API automation
FakerLibrary for generate random data
    
    ``pip install robotframework-selenium2library``
    ``pip install robotframework-ExtendedRequestsLibrary``
    ``pip install robotframework-FakerLibrary``

Install Firefox

    https://github.com/mozilla/geckodriver/releases

You are ready to run your Test case
 For UI Tests
 
    ``cd  ${YOUR_PATH}``
    ``robot -d results tests/project.robot``
For API Tests
 
    ``cd  ${YOUR_PATH}``
    ``robot -d results tests/apiProject.robot``

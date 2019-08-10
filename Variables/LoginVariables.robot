*** Variables ***
${shouldTitle}  Login example page to test the PHP MySQL online system
${shouldUrlForSaveUser}  http://thedemosite.co.uk/savedata.php
${pageTitle}  xpath=//p[@align="center"]/big/strong
${shouldPageTitle}  4. Login
${loginStatus}  xpath=//center/b
${pageInfo}  xpath=//blockquote/p[@align="center"]
${shouldPageInfo}  Enter your login details you added on the previous page and test the login.
${shouldStatusNotLogin}  **No login attempted**
${shouldStatusFailedLogin}  **Failed Login**
${shouldStatusLogin}  **Successful Login**
${usernameInput}  xpath=//input[@name="username"]
${passwordInput}  xpath=//input[@name="password"]
${loginButton}  xpath=//input[@name="FormsButton2"]

${urlAPI}  http://thedemosite.co.uk
${urlpath}  /login.php

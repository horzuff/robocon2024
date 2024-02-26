*** Settings ***
Library            Browser
Library            String

*** Test Cases ***
Sauce labs test
    Browser.New Browser    chromium    False    slowMo=0:00:00.5
    Browser.New Context    viewport={"width": 1366, "height": 768}
    Browser.New Page    url=https://www.saucedemo.com/
    ${login field text}=    Browser.Get Text    id=login_credentials
    ${password field text}=    Browser.Get Text    css=div.login_password
    ${logins}=    String.Fetch from right    ${login field text}    :
    ${passwords}=    String.Fetch from right   ${password field text}    :
    @{logins}=    String.Split String    ${logins}
    @{passwords}=    String.Split String   ${passwords}
    VAR    ${login}    ${logins}[0]    scope=TEST
    VAR    ${password}    ${passwords}[0]    scope=TEST
    Browser.Fill Text    xpath=//input[@name='user-name' and @id='user-name']    ${login}
    Browser.Fill Secret    id=password    $password
    Browser.Click    input#login-button
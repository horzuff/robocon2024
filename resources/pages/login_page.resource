*** Settings ***
Library            Browser
Library            String

*** Keywords ***
Get available logins
    ${login field text}=    Browser.Get Text    id=login_credentials
    ${logins}=    String.Fetch from right    ${login field text}    :
    @{logins}=    String.Split String    ${logins}
    RETURN    ${logins}

Get password
    ${password field text}=    Browser.Get Text    css=div.login_password
    ${password}=    String.Fetch from right   ${password field text}    :
    RETURN    ${password}

Login
    [Arguments]    ${login}    ${password}
    Browser.Fill Text    xpath=//input[@name='user-name' and @id='user-name']    ${login}
    Browser.Fill Secret    id=password    $password
    Browser.Click    input#login-button

*** Settings ***
Library            Browser
Library            String
Variables          locators${/}login_page.yaml

*** Keywords ***
Get available logins
    ${login field text}=    Browser.Get Text    ${available logins field}
    ${logins}=    String.Fetch from right    ${login field text}    :
    @{logins}=    String.Split String    ${logins}
    RETURN    ${logins}

Get password
    ${password field text}=    Browser.Get Text    ${available password field}
    ${password}=    String.Fetch from right   ${password field text}    :
    RETURN    ${password}

Login
    [Arguments]    ${login}    ${password}
    Browser.Fill Text    ${username input}    ${login}
    Browser.Fill Secret    ${password input}    $password
    Browser.Click    ${login button}

*** Settings ***
Library            Browser

*** Keywords ***
Enter first name
    [Arguments]    ${name}
    Browser.Fill Text    id=first-name    ${name}

Enter last name
    [Arguments]    ${last name}
    Browser.Fill Text    id=last-name    ${last name}

Enter postal code
    [Arguments]    ${code}
    Browser.Fill Text    id=postal-code    ${code}

Fill out shipping info
    [Arguments]    ${first name}    ${last name}    ${post code}
    Enter first name    ${first name}
    Enter last name    ${last name}
    Enter postal code    ${post code}

Continue to overview
    Browser.Click    id=continue
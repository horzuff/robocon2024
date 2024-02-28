*** Settings ***
Library            Browser
Variables          locators${/}checkout_page.yaml

*** Keywords ***
Enter first name
    [Arguments]    ${name}
    Browser.Fill Text    ${first name input}    ${name}

Enter last name
    [Arguments]    ${last name}
    Browser.Fill Text    ${last name input}    ${last name}

Enter postal code
    [Arguments]    ${code}
    Browser.Fill Text    ${post code input}   ${code}

Fill out shipping info
    [Arguments]    ${first name}    ${last name}    ${post code}
    Enter first name    ${first name}
    Enter last name    ${last name}
    Enter postal code    ${post code}

Continue to overview
    Browser.Click    ${continue button}
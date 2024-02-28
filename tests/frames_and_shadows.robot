*** Settings ***
Library            Browser
Library            OperatingSystem
Resource           utils${/}browser_management.resource

*** Test Cases ***

iFrames test
    browser_management.Set up browser    https://the-internet.herokuapp.com/iframe    headless=False
    ${status}=    BuiltIn.Run Keyword And Return Status
    ...        Browser.Get Element    xpath=//body[@id="tinymce"]
    BuiltIn.Should Not Be True    ${status}
    ${old prefix}=    Browser.Set Selector Prefix    iframe#mce_0_ifr >>>
    ${status}=    BuiltIn.Run Keyword And Return Status
    ...        Browser.Get Element    xpath=//body[@id="tinymce"]
    BuiltIn.Should Be True    ${status}

Shadow Dom test
    browser_management.Set up browser    https://www.htmlelements.com/demos/menu/shadow-dom/index.htm    headless=False
    Try accessing shadow dom with xpath
    Try accessing shadow dom with css
    Try accessing shadow dom with text
    Avoid getting into shadow dom with :light engines


*** Keywords ***

Try accessing shadow dom with xpath
    ${status}=    BuiltIn.Run Keyword And Return Status
    ...        Browser.Get Element    xpath=//div[@smart-id="mainContainer"]
    BuiltIn.Should Not Be True    ${status}
    ${status}=    BuiltIn.Run Keyword And Return Status
    ...        Browser.Get Element    xpath=//div[text()="File"]
    BuiltIn.Should Not Be True    ${status}

Try accessing shadow dom with css
    ${status}=    BuiltIn.Run Keyword And Return Status
    ...        Browser.Get Element    css=div[smart-id="mainContainer"]
    BuiltIn.Should Be True    ${status}

Try accessing shadow dom with text
    ${status}=    BuiltIn.Run Keyword And Return Status
    ...        Browser.Get Element    text=File
    BuiltIn.Should Be True    ${status}

Avoid getting into shadow dom with :light engines
    ${status}=    BuiltIn.Run Keyword And Return Status
    ...        Browser.Get Element    css:light=div[smart-id="mainContainer"]
    BuiltIn.Should Not Be True    ${status}
    ${status}=    BuiltIn.Run Keyword And Return Status
    ...        Browser.Get Element    text:light=File
    BuiltIn.Should Not Be True    ${status}
    
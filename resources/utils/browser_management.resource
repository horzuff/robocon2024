*** Settings ***
Library            Browser

*** Keywords ***
Set up browser
    [Arguments]    ${browser}=chromium    ${headless}=True    ${slowMo}=0:00:00.5
    ...        ${viewport}={"width": 1920, "height": 1080}    ${url}=https://www.saucedemo.com/
    Browser.New Browser    ${browser}    ${headless}    slowMo=${slowMo}
    Browser.New Context    viewport=${viewport}
    Browser.New Page    url=${url}
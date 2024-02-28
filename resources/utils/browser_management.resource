*** Settings ***
Library            Browser
Variables          locators${/}login_page.yaml


*** Keywords ***
Open sauce labs demo site
    [Arguments]    ${browser}=chromium    ${headless}=True    ${slowMo}=0:00:00.5
    ...        ${viewport}={"width": 1920, "height": 1080}    ${url}=https://www.saucedemo.com/
    Browser.New Browser    ${browser}    ${headless}    slowMo=${slowMo}
    Browser.New Context    viewport=${viewport}
    Browser.New Page    url=${url}
    Browser.Wait For Elements State    ${username input}    visible    message=username field didn't load correctly
    Browser.Wait For Elements State    ${password input}    visible
    Browser.Wait For Elements State    ${login button}    visible
*** Settings ***
Library            Browser
Variables          locators${/}order_overview_page.yaml

*** Keywords ***
Finish order
    Browser.Click    ${finish order button}
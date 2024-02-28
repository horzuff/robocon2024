*** Settings ***
Library            Browser
Variables          locators${/}shopping_cart_page.yaml

*** Keywords ***
Go to checkout
    Browser.Click    ${go to checkout button}
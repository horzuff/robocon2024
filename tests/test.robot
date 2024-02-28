*** Settings ***
Library            Browser
Library            String
Library            Debugger
Library            Collections
Resource           utils${/}browser_management.resource
Resource           pages${/}login_page.resource
Resource           pages${/}products_page.resource
Resource           pages${/}shopping_cart_page.resource
Resource           pages${/}checkout_page.resource
Resource           pages${/}order_overview_page.resource
Resource           pages${/}header_area.resource

*** Test Cases ***
Sauce labs test 1
    browser_management.Open sauce labs demo site    headless=False    viewport={"width": 1360, "height": 766}
    @{logins}=    login_page.Get available logins
    ${password}=    login_page.Get password
    VAR    ${login}    ${logins}[0]    scope=SUITE
    login_page.Login    ${login}    ${password}
    products_page.Add item to cart    Sauce Labs Onesie
    products_page.Add item to cart    Sauce Labs Bike Light
    products_page.Add item to cart    Sauce Labs Backpack
    header_area.Go to shopping cart
    shopping_cart_page.Go to checkout
    checkout_page.Fill out shipping info    first name=Rob    last name=Ocon    post code=03-2024
    checkout_page.Continue to overview
    order_overview_page.Finish order
    header_area.Logout
    Browser.Close Browser

Sauce Labs test 2
    browser_management.Open sauce labs demo site    headless=False    viewport={"width": 1360, "height": 766}
    @{logins}=    login_page.Get available logins
    ${password}=    login_page.Get password
    VAR    ${login}    ${logins}[0]    scope=SUITE
    login_page.Login    ${login}    ${password}
    products_page.Set sorting    za
    products_page.Validate sorting    za
    header_area.Logout
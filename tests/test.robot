*** Settings ***
Library            Browser
Library            String
Library            Debugger
Library            Collections
Resource           .\utils\browser_management.resource
Resource           .\pages\login_page.resource
Resource           .\pages\main_page.resource

*** Test Cases ***
Sauce labs test 1
    browser_management.Set up browser    headless=False    viewport={"width": 1360, "height": 766}
    @{logins}=    login_page.Get available logins
    ${password}=    login_page.Get password
    VAR    ${login}    ${logins}[0]    scope=SUITE
    login_page.Login    ${login}    ${password}
    main_page.Add item to cart    Sauce Labs Onesie
    main_page.Add item to cart    Sauce Labs Bike Light
    main_page.Add item to cart    Sauce Labs Backpack
    Browser.Click    id=shopping_cart_container
    Browser.Click    id=checkout
    Browser.Fill Text    id=first-name    Rob
    Browser.Fill Text    id=last-name    Ocon
    Browser.Fill Text    id=postal-code    03-2024
    Browser.Click    id=continue
    Browser.Click    id=finish
    Browser.Click    id=react-burger-menu-btn
    Browser.Click    id=logout_sidebar_link
    Browser.Close Browser

Sauce Labs test 2
    browser_management.Set up browser    headless=False    viewport={"width": 1360, "height": 766}
    @{logins}=    login_page.Get available logins
    ${password}=    login_page.Get password
    VAR    ${login}    ${logins}[0]    scope=SUITE
    login_page.Login    ${login}    ${password}
    main_page.Set sorting    za
    main_page.Validate sorting    za
    

    Debugger.Debug
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
    Browser.New Browser    chromium    False    slowMo=0:00:00.5
    Browser.New Context    viewport={"width": 1366, "height": 768}
    Browser.New Page    url=https://www.saucedemo.com/
    Browser.Fill Text    xpath=//input[@name='user-name' and @id='user-name']    ${login}
    Browser.Fill Secret    id=password    $password
    Browser.Click    css=span.select_container
    Browser.Click    xpath=//option[@value='za']
    ${item elements}=    Browser.Get Elements    xpath=//div[contains(@class,"inventory_item_name")]
    @{items}=    BuiltIn.Create List
    FOR    ${element}    IN    @{item elements}
        ${item name}=    Browser.Get Text    ${element}
        ${item name}=    String.Convert To Lower Case    ${item name}
        Collections.Append To List    @{items}    ${item name}
    END
    FOR    ${index}    ${item}    IN ENUMERATE    @{items}
        IF    ${index} < (len(@{items})-1)
            BuiltIn.Should Be True    ${item} > ${items}[${index+1}]
        END
    END
    

    Debugger.Debug
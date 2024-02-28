*** Settings ***
Library            Browser
Library            OperatingSystem
Library            String
Library            Collections
Resource           utils${/}browser_management.resource
Resource           pages${/}login_page.resource
Resource           pages${/}products_page.resource
Resource           pages${/}shopping_cart_page.resource
Resource           pages${/}checkout_page.resource
Resource           pages${/}order_overview_page.resource
Resource           pages${/}header_area.resource

*** Test Cases ***
# Sauce labs test 1
#     browser_management.Open sauce labs demo site    headless=False    viewport={"width": 1360, "height": 766}
#     @{logins}=    login_page.Get available logins
#     ${password}=    login_page.Get password
#     VAR    ${login}    ${logins}[0]    scope=SUITE
#     login_page.Login    ${login}    ${password}
#     products_page.Add item to cart    Sauce Labs Onesie
#     products_page.Add item to cart    Sauce Labs Bike Light
#     products_page.Add item to cart    Sauce Labs Backpack
#     header_area.Go to shopping cart
#     shopping_cart_page.Go to checkout
#     checkout_page.Fill out shipping info    first name=Rob    last name=Ocon    post code=03-2024
#     checkout_page.Continue to overview
#     order_overview_page.Finish order
#     header_area.Logout
#     Browser.Close Browser

# Sauce Labs test 2
#     browser_management.Open sauce labs demo site    headless=False    viewport={"width": 1360, "height": 766}
#     @{logins}=    login_page.Get available logins
#     ${password}=    login_page.Get password
#     VAR    ${login}    ${logins}[0]    scope=SUITE
#     login_page.Login    ${login}    ${password}
#     products_page.Set sorting    za
#     products_page.Validate sorting    za
#     header_area.Logout
#     Browser.Close Browser

File downloading test
    browser_management.Set up browser    https://the-internet.herokuapp.com/download    headless=False
    Download by href
    Download with saveAs
    Download with promise
    Download with promise and saveas

File uploading test
    browser_management.Set up browser    https://the-internet.herokuapp.com/upload    headless=False
    Upload to input
    Upload with promise
    
*** Keywords ***

Download by href
    @{downloads}=    Browser.Get Elements    xpath=//div[@class="example"]//a[text()]
    ${href}=    Browser.Get Property    ${downloads}[0]    href
    ${file}=    Browser.Download    href=${href}
    ${actual_size}=    Get File Size    ${file.saveAs}

Download with saveAs
    @{downloads}=    Browser.Get Elements    xpath=//div[@class="example"]//a[text()]
    ${href}=    Browser.Get Property    ${downloads}[1]    href
    ${filename}=    Browser.Get Text    ${downloads}[1]
    ${file}=    Browser.Download    ${href}    saveAs=${OUTPUT_DIR}${/}${filename}
    OperatingSystem.File Should Exist    ${OUTPUT_DIR}${/}${filename}
    OperatingSystem.File Should Not Be Empty    ${OUTPUT_DIR}${/}${filename}
    VAR    ${test file}    ${OUTPUT_DIR}${/}${filename}    scope=SUITE

Download with promise
    @{downloads}=    Browser.Get Elements    xpath=//div[@class="example"]//a[text()]
    ${href}=    Browser.Get Property    ${downloads}[2]    href
    ${filename}=    Browser.Get Text    ${downloads}[2]
    ${download promise}=    Browser.Promise To Wait For Download
    Browser.Click    ${downloads}[2]
    ${file}=    Browser.Wait For    ${download promise}
    OperatingSystem.File Should Exist      ${file.saveAs}
    Should Be True    '${file.suggestedFilename}' != ${None}

Download with promise and saveas
    @{downloads}=    Browser.Get Elements    xpath=//div[@class="example"]//a[text()]
    ${href}=    Browser.Get Property    ${downloads}[3]    href
    ${filename}=    Browser.Get Text    ${downloads}[3]
    ${download promise}=    Browser.Promise To Wait For Download    ${OUTPUT_DIR}${/}${filename}
    Browser.Click    ${downloads}[3]
    ${file}=    Browser.Wait For    ${download promise}
    OperatingSystem.File Should Exist    ${OUTPUT_DIR}${/}${filename}
    OperatingSystem.File Should Not Be Empty    ${OUTPUT_DIR}${/}${filename}

Upload to input
    Browser.Upload File By Selector    id=file-upload    ${test file}
    Browser.Click    id=file-submit
    Browser.Wait For Elements State    id=uploaded-files    visible
    Browser.Go Back

Upload with promise
    ${upload promise}=    Browser.Promise To Upload File    ${test file}
    Browser.Click    id=file-upload
    ${upload result}=    Browser.Wait For    ${upload promise}
    Browser.Click    id=file-submit
    Browser.Wait For Elements State    id=uploaded-files    visible
    Browser.Go Back

*** Settings ***
Library            Browser
Library            String
Library            Collections

*** Keywords ***

Add item to cart
    [Arguments]    ${item name}
    ${lowercase itemname}=    String.Convert To Lower Case    ${item name}
    ${dash separated itemname}=    String.Replace String    ${lowercase itemname}    ${SPACE}    -
    VAR    ${add item locator}    id=add-to-cart-${dash separated itemname}
    Browser.Click    ${add item locator}

Set sorting
    [Arguments]    ${sorting type}
    Browser.Click    css=span.select_container
    Browser.Click    xpath=//option[@value='${sorting type}']

Validate sorting
    [Arguments]    ${sorting type}
    @{items}=    BuiltIn.Create List
    IF    '${sorting type}' in ['az', 'za']
        ${item elements}=    Browser.Get Elements    xpath=//div[contains(@class,"inventory_item_name")]
        FOR    ${element}    IN    @{item elements}
            ${item name}=    Browser.Get Text    ${element}
            ${item name}=    String.Convert To Lower Case    ${item name}
            Collections.Append To List    @{items}    ${item name}
        END
    ELSE IF    '${sorting type}' in ['lohi', 'hilo']
        ${item elements}=    Browser.Get Elements    xpath=//div[contains(@class,"inventory_item_price")]
        FOR    ${element}    IN    @{item elements}
            ${item name}=    Browser.Get Text    ${element}
            ${item name}=    String.Convert To Lower Case    ${item name}
            Collections.Append To List    @{items}    ${item name}
        END
    END
    ${actual order items}=    Collections.Copy List    ${items}
    Collections.Sort List    ${items}
    IF    ${sorting type} in ['za', 'hilo']
        Collections.Reverse List    ${items}
    END
    BuiltIn.Should Be Equal    ${items}    ${actual order items}
    

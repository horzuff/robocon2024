*** Settings ***
Library            Browser
Library            String
Library            Collections
Variables          locators${/}products_page.yaml

*** Keywords ***

Add item to cart
    [Arguments]    ${item name}
    ${lowercase itemname}=    String.Convert To Lower Case    ${item name}
    ${dash separated itemname}=    String.Replace String    ${lowercase itemname}    ${SPACE}    -
    #the following step is not mandatory, but I like to include it to make it more explicit what happens here
    ${add item locator}=    BuiltIn.Replace Variables   ${add item to cart by name}
    Browser.Click    ${add item locator}

Set sorting
    [Arguments]    ${sorting type}
    Browser.Click    ${sorting dropdown}
    Browser.Click    ${sorting option.${sorting type}}

Validate sorting
    [Arguments]    ${sorting type}
    @{items}=    BuiltIn.Create List
    IF    '${sorting type}' in ['az', 'za']
        ${item elements}=    Browser.Get Elements    ${item name label}
        FOR    ${element}    IN    @{item elements}
            ${item name}=    Browser.Get Text    ${element}
            ${item name}=    String.Convert To Lower Case    ${item name}
            Collections.Append To List    @{items}    ${item name}
        END
    ELSE IF    '${sorting type}' in ['lohi', 'hilo']
        ${item elements}=    Browser.Get Elements    ${item price label}
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
    

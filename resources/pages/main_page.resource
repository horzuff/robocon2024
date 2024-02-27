*** Settings ***
Library            Browser

*** Keywords ***
Add item to cart
    [Arguments]    ${item name}
    Browser.Click    xpath=//div[text()="${item name}"]/ancestor::div[@class="inventory_item_description"]//button[contains(@id,"add-to-cart-")]



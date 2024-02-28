*** Settings ***
Library            Browser
Library            String
Library            Collections
Variables          locators${/}header_area.yaml

*** Keywords ***

Go to shopping cart
    Browser.Click    id=shopping_cart_container

Expand options
    Browser.Click    id=react-burger-menu-btn

Logout
    Expand options
    Browser.Click    id=logout_sidebar_link

Open About
    Expand options
    Browser.Click    id=about_sidebar_link

Go to All Items
    Expand options
    Browser.Click    id=inventory_sidebar_link

Reset App State
    Expand options
    Browser.Click    id=reset_sidebar_link
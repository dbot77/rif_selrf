*** Settings ***
Documentation    Login Page class

*** Variables ***
${path_login_page}=    /wp-login.php

# Form elements
${loc_lgnform_user_field}=    id=user_login
${loc_lgnform_pw_field}=    id=user_pass
${loc_lgnform_login_btn}=    css=input[value="Log In"]

# Notification messages
${loc_lgnform_error_msg_text}=    id=login_error
${var_lgnform_invalid_unpw_error_text}=    ERROR: The username or password you entered is incorrect. Lost your password?


*** Keywords ***
lgnform_input_text_in_user_field
    [Arguments]    ${text}=${EMPTY}
    Wait Until Page Contains Element    ${loc_lgnform_user_field}
    Input Text    ${loc_lgnform_user_field}    ${text}

lgnform_user_field_displays_text
    [Arguments]    ${exp_text}=${EMPTY}
    Wait Until Page Contains Element    ${loc_lgnform_user_field}
    ${act_text}=    Get Text    ${loc_lgnform_user_field}
    Should Be Equal    ${exp_text}    ${act_text}

lgnform_pw_field_displays_text
    [Arguments]    ${exp_text}=${EMPTY}
    Wait Until Page Contains Element    ${loc_lgnform_pw_field}
    ${act_text}=    Get Text    ${loc_lgnform_pw_field}
    Should Be Equal    ${exp_text}    ${act_text}

lgnform_input_text_in_pw_field
    [Arguments]    ${text}=${EMPTY}
    Wait Until Page Contains Element    ${loc_lgnform_pw_field}
    Input Text    ${loc_lgnform_pw_field}    ${text}

lgnform_click_login_button
    wait_then_click_button    ${loc_lgnform_login_btn}

lgnform_invalid_unpw_error_msg_is_displayed
    Wait Until Page Contains Element    ${loc_lgnform_error_msg_text}
    ${exp_text}=    Set Variable    ${var_lgnform_invalid_unpw_error_text}
    ${act_text}=    Get Text    ${loc_lgnform_error_msg_text}
    ${act_text_st}=    Strip String    ${act_text}
    Should Be Equal    ${exp_text}    ${act_text_st}

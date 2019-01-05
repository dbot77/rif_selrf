*** Settings ***
Documentation    Lost Password Page class


*** Variables ***
${var_lostpw_page_path}=    wp-login.php?action=lostpassword
${loc_lostpwform_user_field}=    id=user_login
${loc_lostpwform_get_new_pw_btn}=    css=input[value="Get New Password"]
${loc_lostpwform_error_msg_text}=    id=login_error
${var_lostpwform_empty_input_error_msg_text}=    ERROR: Enter a username or email address.
${var_lostpwform_notfound_input_error_msg_text}=    ERROR: There is no user registered with that email address.

*** Keywords ***
lostpwform_input_text_in_email_field
    [Arguments]    ${text}=${EMPTY}
    Wait Until Page Contains Element    ${loc_lostpwform_user_field}
    Input Text    ${loc_lostpwform_user_field}    ${text}

lostpwform_error_msg_text_is_displayed
    [Arguments]    ${exp_error_text}
    Wait Until Page Contains Element    ${loc_lostpwform_error_msg_text}
    ${act_error_text}=    Get Text    ${loc_lostpwform_error_msg_text}
    ${act_error_text_st}=    Strip String    ${act_error_text}
    Should Be Equal    ${exp_error_text}   ${act_error_text_st}

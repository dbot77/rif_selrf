*** Settings ***
Documentation     Lost Password Path tests
Resource          ../resources/master.robot

Suite Setup       default_suite_setup
Test Teardown     default_test_teardown
Suite Teardown    default_suite_teardown
Force Tags        desktop    lost_pw


*** Test Cases ***
lostpw_page_submit_valid_email_happy_path
    [Tags]    smoke
    [Documentation]
    ...    PreCond: Clean browser (cleared cookies/cache) and User is logged out
    ...    1. Go to Lost Password Page
    ...    2. Enter valid Subscriber user email and submit
    ...    ER: User is directed to Lost PW Confirmation Page and confirmation message is displayed

    # 1. Go to Lost Password Page
    go_to_url    ${var_lostpw_page_path}

    # 2. Enter valid Subscriber email and submit
    lostpwform_input_text_in_email_field    ${test_subscriber_email}
    wait_then_click_button    ${loc_lostpwform_get_new_pw_btn}

    # ER: User is directed to Lost PW Confirmation Page and confirmation message is displayed
    Wait Until Page Does Not Contain Element    ${loc_lostpwform_get_new_pw_btn}
    lostpw_conf_page_displays_confirm_msg
    Location Should Contain    ${var_lostpw_conf_page_path}


lostpw_page_submit_empty_email
    [Documentation]
    ...    PreCond: Clean browser (cleared cookies/cache) and User is logged out
    ...    1. Go to Lost Password Page
    ...    2. Leave all fields empty and submit
    ...    ER: User remains on Lost Password Page and empty-input error message displays

    # 1. Go to Lost Password Page
    go_to_url    ${var_lostpw_page_path}

    # 2. Submit form
    wait_then_click_button    ${loc_lostpwform_get_new_pw_btn}

    # ER: User remains on Lost Password Page and error message displays
    Location Should Contain   ${var_lostpw_page_path}
    lostpwform_error_msg_text_is_displayed    ${var_lostpwform_empty_input_error_msg_text}


lostpw_page_submit_notfound_email
    [Documentation]
    ...    PreCond: Clean browser (cleared cookies/cache) and User is logged out
    ...    1. Go to Lost Password Page
    ...    2. Input not-found email (that does not exist in user table) and submit
    ...    ER: User remains on Lost Password Page and not-found error message displays

    # 1. Go to Lost Password Page
    go_to_url    ${var_lostpw_page_path}

    # 2. Input not-found email and submit
    lostpwform_input_text_in_email_field    notfound@robotsinfilm.com
    wait_then_click_button    ${loc_lostpwform_get_new_pw_btn}

    # ER: User remains on Lost Password Page and error message displays
    Location Should Contain   ${var_lostpw_page_path}
    lostpwform_error_msg_text_is_displayed    ${var_lostpwform_notfound_input_error_msg_text}

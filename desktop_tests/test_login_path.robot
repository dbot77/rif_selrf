*** Settings ***
Documentation     Login Path tests
Resource          ../resources/master.robot

Suite Setup       default_suite_setup
Test Teardown     default_test_teardown
Suite Teardown    default_suite_teardown
Force Tags        desktop    login


*** Test Cases ***
login_path_login_valid_creds_subscriber_happy_path
    [Tags]    smoke
    [Documentation]
    ...    PreCond: Clean browser (cleared cookies/cache) and User is logged out
    ...    1. Go to Login Page
    ...    2. Enter valid Subscriber un/pw and submit
    ...    ER: User redirected to Profile Page and correct username is displayed

    # 1. Go to Login Page
    go_to_url    ${path_login_page}

    # 2. Enter valid Subscriber un/pw and submit
    lgnform_input_text_in_user_field    ${test_subscriber_username}
    lgnform_input_text_in_pw_field    ${test_subscriber_password}
    lgnform_click_login_button

    # ER: User redirected to Profile Page and correct username is displayed
    Wait Until Page Does Not Contain Element    ${loc_lgnform_login_btn}
    profile_page_username_field_displays_correct_user    ${test_subscriber_username}

login_page_login_empty_creds
    [Documentation]
    ...    PreCond: Clean browser (cleared cookies/cache) and User is logged out
    ...    1. Go to Login Page
    ...    2. Leave all fields empty and submit
    ...    ER: User remains on Login Page and un/pw fields are empty

    # 1. Go to Login Page
    go_to_url    ${path_login_page}

    # 2. Submit form
    lgnform_click_login_button

    # ER: User remains on Login Page and un/pw fields are empty
    Location Should Contain    ${path_login_page}
    lgnform_user_field_displays_text   ${EMPTY}
    lgnform_pw_field_displays_text   ${EMPTY}

login_page_login_invalid_pw_creds
    [Documentation]
    ...    PreCond: Clean browser (cleared cookies/cache) and User is logged out
    ...    1. Go to Login Page
    ...    2. Enter valid un and invalid pw and submit
    ...    ER: User remains on Login Page and invalid un/pw msg is displayed

    # 1. Go to Login Page
    go_to_url    ${path_login_page}

    # 2. Enter valid un and invalid pw and submit
    lgnform_input_text_in_user_field    ${test_subscriber_username}
    lgnform_input_text_in_pw_field    "12345678"
    lgnform_click_login_button

    # ER: User remains on Login Page and error msg is displayed
    Location Should Contain    ${path_login_page}
    lgnform_invalid_unpw_error_msg_is_displayed

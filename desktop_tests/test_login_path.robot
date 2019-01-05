*** Settings ***
Documentation     Login Path tests
Resource          ../resources/master.robot

Suite Setup       default_suite_setup
Test Teardown     default_test_teardown
Suite Teardown    default_suite_teardown
Force Tags        desktop    login

# PreCond: User is logged out

*** Test Cases ***
login_path_login_valid_creds_subscriber_happy_path
    [Tags]    smoke
    # 1. Go to Login Page
    go_to_url    ${var_login_page_path}

    # 2. Enter valid Subscriber un/pw and submit
    lgnform_input_text_in_user_field    ${test_subscriber_username}
    lgnform_input_text_in_pw_field    ${test_subscriber_password}
    lgnform_click_login_button

    # ER: User redirected to Profile Page and correct username is displayed
    Wait Until Page Does Not Contain Element    ${loc_lgnform_login_btn}
    profile_page_username_field_displays_correct_user    ${test_subscriber_username}

login_page_login_empty_creds
    # 1. Go to Login Page
    go_to_url    ${var_login_page_path}

    # 2. Leave empty un/pw and submit
    lgnform_click_login_button

    # ER: User remains on Login Page and un/pw fields are empty
    Location Should Contain    ${var_login_page_path}
    lgnform_user_field_displays_text   ${EMPTY}
    lgnform_pw_field_displays_text   ${EMPTY}

login_page_login_invalid_pw_creds
    # 1. Go to Login Page
    go_to_url    ${var_login_page_path}

    # 2. Enter valid un and invalid pw and submit
    lgnform_input_text_in_user_field    ${test_subscriber_username}
    lgnform_input_text_in_pw_field    "12345678"
    lgnform_click_login_button

    # ER: User remains on Login Page and error msg is displayed
    Location Should Contain    ${var_login_page_path}
    lgnform_invalid_unpw_error_msg_is_displayed

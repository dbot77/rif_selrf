*** Settings ***
Documentation     Contact Page tests
Resource          ../resources/master.robot

Suite Setup       default_suite_setup
Test Teardown     default_test_teardown
Suite Teardown    default_suite_teardown
Force Tags        desktop    offsite

# PreCond: User is logged out & Clear cookies/cache

*** Test Cases ***
contact_pg_submit_form_valid_inputs_happy_path
    # 1. Go to Contact Page
    go_to_url    ${var_contact_page_path}

    # 2. Enter valid inputs in all form fields and submit
    contform_input_data_and_submit    This is a test.

    # ER: Form submits and confirmation message is displayed
    Wait Until Page Does Not Contain Element    ${loc_contform_container}
    get_element_text_and_compare_to_exp_text    ${loc_contform_conf_msg}    ${contform_conf_msg}    equals

contact_pg_submit_form_verify_req_fields
    # 1. Go to Contact Page
    go_to_url    ${var_contact_page_path}

    # 2. Click submit button (leave all fields empty)
    wait_then_click_button    ${loc_contform_submit_btn}

    # ER: Form does not submit and Req field error msg displays for applicable fields

    # Capture all label fields that should have Req field error msg (currently 1)
    @{list_elements}=    Get Webelements    ${loc_contform_req_field_error_msg}
    ${list_len} =	Get Length    ${list_elements}
    Should Be Equal As Integers    ${list_len}    1

    # Loop thru label list and verify Req field error msg is displayed for each
    :FOR  ${element}  IN  @{list_elements}
    \    get_element_text_and_compare_to_exp_text    ${element}    ${contform_req_field_error_msg}    equals

    # 3. Enter valid inputs in all required fields and submit
    contform_input_data_and_submit    This is a test.

    # ER: Form submits and confirmation message is displayed
    Wait Until Page Does Not Contain Element    ${loc_contform_msg_field}
    get_element_text_and_compare_to_exp_text    ${loc_contform_conf_msg}    ${contform_conf_msg}    equals
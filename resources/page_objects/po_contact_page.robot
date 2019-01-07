*** Settings ***
Documentation    Contact Page class

*** Variables ***
${var_contact_page_path}=    /contact/

# Form elements
${loc_contform_container}=    css=div.wpforms-container
${loc_contform_email_field}=    ${loc_contform_container}    input[type="email"]
${loc_contform_msg_field}=    ${loc_contform_container}    textarea
${loc_contform_submit_btn}=    ${loc_contform_container}    .wpforms-submit

# Notification messages
${loc_contform_req_field_error_msg}=    css=label.wpforms-error
${contform_req_field_error_msg}=    This field is required.
${loc_contform_conf_msg}=    css=.wpforms-confirmation-container-full p
${contform_conf_msg}=    Your message has been sent. Thank you!


*** Keywords ***
contform_input_data_and_submit
    [Arguments]    ${msg}=${EMPTY}

    # Input to Text box
    Wait Until Page Contains Element    ${loc_contform_msg_field}
    Input Text    ${loc_contform_msg_field}    ${msg}

    # Submit
    wait_then_click_button    ${loc_contform_submit_btn}

*** Settings ***
Documentation    Profile Page class


*** Variables ***
${var_prof_page_path}=    wp-admin/profile.php
${loc_prof_page_username_field}=    id=user_login


*** Keywords ***
profile_page_username_field_displays_correct_user
    [Arguments]    ${username}
    Wait Until Page Contains Element    ${loc_prof_page_username_field}
    Textfield Should Contain    ${loc_prof_page_username_field}    ${username}

*** Settings ***
Documentation     Title Page tests
Resource          ../resources/master.robot

Suite Setup       default_suite_setup
Test Teardown     default_test_teardown
Suite Teardown    default_suite_teardown
Force Tags        desktop    offsite


*** Test Cases ***
title_pg_title_details_are_displayed
    [Tags]    smoke
    [Documentation]
    ...    PreCond: Clean browser (cleared cookies/cache) and User is logged out
    ...    1. Go to a Title page
    ...    2. observe the content for each of the following elements: h1 text, title-specs, summary, and cast table headers
    ...    ER: Verify each element has content (not empty)

    # 1. Go to a title page
    go_to_url    ${var_title_page_path}

    # 2a. Get the text from each of the title details elements and save to list
    @{list_elements_text}=    Create List

    ${text}=    get_h1_text
    Append To List    ${list_elements_text}    ${text}

    ${text}=    Get Text    ${loc_title_page_title_specs_block}
    Append To List    ${list_elements_text}    ${text}

    ${text}=    Get Text    ${loc_title_page_summary_block}
    Append To List    ${list_elements_text}    ${text}

    # 2b. Get count of children under #title-details
    ${child_num}=    Get Element Count    css=#title-details > *

    # 2c. Set child index and get text for ROBOT CAST th locator
    ${i}=    Evaluate    (${child_num} - 1)
    ${text}=    Get Text    css=#title-details > table:nth-child(${i}) th
    Append To List    ${list_elements_text}    ${text}

    # 2d. Set child index and get text for NON-ROBOT CAST th locator
    ${i}=    Evaluate    "${child_num}"
    ${text}=    Get Text    css=#title-details > table:nth-child(${i}) th
    Append To List    ${list_elements_text}    ${text}

    # ER: Verify each element in the list is not empty
    :FOR  ${item}  IN  @{list_elements_text}
        \    Should Not Be Empty    ${item}

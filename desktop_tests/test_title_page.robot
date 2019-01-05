*** Settings ***
Documentation     Title Page tests
Resource          ../resources/master.robot

Suite Setup       default_suite_setup
Test Teardown     default_test_teardown
Suite Teardown    default_suite_teardown
Force Tags        desktop    offsite

# PreCond: User is logged out & Clear cookies/cache

*** Test Cases ***
title_pg_title_details_are_displayed
    # 1. Go to a title page
    go_to_url    ${var_title_page_path}

    # 2. Verify the following title details contain content:
    # h1 text, title-specs, summary, and cast table headers

    # Get the text from the elements, save to list and verify each has content (not empty):
    @{list_elements_text}=    Create List

    ${text}=    get_h1_text
    Append To List    ${list_elements_text}    ${text}

    ${text}=    Get Text    ${loc_title_page_title_specs_block}
    Append To List    ${list_elements_text}    ${text}

    ${text}=    Get Text    ${loc_title_page_summary_block}
    Append To List    ${list_elements_text}    ${text}

    # Get count of children under #title-details
    ${child_num}=    Get Element Count    css=#title-details > *

    # Set child index and get text for ROBOT CAST th locator
    ${i}=    Evaluate    (${child_num} - 1)
    ${text}=    Get Text    css=#title-details > table:nth-child(${i}) th
    Append To List    ${list_elements_text}    ${text}

    # Set child index and get text for NON-ROBOT CAST th locator
    ${i}=    Evaluate    "${child_num}"
    ${text}=    Get Text    css=#title-details > table:nth-child(${i}) th
    Append To List    ${list_elements_text}    ${text}

    :FOR  ${item}  IN  @{list_elements_text}
        \    Should Not Be Empty    ${item}

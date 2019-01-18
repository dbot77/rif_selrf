*** Settings ***
Documentation    Setup and Utility settings, variables and keywords

Library          BuiltIn
Library          Collections
Library          SeleniumLibrary
Library          String

Resource          component_objects/co_learn_more_widget.robot
Resource          component_objects/co_main_nav.robot
Resource          component_objects/co_recently_added_widget.robot
Resource          component_objects/co_search_widget.robot

Resource          page_objects/po_contact_page.robot
Resource          page_objects/po_home_page.robot
Resource          page_objects/po_library_page.robot
Resource          page_objects/po_login_page.robot
Resource          page_objects/po_lostpw_page.robot
Resource          page_objects/po_lostpw_conf_page.robot
Resource          page_objects/po_profile_page.robot
Resource          page_objects/po_search_results_page.robot
Resource          page_objects/po_title_page.robot

*** Variables ***

### SELENIUM SETTINGS ###
${browser}=      chrome
${sel_speed}=    .7

### DOMAIN URLS ###
${domain}=       https://blackbird77.com/wp    # Staging is default. Ok to alter (Ex. -v domain:https://robotsinfilm.com)

### TEST USERS ### (Do not alter)
${test_subscriber_username}=    SubTestUser
${test_subscriber_password}=    k0AkmbDeMQFKFwF9
${test_subscriber_email}=       robotsinfilm+subtestuser@gmail.com

### UTILITY VARS ###
${loc_h1}=    css=h1


*** Keywords ***
# SETUP AND TEARDOWN KEYWORDS
default_suite_setup
    Set Selenium Speed    ${sel_speed}
    Open Browser    ${domain}    ${browser}
    Set Window Size    1275    800


default_test_teardown
    Delete All Cookies


default_suite_teardown
    Close All Browsers


# UTILITY KEYWORDS
construct_full_url
    [Arguments]    ${path}=${EMPTY}
    ${domain}=    Set Variable If    '${domain}'=="https://blackbird77.com"    https://blackbird77.com/wp    ${domain}    # if stg, set full stg domain
    ${full_url}=    Catenate    SEPARATOR=    ${domain}    ${path}
    [return]    ${full_url}


go_to_url
    [Arguments]    ${path}=${EMPTY}
    ${full_url}=    construct_full_url    ${path}
    Go To    ${full_url}
    Location Should Be    ${full_url}


scroll_to_element
    [Arguments]    ${element}
    ${x_pos}=    Get Horizontal Position    ${element}
    ${y_pos}=    Get Vertical Position    ${element}
    Execute JavaScript    window.scrollTo(${x_pos}, ${y_pos} - 200);


wait_then_click_link
    [Arguments]    ${loc_link}
    Wait Until Page Contains Element    ${loc_link}
    Click Link   ${loc_link}


wait_then_click_button
    [Arguments]    ${loc_btn}
    Wait Until Page Contains Element    ${loc_btn}
    Click Button   ${loc_btn}


get_h1_text
    Wait Until Page Contains Element    ${loc_h1}
    ${text}=    Get Text    ${loc_h1}
    [return]    ${text}


get_element_text_and_compare_to_exp_text
    [Arguments]    ${loc}    ${exp_text}    ${action}
    Wait Until Page Contains Element    ${loc}
    #Sleep    5s    # helps debug Safari errors
    ${act_text}=    Get Text    ${loc}

    # Fix Special Cases where link text intentionally does not match page h1 text
    ${act_text_final}=    Set Variable If
    ...    '${act_text}'=="Welcome to Robots in Film!"    Home    ${act_text}     # For Home Page

    # Applicable comparison action is executed
    Run Keyword If    '${action}'=="equals"      Should Be Equal As Strings    ${act_text_final}    ${exp_text}
    Run Keyword If    '${action}'=="contains"    Should Contain                ${act_text_final}    ${exp_text}


loop_thru_links_verify_landing_page
    [Documentation]
    ...    This keyword is used for when a group of links are displayed as list items <li>
    ...    The locator for the links must be in nth-child format (so we can loop through the links the list) and
    ...    must be divided into two parts (pre index and post index). The index will be handled via the i variable in the loop
    ...    Arguments:
    ...    start_url: the page you want to run the test on (Home Page is default)
    ...    range: how many links you expect to be in the group of links
    ...    loc_link_pt1: The first half of the locator
    ...    loc_link_pt2: the second half of the locator
    ...    action: the type of comparison to verify the landing page is correct (either "equals" or "contains")

    [Arguments]    ${start_url}    ${range}    ${loc_link_pt1}    ${loc_link_pt2}    ${action}

    # LOOP through all links within the range and take actions on each
    :FOR  ${i}  IN RANGE  ${range}

        # Go to url if provided (if empty, start will be Home Page)
        \    Run Keyword Unless    '${start_url}'=='${EMPTY}'    go_to_url    ${start_url}

        # i starts at 0 by default, nth-child starts at 1 by default, and since i will represent
        # the nth-child's num, we need to add 1 to i to keep them in sync
        \    ${i}=    Evaluate    ${i}+1

        # Construct the full locator for the link
        \    ${loc_link_full}=    Catenate    SEPARATOR=    ${loc_link_pt1}    ${i}    ${loc_link_pt2}

        # Save the link's text then click it
        \    Wait Until Page Contains Element    ${loc_link_full}
        \    ${link_text}=    Get Text    ${loc_link_full}
        \    wait_then_click_link    ${loc_link_full}

        # Save landing page's h1 text & compare to link text
        \    get_element_text_and_compare_to_exp_text    ${loc_h1}    ${link_text}    ${action}

    # END LOOP

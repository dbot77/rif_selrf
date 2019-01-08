*** Settings ***
Documentation     Global Sidebar tests
Resource          ../resources/master.robot

Suite Setup       default_suite_setup
Test Teardown     default_test_teardown
Suite Teardown    default_suite_teardown
Force Tags        desktop    offsite    sidebar


*** Test Cases ***
globsb_lm_wgt_click_links_verify_landing_page
    [Documentation]
    ...    PreCond: Clean browser (cleared cookies/cache) and User is logged out
    ...    1. Go to any page that displays the global sidebar (ex. Home Page)
    ...    2. Learn More widget: For each link, click the link and verify landing page (compare link text to landing page h1 text)
    ...    ER: The user is directed to the correct landing page

    loop_thru_links_verify_landing_page
    ...    ${EMPTY}
    ...    3
    ...    ${loc_lm_wgt_link_pt1}
    ...    ${loc_lm_wgt_link_pt2}
    ...    contains


globsb_ra_wgt_click_links_verify_landing_page
    [Documentation]
    ...    PreCond: Clean browser (cleared cookies/cache) and User is logged out
    ...    1. Go to any page that displays the global sidebar (ex. Home Page)
    ...    2. Recently Added widget: For each link, click the link and verify landing page (compare link text to landing page h1 text)
    ...    ER: The user is directed to the correct landing page

    loop_thru_links_verify_landing_page
    ...    ${EMPTY}
    ...    3
    ...    ${loc_ra_wgt_link_pt1}
    ...    ${loc_ra_wgt_link_pt2}
    ...    contains

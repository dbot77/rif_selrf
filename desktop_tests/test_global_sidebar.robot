*** Settings ***
Documentation     Global Sidebar tests
Resource          ../resources/master.robot

Suite Setup       default_suite_setup
Test Teardown     default_test_teardown
Suite Teardown    default_suite_teardown
Force Tags        desktop    offsite    sidebar

# PreCond: User is logged out & Clear cookies/cache

*** Test Cases ***
globsb_lm_wgt_click_links_verify_landing_page
    [Documentation]
    ...    # 1. Go to any page with global sidebar (ex. Home Page)
    ...    # 2. Learn More widget: For each link, click the link and verify landing page (compare link text to h1 text)
    ...    # ER: The landing page is correct

    loop_thru_links_verify_landing_page
    ...    ${EMPTY}
    ...    3
    ...    ${loc_lm_wgt_link_pt1}
    ...    ${loc_lm_wgt_link_pt2}
    ...    contains


globsb_ra_wgt_click_links_verify_landing_page
    [Documentation]
    ...    # 1. Go to any page with global sidebar (ex. Home Page)
    ...    # 2. Recently Added widget: For each link, click the link and verify landing page (compare link text to h1 text)
    ...    # ER: The landing page is correct

    loop_thru_links_verify_landing_page
    ...    ${EMPTY}
    ...    3
    ...    ${loc_ra_wgt_link_pt1}
    ...    ${loc_ra_wgt_link_pt2}
    ...    contains

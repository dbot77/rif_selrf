*** Settings ***
Documentation     Global Header tests
Resource          ../resources/master.robot

Suite Setup       default_suite_setup
Test Teardown     default_test_teardown
Suite Teardown    default_suite_teardown
Force Tags        desktop    offsite

# PreCond: User is logged out & Clear cookies/cache

*** Test Cases ***
globhdr_main_nav_click_links_verify_landing_page
    [Tags]    smoke    header    main_nav
    # 1. Go to any page with global header (Ex. Home Page)
    # 2. Main Nav: For each link, click the link and verify landing page (compare link text to h1 text)
    # ER: The landing page is correct

    loop_thru_links_verify_landing_page
    ...    ${EMPTY}
    ...    5
    ...    ${loc_main_nav_link_pt1}
    ...    ${loc_main_nav_link_pt2}
    ...    contains

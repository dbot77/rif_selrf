*** Settings ***
Documentation     Global Header tests
Resource          ../resources/master.robot

Suite Setup       default_suite_setup
Test Teardown     default_test_teardown
Suite Teardown    default_suite_teardown
Force Tags        desktop    offsite


*** Test Cases ***
globhdr_main_nav_click_links_verify_landing_page
    [Tags]    smoke    header    main_nav
    [Documentation]
    ...    PreCond: Clean browser (cleared cookies/cache) and User is logged out
    ...    1. Go to any page that displays the global header (Ex. Home Page)
    ...    2. Main Nav: For each link, click the link and verify landing page (compare link text to landing page h1 text)
    ...    ER: The user is directed to the correct landing page

    loop_thru_links_verify_landing_page
    ...    ${EMPTY}
    ...    5
    ...    ${loc_main_nav_link_pt1}
    ...    ${loc_main_nav_link_pt2}
    ...    contains

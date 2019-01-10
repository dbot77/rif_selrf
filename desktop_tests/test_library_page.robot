*** Settings ***
Documentation     Library Page tests
Resource          ../resources/master.robot

Suite Setup       default_suite_setup
Test Teardown     default_test_teardown
Suite Teardown    default_suite_teardown
Force Tags        desktop    offsite


*** Test Cases ***
lib_pg_bycat_wgt_click_links_verify_landing_page
    [Documentation]
    ...    PreCond: Clean browser (cleared cookies/cache) and User is logged out
    ...    1. Go to Library Page
    ...    2. By Category widget: For each link, click the link and verify landing page (compare link text to landing page h1 text)
    ...    ER: The user is directed to the correct landing page

    loop_thru_links_verify_landing_page
    ...    ${path_lib_page}
    ...    3
    ...    ${loc_bycat_wgt_link_pt1}
    ...    ${loc_bycat_wgt_link_pt2}
    ...    contains

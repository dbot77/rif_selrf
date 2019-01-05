*** Settings ***
Documentation     RiF Library Page tests
Resource          ../resources/master.robot

Suite Setup       default_suite_setup
Test Teardown     default_test_teardown
Suite Teardown    default_suite_teardown
Force Tags        desktop    offsite

# PreCond: User is logged out & Clear cookies/cache

*** Test Cases ***
lib_pg_bycat_wgt_click_links_verify_landing_page
    # 1. Go to RiF Library Page
    # 2. By Category widget: For each link, click the link and verify landing page (compare link textto h1 text)
    # ER: The landing page is correct

    loop_thru_links_verify_landing_page
    ...    ${var_lib_page_path}
    ...    3
    ...    ${loc_bycat_wgt_link_pt1}
    ...    ${loc_bycat_wgt_link_pt2}
    ...    contains

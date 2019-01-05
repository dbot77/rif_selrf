*** Settings ***
Documentation     Search Path tests
Resource          ../resources/master.robot

Suite Setup       default_suite_setup
Test Teardown     default_test_teardown
Suite Teardown    default_suite_teardown
Force Tags        desktop    search    offsite

# PreCond: User is logged out & Clear cookies/cache

*** Test Cases ***
srch_path_globsb_submit_search_has_results_with_pag_happy_path
    [Tags]    smoke    sidebar
    # 1. Go to Home Page
    # 2. Sidebar Search widget: Submit a search term that has results with pagination (ex. star)
    ${srch_term}=    Set Variable    star
    srch_wgt_input_text_and_submit    ${loc_srch_wgt_text_box_globsb}    ${loc_srch_wgt_submit_btn_globsb}    ${srch_term}

    # ER: User directed to Search Results Page and h1 title text contains search term
    ${title_text}=    get_h1_text
    Should Contain    ${title_text}    ${srch_term}

    # 3. Save all search result titles in a list
    @{list_titles_elements}=    Get Webelements    ${loc_srch_rslt_h2_title_link}
    ${list_titles_text}=    Create List    # create empty list to store titles
    :FOR    ${element}    IN    @{list_titles_elements}
        \   ${text}=    Get Text    ${element}
        \   Append To List    ${list_titles_text}    ${text}

    # 4. At bottom of results, click right arrow (next page) pagination button
    wait_then_click_link    ${loc_srch_rslt_pag_next_arrow}

    # ER: User directed to next results page and h1 title text contains search term
    ${title_text}=    get_h1_text
    Should Contain    ${title_text}    ${srch_term}

    # ER: Add page 2 result titles to list and verify no dupes vs page 1
    @{list_titles_elements}=    Get Webelements    ${loc_srch_rslt_h2_title_link}
    :FOR    ${element}    IN    @{list_titles_elements}
        \   ${text}=    Get Text    ${element}
        \   Append To List    ${list_titles_text}    ${text}

    List Should Not Contain Duplicates    ${list_titles_text}

    # 5. Click the first search result on the current page
    # ER: User is directed to corresponding page (link text matches page's title text)
    ${link_text}=    Get Text    ${loc_srch_rslt_h2_title_link}
    wait_then_click_link    ${loc_srch_rslt_h2_title_link}
    get_element_text_and_compare_to_exp_text    ${loc_h1}    ${link_text}    equals


srch_path_srch_rslt_pg_submit_search_no_results
    [Tags]
    # 1. Go to Search Results Page with Search widget displayed
    go_to_url    ${srch_rslt_page_path_displays_srch_wgt}

    # 2. Search widget: Submit a search term that has results with pagination (ex. star)
    ${srch_term}=    Set Variable    wxyz
    srch_wgt_input_text_and_submit    ${loc_srch_wgt_text_box_srch_rslt_pg}    ${loc_srch_wgt_submit_btn_srch_rslt_pg}    ${srch_term}

    # ER: User directed to Search Results Page and no results message displays
    ${act_text}=    Get Text    ${loc_srch_rslt_no_result_msg_text}
    Should Be Equal As Strings    ${act_text}    ${srch_rslt_no_result_msg_text}

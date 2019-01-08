*** Settings ***
Documentation     Search Path tests
Resource          ../resources/master.robot

Suite Setup       default_suite_setup
Test Teardown     default_test_teardown
Suite Teardown    default_suite_teardown
Force Tags        desktop    search    offsite


*** Test Cases ***
srch_path_globsb_submit_search_has_results_with_pag_happy_path
    [Tags]    smoke    sidebar
    [Documentation]
    ...    PreCond: Clean browser (cleared cookies/cache) and User is logged out
    ...    1. Go to Home Page
    ...    2. In the Global sidebar Search widget: Submit a search term that has paginated results (ex. star)
    ...    ER: User is directed to the Search Results Page and h1 title text contains search term
    ...    3. Review the Page 1 search results, scroll down and click the Next arrow button and review the Page 2 search results
    ...    ER: There aren't any duplicate results
    ...    4. Click the first search result on page 2
    ...    ER: User is directed to the corresponding Title page (link text matches page's title text)

    # 1. Go to Home Page (handled via Suite Setup)

    # 2. Sidebar Search widget: Submit a search term that has results with pagination (ex. star)
    ${srch_term}=    Set Variable    star
    srch_wgt_input_text_and_submit    ${loc_srch_wgt_text_box_globsb}    ${loc_srch_wgt_submit_btn_globsb}    ${srch_term}

    # ER: User directed to Search Results Page and h1 title text contains search term
    ${title_text}=    get_h1_text
    Should Contain    ${title_text}    ${srch_term}

    # 3a. Save all  page 1 search result titles in a list
    @{list_titles_elements}=    Get Webelements    ${loc_srch_rslt_h2_title_link}
    ${list_titles_text}=    Create List    # create empty list to store titles
    :FOR    ${element}    IN    @{list_titles_elements}
        \   ${text}=    Get Text    ${element}
        \   Append To List    ${list_titles_text}    ${text}

    # 3b. At bottom of results, click right arrow (next page) pagination button
    wait_then_click_link    ${loc_srch_rslt_pag_next_arrow}

    # ER: User directed to page 2 and h1 title text contains search term
    ${title_text}=    get_h1_text
    Should Contain    ${title_text}    ${srch_term}

    # 3c: Add page 2 result titles to list
    @{list_titles_elements}=    Get Webelements    ${loc_srch_rslt_h2_title_link}
    :FOR    ${element}    IN    @{list_titles_elements}
        \   ${text}=    Get Text    ${element}
        \   Append To List    ${list_titles_text}    ${text}

    # ER: Verify no dupes on page 2 vs page 1
    List Should Not Contain Duplicates    ${list_titles_text}

    # 4. Click the first search result on the current page
    # ER: User is directed to the corresponding Title page (link text matches page's title text)
    ${link_text}=    Get Text    ${loc_srch_rslt_h2_title_link}
    wait_then_click_link    ${loc_srch_rslt_h2_title_link}
    get_element_text_and_compare_to_exp_text    ${loc_h1}    ${link_text}    equals


srch_path_srch_rslt_pg_submit_search_no_results
    [Documentation]
    ...    PreCond: Clean browser (cleared cookies/cache) and User is logged out
    ...    1. Go to the Search Results Page with Search widget displayed
    ...    2. Search widget: Submit a search term that wil not return any results (ex. wxyz)
    ...    ER: User is directed to Search Results Page and no results message displays

    # 1. Go to Search Results Page with Search widget displayed
    go_to_url    ${srch_rslt_page_path_displays_srch_wgt}

    # 2. Search widget: Submit a search term that wil not return any results
    srch_wgt_input_text_and_submit    ${loc_srch_wgt_text_box_srch_rslt_pg}    ${loc_srch_wgt_submit_btn_srch_rslt_pg}    wxyz

    # ER: User directed to Search Results Page and no results message displays
    ${act_text}=    Get Text    ${loc_srch_rslt_no_result_msg_text}
    Should Be Equal As Strings    ${act_text}    ${srch_rslt_no_result_msg_text}

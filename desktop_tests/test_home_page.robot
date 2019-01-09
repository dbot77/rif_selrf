*** Settings ***
Documentation     Home Page tests
Resource          ../resources/master.robot

Suite Setup       default_suite_setup
Suite Teardown    default_suite_teardown
Test Teardown     default_test_teardown
Force Tags        desktop    offsite


*** Test Cases ***
hp_splt_widget_click_links_verify_landing_page
    [Documentation]
    ...    PreCond: Clean browser (cleared cookies/cache) and User is logged out
    ...    1. Go to the Home Page
    ...    2. In the Robot Spotlight widget, click the link in the first feature box and verify landing page (compare link text to landing page h1 text)
    ...    ER: The user is directed to the correct landing page
    ...    3. Go to the Home Page
    ...    4. In the Robot Spotlight widget, click the View All link and verify landing page (compare link text to landing page h1 text)
    ...    ER: The user is directed to the correct landing page

    # 1. Go to the Home Page (handled via Suite Setup)

    # 2a. In the Spotlight widget, save the Title name for the first feature box
    ${hp_title_name}=    hp_splt_widget_feat_box_get_title_name

    # 2b. Click the title name link for the box
    wait_then_click_link    ${loc_hp_splt_widget_feat_box_title_name_link}

    # 2c. On the landing page, save the h1 Title text
    ${titlepg_title_name}=    get_h1_text

    # 2d. Compare the h1 Title text (#4) to the Title name text (#2)
    # ER: They are the same
    Should Contain    ${titlepg_title_name}    ${hp_title_name}

    # 3. Go to the Home Page
    go_to_url    ${path_home_page}

    # 4a. In the Spotlight widget, save the View All link text
    ${view_all_text}=    hp_splt_widget_viewall_box_get_view_all_link_text

    # 4b. Click the View All link
    wait_then_click_link    ${loc_hp_splt_widget_viewall_box_view_all_link}

    # 4c. On the Tag Page, save the h1 Title text
    ${tagpg_title_name}=    get_h1_text

    # 4d. Extract the tag name from the h1 text string
    ${tagpg_tag_name}=    Get Substring    ${tagpg_title_name}    5

    # 4e. Compare the tag name (#9) to the View All Link text (#6)
    # ER: The View All text contains the tag name
    Should Contain    ${view_all_text}    ${tagpg_tag_name}

*** Settings ***
Documentation     Home Page tests
Resource          ../resources/master.robot

Suite Setup       default_suite_setup
Suite Teardown    default_suite_teardown
Test Teardown     default_test_teardown
Force Tags        desktop    offsite

# PreCond: User is logged out & Clear cookies/cache

*** Test Cases ***
hp_splt_widget_click_links_verify_landing_page
    # 1. Go to the Home Page

    # 2. In the Spotlight widget, save the Title name for the first feature box
    ${hp_title_name}=    hp_splt_widget_feat_box_get_title_name

    # 3. Click the title name link for the box
    wait_then_click_link    ${loc_hp_splt_widget_feat_box_title_name_link}

    # 4. On the landing page, save the h1 Title text
    ${titlepg_title_name}=    get_h1_text

    # 5. Compare the h1 Title text (#4) to the Title name text (#2)
    # ER: They are the same
    Should Contain    ${titlepg_title_name}    ${hp_title_name}

    # 5. Go to the Home Page
    go_to_url    ${var_home_page_path}

    # 6. In the Spotlight widget, save the View All link text
    ${view_all_text}=    hp_splt_widget_viewall_box_get_view_all_link_text

    # 7. Click the View All link
    wait_then_click_link    ${loc_hp_splt_widget_viewall_box_view_all_link}

    # 8. On the Tag Page, save the h1 Title text
    ${tagpg_title_name}=    get_h1_text

    # 9. Extract the tag name from the h1 text string
    ${tagpg_tag_name}=    Get Substring    ${tagpg_title_name}    5

    # 9. Compare the tag name (#9) to the View All Link text (#6)
    # ER: The View All text contains the tag name
    Should Contain    ${view_all_text}    ${tagpg_tag_name}

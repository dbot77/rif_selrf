*** Settings ***
Documentation    Home Page class


*** Variables ***
${var_home_page_path}=    /

# Robot Spotlight widget
${loc_hp_splt_widget_feat_box_title_name_link}=    css=.feat-box.spotlight .title-name a
${loc_hp_splt_widget_viewall_box_view_all_link}=    css=#view-all-box-spotlight .view-all-link a


*** Keywords ***
hp_splt_widget_feat_box_get_title_name
# Spotlight widget - in the first feat-box, get the title name link text
    Wait Until Page Contains Element    ${loc_hp_splt_widget_feat_box_title_name_link}
    ${text}=    Get Text    ${loc_hp_splt_widget_feat_box_title_name_link}
    # Remove the ellipsis (if present)
    ${text}=    Remove String    ${text}    ...
    [return]    ${text}

hp_splt_widget_viewall_box_get_view_all_link_text
# Spotlight widget - in the view-all-box, get the VIew All link text
    Wait Until Page Contains Element    ${loc_hp_splt_widget_viewall_box_view_all_link}
    ${text}=    Get Text    ${loc_hp_splt_widget_viewall_box_view_all_link}
    [return]    ${text}

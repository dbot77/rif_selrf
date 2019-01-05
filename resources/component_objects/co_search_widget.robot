*** Settings ***
Documentation    Search widget class
...    This widget appears in multiple locations on the site.
...    The widget's core elements are always the same regardless of location.
...    To denote the widgets in their different locations we combine the location's parent locator with the widget's core locators
...    The location is referenced in the variable name:
...    globsb = appears in the sidebar
...    srch_rslt_pg = appears on the No Results version of the Search Results Page


*** Variables ***
${loc_srch_wgt_text_box}=    input[type="search"]
${loc_srch_wgt_submit_btn}=    button[type="submit"]

# Location-specific locators ###
# in Global Sidebar
${loc_globsb_container}=    css=aside#secondary
${loc_srch_wgt_text_box_globsb}=    ${loc_globsb_container}    ${loc_srch_wgt_text_box}
${loc_srch_wgt_submit_btn_globsb}=    ${loc_globsb_container}    ${loc_srch_wgt_submit_btn}

# on Search Results Page
${loc_srch_rslt_pg_container}=    css=div.page-content
${loc_srch_wgt_text_box_srch_rslt_pg}=    ${loc_srch_rslt_pg_container}    ${loc_srch_wgt_text_box}
${loc_srch_wgt_submit_btn_srch_rslt_pg}=    ${loc_srch_rslt_pg_container}    ${loc_srch_wgt_submit_btn}

*** Keywords ***
srch_wgt_input_text_and_submit
    [Arguments]    ${loc_text_box}    ${loc_submit_btn}    ${srch_term}=${EMPTY}
    Wait Until Page Contains Element    ${loc_text_box}
    Input Text    ${loc_text_box}    ${srch_term}
    Click Button    ${loc_submit_btn}


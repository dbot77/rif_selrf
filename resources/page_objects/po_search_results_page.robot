*** Settings ***
Documentation    Search Results Page class


*** Variables ***
${srch_rslt_page_path_displays_srch_wgt}=    ?s=aaaa
${loc_srch_rslt_pag_next_arrow}=    css=a.next.page-numbers
${loc_srch_rslt_h2_title_link}=    css=h2.entry-title a
${loc_srch_rslt_no_result_msg_text}=    css=section.no-results p
${srch_rslt_no_result_msg_text}=    Sorry, but nothing matched your search terms. Please try again with some different keywords.


*** Keywords ***


*** Settings ***
Documentation    Lost Password Confirmation Page class


*** Variables ***
${var_lostpw_conf_page_path}=    /wp-login.php?checkemail=confirm
${loc_lostpw_conf_page_conf_msg_text}=    css=p.message
${lostpw_conf_page_conf_msg_text}=    Check your email for the confirmation link.


*** Keywords ***
lostpw_conf_page_displays_confirm_msg
    Wait Until Page Contains Element    ${loc_lostpw_conf_page_conf_msg_text}
    ${act_text}=    Get Text    ${loc_lostpw_conf_page_conf_msg_text}
    ${act_text_strp}=    Strip String    ${act_text}    # trims spaces from ends
    Should Be Equal    ${lostpw_conf_page_conf_msg_text}    ${act_text_strp}

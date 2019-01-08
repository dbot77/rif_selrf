## UI desktop automation scripts for Selenium with Robot Framework.

Supported desktop browsers: Chrome, Firefox and Safari (OSX)

#### General:
- All Setup and Utility settings, variables and keywords are contained in file master.robot. This file may eventually be broken into smaller files if/when it gets too large.
- New page or component object classes need to be added to the Resource list in master.robot. 

#### Keywords:
- Native Selenium and Robot Framework keywords are in format "My Keyword ABC" (first letter uppercase, all other letters lowercase, spaces between words)
- Custom keywords are in format "my_keyword_xyz" (all lowercase with underscores, no spaces)
- You will only be creating **Custom** keywords.
- Upper/lowercase and space/underscore names are interpreted as the same keyword ("My Keyword" is same as "my_keyword") so do not duplicate any of the Native keywords in this manner. It will cause an error in your script.

#### Variables:
- Variable format is "my_variable" (all lowercase with underscores, no spaces)
- If a variable is for an element locator, "loc_" should be prepended to the variable name
- If a variable is for a page's path ("/contact/"), the variable name should be in format "x_page_path" ("contact_page_path").



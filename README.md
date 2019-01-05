## UI desktop automation scripts for Selenium with Robot Framework.

Supported desktop browsers: Chrome, Firefox and Safari

#### File Structure:
- All Setup and Utility settings, variables and keywords are contained in file master.robot. This file may eventually be broken into smaller files if/when it gets too large.
- New page or component object classes need to be added to the Resource list in master.robot. 

#### Keywords:
- Default Selenium and Robot Framework keywords are in format "My Keyword ABC" (first letter uppercase, all other letters lowercase, spaces between words)
- Custom keywords are in format "my_keyword_xyz" (all lowercase with underscores, no spaces)
- Upper/lowercase and space/underscore names are interpreted as the same keyword which will cause errors. Ex. "My Keyword" is the same as "my_keyword" (will cause error if you have both in your scripts)

#### Variables:
- Variable format is "my_variable" (all lowercase with underscores, no spaces)
- If a variable is for an element locator, "loc_" should be prepended to the variable name
- If a variable is for a page's path, the variable name should be in format "x_page_path". Ex. "contact_page_path"



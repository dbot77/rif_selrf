## UI desktop automation scripts for Selenium with Robot Framework.

Supported desktop browsers (OSX): Chrome, Firefox and Safari

#### Running tests in Terminal:

If browser or domain value is not submitted, the tests will run by default on the Staging environment in Chrome. For example:

- robot -L debug desktop_tests

To alter the domain or browser, pass values to the "browser" or "domain" variables. For example:

- robot -v browser:firefox -v domain:https://robotsinfilm.com -L debug desktop_tests

Access to the Login/LostPW sections of the site are protected. To run all tests that are not in protected areas, use the "offsite" tag. For example:

- robot -L debug -i offsite desktop_tests

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
- If a variable is for a page's path ("/contact/"), "path_" should be prepended to the variable name



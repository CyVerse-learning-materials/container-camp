---
name: RST file content to update
about: List improvements for an individual RST file.
title: Improvements for [RST file] Release [X.X.X]
labels: 2.0 Release
assignees: ''

---

This is a checklist issue for reviewing content within a specific RST.

### 1. Changes to be made to content

- [ ] Some changes
- [ ] Other updates
- [ ] Images to be added
- [ ] Formatting 
- [ ] etc...

### 2. Check on the following required formatting for all pages

- [ ] All `.rst` pages begin with the following
    ````
    .. include:: cyverse_rst_defined_substitutions.txt
    .. include:: custom_urls.txt

     |CyVerse_logo|_

    |Home_Icon|_
    `Learning Center Home <http://learning.cyverse.org/>`_
    ````

- [ ]  Documentation contains the fix/improve instructions on all `.rst` pages
    ````
    **Fix or improve this documentation**

    - Search for an answer:
       |CyVerse Learning Center|
    - Ask us for help:
      click |Intercom| on the lower right-hand side of the page
    - Report an issue or submit a change:
      |Github Repo Link|
    - Send feedback: `Tutorials@CyVerse.org <Tutorials@CyVerse.org>`_
    ````

- [ ] All hyperlinks in documentation are on the repo's `custom_urls.txt` or `cyverse_rst_defined_substitutions.txt`
 **Note**:  We want to avoid:
    -  Best practice is to AVOID inline hyperlinks
    -  Where possible links should NOT be on the `.rst` page but on a single
        document that is included. (e.g. `custom_urls.txt` or `cyverse_rst_defined_substitutions.txt`)
    - Links should have the form below and open in a new tab:
        ````
            .. |Link Title| raw:: html

           <a href="https://LINK.URL" target="blank">Link Title</a>


### 3. Overall quality control 

- [ ] Editor has checked for quality (spelling, formatting, etc.)
- [ ] Sample/test data is available with anonymous/public read access
      in the appropriate directory at `/iplant/home/shared/cyverse_training`

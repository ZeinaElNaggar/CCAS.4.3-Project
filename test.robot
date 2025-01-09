*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                  http://localhost:5174  # Replace with your app's URL
${BROWSER}              Edge
${DELAY}                2s

*** Test Cases ***
TC_009 Verify Adoption Application Notification Email
    [Documentation]    Integration Testing
    [Documentation]    Preconditions: User submitted an adoption form.
    [Documentation]    Valid email address linked to user account.
    [Documentation]    Steps:
    ...                1. Submit an adoption application.
    ...                2. Wait for application processing.
    ...                3. Check email.
    [Documentation]    Expected Result: User receives an email about the application status.
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    ${DELAY}

    # Submit adoption form
    Click Element    xpath=//a[contains(text(), 'Adoption Form')]
    Wait Until Page Contains    Adoption Form    20s
    Input Text    name=animalName    Bella
    Input Text    name=userEmail    valid_user@example.com
    Click Button    xpath=//button[contains(text(), 'Submit')]
    Wait Until Page Contains    Application Submitted    30s

    # Verify email notification (pseudo-step for email verification)
    Verify Email Received    subject=Adoption Application Received    recipient=valid_user@example.com

    Log    TC_009 completed successfully.
    Close Browser

---

TC_010 Verify Shelter Staff Can Add a New Animal Profile
    [Documentation]    System Testing
    [Documentation]    Preconditions: Staff account exists.
    [Documentation]    Animal profile details (e.g., species, age).
    [Documentation]    Steps:
    ...                1. Log in as shelter staff.
    ...                2. Navigate to the "Add Profile" page.
    ...                3. Enter details.
    [Documentation]    Expected Result: New profile is successfully added and appears in the gallery.
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    ${DELAY}

    # Log in as shelter staff
    Input Text    name=username    staff_user
    Input Text    name=password    secure_password
    Click Button    xpath=//button[contains(text(), 'Log In')]
    Wait Until Page Contains    Welcome, Staff    20s

    # Navigate to "Add Profile" page
    Click Element    xpath=//a[contains(text(), 'Add Profile')]
    Wait Until Page Contains    Add Animal Profile    20s

    # Enter animal details
    Input Text    name=species    Dog
    Input Text    name=age        2
    Input Text    name=name       Max
    Click Button    xpath=//button[contains(text(), 'Submit')]
    Wait Until Page Contains    Profile Added Successfully    20s

    # Verify profile appears in the gallery
    Navigate To    ${URL}/gallery
    Wait Until Page Contains    Max

    Log    TC_010 completed successfully.
    Close Browser

---

TC_001 Verify Search and Filter Functionality
    [Documentation]    Integration Testing
    [Documentation]    Preconditions: Test data for animals exists in the database.
    [Documentation]    Steps:
    ...                1. Navigate to the search page.
    ...                2. Enter criteria.
    ...                3. Apply filters.
    ...                4. View results.
    [Documentation]    Expected Result: Gallery displays animals matching the search query and filters.
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    ${DELAY}

    # Navigate to search page
    Click Element    xpath=//a[contains(text(), 'Search')]
    Wait Until Page Contains    Search Animals    20s

    # Enter search criteria and apply filters
    Input Text    name=searchQuery    Dogs
    Select From List By Value    name=ageFilter    Puppy
    Click Button    xpath=//button[contains(text(), 'Search')]

    # Verify results
    Wait Until Page Contains    Dogs
    Wait Until Page Contains    Puppy

    Log    TC_001 completed successfully.
    Close Browser

---

*** Keywords ***
Verify Email Received
    [Arguments]    ${SUBJECT}    ${RECIPIENT}
    Log    Verifying email with subject "${SUBJECT}" for recipient "${RECIPIENT}"
    # Implement actual email verification logic here, e.g., using an email testing tool or API.
    # Placeholder for demonstration purposes.
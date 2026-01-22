def create_playwright_skill
  create_file '.opencode/skills/playwright/SKILL.md', <<~'MARKDOWN'
    ---
    description: "Write and execute Playwright end-to-end tests for the application."
    tool_dependencies:
      - playwright_browser_navigate
      - playwright_browser_click
      - playwright_browser_fill_form
      - playwright_browser_take_screenshot
      - playwright_browser_run_code
      - playwright_browser_wait_for
    ---

    # Playwright Skill

    You are an expert in writing and executing end-to-end tests using Playwright. Your goal is to ensure the application functions correctly from a user's perspective by simulating real user interactions.

    ## Instructions

    1.  **Analyze Requirements:** Understand what critical user flows need to be tested (e.g., sign up, login, creating a resource, checkout).
    2.  **Write Tests:** Create Playwright test scripts. Focus on resilience and user-centric actions (click by role, fill by label).
    3.  **Execute Tests:** Run the tests to verify the application's behavior.
    4.  **Debug & Fix:** If tests fail, analyze the screenshots or logs, fix the application code or the test script, and re-run.

    ## Best Practices

    -   **Locators:** Prefer user-facing locators like `getByRole`, `getByLabel`, `getByText`. Avoid using brittle CSS selectors or XPaths unless absolutely necessary.
    -   **Resilience:** Use auto-waiting assertions. Playwright waits for elements to be actionable before interacting.
    -   **Isolation:** Ensure tests are independent. Use a fresh browser context or incognito window for each test scenario if needed.
    -   **Screenshots:** Take screenshots on failure to help with debugging.

    ## Example Scenarios

    -   **Authentication:** Verify a user can sign up and log in.
    -   **CRUD Operations:** Verify a user can create, read, update, and delete a resource.
    -   **Navigation:** Verify links and menus work as expected.
    -   **Form Validation:** Verify error messages appear for invalid inputs.

    ## Usage

    When you need to verify a feature works end-to-end, load this skill and instruct it to "Test the [feature name] flow."
  MARKDOWN
end

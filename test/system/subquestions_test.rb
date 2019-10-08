require "application_system_test_case"

class SubquestionsTest < ApplicationSystemTestCase
  setup do
    @subquestion = subquestions(:one)
  end

  test "visiting the index" do
    visit subquestions_url
    assert_selector "h1", text: "Subquestions"
  end

  test "creating a Subquestion" do
    visit subquestions_url
    click_on "New Subquestion"

    fill_in "Code", with: @subquestion.code
    fill_in "Exact value", with: @subquestion.exact_value
    fill_in "Position", with: @subquestion.position
    fill_in "Question", with: @subquestion.question_id
    fill_in "Value", with: @subquestion.value
    click_on "Create Subquestion"

    assert_text "Subquestion was successfully created"
    click_on "Back"
  end

  test "updating a Subquestion" do
    visit subquestions_url
    click_on "Edit", match: :first

    fill_in "Code", with: @subquestion.code
    fill_in "Exact value", with: @subquestion.exact_value
    fill_in "Position", with: @subquestion.position
    fill_in "Question", with: @subquestion.question_id
    fill_in "Value", with: @subquestion.value
    click_on "Update Subquestion"

    assert_text "Subquestion was successfully updated"
    click_on "Back"
  end

  test "destroying a Subquestion" do
    visit subquestions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Subquestion was successfully destroyed"
  end
end

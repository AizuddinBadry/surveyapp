require "application_system_test_case"

class QuestionGroupsTest < ApplicationSystemTestCase
  setup do
    @question_group = question_groups(:one)
  end

  test "visiting the index" do
    visit question_groups_url
    assert_selector "h1", text: "Question Groups"
  end

  test "creating a Question group" do
    visit question_groups_url
    click_on "New Question Group"

    fill_in "Description", with: @question_group.description
    fill_in "Name", with: @question_group.name
    fill_in "Order", with: @question_group.order
    fill_in "Survey", with: @question_group.survey_id
    click_on "Create Question group"

    assert_text "Question group was successfully created"
    click_on "Back"
  end

  test "updating a Question group" do
    visit question_groups_url
    click_on "Edit", match: :first

    fill_in "Description", with: @question_group.description
    fill_in "Name", with: @question_group.name
    fill_in "Order", with: @question_group.order
    fill_in "Survey", with: @question_group.survey_id
    click_on "Update Question group"

    assert_text "Question group was successfully updated"
    click_on "Back"
  end

  test "destroying a Question group" do
    visit question_groups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Question group was successfully destroyed"
  end
end

require "application_system_test_case"

class SurveySettingsTest < ApplicationSystemTestCase
  setup do
    @survey_setting = survey_settings(:one)
  end

  test "visiting the index" do
    visit survey_settings_url
    assert_selector "h1", text: "Survey Settings"
  end

  test "creating a Survey setting" do
    visit survey_settings_url
    click_on "New Survey Setting"

    check "Enable pdpa" if @survey_setting.enable_pdpa
    fill_in "Pdpa error message", with: @survey_setting.pdpa_error_message
    fill_in "Pdpa message", with: @survey_setting.pdpa_message
    click_on "Create Survey setting"

    assert_text "Survey setting was successfully created"
    click_on "Back"
  end

  test "updating a Survey setting" do
    visit survey_settings_url
    click_on "Edit", match: :first

    check "Enable pdpa" if @survey_setting.enable_pdpa
    fill_in "Pdpa error message", with: @survey_setting.pdpa_error_message
    fill_in "Pdpa message", with: @survey_setting.pdpa_message
    click_on "Update Survey setting"

    assert_text "Survey setting was successfully updated"
    click_on "Back"
  end

  test "destroying a Survey setting" do
    visit survey_settings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Survey setting was successfully destroyed"
  end
end

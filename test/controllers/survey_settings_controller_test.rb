require 'test_helper'

class SurveySettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @survey_setting = survey_settings(:one)
  end

  test "should get index" do
    get survey_settings_url
    assert_response :success
  end

  test "should get new" do
    get new_survey_setting_url
    assert_response :success
  end

  test "should create survey_setting" do
    assert_difference('SurveySetting.count') do
      post survey_settings_url, params: { survey_setting: { enable_pdpa: @survey_setting.enable_pdpa, pdpa_error_message: @survey_setting.pdpa_error_message, pdpa_message: @survey_setting.pdpa_message } }
    end

    assert_redirected_to survey_setting_url(SurveySetting.last)
  end

  test "should show survey_setting" do
    get survey_setting_url(@survey_setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_survey_setting_url(@survey_setting)
    assert_response :success
  end

  test "should update survey_setting" do
    patch survey_setting_url(@survey_setting), params: { survey_setting: { enable_pdpa: @survey_setting.enable_pdpa, pdpa_error_message: @survey_setting.pdpa_error_message, pdpa_message: @survey_setting.pdpa_message } }
    assert_redirected_to survey_setting_url(@survey_setting)
  end

  test "should destroy survey_setting" do
    assert_difference('SurveySetting.count', -1) do
      delete survey_setting_url(@survey_setting)
    end

    assert_redirected_to survey_settings_url
  end
end

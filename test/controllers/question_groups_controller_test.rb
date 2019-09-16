require 'test_helper'

class QuestionGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question_group = question_groups(:one)
  end

  test "should get index" do
    get question_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_question_group_url
    assert_response :success
  end

  test "should create question_group" do
    assert_difference('QuestionGroup.count') do
      post question_groups_url, params: { question_group: { description: @question_group.description, name: @question_group.name, order: @question_group.order, survey_id: @question_group.survey_id } }
    end

    assert_redirected_to question_group_url(QuestionGroup.last)
  end

  test "should show question_group" do
    get question_group_url(@question_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_question_group_url(@question_group)
    assert_response :success
  end

  test "should update question_group" do
    patch question_group_url(@question_group), params: { question_group: { description: @question_group.description, name: @question_group.name, order: @question_group.order, survey_id: @question_group.survey_id } }
    assert_redirected_to question_group_url(@question_group)
  end

  test "should destroy question_group" do
    assert_difference('QuestionGroup.count', -1) do
      delete question_group_url(@question_group)
    end

    assert_redirected_to question_groups_url
  end
end

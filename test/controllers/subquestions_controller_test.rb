require 'test_helper'

class SubquestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subquestion = subquestions(:one)
  end

  test "should get index" do
    get subquestions_url
    assert_response :success
  end

  test "should get new" do
    get new_subquestion_url
    assert_response :success
  end

  test "should create subquestion" do
    assert_difference('Subquestion.count') do
      post subquestions_url, params: { subquestion: { code: @subquestion.code, exact_value: @subquestion.exact_value, position: @subquestion.position, question_id: @subquestion.question_id, value: @subquestion.value } }
    end

    assert_redirected_to subquestion_url(Subquestion.last)
  end

  test "should show subquestion" do
    get subquestion_url(@subquestion)
    assert_response :success
  end

  test "should get edit" do
    get edit_subquestion_url(@subquestion)
    assert_response :success
  end

  test "should update subquestion" do
    patch subquestion_url(@subquestion), params: { subquestion: { code: @subquestion.code, exact_value: @subquestion.exact_value, position: @subquestion.position, question_id: @subquestion.question_id, value: @subquestion.value } }
    assert_redirected_to subquestion_url(@subquestion)
  end

  test "should destroy subquestion" do
    assert_difference('Subquestion.count', -1) do
      delete subquestion_url(@subquestion)
    end

    assert_redirected_to subquestions_url
  end
end

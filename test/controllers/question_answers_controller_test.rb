require 'test_helper'

class QuestionAnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question_answer = question_answers(:one)
  end

  test "should get index" do
    get question_answers_url
    assert_response :success
  end

  test "should get new" do
    get new_question_answer_url
    assert_response :success
  end

  test "should create question_answer" do
    assert_difference('QuestionAnswer.count') do
      post question_answers_url, params: { question_answer: { code: @question_answer.code, exact_value: @question_answer.exact_value, question_id: @question_answer.question_id, value: @question_answer.value } }
    end

    assert_redirected_to question_answer_url(QuestionAnswer.last)
  end

  test "should show question_answer" do
    get question_answer_url(@question_answer)
    assert_response :success
  end

  test "should get edit" do
    get edit_question_answer_url(@question_answer)
    assert_response :success
  end

  test "should update question_answer" do
    patch question_answer_url(@question_answer), params: { question_answer: { code: @question_answer.code, exact_value: @question_answer.exact_value, question_id: @question_answer.question_id, value: @question_answer.value } }
    assert_redirected_to question_answer_url(@question_answer)
  end

  test "should destroy question_answer" do
    assert_difference('QuestionAnswer.count', -1) do
      delete question_answer_url(@question_answer)
    end

    assert_redirected_to question_answers_url
  end
end

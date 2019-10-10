$(".add-subquestion").bind("ajax:success", function(e) {
  var answerSize = $(".subquestions").length;
  var json = JSON.parse(e.detail[0]);
  $("#subquestion-list").append(
    '<div class="subquestion list-group-item  column is-12 columns is-multiline" id="question_answer_' +
      json.id +
      '">' +
      '<div class="card column is-11">' +
      '<div class="card-header">' +
      '<p class="card-header-title"><i class="fa fa-bars pr-5"></i>' +
      '<input class="input" type="text" value="' +
      json.exact_value +
      '" name="question[question_subquestions_attributes][' +
      answerSize +
      '][exact_value]" id="question_question_subquestionss_attributes_' +
      answerSize +
      '_exact_value">' +
      '<input type="hidden" value="' +
      json.id +
      '" name="question[question_subquestions_attributes][' +
      answerSize +
      '][id]" id="question_question_subquestions_attributes_' +
      answerSize +
      '_id">' +
      "</p>" +
      "</div>" +
      "</div>" +
      '<div class="column is-1">' +
      '<p class="buttons pt-15">' +
      '<a class="delete_subquestion button is-small is-danger" data-confirm="Are you sure?" data-remote="true" rel="nofollow" data-method="delete" href="/users/manage/question_answers/' +
      json.id +
      '"><span class="icon is-small"><span class="icon is-small"><i class="fa fa-times"></i></span></span></a>' +
      "</p>" +
      "</div>" +
      "</div>"
  );
});

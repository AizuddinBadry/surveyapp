$(".add-answer").bind("ajax:success", function(e) {
  var answerSize = $(".answer").length;
  var json = JSON.parse(e.detail[0]);
  $("#answers-list").append(
    '<div class="answer list-group-item  column is-12 columns is-multiline ui-sortable-handle" id="question_answer_' +
      json.id +
      '">' +
      '<div class="card column is-11">' +
      '<div class="card-header">' +
      '<p class="card-header-title"><i class="fa fa-bars pr-5"></i>' +
      '<div class="pr-3">' +
      '<input class="input" type="text" value="' +
      json.code +
      '" name="question[question_answers_attributes][' +
      answerSize +
      '][code]" id="question_question_answers_attributes_' +
      answerSize +
      '_code">' +
      "</div>" +
      '<input class="input" type="text" value="' +
      json.exact_value +
      '" name="question[question_answers_attributes][' +
      answerSize +
      '][exact_value]" id="question_question_answers_attributes_' +
      answerSize +
      '_exact_value">' +
      '<input type="hidden" value="' +
      json.id +
      '" name="question[question_answers_attributes][' +
      answerSize +
      '][id]" id="question_question_answers_attributes_' +
      answerSize +
      '_id">' +
      "</p>" +
      "</div>" +
      "</div>" +
      '<div class="column is-1">' +
      '<p class="buttons pt-5">' +
      '<a class="delete_answer button is-small is-danger" data-confirm="Are you sure?" data-remote="true" rel="nofollow" data-method="delete" href="/users/manage/question_answers/' +
      json.id +
      '"><span class="icon is-small"><span class="icon is-small"><i class="fa fa-times"></i></span></span></a>' +
      "</p>" +
      "</div>" +
      "</div>"
  );
});

$(".add-subquestion").bind("ajax:success", function(e) {
  var subquestionSize = $(".subquestions").length;
  var json = JSON.parse(e.detail[0]);
  $("#subquestion-list").append(
    '<div class="subquestions list-group-item  column is-12 columns is-multiline" id="subquestion_' +
      json.id +
      '">' +
      '<div class="card column is-11">' +
      '<div class="card-header">' +
      '<p class="card-header-title"><i class="fa fa-bars pr-5"></i>' +
      '<div class="pr-3">' +
      '<input class="input" type="text" value="' +
      json.code +
      '" name="question[subquestions_attributes][' +
      subquestionSize +
      '][code]" id="subquestions_attributes_' +
      subquestionSize +
      '_code">' +
      "</div>" +
      '<input class="input" type="text" value="' +
      json.exact_value +
      '" name="question[subquestions_attributes][' +
      subquestionSize +
      '][exact_value]" id="subquestions_attributes_' +
      subquestionSize +
      '_exact_value">' +
      '<input type="hidden" value="' +
      json.id +
      '" name="question[subquestions_attributes][' +
      subquestionSize +
      '][id]" id="subquestions_attributes_' +
      subquestionSize +
      '_id">' +
      "</p>" +
      "</div>" +
      "</div>" +
      '<div class="column is-1">' +
      '<p class="buttons pt-15">' +
      '<a class="delete_subquestion button is-small is-danger" data-confirm="Are you sure?" data-remote="true" rel="nofollow" data-method="delete" href="/users/manage/subquestions/' +
      json.id +
      '"><span class="icon is-small"><span class="icon is-small"><i class="fa fa-times"></i></span></span></a>' +
      "</p>" +
      "</div>" +
      "</div>"
  );
});

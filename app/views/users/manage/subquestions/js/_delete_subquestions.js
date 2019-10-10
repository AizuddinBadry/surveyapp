$(".delete_subquestion").bind("ajax:success", function() {
  $(this)
    .closest(".subquestions")
    .fadeOut();
});

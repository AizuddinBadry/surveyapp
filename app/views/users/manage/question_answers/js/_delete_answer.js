$(".delete_answer").bind("ajax:success", function() {
  $(this)
    .closest(".answer")
    .fadeOut();
});

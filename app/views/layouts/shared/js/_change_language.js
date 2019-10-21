$("#change_language").on("change", function() {
  window.location.href =
    $(location).attr("pathname") + "?lang=" + $(this).val();
});

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
var ReactRailsUJS = require("react_ujs");
require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("jquery");
require("jquery-ui/ui/widget");
require("jquery-ui/ui/widgets/sortable");
require("datatables.net-dt");
require("datatables.net-rowreorder-dt");
require("datatables-bulma");
require("bulma-extensions");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
document.addEventListener("turbolinks:load", function() {
  "use strict";
  $(".datatable").DataTable();
  $("#answers-list").sortable({
    update: function(e, ui) {
      $.ajax({
        url: $(this).data("url"),
        type: "PUT",
        data: $(this).sortable("serialize")
      });
    }
  });
  $("#groups-list").sortable({
    update: function(e, ui) {
      $.ajax({
        url: $(this).data("url"),
        type: "PUT",
        data: $(this).sortable("serialize")
      });
    }
  });
  $("#subquestion-list").sortable({
    update: function(e, ui) {
      $.ajax({
        url: $(this).data("url"),
        type: "PUT",
        data: $(this).sortable("serialize")
      });
    }
  });
});
$(document).ready(function() {
  $(".datatable").DataTable();

  var table = $(".questions-datatable").DataTable({
    rowReorder: true,
    columnDefs: [
      {
        targets: [3],
        visible: false,
        searchable: false
      },
      {
        targets: [0],
        visible: false,
        searchable: false
      }
    ]
  });

  table.on("row-reorder", function(e, diff, edit) {
    for (var i = 0, ien = diff.length; i < ien; i++) {
      var rowData = table.row(diff[i].node).data();
      $.post("/api/v1/questions/sort", {
        question_group_id: rowData[3],
        code: rowData[2],
        position: diff[i].newData
      }).done(function(data) {});
    }
  });
  $(".card-toggle").click(function() {
    $(this)
      .next()
      .slideToggle();
  });
  $(".open-modal").click(function() {
    var modal = $(this).data("target");
    $("#" + modal).addClass("is-active");
  });

  $(".modal--close").click(function() {
    $(".modal").removeClass("is-active");
  });
});
// Support component names relative to this directory:
var componentRequireContext = require.context("components", true);
ReactRailsUJS.useContext(componentRequireContext);

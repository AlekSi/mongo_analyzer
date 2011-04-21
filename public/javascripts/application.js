$(document).ready(function() {
  $("#slow-queries").tablesorter();

  $("#change-profiling-level").bind("click", function(){
    $("#modal-change-profiling-level").modal();
    return false;
  })

  $("#show-collections").bind("click", function(){
    $("#modal-show-collections").modal();
    return false;
  })

  $("#reset-query-log").bind("click", function(){
    $("#modal-reset-query-log").modal();
    return false;
  })

  $("#slow-queries tr").bind("click", function(){
    if ($(this).hasClass("tr-highlighted")) {
      $(this).removeClass("tr-highlighted");
    } else {
      $(this).addClass("tr-highlighted");
    }
  })

  $(".confirm-link").bind("click", function(){
    if (confirm("Really?")) {
      window.location($(this).attr("href"));
    } else {
      return false;
    }
  })

});

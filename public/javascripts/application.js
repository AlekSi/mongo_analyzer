$(document).ready(function() { 
  $("#slow-queries").tablesorter();

  $("#change-profiling-level").bind("click", function(){
    $("#modal-change-profiling-level").modal();
    return false;
  })

  $("#slow-queries tr").bind("click", function(){
    if ($(this).hasClass("tr-highlighted")) {
      $(this).removeClass("tr-highlighted");
    } else {
      $(this).addClass("tr-highlighted");
    }
  })
}); 

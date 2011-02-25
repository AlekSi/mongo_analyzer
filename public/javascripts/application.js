$(document).ready(function() { 
  $("#slow-queries").tablesorter();

  $("#change-profiling-level").bind("click", function(){
    $("#modal-change-profiling-level").modal();
    return false;
  })
}); 

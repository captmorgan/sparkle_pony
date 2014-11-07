$(document).ready(function() {

  $("#loading_div").hide();

  $("a.copy_to_form").each(function(){
    $(this).bind('click', function() {
      $("#query_form > textarea").text($(this).text().trim());
      return false;
    });
  });

  $("#query_form").submit(function(){
    if (!$('#csv').is(':checked')) {
      event.preventDefault();
      $("#loading_div").show();
      $.ajax({
        type: 'POST',
        url: '/user/query/create',
        data: {query: $("#query").val(), csv: $('#csv').is(':checked')},
        success: function(data) {
               $("#q_output").html(data);
               $("#q_history").load("/user/query/render_history");
               $("#loading_div").hide();
               }
      });
    }
  });

  $("#history_form").submit(function(){
    event.preventDefault();
    var new_name = $("#name").val();
    $.ajax({
      type: 'GET',
      url: '/user/query/update_history',
      data: {name: new_name},
      success: function(data) {
             $("#q_history").html(data);
             $("#name").val(new_name);
             }
           });
  });

});

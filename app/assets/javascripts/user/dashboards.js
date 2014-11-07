$(document).ready(function()  {

  $('#assign_cols').hide();

  // this is kind of gross
  if ($('#db_group_row').data('value') === '') {
    $('#db_group_row').hide();
  }


  function setOptions(options_array) {
    // if we have any options, we should probably remove them
    $("[id=db_type]").find('option').remove().end();

    // need to hide or show the group selector depending on how many cols
    // the query had

    // yay lets build the option string
    option_string = "";
    $.each(options_array, function( key, value ) {
      option_string += ("<option value='" + value +"'>" + value + "</option>");
    })
    // append it to ALL THE db_types
    $('[id=db_type]').append(option_string);

    if (options_array.length == 2) {
      $('[name="group"]').find('option').remove().end();
      $('#db_group_row').hide();
    } else {
      $('#db_group_row').show();
    }
  }

  function displayError(error_message) {
    // if there was an old error, lets remove it
    $("#db_query_error").remove();
    // html
    error_div="<div class='alert alert-block alert-error' id='db_query_error'>" +
          "<h4>Error!</h4>" +
          "<p class='alert alert-error'>" +
            error_message +
          "</p> </div>";
    $("#db_query_col").prepend(error_div);
  }


  var ct = $('#crosstab');
  $(ct).hide();

  $('#toggler').click(function() {
    $(ct).toggle();
  });

  $("#db_query_submit").click(function(){
    event.preventDefault();
    var db_name = $("#dboard_name").val();
    var db_query = $('#dboard_query').val();
    $.ajax({
      type: 'POST',
      url: '/user/dashboards/get_col_names',
      data: {name: db_name,
             query: db_query
            },
      success: function(data) {
            $("#db_query_error").remove();
            setOptions(data);
            $('#assign_cols').show();
            },
        error: function(data) {
               $("#db_query_error").remove();
               displayError(data.responseText);
                    }
           });
  });

    $("#db_query_update").on("ajax:success", function(e, data, status, xhr) {
      $("#db_query_error").remove();
      setOptions(data);
    }
  ).on("ajax:error", function(e, xhr, status, error) {
      $("#db_query_error").remove();
      displayError(xhr.responseText);
  });
});

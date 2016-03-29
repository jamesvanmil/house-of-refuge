var multiselect = function() {
  $(".js-multiselect").select2({
    theme: "bootstrap",
    placeholder: "Click to select"
  });
};

var datepicker = function() {
  $( ".datepicker-from" ).datepicker({
    defaultDate: new Date(1869, 9, 01),
    minDate: new Date(1869, 9, 01),
    maxDate: new Date(1902, 6, 31),
    onClose: function( selectedDate ) {
      $( "#to" ).datepicker( "option", "minDate", selectedDate );
    }
  });
  $( ".datepicker-to" ).datepicker({
    defaultDate: new Date(1902, 6, 31),
    minDate: new Date(1869, 9, 01),
    maxDate: new Date(1902, 6, 31),
    onClose: function( selectedDate ) {
      $( "#from" ).datepicker( "option", "maxDate", selectedDate );
    }
  });
};

$(document).ready(multiselect);
$(document).on('page:load', multiselect);
$(document).ready(datepicker);
$(document).on('page:load', datepicker);

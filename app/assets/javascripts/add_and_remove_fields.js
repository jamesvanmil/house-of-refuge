//Add an addidional field to the Admissions search page
var add_field = function () {
  $('.add-search-field').on('click', function(event) {
    event.preventDefault();
    var lastField = $(this).parent().children('.search-row').last();
    var index = (lastField.attr('id')).replace("search-row-", "");
    $(field.replace(/INDEX/g, parseInt(index) + 1)).insertAfter(lastField);
  });
};

var remove_field = function () {
  $('.remove-search-field').on('click', function(event) {
    event.preventDefault();
    var thisField = $(this).closest('.search-row'); 
    var index = (thisField.attr('id')).replace("search-row-", "");
    thisField.remove();
  });
};

var field = "<div class='row search-row' id='search-row-INDEX'> <div class='form-group col-sm-4'> <select name='fieldINDEX' id='fieldINDEX' class='form-control'><option selected='selected' value='name'>Name</option> <option value='alias'>Alias</option> <option value='by_whom_committed'>By Whom Committed</option> <option value='disposal'>Disposal</option> <option value='parentage'>Parentage</option></select> </div> <div class='form-group col-sm-4'> <input type='text' name='valueINDEX' id='valueINDEX' class='form-control'> </div> <div class='form-group col-sm-4'> <a class='btn btn-default remove-search-field' href=''>Remove Field</a> </div> </div>";

$(document).ready(add_field);
$(document).on('page:load', add_field);
$(document).ready(remove_field);
$(document).on('page:load', remove_field);

function Business (input) {
  this.new_business_form = input.newForm;
}

Business.prototype.bindEvents = function() {
  this.new_business_form.on('change', '#business_address_attributes_country', function() {
    console.log($(this).val());
    $.ajax({
      url: "/businesses/update_states",
      dataType: 'json',
      type: 'post',
      data: {country: $(this).val()},
      success: function (data) {
        var options = [], option = null;
        $.each(data, function(index, value) {
          option = $('<option>', {
            value: value
          }).text(value);
          options.push(option)
        });
        $('#business_address_attributes_state').empty().append(options);
      },
    });
  });
};

$( function() {
  var input = { 
    newForm: $('#new_business')
  },
  business = new Business(input);
  business.bindEvents();
});

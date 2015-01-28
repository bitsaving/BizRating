function Business (input) {
  this.new_business_form = input.newForm;
  this.add_phone = input.add_phone;
  this.add_email = input.add_email;
  this.add_image = input.add_image;
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
  this.add_phone.on('click', function(e) {
    e.preventDefault();
    var new_phone = $(this).prev('div').clone(),
      number = $('div.phone div').length + 1;
      new_phone.find('input').attr('name', "business[phone_numbers_attributes][" + number + "][details]");
      $('div.phone').append(new_phone);
  });
  this.add_email.on('click', function(e) {
    e.preventDefault();
    var new_email = $(this).prev('div').clone(),
      number = $('div.email div').length + 1;
      new_email.find('input').attr('name', "business[emails_attributes][" + number + "][details]");
      $('div.email').append(new_email);
  });
  this.add_image.on('click', function(e) {
    e.preventDefault();
    var new_image = $(this).prev('div').clone(),
      number = $('div.image div').length + 1;
      new_image.find('input').attr('name', "business[images_attributes][" + number + "][image]");
      $('div.image').append(new_image);
  });
};

$( function() {
  var input = { 
    newForm: $('#new_business'),
    add_phone: $('a#add_phone'),
    add_email: $('a#add_email'),
    add_image: $('a#add_image')
  },
  business = new Business(input);
  business.bindEvents();
});

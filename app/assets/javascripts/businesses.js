function Business (input) {
  this.businessForms = input.forms;
  this.statusLink = input.statusLink;
  this.searchForm = input.searchForm;
}

Business.prototype.initialize = function() {
  this.addStatus();
  this.bindEvents();
};

Business.prototype.addStatus = function() {
  this.statusLink.each(function(index, link) {
    link.text = ($(link).data('businessStatus') ? 'Disable' : "Enable");
  });
};

Business.prototype.bindEvents = function() {
  this.bindFormEvents();
  this.bindStatusEvent();
  this.bindSearchEvent()
};

Business.prototype.bindSearchEvent = function() {
  var _this = this;
  this.searchForm.on('change', 'select', function() {
    _this.searchForm.submit();
  })
};

Business.prototype.bindFormEvents = function() {
  this.businessForms.on('change', '#business_address_attributes_country', function() {
    $.ajax({
      url: "/admin/states/",
      dataType: 'json',
      type: 'get',
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

Business.prototype.bindStatusEvent = function() {
  this.statusLink.on('click', function(e) {
    e.preventDefault();
  var linkdata = $(this).data(), 
  _this = this;
  confirmText = 'You want to' + (linkdata['businessStatus'] ? ' disable ' : ' enable ') + linkdata['businessName'];
  if (confirm(confirmText)) {
    $.ajax({
        url: "businesses/update_status",
        dataType: 'json',
        type: 'patch',
        data: linkdata,
        success: function (e) {
          $(_this).data('businessStatus', e[0]);
          _this.text = (e[0] ? 'Disable' : "Enable");
          $(_this).toggleClass('btn-danger btn-success');
        },
        error: function (e) {
          alert($.parseJSON(e.responseText));
        }
      });
    }
  });
};

$( function() {
  var input = { 
    forms: $("#new_business, .edit_business"),
    statusLink: $('td.btn-just a.btn.btn-xs.edit'),
    searchForm: $('#business_search')
  },
  business = new Business(input);
  business.initialize();
});

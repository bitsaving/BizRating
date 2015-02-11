// FIXME_AB: Lets use JS as less as we can
function Business (input) {
  this.businessForms = input.forms;
  this.statusLink = input.statusLink;
  this.searchForm = input.searchForm;
  this.autoCompleteField = input.autoCompleteField;
  this.countryField = input.countryField;
  this.countryCode = null;
  this.stateIndexUrl = input.stateIndexUrl;
  this.updateStatusUrl = input.updateStatusUrl;
}

Business.prototype.initialize = function() {
  $('#loader').hide();
  this.addStatus();
  this.bindEvents();
  this.updateAutoComplete();
};

Business.prototype.addStatus = function() {
  this.statusLink.each(function(index, link) {
    link.text = ($(link).data('businessStatus') ? 'Enable' : "Disable");
  });
};

Business.prototype.bindEvents = function() {
  this.bindFormEvents();
  this.bindStatusEvent();
  this.bindSearchEvent();
};

Business.prototype.setCountryValue = function() {
  this.countryCode = this.countryField.find('option:selected')
            .data('code').toLowerCase();
};

Business.prototype.bindSearchEvent = function() {
  var _this = this;
  this.searchForm.on('change', 'select', function() {
    _this.searchForm.submit();
  });
};

Business.prototype.bindFormEvents = function() {
  var _this = this;
  this.countryField.on('change', function() {
    $.ajax({
      // FIXME_AB: Lets not hard code urls in js. Use data attributes
      // Fixed
      url: _this.stateIndexUrl,
      dataType: 'json',
      type: 'get',
      data: {country: $(this).val()},
      // FIXME_AB: Whenever you are sending ajax request use spinner to show user that something is in progress
      // Fixed
      beforeSend: function() {
        $('#loader').show();
      },
      complete: function(){
        $('#loader').hide();
      },
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
    _this.updateAutoComplete();
  });
};

Business.prototype.updateAutoComplete = function() {
  var _this = this;
  this.setCountryValue();
  this.autoCompleteField.attr('placeholder', 'Enter a Place');
  this.completeArea = new google.maps.places.Autocomplete(this.autoCompleteField[0], {
    types: ['address'], componentRestrictions: { country: this.countryCode }
  });
  google.maps.event.addListener(this.completeArea, 'place_changed', function() {
    $('#business_address_attributes_area').val(_this.autoCompleteField.val());
    console.log(_this.autoCompleteField.val());
  });
};

Business.prototype.bindStatusEvent = function() {
  var _that = this;
  this.statusLink.on('click', function(e) {
    e.preventDefault();
  var linkdata = $(this).data(),
  _this = this;
  confirmText = 'Do you want to' + (linkdata['businessStatus'] ? ' enable ' : ' disable ') + linkdata['businessName'] + " ?";
  if (confirm(confirmText)) {
    $.ajax({
        url: _that.updateStatusUrl,
        dataType: 'json',
        type: 'patch',
        data: linkdata,
        success: function (e) {
          $(_this).data('businessStatus', !e[0]);
          _this.text = (e[0] ? 'Disable' : "Enable");
          $(_this).toggleClass('btn-danger btn-success');
        },
        beforeSend: function() {
        $('#loader').show();
        },
        complete: function(){
          $('#loader').hide();
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
    statusLink: $('td a.btn.btn-xs.edit'),
    searchForm: $('#business_search'),
    autoCompleteField: $('#Area'),
    countryField: $('#business_address_attributes_country'),
    stateIndexUrl: "/admin/states/",
    updateStatusUrl: "businesses/update_status"
  },
  business = new Business(input);
  business.initialize();
});

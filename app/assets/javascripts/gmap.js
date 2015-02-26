function Map(input) {
  this.areaKey = input.areaKey;
}

Map.prototype.initialize = function() {
  this.setup();
  this.bindEvent();
}

Map.prototype.bindEvent = function() {
  var _this = this;
  this.areaKey.on('keyup', function() {
    _this.codeAddress();
  });
};

Map.prototype.codeAddress = function() {
  var address = this.areaKey.val(), _this = this;
  this.marker = new google.maps.Marker();
  _this.geocoder.geocode( {
      'address': address,
      componentRestrictions: {
        country: $('#business_address_attributes_country option:selected').data('code'),
        postalCode: $('#business_address_attributes_pin_code').val(),
        administrativeArea: $('#business_address_attributes_state option:selected').val()
      }
    }, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      _this.mapCanvas.setCenter(results[0].geometry.location);
      _this.marker({
        map: _this.mapCanvas,
        position: results[0].geometry.location
      });
    } else {
        alert('Geocode was not successful for the following reason: ' + status);
    };
  });
};

Map.prototype.setup = function() {
  this.geocoder = new google.maps.Geocoder();
  var latlng = new google.maps.LatLng(45, 90);
  this.mapCanvas = new google.maps.Map(document.getElementById('map-canvas'), {
    zoom: 2,
    center: latlng
  });
};

$(function() {
  var input = {
      areaKey: $('#Area')
    },
    gmap = new Map(input);
    gmap.initialize();
});
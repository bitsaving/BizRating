function Map(input) {
  this.searchBox = input.searchBox;
  this.country = input.country;
  this.form = input.form;
  this.pinCode = input.pinCode;
  this.componentRestrictions = {};
}

Map.prototype.initialize = function() {
  this.setupMap();
  this.bindEvent();
};

Map.prototype.bindEvent = function() {
  var _this = this;
  this.searchBox.on('keyup', function() {
    _this.codeAddress();
  });
  google.maps.event.addListener(this.mapCanvas, 'click', function(event) {
    _this.addMarker(event.latLng);
  });
  this.country.on('change', function(event) {
    _this.componentRestrictions['country'] = $(this).val();
    _this.centerMap($(this).val());
    _this.mapCanvas.setZoom(4);
  });
  this.form.on('change', '#business_address_attributes_state', function(event) {
    _this.componentRestrictions['administrativeArea'] = $(this).val();
    _this.centerMap($(this).val());
    _this.mapCanvas.setZoom(11);
  });
  this.pinCode.on('change', function(event) {
    _this.componentRestrictions['postalCode'] = $(this).val();
    _this.centerMap($(this).val());
    _this.mapCanvas.setZoom(14);
  });
};

Map.prototype.centerMap = function(value) {
  var _this = this;
  this.geocoder.geocode( { 'address': value,
    componentRestrictions: _this.componentRestrictions
      }, function(results, status) {
        console.log(results);
    if (status == google.maps.GeocoderStatus.OK) {
        _this.mapCanvas.setCenter(results[0].geometry.location);
    } else {
        alert("Could not find location: " + location);
    }
});
};

Map.prototype.addMarker = function(location) {
  var _this = this;
  this.marker.setMap(null);
  this.geocoder.geocode({
      'latLng' : location
    }, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
          _this.marker = new google.maps.Marker({
          position: location,
          map: _this.mapCanvas,
          visible: true,
          title: results[0].formatted_address,
          zoom: 16
        });
        $('#business_address_attributes_longitude').val(location.lng());
        $('#business_address_attributes_latitude').val(location.lat());
        _this.searchBox.val(results[0].formatted_address);
      }
    }
  );
};

Map.prototype.codeAddress = function() {
  var address = this.searchBox.val(), _this = this;
  _this.geocoder.geocode({
      'address': address,
      componentRestrictions: _this.componentRestrictions
    }, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      _this.setMap(results);
    } else {
        alert('Geocode was not successful for the following reason: ' + status);
    };
  });
};

Map.prototype.setMap = function(results) {
  this.mapCanvas.setCenter(results[0].geometry.location);
  this.mapCanvas.setZoom(16);
};

Map.prototype.setupMap = function() {
  this.geocoder = new google.maps.Geocoder();
  var latlng = new google.maps.LatLng(45, 90);
  this.mapCanvas = new google.maps.Map(document.getElementById('map-canvas'), {
    zoom: 1,
    center: latlng,
    scaleControl: true
  });
  this.marker = new google.maps.Marker();
};

$(function() {
  var input = {
      searchBox: $('#Search'),
      country: $('#business_address_attributes_country'),
      form: $('#new_business'),
      pinCode: $('#business_address_attributes_pin_code'),

    },
    gmap = new Map(input);
    gmap.initialize();
});

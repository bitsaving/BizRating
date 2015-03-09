function Map(input) {
  this.areaKey = input.areaKey;
}

Map.prototype.initialize = function() {
  this.setupMap();
  this.bindEvent();
};

Map.prototype.bindEvent = function() {
  var _this = this;
  this.areaKey.on('keyup', function() {
    _this.codeAddress();
  });
  google.maps.event.addListener(this.mapCanvas, 'click', function(event) {
    _this.addMarker(event.latLng);
  });
};

Map.prototype.addMarker = function(location) {
  if (this.mapCanvas.getZoom() >= 16){
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
          _this.areaKey.val(results[0].formatted_address);
        }
      }
    );
  } else {
    alert('Zoom level less than 16')
  }
};

Map.prototype.codeAddress = function() {
  var address = this.areaKey.val(), _this = this;
  _this.geocoder.geocode({
      'address': address,
      componentRestrictions: {
        country: $('#business_address_attributes_country option:selected').data('code'),
        postalCode: $('#business_address_attributes_pin_code').val(),
        administrativeArea: $('#business_address_attributes_state option:selected').val()
      }
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
    center: latlng
  });
  this.marker = new google.maps.Marker();
};

$(function() {
  var input = {
      areaKey: $('#Search')
    },
    gmap = new Map(input);
    gmap.initialize();
});
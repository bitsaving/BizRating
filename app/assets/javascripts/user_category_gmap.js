function UserCategoryGmap(input) {
  this.gmap_div = input.gmap_div
  this.businessLocationList = input.businessLocationList;
}

UserCategoryGmap.prototype.initialize = function() {
  this.gmap = new google.maps.Map(this.gmap_div[0],
    { zoom: 16,
      center: new google.maps.LatLng(this.getCookie('lat'), this.getCookie('lng'))
    }
  );
  this.showMarker();
};

UserCategoryGmap.prototype.showMarker = function() {
  var _this = this;
  this.businessLocationList.each(function(index, value) {
    var location = _this.geoLocation(value),
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(location.lat, location.lng),
        map: _this.gmap,
        visible: true,
      }),
      info = new google.maps.InfoWindow({
        content: _this.infoString(value)
      });
    google.maps.event.addListener(marker, 'click', function() {
      info.open(_this.gmap, marker);
      _this.businessLocationList.eq(index).toggleClass('marker')
    });
  });
};

UserCategoryGmap.prototype.infoString = function(element) {
  return $(element).attr('data-name')
};

UserCategoryGmap.prototype.geoLocation = function(element) {
  var input = {
    lat: $(element).attr('data-latitude'),
    lng: $(element).attr('data-longitude')
  };
  return input
};

UserCategoryGmap.prototype.getCookie = function(cookieName) {
    var name = cookieName + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) == 0) return c.substring(name.length, c.length);
    }
    return "";
};

$(function() {
  var input = {
    gmap_div : $('#gmap'),
    businessLocationList : $('#business_list div.business')
  }, userCategoryGmap = new UserCategoryGmap(input);
  userCategoryGmap.initialize();
})

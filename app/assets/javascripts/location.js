function UserLocation(input) {
  this.lat = input.lat;
  this.lng = input.lng;
}

Location.prototype.intialize = function() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(this.setPostion);
  } else {
    alert("Geolocation is not supported by this browser.");
  }
};

Location.prototype.setPostion = function(position) {
  document.cookie="lat=" + position.coords.latitude;
  document.cookie="lng=" + position.coords.longitude;
}

$(function() {
  var input = {
    lat: $('#lat'),
    lng: $('#lng')
  },
  userLocation = new UserLocation(input);
  location.intialize();
})
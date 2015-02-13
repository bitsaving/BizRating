function UserBusinesses (sliders) {
  this.sliders = sliders;
}

UserBusinesses.prototype.initialize = function() {
  this.bindEvents();
  this.sliders.next('div').hide();
  this.sliders.last().next('div').show();
};

UserBusinesses.prototype.bindEvents = function() {
  this.sliders.on('click', function() {
    $(this).next('div').slideToggle('100');
  });
};

$(function() {
  var sliders = $('.sliders'),
    userBusiness = new UserBusinesses(sliders);
  userBusiness.initialize();
})
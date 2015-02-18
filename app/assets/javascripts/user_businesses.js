function UserBusinesses (sliders) {
  this.sliders = sliders;
}

UserBusinesses.prototype.initialize = function() {
  this.bindEvents();
  this.sliders.next('div').hide();
  this.sliders.last().next('div').show().siblings('img').toggleClass('rotate90');
};

UserBusinesses.prototype.bindEvents = function() {
  this.sliders.on('click',function() {
    $(this).toggleClass('rotate90').nextAll('div').slideToggle();
    $(this).prev('img').toggleClass('rotate90');
  });
};

$(function() {
  var sliders = $('.sliders'),
    userBusiness = new UserBusinesses(sliders);
  userBusiness.initialize();
})
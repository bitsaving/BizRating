function UserBusinesses (input) {
  this.sliders = input.sliders;
  this.labels = input.labels;
  this.reviewBtn = input.reviewBtn;
  this.reviewForm = input.reviewForm;
}

UserBusinesses.prototype.initialize = function() {
  this.labels.first().css({ visibility: 'collapse' });
  this.sliders.next('div').hide();
  // this.sliders.last().next('div').show().siblings('img').toggleClass('rotate90');
  this.reviewForm.hide();
  this.bindEvents();
};

UserBusinesses.prototype.bindEvents = function() {
  var _this = this;
  this.sliders.on('click',function() {
    $(this).toggleClass('rotate90').nextAll('div').slideToggle();
    $(this).prev('img').toggleClass('rotate90');
  });

  this.reviewBtn.on('click', function() {
    _this.reviewForm.show();
  })

  this.labels.on("click", function() {
    $(this).parent('li')
      .addClass("add-color").prevAll('li').addClass("add-color").end()
      .nextAll('li').removeClass("add-color").end()
      .siblings('input').checked = true;
  });

  $("ul.rating-star li").hover(function(){
    $(this).find("label").trigger('click');
  });

  $(document).on("ajax:success", function(e, data) {
    $("div.jumbotron").last().append($("<div>", {
      class: "review "})
      .append("<p><strong>" + data[1] + "&nbsp</strong>"+ data[2] + "</p>")
      .append("<p>" + data[0] + "</p>"));
    $("form.creation").hide();
    $(".rating div.filled").css({ width: data[3] + "%" });
  });

  $(document).on("ajax:error", function(e, data) {
    console.log(data);
    alert(data.responseText);
  });
};

$(function() {
  var input = {
    sliders: $('.sliders'),
    labels: $("ul.rating-star li label"),
    reviewBtn: $('#new-review-btn'),
    reviewForm: $('#new-review')
  },
    userBusiness = new UserBusinesses(input);
  userBusiness.initialize();
})
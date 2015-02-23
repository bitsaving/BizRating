function UserBusinesses (input) {
  this.sliders = input.sliders;
  this.labels = input.labels;
  this.reviewBtn = input.reviewBtn;
  this.reviewForm = input.reviewForm;
  this.reviewDetails = input.reviewDetails;
}

UserBusinesses.prototype.initialize = function() {
  this.labels.first().css({ visibility: 'collapse' });
  this.sliders.next('div').hide();
  this.sliders.last().next('div').show().end().prev('img').toggleClass('rotate90');
  this.reviewForm.hide();
  this.reviewDetails.hide();
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
  });

  this.reviewForm.find("input[type='submit']").on('click', function(e) {
    if (confirm('Do you want to post this review?')) {
      return true;
    } else {
      e.preventDefault();
      _this.reviewForm.find('textarea').focus();
    }
  });

  this.labels.on("click", function() {
    $(this).parent('li')
      .addClass("add-color").prevAll('li').addClass("add-color").end()
      .nextAll('li').removeClass("add-color").end()
      .siblings('input').checked = true;
    console.log($(this).parent('li').index());
    _this.reviewDetails.hide();
    _this.reviewDetails.eq($(this).parent('li').index()).show();
  });

  $(document).on("ajax:success", function(e, data) {
    $("div.jumbotron").last().prepend($("<div>", {
      class: "review "})
      .append("<p><strong>" + data[1] + "&nbsp</strong>"+ data[2] + "</p>")
      .append("<p>" + data[0] + "</p>"));
    $("form.creation").hide();
    $(".rating div.filled").first().css({ width: data[3] + "%" });
    location.reload();
  });

  $(document).on("ajax:error", function(e, data) {
    alert(data.responseText);
    _this.reviewForm.find('textarea').focus();
  });
};

$(function() {
  var input = {
    sliders: $('.sliders'),
    labels: $("ul.rating-star li label"),
    reviewBtn: $('#new-review-btn'),
    reviewForm: $('#new-review'),
    reviewDetails: $('#rate-detail span')
  },
    userBusiness = new UserBusinesses(input);
  userBusiness.initialize();
})
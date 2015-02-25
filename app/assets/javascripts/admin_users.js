function User (input) {
  this.statusLink = input.statusLink;
  this.updateStatusUrl = input.updateStatusUrl;
}

User.prototype.initialize = function() {
  this.addStatus();
  this.bindStatusEvent();
};

User.prototype.addStatus = function() {
  this.statusLink.each(function(index, link) {
    link.text = ($(link).data('userActive') ? 'Enable' : "Disable");
  });
};

User.prototype.bindStatusEvent = function() {
  var _that = this;
  this.statusLink.on('click', function(e) {
    e.preventDefault();
    var linkdata = $(this).data(),
        _this = this;
  confirmText = 'Do you want to' + (linkdata['userName'] ? ' enable ' : ' disable ') + linkdata['userName'] + " ?";
  if (confirm(confirmText)) {
    $.ajax({
        url: _that.updateStatusUrl,
        dataType: 'json',
        type: 'patch',
        data: linkdata,
        success: function (e) {
          $(_this).data('userActive', !e[0]);
          _this.text = (e[0] ? 'Disable' : "Enable");
          $(_this).toggleClass('btn-danger btn-success')
        },
        error: function (e) {
          alert($.parseJSON(e.responseText));
        }
      });
    }
  });
};



$(function(){
  var input = {
    statusLink : $('td a'),
    updateStatusUrl : "users/update_status",
  },
  user = new User(input);
  user.initialize();
});

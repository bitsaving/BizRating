function CheckList(input) {
  this.time_slots = input.time_slots;
}

CheckList.prototype.bindEvents = function() {
  var _this = this;
  this.time_slots.on('click', '.fields #Checkall', function() {
    var that = this;
    $(this).parents('.controls').parent().find('.days').each(function() {
      $(this)[0].checked = that.checked;
    })
  });
  this.time_slots.on('click', '.days', function() {
    $(this).parents('.field').find('#Checkall')[0].checked = false;
  });
};

$(function() {
  var input = {
    time_slots: $('.time-slot')
  },
  checkList = new CheckList(input);
  checkList.bindEvents();
});

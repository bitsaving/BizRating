function UserCategory(input) {
  this.selectField = input.selectField;
  this.form = input.form;
}

UserCategory.prototype.bindEvent = function() {
  var _this = this;
  this.selectField.on('change', function() {
    _this.form.submit();
  });
};

$(function() {
  var input = {
    selectField : $('#order'),
    form: $('#order_form')
  },
  userCategory = new UserCategory(input);
  userCategory.bindEvent();
})

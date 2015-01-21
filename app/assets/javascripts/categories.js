function Category (input) {
  this.newForm = input.newForm;
  this.categoryList = input.categoryList;
}

Category.prototype.initialize = function() {
  this.bindEvents();
};

Category.prototype.bindEvents = function() {
  var _this = this;
  this.categoryList.sortable({
    revert: false,
    distance: 40
  });
  this.bindFormEvent();
};

Category.prototype.bindFormEvent = function() {
  var _this = this;
  this.newForm.on('submit', function(e) {
    e.preventDefault();
    _this.validateForm();
  });  
}

Category.prototype.validateForm = function() {
  var input_file = this.newForm.find('#category_image'),
    _this = this;
    $.ajax({
      url: "categories/valid",
      dataType: 'json',
      type: 'post',
      data: this.newForm.serialize(),
      success: function () {
        if ($('#new_category #category_image')[0].value == ""){
          _this.newForm.find('div.form-group').addClass('has-error');
          _this.newForm.find('div.form-group').first().removeClass('has-error');
        } else {
          _this.newForm.off('submit');
          _this.newForm.submit();
        }
      },
      error: function (e) {
        errors = $.parseJSON(e.responseText);
        _this.newForm.find('div.form-group').removeClass('has-error');
        $.each(errors, function(key, value) {
          var input = _this.newForm.find('#category_'+ key)
          if (key == 'image' && input[0].value != "") {
            input[0].placeholder = 'No file selected';
            input.parents('div.form-group').addClass('has-error');
          } else {
            input[0].placeholder = input[0].value + ' ' + value;
            input[0].value = "";
            input.parents('div.form-group').addClass('has-error');
          }
        });
      }
    });
};

Category.prototype.nameValid = function() {
  if(inputs[0].value.trim().length == 0) {
      $(inputs[0]).parents('div.form-group').addClass('has-error');
      return false
  } else {
    $(inputs[0]).parents('div.form-group').removeClass('has-error');
    return true
  }
};

Category.prototype.fileValid = function() {
  if(inputs[1].value.trim().length == 0) {
      $(inputs[1]).parents('div.form-group').addClass('has-error')
      return false
  } else {
    $(inputs[1]).parents('div.form-group').removeClass('has-error');
    return true
  }
};

$(function(){
  var input = {
    newForm : $('#new_category'),
    categoryList : $('ul.categoryList')
  },
  category = new Category(input);
  category.initialize();
});

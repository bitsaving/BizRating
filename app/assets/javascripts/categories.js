function Category (input) {
  this.newForm = input.newForm;
  this.categoryList = input.categoryList;
  this.statusLink = input.statusLink;
}

Category.prototype.initialize = function() {
  this.addStatus();
  this.bindEvents();
};

Category.prototype.addStatus = function() {
  this.statusLink.each(function(index, link) {
    link.text = ($(link).data('categoryStatus') ? 'Disable' : "Enable");
  });
};

Category.prototype.bindEvents = function() {
  var _this = this;
  this.categoryList.sortable({
    revert: false,
    distance: 40
  });
  this.bindStatusEvent();
  this.bindFormEvent();
};

Category.prototype.bindStatusEvent = function() {
  this.statusLink.on('click', function() {
  var linkdata = $(this).data(), 
  _this = this;
  confirmText = 'You want to' + (linkdata['categoryStatus'] ? ' disable ' : ' enable ') + linkdata['categoryName'];
  if (confirm(confirmText)) {
    $.ajax({
        url: "categories/update_status",
        dataType: 'json',
        type: 'post',
        data: linkdata,
        success: function (e) {
          $(_this).data('categoryStatus', e[0]);
          _this.text = (e[0] ? 'Disable' : "Enable");
        },
        error: function (e) {
          errors = $.parseJSON(e.responseText);
            alert(2);
        }
      });
    }
  });
};

Category.prototype.bindFormEvent = function() {
  var _this = this;
  this.newForm.on('submit', function(e) {
    e.preventDefault();
    _this.validateForm();
  });
};

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
    newForm : $('form#new_category'),
    categoryList : $('ul.categoryList'),
    statusLink : $('td.btn-just a:nth-child(2)')
  },
  category = new Category(input);
  category.initialize();
});

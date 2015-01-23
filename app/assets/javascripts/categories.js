function Category (input) {
  this.newForm = input.newForm;
  this.categoryList = input.categoryList;
  this.statusLink = input.statusLink;
  this.formErrors = null;
  this.categoryNameInput = input.categoryNameInput;
  this.editForms = input.editForms;
}

Category.prototype.initialize = function() {
  this.addStatus();
  this.getCategoryNames();
  this.bindEvents();
};

Category.prototype.getCategoryNames = function() {
  var _this = this;
  categoryNameInput.each( function(index, field) {
    _this.categoryNameArray.push(field.value);
  })
};

Category.prototype.addStatus = function() {
  this.statusLink.each(function(index, link) {
    link.text = ($(link).data('categoryStatus') ? 'Disable' : "Enable");
  });
};

Category.prototype.bindEvents = function() {
  var _this = this;
  this.bindSortableEvents();
  this.bindStatusEvent();
  this.bindFormEvent();
};

Category.prototype.bindSortableEvents = function() {
  this.categoryList.sortable({
    revert: false,
    stop: function() {
      $.ajax({
        url: "categories/update_position",
        dataType: 'json',
        type: 'post',
        data: {position : $(this).sortable("toArray")},
        success: function() {
          alert('updated');
        },
        error: function() {
          alert('failed to update');
        }
      });
    }
  });
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
          alert($.parseJSON(e.responseText));
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
  this.edit-form
};

Category.prototype.validateForm = function() {
  this.validateNameInput
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

Category.prototype.validateNameInput = function(field) {
  
  if(field.value.trim().length == 0) {
      $(field).parents('div.form-group').addClass('has-error');
      return false
  } else {
    $(field).parents('div.form-group').removeClass('has-error');
    return true
  }
};

Category.prototype.validateFieldInput = function(field) {
  if(field.value.trim().length == 0) {
      $(field).parents('div.form-group').addClass('has-error')
      return false
  } else {
    $(field).parents('div.form-group').removeClass('has-error');
    return true
  }
};

$(function(){
  var input = {
    newForm : $('form#new_category'),
    categoryList : $('tbody.sortable'),
    statusLink : $('td.btn-just a:nth-child(2)'),
    editForms : $('form.edit-form'),
    categoryNameInput : editForms.find('input[type=text]')
  },
  category = new Category(input);
  category.initialize();
});

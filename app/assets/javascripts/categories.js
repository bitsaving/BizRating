function Category (input) {
  this.newForm = input.newForm;
  this.categoryList = input.categoryList;
  this.statusLink = input.statusLink;
  this.categoryNames = [];
  this.editForms = input.editForms;
}

Category.prototype.initialize = function() {
  this.addStatus();
  this.getCategoryNames();
  this.bindEvents();
};

Category.prototype.getCategoryNames = function() {
  var _this = this;
  this.editForms.find('input[type=text]').each( function(index, field) {
    _this.categoryNames.push(field.value);
  });
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
        type: 'patch',
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
        type: 'patch',
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
    _this.validateNewForm()
    if (!_this.formValid) {
      e.preventDefault();
    }
  });
};

Category.prototype.validateNewForm = function() {
  this.validateNameInput(this.newForm.find('#category_name'));
  this.validateFieldInput(this.newForm.find('#category_image'));
};

Category.prototype.validateNameInput = function(field) {
  if (field[0].value.trim().length == 0) {
      $(field).parents('div.form-group').addClass('has-error');
      field[0].placeholder = "Can't be blank"
    this.formValid = false;
    } else if ($.inArray(field[0].value, this.categoryNames) > -1) {
      field[0].placeholder = field[0].value + ' is already taken';
      field[0].value = "";
      $(field).parents('div.form-group').addClass('has-error');
      this.formValid = false;
    } else {
      $(field).parents('div.form-group').removeClass('has-error');
      this.formValid = true;
    }
};

Category.prototype.validateFieldInput = function(field) {
  if(field[0].value.trim().length == 0) {
    $(field).parents('div.form-group').addClass('has-error');
    this.formValid = this.formValid && false;
  } else {
    $(field).parents('div.form-group').removeClass('has-error');
    this.formValid = this.formValid && true;
  }
};

$(function(){
  var input = {
    newForm : $('form#new_category'),
    categoryList : $('tbody.sortable'),
    statusLink : $('td.btn-just a:nth-child(2)'),
    editForms : $('form.edit-form')
  },
  category = new Category(input);
  category.initialize();
});

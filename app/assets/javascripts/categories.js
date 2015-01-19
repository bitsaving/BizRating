function Category (input) {
  this.editForm = input.editForm;
  this.newForm = input.newForm;
  this.categoryList = input.categoryList;
}

Category.prototype.bindEvents = function() {
  var _this = this;
  $(document).on("ajax:success", 'form.delete', function() {
    $(this).parent('div.category').remove();
  });

  this.editForm.on('click', function(e) {
    $($(this).data('target')).show();
  });

  this.newForm.on('click', function(e) {
    $($(this).data('target')).show();
  });
  
  this.categoryList.sortable({
    revert: false,
    distance: 40
  });
};

$(function(){
  var input = {
    editForm : $('a.edit'),
    newForm : $('a.new'),
    categoryList : $('ul.categoryList')
  },
  category = new Category(input);
  category.bindEvents();
});

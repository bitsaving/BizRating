function Category (input) {
  this.categoryList = input.categoryList;
  this.statusLink = input.statusLink;
}

Category.prototype.initialize = function() {
  this.addStatus();
  this.bindEvents();
};

Category.prototype.addStatus = function() {
  this.statusLink.each(function(index, link) {
    link.text = ($(link).data('categoryStatus') ? 'Enable' : "Disable");
  });
};

Category.prototype.bindEvents = function() {
  this.bindSortableEvents();
  this.bindStatusEvent();
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
        success: function() { },
        error: function() {
          alert('failed to update');
        }
      });
    }
  });
};

Category.prototype.bindStatusEvent = function() {
  this.statusLink.on('click', function(e) {
    e.preventDefault();
    var linkdata = $(this).data(),
        _this = this;
  confirmText = 'Do you want to' + (linkdata['categoryStatus'] ? ' enable ' : ' disable ') + linkdata['categoryName'] + " ?";
  if (confirm(confirmText)) {
    $.ajax({
        url: "categories/update_status",
        dataType: 'json',
        type: 'patch',
        data: linkdata,
        success: function (e) {
          $(_this).data('categoryStatus', !e[0]);
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
    categoryList : $('tbody.sortable'),
    statusLink : $('td.btn-just a:nth-child(2)')
  },
  category = new Category(input);
  category.initialize();
});

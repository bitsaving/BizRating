function Category (input) {
  this.categoryList = input.categoryList;
  this.statusLink = input.statusLink;
  this.updateStatusUrl = input.updateStatusUrl;
  this.updatePositionUrl = input.updatePositionUrl;
}

Category.prototype.initialize = function() {
  $('#loader').hide();
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
  $('#edit_category').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget),
      name = button.data('name'),
      image = button.data('image'),
      id = button.data('id');
    $(this).find("input[type='text']").val(name);
    $(this).find("form").attr('action', 'categories/' + id);
    $(this).find("img").attr('src', image);
  })
};

Category.prototype.bindSortableEvents = function() {
  var _this = this;
  this.categoryList.sortable({
    revert: false,
    handle: '.sort',
    stop: function() {
      $.ajax({
        url: _this.updatePositionUrl,
        dataType: 'json',
        type: 'patch',
        data: {position : $(this).sortable("toArray")},
        beforeSend: function() {
          $('#loader').show();
        },
        complete: function(){
          $('#loader').hide();
        },
        error: function() {
          alert('failed to update');
        }
      });
    }
  });
};

Category.prototype.bindStatusEvent = function() {
  var _that = this;
  this.statusLink.on('click', function(e) {
    e.preventDefault();
    var linkdata = $(this).data(),
        _this = this;
  confirmText = 'Do you want to' + (linkdata['categoryStatus'] ? ' enable ' : ' disable ') + linkdata['categoryName'] + " ?";
  if (confirm(confirmText)) {
    $.ajax({
        url: _that.updateStatusUrl,
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
    statusLink : $('td.btn-just a:nth-child(2)'),
    updateStatusUrl : "categories/update_status",
    updatePositionUrl : "categories/update_position"
  },
  category = new Category(input);
  category.initialize();
});

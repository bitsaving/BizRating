module CategoriesHelper

  def category_add_error_class(field_name)
    @category.errors[field_name].empty? ? '' : 'has-error'
  end

end
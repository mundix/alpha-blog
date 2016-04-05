require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: "books") #no podia ser sports es por que ya estaba creado en otro integration test "create_categoiries_test.rb"
    @category2 = Category.create(name: "programming")
  end

  test "should show categories listing" do
    get categories_path
    assert_template 'categories/index'
    asert_select "a[href=?]", category_path(@category), text: @category.name
    asert_select "a[href=?]", category_path(@category2), text: @category2.name
  end

end
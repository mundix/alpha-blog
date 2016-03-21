require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
  #   wants to get new category path

    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count',1 do
      post_via_redirect categories_path, category: {name: "sports"}
    end
    assert_template 'categories/index'
    assert_match 'sports', response.body
  end

  test "invalid category submission result in failure" do

    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, category: {name: " "} # not redirecting
    end
    assert_template 'categories/new'
    # Esta parte viene de share/_errors.html.erb partial
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'

  end


end
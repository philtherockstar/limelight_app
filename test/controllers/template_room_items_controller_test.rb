require 'test_helper'

class TemplateRoomItemsControllerTest < ActionController::TestCase
  setup do
    @template_room_item = template_room_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:template_room_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create template_room_item" do
    assert_difference('TemplateRoomItem.count') do
      post :create, template_room_item: {  }
    end

    assert_redirected_to template_room_item_path(assigns(:template_room_item))
  end

  test "should show template_room_item" do
    get :show, id: @template_room_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @template_room_item
    assert_response :success
  end

  test "should update template_room_item" do
    patch :update, id: @template_room_item, template_room_item: {  }
    assert_redirected_to template_room_item_path(assigns(:template_room_item))
  end

  test "should destroy template_room_item" do
    assert_difference('TemplateRoomItem.count', -1) do
      delete :destroy, id: @template_room_item
    end

    assert_redirected_to template_room_items_path
  end
end

class TemplateRoomItemsController < ApplicationController
  before_action :set_template_room_item, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @template_room_items = TemplateRoomItem.all.order("room_id, item_id")
    respond_with(@template_room_items)
  end

  def show
    respond_with(@template_room_item)
  end

  def new
    @rooms=Room.all.order('display_order')
    @items=Item.all
    @template_room_item = TemplateRoomItem.new
    respond_with(@template_room_item)
  end

  def edit
    @rooms=Room.all.order('display_order')
    @items=Item.all
  end

  def create
    @template_room_item = TemplateRoomItem.new(template_room_item_params)
    @template_room_item.save
    respond_with(@template_room_item)
  end

  def update
    @template_room_item.update(template_room_item_params)
    respond_with(@template_room_item)
  end

  def destroy
    @template_room_item.destroy
    respond_with(@template_room_item)
  end

  private
    def set_template_room_item
      @template_room_item = TemplateRoomItem.find(params[:id])
    end

    def template_room_item_params
      params[:template_room_item].permit(:room_id,:item_id,:quantity,:id)
    end
end

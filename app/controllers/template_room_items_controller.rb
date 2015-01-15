class TemplateRoomItemsController < ApplicationController
  before_action :set_template_room_item, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @template_room_items = TemplateRoomItem.all
    respond_with(@template_room_items)
  end

  def show
    respond_with(@template_room_item)
  end

  def new
    @template_room_item = TemplateRoomItem.new
    respond_with(@template_room_item)
  end

  def edit
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
      params[:template_room_item]
    end
end

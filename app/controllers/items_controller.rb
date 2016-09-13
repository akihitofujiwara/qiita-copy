class ItemsController < ApplicationController
  include Md2html

  before_action :set_user, only: %i(show)
  before_action :set_item, only: %i(show edit update destroy)

  def new
    @item = current_user.items.build
  end

  def create
    @item = current_user.items.build item_params
    if @item.save
      redirect_to [current_user, @item], notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def update
    if @item.update item_params
      redirect_to [current_user, @item], notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to (request.referer == draft_items_path ? :back : mines_path), notice: "Item was successfully destroyed."
  end

  def md2html
    render json: {html: convert(params[:md])}
  end

  def search
    @items = Item.search(params[:q])
    @stocked_items = current_user.stocked_items.search(params[:q])
  end

  private
  def item_params
    params.require(:item).permit(:title, :body, :tag_list, :scope)
  end

  def set_user
    @user = User.find params[:user_id]
  end

  def set_item
    @item = (@user || current_user).items.find params[:id]
  end
end

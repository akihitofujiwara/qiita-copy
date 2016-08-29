class ItemsController < ApplicationController
  before_show :set_user_by_params, :set_item_by_params_from_user
  before_edit_or_update_or_destroy :set_item_by_params_from_current_user
  before_new :set_new_item_from_current_user

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
    redirect_to mines_path, notice: "Item was successfully destroyed."
  end

  private
  def item_params
    params.require(:item).permit(:title, :body, :tag_list, :scope)
  end
end

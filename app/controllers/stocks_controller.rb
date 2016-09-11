class StocksController < ApplicationController
  before_action :set_item, only: %w(create destroy)

  def create
    current_user.stock @item
    redirect_to :back
  end

  def destroy
    current_user.unstock @item
    redirect_to :back
  end

  private
  def set_item
    @item = Item.find params[:item_id]
  end
end

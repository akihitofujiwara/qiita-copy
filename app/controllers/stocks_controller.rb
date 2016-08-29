class StocksController < ApplicationController
  before_create_or_destroy :set_item_by_params

  def create
    current_user.stock @item
    redirect_to :back
  end

  def destroy
    current_user.unstock @item
    redirect_to :back
  end
end

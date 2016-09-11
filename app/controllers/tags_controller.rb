class TagsController < ApplicationController
  before_action :set_tag, only: %i(show)

  private
    def set_tag
      @tag = Tag.find params[:id]
    end
end

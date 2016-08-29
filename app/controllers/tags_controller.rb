class TagsController < ApplicationController
  before_show :set_tag_by_params
end

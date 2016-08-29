class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i(feeds items stocks mines)
  before_index_or_items :set_items
end


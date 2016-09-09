class HomeController < ApplicationController
  before_all_items :set_items
  before_action :authenticate_user!, only: %i(feeds items stocks mines)
end


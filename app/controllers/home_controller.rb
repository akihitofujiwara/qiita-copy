class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i(feeds items stocks mines)
end


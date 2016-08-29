class UsersController < ApplicationController
  before_show :set_user_by_params
end

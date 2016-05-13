class UsersController < ApplicationController

  def index
    @users = User.all
    render :index
  end

  def show
    @users = User.find_by_id([:id])
    render :show
  end
end

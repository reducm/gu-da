class BlogController < ApplicationController
  def index
    @user = User.new 
  end
end

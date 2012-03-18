class BlogController < ApplicationController
  def index
    redirect_to articles_path if session[:logined]
    @user = User.new
  end
end

class PagesController < ApplicationController
  before_filter :check_login
  before_filter :check_session
  before_filter :check_admin
  
  def create
    binding.pry
  end

  def update
  end
end

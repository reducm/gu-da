require 'jas/jlogin'
class ApplicationController < ActionController::Base
  before_filter :check_login, :only => [:update, :destroy]  

  protect_from_forgery
  include JLogin
end

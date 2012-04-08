require 'jas/jlogin'
class ApplicationController < ActionController::Base
  protect_from_forgery

  include JLogin

  before_filter :check_login, :only => [:update, :destroy, :edit]  
end

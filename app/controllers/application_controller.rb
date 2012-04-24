require 'jas/jlogin'
class ApplicationController < ActionController::Base
  protect_from_forgery

  include JLogin
end

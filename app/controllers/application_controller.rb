require 'jas/jlogin'
require 'jas/jbreadcrumbs'
class ApplicationController < ActionController::Base
  protect_from_forgery
  include JLogin
  include JBreadcrumbs
end

require_dependency 'jas/jlogin'
require_dependency 'jas/jbreadcrumbs'
class ApplicationController < ActionController::Base
  protect_from_forgery
  include JLogin
  include JBreadcrumbs
end

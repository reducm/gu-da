class SessionsController < ApplicationController
  before_filter :check_session
  before_filter :check_login
  end

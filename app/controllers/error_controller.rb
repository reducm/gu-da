#encoding: utf-8
class ErrorController < ApplicationController
  def login()
    flash[:notice] = "fucking no login error"
  end

  def nonelogin
  end

  def error
    
  end

  def nouser
    flash[:notice] = "没有用户"
  end
end

#encoding: utf-8
class ErrorController < ApplicationController
  def login()
    flash[:notice] = "fucking no login error"
  end

  def nonelogin
    respond_to do|format|
      format.html
      format.json {render json: {errors:flash[:notice]}}
    end
  end

  def error
    
  end

  def nouser
    flash[:notice] = "没有用户"
  end
end

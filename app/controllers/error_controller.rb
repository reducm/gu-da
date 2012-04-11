class ErrorController < ApplicationController
  def login()
    flash[:notice] = "fucking no login error"
  end

  def nonelogin
  end

  def error
    
  end
end

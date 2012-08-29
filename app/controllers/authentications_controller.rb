require_dependency 'jas/jshare'
class AuthenticationsController < ApplicationController
  layout 'acount_setting'
  include JShare
  before_filter :check_session
  #before_filter :check_login

  def index
    flash[:notice] = params[:message] unless params[:message].blank?
    @authentications = Authentication.get_all(@user_id)
    @authentication_hash = {}
    @authentications.each do |a|
      atr = a.attributes
      @authentication_hash[a['provider']] = atr
    end
    @authentications = nil
    @authentication_hash
  end

  def create
    renv = request.env["omniauth.auth"]
    atoken = renv["credentials"].token
    asecret = request.env["omniauth.auth"]["credentials"].secret
    binding.pry
    if @a = Authentication.find_by_user_id_and_provider(@user_id,renv.provider) 
      @a.update_from_request(renv)
    else
      @a = Authentication.create_from_request(@user_id, renv)
    end

    if session[:create_article] || session[:update_article]
      redirect_to user_article_path(@user_id, session[:create_article] || session[:update_article])
    else
      redirect_to user_authentications_path(@user_id)
    end
  end

  def share
    session[:create_article], session[:update_article] = false, false
    share_to(Article.find(params['article']),params['providers'])
  end
end

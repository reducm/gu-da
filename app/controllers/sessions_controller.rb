class SessionsController < ApplicationController
  layout 'article'
  def create
    @oauth = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)
    session[:atoken] = request.env["omniauth.auth"]["credentials"].token
    session[:asecret] = request.env["omniauth.auth"]["credentials"].secret
    @oauth.authorize_from_access(session[:atoken], session[:asecret])
    @weibo_client = Weibo::Base.new(oauth)
  end
end

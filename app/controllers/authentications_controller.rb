class AuthenticationsController < ApplicationController
  layout 'acount_setting'
  before_filter :check_session
  before_filter :check_login

  def index
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
    a = Authentication.find_by_user_id_and_provider(@user_id,renv.provider) || Authentication.create_from_request(@user_id, renv)
    binding.pry
    redirect_to user_authentications_path(@user_id)
  end
end

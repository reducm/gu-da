class DraftsController < ApplicationController
  layout false
  respond_to :json
  before_filter :check_login, only: [:create, :destroy, :update] 
  before_filter :check_session

  def index
    user_id = params[:user_id] || session[:user_id]
    @ds = Draft.where("user_id=?", user_id).all
    respond_with @ds
  end

  def destroy
    @draft = Draft.find(params[:id])
    @draft.destroy
    head :ok
  end

  def create
    params[:draft][:user_id] = session[:user_id]
    @draft = Draft.new(params[:draft])
    @draft.save
    respond_with @draft
  end

  def update
    @draft = Draft.find(params[:id])
    @draft.update_attributes(params[:draft])
    respond_with @draft
  end
end

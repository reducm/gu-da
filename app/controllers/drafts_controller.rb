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
    @draft = Draft.new(draft_params)
    @draft.save
    respond_with @draft
  end

  def update
    @draft = Draft.find(params[:id])
    @draft.update_attributes(draft_params)
    respond_with @draft
  end

  protected
  def draft_params
    params.require(:draft).permit(:content, :manual, :title, :user_id)
  end
end

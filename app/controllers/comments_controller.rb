class CommentsController < ApplicationController
  def create
    Comment.create(params[:comment])
    redirect_to :controller => 'articles', :action => 'show', :id => params[:comment][:article_id]   
  end
end
